Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAC1C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B525D2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 09:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="xM8fL24m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B525D2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbeKOThl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 14:37:41 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35160 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387548AbeKOThl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 14:37:41 -0500
Received: by mail-wm1-f67.google.com with SMTP id t15-v6so17332269wmt.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 01:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uNm7UG+p0cFTwhhywuPjSiHbxGrq0ABTHOWshR9EV/A=;
        b=xM8fL24mbu8ShG59YrloBNmRt+vznWfrG838jmPFzsWP0hhsmG22dcUez88i+EdhLY
         07DQ+/S/nh/efYc1uiLipUoAfHUAHk/Q62zYklE5V09p/Lw97KccOPflASARTZZrg5pz
         Cdeppy/EkxMME/46hJ3i/dITcE7VgTnZogTvNuwCwni49Lo9PyBXqKMk0TCSsVbKmozZ
         hH9sVdmJmOsgHfJMAfuhVWBURCloyyFMHn+nTrl66jDciWz06P39yg3jyx1TSo9ZCKNY
         ncaaJFKj2lA7v2eVQ22jiMM29tW5aETJ4T/vdU+PW447I6RBIUSjjw2acill89qtlNTX
         5bfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uNm7UG+p0cFTwhhywuPjSiHbxGrq0ABTHOWshR9EV/A=;
        b=M1IE+f7Au+cYzFABhoaztOiw+WYy92pPzHf13NGReEryREfeB1qjO/DHFKkKWIPH1l
         qCQn1LDRFbHNCYbX9lRvEjXIzwUjeMMnckZKGZYDastLqmTFpkvu7d4ItnTAThgN7kJi
         K7uCZT4WslW8iCsLgrtSpaNNqe33hH4RtiR+jz8232fGhzWI+u3IDF+FXMa5quO/U/1i
         GQ7p2i45Db9w5JrEaO3K4tZ/r6gLv7t7pi4tadzM6hvw5wpafO+rf9X1mYiU+rIJjo7g
         sRN+PIfpLS7866hPCzBL4GqS7uFEtKLWP9QK4RvNkdTBTOHpkryioaur/46FU7F4vbph
         sB2A==
X-Gm-Message-State: AGRZ1gIAf/J/esG7JSuGRJSggBd2cdzgL69FbWK8ASjqh61+UAV2nerq
        KxkwdrqCKITqdjKW6l05Ambhhg==
X-Google-Smtp-Source: AJdET5cnrvLUvsGLwqpKv6hpw+aiGJuSE24NGSxBtuQkp9Lzqm640R9T3+AI0eIZkQlnMNJZ0D3L3A==
X-Received: by 2002:a1c:7c0b:: with SMTP id x11mr754185wmc.20.1542274238235;
        Thu, 15 Nov 2018 01:30:38 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id f12-v6sm12950033wru.63.2018.11.15.01.30.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 01:30:37 -0800 (PST)
Date:   Thu, 15 Nov 2018 10:30:34 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Gilles.Muller@lip6.fr, Julia.Lawall@lip6.fr, agust@denx.de,
        airlied@linux.ie, alexandre.torgue@st.com, alistair@popple.id.au,
        benh@kernel.crashing.org, carlo@caione.org, davem@davemloft.net,
        galak@kernel.crashing.org, joabreu@synopsys.com,
        khilman@baylibre.com, matthias.bgg@gmail.com,
        maxime.ripard@bootlin.com, michal.lkml@markovi.net,
        mpe@ellerman.id.au, mporter@kernel.crashing.org,
        narmstrong@baylibre.com, nicolas.palix@imag.fr, oss@buserror.net,
        paulus@samba.org, peppe.cavallaro@st.com, tj@kernel.org,
        vitb@kernel.crashing.org, wens@csie.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-ide@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        cocci@systeme.lip6.fr, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181115093034.GB23965@Red>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024085700.GR30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > This patchset adds a new set of functions which are open-coded in lot of
> > place.
> > Basicly the pattern is always the same, "read, modify a bit, write"
> > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> 
> The advantage of them being open-coded is that it's _obvious_ to the
> reviewer that there is a read-modify-write going on which, in a multi-
> threaded environment, may need some locking (so it should trigger a
> review of the locking around that code.)
> 
> With it hidden inside a helper which has no locking itself, it becomes
> much easier to pass over in review, which means that races are much
> more likely to go unspotted - and that is bad news.
> 

Hello

I understand your fear, but I think the benefit overhaul thoses.
Furthermore, drivers which I have converted does not need such locking.

If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.

Regards
