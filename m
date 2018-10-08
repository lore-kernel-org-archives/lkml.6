Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0FCC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 587CC2086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 06:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 587CC2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJHNQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:16:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:34551 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725842AbeJHNQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:16:38 -0400
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQUP-1fvKiv0FOn-00GreV; Mon, 08
 Oct 2018 08:06:28 +0200
Received: from [192.168.20.60] ([92.116.184.237]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQUP-1fvKiv0FOn-00GreV; Mon, 08
 Oct 2018 08:06:28 +0200
Subject: Re: [PATCH v3 5/6] parisc: wire up rseq system call
To:     Firoz Khan <firoz.khan@linaro.org>
Cc:     linux-parisc@vger.kernel.org,
        "James E . J . Bottomley" <jejb@parisc-linux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
References: <1538975801-13735-1-git-send-email-firoz.khan@linaro.org>
 <1538975801-13735-6-git-send-email-firoz.khan@linaro.org>
 <feb53cb6-e20b-42c3-5b53-8b310c772545@gmx.de>
 <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
From:   Helge Deller <deller@gmx.de>
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
Message-ID: <22745bed-baf6-4f08-6801-3529021cf33e@gmx.de>
Date:   Mon, 8 Oct 2018 08:06:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <CALxhOnjjWQRi6G4N-o+GZzkqc_zAYNT3RaN+P6bdEXeE=uY6-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9uYmU3LmjfAJ+HDG+JWGG2r+pavFs+h+Kg2F7UDTTvXNPHi+zlG
 wSZS5xSdmA0r8KAwFOP6Hgx80G0fV0VX0ynGjUkkj7RztoyPVllxunfWW3843e7T8e5vB77
 rhL2AF4jGXinVff1UNBkCoyR7DyFvgq5TUThNW8ZcMOFKeny6cg1krDjLc0qVkYEvxZc6EB
 L+LW8836i3HNB8iolpcGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6HLwKVputgs=:69R5WazUSGYugSKN2OQyhY
 UTNJE0nSxVv9JT7rpQPjMAWM2rr8Dwn/yOq0LVhNW/78KSIjXiTIs5oByqi9i9jeiZS/YItpn
 6/2hGdHXc8lmnguD/R4nYP3Iu6Haeg+LuXor7Hh/g/WuAptCriiOoX+NHoSymUXNsjzlweOqv
 Xt0PZTp5rlA2+ma/QT5vwSbbZh5sgKyJ+tTldvTJRe05PPpceqDAemjcWUc1gRJ6iGay09H+x
 Y9nMLYYaad2Hq6lwjzyHZGC9brUq5ahy7l2omXAyP/HNqBpqDamhu0lBWXBI+9yUb8ejOP2tT
 cvTE9JQKchONgEzJBUwLnJEpnDTKOEeuSDeuexgbRVOQCIxfs96N0T2Gv3P0z07OJFCfrXwx2
 y+hyoldwS1CmFRStPeR7ozs+mE9tDOIHrEWj4HHSGCxhzZ7MtIzqBeeGvxPQ9B3g4T4fVfBO9
 sDOwt+1/QLdNBPU8Zka7klu63Q/8JDh0vamYkvxcn7gIRcyvpIhBApbFA0SG1dKQdBK0y40Ig
 kG7JAp7npjQE0HGL03/JvWby5LL+FBtXn/tcgRUflV8pVwpnik/BZs8mP1EvuT7S7kCtyUtc8
 xHoABTQDK+g6XaLqnpTyBU9SiGyw0FezfJtBo13JJyzSx1loiTfYq4tKLj3xENovgeNSGC/u7
 R6ZNXzdRPhpZOHdZFjBSyb+UYy4mwI7X14ysDZoZj8oSO+FMGVFDUUd/5EetzJ3rrM08XRuky
 dGdkJW1XOqyriCEqajZvEwzqhaUT9a/70I56+3y5hRuusk0a4dq+UurkpGquHYJiMQHDPnaGh
 152rtaWmrpjekYx5DuYZm0UynSC5D8hemWCczsqbHVADBZt9bo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.10.2018 07:52, Firoz Khan wrote:
> Hi Helge,
> 
> On Mon, 8 Oct 2018 at 11:11, Helge Deller <deller@gmx.de> wrote:
>>
>> On 08.10.2018 07:16, Firoz Khan wrote:
>>> Signed-off-by: Firoz Khan <firoz.khan@linaro.org>
>>> ---
>>>  arch/parisc/kernel/syscalls/syscall.tbl | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/parisc/kernel/syscalls/syscall.tbl b/arch/parisc/kernel/syscalls/syscall.tbl
>>> index 4e85293..4334bb7 100644
>>> --- a/arch/parisc/kernel/syscalls/syscall.tbl
>>> +++ b/arch/parisc/kernel/syscalls/syscall.tbl
>>> @@ -349,4 +349,5 @@
>>>  347     common  preadv2                         sys_preadv2                     compat_sys_preadv2
>>>  348     common  pwritev2                        sys_pwritev2                    compat_sys_pwritev2
>>>  349     common  statx                           sys_statx
>>> -350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
>>> \ No newline at end of file
>>> +350  common  io_pgetevents                   sys_io_pgetevents               compat_sys_io_pgetevents
>>> +351  common  rseq                            sys_rseq                        compat_sys_rseq
>>
>> You can't add the rseq syscall for parisc yet.
>> It needs additional code in the kernel for parisc which hasn't been tested yet.
>> See my initial untested patch at https://patchwork.kernel.org/patch/10495209/
> 
> Thanks for your update!
> 
> When I compiled the kernel I got below warnings.
> 
> <stdin>:696:2: warning: #warning syscall nfsservctl not implemented [-Wcpp]
> <stdin>:1335:2: warning: #warning syscall rseq not implemented [-Wcpp]
> 
> I added an IGNORE entry nfsservctl in script/checksyscalls.sh because this
> syscall is gone. But we definitely have to keep rseq entry on parisc
> architecture.

I prefer to keep the warning for rseq for now.
It reminds me that we still may want the rseq syscall.
If the warning is a problem, you may simply add the __IGNORE_rseq define. 

> I can ignore this patch currently as your patch not yet tested.
> 
> FYI, I have merged the system call table files based on our previous
> discussions.
> Please comment on that.

I'll do after testing.

Thanks!
Helge
 
> I would appreciate if you can perform a boot test without this patch
> on the actual
> platform.
> 
> Firoz
> 
>>
>> Helge

