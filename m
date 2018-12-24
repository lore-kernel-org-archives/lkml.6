Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB42C64E75
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B04F21773
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb4HTdN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLXXBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:01:07 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44247 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXXBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:01:06 -0500
Received: by mail-pl1-f194.google.com with SMTP id e11so5970256plt.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AjwGFShSmwBpgIsOulFohDAx7qV0Yc6oE6h/b9t4lYk=;
        b=sb4HTdN+DV7UssoM/+FO57CZpJd6CpmMuyiAPaN8YsOe/9JS3/Sm1d7iHYkGiq34KB
         /hXPgzChzIJGkFYfg8/NkyUJcIo70w6+iwegWvcwRif1OSASh/r/UOdOmfOIHYEpDqYA
         Dz1TbbjBe61UVnGvXwsvTAKpxqrMWsg2j47bsvgNHsmRIvEmRRAdJ9439aaPFadoPcWp
         LhfynR7JoQa5E5fmFbl0lH5eSe6lOns8bA8l8X9N4Fq0wL/CTZRsqEYdgTQYrh5Tk9DN
         ItjWsj81zzW+veV2BKOH7mRxSKW1WR58iY6Y/y+h0/irrVWbaF/ZyAVvpBb/N1Ts5rfv
         ycIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AjwGFShSmwBpgIsOulFohDAx7qV0Yc6oE6h/b9t4lYk=;
        b=te+X4JzJHUPlCGTwB1luWchy6UbJg2SrUVa8AlanvlzC0tEWMZxSh80fzt+u6FADEm
         PcDrbp38QCzhegIK6xkd9pTooA7UeS2lNbY25wiMe32XuXv3EGPfXFHcnRHHmJpymkeL
         tL2bUN/Pfy4+k1RiFBpW2xHbmG8DnLqUjChlq47Cddy800mMomohBD2M9ETqx+t7h6bW
         z0drn7jxS7zi2bSR+wf52f2ei11/6Bk6B8i8MzjFYIXb5epvS8iraSfW9YMSq1OjJKIQ
         wUhmeiVrQJ7yV1B/ISX8ckrBtR+/dd+ZolAzafzdk1JCHvfHFK+TY+J1EIy0V8a9RsDD
         PEzA==
X-Gm-Message-State: AJcUuke2npWuMt6KpCq1JJ41eX5jgD8FjOp2jUzfgwYkD0ohsMZNFSkr
        YhVgmzNGPyEVlg+CL9FnpW0=
X-Google-Smtp-Source: ALg8bN4D8wkbZO6IqISKHaFTw/SGCW3O4bnM1ZnK85jWzwYwR+s03IIX3gmCQBVcOm9GxEfmf/rQvQ==
X-Received: by 2002:a17:902:280b:: with SMTP id e11mr14531659plb.269.1545692465940;
        Mon, 24 Dec 2018 15:01:05 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v12sm47051806pgg.41.2018.12.24.15.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Dec 2018 15:01:04 -0800 (PST)
Subject: Re: [GIT PULL] x86/amd-nb changes for v4.21
To:     Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20181224225004.GA96500@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0308c977-2105-5d33-adb9-9e1f00b2a1e0@roeck-us.net>
Date:   Mon, 24 Dec 2018 15:01:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181224225004.GA96500@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/24/18 2:50 PM, Ingo Molnar wrote:
> Linus,
> 
> Please pull the latest x86-amd-nb-for-linus git tree from:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-amd-nb-for-linus
> 
>     # HEAD: 210ba1201ff950b3d05bfd8fa5d47540cea393c0 hwmon/k10temp: Add support for AMD family 17h, model 30h CPUs
> 
> Update DF/SMN access and k10temp for AMD F17h M30h, by Brian Woods:
> 
>    "Updates the data fabric/system management network code needed to get
>     k10temp working for M30h.  Since there are now processors which have
>     multiple roots per DF/SMN interface, there needs to some logic which
>     skips N-1 root complexes per DF/SMN interface.  This is because the root
>     complexes per interface are redundant (as far as DF/SMN goes).  These
>     changes shouldn't effect past processors and, for F17h M0Xh, the
>     mappings stay the same."
> 
> The hwmon changes were seen and acked by hwmon maintainer Guenter Roeck.
> 
>    out-of-topic modifications in x86-amd-nb-for-linus:
>    -----------------------------------------------------
>    drivers/hwmon/k10temp.c            # 210ba1201ff9: hwmon/k10temp: Add support f
>                                     # dedf7dce4cec: hwmon/k10temp, x86/amd_nb: C

This will likely result in a minor conflict against the changes coming in
from the hwmon tree (overlapping PCI IDs). Resolution is to accept both changes.

Guenter

>    include/linux/pci_ids.h            # be3518a16ef2: x86/amd_nb: Add PCI device I
>                                     # dedf7dce4cec: hwmon/k10temp, x86/amd_nb: C
> 
>   Thanks,
> 
> 	Ingo
> 
> ------------------>
> Woods, Brian (4):
>        hwmon/k10temp, x86/amd_nb: Consolidate shared device IDs
>        x86/amd_nb: Add support for newer PCI topologies
>        x86/amd_nb: Add PCI device IDs for family 17h, model 30h
>        hwmon/k10temp: Add support for AMD family 17h, model 30h CPUs
> 
> 
>   arch/x86/kernel/amd_nb.c | 53 ++++++++++++++++++++++++++++++++++++++++--------
>   drivers/hwmon/k10temp.c  | 10 ++-------
>   include/linux/pci_ids.h  |  3 +++
>   3 files changed, 50 insertions(+), 16 deletions(-)
> 

