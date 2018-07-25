Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64449C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2745820852
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 17:26:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2745820852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=real-time-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbeGYSjM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 14:39:12 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:47637 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbeGYSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 14:39:12 -0400
Received: from pc00012.rts.com ([46.237.192.139]) by mrelayeu.kundenserver.de
 (mreue103 [212.227.15.183]) with ESMTPSA (Nemesis) id
 0LrHzA-1g7aQX3joq-0133S3; Wed, 25 Jul 2018 19:26:01 +0200
From:   Dmitry Malkin <d.malkin@real-time-systems.com>
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
Organization: Real-Time Systems GmbH
To:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
Date:   Wed, 25 Jul 2018 19:26:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:WjFqAAkRElC2ViqxZ+aWlnCt1/V/i1uyqw0C11PFTwCK8x8MYAM
 RdJ0RCgMFpfjrrkATs5z7ysw2gvohep6rMIeUeLx2G3SFugJifgS405Kgs4VkIZ06nV8OMu
 ODX05isLBBbknoe4GTVFBsSdpSdqkUbBThGXPGhFrF8hEEmzIoQAxuXfA1AAaQ8aNeqssgH
 bT4C7u1kjDi04IfyFDW8A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ZS+7xzNjMqw=:4BfnJbiQvmZghW1EQPeeL6
 xmJ1dYsK5MonGYULcxSX9hJpK6Ag7I3BxR+tfsYYr7L8ho5d1xRx+Ld6+odKqRs8LEKRfhfrQ
 4gQ9J01T5/BqQZXQWZ+xr8YzOYnuvuKP5y4wEQKSUC4LzTDiTOETXTXcwhDleXXHFlHWkaLv8
 /64suo64sxH3VEkbxL3jLLKvRnf1XIBg47fzSXxzHW1ci7/POL4yW/9Pku/oudxtxfeR01EAt
 I9y7lDcgL5lEhsoTQKF4Gj7SkcsCKZd7csJfbsNCOz33DSvRoNXgHQ5mzZsY1W7CgtMi03zk+
 qMRbKMHRiwapQ3Yl+NuCtr7jbUjlM+ZV5UGunXeZIwiOm17lAIcfsxDwpRdQ59P96sVWYQ/tm
 kfPGaDYDf2JachxpMarhuE+sovBYnKiKJwAuWk/lYRvZw0eGZ3Z2vfQgVaAIG8K6nzykW/Cs+
 /FpQqegN1KTurNPm102XPFGavBayXK6eNVwnz8DdKMBjXNqQmpR+j66GSlj20RgArTbO08VC8
 dn9F0ibQMBPizLnUHrn0oXa5p1BS+GOxXdQQHjCGcwpImIS6oPHN3HyvwwbZ1D0HtosigMSoa
 9iAKNJwWeHTCP8TYyGuFHlDkbLyC+RQ2UID7sUiKHpwZKIcDWS2j0iqUSL8LsxDevM8hTwnKA
 UP+uCiPerH7dQYDMYBOnMAw9tPysw43Cw7XFab21UKLrbRnjt8LTvlxam6xRev68nmEr0PbVv
 C7+FKSw5F3R2kP7U
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there may be some other reasons which may cause undefined behavior 
(reboot for example):

in arch/x86/boot/compressed/pgtable_64.c in function paging_prepare():

1. structure "paging_config" allocated on stack without setting default 
value for flag "l5_required":
 >>struct paging_config paging_config = {};
l5_required is set only if CONFIG_X86_5LEVEL is defined

2. reading from memory which may be reserved in case of EFI systems:
 >>    ebda_start = *(unsigned short *)0x40e << 4;
 >>    bios_start = *(unsigned short *)0x413 << 10;
Also, on EFI system without CSM it will results in all zeros. Which will 
place trampoline_start to 0x9d000. And it also may be reserved memory. 
In fact I have such system and it is causes instant reboot (when code 
starts copying to "trampoline_start").

3. paging_prepare(void) returns "struct paging_config". Copy by value. 
Is it really specified by ABI or GCC itself that the second field (which 
is flag "l5_required") will go to RDX register?



