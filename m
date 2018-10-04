Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167A8C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D220D2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 13:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIvIY9hl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D220D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbeJDUow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 16:44:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34475 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727628AbeJDUov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 16:44:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id f8-v6so8465468ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVfjx/J81Asw8N+3qCIoCNsFmK4yPA5krqUhqaSEz24=;
        b=CIvIY9hlO6VBkbfcmsN+cNJv/KAnUA/JxZ/53VCQPDxn7n18ZJaX+iLAg+aL94tZ55
         ZVp+dXJbMBgZ88RbeHXLbVvix9Sf0rEUJnI8UXMSXLuKDsiv3FfxLnTrwhGUzk6K83ex
         IX1qx6wDjH1lYlqp116BBaePtqpQR/6zaNocAOCI8gbRwaA9PPBq6PJXtoGyXyoWZgGb
         wbGyy8rNgO1vUzqEl0SoSsz8ish0NAaIb5mMPsjhwQ8k62bt8FnUEAoFCuQyoWpC2SY+
         9Iga2IFr7DMYIbgDUT9/BR9YaLlDz9/aa1HLiSxi39S9EKecHVYva/QONK5G4tipiYRR
         wT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVfjx/J81Asw8N+3qCIoCNsFmK4yPA5krqUhqaSEz24=;
        b=eBnP8ERGfi7cEzhyfzwCShxqol6HGF7z8gzO28IWZNCchGADHCk4r52EQIMbhAjT2e
         ZvPq3YyKrPlXfF83yYf6IozDDvq6AbAZUuFXahLl5OT1AxUkvhCkyOeENpMqusbG83Rj
         BaQwB3pdvMDE2nStyU6V1mE1Ta+mjYuWaJllgSlmF3bs/Ayz8CjxrW8kRn7kBuOM7PVB
         10BdHUZc20NSNzrf8V8rVI1tilxEuicI+vdFrZdUGcBz5gWmT9iyLnzReyWeNRdLzCw4
         +mN6c8aDe/G0G9LXI4j9o10sGifADpdW2AtugNRLk2NnN0/gcoAf89e/ZWAJQbXgbira
         /neA==
X-Gm-Message-State: ABuFfog4jcDNO1q1HtYUfdinMVtANAQyhTGrQs6xoT8E2psPZE2mG+O6
        GZUJJ77TztFQ/DRLHwfWwP8=
X-Google-Smtp-Source: ACcGV61paGLXHOltImhbsumXYoCIkVbeU6syiASQ8TgmKJYcpnuz4sIh0Sg5PRNWEqJ0BabyET4E4Q==
X-Received: by 2002:a2e:3006:: with SMTP id w6-v6mr1607051ljw.146.1538661086253;
        Thu, 04 Oct 2018 06:51:26 -0700 (PDT)
Received: from z50.localnet (78-10-164-223.static.ip.netia.com.pl. [78.10.164.223])
        by smtp.gmail.com with ESMTPSA id k9-v6sm172612lje.51.2018.10.04.06.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 06:51:25 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [RFC PATCH] mtd: rawnand: ams-delta: use ->exec_op()
Date:   Thu, 04 Oct 2018 15:52:57 +0200
Message-ID: <7546835.d2Xs8Qh0bZ@z50>
In-Reply-To: <20181003160634.147dd95c@bbrezillon>
References: <20180719081508.5dafebde@bbrezillon> <4278198.vlhjLe5TOR@z50> <20181003160634.147dd95c@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On Wednesday, October 3, 2018 4:06:34 PM CEST Boris Brezillon wrote:
> On Wed, 03 Oct 2018 15:55:25 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
>   
> > > > 
> > > > Implementation of NAND_OP_WAITRDY_INSTR has been based on legacy
> > > > nand_wait_ready(),  
> > > 
> > > I don't remember what the ams-delta ->dev_ready()/->waitfunc() hooks
> > > are doing, but is shouldn't be too hard to replace them by an
> > > ams_delta_wait_ready() func.  
> > 
> > Default nand_wait() is used as ->waitfunc(), and ->dev_ready() returns R/B 
> > GPIO pin status.
> 
> Okay. Then it might make sense to provide a generic helper to poll a
> gpio.
> 
> void nand_gpio_waitrdy(struct nand_chip *chip, struct gpio_desc *gpiod)
> {
> 	...
> }

How about a still more generic helper which accepts dev_ready() callback as an 
argument?

Thanks,
Janusz


