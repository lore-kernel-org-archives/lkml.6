Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3121DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7D2F2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 15:54:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EaJ9t8ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7D2F2086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbeJPXp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 19:45:57 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45093 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJPXp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 19:45:56 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016155450euoutp017b661d3fcc8e592be928f205b2500b8c~eIc3Qs-P60189101891euoutp01E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 15:54:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016155450euoutp017b661d3fcc8e592be928f205b2500b8c~eIc3Qs-P60189101891euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539705290;
        bh=eNNxJdzqAwGLgQ0h0k09v8JFkE50y9RoTHf/3lmL9aM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=EaJ9t8ax5tftebXV/9R53uncvNx/WZH7R52lOh8d+ji6mO4/RGuu3d4rFMCHTpmHH
         aNT2dm9LUCIKk0pmRKDyxOOjkx4mYVkTieRnOjD07j6+3Nj9dPISvSSW2tR+yhHCHE
         cJqFRzz6OGtx0LmA7/1jipVyCJXg8Hx71Y8zw630=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181016155449eucas1p10e0dd50caa34ffb41a9128b9cb9bcd87~eIc2RY1GA1503715037eucas1p1f;
        Tue, 16 Oct 2018 15:54:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 37.A8.04441.9C906CB5; Tue, 16
        Oct 2018 16:54:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016155448eucas1p26b5aaaf626771b42a2f8c54808391f43~eIc1fLmJw0976609766eucas1p2x;
        Tue, 16 Oct 2018 15:54:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181016155448eusmtrp1794bbbbdaef5fb970765a53291f02ed9~eIc1QQ0Ft2835628356eusmtrp1R;
        Tue, 16 Oct 2018 15:54:48 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-e1-5bc609c9df99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 38.70.04128.8C906CB5; Tue, 16
        Oct 2018 16:54:48 +0100 (BST)
