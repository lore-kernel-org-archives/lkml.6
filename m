Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADDC46470
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40A521C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 04:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mAmpkJZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40A521C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeHIHPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 03:15:35 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:33967 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbeHIHPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 03:15:35 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180809045237epoutp03cc4a05c84870abdc370fe05916a18689~JHjQ1fOki2712327123epoutp03H;
        Thu,  9 Aug 2018 04:52:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180809045237epoutp03cc4a05c84870abdc370fe05916a18689~JHjQ1fOki2712327123epoutp03H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533790357;
        bh=hk82B5zWgUG9/qiLCTpUaNunBfRCdekGQCSkSqYts44=;
        h=Date:From:To:Subject:In-reply-to:References:From;
        b=mAmpkJZheaI9hNVqQJdKw0SVANHbBqNBUTUXTIdzWyM13DQ5zaTBiCIdp8AQNJcsL
         rP/WDIqxZXE9J+F6Kfgrc+DtY6NyXHN0Ok1acuw4gNfts8il3r+woptiHyywW2XEOl
         7qCNYU47XXlvlexEazSxatCu8dhMmz+EzQ+8qIjY=
Received: from epsmges2p3.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180809045235epcas1p1a7e2afb93132a937eeaf46f73dee5676~JHjO_8MvT1511715117epcas1p1m;
        Thu,  9 Aug 2018 04:52:35 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        0E.C0.04412.398CB6B5; Thu,  9 Aug 2018 13:52:35 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180809045235epcas2p11884507a0eed7f850ffa35c29d33715c~JHjOl26Jf0915009150epcas2p1G;
        Thu,  9 Aug 2018 04:52:35 +0000 (GMT)
X-AuditID: b6c32a47-289ff7000000113c-99-5b6bc893b000
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.FB.03824.398CB6B5; Thu,  9 Aug 2018 13:52:35 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PD6006DSG7MVYC0@mmp1.samsung.com>; Thu, 09 Aug 2018 13:52:35 +0900 (KST)
Message-id: <5B6BC892.5010804@samsung.com>
Date:   Thu, 09 Aug 2018 13:52:34 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: maxim: Add SPDX license identifiers
In-reply-to: <20180807162122.19614-1-krzk@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7bCmue7kE9nRBp1HNCw2zljPanH+/AZ2
        i8u75rBZ3G5cwebA4rFpVSebR9+WVYwenzfJBTBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        RRsaGukZGpjrGRkBaeNYKyNToJKE1IzGo4fZC76zVKw6ZdHA2MfSxcjJISFgIvF+/logm4tD
        SGAHo0RH00kmCOc7o8SRxe/ZYaqm/l3JDJHYzSix+xNIFScHr4CgxI/J94DaOTiYBeQljlzK
        BgkzC2hKbN29nh2i/i6jxNuZXSwQ9VoSt6/NZgOxWQRUJZZd6WYGsdmA4vtf3ACL8wsoSlz9
        8ZgRxBYViJDYOf8b2BEiAqsYJdpWS4DYwgIOEu0TnoLN5BQwlWhcPxvsOAmBOWwSp78cZIa4
        2kXi6pkZUB8IS7w6vgXKlpZ4tmojI0RDO6PElxfNrBDOBEaJD6c2M0FUGUs8W9jFBPEPn0TH
        4b/sIG9KCPBKdLQJQZR4SDSc/wMNlg5Gie4TMxgnMMrMQgqZWYiQmYUUMgsYmVcxiqUWFOem
        pxYbFRjrFSfmFpfmpesl5+duYgQnJC33HYzbzvkcYhTgYFTi4b3Alx0txJpYVlyZe4hRgoNZ
        SYR3szhQiDclsbIqtSg/vqg0J7X4EKMpMGAnMkuJJucDk2VeSbyhqZGxsbGFqbmlsYGlkjhv
        lV9wtJBAemJJanZqakFqEUwfEwenVANjSmHs891fjZX1d++dJsIT9FzEKbTiunrkQznHCjO1
        z5/6z5XIqrG9eB/1We3+Ma+/h2et7r8vutFBQFhbj9+1c8Uyr1MT9omKeE1UUpnLy7MiNWi1
        b0a48LFcx0cP/LhXTSpfttSu5nzVQdU/ManxuffO/Q3fODe011pJ5mfiNPfg99mF4V1KLMUZ
        iYZazEXFiQAtECcEXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBLMWRmVeSWpSXmKPExsVy+t9jAd3JJ7KjDe6v57XYOGM9q8X58xvY
        LS7vmsNmcbtxBZsDi8emVZ1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXRePQwe8F3lopV
        pywaGPtYuhg5OSQETCSm/l3J3MXIxSEksJNRYvKe74wgCV4BQYkfk+8BFXFwMAvISxy5lA0S
        ZhZQl5g0bxEziC0kcJ9R4uRfLohyLYnb12azgdgsAqoSy650g9WwAcX3v7gBFucXUJS4+uMx
        I8hIUYEIie4TlSBrRQRWMUrs/r8F7B5hAQeJ9glPWSDu6WKUeHn7A1iCU8BUonH9bOYJjPyz
        kJw3C+G8WUjOW8DIvIpRMrWgODc9t9iowCgvtVyvODG3uDQvXS85P3cTIzA8tx3W6t/B+HhJ
        /CFGAQ5GJR7eC3zZ0UKsiWXFlbmHGCU4mJVEeDeLA4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwGnPoW8ZosM2yVYrauiaFuSm8OnLNUckm8WzhIqVl
        4R7xy+/tk+G/LFp40pHz9A37X7OjnJgPW6RzyGZoVfFt41uewdibu0li0pQFruK723u51y/b
        vXWiwxQ5uQW5LQeW8UcEedwr158dGPP54WxfznlVjxj7t+SvlmBcmP5kBfffF/UL2SYrsRRn
        JBpqMRcVJwIAHEo3tUsCAAA=
X-CMS-MailID: 20180809045235epcas2p11884507a0eed7f850ffa35c29d33715c
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180807162203epcas4p3975e866242639590247fe922a4a54266
References: <CGME20180807162203epcas4p3975e866242639590247fe922a4a54266@epcas4p3.samsung.com>
        <20180807162122.19614-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 2018년 08월 08일 01:21, Krzysztof Kozlowski wrote:
> Replace GPL v2.0+ license statements with SPDX license identifiers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/extcon/extcon-max14577.c | 24 +++++++-----------------
>  drivers/extcon/extcon-max77693.c | 22 ++++++----------------
>  drivers/extcon/extcon-max77843.c | 19 +++++++------------
>  drivers/extcon/extcon-max8997.c  | 22 ++++++----------------
>  4 files changed, 26 insertions(+), 61 deletions(-)
> 

Thanks. Applied it for v4.20.

(snip)

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
