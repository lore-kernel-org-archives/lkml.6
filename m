Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545FDC282D7
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B2C20857
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 00:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uZ9ax9hP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfAaAqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 19:46:12 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37549 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfAaAqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 19:46:11 -0500
Received: by mail-qk1-f193.google.com with SMTP id g125so951760qke.4;
        Wed, 30 Jan 2019 16:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:cc:subject:in-reply-to:references
         :mime-version:content-disposition:content-transfer-encoding;
        bh=XcdSi3Ih+roxXYRHFPAfDLi6o9yJrw0mTUThqSLwojQ=;
        b=uZ9ax9hP8TxvF6Rtz1MBqIp0HV/lx336g0JCnxfX5lI2obe2mZGzoP6UYYNdfLYbG3
         0WoIpRNuAk9JtfzPgDcGMpiKbQMttDrzEkbdMKf7Onfs8SKUHYSArp1asPbRpc2YGQT2
         i0swOApxgxtzfsYJQkl2dItxVvt1b1kmVN8QFveNVKSNB6hEeM5bArz76E7Tqglh2YQk
         8qx/isee40WF2tUnaDRzJF2GmjmpvvEjZpBQr1piLz/nu3Ov9vAJwl8CyBDaQl++nT0N
         KnajmbfPZscMqmKSna8LEYMtm32avJVrTKiOg3B2bDdHC36v8lYnaWkOSsehJaQNYJ8y
         DN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:cc:subject:in-reply-to
         :references:mime-version:content-disposition
         :content-transfer-encoding;
        bh=XcdSi3Ih+roxXYRHFPAfDLi6o9yJrw0mTUThqSLwojQ=;
        b=F5VDmr5BNitG2vyE2yMy3A1G4ryZcFpmrSMfLEbwBp6vy31vJ40K2R0Z7K2BoD7gAr
         MXPqMHtkcXOfFH+RbugwpZ9xZlAtycvi3WtxMvM2BysMpc+yTaRi3DUIMZGYejTIfrqz
         jFkPYGRq0RM9YkxEsNfH2IB1Qwy5fEODO3S6l6wQ3Yf/bnPPE5QwLvpApluLPzrsPl8h
         S5l6xJU2Bjimk6yTpNzg7+U2EIsYsnSpGzCTvgqM3gmY20W7oSSoHXDVdacp0QyhHfga
         8vXd1BKULtWaRJiPdPrQj/M3AX2ho8GgzMugs8R58BBu5R2S4uJcYdvfU3CnFd6VGzml
         F+rA==
X-Gm-Message-State: AJcUukczzrRN30tZryj/PWcKVeYWqefvLP3Z5vdyBa5/z7Lefi5Zi7Fj
        6LTkEgetfjZOGmLB/ExG2Vk=
X-Google-Smtp-Source: ALg8bN4nFUg782OQUvyKXEi8iLg3tQ5cdA5WTTcQBP+t1BJGzjNcNzbZdY6AGwuwesFZvVzKifGXZQ==
X-Received: by 2002:a37:7d05:: with SMTP id y5mr28154393qkc.310.1548895570441;
        Wed, 30 Jan 2019 16:46:10 -0800 (PST)
Received: from localhost (modemcable249.105-163-184.mc.videotron.ca. [184.163.105.249])
        by smtp.gmail.com with ESMTPSA id r1sm2644978qte.28.2019.01.30.16.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 16:46:09 -0800 (PST)
Date:   Wed, 30 Jan 2019 19:46:08 -0500
Message-ID: <20190130194608.GB28098@t480s.localdomain>
From:   Vivien Didelot <vivien.didelot@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>
Subject: Re: [PATCH net-next v2 1/2] net: dsa: mv88e6xxx: Save switch rules
In-Reply-To: <20190130104606.31639abb@xps13>
References: <20190125095507.29334-1-miquel.raynal@bootlin.com>
 <20190125095507.29334-2-miquel.raynal@bootlin.com>
 <c1421a5d-5f92-bb86-b5cc-9fa19a1c8d9f@gmail.com>
 <20190128152456.212ae5ac@xps13> <20190128144417.GG4765@lunn.ch>
 <20190128165749.6abf2dc4@xps13> <20190128174246.GD28759@lunn.ch>
 <20190129100117.5ef6774c@xps13> <20190129145157.GK4765@lunn.ch>
 <20190129104613.GC20920@t480s.localdomain> <20190130104606.31639abb@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On Wed, 30 Jan 2019 10:46:06 +0100, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> > > > Today, there is no S2RAM support for switches. First, I proposed to add
> > > > suspend/resume callbacks to the mv88e6xxx driver - just enough to avoid
> > > > crashing the kernel.  
> > > 
> > > Then i would suggest the mv88e6xxx refuses the suspend. Actually that
> > > probably is the first correct step. We don't have suspend support, so
> > > stop the suspend happening, so preventing the kernel crash.  

Actually can you show me the crash that is happening?
