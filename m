Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CFEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2746320881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 05:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RJMuWC3T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2746320881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeGJF67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 01:58:59 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:36538 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbeGJF6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 01:58:55 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20180710055853epoutp03cb3132c3f69975c82bcec1d8e31cf5c1~-7GjqQopJ0143101431epoutp03r
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 05:58:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180710055853epoutp03cb3132c3f69975c82bcec1d8e31cf5c1~-7GjqQopJ0143101431epoutp03r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531202333;
        bh=NQDe6O/0Xu2uKfP/A1Nozq3SMPczSAliokLuUJCiMQ0=;
        h=Subject:Reply-To:From:To:In-Reply-To:Date:References:From;
        b=RJMuWC3TftvCILTCWYifKfkYDYdxgYRN1ESrtsv0pZJ17ZnqArZJsdgQGEVKhaMc4
         fQqpMEUHSvms4Q75zW8CEngbWqlpjYgCNtRDxfbD5b0XuoEmECTA8cz6VviKwGQXJm
         2ozn+2bCuiomA8x2gn5XcoU1+7Ud6ZIzZs5lQW90=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.156]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180710055849epcas1p1fb50ff2b9b0262f9bc55caec045048b9~-7GgBFDFn0373703737epcas1p1K;
        Tue, 10 Jul 2018 05:58:49 +0000 (GMT)
X-AuditID: b6c32a38-773ff700000010f7-41-5b444b172d79
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        8C.1D.04343.71B444B5; Tue, 10 Jul 2018 14:58:47 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: devfreq relation with pm qos
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     noman pouigt <variksla@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
Date:   Tue, 10 Jul 2018 14:58:47 +0900
X-CMS-MailID: 20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmrq64t0u0wYO7VhYvD2lanG16w25x
        edccNovPvUcYLV7N7GRyYPXYOesuu0ffllWMHp83yQUwR6XaZKQmpqQWKaTmJeenZOal2yp5
        B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZAWnjWCsjU6CShNSMfXcPsRf0c1TMePWFvYFxO1sXIyeHhICJxLeH
        qxm7GLk4hAR2MEp8fXiOqYuRg4NXQFDi7w5hkBphAV2JRWfngNULCShJNNzcxwwR15foeLCN
        EcRmA6rZuuEuC8gcEYFTjBLzl11igljAKzGj/SkLhC0tsX35VkaQ+ZwCgRLNX6sgwqISN1e/
        ZYex3x+bzwhhi0i03jvLDGELSjz4uRsqLiXx5O1CqPp6ieufFzGB7JUQmMAo8fvGf6iEvsSj
        K7PZIH7xlbjZxg1isgioSux/ogxR4SIx8WAXWDWzgLzE9rdzmEFKmAU0Jdbv0oc5vmHjb3Z0
        NrMAn8S7rz2sMPEd855APasmcWj3Eqh6GYnT0xdCXe8hsaP5NCsklO8zSixp+sk2gVFhFiKg
        ZyG5YhbCFQsYmVcxiqUWFOempxYbFpjoFSfmFpfmpesl5+duYgSnOi2LHYx7zvkcYhTgYFTi
        4d2Q6hwtxJpYVlyZe4hRgoNZSYTXIAcoxJuSWFmVWpQfX1Sak1p8iNEUGBYTmaVEk/OBaTiv
        JN7Q1MjY2NjCxNDM1NBQSZy34qZAtJBAemJJanZqakFqEUwfEwenVANjTIjh1ccc10Iia/y3
        Tv3Su+Gq7lQOzdQF3/Z07DRlP/hWwXPK0oNBJUYR0kzm6gp3oy5s+bL+yeatLivdj/9V3WTN
        lrHPdb7ud7HTJ+9xWzC/X/XjSf6C77FX9naG8ztxyz1t5Nmadk9+VpFHc9O6OyF/THlOr9Rd
        13AvYs6RtJO6vsded4eKKLEUZyQaajEXFScCACjSxVyLAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73
References: <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com>
        <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
        <CGME20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73@epcms1p2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> + dev freq maintainters.
> 
> On Mon, Jul 9, 2018 at 3:37 AM, noman pouigt <variksla@gmail.com> wrote:
> > folks,
> >
> > I am trying to figure out the relationship between PM QOS
> > with devfreq framework. I see this thread[1] where MyungJoo
> > talks about QOS and devfreq but that control is through
> > sysfs but I don't see any relation of pm qos (kernel/power/qos.c)
> > with devfreq directly as devfreq is not calling any of the QOS
> > api's. Is this intended?
> >
> > Isn't QOS value update using pm_qos_update_request has a
> > direct relation with devfreq drivers i.e. setting the value to
> > high or low selects the corresponding voltage and frequency
> > setting in devfreq framework? I went through the devfreq
> > drivers and couldn't find that relationship. Is this by design or
> > I am missing something very obvious?
> >
> > [1] https://lwn.net/Articles/484161/

Hello,

Unfortunately, the suggested concept in the referred article was not ever
accepted in the mainline.

Cheers,
MyungJo
