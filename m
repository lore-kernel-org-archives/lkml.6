Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEBEC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7C3214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7C3214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=peterpall.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726063AbeLDHde convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:33:34 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:55703 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbeLDHde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:33:34 -0500
Received: from [192.168.44.140] ([2.247.255.74]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1Mj8Vx-1h70Kf3Twj-00fD0h for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018
 08:33:33 +0100
From:   =?UTF-8?Q?Gunter_K=c3=b6nigsmann?= <gunter@peterpall.de>
Subject: Re: ext4 file system corruption with v4.19.3 / v4.19.4
Openpgp: preference=signencrypt
Autocrypt: addr=gunter@peterpall.de; keydata=
 xsFNBEtcn30BEAC6zdpDRiIMJ8/55TEK3gM50tneUn4g/8yFgC/AnAuEVdxAYoJO6bAAss6u
 ggY0Cocx/rLWl1CYYWnrLc+EQ0EWGjsZPHYTljC6lvXIUnK/uSboHjLbfun0EprYwYUFKw+L
 yRnsUbstBZm+QSc4A47m6l/vfzxOJU3gnuMSvsFc62B2jNk0czfHtOUXYZJLEGaTLNqUCIoM
 w+8AksntLcCsDgdcpA3GCoacq+Lo/t5u4uGJA8arxTRPWL9uD8zuGMuqt2N41q2DjJq9I1Q2
 GqyeJfUtLx1a0H6hGuxkzQTvc7QpQ9q3k43KPHLFkqCRCMCi5xk/ffQsENw4GXw5Gp6VPyA5
 HpeyS5xlAKa3qnZDHvNG+WzVI7pwAXN+smrrr9BnupKmWZ5rM59NpJRfqgLlofQIxrHc33Vr
 qPH5ET7c5gM8li7jkG0Olwens45/yFtFAKz2rrjBnrxhvs6FVJJXTjIhwJIn8+dPoconxDo9
 LWjecxuq5PqGYv8zI4k5hqXC0dX2jIim5YyAUMTEvHZeQ2mnVEV7zf2xfZHQLUIx43Uk1+S0
 d4iRQ2v3NVA3aibwRVxesWoBKXB02wbyVBKNKWjBjUuGkUjZh7akhG/KavGqPOiEGYr2O3t3
 PMuLfCLaI5dKkXl+JMwlenpG0n+td1TlVQwlNkHZqPZ1jAOWXwARAQABzStHdW50ZXIgS8O2
 bmlnc21hbm4gPHd4bWF4aW1hQHBoeXNpa2J1Y2guZGU+wsF9BBMBCgAnBQJVKBKqAhsDBQkT
 MXQgBQsJCAcDBRUKCQgLBRYDAgEAAh4BAheAAAoJEFyGwOQhHVuOAJ8P/1kTiTL5UjMpXaBS
 0fHcaM3ln1v+jSZg8g52nV2p4sRW8ScyQXhQ4D+sUNkFvfG+1g+GC0viTLBPmDt9g9uR6NOe
 cknKdQ5tbC+zv8HtyTLEahHND0F/e6siC7DHmOhk5BDc7A1R48QijEdZ7CZUuYSNVkg3w3VC
 Jg2+KUKZ/zrMBK0o3XpGCzyEK2U0sjsALcQmB6DVQ1tEkb5yjCbs9SYKyArBe5CnFZwFgbt5
 UPTgoZTEyomTY0oBLiU9pBdL+Va4O5qNbLmDN3R3DzZqPvntTCUCoUVTFVjjV1vApSVHdamn
 S31Xq7TrYvKvz5heOOKkqEfN/Cgx6EZJyJGyzYr3NaBzuA6U+xs00C6+aHxIeFf2myLpe9Jt
 WNzGHY9vCO/RyTHkKeNUSHFwq9bfMy4JF8BxqEZ+cp8lTjx8ht/w3APoQHOf1WWLlDnFZnEw
 8+9MHBu0T7itAI8F2ZQezZn0AV/F9gdrpH9J5hjAj0cGR0YdLfMWMQqQjOQALUNL5B6KuXtk
 gmsoAvChyv0jDQZaygCpwv41dJmxstPyET8s/ESblzyi+GgwRMb0TPJNqdRFh3ezyy0YTXbs
 lTtbp9VBDVHzTQxb6LHsSRFwukdnfQCkj9njqGWPjxnA7e+/3W/iksgenogytOGIurCMpEAU
 I8Ba8HOuiZy2msdXLkj3zsFNBEtcn30BEACywwvvCuzO/hV44wBnPCKc2C5CNeiIV/PZethA
 tZhJOtQazhh4D0ebf86ZSmdkKtyViaopR/t8JCJ/RRd2PYdhRDmKaz7L01yTmj7PpOpT2Y3N
 +GHgzyfsd0fNxySp+jgq+mhd3Kwmj+dnDI8CFZvddbadKz3N+e1fLvdshBWJtGEhLV/PMbVb
 gfZYlKYY4NzA2aZeMH9V9L94/Fn8lNvEx176vxa05Tdr+55OqHw+uJsH0iFDQmAM85bu6reb
 XxJq8jY20xhIiXirPG6BG7/o428hEVxbftEQHhAADXL2syOXsf8pZ27a3YGkX3IKIR6PU+Wi
 YqMOLoyLy4OqBBxIzircyucFPYvgOm5mUjBtjbeLGTU0MmA+Lq24nT1Iclfz0gEUmxcPmG97
 v4CQAbMknJhofZL1VEfnHhGBAdC9pCpcO+aT1Zfhaj0w7KtOLEKTPse8pwgg1TnWtMDWGomE
 SuNv3HpudEXZDy8jyQuRhenwfWemKCWUx5xDxg2mVgoUYQnfjEGZ4AfliaLHK09V2MQz2KJu
 /pbDAvr0Jm+ojLwC80x6k3lyXmY0YeKN3dGr39zy8VKlfPJsM09+bCGwbchZMuuUBwz5/hxz
 QVxoRGrzRVHnV+JyiiWOCqFuF9OcsVMyq4Ut5NSBY/iQbrUMBEfyhyMOIQgvcVrmuseKmQAR
 AQABwsFlBBgBCgAPAhsMBQJVKBJvBQkTMXRsAAoJEFyGwOQhHVuOgMIQAJIuD4STK6MP5rd8
 /7PJY5dG8EIvdQWSqyFbRCpGVwt1odQ+Scl8BKTcYiKwKlhXGewbY2ekdAyRTnR+Pi96zcmV
 rkxNRQhKCqn7JmBX7BU541BEwY26R9YlFjCi0BIJNnOFsVqqkwKJYh1qO4RcpVmi9mX3OTfA
 SqREywzSjOmUmrkzo38O/EIhwzlEIFdC2+14MrbYV/hZ8eILYc7PMF6pcEVatdiGqfE8dzYK
 AyeOUTUV5VcPbyXrQwj2OzSFHea1gzs5e3L0NPADPv40Oa/IN6HetNa4iHNj4hAP0WHdow89
 jZTJBmKQa75hJb9J/SxCMWGa4fK1OdhYGwi/dIB0t4luggvhm4jrBN7LY8PR2NrCfoi4PdSx
 1mVKAjcOT99wOBVmdTd3VP56fjdApsi/SQZpagzJrwAqrVwhuE9j8KSxONicnEuC8H7tW13P
 Y1pNewPIlqXLmAamlFJZShEfZpAwBmKQNiy5Jzp9P7T1Hnj7w8KJVZ48EZmRQO8NTPN2niJL
 6Mq1KoDEEzg19O6e/9fBZpeaazsaPMpQ4aOMhyDR7jyVrgTFwK9peWBrsGUX3UxHknfuGSPM
 MOVtRGNRyBZ5PH3tTHQUK5yTLPXGfR0tC3bbhP+/xVFztBU5GtjajYEiPryoxsqXda5E45gu
 QDeGlP63A66aPzIq5as4
To:     linux-kernel@vger.kernel.org
Message-ID: <90d3676e-09d5-9d09-50fc-9a2dc64c30a7@peterpall.de>
Date:   Tue, 4 Dec 2018 08:33:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:S2yiYTDxjeOY93EuvtUuboJTeTZe+WOwaeKkVxIjyuTjahXfac3
 Pnb8tEdUJZYL4IBk0MqrqPc/QI+AopOct8eVGsRqTvlugcMCC44q1S14fjV2nu6WwDmAbaH
 GA/pq+kHmJi4N6gzA2nVKLHhb+0zIymcKISnA8k8gZqXRdQYC0dGXvJD44/B2sGBBzC/o4h
 UybE56iIaLPDsvQDT93Qg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fxKwtDNpflU=:4ei2TWZRefgkrlFGrtVI4X
 aO/rCQ9qqjyrf9XJfXNPp8pUZj6v1cVEV7z6DjrbE+UBSI/6iqtzObNVJAZ3McOLS0Kz+rw96
 bjratT2q0PQwhGcfQBsoFMnn9cNQtuW5lRXrAEu8u163uswBUunaEsPv5HYSpxZ1qCpygN+sh
 GWzkw5GpSpa+XDDCTVLXivw8lCme+16KhSiSMQ3/BohMJad5vhpSMxqu3nu6kweWCFNw8U3yV
 /wuKe29qqctON47AQKxDTo/ttYmuAP/DBAVSojfV/H8qt2TtIgOZc7xWs4TvtuMrZLyaJqvgs
 SJN+4DrabAcc6GwojKce/JO6uOXF5KebTcEBK/74aNLbfzVLWsb32N3cNP7sZJYSUDGF2LYpG
 wd+LYL6NzytjIAzXVixyOQspmNHZv8gJY2eNpuCkpo1FfuhC0UBgXSHNeIywxEcGdNRdrTpDv
 F+v9jDYxzHvOEVl2DzEd/5G8gs7MmMUWO64xEjkzwdtcfsDz7bscb/WuVW7fXTrt+4tlZLQv/
 8adnfr7uiIBn/KVMe/xs0h5YJWDzmzNYBnOBJqd2MZrFd+64IlEbopNrphY0XR/p6AXjxwd7m
 hvl9cvFcXQauBdad1ZcHBqmGYmIG4q/dLF5lei+Mg8ajRLG3fNeNMQnI+Ie2ZS7gN3R5K2irH
 FURqaJNjixoyQMfGS8igfyh34X84rVhp+bPsFZTDtBuoshSI06jp4eIiszTY7V4IlncuAlO96
 SqMjCeQhdhcKnC6kQ+migwSEl/v/MNXAHEvW80Wo5HPtGsB/NqDvTRCxWNw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After upgrading my kernel to 4.19 I got a corruption on nearly every
reboot or resume from suspend on my Acer s7-391 [UEFI boot].

Going to my UEFI setup and changing IDE mode from IDE to ATA seems to
have resolved the issue for me.

Don't know, though, if that is a valid data point or if it was a mere
accident (tested only on one computer) or just avoids the Bad Timing by
a few nanoseconds....


