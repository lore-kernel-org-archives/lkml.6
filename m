Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D4EECDFBD
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94C6C20854
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 04:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4+qz4OH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="gN+tPAVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94C6C20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeGSF0E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 01:26:04 -0400
Received: from mail-qt0-f178.google.com ([209.85.216.178]:43109 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeGSF0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 01:26:04 -0400
Received: by mail-qt0-f178.google.com with SMTP id f18-v6so6122770qtp.10;
        Wed, 18 Jul 2018 21:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9yJ90df+TTX5CIQM4J0A/Pw6UXBr664OOZqD/pXQ2u4=;
        b=m4+qz4OHpKagewffyRc/YAaRdMg1uOUANi+vQIh4FrnYyGX/96DGcEuhCCUviqqg2o
         fSGce523iUBlLZL8l+qo1JjhwOx/a1eINJqFUw2osnkaZ9Zvs3I6nYrVE7kY9/+tFhpH
         uePAlPh88ftrPNkOXm6Ha1m5Z4Y6Mq+Heo2cM+yApSd8YjyjnxHMymX9D2xwfAHQ8WK/
         j1dbUb6ji+PvKFjIMPd6x81crok073rzZUNMkZ8h70HTdyRFOcoSA2ikxaQt+oi4dfXt
         gHB9BFMAlAhSGBFx23LWu2dClO3NTYP1m7kXLusn2aii2Wkzryprn6/13MtXqXTBpTke
         AtFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=9yJ90df+TTX5CIQM4J0A/Pw6UXBr664OOZqD/pXQ2u4=;
        b=gN+tPAVQcRGRNnNSX17FlubhUJumosZm1HVJc63mgh3KfDaYRpXDRPfbkUnQ+1nKMD
         b+f+6ZAS3rlpFZ6KpL6MWxFOCgQ0Z4zKhnlJcdR0pAepN3Z16jiO0zhFUFp3pugEK8zF
         j53ezni0lCZDwomMH0H0M3XfMneq7c1E6z6do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=9yJ90df+TTX5CIQM4J0A/Pw6UXBr664OOZqD/pXQ2u4=;
        b=C6LJSMtx1LZWq7eaiCVvQxRHV0OnKSJGjGG0A8MPnRAfFSATaC5bOqmUQ50hgyRGqf
         Kr7j5zikhojrSeAN2tlMHMzJPZRE54m/Z0UEOJvyYW01xdrem7OuDHkFLQs98rtysy9z
         iPcWbF8V5/TSod8vLJ1USCSra3bPCev4ijEgazL7O/YhsH6YSU+pSSwshPKWQOjedJ04
         8iTQymtWy7mH4KRFGBsFysrTcHhhX6LPQdPP5UdDePqkuXsZzJBtPQbkmWZP5FK7kx1z
         2sXMEAuPr2nF9/kd6mAgKv2unJ6o6yTobxoEfcpClpAisCUehE0TrTkqzQe2Lk7ImTYj
         jO4A==
X-Gm-Message-State: AOUpUlH04ZR4HPcc9bgYOoMtpvm4aNAnbCRNTfKr80chUDX5KfSMrpsp
        CXUmUvImEl9d/GmFRW09qWjqe0IPSj4aEqAhDhg=
X-Google-Smtp-Source: AAOMgpc1BAr2h0bSI+dbHAJXXTa5mI+gGai9LshHzfwV+4GfzzOf3ny+S3GvtJId/luiiIVDc4ClaRCTLsb18AyeElE=
X-Received: by 2002:a0c:a281:: with SMTP id g1-v6mr9364624qva.60.1531975493054;
 Wed, 18 Jul 2018 21:44:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:169d:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 21:44:32
 -0700 (PDT)
In-Reply-To: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
References: <1531841466-9833-1-git-send-email-eajames@linux.vnet.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 19 Jul 2018 14:14:32 +0930
X-Google-Sender-Auth: SXG1cd0PjixoiuSsuUuYbjb1pco
Message-ID: <CACPK8XdJtshKP8GR4YHVNtt8PY2f_ky0VurZYPXJbdtmwxLxNw@mail.gmail.com>
Subject: Re: [PATCH v12 0/8] i2c: Add FSI-attached I2C master algorithm
To:     Eddie James <eajames@linux.vnet.ibm.com>
Cc:     linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 July 2018 at 01:00, Eddie James <eajames@linux.vnet.ibm.com> wrote:
> This series adds an algorithm for an I2C master physically located on an FSI
> slave device. The I2C master has multiple ports, each of which may be connected
> to an I2C slave. Access to the I2C master registers is achieved over FSI bus.
>
> Due to the multi-port nature of the I2C master, the driver instantiates a new
> I2C adapter for each port connected to a slave. The connected ports should be
> defined in the device tree under the I2C master device.

I gave this a run on a Romulus P9 system, and dumped the SBE using it.
All seemed well.

Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel
