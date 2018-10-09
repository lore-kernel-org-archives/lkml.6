Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5248C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6484D21479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 07:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EWNTM6r3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6484D21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeJIPH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 11:07:27 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47497 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeJIPH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 11:07:26 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181009075147euoutp01d292a7a077d31623577e07b83cafcd61~b4WGuLJKD0306003060euoutp01l
        for <linux-kernel@vger.kernel.org>; Tue,  9 Oct 2018 07:51:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181009075147euoutp01d292a7a077d31623577e07b83cafcd61~b4WGuLJKD0306003060euoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539071507;
        bh=iBQ8W0Va1THdhv90z2R4VMSWSrZYuAcjHnr1ASe2V3k=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EWNTM6r3X2eChcYEB8Gmz2TUJ32F/jBmKAGCunFZq1fRye4ezZUwlX0r+xiG02OSh
         dWeXDyFLCm2rcJrZzuKQ4SOM7CzEfAexKm8ENMwjFrUnQCvlEuI1Pt6ICMTuxf4uan
         D+KoaxTlSnN/XlOp/1hpD0GN9rmcJ5yFwYoyZLrE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181009075146eucas1p290ec4116b8600deceee9e0c8c8331250~b4WF_aO8V0237202372eucas1p2h;
        Tue,  9 Oct 2018 07:51:46 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id FF.9C.04806.21E5CBB5; Tue,  9
        Oct 2018 08:51:46 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c;
        Tue,  9 Oct 2018 07:51:45 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181009075145eusmtrp22fcced226a7029cf6ed7a9d9a7994fbd~b4WEvMpoN1179911799eusmtrp2N;
        Tue,  9 Oct 2018 07:51:45 +0000 (GMT)
X-AuditID: cbfec7f5-367ff700000012c6-47-5bbc5e12bdd1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6C.42.04128.01E5CBB5; Tue,  9
        Oct 2018 08:51:44 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181009075144eusmtip296d8354c47cbbba05046242fe0d49f1a~b4WEL4Z_K2020720207eusmtip2U;
        Tue,  9 Oct 2018 07:51:44 +0000 (GMT)
