Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D161CC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8E921EF6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="U1iUIOi1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8E921EF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbeHJKjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:39:02 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:31471 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbeHJKjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:39:01 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20180810081014epoutp015653217a7c3efc23d36453f7054335e6~Jd5FeXkwS1093810938epoutp01a
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 08:10:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180810081014epoutp015653217a7c3efc23d36453f7054335e6~Jd5FeXkwS1093810938epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533888614;
        bh=K890SNo7xi8RJ9bjHafTtGRR3EdB5tdwiDtmhaooO8k=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=U1iUIOi1WrHMG4XemCZxkf6flqwGbX5GRB5E85xrL3EdudPZF+pGXLvkdPuaDQxhi
         T9b7j9uNeNBZBOKtQ2wXH0L5hxhVMwZKm861vSiIbXtrLo5LQXZyKJOIvS3zZXY3EZ
         BRy2Me0uyfHgDBnt921bdg2SW7EVxolFyWQIm9BY=
Received: from epsmges5p3new.samsung.com (unknown [182.195.40.192]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20180810081013epcas5p349ebe343143962b07e9caa66f55c45a1~Jd5Ex1OZ12033320333epcas5p3W;
        Fri, 10 Aug 2018 08:10:13 +0000 (GMT)
X-AuditID: b6c32a4b-221ff700000010d0-ba-5b6d4865edcb
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        48.78.04304.5684D6B5; Fri, 10 Aug 2018 17:10:13 +0900 (KST)
Mime-Version: 1.0
Subject: RE: [PATCH 1/1] selftest/net: fix FILE_SIZE for 32 bit
 architecture.
Reply-To: maninder1.s@samsung.com
From:   Maninder Singh <maninder1.s@samsung.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>
CC:     "shuahkh@osg.samsung.com" <shuahkh@osg.samsung.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>,
        AMIT SAHRAWAT <a.sahrawat@samsung.com>,
        Vaneet Narang <v.narang@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <4f2c8d694dce4125a609e8d5383ebe36@AcuMS.aculab.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180810060341epcms5p4e8defed12cf0adeccd4d8d1e3c93c6b3@epcms5p4>
Date:   Fri, 10 Aug 2018 11:33:41 +0530
X-CMS-MailID: 20180810060341epcms5p4e8defed12cf0adeccd4d8d1e3c93c6b3
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLJsWRmVeSWpSXmKPExsWy7bCmpm6qR260wcdfChYXd6dazDnfwmKx
        Y+lmJounxx6xW+x7f5bNYvP3DjaLy7vmsFkcWyBmce/NViaLqV8+sFgcOjmX0YHbo3/2FDaP
        LStvMnnsnHWX3WPBplKPLf1ARt+WVYwenzfJBbBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAF2opFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        ijY0NNIzNDDXMzIC0qaxVkamQCUJqRnz/21nLDjMXLFl9S3WBsYrTF2MHBwSAiYSm3pFuxi5
        OIQEdjNKbPi+ihUkzisgKPF3h3AXIyeHsIC/xJULi5hAbCEBRYkLM9YwgpQICxhI/NqqARJm
        E9CTWLVrDwvIGBGBBkaJhw/esII4zAL9zBKrFz1mBqmSEOCVmNH+lAXClpbYvnwrI4jNKeAg
        se/XRVaIuKjEzdVv2WHs98fmM0LYIhKt985CzRGUePBzN1RcRmL15l6wzRIC7YwS2x+cYYJw
        pjBKtFy8C7XNXOL8yflg3bwCvhLfLk4E+55FQFVi81+oEheJHwd3gS1mFpCX2P52DjNICbOA
        psT6XfoQJbISU0+tY4Io4ZPo/f2ECeavHfNgbFWJlpsbWGF+/PzxI9R4D4n1t74xQQL6NZPE
        jAtH2CYwKsxChPUsJJtnIWxewMi8ilEytaA4Nz212LTAOC+1XK84Mbe4NC9dLzk/dxMjOKlq
        ee9g3HTO5xCjAAejEg8vQ2pOtBBrYllxZe4hRgkOZiUR3kzT3Ggh3pTEyqrUovz4otKc1OJD
        jKbAIJjILCWanA9M+Hkl8YamRmZmBpYGpsYWZoZK4rwf/IKjhQTSE0tSs1NTC1KLYPqYODil
        GhiTOh/undmuNedBZW7V6ua8ysDoQwuElq188u7OGxu5lNgSv483Oax2xpy9v/PxtkWxfebb
        WjvXvusufOn7d1rH1tlsb4JWnq14uDxzSxL/zHwejgvp+5ql2z9Vb3ss+FtK9s/Lrsodq253
        Lj+wRZS141jWbTuVu1Njphrnusw90DP/df7G+TstlFiKMxINtZiLihMB8Auy8MADAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0
References: <4f2c8d694dce4125a609e8d5383ebe36@AcuMS.aculab.com>
        <4a412194-99aa-7969-54a4-727368fbf82c@gmail.com>
        <20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0~HCuTv0d7l2131721317epcas5p4u@epcas5p4.samsung.com>
        <20180803033159epcms5p1dd2f5a6834268e9a22efa15421795fa0@epcms5p1>
        <CGME20180802103616epcas5p48ec1e2ea3568b11683aa7b55254dffb0@epcms5p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >
>> >What about using more conventional size_t instead of "unsigned long long" ?
>> 
>> size_t is also equivalent to unsigned long and it will not hold value of (1 << 35) for 32 bit system.
>> So we can do two things.
> 
>Wouldn't the 'correct' type be off_t ?
>In any case, IIRC, you have to do really horrid things in Linux to
>access files larger than 2G on 32bit systems.
> 
>        David

Any inputs.

Thanks,
Maninder Singh
