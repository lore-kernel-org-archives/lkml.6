Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeC2MKa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:10:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:56265 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeC2MK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:10:28 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180329121026epoutp035a228465ec370a81cdc95a4700c0845a~gYujVdsO_3014330143epoutp03c
X-AuditID: b6c32a4b-fcbff70000000fe6-24-5abcd7b1841b
Mime-Version: 1.0
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Reply-To: maninder1.s@samsung.com
From: Maninder Singh <maninder1.s@samsung.com>
To: Vaneet Narang <v.narang@samsung.com>, Nick Terrell <terrelln@fb.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
CC: "davem@davemloft.net" <davem@davemloft.net>,
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
In-Reply-To: <20180329102046epcms5p8ecc9532b03bab4f47cbdbb2507171b86@epcms5p8>
X-Drm-Type: Y,confirm
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180329102613epcms5p6ffaa80d12115ded8f3c9ef01dd009744@epcms5p6>
Date: Thu, 29 Mar 2018 15:56:13 +0530
X-CMS-MailID: 20180329102613epcms5p6ffaa80d12115ded8f3c9ef01dd009744
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
X-MTR: 20180329102613epcms5p6ffaa80d12115ded8f3c9ef01dd009744
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUxbVRjGc+5XL2iXSwt6ZMPgzcgAQ9d2LRzMmHMj5i6bC4uJxi5LvcIZ
        baQt6S0o/lVHmYOlHcyp2KGdXYJZSxwtFFiLRnB+MFEgGglZrMZIsrFlMOYGk23aS8H53+99
        8rzvm+fNOSypWmByWavdhZ12sY5nMqmBr4oKSyLTwyZt+IoaTSUw6jrfw6CRWBEajNyh0UrY
        y6DYkddQ14SHQsfnNqHx4zb0W/IugX6KdzGo+/a8AvV6/AqUvB4j0B/tJwk09+AXBl2fTFJo
        dOwjsFMlDCQGaMHv9jLCafcUJfSfmyGE9hOLQOhovqEQLvh/VQgDXxYIZ4evEkI01MoI33Wu
        UIKvPwSEC4t9tHAr+mTVBhPebsFiDXbmY3u1o8Zqr63g975o3m02lmp1JbpyVMbn20UbruAr
        91WVPG+tS4Xk8xvFuoaUVCVKEr91x3ano8GF8y0OyVXBH9Tp9Bqdtkyj1+s1BuOhZ/TGlOVV
        bJmejjP14+Kb33tCCjc4Zm4DGSzkDLD5yIiiDWSyKi4B4JkPeqg2wLJKLgveH1LLHjX3Ejw2
        9blCZhX3FJzs7AGyRc1p4d+xQllmOA0MxYcpeUw2NwLg8FiclguS89Ew6buqSC9Tws53Zqk0
        b4SDn8aAzBncfhhYvrim58B77tn/eP6bAEhzNmxJ/kCmOQv+fjexpm+C4T7v6mbINQN45ayH
        SBenAAx+28KkXWVwYiyw2q3kXoCBhSVaZoorgJG+y4wcB3KVcC5sk2WSexp2f3KNlGWSK4Ln
        41vTU/Lge5c+I9JcAUMTrXTavgF6V/4k1jMOfbzOBdAz00uv57118+ZaLgF2fRFUtAPe//DU
        /v8t9j9cfAaQIfAErpdstVgy1m+z4zc0kmiTGuy1mmqHLQpWX3vx3iEQ/XHfKOBYwD+qRMGE
        SUWLjVKTbRRAluSzlfOFKUlZIza9hZ0Os7OhDkujwJi6QAeZm1PtSP0du8usM5RrDaWlZTqt
        ttzAP6587kClScXVii78Osb12LneR7AZuW6ALItZz6o+tJYUbw63Ok/lmfRNjbMCm7mHPzz2
        yonApUnfTOa9XUT50f0HT+5o/trdHVRvjI53H1j2RrKLZnbfWTHvankf/hNcnrDtGWof/Ovw
        tYs7jUdP327qe7Cct7AU+FnZf4Mt8OZYN7/t3Yar7z9yaOmx3o6Rd7f4LlMv85FGnpIsoq6Y
        dEriv1JZ6MoDBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
X-RootMTR: 20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d
References: <20180329102046epcms5p8ecc9532b03bab4f47cbdbb2507171b86@epcms5p8>
        <20180323134319epcms5p62e6021aa33c941c46ecdb8b5364b614c@epcms5p6>
        <1663C9A3-7DAC-4A11-894C-C99E07BEDAD2@fb.com>
        <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
        <20180321082628.GB2746@jagdpanzerIV>
        <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcms5p6>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2TCAaNB009595


Hello Nick/Sergey,
 
Any suggestion or comments, so that we can change code and resend the patch?
 