Subject: Re: [RESEND PATCH v2 3/3] ARM: dts: imx28-cfa10036: Fix the reset
 gpio signal polarity
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     =?UTF-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Tue, 9 Oct 2018 09:51:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20181009002031.GU3587@dragon>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7pCcXuiDTr+c1jMP3KO1WLj5tss
        Fif6PrBaXN41h83i/+cnrBate4+wW7zYIu7A7rFpVSebx8Z3O5g8Pm+S83j59wNzAEsUl01K
        ak5mWWqRvl0CV8bKh5uYC86xVTw4+JqpgXE1axcjJ4eEgInE6UlrmLoYuTiEBFYwSjRub2SF
        cL4wSmxZ+hvK+cwoMeHUJXaYlvvzfzNDJJYzSlw5P4kNwnnPKNH2aDpYlbBAosScky+ZQWwR
        AWWJUxv72EGKmAWOMkm0ve5gA0mwCVhJTGxfxQhiswioSKy+sR5oHweHqECERP8ZdZAwr4Cg
        xMmZT1hAbE4BbYkX8y+AzWcWkJdo3job7AoJgUXsEm8vbmaEaCiTWHDyBNR3LhK9q0+yQNjC
        Eq+Ob4F6QUbi/875TBDN0xkl3vxaygLhrGeUWHPmGBNElbXE4eMXwS5iFtCUWL9LHyLsKDG5
        +S07SFhCgE/ixltBiIP4JCZtm84MEeaV6GgTgqhWk9iwbAMbzNqunSuZIWwPiR8PXzFOYFSc
        heTNWUhem4WwdwEj8ypG8dTS4tz01GLjvNRyveLE3OLSvHS95PzcTYzAFHP63/GvOxj3/Uk6
        xCjAwajEwzsjb3e0EGtiWXFl7iFGCQ5mJRFe0e27ooV4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        Lpu3MVpIID2xJDU7NbUgtQgmy8TBKdXA6NS84e5ZRpupx9ck/81/+LJjhjBTjkS8xM7vya8m
        XpFQ7fjgu2Mtl2IV79vrO32OfN/I0Zwze5KxS4yfzE29fwc3n2sJdbl7a16NoLOJu0j1grig
        AnedNOVWc8GZHEerfW4pf1kc0zDP7ljxN5XeLxIz5Z0vrN3x6q6SdJhsffG5v2K/Pms+VWIp
        zkg01GIuKk4EAHLWKiYtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPIsWRmVeSWpSXmKPExsVy+t/xe7oCcXuiDR6/M7eYf+Qcq8XGzbdZ
        LE70fWC1uLxrDpvF/89PWC1a9x5ht3ixRdyB3WPTqk42j43vdjB5fN4k5/Hy7wfmAJYoPZui
        /NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9O5uU1JzMstQifbsEvYyVDzcxF5xj
        q3hw8DVTA+Nq1i5GTg4JAROJ+/N/M3cxcnEICSxllJi5+T5QggMoISNxfH0ZRI2wxJ9rXWwg
        tpDAW0aJ+2sqQGxhgUSJOSdfMoPYIgLKEqc29rFDzFnNJLFtyQQ2EIdZ4CiTxIzPP9hBqtgE
        rCQmtq9iBLF5Bewk3uydC9bNIqAisfrGerCLRAUiJG497GCBqBGUODnzCZjNKaAt8WL+BbA5
        zALqEn/mXWKGsOUlmrfOZp7AKDgLScssJGWzkJQtYGRexSiSWlqcm55bbKRXnJhbXJqXrpec
        n7uJERg524793LKDsetd8CFGAQ5GJR7eGXm7o4VYE8uKK3MPMUpwMCuJ8Ipu3xUtxJuSWFmV
        WpQfX1Sak1p8iNEU6ImJzFKiyfnAqM4riTc0NTS3sDQ0NzY3NrNQEuc9b1AZJSSQnliSmp2a
        WpBaBNPHxMEp1cBYYNr8LevY8vP61TtevrQ/khgUl7nL4J/F5RU+r9QKOqLW8UT1Lz60SWTD
        5Yk3709S+HPE4WPOn8dKbzJulPvt5CzNVWC3knY+nBpSVH2wtXee2SzdW0LdKm42Hmt2xPiU
        3L59Uj1pt1pjRWJD/Bqxy3MLj3jZ9HtPvRDUdfXku8yeY389t59WYinOSDTUYi4qTgQAOB9E
        C7ICAAA=
Message-Id: <20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9~b4WFAVFkx0235802358eucas1p2c@eucas1p2.samsung.com>
X-CMS-MailID: 20181009075145eucas1p2691c7d04aa8328080af7cbc4ab5e03b9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181009002056epcas5p24207204c9e65e8f34382de6672adb993
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181009002056epcas5p24207204c9e65e8f34382de6672adb993
References: <1538040281-21319-1-git-send-email-michal.vokac@ysoft.com>
        <1538040281-21319-3-git-send-email-michal.vokac@ysoft.com>
        <68f4da21-6f0d-5bf9-b352-cdc423269080@ysoft.com>
        <CGME20181009002056epcas5p24207204c9e65e8f34382de6672adb993@epcas5p2.samsung.com>
        <20181009002031.GU3587@dragon>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/09/2018 02:20 AM, Shawn Guo wrote:
> On Mon, Oct 08, 2018 at 11:45:36AM +0000, Vokáč Michal wrote:
>> On 27.9.2018 11:24, Michal Vokáč wrote:
>>> The reset signal of the SSD1306 OLED display is actually active-low.
>>> Adapt the DT to reflect the real world.
>>>
>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>> ---
>>> v2 changes: New patch in the series
>>
>> Bartlomiej just queued the first two patches for v4.20.
>> Will somebody take this one? Otherwise this SoM will end up with
>> broken OLED display reset.
> 
> Well, it means the change breaks the ABI between kernel and device tree,
> e.g. the new kernel will not work with existing/installed DTBs.

Should I revert this sdd10307fb patch then?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
