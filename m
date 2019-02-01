Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B622C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C73F20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 21:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj50bgXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfBAVL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 16:11:26 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:33659 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAVL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 16:11:26 -0500
Received: by mail-yw1-f68.google.com with SMTP id p17so611397ywg.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 13:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MBoLb1lcaRx4oJB9bJ7XpWZqJmiOQken3tNfniafJCw=;
        b=bj50bgXOWbY06q0UOa432ByIyLgKTxwJAKKkpNd7y62hgPMKfDZYeq+1ZTPRVtpe4Y
         IKKbtx4infcJAZbDzskHakjRKcvDX6lyZIf31u69tHsU9um70lUJ3RJdfJppaYTM5wzo
         V9SwcrWgM1EvVlRyscmimJ8wi37oGsvEUSEYdIa1eHI9QXoH3EQeZVs8iVipJ38DZIpe
         s8SDF1Cpirk3X6YcIoNVMFj/LkCbE8YnVVGyQfw4CRzilSfhjFpjjQW7gfqk9ENNLoKg
         TSHGTk4qFEiyMpcaab6MwXzlqsbSOcd3Bk8NfaAY28LV6Qf5deGvDs17+756Go3bgCXS
         y/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MBoLb1lcaRx4oJB9bJ7XpWZqJmiOQken3tNfniafJCw=;
        b=l/Sn7tHGIWM883NmbNpW3Id8WO69+qhqb6CMptIDYpJAE0gVC2j8fmzGTPiPFReQto
         ez6HSJkh9V5wp2VlvsVXNIZ+ZbnnruTS/l+A1GLvBnfUqW3koWKSyBTuluu+hie/TaUQ
         iYPFlLd7i+DKrKDfrqOkeLrxbgtYa04uD6Ek8HgzbDYO5CqRC7yUIXr7TOA/6mN70pQp
         c3pzJWbN6r/wiEf4XODGP2SIlEXBSGhyAh6Oyv8xyjRTh92nDd/PD6K7R/EXFzirGN6t
         t/1ggJfYxTsJURrBuc4d2NjhLqQpfny8WahUpN7aLQqwhGJ/ITfvX4bTTzyfmiP2aXcE
         Bfog==
X-Gm-Message-State: AJcUukcHIGvR6MpETazpu1INTTntiNXXYvh4HmkKwBPc7T/tCMbzVW6d
        YG4qM1BVgAf/grJvxaoE9q49mKOK
X-Google-Smtp-Source: ALg8bN6x5lTFRUF4xotcSQMLVqtkyu9nV4tQpTlizJG0zJdxwmR2aWijZxoUu8vAMYzrhWhSXo1IkQ==
X-Received: by 2002:a0d:cc51:: with SMTP id o78mr39622903ywd.33.1549055484728;
        Fri, 01 Feb 2019 13:11:24 -0800 (PST)
Received: from [10.67.48.225] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id u4sm5640911ywu.92.2019.02.01.13.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 13:11:23 -0800 (PST)
Subject: Re: [GIT PULL 2/3] bcm2835-dt-64-next-2019-01-29
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1548788008-4733-1-git-send-email-stefan.wahren@i2se.com>
 <1548788008-4733-2-git-send-email-stefan.wahren@i2se.com>
 <e9a43bc2-32cd-84d8-afbd-a9c8780d8f50@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 M5kY0ACeNhCZJvZ5g4C2Lc9fcTHu8jxmEkI=
Message-ID: <b2a421d6-151a-c2d4-08b4-41ac7753b2a8@gmail.com>
Date:   Fri, 1 Feb 2019 13:11:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e9a43bc2-32cd-84d8-afbd-a9c8780d8f50@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
>> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
>>
>>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
>>
>> are available in the git repository at:
>>
>>   git://github.com/anholt/linux tags/bcm2835-dt-64-next-2019-01-29
>>
>> for you to fetch changes up to 3688325a4acac981e95e25478d3703e3ab05d4c9:
>>
>>   arm64: dts: broadcom: Add reference to RPi 3 A+ (2019-01-09 19:24:04 +0100)
>>
>> ----------------------------------------------------------------
>> This pull request brings in the arm64 reference for Raspberry Pi 3 A+.
>>
>> ----------------------------------------------------------------
> 
> Merged into devicetree-arm64/next, thanks Stefan!
This failed to build as well:

[X] Building with aiaiai-test-patchset -j 17 --bisectability --sparse
--smatch --cppcheck --coccinelle --checkpatch --targets "all dtbs
dtbs_install" -M "INSTALL_DTBS_PATH="$PWD/dtbs_install"" -c v5.0-rc1
/home/fainelli/dev/linux multi_v7_defconfig,arm,arm-linux-
bcm2835_defconfig,arm,arm-linux- defconfig,arm64,aarch64-linux-  <
devicetree-arm64.patch
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

Successfully built configuration "multi_v7_defconfig,arm,arm-linux-", no
issues.

--------------------------------------------------------------------------------

Successfully built configuration "bcm2835_defconfig,arm,arm-linux-", no
issues.

--------------------------------------------------------------------------------
Failed to build : ed20bfd45a31 arm64: dts: broadcom: Add reference to
RPi 3 A+
Configuration: "defconfig, architecture arm64".


arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dts:2:10: fatal error:
arm/bcm2837-rpi-3-a-plus.dts: No such file or directory
 #include "arm/bcm2837-rpi-3-a-plus.dts"
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[3]: *** [arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-a-plus.dtb] Error 1

--------------------------------------------------------------------------------

-- 
Florian
