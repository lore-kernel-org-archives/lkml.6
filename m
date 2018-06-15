Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EE48FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A413A208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAVg92Yq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A413A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756028AbeFOIQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:16:01 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53835 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755819AbeFOIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:15:58 -0400
Received: by mail-wm0-f67.google.com with SMTP id x6-v6so2112156wmc.3;
        Fri, 15 Jun 2018 01:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vXDO+ySUROgoAJpFoMVL6sZVzd79uv2B1Oh0umIU2es=;
        b=iAVg92Yqn4Vzl0sEzLykSlW7U6v3o9YEH66yfiLwWWV5xkflMKAWua4q7vJDj5OWR3
         MGDAXjlc+bgLA6VZ2j7ifaMoKf+e5TgxHwaG4PHrLjTgblhCZGYpF+xnP7hX7yXFD7e4
         4HVJ/PSly/RobV0YVsvtH4pIb6jYG/jjhLODo/Y10EdX943dEMgHRXNsh0E9PCfQEyVe
         PfYh/2yfX5/h+4J8DdHmXHQLqusBF5RMsr6ncbxFUFNIXYcsT5uPlT7KrbYZXEfycLh0
         8zbhnv23Tuac3DQm1BNHi41xkO4Ryspu+AV3QHpFmJX31yvRGzFrbBJRnzLTzr7SLcDO
         ePiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vXDO+ySUROgoAJpFoMVL6sZVzd79uv2B1Oh0umIU2es=;
        b=I9SgUso02zcyqwvzX0cif/Mt8e8kMplgAX4nOMDWBKrk7JNBCTGyh9bEBsGD4kLz/0
         kvSCzcbpks+ZE6uzDpJJI6TSKSkpygIEdWOgskPPa8VsnIKGNd9cEvUpWZ8UHR5iA1VR
         hMvX2oUcptWi/Hd66FRYQqYDXONmfnW3CuD3ttFfFe9zeIe6zd9itLzhv+p/ym4FNE79
         p9jwu2o2BF5rHSGPDBRtLdlksTTUlgIW0/MY7KM2r1gxsPJ8QETRcdP5QcKKzEfnZ/9r
         VGLv0ECQB39Vk3v9uyo4NYFXqkjCiBXE+bG8pEr3VRToajA84YbWgSWNSPg9/VBYqgl+
         ARzg==
X-Gm-Message-State: APt69E0ONM0pi5dzlau1AkCuQ90CAiilkf/zEHHQEC4hetRTR4qXi75X
        L6Ms3jTyHqiWmn6XfL89Km8=
X-Google-Smtp-Source: ADUXVKKcZuh6SmEnL3sx6L4xNFdNlhxrfMjFwxsNhsrAuNnHU+Nff8Or2jCes9sNzp+GAvYCjGj6wg==
X-Received: by 2002:a1c:dac2:: with SMTP id r185-v6mr415321wmg.31.1529050557236;
        Fri, 15 Jun 2018 01:15:57 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id a203-v6sm1357743wme.46.2018.06.15.01.15.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 01:15:56 -0700 (PDT)
Date:   Fri, 15 Jun 2018 10:15:54 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] crypto: sun4i-ss: prevent deadlock on emulated hardware
Message-ID: <20180615081554.GA3047@Red>
References: <20180614193659.29261-1-clabbe.montjoie@gmail.com>
 <20180615075754.b3ivyagjsomiafwk@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615075754.b3ivyagjsomiafwk@flea>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 09:57:54AM +0200, Maxime Ripard wrote:
> On Thu, Jun 14, 2018 at 09:36:59PM +0200, Corentin Labbe wrote:
> > Running a qemu emulated cubieboard with sun4i-ss driver enabled led to a never
> > ending boot.
> > This is due to sun4i-ss deadlocked and taking all cpu in an infinite loop.
> > Since the crypto hardware is not implemented, all registers are read as 0.
> > So sun4i-ss will never progress in any operations. (TX_CNT being always 0)
> > 
> > The first idea is to add a "TX_CNT always zero timeout" but this made cipher/hash loops
> > more complex and prevent a case that never happen on real hardware.
> > 
> > The best way to fix is to check at probe time if we run on a virtual
> > machine with hardware emulated but non-implemented and prevent
> > sun4i-ss to be loaded in that case.
> > Letting sun4i-ss to load is useless anyway since all crypto algorithm will be
> > disabled since they will fail crypto selftests.
> > 
> > Tested-on: qemu-cubieboard
> > Tested-on: cubieboard2
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  drivers/crypto/sunxi-ss/sun4i-ss-core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/crypto/sunxi-ss/sun4i-ss-core.c b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > index a81d89b3b7d8..a178e80adcf3 100644
> > --- a/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > +++ b/drivers/crypto/sunxi-ss/sun4i-ss-core.c
> > @@ -341,9 +341,18 @@ static int sun4i_ss_probe(struct platform_device *pdev)
> >  	 * I expect to be a sort of Security System Revision number.
> >  	 * Since the A80 seems to have an other version of SS
> >  	 * this info could be useful
> > +	 * Detect virtual machine with non-implemented hardware
> > +	 * (qemu-cubieboard) by checking the register value after a write to it.
> > +	 * On non-implemented hardware, all registers are read as 0.
> > +	 * On real hardware we should have a value > 0.
> >  	 */
> >  	writel(SS_ENABLED, ss->base + SS_CTL);
> >  	v = readl(ss->base + SS_CTL);
> > +	if (!v) {
> > +		dev_err(&pdev->dev, "Qemu with non-implemented SS detected.\n");
> > +		err = -ENODEV;
> > +		goto error_rst;
> > +	}
> 
> This is wrong way to tackle the issue. There's multiple reason why
> this could happen (for example the device not being clocked, or
> maintained in reset). There's nothing specific about qemu here, and
> the fundamental issue isn't that the device isn't functional in qemu,
> it's that qemu lies about which hardware it can emulate in the DT it
> passes to the kernel.
> 
> There's no way this can scale, alone from the fact that qemu should
> patch the DT according to what it can do. Not trying to chase after
> each and every device that is broken in qemu.
> 
> NAK.
> 

My fix detect also when the device is badly clocked.
So since it could fix problem unrelated to qemu, I will send a V2 with updated comment.

Regards
