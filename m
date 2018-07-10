Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DA4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4866120989
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4866120989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934285AbeGJPbd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:31:33 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:33969 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754260AbeGJPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:31:31 -0400
Received: by mail-ed1-f42.google.com with SMTP id d3-v6so16911670edi.1;
        Tue, 10 Jul 2018 08:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QaDPaNX0K1DBVtm1SxL8OcsS6A9OQy9y0W3joTM8Mbc=;
        b=QSS88uPNUKsCU7gLCQqc7mYwwG8EYvcKf6QU0fYPDI3usODddky23pYYrqczzKXZoc
         MUdG5VKFfuv+gG8o2Qi93BjLAa9VQ522QgdhBW6+KlWtWRK3UXXv/w9FBUXpz7LLwNxc
         5aSYWVLJf2Y77hg29owtY3SdvgSBhT/DHtesuAReanXGO9sK+24b8Mo40Ne0gRfS6ksq
         RQX7wmaJZssCXhIFG/ukbAybhZzlfnmzkqElcQQgS6RVuvTxnCVpr5wHo7Ty0sEDKC4o
         aqKPnH8HLb6dIEAbfdUxja9NV99H7uqkLssBxsFAVupvMMYu0GA/bSp+HgKairAMkQYc
         +/rw==
X-Gm-Message-State: APt69E1m2//V9FHOWeFQF/yC0e7TMFCuX5OIe0GixUQNur0ePC6QYkro
        0RvOGaUWunM6JRkdipOjvA/fWoAI
X-Google-Smtp-Source: AAOMgpfbSzTGtq0/WPydjzXJwvHNgKCtqcM/GNgk82bLVf18De8e91TkrhBRc3aM24HwEbdcEnCKVg==
X-Received: by 2002:a50:d2d7:: with SMTP id q23-v6mr27941851edg.183.1531236690015;
        Tue, 10 Jul 2018 08:31:30 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com. [74.125.82.54])
        by smtp.gmail.com with ESMTPSA id y99-v6sm8232405ede.18.2018.07.10.08.31.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:31:29 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id v3-v6so21229741wmh.0;
        Tue, 10 Jul 2018 08:31:29 -0700 (PDT)
X-Received: by 2002:a1c:6fdd:: with SMTP id c90-v6mr14753597wmi.16.1531236688949;
 Tue, 10 Jul 2018 08:31:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:31:08
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-8-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-8-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:31:08 +0800
X-Gmail-Original-Message-ID: <CAGb2v65q5OkVnnjufc1kHP=sc+6Kw5EHGmNDwuguTnrgPgxJbw@mail.gmail.com>
Message-ID: <CAGb2v65q5OkVnnjufc1kHP=sc+6Kw5EHGmNDwuguTnrgPgxJbw@mail.gmail.com>
Subject: Re: [PATCH 07/17] drm/sun4i: DW HDMI: Release nodes if error happens
 during CRTC search
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 7, 2018 at 1:51 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> If error happens in sun8i_dw_hdmi_find_possible_crtcs(), nodes are not
> released with of_node_put() before returning.
>
> Fix that by calling of_node_put() when necessary. While on it, clean up
> the code by using of_graph_get_remote_node() which also lowers number of
> cases where error handling has to be performed.

Good job!

> Fixes: 57e23de02f48 ("drm/sun4i: DW HDMI: Expand algorithm for possible crtcs")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
