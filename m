Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754210AbeDBGIf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:08:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:58337 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751639AbeDBGIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:08:32 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180402060831epoutp03fa2221c9495961134e7dfa513a7ff8cd~hiXsqXVIB0489804898epoutp03d
X-AuditID: b6c32a4a-d07ff70000000fed-e1-5ac1c8de4203
Mime-Version: 1.0
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Reply-To: maninder1.s@samsung.com
From: Maninder Singh <maninder1.s@samsung.com>
To: "sergey.senozhatsky.work@gmail.com"
        <sergey.senozhatsky.work@gmail.com>
CC: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20180321064128.GA468@jagdpanzerIV>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180402060354epcms5p391e8f43648898d6d7dbd2ceb274f3cd9@epcms5p3>
Date: Mon, 02 Apr 2018 11:33:54 +0530
X-CMS-MailID: 20180402060354epcms5p391e8f43648898d6d7dbd2ceb274f3cd9
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180402060354epcms5p391e8f43648898d6d7dbd2ceb274f3cd9
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAJsWRmVeSWpSXmKPExsWy7bCmuu69EwejDHYuVbG4uDvVYs76NWwW
        B7dqWmzf+I3V4vfqXjaLOedbWCy6X8lYnOnOtbh/7yeTxeVdc9gsln19z26xoWUWu8W9N1uZ
        LB5NmMRk8ebCPRaLQyfnMjoIeGzbvY3VY1ZDL5vH7IaLLB5bVt5k8pjQ/4nRY+esu+we2w6o
        eize85LJY9OqTjaPEzN+s3j0bVkFlPy0mdXj8ya5AN6oVJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoLeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZK0YaGRnqGBuZ6RkZGeiamsVZGpkAlCakZPVO2MhVc4K5Yv76PrYFxBXcXIyeHhICJRN/d
        pSxdjFwcQgK7GSW+Hp/E2MXIwcErICjxd4cwSI2wQJhEx8W97CC2kICixIUZa8BKhAUMJH5t
        1QAJswnoSazatYcFxBYR8JZYsraVCcRmFnjGKrFuWyjEKl6JGe1PWSBsaYnty7cygticQGPO
        397HCBEXlfjTAFMjKvH+2HyouIhE672zzBC2oMSDn7uh4jISqzf3gp0vIdDMKPFicQsThDOF
        UWLR8VY2iCpzifMn54N18wr4SrReWMQKYrMIqEqsejAXapuLxPqjjcwQV2tLLFv4mhnkSWYB
        TYn1u/QhSmQlpp5axwQSlhCwldi6Owqimk+i9/cTJpgfd8yDsVUlWm5uYIX59/PHj1CbPCTm
        7FvEPoFRaRYioGch2TsLYe8CRuZVjJKpBcW56anFpgVGeanlesWJucWleel6yfm5mxjBqVvL
        awfjsnM+hxgFOBiVeHhn2ByMEmJNLCuuzD3EKMHBrCTCu2IRUIg3JbGyKrUoP76oNCe1+BCj
        KTAEJjJLiSbnA/NKXkm8oYmlgYmZmbmhgYGliZI4r2OgS5SQQHpiSWp2ampBahFMHxMHp1QD
        4/a9X2dnv8xODDDymFDivIFlIe+Og2bfnusuSi9cnTT/jqz5gToeJ9YXFxn5771clB33agfr
        1S6XmNoLl7ZNXC8kb/Ra5se3dZdfbVLbu9LP1yzLpUP2wDHBspbZCxdziSzfM004UeXA8c6N
        MocerNp3e1uihZXhcrl8rr5k24VZX6stv52yeaTEUpyRaKjFXFScCADw9BJX8wMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
X-RootMTR: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
References: <20180321064128.GA468@jagdpanzerIV>
        <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
        <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcms5p3>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w3268eqc001753


 Hello,

>> (Added cover letter to avoid much text in patch description)
>> 
>> LZ4 specification defines 2 byte offset length for 64 KB data.
>> But in case of ZRAM we compress data per page and in most of
>> architecture PAGE_SIZE is 4KB. So we can decide offset length based
>> on actual offset value. For this we can reserve 1 bit to decide offset
>> length (1 byte or 2 byte). 2 byte required only if ofsset is greater than 127,
>> else 1 byte is enough.
> 
>So what happens if I compress the data on a system with no dyn
>offset and then send it over the network to a machine which has
>dyn offset? Or, say, I have a USB stick with a compression enabled
>FS, store files on a dyn offset enabled PC and then mount that USB
>stick on a machine with no dyn offset support. And vice versa.


lz4_dyn is not an extension of LZ4 so there is no backward compatibility.
Consider this as a different algorithm adapted from LZ4 for better compression ratio.

Thanks
Maninder Singh
