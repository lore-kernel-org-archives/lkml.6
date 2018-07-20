Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AC7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2460F206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIOtAs2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2460F206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeGTTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 15:00:50 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34597 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388180AbeGTTAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 15:00:50 -0400
Received: by mail-lf1-f66.google.com with SMTP id n96-v6so2385405lfi.1;
        Fri, 20 Jul 2018 11:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ss7aZ3CMIPwJqH0yomHHNKktQe1KwIatu0svinrzdaE=;
        b=TIOtAs2Z4Kf+IkASxAiR71Fw5DW3ufFGTy1ajBCQWND+Rsod7RarkukZ4P6Q+F2qeU
         8i68EJsn7YF1VAoXVIzFh6AyS3RCBpqpGabWoReBVqQRsQTkXxoFAcrZeggjOu2+T0eJ
         eWkSKN9FZG/APrzvzSUdrAtOoNoHkIFRuHYTl/GgTKa3tijZS0kHMlKv6RaTs8QySHWM
         PhfFEy3J6Z2PdcnMOkhq2zN4wCf90asG2QWRUn1TymcVSek519bbrztj1qY6sLti/yE/
         axzIUG8+xXCvrHYQ//ki0ZKprxw3PFU14qQJ4nanGzYYBMb20AJ0tczSwAM8DqJQt5Jb
         Xkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ss7aZ3CMIPwJqH0yomHHNKktQe1KwIatu0svinrzdaE=;
        b=t7Hq/sU4cUwFBr4nNcJ3N+WB+h756jxkckiTGw1TMjCVlJ6ntymAyA2a3EFGn5Uzcx
         7exrADTzEG9wk/aB/Ta609VnqVeNSU+Ut4bUmlbvtBCtENFH0jttEMQ002wZiRYIudlE
         sxsxpzXi22aoqri4IZflfmLdLjADiAGVF29qPIPSe/mOxRwnZwuDT++nGiedwWRTnpDr
         Jrz21fJzQBl48P/NfN+qTo27XFsBnxi0WVmAI076oqoO1HuLsTakKjaXH5zuE83Ro3Dv
         n3ETsAMUnBLqGY5B6XHjnS6R8Vv62k1B/VtBSa9Hwu1qluLZzFBLWvcM/bm1byl9K3Uy
         xydw==
X-Gm-Message-State: AOUpUlHzQDFlydgtp3SpIg7d+AFI22nPxnDSJQ3hLE/t3HbG7pXGaWue
        zMiOLubMUYXpfJGFrhfa6c0=
X-Google-Smtp-Source: AAOMgpe0R1yFCqjlWArYnvHJA/bQThWKahKOznUf9sUloR/fZ6M5TI32s9uor75dCGLVLMd9O0q+dQ==
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr1942029lfg.14.1532110282920;
        Fri, 20 Jul 2018 11:11:22 -0700 (PDT)
Received: from z50.localnet ([31.0.82.186])
        by smtp.gmail.com with ESMTPSA id l141-v6sm383286lfg.55.2018.07.20.11.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 11:11:22 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Subject: Re: [RFC PATCH 3/8] mtd: rawnand: ams-delta: Set port direction once per transfer
Date:   Fri, 20 Jul 2018 20:12:05 +0200
Message-ID: <90128326.sKM4evrj8F@z50>
In-Reply-To: <20180719082318.290abee1@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com> <20180718235710.18242-4-jmkrzyszt@gmail.com> <20180719082318.290abee1@bbrezillon>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 19, 2018 8:23:18 AM CEST Boris Brezillon wrote:
> On Thu, 19 Jul 2018 01:57:05 +0200
> Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:
> 
> > In its current shape, the driver sets data port direction before each
> > byte read/write operation, even during multi-byte transfers.  Optimize
> > that by setting the port direction only on first byte of each transfer.
> 
> Sounds like premature optimization for something you'll rework when
> fully switching to the GPIO consumer API to control the DATA bus.

Indeed, this optimization was crucial for getting acceptable performance of 
data transfers over GPIO.  I'm only not sure if there is any action in 
response to your comment expected on my side, e.g., did you want to say I 
should modify the patch description, or change the order of patches?

Thanks,
Janusz



