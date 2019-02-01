Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571F7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A0A20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sy6Ysniv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfBAFCT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:02:19 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35593 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725681AbfBAFCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:02:19 -0500
Received: by mail-yb1-f194.google.com with SMTP id 64so2206210ybs.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 21:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qUhTbPCsO1jrFKUgbQA//w6RlZBwF6axtVnQtjKwisM=;
        b=Sy6YsnivoVLUgmSIDfL05vlpLRjFDqu0KUUW74NmN1b0LqGyZkDBgB00wbNidysx5Z
         X1mBxS+RlEc6y46irnWFfGP9anFvIMkbAcvRqRa5URRjTbZ5PxNIDoCz3nES2lMY+DUX
         a5kS53DNWA9p+mrjB6zg6N2Fz0wgIW3OThrTGs4RK63c+gKUDXjR1bDdG25E3R+WiRHu
         WquitCrKJYEGKdYQHsMXBBKtaFz82i8xdJiHcOWM2PvJ6vVgIyzVkJHj9spyVy5Q1CYs
         AyRQ5cBFg6eZ190WuIs3Pv9iuRUXZcbdn7RBro8LQlBJ+G9ZnXGt0FlfAmYFQPLQIomk
         m+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qUhTbPCsO1jrFKUgbQA//w6RlZBwF6axtVnQtjKwisM=;
        b=Ahp9aZCGl4QLwLUPBkKKVuu9QhKLeJl0+omLA0nWsCxvbztnmdry1XRy33XMYJNdpy
         qEJRIS842FQSHwL8B6Qc6L5jhpatGN4VqTYBY7hGB9Y8uMnqzLmxtD4VVGR3IqV2c8Bm
         nWgmtu1NCg7dBreWPjg/2w194sbJrerXFslLmOYZgD36GcH+T+SL02rScUK1u5tOoDZ1
         m9EePsANyKS9P62rDAKivvE0XXFwEayo3p48pCqzzPK0vDESjg3ZC3G+uQ+un6NFvtih
         Bn0OdsASlCvOIS7IfPjP858NHdnh2O0BC+4pSjoPfpiKmpOun/GW0dBHnoovBN4D/j/F
         KZEA==
X-Gm-Message-State: AJcUukc81v4tYCp2GL1KidHD8FhBWoaAmq3OxEGZ3qRnLSjchVVt31Mb
        xmi0MThe13RxPFXwzszsGyg=
X-Google-Smtp-Source: ALg8bN5D3/yWqi9E8DgxniNMauXZlaQbVZ66beY+qgL+S/Q2XJ/FAovYMIvFLLEdRSB9QVJbMmj9sw==
X-Received: by 2002:a5b:903:: with SMTP id a3mr35898645ybq.184.1548997337774;
        Thu, 31 Jan 2019 21:02:17 -0800 (PST)
Received: from [10.10.116.34] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id d85sm2448336ywd.22.2019.01.31.21.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 21:02:16 -0800 (PST)
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2019-01-29
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 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
 w0j9Sw==
Message-ID: <10832eda-69a1-1c47-3fe6-7e8da02884d6@gmail.com>
Date:   Thu, 31 Jan 2019 21:02:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <92b0b6d9-ced1-4a0a-e0d5-d72751dacfcb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/19 8:10 PM, Florian Fainelli wrote:
> 
> 
> On 1/29/19 10:53 AM, Stefan Wahren wrote:
>> Hi Florian,
>>
>> sorry for being that late and hoping it's not too late.
>>
>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>>
>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/anholt/linux tags/bcm2835-dt-next-2019-01-29
>>
>> for you to fetch changes up to 14117e0af4a853b2b37925f526b2bfe1cfc7b285:
>>
>>   ARM: dts: bcm2835-rpi-zero-w: Drop unnecessary pinctrl (2019-01-22 07:25:59 +0100)
>>
>> ----------------------------------------------------------------
>> This pull request adds the necessary changes for the new BCM2835 PM driver,
>> support for the new Raspberry Pi 3 A+ and the missing GPIO labels for RPi 2/3.
>> Additionally it contains some minor DT fixes.
>>
>> ----------------------------------------------------------------
> 
> Merged into devicetree/next, thanks Stefan!

And backed out, integration failed with the following results:

[X] aiaiai build results:
Tested the patch(es) on top of the following commits:
bfeffd155283 Linux 5.0-rc1
85e1ffbd42f6 Merge tag 'kbuild-v4.21-3' of
git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
ac5eed2b4177 Merge branch 'perf-urgent-for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
574823bfab82 Change mincore() to count "mapped" pages rather than
"cached" pages

--------------------------------------------------------------------------------
Failed to build : 22065550c391 ARM: dts: bcm2835-rpi-zero-w: Drop
unnecessary pinctrl
Configuration: "multi_v7_defconfig, architecture arm".


In file included from arch/arm/boot/dts/bcm2835.dtsi:2:0,
                 from arch/arm/boot/dts/bcm2835-rpi-a.dts:3:
arch/arm/boot/dts/bcm283x.dtsi:6:10: fatal error:
dt-bindings/soc/bcm2835-pm.h: No such file or directory
 #include <dt-bindings/soc/bcm2835-pm.h>
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [arch/arm/boot/dts/bcm2835-rpi-a.dtb] Error 1

--------------------------------------------------------------------------------
Failed to build : 22065550c391 ARM: dts: bcm2835-rpi-zero-w: Drop
unnecessary pinctrl
Configuration: "bcm2835_defconfig, architecture arm".

It looks like commit "ARM: bcm283x: Switch V3D over to using the PM
driver instead of firmware." is failing here and we should also have
"soc: bcm: bcm2835-pm: Add support for power domains under a new
binding." present as a preriquisite to build this branch.

Alternatively, if you prefer to put "ARM: bcm283x: Switch V3D over to
using the PM driver instead of firmware." in your drivers pull request,
that might work too.

I have kept pull request 2 and 3 applied for now, let me know how you
want to proceed.
-- 
Florian
