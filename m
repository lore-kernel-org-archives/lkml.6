Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49D7C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A50F208EB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 16:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A50F208EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934512AbeGJQKN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 12:10:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42261 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934491AbeGJQKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 12:10:10 -0400
Received: by mail-ed1-f66.google.com with SMTP id g12-v6so16969926edi.9;
        Tue, 10 Jul 2018 09:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VU+Gt5JFFoLcSSu4/hDeAaoG/rSveKmSAU/Z4RK+QTY=;
        b=NSaliWUhWfj1CUvARhyvlXlVeao6hRXarX3Wnwwt9xWz5gCxGt51si2iT9PvkZS4/5
         5leSovcT/KlKC/6F0BbnEUjkhob1xuzKKlF/ArD2Mqvcqr1m6AO6l2QeyiW2BIwVCRCM
         vLA/6BnmvIApl/zUFLBoAXzjxYe7FpRhOltZhmU7jg/ZOD7lLoIfiwbxLe1Q2cFZ7g0e
         c7Uxj/L51h7VLyXr5vb33RQR4WXmswyrP+vBPLB6xn2wH3oQskMn4ReuphsLuqxa4Qz2
         cGu25TPLQH1LbzdWp52MFcJeLVIPLd5P7xwQZYrJqckjluVedeAhZ2fLz0f/XbN7G+bz
         YLww==
X-Gm-Message-State: APt69E1+TyntxQwhHpzk6JhSQFlFAz2z+CB5p/bGS5FpKo78Dlv4qeud
        4bUFxQylY6810Q6nJX6QKeC9dT9z
X-Google-Smtp-Source: AAOMgpfZ3zBTaIYFgeBYze6yhSZT9Y0od1qw1Su8haF5+2L6Z5ouuydP2zhB+rg5S7gR7+WNbTBRAQ==
X-Received: by 2002:a50:e0c9:: with SMTP id j9-v6mr28134674edl.198.1531239009153;
        Tue, 10 Jul 2018 09:10:09 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id v8-v6sm8667736edr.48.2018.07.10.09.10.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 09:10:08 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id p1-v6so15211061wrs.9;
        Tue, 10 Jul 2018 09:10:08 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr17697836wra.19.1531239007903;
 Tue, 10 Jul 2018 09:10:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 09:09:47
 -0700 (PDT)
In-Reply-To: <20180706175113.26698-18-jernej.skrabec@siol.net>
References: <20180706175113.26698-1-jernej.skrabec@siol.net> <20180706175113.26698-18-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 11 Jul 2018 00:09:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v65x3CBw009gFTH-DmAFjfX_xSbSzOXLWbkyJU1PQ1yD+g@mail.gmail.com>
Message-ID: <CAGb2v65x3CBw009gFTH-DmAFjfX_xSbSzOXLWbkyJU1PQ1yD+g@mail.gmail.com>
Subject: Re: [PATCH 17/17] dt-bindings: display: sun4i-drm: Fix order of DW
 HDMI PHY compatibles
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
> They are currently sorted alphabetically. However, they should be sorted
> by release date of the family and then alphabetically.
>
> Fixes: 03c35dbf73e0 ("dt-bindings: display: sun4i-drm: Add description of A64 HDMI PHY")
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
