Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A29CAC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5405124869
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 02:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5405124869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753043AbeF1CJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 22:09:17 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38541 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbeF1CJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 22:09:15 -0400
Received: by mail-ed1-f66.google.com with SMTP id a5-v6so4186780edt.5;
        Wed, 27 Jun 2018 19:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=edDzqeyPUksW+xM5NGS9wvWeTaaMpw47a0H05FeWUyw=;
        b=fiy2K0NnbZx92GOx5RUMuI1ZaVGtm5KBOqicsohZedfapVxCgjf2ZbV2BYQZoFL4aq
         dxf7qCRSlEDlzYebXGX4/+j4aQX2UO0AIxzINtrPbeJ3toybzPvcVyC+d8773LxMJcum
         VIaDnnY7nunBPRTkQMDdkkFSECsX/w9PEZHpcADYmi1brVzxDcsedoCJ+xgMzfYWF9HM
         s3WhpSboF0Eio9NEtDVAXwJz0kYQiSkoZ5BK5iWbQvmPeWeovejpEDkMcsiKoA96CP33
         9jbZGVc6lkK1vMvFjjzHTGPiQ9NQdmt4CCILOcTqaXJIFr8IlY4kpVlF+opZJYY/+Nux
         iINA==
X-Gm-Message-State: APt69E0kfZPCQIAIVC5w3xkTUuTZ3W2Ou2Wb4nPj4yAZzXQgoT6HIJ8a
        k9yJILXuN6e9DHSu9GeYGcWNKBNv
X-Google-Smtp-Source: AAOMgpehUG9tip4ynYsTDvmz2txp+I0K5teJQFz8BP27jlTnX0c1PS9eVAOQEce9qcxd8wa1bW7+0w==
X-Received: by 2002:aa7:c396:: with SMTP id k22-v6mr7645030edq.149.1530151753823;
        Wed, 27 Jun 2018 19:09:13 -0700 (PDT)
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com. [74.125.82.41])
        by smtp.gmail.com with ESMTPSA id j24-v6sm212719edr.90.2018.06.27.19.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 19:09:12 -0700 (PDT)
Received: by mail-wm0-f41.google.com with SMTP id z13-v6so7312271wma.5;
        Wed, 27 Jun 2018 19:09:12 -0700 (PDT)
X-Received: by 2002:a1c:1bc5:: with SMTP id b188-v6mr670172wmb.143.1530151752358;
 Wed, 27 Jun 2018 19:09:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 19:08:51
 -0700 (PDT)
In-Reply-To: <20180625120304.7543-12-jernej.skrabec@siol.net>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-12-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 28 Jun 2018 10:08:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v64VJ2Mxq7jS=rtUNFwE6BccdDcHPN7MvG0dLHnKoMNJow@mail.gmail.com>
Message-ID: <CAGb2v64VJ2Mxq7jS=rtUNFwE6BccdDcHPN7MvG0dLHnKoMNJow@mail.gmail.com>
Subject: Re: [PATCH v3 11/24] drm/sun4i: Don't check for LVDS and RGB when
 TCON has only ch1
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> wrote:
> LVDS and RGB interfaces are always connected to TCONs which have channel
> 0. It doesn't make sense to try to init them on TV TCONs.
>
> Add a check if TCON has channel 0 before trying to init LVDS or RGB
> interface.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Though I think at some point we could just have separate functions
to handle channel 0 and channel 1.

ChenYu
