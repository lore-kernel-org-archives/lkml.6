Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeBFRLL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:11:11 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:37967 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752286AbeBFRLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 12:11:00 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180206171058euoutp02973d39447dc92478106e3c6f607f546f~Qy7ZS524U2731127311euoutp02k
X-AuditID: cbfec7f2-f793b6d000003243-f0-5a79e1a1c3d2
Subject: Re: [PATCH] crypto: s5p-sss.c: Fix kernel Oops in AES-ECB mode
To: Anand Moon <linux.amoon@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Kamil Konieczny <k.konieczny@partner.samsung.com>
Message-id: <b3b0b170-f10b-fb8a-74f9-b6aa0cb41980@partner.samsung.com>
Date: Tue, 06 Feb 2018 18:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <CANAwSgTO5_mL9GEYrXDJyKakY3JTeF+VxbCTuHczAvfVY0zUsg@mail.gmail.com>
Content-type: text/plain; charset="utf-8"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHfXfOdo6j2eu8PXiNpV0E7WodyqKictSXKAJbH2zkwS5ObVNp
        9aGRec+yZSpLyFVeki66lrfKzMzrcIpJGrpSWaiUhBdKS83tKPjt97zP7+V5/vDQhPgV35M+
        HxPPKmPk0RKBkKxsmukI0g+qZZuHOtyZivwXfKbAfINkMse8GbO5nGK+WmZ4THdtgYDJN9fx
        mOcVXyjmWeMAxSzMJhH7hFLjkz6etEY3QEkr6wOkhrJ0gXRen0NKbxnLkHTS4HuMkglDI9no
        84msctPeM8JzWcPZVFy98HLvu1KBBpXQGciRBrwdeotTBRy7Q6flxSILaTEuQtCi6V4qJhFY
        Rh+Tyz90lh6SaxQj0JuTeFzxHUGjtZ+wWS44DGrKC+3sitfBJ2sp3yYReJYHpodv7AMFeCcM
        VZl4Nhbhw3AzMxVlIJomcQDUd9kVNxwO+ntWxCnO8Oeuxb6FIz4BRcZyysYE3ggjU1qSYw9I
        Su5bYj94+fQnwW39VwB5psMcH4TZ7FE+xy4w1mykOPaG9LT39jCAbyMo6W2juCIHQXNuD4+z
        dsOH5i4+N8EJtJV5hG1pwCJISxFzihRS+muX9P3Q9TzHHkaMBxF0TgdlIz/dijy6FRl0KzLo
        VmQoRGQZcmUTVIooVrUtWCVXqBJiooLPxioMaPGY2uebJ6rRdMuuBoRpJFklSjOoZWK+PFGl
        VjQgoAmJq+i47UkUKVdfYZWxEcqEaFbVgLxoUuIh2iNLOSXGUfJ49iLLxrHK5S6PdvTUIEwG
        H9nx0VN2aaHCfHpkeO7Ig9PDLckza6xEcfgFo2t7m4OvuS3oqGaDVwjlltamrafvtCY4t1dp
        Vx/IPDXVOOV/NWlhfOD3L4csw7imSf6o++2/8EBT8TftWOv6qM9zPqGPyK0nvXKDw2pSGWPE
        /FqTk09Iww//19WHrt2/bp2ok5Cqc/ItgYRSJf8PDB2/JkgDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Zd0FDyujDCYeMbHYOGM9q8Wc8y0s
        Ft2vZCzOn9/AbnH/3k8mi8u75rBZzDi/j8li3cZb7BZrj9xlt/j/q5nZgctjy8qbTB47Z91l
        99h2QNVj06pONo9/C6ewePRtWcXo8XmTXAB7FJdNSmpOZllqkb5dAldG7+MJ7AUHuCpu7F/B
        1sC4nKOLkZNDQsBEYta9qywQtpjEhXvr2boYuTiEBJYwSjxd/4UZJCEk8IxRYtpLORBbWMBd
        YueGBWBxEQE1iStPV7CCNDAL/GKSWPzpIjNE92NGiW+vp4CNZRMwl3i0/QwTiM0r4CbR093O
        2MXIwcEioCpx4CIbSFhUIEKic+V8FogSQYkfk++B2ZwCwRLvT3WwgZQzC6hLTJmSCxJmFhCX
        aG69yQJhy0tsXvOWeQKj4Cwk3bMQOmYh6ZiFpGMBI8sqRpHU0uLc9NxiQ73ixNzi0rx0veT8
        3E2MwPjZduzn5h2MlzYGH2IU4GBU4uE12FAZJcSaWFZcmXuIUYKDWUmEN2gTUIg3JbGyKrUo
        P76oNCe1+BCjNAeLkjjveQOglEB6YklqdmpqQWoRTJaJg1OqgXHKjK5D+mXv5MzSBFuY7fau
        XX1svgiDfeu9H0uCGX30A2JNpz5oLt+7sGzPzoTGuVeSr/m/XP7r6pXdU9L/zO9+umVnZmjW
        vPTsph83FNm9GmsCOqO37H8WPzF0y8xSlhhFLqY0Xr7Hk61K+sP8TJweqwkVdu9447hsZl7V
        bf+gb+9O13rPNFFiKc5INNRiLipOBAA0Y5+WmwIAAA==
X-CMS-MailID: 20180206171056eucas1p20ff76b00b33866d364ff501a5acc2d05
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f
X-RootMTR: 20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f
References: <CGME20180205174022eucas1p101e8339284c1f0ac8f40f70c24de1c1f@eucas1p1.samsung.com>
        <224788c7-426b-d3a9-d0a6-412d2b8afb75@partner.samsung.com>
        <CANAwSgTO5_mL9GEYrXDJyKakY3JTeF+VxbCTuHczAvfVY0zUsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.02.2018 17:48, Anand Moon wrote:
> Hi Kamil,
> 
> Thanks for providing the fix to this issue.
> 
> On 5 February 2018 at 23:10, Kamil Konieczny
> <k.konieczny@partner.samsung.com> wrote:
>>
>> In AES-ECB mode crypt is done with key only, so any use of IV
>> can cause kernel Oops, as reported by Anand Moon.
> 
> If possible could you avoid the name in commit message.

This is added after '---' line, so it will not appear in commit message.

>> Fixed it by using IV only in AES-CBC and AES-CTR.
>>
>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> Reported-by: Anand Moon <linux.amoon@gmail.com>
> 
> [snip]
> 
> Please add my. Tested on Odroid HC2
> 
> Tested-by: Anand Moon <linux.amoon@gmail.com>

This will add you name in commit message,
additionally with 'Reported-by:' line.

> Below are the result at my end.
> 
> aes-cbc-essiv:sha256 (128 bit key)
> WRITE:
> 100+0 records in
> 100+0 records out
> 838860800 bytes (839 MB, 800 MiB) copied, 11.7225 s, 71.6 MB/s
> [...]

is it from 'cryptsetup benchmark' ? benchmark did not cause oops.
Please test with luksFormat, ie. use

cryptsetup luksFormat --debug -q -d /tmp/testkey.key \
  --cipher aes-cbc-essiv:sha256 -h sha256 -s 128 /tmp/test.bin

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
