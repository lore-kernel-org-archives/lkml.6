Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A66AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDC2C2087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC2C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbeJDVcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:32:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:44129 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727322AbeJDVca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:32:30 -0400
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1flkhG0Vgg-00w00j; Thu, 04
 Oct 2018 16:38:48 +0200
Received: from [10.95.173.99] ([155.56.40.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M8MyE-1flkhG0Vgg-00w00j; Thu, 04
 Oct 2018 16:38:48 +0200
Subject: Re: [GIT PULL] parisc fixes for kernel v4.19
From:   Helge Deller <deller@gmx.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        James.Bottomley@hansenpartnership.com,
        John David Anglin <dave.anglin@bell.net>
References: <20181002210213.GA17826@ls3530.fritz.box>
 <20181002211645.GA6454@kroah.com>
 <ad45f249-e064-d5a4-c658-eaa03bb3a04a@gmx.de>
 <20181002222452.GB11788@kroah.com>
 <dbfa0162-8ed1-b16e-a418-da3b92c76230@gmx.de>
 <20181003181612.GB28575@kroah.com>
 <CAK8P3a2ntPX4+LbYWJbDG1k-8NwkhyY0nYk-mfZU2FBF_h23Yw@mail.gmail.com>
 <20181003230226.GB27729@kroah.com>
 <ed8a12d5-604f-c938-f65d-051e05561dc6@gmx.de>
 <CAK8P3a3HCBY8+xK_o50aswFsrb1EVCFATV4zwqfNqHUDqtDa_w@mail.gmail.com>
 <9ba92a5e-c447-f894-5263-3d7220716f87@gmx.de>
Openpgp: preference=signencrypt
Autocrypt: addr=deller@gmx.de; prefer-encrypt=mutual; keydata=
 xsBNBFDPIPYBCAC6PdtagIE06GASPWQJtfXiIzvpBaaNbAGgmd3Iv7x+3g039EV7/zJ1do/a
 y9jNEDn29j0/jyd0A9zMzWEmNO4JRwkMd5Z0h6APvlm2D8XhI94r/8stwroXOQ8yBpBcP0yX
 +sqRm2UXgoYWL0KEGbL4XwzpDCCapt+kmarND12oFj30M1xhTjuFe0hkhyNHkLe8g6MC0xNg
 KW3x7B74Rk829TTAtj03KP7oA+dqsp5hPlt/hZO0Lr0kSAxf3kxtaNA7+Z0LLiBqZ1nUerBh
 OdiCasCF82vQ4/y8rUaKotXqdhGwD76YZry9AQ9p6ccqKaYEzWis078Wsj7p0UtHoYDbABEB
 AAHNHEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT7CwJIEEwECADwCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAFiEE9M/0wAvkPPtRU6Boh8nBUbUeOGQFAlrHzIICGQEACgkQh8nB
 UbUeOGT1GAgAt+EeoHB4DbAx+pZoGbBYp6ZY8L6211n8fSi7wiwgM5VppucJ+C+wILoPkqiU
 +ZHKlcWRbttER2oBUvKOt0+yDfAGcoZwHS0P+iO3HtxR81h3bosOCwek+TofDXl+TH/WSQJa
 iaitof6iiPZLygzUmmW+aLSSeIAHBunpBetRpFiep1e5zujCglKagsW78Pq0DnzbWugGe26A
 288JcK2W939bT1lZc22D9NhXXRHfX2QdDdrCQY7UsI6g/dAm1d2ldeFlGleqPMdaaQMcv5+E
 vDOur20qjTlenjnR/TFm9tA1zV+K7ePh+JfwKc6BSbELK4EHv8J8WQJjfTphakYLVM7ATQRQ
 zyD2AQgA2SJJapaLvCKdz83MHiTMbyk8yj2AHsuuXdmB30LzEQXjT3JEqj1mpvcEjXrX1B3h
 +0nLUHPI2Q4XWRazrzsseNMGYqfVIhLsK6zT3URPkEAp7R1JxoSiLoh4qOBdJH6AJHex4CWu
 UaSXX5HLqxKl1sq1tO8rq2+hFxY63zbWINvgT0FUEME27Uik9A5t8l9/dmF0CdxKdmrOvGMw
 T770cTt76xUryzM3fAyjtOEVEglkFtVQNM/BN/dnq4jDE5fikLLs8eaJwsWG9k9wQUMtmLpL
 gRXeFPRRK+IT48xuG8rK0g2NOD8aW5ThTkF4apznZe74M7OWr/VbuZbYW443QQARAQABwsBf
 BBgBAgAJBQJQzyD2AhsMAAoJEIfJwVG1HjhkNTgH/idWz2WjLE8DvTi7LvfybzvnXyx6rWUs
 91tXUdCzLuOtjqWVsqBtSaZynfhAjlbqRlrFZQ8i8jRyJY1IwqgvHP6PO9s+rIxKlfFQtqhl
 kR1KUdhNGtiI90sTpi4aeXVsOyG3572KV3dKeFe47ALU6xE5ZL5U2LGhgQkbjr44I3EhPWc/
 lJ/MgLOPkfIUgjRXt0ZcZEN6pAMPU95+u1N52hmqAOQZvyoyUOJFH1siBMAFRbhgWyv+YE2Y
 ZkAyVDL2WxAedQgD/YCCJ+16yXlGYGNAKlvp07SimS6vBEIXk/3h5Vq4Hwgg0Z8+FRGtYZyD
 KrhlU0uMP9QTB5WAUvxvGy8=
Message-ID: <52a7db47-ec60-76e7-a71c-8d95c83df471@gmx.de>
Date:   Thu, 4 Oct 2018 16:38:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <9ba92a5e-c447-f894-5263-3d7220716f87@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:610es2IC3Vx+koP5Mb1DktbTI3511qHweyUfR4K0IGeXrJAcuNR
 aJ/ibJjKkiDCxOJC5ZdREOXE6gkRqaAyPx5gLemr3V3wKlBd7BzGz8usf8LqfNonDJiGtQT
 FjAgCea1HnYShwlwXTQ7e/DSnauQEcyosIXVKVTsPA+9VNe4zmXhjhc7HqBXetW+fNT6kNS
 yTVmTkBQjqTN4S7AGKiHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OpnWdpY2Y90=:BZreqjqYGASak3mtWvhL20
 /AhLjFXuJsi42j9sWLXt0L8yc9bEtgCeMXTmdDz1YWW03YpTOQfuw9j9a2aXmwYcjt8CK7Z/D
 I1K9FgS2bMzpU/5QZyFuApgPpKDixSv2fHULejYsY/VMnqgfJxRj9zfpza12I2xCBdX59UGdr
 /7PrZ99DjDtao7Uoeb/SGDAuMMyrPbiJuC/vgvJXP+NBBDBD+N+0anA67A9ykPJM4ojQjvLgG
 nDrQsQIWV7f6w0mCLDJ58ZsCnQGe7HS1E1yy6dKtfo/qUFgRi7+8xAtqae+yc3TCl+7bG0TIY
 MEz2auavxcwexsE3INexkdf4OSIQIfghXyaYa645ewp/XV9bLvH3LzCUwknuBsoJI9VLNVLfV
 tgadtVuxvBqD2YunOQGKSuQF2AUDYJW8ToZyrXb3gE9qlHpyscVANTo0vgcIXta6MDyXKXrCy
 UikLN39q1uCo+K6C8V4+pPHKwxDMqYvsxYwg7epWaMh6kL7gNKz3JhXjGKDwnP+EVybjvbH38
 ssopKo63EVgU56yAW7/NX1QgVrx4LTSfR+rxMNGUpBEyJGo99NfEe0x7MXFU8UqrYoEh1QLsw
 8M/V8w1qpMla8CagbPPIi8St+EhL9/rVLiTfrrcr//7ShYSUw2ea5wdKx8afQK/bghs9Z7UcP
 50Iy4+pOylWN8/wLCuk5tpl54Jyrxp0+x8/8LoHNvsIdIMPhYzKB2w1F38Vz7bGYpueMyfFyV
 i0Coed4r0N4jrWKI7EICNugkzTFk4KouJI2nolF47UvF5sm9tvBiJGUZ7BEh01ZU7bsPZda72
 2AuSSuc91nqOiRrLGgUxm8990F4vfxbji2g3cbJ7q1xYhhxHYMKhA1/teZ2qnbxlJdK9MqhuP
 6/aBwYOE1ci0DzE70w08UTf8ol67t+zLSWF2wQWat9vtsmQWi8vpX6gfu2DzFwmLnUQPTCTWq
 BmdjQ68DbhGG+2PTarjzRnjRNz6wZg+HCbL2aFy2IE0Jn0EFwsjiW
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.10.2018 16:30, Helge Deller wrote:
> On 04.10.2018 15:34, Arnd Bergmann wrote:
>> On Thu, Oct 4, 2018 at 10:42 AM Helge Deller <deller@gmx.de> wrote:
>>> On 04.10.2018 01:02, gregkh wrote:
>>>> On Wed, Oct 03, 2018 at 09:49:08PM +0200, Arnd Bergmann wrote:
>>>>> On Wed, Oct 3, 2018 at 8:16 PM Greg Kroah-Hartman
>>>>> <gregkh@linuxfoundation.org> wrote:
>>>>>> On Wed, Oct 03, 2018 at 04:47:30PM +0200, Helge Deller wrote:
>>>>>>> On 03.10.2018 00:24, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Oct 02, 2018 at 11:46:11PM +0200, Helge Deller wrote:
>>>>> Or to put it another way: If the argument is
>>>>> that there won't ever be a 64-bit user space for parisc
>>>
>>> FYI, I was planning to try a 64-bit user space at some point.
>>> Just see my recent patches and mails, e.g.
>>> b6fc0cccb6b35815a7d1cfc9279cdbfc2c61d00d
>>> 5b00ca0b8035e49ef7c466e959c5cb457a654351
>>> and
>>> https://www.spinics.net/lists/linux-parisc/msg09070.html
>>>
>>>>> and we don't care about it,
>>>
>>> I (and a few others) do care about it.
>>>
>>>>> then we'd be better of removing all native 64-bit
>>>>> syscalls from arch/parisc/kernel/syscall_table.S.
>>>>
>>>> Ok, then let's treat this like any other arch/driver/subsystem that we
>>>> remove.  Drop the file(s) in a -rc1 merge window and then if anyone
>>>> object to it later on because they really were using it, you can easily
>>>> revert that change.
>>>
>>> As a maintainer of this port, I object to this.
>>> You suggest to remove a working, functional and maintained interface for no good use.
>>> Removing it won't save lots of bytes in the executable (or source code)
>>> but will make my life as maintainer harder.
>>
>> Makes sense. I was basing my thoughts on the observation that
>> nobody did this in the last 18 years that he port has been around,
>> but if you still plan to do this, then we should not regress.
>>
>> What is your current estimate for how many more patches
>> are required to get it working reasonably well? 
> 
> I'm not aware of missing functionality which requires additional patches
> for the Linux kernel.
> It's userspace which needs work, e.g. binutils needs to be fixed
> to get multiple stub section support, and glibc.
> 
>> Did you plan
>> to have commit 5b00ca0b8035 ("parisc: Restore possibility
>> to execute 64-bit applications") backported to stable kernels,
>> or just get it working in future versions?
> 
> A backport of this patch is not needed.
> The patch fixes the 64-bit loader which I broke a few days before 
> when I switched to the generic binfmt implementation with commit
> 71d577db01a5 ("parisc: Switch to generic COMPAT_BINFMT_ELF").

Actually, to be correct here, backporting my commit 5b00ca0b8035
to v4.17, v4.18 and v4.19 would be the right thing.

>> I suppose we either want to backport that patch and mine,
>> or neither of them.

Agreed. Both would be best.

Helge
