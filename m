Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BFAC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64C9620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:21:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C9620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=real-time-systems.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732056AbeGZRjP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:39:15 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:52695 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730781AbeGZRjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:39:15 -0400
Received: from pc00012.rts.com ([46.237.192.139]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id
 0MeXgF-1fLp4T2oRT-00QG6v; Thu, 26 Jul 2018 18:21:10 +0200
Subject: Re: 4.17.x won't boot due to "x86/boot/compressed/64: Handle 5-level
 paging boot if kernel is above 4G"
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     linux-x86_64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
References: <f1fb3e5e-f18a-9f89-84c5-1dc73e08ceef@real-time-systems.com>
 <20180725212122.f2m3cfiqb4az3cb7@black.fi.intel.com>
 <a3e428be-0875-3b64-7680-252cd61b52c9@real-time-systems.com>
 <20180726145008.ccmeklqx4ofb4456@black.fi.intel.com>
From:   Dmitry Malkin <d.malkin@real-time-systems.com>
Organization: Real-Time Systems GmbH
Message-ID: <9e22ee9b-0ada-9863-32aa-db3cacd25862@real-time-systems.com>
Date:   Thu, 26 Jul 2018 18:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180726145008.ccmeklqx4ofb4456@black.fi.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:b5Mf2l12nBV0vEggjJakZnj30IjIs9X+k7hoYJUoOpu7a8Adczb
 9p7Jaj/WguNgog9lLx1oDX3u+BUZGl4K8Z4K8zWjk80Mq7b0qZMXftfNexXKOFHY6n4yWRu
 qkPD3nfa0U0ZJYS8jjmp38t/iASzB+HR4XYU91t99iUJknZ8kgzLMM7PRMGkbzuE6JKA35p
 2Ha8IOseWSRVzH/jkG0CQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9oeNbVPGt6A=:8mRe96L/VZFqr98tv9jAaU
 TkYfQw6E+gXEJP9Alo3Uy5YNkE5RHnwRSpJG6jAj3vYj0yAvvtRQtezMGp/Y5Ez2EeKHYR6Eo
 abUNE4JdEUBykLat3JaMtch4nxQEzhngwBgaVotuwQwhj8fx99YeYmUaoftAQEe1RlrVhA71I
 7Nrqh9KDAfuOkHbldX0UGULuMZrEz1fZQWp9FFZk27qBcm7KMa1wU9NTrunqCJXMru+ho+0CS
 JFKOuDXVhO2fTw3AXX4d6mLE2gQw1hhkjlsVG9qIJeY0WKYD4411cPIBVdnMkJJxTIReH4l56
 VS7dc6omwl+rBcwYe4eYGp9Sxrw62g86sdfjpjNM9NCwq/io4KEUoUuNjDQVU9aLvZNw+dZTa
 IQkXC7tHkjYSru4utU4+LWbo/lG/052TFKIk6E7wivU9cO1AJpk9P+RwKHDeiwVOSYRWOz1ea
 ecWiOjesL8eYVnzPhaA1AXBI+X1uc0RyWF6DuJyIHFBGUDoDiVnxt/AfmWRZDpolpSm0xGeVc
 t4hGuZx9uGTdnP/JlEpzM1hIwoJk5JUQ6SOkwKvXJ+l0v+zX17LFoCoFoJF0zCTLLPfLuA8xG
 JCNOuTMFD1BrZsNETEHPxBjdzy8OtVMZpVutsagnG4cOe38ewY5GVMVL3CcNq5+qLOm3Me7QD
 3Ay0TUGhAm+6bKaB0FzzV25u02RoZoeX7/goaLYNt3SOIe1/Wo1KK9EPE3J1GiNpXveIwbywO
 SS0Pwa2HB2HB+cfg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/26/2018 04:50 PM, Kirill A. Shutemov wrote:
>>>> 2. reading from memory which may be reserved in case of EFI systems:
>>>>>>      ebda_start = *(unsigned short *)0x40e << 4;
>>>>>>      bios_start = *(unsigned short *)0x413 << 10;
>>>> Also, on EFI system without CSM it will results in all zeros. Which will
>>>> place trampoline_start to 0x9d000. And it also may be reserved memory. In
>>>> fact I have such system and it is causes instant reboot (when code starts
>>>> copying to "trampoline_start").
>>> Could you show dmesg from such system?
>> Sure, here it is (please note than not both pages are reserved but only
>> second one: 0x9e000-0x9ffff):
> Well. That's bad.
>
> I don't see much options but parse e820 in decompression code. I hoped to
> avoid this.
>
> Let me see what I can do there.
Just in case of UEFI (I don't know much about BIOS and kexec):
register RSI (right before call paging_prepare) will contains pointer to 
"struct boot_params" (returned by function efi_main() in eboot.c).
There are fields e820_table and e820_entries.

