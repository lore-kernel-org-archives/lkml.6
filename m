Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED71C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996B4217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 01:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbfBGBhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 20:37:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:43351 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbfBGBhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 20:37:20 -0500
Received: from [10.8.11.6] ([196.52.84.14]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0LvQkh-1hH5np1Mln-010ead for
 <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:37:18 +0100
To:     linux-kernel@vger.kernel.org
From:   "Artem S. Tashkinov" <ultrafine@gmx.com>
Subject: On the issue of CPU model-specific registers write protection in UEFI
 secure boot mode
Message-ID: <8d1f8adc-222b-40df-4573-67f28819126c@gmx.com>
Date:   Thu, 7 Feb 2019 01:37:16 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:MFmXOgcNerOfqqeHVRvWtqTF7kjbBWUR82moBWcaj9ZhJPVTXOn
 xbFV7jIcqN4QcANZl7OSwh96+QfN6EpriVLFEuv8eygabe2JmMtjCWMf0ueQEQznamS1Ehi
 GYn+oeD8ne+Pnq4sl77YX2caEVL4FXBzc+QvJRMePsi+fASL+p8tUW1btXCD5p9m4qUbumI
 B1ev7qH24acTtYeGx634g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijCAaFBmPrc=:Y3OlgEQr+6c/1gRYnnsJvN
 j7DRKiWYkODTBt+LnTKtW/+g1fXVnzj/X+OzmsMEZIsxRezG1/tLFD/Mz1P8Q9RFWrnrh6wDS
 S9lxgqSbiO/5seUEFdprVDy8A3K23MrqIHnQhgHVhyvl04mZsg9tFyf1MML5Fl6P5ewDtPP5b
 zRTnjt6ieYiw15EpcqNhppKxBbmKV32zNjsgwYSymLekTzWziXJjZT1/cvYF4Q7OK3f50GM2f
 EPaJkwP6N1D4HnBx/hezaKZOvIZHONYQWBjNDybE82NV7tWh4svoHnhxqngiTIOkxxzs9U0Jq
 61vk6hErL5fgdTfdsWpXsgxqAV7oDchs3BE7CFlUl65p53LTQ3I75rNI1zkgIM0VIcp93H9sa
 oInesG0Yiemyh3oUUO7WrayOrIE/KO9vFkfcZPnd/fYAC905CgEy0jbZxGUzJfMycc3Sr1Kj4
 Hoh0LUPhZEgooCL7rUkad07cHeNsD0J/QKVWVO2vPq8iYAuJLVT35MYBMD3swevGjHzzFCxHt
 MxovydmrJP2SOKKxP+zzEP4foXvydJz3pSc8VltbYTNNtGapc7a2zXvS8WDiFBy08A++pojO2
 YP709Rfz7fUPY+QUEjJ3Dp7EqaYtxhnkjqYLeO7IHiHt1QUW3tDGw6jgdaCe0Eq18UIDrIM/Q
 8ljWlgCAGPT0ya+rYQua1i01dan59Iz4YosXM2l5oSxi0p2EP2bFwl6zjoMN4bHLVC2yKk1yF
 MwmIUCQniRdquzDscd2dAUIdZ4qAdA5OPC9Jg0wskqVWuvppTHv5vtWcl8RbZwrW7GIdFbjQ5
 1Q1Yz7oDaIs9k1UeCQPjVkVTmWB0W8EbmOxjyV53uakpqBwTyZwlTMwIXTnFdQnI4FPycEnjp
 adc1K0ZMu5oTcvxcOgNvoqz55o155KYJrrJeVOt17qHnhZF15Xry9Kbja9Vrga4KCHieVQJ46
 b+VXnQAkq/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello LKML,

Is there a serious reason why CPU MSR is write protected in UEFI secure 
boot mode in Linux?

  * In order to even use MSR you have to be root to `modprobe msr`.
  * In order to read/write from/to MSR you have to be root as 
/dev/cpu/*/msr is accessible only by root.
  * CPU registers don't survive reboot/power cycles.
  * I'm not a CPU designer but if I'm not mistaken MSR cannot be used to 
create any sort of stealth malware.

So, I'm asking this question because these registers allow to fine tune 
Intel CPU power parameters ( https://github.com/georgewhewell/undervolt 
) like voltage and others and make it possible to run your system both 
faster and cooler and right now it's not possible under Linux and 
perfectly possible under competing proprietary OSes.

Of course, the user can

  * fetch his distro kernel sources
  * apply a patch from ( 
https://github.com/intel/intel-cmt-cat/wiki/UEFI-Secure-Boot-Compatibility )
  * install his own UEFI certificate
  * compile, sign and install a patched MSR kernel module

However this all has to be done for each new kernel release and many 
Linux users just cannot do anything on this list.

Best regards,
Artem
