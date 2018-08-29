Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F414C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766A52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W0+EtROq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766A52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeH2LCW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:02:22 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:31432 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727562AbeH2LCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:02:21 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180829070653epoutp023050c2ee2dbc53af68cde04e53d3bf22~PSSNCs6xP2581325813epoutp02R;
        Wed, 29 Aug 2018 07:06:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180829070653epoutp023050c2ee2dbc53af68cde04e53d3bf22~PSSNCs6xP2581325813epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1535526413;
        bh=71N+4AO/kn3O7aEOWzLyTmnMRDMrztO21uXHaR9veeI=;
        h=Date:From:To:Subject:In-reply-to:References:From;
        b=W0+EtROqSiqmvghGCeAKRwVovtsITT7SGn2e6WnVMAk8Qu4070PzglA3bWaBaQq/n
         K0UjZaYzoHNPpS+2qI/ssffndsGDEkd9yONCNgw51obnkcbl+lKZXuzrQKx7+YKbhh
         LCgfSSlaltwyFvc26jFs4GxaZT7iChkH5QNluGYc=
Received: from epsmges2p1.samsung.com (unknown [182.195.40.156]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20180829070651epcas1p45cd14a43da51df35ce89eb3296e94301~PSSKiH8bv0981509815epcas1p4a;
        Wed, 29 Aug 2018 07:06:51 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.9C.04218.A06468B5; Wed, 29 Aug 2018 16:06:50 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20180829070650epcas2p17a3f9c5635aa4ed204710e69134d6540~PSSKG1POZ1797317973epcas2p1b;
        Wed, 29 Aug 2018 07:06:50 +0000 (GMT)
X-AuditID: b6c32a45-253ff7000000107a-42-5b86460ab781
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A1.95.03703.A06468B5; Wed, 29 Aug 2018 16:06:50 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from [10.113.63.77] by mmp1.samsung.com (Oracle Communications
        Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with ESMTPA id
        <0PE700A9CNRDIG10@mmp1.samsung.com>; Wed, 29 Aug 2018 16:06:50 +0900 (KST)
Message-id: <5B864609.2040405@samsung.com>
Date:   Wed, 29 Aug 2018 16:06:49 +0900
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v1 1/7] extcon: Make static analyzer happy about union
 assignment
In-reply-to: <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmhS63W1u0wZFmRovepulMFm+OA4nL
        u+awWdxuXMHmwOIx72Sgx/t9V9k8+rasYvT4vEkugCUq1SYjNTEltUghNS85PyUzL91WyTs4
        3jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMHaKOSQlliTilQKCCxuFhJ386mKL+0JFUhI7+4
        xFYp2tDQSM/QwFzPyAhIG8daGZkClSSkZvw/8Yy14D17xeFtl5gaGDeydTFyckgImEisuTWZ
        tYuRi0NIYAejxM2ew2wQzndGieffv7DDVPV3r2GESOxmlDj96S8TSIJXQFDix+R7LF2MHBzM
        AvISRy5lg4SZBTQltu5ezw5Rf5dR4snMBVD1WhLvljeB2SwCqhKvPr8EO4MNKL7/xQ0wm19A
        UeLqj8eMILaoQITEzvnfwAaJCCxnlHh6ZwnYRcIC4RLnvi8EG8Qp4C7xce9FsB8kBJawSUzY
        t4AZ4mwXic+z+lkgbGGJV8e3QL0jLfFs1UZGiIZ2RokvL5qhuicwSnw4tZkJospY4tnCLiaI
        h/gkOg7/ZQf5U0KAV6KjTQiixEOic/8xqD9nMUp0TzzOMoFRZhZS0MxCBM0spKBZwMi8ilEs
        taA4Nz212KjAUK84Mbe4NC9dLzk/dxMjODlpue5gnHHO5xCjAAejEg8vR3BrtBBrYllxZe4h
        RgkOZiUR3iCDtmgh3pTEyqrUovz4otKc1OJDjKbAkJ3ILCWanA9MnHkl8YamRsbGxham5pbG
        BpZK4rzVfsHRQgLpiSWp2ampBalFMH1MHJxSDYzzinlkPhclptvPzJjRavPPKs2x1GbyJiHT
        UNu9hb83bXeyOmr7xsSaNTW0RJ2xKj/ksX+h9o993xfJFy9mm3O3/fThshUCrba35qQcrOm/
        NOvir7/v2Iw3Tn/Db3G7ps9r2p2vnjVbt18pWhsdfzPj1BWfx0cWPhNYvL1L9d7MkqOXJK86
        dO9RYinOSDTUYi4qTgQAw83VGWQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLLMWRmVeSWpSXmKPExsVy+t9jAV0ut7Zog5/3FS16m6YzWbw5DiQu
        75rDZnG7cQWbA4vHvJOBHu/3XWXz6NuyitHj8ya5AJYoLpuU1JzMstQifbsEroz/J56xFrxn
        rzi87RJTA+NGti5GTg4JAROJ/u41jF2MXBxCAjsZJW4++sICkuAVEJT4MfkekM3BwSwgL3Hk
        UjZImFlAXWLSvEXMILaQwH1Gif/LzSHKtSTeLW9iArFZBFQlXn1+CTafDSi+/8UNMJtfQFHi
        6o/HjCAjRQUiJLpPVIKsFRFYzijx+NwidpAaYYFwiXPfFzJB3DOHUeLdk06wBKeAu8THvRdZ
        JzDyz0Jy3iyE82YhOW8BI/MqRsnUguLc9NxiowKjvNRyveLE3OLSvHS95PzcTYzAQN12WKt/
        B+PjJfGHGAU4GJV4eDmCW6OFWBPLiitzDzFKcDArifAGGbRFC/GmJFZWpRblxxeV5qQWH2KU
        5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamDcctFWQegeT/XzJ2kLfDidEvI2nlvQs/2N
        3i0j3bmq2xx4yq21l67/36Wx7ve7BTe/yJmcvDVV92jaY4n9kRuuZW7gNzBZxuFjdun8ktZY
        paxfZz6unusvM23DxrMaGzZwrOvzKvjBEbP+9fP1XrH/Nrnrb1fz2HK406Q10TlF7PWrzoKC
        89aXlFiKMxINtZiLihMBCpjPE1ACAAA=
X-CMS-MailID: 20180829070650epcas2p17a3f9c5635aa4ed204710e69134d6540
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180827153615epcas5p212a6279a5d5c3cbfc2608cbf34c2803d
References: <CGME20180827153615epcas5p212a6279a5d5c3cbfc2608cbf34c2803d@epcas5p2.samsung.com>
        <20180827153557.58363-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018년 08월 28일 00:35, Andy Shevchenko wrote:
> When assign unions we need to supply non-scalar value, otherwise
> static analyzer is not happy:
> 
> CHECK   drivers/extcon/extcon.c
> drivers/extcon/extcon.c:631:22: warning: cast to non-scalar
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/extcon/extcon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index b9d27c8fe57e..c21650a92689 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -628,7 +628,7 @@ int extcon_get_property(struct extcon_dev *edev, unsigned int id,
>  	unsigned long flags;
>  	int index, ret = 0;
>  
> -	*prop_val = (union extcon_property_value)(0);
> +	*prop_val = (union extcon_property_value){0};
>  
>  	if (!edev)
>  		return -EINVAL;
> 

Applied all patches of this series. Thanks.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
