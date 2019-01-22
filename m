Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E0AC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECDD920879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 04:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IU48NjMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbfAVE6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 23:58:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:17649 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbfAVE6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 23:58:06 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190122045803epoutp025f9952285b173d1ba016423cca4f63d7~8EtYz1G_X2320223202epoutp022
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 04:58:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190122045803epoutp025f9952285b173d1ba016423cca4f63d7~8EtYz1G_X2320223202epoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548133083;
        bh=Wz/C9mqZUhcnbosLTx5NjZK4ftZE/GNkVr5eZUXqq6s=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=IU48NjMYnoj+6Exj+IsIz+wxI/HSjt9Yt9LVbAbzQhhIuQrp3JCLBURCU/3FKYRB/
         Ckyi+WRVMIyRSef6uIm5OZ+DZDKFEo/gK1REV2u7zAGs0gUvDqmbtfirC97ANhSx4H
         gJ+VxSP7UMJy7Cyt6/gv3AwhTQFhL3S4JS/Eo9EA=
Received: from epsmges1p4.samsung.com (unknown [182.195.40.158]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190122045756epcas1p257fe0acd3225188ced1c22f8208b06f2~8EtTChkpj3149731497epcas1p2Z;
        Tue, 22 Jan 2019 04:57:56 +0000 (GMT)
X-AuditID: b6c32a38-c0fff700000010c0-68-5c46a2ca04d6
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        6A.68.04288.AC2A64C5; Tue, 22 Jan 2019 13:57:46 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH] drivers: extcon: Add support for ptn5150
Reply-To: myungjoo.ham@samsung.com
From:   MyungJoo Ham <myungjoo.ham@samsung.com>
To:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190122044216.GA23297@chikyu>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190122045746epcms1p80456e6f7c5b6cd36b47f10190dd445db@epcms1p8>
Date:   Tue, 22 Jan 2019 13:57:46 +0900
X-CMS-MailID: 20190122045746epcms1p80456e6f7c5b6cd36b47f10190dd445db
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMKsWRmVeSWpSXmKPExsWy7bCmge6pRW4xBg/P61lc//Kc1eLY9YnM
        Fpd3zWGzeLl/OqsDi8f9veweO2fdZffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8dFsl
        7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygjUoKZYk5pUChgMTiYiV9O5ui/NKSVIWM
        /OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7IzD574yFvxlrfg+i6+B8SZLFyMn
        h4SAicSbTRtZuxi5OIQEdjBKTLn8iq2LkYODV0BQ4u8OYZAaYQFHiVf/jrOC2EICShINN/cx
        Q8T1JToebGMEsdkEdCW2brgLNlNEIEZiQt9SNhCbWSBHYvLyw4wQu3glZrQ/hdorLbF9+Vaw
        OKeAjsTHoz+g4qISN1e/ZYex3x+bD9UrItF67ywzhC0o8eDnbkaYOTOm/IfqrZZ41HORGeQX
        CYEWRolVM7cxQST0Jc7MPQl2EK+Ar8TvP3vAmlkEVCWe/YM5zkVidcN1qKPlJba/ncMMCgdm
        AU2J9bv0IcJ8Eu++9rDC/LJj3hOo8WoSh3YvgbpZRuL09IVQd3pITJ7YzAIJ29eMEndaZzFP
        YJSfhQjeWUi2zULYtoCReRWjWGpBcW56arFhgQlyhG5iBCc4LYsdjHvO+RxiFOBgVOLh5Tjn
        GiPEmlhWXJl7iFGCg1lJhFdwjluMEG9KYmVValF+fFFpTmrxIUZToKcnMkuJJucDk29eSbyh
        qZGxsbGFiaGZqaGhkjjvegfnGCGB9MSS1OzU1ILUIpg+Jg5OqQZGy21PninN3Svy6XHLpXRj
        pn1nYm1vNUZuvz5F4oQbv05CBk+fyMPtrBUxR1dM+Stwj+VprpTv48c7l5xjKA0/6vwh8hLr
        lLj7Nh06lsnMycEzL0/9WnP84xxZRd75zQIcH+JubVzUz3xU1ffLDJuEjbm/32x4de7/vimG
        f19otr3/93P5TmXvDUosxRmJhlrMRcWJAH1w5ByGAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190122044306epcas5p30f875260e568d5fb0e4909035060f8ff
References: <20190122044216.GA23297@chikyu>
        <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
        <201901220830.8kqj0YjW%fengguang.wu@intel.com>
        <CGME20190122044306epcas5p30f875260e568d5fb0e4909035060f8ff@epcms1p8>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi Chanwoo Choi,
>
>This is the first time I am sending a driver to LKML. I have a few doubts. Can
>you please clarify them when you are free?

Although I'm not Chanwoo, but a guy who's about 50ft away from his cubicle,
as he appears to be busy today... :)

>
>1. I have developed and tested this patch on 4.14.89 kernel. When trying to 
>mainline the driver should I rebase and send the patch on top of current tree(v5.0-rc2)?

Yes, you are supposed to be based on the most recent RC.

>
>2. Is there any specific git on which I should test this driver on? Like below?
>https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git

I'd recommend to pull torvald's master with RC tag.


Cheers,
MyungJoo

>
>Thanks,
>Vijai Kumar K
