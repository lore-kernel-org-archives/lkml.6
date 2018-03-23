Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeCWOQx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 10:16:53 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:41410 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCWOQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 10:16:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180323141648epoutp01ba555430003d66089e73ecfd8461e7d8~eklLuTrZo1309313093epoutp01D
X-AuditID: b6c32a4b-cd1ff70000001126-89-5ab50c4f3e4b
Mime-Version: 1.0
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Reply-To: v.narang@samsung.com
From: Vaneet Narang <v.narang@samsung.com>
To: Nick Terrell <terrelln@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC: Maninder Singh <maninder1.s@samsung.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "ngupta@vflare.org" <ngupta@vflare.org>,
        Kees Cook <keescook@chromium.org>,
        "anton@enomsg.org" <anton@enomsg.org>,
        "ccross@android.com" <ccross@android.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>, Yann Collet <cyan@fb.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <1663C9A3-7DAC-4A11-894C-C99E07BEDAD2@fb.com>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180323134319epcms5p62e6021aa33c941c46ecdb8b5364b614c@epcms5p6>
Date: Fri, 23 Mar 2018 19:13:19 +0530
X-CMS-MailID: 20180323134319epcms5p62e6021aa33c941c46ecdb8b5364b614c
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180323134319epcms5p62e6021aa33c941c46ecdb8b5364b614c
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPJsWRmVeSWpSXmKPExsWy7bCmlq4/z9Yogynr9Cwu7k61mLN+DZvF
        wa2aFts3fmO1+L26l81ia1OSxZzzLSwW3a9kLM5051rcv/eTyeLyrjlsFofnt7FYLPv6nt1i
        Q8ssdot7b7YyWTyaMInJ4tW/a2wWby7cY3EQ8ti2exurx6yGXjaP2Q0XWTy2rLzJ5DGh/xOj
        x8Tmd+weO2fdZffYdkDVY/Gel0wem1Z1snmcmPGbxaNvyypGj52fNrN6fN4kF8AXlWqTkZqY
        klqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA/SkkkJZYk4pUCgg
        sbhYSd/Opii/tCRVISO/uMRWKdrQ0EjP0MBcz8jISM/ENNbKyBSoJCE1Y86aySwFGxQrGi7f
        YmtgfC7axcjJISFgIrFi3jrmLkYuDiGB3YwSfT/XsHYxcnDwCghK/N0hDFIjLBAm0XFxLzuI
        LSQgJ3H8xm5GiLiOxIl5axhBytkEtCQ+toSDhEUEYiTO75/BBDKSWeA7q8Tt881sELt4JWa0
        P2WBsKUlti/fCtbLKWAlsXiiEERYVOJPA0yJqMT7Y/MZIWwRidZ7Z5khbEGJBz93Q8VlJL5/
        7WcF2SUh0M0o8W7ybhYIZwqjRMMbmG5zifMn54N18wr4Skxtb2EFsVkEVCUeLXrMBFHjInG2
        9RzYk8wC8hLb385hBjmOWUBTYv0ufYgSWYmpp9ZBldtKXOprYIEo55Po/f2ECebHHfNgbCWJ
        cwd3Qv0uIfGkcybUAx4Sc/YtYp/AqDQLEdKzkCyehbB4ASPzKkbJ1ILi3PTUYtMC47zUcr3i
        xNzi0rx0veT83E2M4MSu5b2DcdM5n0OMAhyMSjy8Mw5tjhJiTSwrrsw9xCjBwawkwmvxckuU
        EG9KYmVValF+fFFpTmrxIUZTYBBMZJYSTc4HZp28knhDE0sDEzMzc0MDA0sTJXFex0CXKCGB
        9MSS1OzU1ILUIpg+Jg5OqQbGMqHNd1wXWd/u27ePpV3sRs1GhkN/I5P3qeh8CpSxXTTr2c8m
        x/Rnupsctq+13eUc9GvtHM+le5w/bvS3X1v9eVJ+/IaOdzGz155lVfjEG+QlWRYupcctLC4e
        fHLxr7usQkLesbsc5S78atZbt4hn/taLm3QebLetl7k702KatHnFJ8XO2NnmSizFGYmGWsxF
        xYkAeY4RIgIEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
X-RootMTR: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
References: <1663C9A3-7DAC-4A11-894C-C99E07BEDAD2@fb.com>
        <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
        <20180321082628.GB2746@jagdpanzerIV>
        <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcms5p6>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick / Sergey,


