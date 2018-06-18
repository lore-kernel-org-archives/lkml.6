Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31EB0C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8BD02086A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 13:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cCy2w5RU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8BD02086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933693AbeFRNRk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 09:17:40 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:38069 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933279AbeFRNRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 09:17:38 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180618131735euoutp0270622a42cfcbc96decac147c566fae89~5Q5ULPGQ60803708037euoutp02h
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:17:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180618131735euoutp0270622a42cfcbc96decac147c566fae89~5Q5ULPGQ60803708037euoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529327855;
        bh=IlkTFKiSeDUYrks/qfr+99+JpDAgazeQFjWW7O/L0GA=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=cCy2w5RUvOok2fwuPdctDZWivURWfjDGCkiWyo+TsRY63SG7tgfXyYct2tXlVGS6W
         IWcW1Z+olsy9nR3Ath5qzuKMZEVXWq5PtHdWC4sj9WWKMGhjQwDVTTm81QJ36GSmGJ
         GowtTK7W3mEcpDkDu7WdU2SIdO6VVdF+QzXbtRYM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180618131734eucas1p1baab0ee7c436a3c1489128591da76a8e~5Q5TLDFEm3050130501eucas1p1J;
        Mon, 18 Jun 2018 13:17:34 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.D0.17380.EE0B72B5; Mon, 18
        Jun 2018 14:17:34 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20180618131733eucas1p1351a8d5eecdfde1008e1b753eb9ade21~5Q5SUWbnP3050130501eucas1p1H;
        Mon, 18 Jun 2018 13:17:33 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180618131733eusmtrp2abe29e8769a24bafd79325bcd812a67f~5Q5SEaibE1360813608eusmtrp2O;
        Mon, 18 Jun 2018 13:17:33 +0000 (GMT)
X-AuditID: cbfec7f4-713ff700000043e4-c5-5b27b0ee05d5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 4A.0F.04183.DE0B72B5; Mon, 18
        Jun 2018 14:17:33 +0100 (BST)
