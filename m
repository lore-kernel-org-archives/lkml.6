Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23E9C43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31E321738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AaZojl24"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfAIS2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:28:08 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46160 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbfAIS2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:28:04 -0500
Received: by mail-yb1-f194.google.com with SMTP id n16so3357492ybg.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JxIjSXUMfcMOh/NKE8hkX8k17mbhEUFgFur+hJ0iY4I=;
        b=AaZojl24TyxUvoj3qk5rJ+KXI5rrkbo+R4lzjpvup5hwI4SPvsj7L5SF1ITf8RdiLS
         UCRkX7esIHh3M5xSq+3S1+YCnolVOIINbAHKv622mmFWNpB1TQS3PopOIu/LhuSBQ+QF
         EoQF9HQjnxKNyhSe6gkxb+z1dPGJx1Jml3KqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JxIjSXUMfcMOh/NKE8hkX8k17mbhEUFgFur+hJ0iY4I=;
        b=RXpI+aXfFaRH5j7aTr+22FR9P9v89xCWZJmqY/O/HSR+ym/CNvo1WGItg1l2ueip62
         TLkTFwr9dHkds8tGmc1eyr6JNlCotH7LQamx7x2K+XgSGWJb3BdWiuJaw1HhBN2ajg9M
         PmAMaGo0cvdOiU/MZMbTFOIXpYqdlEyogv+kLfTDlYVSWwYHRjqc3I/Z+7MnO1nFe6G+
         olimkjLE8qXLAjwk0JB+AyqV34aWvDcqsvcLIYWa9MXKvDvz626UerecaC3zT+hCtRs0
         fQWQi7h+3122qF8A4af2UVa8nz9vnNArPxAvsYpUsdCdHzAeKxop43qo1UtzliRWCbFS
         Llww==
X-Gm-Message-State: AJcUukd5tT99MeDA2rK/+01kHgUgT9Z4pnQaO0xNnZmHNSSPXoZKR3Wk
        55exCLl/8Jby4V+0AfwF7Fb1rw==
X-Google-Smtp-Source: ALg8bN5Wwoh9/bzU9U9aFL17dEx+mrUhv1QgcFn5B5+gwe43pk9B+zFgdGKuRgvL44IFOhcu+af9Sg==
X-Received: by 2002:a25:bac2:: with SMTP id a2mr6801058ybk.519.1547058482932;
        Wed, 09 Jan 2019 10:28:02 -0800 (PST)
Received: from [10.136.8.252] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id a72sm27998605ywh.42.2019.01.09.10.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 10:28:02 -0800 (PST)
Subject: Re: [PATCH 0/8] Add IPROC I2C slave mode and NIC I2C support
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Shreesha Rajashekar <shreesha.rajashekar@broadcom.com>,
        Michael Cheng <ccheng@broadcom.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <1546938997-13798-1-git-send-email-rayagonda.kokatanur@broadcom.com>
 <6a5380e3-1e15-31e3-bbaa-134856a0c2dc@broadcom.com>
 <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <44deeaef-a9b8-9ce1-d6b8-76d99a53cd4f@broadcom.com>
Date:   Wed, 9 Jan 2019 10:27:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAHO=5PG3NnYqoSyZ9u9kN1m7KagtKv275tpWj6s8NXvzhj52fQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay. Just noticed another thing. May I ask if you ran the
'get_maintaimner.pl' script to figure out the 'To:' and 'Cc:'?

I don't see Wolfram's name on on the To or Cc field of the emails you
send out:

Wolfram Sang <wsa@the-dreams.de>

6845 I2C SUBSYSTEM
6846 M:      Wolfram Sang <wsa@the-dreams.de>
6847 L:      linux-i2c@vger.kernel.org


Thanks,

Ray

On 1/8/2019 6:15 PM, Rayagonda Kokatanur wrote:
> Sorry for confusion. I made mistake in adding bcm-kernel-feedback-list
> while sending patch. Hence sent same patch set with updated email list. 
> 
> Best regards,
> Rayagonda
> 
> 
> 
> On Jan 8, 2019 10:55 PM, "Ray Jui" <ray.jui@broadcom.com
> <mailto:ray.jui@broadcom.com>> wrote:
> 
>     You sent out the same patch series 3 times without any explanation. Very
>     confusing.
> 
>     Is this the latest one that should be reviewed?
> 
>     Thanks,
> 
>     Ray
> 
> 
>     On 1/8/2019 1:16 AM, Rayagonda Kokatanur wrote:
>     > Hi,
>     > This patchset contains support for IPROC I2C slave and NIC I2C
>     support.
>     > Following are the brief changes done inorder to support both IPROC I2C
>     > slave mode and NIC I2C,
>     >
>     > a. Add support to allow I2C rx transfer upto 255 bytes
>     > b. Add polling mode support to the iProc I2C driver. Polling mode
>     is used
>     >    in certain SoCs where interrupt is not connected from the I2C
>     block.
>     > c. Add warpper read/write access for register to support indirect
>     register
>     >    access. This is required in certain SoCs with this iProc I2C
>     >    block registered.
>     >
>     >
>     > Ray Jui (1):
>     >   dt-bindings: i2c: iproc: make 'interrupts' optional
>     >
>     > Rayagonda Kokatanur (5):
>     >   i2c: iproc: add polling support
>     >   i2c: iproc: use wrapper for read/write access
>     >   dt-bindings: i2c: iproc: add "brcm,iproc-nic-i2c" compatible string
>     >   i2c: iproc: add NIC I2C support
>     >   arm64: dts: Stingray: Add NIC i2c device node
>     >
>     > Shreesha Rajashekar (2):
>     >   i2c: iproc: I2C read up to 255 bytes support
>     >   i2c: iproc: Add Slave mode support
>     >
>     >  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt     |  14 +-
>     >  .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  18 +
>     >  drivers/i2c/busses/Kconfig                         |   1 +
>     >  drivers/i2c/busses/i2c-bcm-iproc.c                 | 767
>     +++++++++++++++++----
>     >  4 files changed, 669 insertions(+), 131 deletions(-)
>     >
> 
> 
