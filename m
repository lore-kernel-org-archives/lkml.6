Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C05C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558832081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 03:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="KOA+xIQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558832081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeK2OFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 09:05:05 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42534 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2OFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 09:05:05 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so264139pfr.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 19:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=PmvdE8m0FvNlBUvqM3GJLcyCwV+VfWmHN81+mwJltJw=;
        b=KOA+xIQeYzAv5zIJYODzTUR3bwhJapiqnGtfCXltOtg6XfAPa7Y5HG+mGcA96dFxoD
         Y/W0tryalnTxqYMsqxop5zfP5HdxpRwqcp/XlPO93zJwNDkfMyzlJOIIOvU1doWmcUAL
         dEIhIh2VqqfJf8IZCoqm4MOQBOusaIQli2PsZMz6oQwyG9DQ+XWcSf5I9G51ROvgXT2H
         jq4B8UXHgYCPd5wN60dlHlk/7VDHeg90aigzHTrvi+0q5r0DjHprYug1/UlnTzHxEbBm
         yjY7/SrwSkCCkqTWW44/wYebOMfSUU1ghymDSWw/P4M4XwuP6bV2rmhVQpGqPN+putAs
         Tiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=PmvdE8m0FvNlBUvqM3GJLcyCwV+VfWmHN81+mwJltJw=;
        b=uBie6mnAPga5ceQFrgaMJpae6XJLjzsigJbESXqXnc/zGyPf3wyd5kFkQRf0oy5s41
         f5YRUtHqfCLFlhMJDiVMT3N/kNxSrmQlFPAPAURNhZ8hNRrPDUATdo/dk8lxfduqdHxL
         xv+BUu8Xv4Hmi/oz4qXxkK9MLZlSN1TLPZu/L63kMADt+2MXNFWOcOLTFbE2YY42RzJ8
         0x7N5koqcNFGinY+q5iixznXakbeLZASXDrOxCULxONgsLR+hJTgeWUvgufol7+Sdz2R
         DUPZI47WQIE135H+iiBDjs4Ww6oCUs9EUFA11Jr3Bx6yMV8HCUVh3g/TYRwwZlTjxLFt
         t+hw==
X-Gm-Message-State: AA+aEWalHpwKK/Tg1zgLbY70dTOf/TGwvcfkQ4uIMyVmSc73hOZuJzpz
        RNerEdPBPaZkDnQXCl26uxgGiQ==
X-Google-Smtp-Source: AFSGD/XKYZGZGchLFEQcCG8Qocxjt0XWI1aYh4irlCZ/O2Pw5hkI84KC9/rZZdBkrFFxq97Vswt6WA==
X-Received: by 2002:a62:69c4:: with SMTP id e187mr33591672pfc.50.1543460475482;
        Wed, 28 Nov 2018 19:01:15 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id b7sm467198pfa.52.2018.11.28.19.01.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 19:01:14 -0800 (PST)
Date:   Wed, 28 Nov 2018 19:01:14 -0800 (PST)
X-Google-Original-Date: Wed, 28 Nov 2018 19:01:10 PST (-0800)
Subject:     Re: macb: probe of 10090000.ethernet failed with error -110
In-Reply-To: <20181129022858.GG5037@lunn.ch>
CC:     f.fainelli@gmail.com, sergei.shtylyov@cogentembedded.com,
        atish.patra@wdc.com, schwab@suse.de, nicolas.ferre@microchip.com,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, hkallweit1@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     andrew@lunn.ch, Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-0f0b5208-8aac-4563-a2c0-921a0f5d9084@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2018 18:28:58 PST (-0800), andrew@lunn.ch wrote:
>> This is all fine as long as Linux doesn't go and reset the phy again. Until
>> bafbdd527d56 ("phylib: Add device reset GPIO support") was the case.  After
>> that commit I believe phylib is resetting the phy while attempting to enter
>> unmanaged mode, which is now allowed in this particular chip.
>>
>> Since it appears the phy is not usually described by the device tree but is
>> instead discovered by probing a MII-based ID register, it seems the best
>> place to put this is within the phy driver itself.  I find it's usually best
>> to describe things with code, so I hacked up something like
>
> Talking to Florian, i was under the impression that you could not even
> discover the device when its reset state what wrong. You could not
> read the ID registers.
>
> Your suggested change assumed you can discover the device. Is this
> true?

Sorry, I can't tell that from reading the code.  Since our bootloader resets 
the phy into unmanaged mode I think that just deasserting reset should be OK, 
but I don't have much confidence in that -- once I run into one unexpected 
feature I start to expect more :)

It looks like there's already an expectation that at least the phy ID registers 
can be read between falling and rising edges of a reset, as that's how the 
fixups are handled.  Since the error message that shows up with a single 
(single as far as Linux is concerned, triple since a cold boot) reset rising 
edge still lists the phy by name I think that probing is working well enough, 
but I wouldn't be surprised if there's something in the middle that's gone 
wrong.  It's possible registering a fixup that does the double reset can get us 
through the probing sequence.

Maybe Atish or Paul can help out?  I'm a bit embarrassed to admit that I can't 
actually figure out how to boot the board any more, it's been a year since it's 
been my primary target and since I just to arch/riscv stuff now I rely them to 
test on the board...