Received: from [106.120.51.25] (unknown [106.120.51.25]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180618131733eusmtip2b6d24ad8a84e6122a5e554537e9e4d8a~5Q5Rv8D-J1841918419eusmtip2j;
        Mon, 18 Jun 2018 13:17:33 +0000 (GMT)
Subject: Re: [PATCH v2] regulator: core: Enable voltage balancing
To:     Tony Lindgren <tony@atomide.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        Carlos Hernandez <ceh@ti.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
From:   Maciej Purski <m.purski@samsung.com>
Date:   Mon, 18 Jun 2018 15:17:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180615112916.GK112168@atomide.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJKsWRmVeSWpSXmKPExsWy7djP87rvNqhHG3TdlrKY+vAJm8W+vt9s
        FpseX2O1uLxrDpvF7CX9LBZrj9xlt9h/xcuB3ePb10ksHptWdbJ5bF5S79G3ZRWjx/Eb25k8
        Pm+SC2CL4rJJSc3JLEst0rdL4MqY/ucZW8FZ3opT/2cwNTD+5upi5OCQEDCRaFxm2sXIxSEk
        sIJR4uGL7ywQzhdGiS/vLzBDOJ8ZJf7s2s3YxcgJ1jHpcCs7RGI5UNXFf6wgCSGBt4wShz8Y
        gNjCAo4SV+/PYQRZISKgInH3pT1ImFngMqPEpnfBIGE2AS2JNe3xICaLgKrEmz+iIBWiAhES
        C6c+BdvEKyAocXLmExYQm1PASOLWibNMEFPEJW49mQ9ly0tsfzsH7EwJgV3sEnuOzGWGaC6T
        2LrtByvEyS4SX278Z4GwhSVeHd/CDmHLSPzfCTFIQqBaYuXL5SwQgxqA3rp7mRkiYS1x+PhF
        VpBDmQU0Jdbv0ocIO0ocadnOCglEPokbbwUh7uGTmLRtOjNEmFeio00IolpJ4sWMv1CbJCSW
        nnzEOoFRaRaSL2ch+WwWks9mIexdwMiyilE8tbQ4Nz212CgvtVyvODG3uDQvXS85P3cTIzAB
        nf53/MsOxl1/kg4xCnAwKvHwaqxXjxZiTSwrrsw9xCjBwawkwluzEijEm5JYWZValB9fVJqT
        WnyIUZqDRUmcN06jLkpIID2xJDU7NbUgtQgmy8TBKdXAKL7nR+KGxxN3WLE7fiioDqxtvrZq
        QYLA/JQTf7PvRXzMb4/J9nDa8NmzxLRxwoGPx/6WPVefkn1iJoul3OXIRttKqb93jNfWOre9
        0mwTe9dqV/fYpU67V/Yaj7Li2d0Govkrpy/yOyXe/tRjN3cX22IlRbGUNx1z2xVsWHx9PknI
        XlQ93btRiaU4I9FQi7moOBEAd4G5HzwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsVy+t/xe7pvN6hHG7ybr2Ix9eETNot9fb/Z
        LDY9vsZqcXnXHDaL2Uv6WSzWHrnLbrH/ipcDu8e3r5NYPDat6mTz2Lyk3qNvyypGj+M3tjN5
        fN4kF8AWpWdTlF9akqqQkV9cYqsUbWhhpGdoaaFnZGKpZ2hsHmtlZKqkb2eTkpqTWZZapG+X
        oJcx/c8ztoKzvBWn/s9gamD8zdXFyMkhIWAiMelwK3sXIxeHkMBSRomFH2exQyQkJM7e/88K
        YQtL/LnWxQZR9JpR4tbpF4wgCWEBR4mr9+cA2RwcIgIqEndf2oPUMAtcZpQ41XifCaLhKaPE
        6kXH2EGK2AS0JNa0x4P08grYSTxdsZkNJMwioCrx5o8oSFhUIEKic+V8FogSQYmTM5+A2ZwC
        RhK3TpxlArGZBcwk5m1+yAxhi0vcejIfKi4vsf3tHOYJjEKzkLTPQtIyC0nLLCQtCxhZVjGK
        pJYW56bnFhvpFSfmFpfmpesl5+duYgRG3rZjP7fsYOx6F3yIUYCDUYmH90GfWrQQa2JZcWXu
        IUYJDmYlEd6alerRQrwpiZVVqUX58UWlOanFhxhNgX6byCwlmpwPTAp5JfGGpobmFpaG5sbm
        xmYWSuK85w0qo4QE0hNLUrNTUwtSi2D6mDg4pRoYU39NSdm1aMLely6n85sqdluay33reF09
        xeJV3az4iXnbL3uf31KwxboxOaGgzkjzQFz0rfuLm9JMAg5LTl/uYddySJIlp6OK60HXG4GI
        NJtzt8tDXlRLH7XJKp2Y9/HtV8upUy7zN9bVq238FRe9M63Iyki/ekJQ18WXVnt161dOD/m5
        eusdJZbijERDLeai4kQAgNKyaNICAAA=
Message-Id: <20180618131733eucas1p1351a8d5eecdfde1008e1b753eb9ade21~5Q5SUWbnP3050130501eucas1p1H@eucas1p1.samsung.com>
X-CMS-MailID: 20180618131733eucas1p1351a8d5eecdfde1008e1b753eb9ade21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d
References: <20180605044554.GC5738@atomide.com>
        <CGME20180613103622eucas1p1778ba2c2e5dd85ccb4c488bd0a38386d@eucas1p1.samsung.com>
        <1528886026-9457-1-git-send-email-m.purski@samsung.com>
        <20180615112916.GK112168@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/15/2018 01:29 PM, Tony Lindgren wrote:
> Hi,
> 
> * Maciej Purski <m.purski@samsung.com> [180613 10:39]:
>> Call regulator_balance_voltage() instead of set_voltage_rdev()
>> in set_voltage_unlocked() and in enabling and disabling functions,
>> but only if the regulator is coupled.
>>
>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>
>> ---
>> Changes in v2:
>> - fix compile errors
>> - make debug messages more informative
> 
> Thanks for updating it. This series still hangs after loading
> modules on beagleboard-x15:
> 
> [   26.679749] smps12: regulator_set_voltage: 3381
> [   26.684529] smps12: regulator_set_voltage_unlocked:  3045
> [   26.695616] smps12: _regulator_do_set_voltage: 2912
> [   26.701275] smps12: regulator_set_voltage: 3381
> [   26.706002] smps12: regulator_set_voltage_unlocked:  3045
> [   26.712349] smps12: _regulator_do_set_voltage: 2912
> [   26.719329] abb_mpu: regulator_set_voltage: 3381
> [   26.724105] abb_mpu: regulator_set_voltage_unlocked:  3045
> 
> So it seems to be the abb_mpu where it hangs?
> 
> Regards,
> 
> Tony
> 

Hi,

thanks for testing. Yes, it seems that it fails on abb_mpu. I don't know
yet, what is so special about that regulator.

We know at least, that it fails on voltage setting somewhere
between set_voltage_unlocked() and do_set_voltage()
and it does not look like any locking issue.
The most suspicious part in voltage balancing code is of course the
infinite loop. Soon I'll send a next patch on top of my latest compiling
path:
2ff49a6 regulator: core: Enable voltage balancing.
It should reveal, if it is indeed the loop.

As usual, I'd be grateful, if you gave it a try.

Best regards,

Maciej Purski
