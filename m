Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD32C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828562073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="xpfIJvB1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828562073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbeIFC36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:29:58 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46529 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbeIFC35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:29:57 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so7525151ljj.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OVVNnHzewIHfcfDovqBjdmGc4nqgMW6z7CFEk3SaGXw=;
        b=xpfIJvB1J+VyNXl7dnEM9oARfCh3uOdqFCzOVPme2AWVLZBC4bHlkalwwyL0RINlWb
         WzR1pFzHXe7WHpdCIgIU2/PrtkBAsy0O/UX1rAPIDml0NTsVFdbgzY3Sqyrbhbv0GbsV
         T5sXto8tSbxVUjvOmuykBOZdiLCMmmR46tyAr8iaqMPg15/CjkR4dA9P6wAt1IxsqLFl
         O0ahS1PQmv1Tm87u5P0aELxchK3krso3rx37UbaD12+QNowgCPNmkE04S3AU3Q5n2w5Z
         y7ynnI0i6tsm4kBIjVH2VqbjIDCmQK5Esm8gUmoqBtk2inf5V7J4KXOVokjkoRZk4G2C
         mWNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OVVNnHzewIHfcfDovqBjdmGc4nqgMW6z7CFEk3SaGXw=;
        b=e7WFGMPNH4/VyvG8tc/uUUSnOVYMjIaHteQ+BPpl+p027qiuPs26yXQEi4NDG87/sX
         shGHCKTkqSVY3NCqc0Mj5jCTaYjciOnWzMOQPEBUOUmzfETBRIz+QZPMWJj8TLkLV6u7
         H8Pbz9Ky+dt0ryGxQbdbKCO7ypkAP4uMr31rpeBlOeb7j7/NrZm6JQJH/8DHZP+6y2Mr
         UU+cdcRpcwywn8BnlVsNArC161B01hMueFY0xJsFOjMcAntucLnQ8Df+Ww9YOl3Amz65
         njhNVZN1ns3JukOcqsfobuOdS0iNLY21743tKT7f6Zw9cF4rDcufAGcsivyvGp/5r5Ho
         DBjg==
X-Gm-Message-State: APzg51BAxxzd3GM4AEeu2x2uuasJEpzwWfuygocPV6eL5nDSEMap1MMe
        YSWbldQmL/S8D+BETFpMOANr1etjLw3UBX2iAgYjYg==
X-Google-Smtp-Source: ANB0VdZRd3bLhTxzKRO6hORPGfXD9SVMJmnyPQRTBpegp31YtJ9DEIFLnvEzNqC4bmc1KD3FYErE6MHKlTebGM2ez8o=
X-Received: by 2002:a2e:8188:: with SMTP id e8-v6mr24271487ljg.138.1536184667102;
 Wed, 05 Sep 2018 14:57:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:d984:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 14:57:46 -0700 (PDT)
X-Originating-IP: [2620:10d:c090:200::5:31c9]
In-Reply-To: <20180905190750.4566-1-grant.likely@arm.com>
References: <20180905190750.4566-1-grant.likely@arm.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 5 Sep 2018 14:57:46 -0700
Message-ID: <CAOesGMjzEKsa1rx-kHemcSyT2PudLeCd7OrogrVdn99efTXg8g@mail.gmail.com>
Subject: Re: [PATCH] efi_stub: update documentation on dtb= parameter
To:     Grant Likely <grant.likely@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:07 PM, Grant Likely <grant.likely@arm.com> wrote:
> The dtb= parameter is no longer the primary mechanism for providing a
> devicetree to the kernel. Now either firmware or the boot selector (ex.
> Grub) should provide the devicetree and dtb= should only be used for
> debug or when using firmware that doesn't understand DT.
> Update the EFI stub documentation to reflect the current usage.
>
> Signed-off-by: Grant Likely <grant.likely@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Jonathan Corbet <corbet@lwn.net>

Acked-by: Olof Johansson <olof@lixom.net>


-Olof
