Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C26C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E842F2087F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j2FHupLD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E842F2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbeIKVmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:42:31 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:37667 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbeIKVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:42:30 -0400
Received: by mail-it0-f65.google.com with SMTP id h20-v6so2381640itf.2;
        Tue, 11 Sep 2018 09:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6vX4UW7RaK/6b9Bmv6ojKyw7WtIAXIJrAaOPuMQcqT0=;
        b=j2FHupLD+T3g4+OtBqVggJRsEkZoBMx8a9N/jfdoDMCmJzEk/oPa4mIQjP2fwbFhF9
         K9JlEfPe50Hi5nyW/mXX5JB4AlPvWMHVnNscgRXSjoguT7FqHsNItZi5S4dYrBwAQd0e
         BrTwnXqa5YRFftHAu2KS/czvErDJ1r2aLTE5aGrSerVAhCWOSCsoWk7kPCTjebOJRMoj
         kxCD+6u28bRJIZj6oDSiA4a06yPE+pEaOm/2Ln2+/AW5Gu24kZ8GK436c7XEMfSSxvdg
         3OQstCn66lGK4VMo9ryGVeXBbnwBbHmhu06jlxM4T9L6YpZCRsPEfAeMm+yjWhufPKo+
         bLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vX4UW7RaK/6b9Bmv6ojKyw7WtIAXIJrAaOPuMQcqT0=;
        b=HkM4bQDfyoojoX72xdkkm75nx92BsxYhIXr3Sp+HmbI20i+xaalE8qV80Uz+qBvYT5
         WOIjJcer4bzo5zjh/mbIr91MdSCRuWrKZFGkgSNRGxJ2KU9Ki1OwV5hRGBbCrwdrPcbd
         +gFIGWIV5hhNyVUT1XGvzuIrCbcbf/3uC8A+adRhcSgLU47nTnMIlIxINksM9JItM5x6
         vyvFUbTi+6kup54waTkYMgigevhfIiR1n+1MwwtXgnd3GvHV0mP45RXilwhIKkVQ5pL/
         P35SHfTw6TCCE2etUp0GuvXv6Ea3mvW4TiKaMMLGHGBQY43A2Fs16kNqegblejSGdeGg
         ydFQ==
X-Gm-Message-State: APzg51DnHOuuOgZ3ISwqvCeOLeakEN+8rK7h/2ZpiTX9GFcagUcm4MYt
        p5WGxLL9opljES0qZkcd8v7wOSGfG85JLotpOZNw9hHa
X-Google-Smtp-Source: ANB0VdbQ5BsfuRLiJB7MPvmfqwtiXnG3PRgvA7ZdOLKrBDthjFWZZu3GRVlyRcs1k+RRXBKCzGPfj0e8Ncl21ZHf0ZA=
X-Received: by 2002:a24:7bd4:: with SMTP id q203-v6mr2311550itc.123.1536684142640;
 Tue, 11 Sep 2018 09:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180911161527.GA30689@vnote> <20180911162741.GC3902@linux-r8p5>
In-Reply-To: <20180911162741.GC3902@linux-r8p5>
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
Date:   Tue, 11 Sep 2018 19:42:11 +0300
Message-ID: <CAJC2YLatWGvWv3abt7jQSk06rOQKTtkH4RxyPda6-usztFzwBg@mail.gmail.com>
Subject: Re: [PATCH v2] efi: take size of partition entry from GPT header
To:     dave@stgolabs.net
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >The GPT with entries sized more than sizeof(gpt_entry) is not illegal.
> >OVMF firmware from EDK2 perfectly works with it, see edk2-tianocore source
> >code.

> But _why_ is this needed? Does this firmware need larger sized entries (ie: does
> not work without it)?

A disk with correct large-sized GPT entries can be created. UEFI
firmwares will work with it, Linux kernel will not. Is it necessary to
perform such synthetic test or this issue does not matter anyway?

--
Eugene
