Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F270EC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A128420652
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 10:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ybi7cdvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A128420652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJHSEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 14:04:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56948 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbeJHSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 14:04:19 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181008105311euoutp01815abae153204505c797f9a152f35558~bnLNOmW2L2051520515euoutp019
        for <linux-kernel@vger.kernel.org>; Mon,  8 Oct 2018 10:53:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181008105311euoutp01815abae153204505c797f9a152f35558~bnLNOmW2L2051520515euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538995991;
        bh=O5at4rzuAdS/vvnSJF27t0FhR+/UCpTyTGPkJm60HKI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Ybi7cdvg7yrLemqAtnQHDdbVTFKAjOwiw+gXFRRrxiPyRyr06EnS0HPwXd1Y8qBYf
         Bv6SYXEq3lLlRPvLzq501idxV8fAs3zePYfX88xa6N/lCSMKCo0Vyp/KDPXby1gB1C
         3E6BnentHImO8+QsafRjJiCET3fof6U7Kq2UZH8I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181008105310eucas1p29a2357648bda745cda400ceb6d9b5ba7~bnLMhHHkx0135001350eucas1p2d;
        Mon,  8 Oct 2018 10:53:10 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8E.20.04441.6173BBB5; Mon,  8
        Oct 2018 11:53:10 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181008105310eucas1p1347f43171fe1e7cc8122711927a30bb0~bnLLu5wP61861618616eucas1p1i;
        Mon,  8 Oct 2018 10:53:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181008105309eusmtrp19b3479085ae7037f8c49187c76cdb06a~bnLLeF3g42387123871eusmtrp1P;
        Mon,  8 Oct 2018 10:53:09 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-4a-5bbb37164ec2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F2.97.04128.5173BBB5; Mon,  8
        Oct 2018 11:53:09 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181008105309eusmtip2097059dd71ed1e64051d376bd491d4cc~bnLLI3qhM2538725387eusmtip2x;
        Mon,  8 Oct 2018 10:53:09 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 1/3] video: ssd1307fb: Use
 gpiod_set_value_cansleep() for reset
To:     =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Mon, 8 Oct 2018 12:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7pi5rujDXoPK1rMP3KO1WLj5tss
        Fif6PrBaXN41h83i/+cnrBate4+wW7zYIu7A7rFpVSebx8Z3O5g8Pm+S83j59wNzAEsUl01K
        ak5mWWqRvl0CV0bH6TfsBV0sFT//zmdqYNzA3MXIySEhYCLx/Mtexi5GLg4hgRWMErc3TGKD
        cL4wSnzcuJoZwvnMKDFp/x6gMg6wlqt9IRDx5YwSRz9/hCp6zyjRs3YNI8hcYYF4iSlfFrGB
        2CICthL73zSzg9jMAscZJc7sUASx2QSsJCa2rwKrZxFQkeiY2MoKskBUIEKi/4w6SJhXQFDi
        5MwnLCA2p4C7xOSWXhaIMfISzVtng+2VEJjHLrFn1kF2iIYyie/TTkD95iIxY/Y6JghbWOLV
        8S3sELaMxOnJPSwQzdMZJd78WgrlrGeUWHPmGFSHtcTh4xfBLmIW0JRYv0sfIuwocWLCdWhI
        8EnceCsIcRCfxKRt05khwrwSHW1CENVqEhuWbWCDWdu1cyXUaR4St499Zp7AqDgLyZuzkLw2
        C2HvAkbmVYziqaXFuempxYZ5qeV6xYm5xaV56XrJ+bmbGIHp5fS/4592MH69lHSIUYCDUYmH
        d2XArmgh1sSy4srcQ4wSHMxKIryi24FCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeZfN2xgtJJCe
        WJKanZpakFoEk2Xi4JRqYNyx4vEX/WVL3RlqIw7IRe681CBr/mPXm+pr8SasLUeZBLz9WQ8c
        S/14q3fZ3sfX1bgVXBYdMv9RUSGil5VWFSG9craUus3vpyqK/Icl+a3uJZh8P5CekzZvhm6T
        fL7Wig3ih8tf+i7nE0h/8oBB7pTCxXkh7xLaHrtZPG7eLSO779jbv3deByqxFGckGmoxFxUn
        AgCKJh3lKwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7qi5rujDeav0rSYf+Qcq8XGzbdZ
        LE70fWC1uLxrDpvF/89PWC1a9x5ht3ixRdyB3WPTqk42j43vdjB5fN4k5/Hy7wfmAJYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyO02/YC7pY
        Kn7+nc/UwLiBuYuRg0NCwETial9IFyMXh5DAUkaJQ2/3MkLEZSSOry/rYuQEMoUl/lzrYoOo
        ecsoMXHNThaQhLBAvMSUL4vYQGwRAVuJ/W+a2SGKZjFKfL68kwnEYRY4zijxYtVVJpAqNgEr
        iYntqxhBbF4BO4k7B6ezgtgsAioSHRNbwWxRgQiJWw87WCBqBCVOznwCZnMKuEtMbukFs5kF
        1CX+zLvEDGHLSzRvnc08gVFwFpKWWUjKZiEpW8DIvIpRJLW0ODc9t9hIrzgxt7g0L10vOT93
        EyMwcrYd+7llB2PXu+BDjAIcjEo8vCsCdkULsSaWFVfmHmKU4GBWEuEV3Q4U4k1JrKxKLcqP
        LyrNSS0+xGgK9MREZinR5HxgVOeVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgt
        gulj4uCUamDsUlz64ILoNt/SNaF7E5kinax/cP1x4rr/e6H8wmKreTUFNxmLrh6sOGIlauY6
        98rVj3ba9U5ndjfFSe/TN3w7ed5Ssbwrk9VLJt9lfiK6sqJ/385DBYemntbrnHTi9G6R7Tc4
        pgjvWP3shRwb36LL56dwJ2uUb/nQ19VTay8XW9T3hkPetmyREktxRqKhFnNRcSIABifq4bIC
        AAA=
Message-Id: <20181008105310eucas1p1347f43171fe1e7cc8122711927a30bb0~bnLLu5wP61861618616eucas1p1i@eucas1p1.samsung.com>
X-CMS-MailID: 20181008105310eucas1p1347f43171fe1e7cc8122711927a30bb0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180927092738epcas5p28c53516b73fe7747133914f40c84d6c4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180927092738epcas5p28c53516b73fe7747133914f40c84d6c4
References: <CGME20180927092738epcas5p28c53516b73fe7747133914f40c84d6c4@epcas5p2.samsung.com>
        <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/27/2018 11:24 AM, Michal Vokáč wrote:
> The reset signal can be produced by GPIO expander that can sleep.
> In that case the probe function fails. Allow using GPIO expanders for
> the reset signal by using the non-atomic gpiod_set_value_cansleep()
> function.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Patch queued for 4.20, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
