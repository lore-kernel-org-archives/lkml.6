Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1000208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:21:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1000208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934207AbeGJPVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:21:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42912 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934064AbeGJPVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:21:16 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12-v6so16853904edi.9;
        Tue, 10 Jul 2018 08:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1LJGSbj2ooyQ1WtB9mH5wRIpOilNIUeuXgS/T9B+5vI=;
        b=O/eAs6rBPfsd9+Fn7hEIh1GfCa1Hn7tGgy89UZeXkYgl3oSQpf3ZMlSALJUSEtf/EO
         c5huF6QNG2jl6+jPiryZrAC9ItrBpeSU4mXAaMbDMpFfXeWzTu9WzFgq+UCjaznCJujz
         pf+BP46FErBS+iCoBJ2HK5GRIYxu4uvIGbQcv6Y6bUX0NC3T4TkGCacAXFQOKnr1nXXD
         zPMlfMzRfPmn9WjkH4FAMuZXBsSbxG22fOi9p7iBMdipGYgKE7zjD47dXk4ad5X3kBTB
         JMGoDAa0wS62dVMpC7Bg78q813JSBt9b+0A2UZ728X58rjzbuMQnSs5tPqk9gI8jvq6f
         isQA==
X-Gm-Message-State: APt69E1iaErf3bkX8GoIdiA+HZjg53Rhj+IyzVSDdcYKlDhL89dSXuGV
        PMriKEmPoVKXNgHkEKXzf+f9p4sf
X-Google-Smtp-Source: AAOMgpcPqyDSNetOkePWda0qvxJIUnk7tfJ0yecJzlr8xy+R1tmf9tfsawBPub67gZAGl/McMm/wUw==
X-Received: by 2002:a50:c28a:: with SMTP id o10-v6mr27828804edf.296.1531236075352;
        Tue, 10 Jul 2018 08:21:15 -0700 (PDT)
Received: from mail-wm0-f54.google.com (mail-wm0-f54.google.com. [74.125.82.54])
        by smtp.gmail.com with ESMTPSA id g9-v6sm6397312edq.34.2018.07.10.08.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:21:14 -0700 (PDT)
Received: by mail-wm0-f54.google.com with SMTP id v25-v6so25098720wmc.0;
        Tue, 10 Jul 2018 08:21:14 -0700 (PDT)
X-Received: by 2002:a1c:7c0c:: with SMTP id x12-v6mr15665403wmc.58.1531236074006;
 Tue, 10 Jul 2018 08:21:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 08:20:53
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-3-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-3-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 23:20:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v65E=U5nQ=b-yDKKwwt16ra2z9rwNJt_hmQtpLcN6ONLTQ@mail.gmail.com>
Message-ID: <CAGb2v65E=U5nQ=b-yDKKwwt16ra2z9rwNJt_hmQtpLcN6ONLTQ@mail.gmail.com>
Subject: Re: [PATCH 02/17] drm/sun4i: Add R40 display engine compatible
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

On Sat, Jul 7, 2018 at 1:50 AM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> R40 has versatile display pipeline. It supports two simultanious outputs
> on various outputs (TVE, VGA, HDMI, MIPI DSI, LCD).
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