Received: from [106.120.51.20] (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181016155447eusmtip1a7cdacbe536ad07ff32a3b35ce21199d~eIc0r-dMG1088610886eusmtip1l;
        Tue, 16 Oct 2018 15:54:47 +0000 (GMT)
Subject: Re: [PATCH 09/11] DT: arm: exynos: add support for thermal trip
 irq-mode
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?Q?Bart=c5=82omiej_=c5=bbo=c5=82nierkiewicz?= 
        <b.zolnierkie@samsung.com>, kgene@kernel.org
From:   Lukasz Luba <l.luba@partner.samsung.com>
Date:   Tue, 16 Oct 2018 17:54:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTURT1dWbaabVkLAo3oBhrMGKUSkLMJBqXxI+JHwb0x0CMVp0AgVbs
        2CqbaBRZhKpgQBtkEdzaupUGaoWgWDaNC2AKGjQiVaRaiVZwA5QyNfJ37rnnnXfOyyMxWT8R
        QiapD7AatTJFLpTg9W0/n6zsFLfFr9IPi+jb524StOteLqIrvAvpSscTgq587iToU4MfMfrp
        01si2jI4NVafqMXpHnu5kPYWORB9qbdLQOc0OUS0a0Av3BDAmCvMiLljeCViahqHBYzFmC9k
        +p2NQqauNpup0ZcQjN5qRIzXEhYjjpOs3cumJOlYjWLdLkmiYciEp46IDunbrMQRdE1YgMQk
        UNFw0TpCFCAJKaOuIpg4ZsL54RuCX+9f+zdeBMWmP6gAkdNH6s2pPH8FQYHZ6Rd5EJjGP+A+
        30BqGzScGSN8eB4VAb0T36cxRh3D4MYnhc9ISEWCzbjfR+NUOAx9OTodaT61HRxvqpEPS6m5
        0HneNW0ppmJh7HoJztsEw0tXpYDHi6DBU475MgB1lISx3Ne4z19K6cBoi+ZrbgJ3j8tfORDc
        7VYRjxfAo5JCnMccPM4z+jWZkNtp82vWwIP2LsJniU1VuWlX8PRGaP1sIfgnCYA+z1w+TQAU
        15dhPC2FvBMyXr0MrIXPBDwOgivmUtFpJDfM6GiY0cswo5fh/71VCDeiYFbLqRJYLkrNHozk
        lCpOq06I3LNPZUFTf+7RZPtXGxrt3t2CKBLJ50h/9DriZYRSx6WpWhCQmHyeNKG7NV4m3atM
        S2c1+3ZqtCks14JCSVweLL1ccTteRiUoD7DJLJvKav5tBaQ45AiKlX3pK33rPr60enRLelrO
        b1357PSB+46HKluM9uS35CT9+YPuqmdLJGczyhqlO5qz+vKbVjR+X9ydjcWdUms8mO7zTsnv
        DrJwbewn7Szt5o4L6yMUQXfdzR2GSZNwa1HMO6+zbjxLfy4j1DT/8NISLcuN2MttzYNhoavD
        7QteZMpxLlEZtRzTcMq/cMdbtG8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAIsWRmVeSWpSXmKPExsVy+t/xu7onOI9FGyw9zmexccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFpsdA7sK2JSwWl3fNYbP43HuE0WLp9YtMFq17
        j7BbPHnYx+bA57Fm3hpGj52z7rJ7LN7zkslj06pONo871/aweWxeUu+xuG8yq0ffllWMHp83
        yQVwRunZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehl
        zHq+mqXgPXtF37EtrA2MK9m6GDk4JARMJLatKehi5OQQEljKKHH0uTuILSEgJjFp33Z2CFtY
        4s+1LqByLqCa14wS07btZQVJCAsES2yf+A3MFhHQlLj+9zuYzSzQzCzxeK0hRMMlJontje1M
        IMvYBPQkdqwqBKnhFXCTuLexlRHEZhFQlXj+sZENxBYViJBYvfwFK0SNoMTJmU9YQGxOgUCJ
        b2sns0DMN5OYt/khM4QtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0t
        zk3PLTbSK07MLS7NS9dLzs/dxAiM7W3Hfm7Zwdj1LvgQowAHoxIP74/rR6KFWBPLiitzDzFK
        cDArifCmXzoaLcSbklhZlVqUH19UmpNafIjRFOi5icxSosn5wLSTVxJvaGpobmFpaG5sbmxm
        oSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBsWY+78Ppu9tYJQ0Cfokoi1St7zvwyXOZ9lPp
        dz15i25NZtv63dr0vP1Xj84y08dH9J9HT6t4FTyLcYmu6Wnnex/CAlXcUmQUc78vLbb66if8
        9eOv5dMS1sYl9H6SWcz+f9KtstU+AnHOwv5/jVj1b+t+b3AXCwwwKXGqNf/Tc/XSj7Lf72Xi
        lViKMxINtZiLihMBvRycRAMDAAA=
Message-Id: <20181016155448eucas1p26b5aaaf626771b42a2f8c54808391f43~eIc1fLmJw0976609766eucas1p2x@eucas1p2.samsung.com>
X-CMS-MailID: 20181016155448eucas1p26b5aaaf626771b42a2f8c54808391f43
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8
References: <CGME20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8@eucas1p1.samsung.com>
        <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <20181016145651eucas1p1ea84684e37e67b4161548e6cff489cb8~eHqPK-tM31616816168eucas1p1y@eucas1p1.samsung.com>
        <CAJKOXPdKoxB3aN+1y48WD9Gv2P6KvSFSiD6aCk+PimBooE3YWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/16/2018 05:13 PM, Krzysztof Kozlowski wrote:
> On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>>
>> This patch adds support for new flash which indicates
>> that trip point triggers irq when temperature is met.
>> Exynos5433 supports 8 trip point which will trigger irq.
> 
> Exynos5420? 4 trip point
Thanks, you are right. I will fix the comment in a few places.
> 
> BTW, I just noted that you skipped samsung-soc mailing list.
> 
> DTS patches always should go through arm-soc so in case of Exynos -
> linux-samsung-soc mailing list. The list should be also CC-ed if you
> touch other Exynos or Samsung related code and get_maintainers.pl
> always point it. Because you skipped it, some people might miss your
> patches and definitely Patchwork which I am using won't see them
> (https://patchwork.kernel.org/project/linux-samsung-soc/list/).
OK, I will push v2 through that list also.

Regards,
Lukasz
> 
> Best regards,
> Krzysztof
> 
> 
