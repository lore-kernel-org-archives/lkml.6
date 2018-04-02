Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDBGIA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 02:08:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:38398 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751556AbeDBGH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 02:07:58 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180402060756epoutp01fd258ce827252cbfbeabd2519af640d0~hiXMVzsG32946529465epoutp01P
X-AuditID: b6c32a4b-fcbff70000000fe6-8e-5ac1c8bad436
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] lz4: Implement lz4 with dynamic offset length.
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
In-Reply-To: <20180321074948.GA2746@jagdpanzerIV>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180402055152epcms5p546fdb62381b769ed0c719f3bedcee3b8@epcms5p5>
Date: Mon, 02 Apr 2018 11:21:52 +0530
X-CMS-MailID: 20180402055152epcms5p546fdb62381b769ed0c719f3bedcee3b8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180402055152epcms5p546fdb62381b769ed0c719f3bedcee3b8
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPJsWRmVeSWpSXmKPExsWy7bCmlu6uEwejDA6f17e4uDvVYs76NWwW
        B7dqWmzf+I3V4vfqXjaLOedbWCy6X8lYnOnOtbh/7yeTxeVdc9gsln19z26xoWUWu8W9N1uZ
        LB5NmMRk8ebCPRaLQyfnMjoIeGzbvY3VY1ZDL5vH7IaLLB5bVt5k8pjQ/4nRY+esu+we2w6o
        eize85LJY9OqTjaPEzN+s3j0bVkFlPy0mdXj8ya5AN6oVJuM1MSU1CKF1Lzk/JTMvHRbJe/g
        eOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoLeUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnF
        JbZK0YaGRnqGBuZ6RkZGeiamsVZGpkAlCakZx5/1MhdcYK94MaOVsYHxPWsXIyeHhICJxITF
        LWxdjFwcQgK7GSWefGhh7mLk4OAVEJT4u0MYpEZYwF1i/uQrjCC2kICixIUZaxhBSoQFDCR+
        bdUACbMJ6Ems2rWHBcQWEfCWWLK2lQnEZhZ4xiqxblsoxCpeiRntT1kgbGmJ7cu3go3kFDCU
        ePn/C9Q5ohJ/GmBqRCXeH5vPCGGLSLTeO8sMYQtKPPi5GyouI7F6cy8LyPkSAs2MEi8WtzBB
        OFMYJRYdb2WDqDKXOH9yPtRfvhLb7luDhFkEVCUernvKDlHiItE2/QYzxNHyEtvfzgErZxbQ
        lFi/Sx+iRFZi6ql1TBC2rcTLp11Q5XwSvb+fMMH8uGMejK0q0XJzAyvMv58/fmQBGSkh4CGx
        4IXZBEalWYhwnoVk7yyEvQsYmVcxSqYWFOempxabFhjnpZbrFSfmFpfmpesl5+duYgQnbi3v
        HYybzvkcYhTgYFTi4Z1hczBKiDWxrLgy9xCjBAezkgjvikVAId6UxMqq1KL8+KLSnNTiQ4ym
        wBCYyCwlmpwPzCp5JfGGJpYGJmZm5oYGBpYmSuK8joEuUUIC6YklqdmpqQWpRTB9TBycUg2M
        aUI8autm5Fie3JrSwHjwzIbfSgdyn0ZwC/56VZvZ3aZ9jSNrq4fLs6vNEaJrpbRDOj17uBs7
        Q9y3n3Zp7vE9+yGive868zvetu4Pl6/oLOTs2bSOb4Jw75IsJrHD+i3vOud/Y/zkZ7TE+M3y
        6U3PW/qbNRibZs2POq/he06suPBaQnLstlQlluKMREMt5qLiRADFCFiy8gMAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd
X-RootMTR: 20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd
References: <20180321074948.GA2746@jagdpanzerIV>
        <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
        <1521607242-3968-2-git-send-email-maninder1.s@samsung.com>
        <CGME20180321044149epcas5p12cba1afa5fc0f493a47fe20c4a7394bd@epcms5p5>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>> diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
>> index 4ed0a78..5bc5aab 100644
>> --- a/drivers/block/zram/zcomp.c
>> +++ b/drivers/block/zram/zcomp.c
>> @@ -17,11 +17,15 @@
>>  #include <linux/crypto.h>
>>  
>>  #include "zcomp.h"
>> +#define KB        (1 << 10)
>>  
>>  static const char * const backends[] = {
>>          "lzo",
>>  #if IS_ENABLED(CONFIG_CRYPTO_LZ4)
>>          "lz4",
>> +#if (PAGE_SIZE < (32 * KB))
>> +        "lz4_dyn",
>> +#endif
> 
>This is not the list of supported algorithms. It's the list of
>recommended algorithms. You can configure zram to use any of
>available and known to Crypto API algorithms. Including lz4_dyn
>on PAGE_SIZE > 32K systems.
> 
>        -ss
 
Yes, we want to integrate new compression(lz4_dyn) for ZRAM 
only if PAGE_SIZE is less than 32KB to get maximum benefit. 
so we added lz4_dyn to available list of ZRAM compression alhorithms.

Thanks,
Manider Singh
