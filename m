Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A54C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B24720BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 02:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IfTb8/AP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B24720BF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391329AbeGLCmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 22:42:13 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:38579 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387702AbeGLCmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 22:42:13 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20180712023455epoutp027a878d480591d1949bf1ae98bf2497bd~AfnC2bBuo0582905829epoutp02G
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 02:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180712023455epoutp027a878d480591d1949bf1ae98bf2497bd~AfnC2bBuo0582905829epoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1531362895;
        bh=7SPeKx6yKazf5wQmkmGwV+PB5vrLy9iBCdkPJYZWDUU=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IfTb8/AP6zl94i47n+FsDLZFBn3pvUjCaQJHBDEM//lg5Pgx0B/1ByXrxrsiABSbO
         lsPqWjyCyFtjnBN6idfNjZhFO/8+8ZsbSzhtjMzNKzxpU9w15keo/ecGPyXv2PIIzR
         YuiAQqJ7uvDU1L/tuUENBXhhWFZwSAt6Ju3nDYzw=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.157]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180712023452epcas1p180587bc97cdcb9b0e74d8dbf62d6a678~Afm-Vyxvb0754607546epcas1p10;
        Thu, 12 Jul 2018 02:34:52 +0000 (GMT)
X-AuditID: b6c32a38-bd9359c0000010f7-f1-5b46be454829
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.C0.04343.54EB64B5; Thu, 12 Jul 2018 11:34:45 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: Re: devfreq relation with pm qos
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     noman pouigt <variksla@gmail.com>
CC:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20180712023444epcms1p8cb202bb977fcb2b365bc334f87244d04@epcms1p8>
Date:   Thu, 12 Jul 2018 11:34:44 +0900
X-CMS-MailID: 20180712023444epcms1p8cb202bb977fcb2b365bc334f87244d04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFKsWRmVeSWpSXmKPExsWy7bCmvq7rPrdog/tdAhYvD2lanG16w25x
        edccNovPvUcYLV7N7GRyYPXYOesuu0ffllWMHp83yQUwR6XaZKQmpqQWKaTmJeenZOal2yp5
        B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gBtVFIoS8wpBQoFJBYXK+nb2RTll5akKmTk
        F5fYKkUbGhrpGRqY6xkZAWnjWCsjU6CShNSMLfuPsxV0c1Z8m/aftYFxFkcXIyeHhICJxJ7l
        x9m6GLk4hAR2MEo8/PSDtYuRg4NXQFDi7w5hkBphAUOJExMvMYLYQgJKEg039zFDxPUlOh5s
        A4uzCehKbN1wlwXEFhFQlVi84Qk7yExmgeWMEs++tTFCLOOVmNH+lAXClpbYvnwrWJxTIFDi
        zdmnrBBxUYmbq9+yw9jvj82H6hWRaL13lhnCFpR48HM3VFxK4snbhVD19RLXPy9iAlksITCB
        UeL3jf9QCX2JR1dms4HYvAK+EmdXHQaLswBd+v3dI6gaF4k5ayEGMQtoSyxb+JoZFBDMApoS
        63fpw9zfsPE3OzqbWYBP4t3XHlaY+I55T5ggbDWJQ7uXQNXLSJyevhDqfg+JHc2nWScwKs5C
        BPUsJItnISxewMi8ilEstaA4Nz212LDARK84Mbe4NC9dLzk/dxMjON1pWexg3HPO5xCjAAej
        Eg8vB7dbtBBrYllxZe4hRgkOZiUR3ktTgEK8KYmVValF+fFFpTmpxYcYTYH+n8gsJZqcD0zF
        eSXxhqZGxsbGFiaGZqaGhkrivD2nXaOFBNITS1KzU1MLUotg+pg4OKUaGMMTDYQmqn4unify
        MUToyKkD2lHWIhL25ms0J7ducprUEBr9Jzpxh9Au1U06zB7sTc3tu47O6FkdUdbwsk579anr
        /imv582aoabYp2sb+G7VBUEpP9XDl7OUv82q+/6XecHC7ui3kcoJ5ibOXzcWs0kHikbver5L
        XdZvXsuf/okcf7yaTA0YlFiKMxINtZiLihMBYtnvXY0DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73
References: <CAES_P+-=iictJKgHFGN2Mypp_+GMyTOVmZVQw=bSfHbyZMY4QA@mail.gmail.com>
        <CAES_P+_k=fz3yMnVZni2hEnfSujctnT33zoN9-KsBLBeQaG_sA@mail.gmail.com>
        <CAES_P+_GTRcFya=N20+b+U=HOpv9gcpYkfJW_gU_i_2pH2hmMA@mail.gmail.com>
        <20180710055847epcms1p2eed3f89ae0220a06051faa83cc8b21ed@epcms1p2>
        <CGME20180709213456epcas4p17e5753d1b59856a0df3790d7faef8d73@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>MyungJo, I am trying to understand the relationship of PM QOS with
>devfreq drivers. I don't see any relation of PM QOS api's with devfreq dri=
vers
>directly as there are no QOS apis used in the devfreq framework.
>
>The only explanation I have is that PM QOS has direct relationship
>with CPUFREQ driver and as CPUFREQ driver works with CPU
>frequency and that CPU frequency directly affects DEVFREQ drivers
>as devfreq driver maps CPU frequency to device frequency and
>that is why PM QOS doesn=E2=80=99t=20have=20direct=20relation=20with=20PM=
=20QOS.=0D=0A>=0D=0A>Is=20my=20understanding=20right?=0D=0A=0D=0AYour=20und=
erstanding=20on=20the=20fact=20that=20there=20is=20no=20relation=20between=
=0D=0APM=20QOS=20and=20Devfreq=20framework=20of=20today's=20code=20is=20cor=
rect.=0D=0A=0D=0AThe=20reason=20on=20why=20so=20is=20not.=0D=0AIn=20general=
,=20you=20don't=20make=20a=20peripheral=20device=20be=20directly=20throttle=
d=0D=0Aby=20CPUFreq=20values.=20There=20exist=20such=20cases,=20but=20they=
=20are=20not=0D=0A=22general=22=20or=20inherit=20characteristics=20of=20per=
ipheral=20devices.=0D=0A=0D=0ACheers,=0D=0AMyungJoo.=0D=0A