We have compared LZ4 Dyn with Original LZ4 using some samples of realtime application data(4Kb)
compressed/decompressed by ZRAM. For comparison we have used lzbench (https://github.com/inikep/lzbench)
we have implemented dedicated LZ4 Dyn API & kept last literal length as 6 to avoid overhead 
of checks. It seems in average case there is a saving of 3~4% in compression ratio with almost same compression
speed and minor loss in decompression speed (~50MB/s) when compared with LZ4.

Comparison of Lz4 Dyn with LZO1x is also done as LZO1x is default compressor of ZRAM.

Original LZ4:
sh-3.2# ./lzbench  -r  -elz4  data/
lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
Compressor name         Compress. Decompress. Compr. size  Ratio Filename
memcpy                   2205 MB/s  2217 MB/s        4096 100.00 data//data_1
lz4 1.8.0                 216 MB/s   761 MB/s        2433  59.40 data//data_1
lz4 1.8.0                 269 MB/s   877 MB/s        1873  45.73 data//data_2
lz4 1.8.0                 238 MB/s   575 MB/s        2060  50.29 data//data_3
lz4 1.8.0                 321 MB/s  1015 MB/s        1464  35.74 data//data_4
lz4 1.8.0                 464 MB/s  1090 MB/s         713  17.41 data//data_5
lz4 1.8.0                 296 MB/s   956 MB/s        1597  38.99 data//data_6
lz4 1.8.0                 338 MB/s   994 MB/s        2238  54.64 data//data_7
lz4 1.8.0                 705 MB/s  1172 MB/s         193   4.71 data//data_8
lz4 1.8.0                 404 MB/s  1150 MB/s        1097  26.78 data//data_9
lz4 1.8.0                 216 MB/s   921 MB/s        3183  77.71 data//data_10
lz4 1.8.0                 456 MB/s  1101 MB/s        1011  24.68 data//data_11
lz4 1.8.0                 867 MB/s  1202 MB/s          37   0.90 data//data_12


LZ4 Dynamic Offet:  
sh-3.2# ./lzbench  -r  -elz4_dyn  data/
lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
Compressor name         Compress. Decompress. Compr. size  Ratio Filename
memcpy                   2203 MB/s  2218 MB/s        4096 100.00 data//data_1
lz4 1.8.0                 218 MB/s   693 MB/s        2228  54.39 data//data_1
lz4 1.8.0                 273 MB/s   851 MB/s        1739  42.46 data//data_2
lz4 1.8.0                 230 MB/s   526 MB/s        1800  43.95 data//data_3
lz4 1.8.0                 321 MB/s   952 MB/s        1357  33.13 data//data_4
lz4 1.8.0                 470 MB/s  1075 MB/s         664  16.21 data//data_5
lz4 1.8.0                 303 MB/s   964 MB/s        1455  35.52 data//data_6
lz4 1.8.0                 345 MB/s   951 MB/s        2126  51.90 data//data_7
lz4 1.8.0                 744 MB/s  1163 MB/s         177   4.32 data//data_8
lz4 1.8.0                 409 MB/s  1257 MB/s        1033  25.22 data//data_9
lz4 1.8.0                 220 MB/s   857 MB/s        3049  74.44 data//data_10
lz4 1.8.0                 464 MB/s  1105 MB/s         934  22.80 data//data_11
lz4 1.8.0                 874 MB/s  1194 MB/s          36   0.88 data//data_12


LZ4 Dynamic Offset with 32K data:
sh-3.2# ./lzbench -elz4_dyn data/data32k
lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
Compressor name         Compress. Decompress. Compr. size  Ratio Filename
memcpy                   5285 MB/s  5283 MB/s       32768 100.00 data/data32k
lz4 1.8.0                 274 MB/s   995 MB/s       13435  41.00 data/data32k
done... (cIters=1 dIters=1 cTime=1.0 dTime=2.0 chunkSize=1706MB cSpeed=0MB)

Original LZ4 with 32K data:
sh-3.2# ./lzbench_orig -elz4 data/data32k
lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
Compressor name         Compress. Decompress. Compr. size  Ratio Filename
memcpy                   4918 MB/s  5108 MB/s       32768 100.00 data/data32k
lz4 1.8.0                 276 MB/s  1045 MB/s       14492  44.23 data/data32k

LZO1x with 32K data (Default Compressor for ZRAM): 
sh-3.2# ./lzbench -elzo1x,1 data/data32k
lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
Compressor name         Compress. Decompress. Compr. size  Ratio Filename
memcpy                   5273 MB/s  5320 MB/s       32768 100.00 data/data32k
lzo1x 2.09 -1             283 MB/s   465 MB/s       14292  43.62 data/data32k

Regards,
Vaneet Narang