> Hi Nick / Sergey,
> 
> 
> We have compared LZ4 Dyn with Original LZ4 using some samples of realtime application data(4Kb)
> compressed/decompressed by ZRAM. For comparison we have used lzbench (https://github.com/inikep/lzbench)
> we have implemented dedicated LZ4 Dyn API & kept last literal length as 6 to avoid overhead 
> of checks. It seems in average case there is a saving of 3~4% in compression ratio with almost same compression
> speed and minor loss in decompression speed (~50MB/s) when compared with LZ4.
> 
> Comparison of Lz4 Dyn with LZO1x is also done as LZO1x is default compressor of ZRAM.
> 
> Original LZ4:
> sh-3.2# ./lzbench  -r  -elz4  data/
> lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
> Compressor name         Compress. Decompress. Compr. size  Ratio Filename
> memcpy                   2205 MB/s  2217 MB/s        4096 100.00 data//data_1
> lz4 1.8.0                 216 MB/s   761 MB/s        2433  59.40 data//data_1
> lz4 1.8.0                 269 MB/s   877 MB/s        1873  45.73 data//data_2
> lz4 1.8.0                 238 MB/s   575 MB/s        2060  50.29 data//data_3
> lz4 1.8.0                 321 MB/s  1015 MB/s        1464  35.74 data//data_4
> lz4 1.8.0                 464 MB/s  1090 MB/s         713  17.41 data//data_5
> lz4 1.8.0                 296 MB/s   956 MB/s        1597  38.99 data//data_6
> lz4 1.8.0                 338 MB/s   994 MB/s        2238  54.64 data//data_7
> lz4 1.8.0                 705 MB/s  1172 MB/s         193   4.71 data//data_8
> lz4 1.8.0                 404 MB/s  1150 MB/s        1097  26.78 data//data_9
> lz4 1.8.0                 216 MB/s   921 MB/s        3183  77.71 data//data_10
> lz4 1.8.0                 456 MB/s  1101 MB/s        1011  24.68 data//data_11
> lz4 1.8.0                 867 MB/s  1202 MB/s          37   0.90 data//data_12
> 
> 
> LZ4 Dynamic Offet:  
> sh-3.2# ./lzbench  -r  -elz4_dyn  data/
> lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
> Compressor name         Compress. Decompress. Compr. size  Ratio Filename
> memcpy                   2203 MB/s  2218 MB/s        4096 100.00 data//data_1
> lz4 1.8.0                 218 MB/s   693 MB/s        2228  54.39 data//data_1
> lz4 1.8.0                 273 MB/s   851 MB/s        1739  42.46 data//data_2
> lz4 1.8.0                 230 MB/s   526 MB/s        1800  43.95 data//data_3
> lz4 1.8.0                 321 MB/s   952 MB/s        1357  33.13 data//data_4
> lz4 1.8.0                 470 MB/s  1075 MB/s         664  16.21 data//data_5
> lz4 1.8.0                 303 MB/s   964 MB/s        1455  35.52 data//data_6
> lz4 1.8.0                 345 MB/s   951 MB/s        2126  51.90 data//data_7
> lz4 1.8.0                 744 MB/s  1163 MB/s         177   4.32 data//data_8
> lz4 1.8.0                 409 MB/s  1257 MB/s        1033  25.22 data//data_9
> lz4 1.8.0                 220 MB/s   857 MB/s        3049  74.44 data//data_10
> lz4 1.8.0                 464 MB/s  1105 MB/s         934  22.80 data//data_11
> lz4 1.8.0                 874 MB/s  1194 MB/s          36   0.88 data//data_12
> 
> 
> LZ4 Dynamic Offset with 32K data:
> sh-3.2# ./lzbench -elz4_dyn data/data32k
> lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
> Compressor name         Compress. Decompress. Compr. size  Ratio Filename
> memcpy                   5285 MB/s  5283 MB/s       32768 100.00 data/data32k
> lz4 1.8.0                 274 MB/s   995 MB/s       13435  41.00 data/data32k
> done... (cIters=1 dIters=1 cTime=1.0 dTime=2.0 chunkSize=1706MB cSpeed=0MB)
> 
> Original LZ4 with 32K data:
> sh-3.2# ./lzbench_orig -elz4 data/data32k
> lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
> Compressor name         Compress. Decompress. Compr. size  Ratio Filename
> memcpy                   4918 MB/s  5108 MB/s       32768 100.00 data/data32k
> lz4 1.8.0                 276 MB/s  1045 MB/s       14492  44.23 data/data32k
> 
> LZO1x with 32K data (Default Compressor for ZRAM): 
> sh-3.2# ./lzbench -elzo1x,1 data/data32k
> lzbench 1.7.3 (32-bit Linux)   Assembled by P.Skibinski
> Compressor name         Compress. Decompress. Compr. size  Ratio Filename
> memcpy                   5273 MB/s  5320 MB/s       32768 100.00 data/data32k
> lzo1x 2.09 -1             283 MB/s   465 MB/s       14292  43.62 data/data32k
> 
> Regards,
> Vaneet Narang
 
Thanks.
 
