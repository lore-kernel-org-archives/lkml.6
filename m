Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9675CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC5242C8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Wer8BNgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EBC5242C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbeGDNyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:54:46 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:36637 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751735AbeGDNyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:54:43 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180704135441euoutp01b87071b1cb0f387115ea583b288813cc~_LuRClUFF1982819828euoutp01d;
        Wed,  4 Jul 2018 13:54:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180704135441euoutp01b87071b1cb0f387115ea583b288813cc~_LuRClUFF1982819828euoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530712481;
        bh=bXgnp82V/A4kjNw5ZZqIDLbjb3FBoedQGc557nRpdcs=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Wer8BNgA5xW7Y63dsx2WpHOVXSDS2Gf8JDGt97/0GZQtcBCSOmoSkwM8U+Ly2b+JV
         uaSZKfjvDuIITxxuJV1DdRycaQlFy9sMrPEhgub0h6hppM6y2qbMXCoipGRFW6LSVg
         sg+2qY3pK8IRI71Y6YsLNJdIkIG8lIsNtNnwcbso=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704135440eucas1p119b519a36bd58477f48b905969b49df5~_LuQZHcbJ0847808478eucas1p1U;
        Wed,  4 Jul 2018 13:54:40 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A8.C1.05700.0A1DC3B5; Wed,  4
        Jul 2018 14:54:40 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180704135439eucas1p15aa9f097aba8d1f12ccb6e31ee6ab46b~_LuPqfBqC0407804078eucas1p1x;
        Wed,  4 Jul 2018 13:54:39 +0000 (GMT)
X-AuditID: cbfec7f2-1c1ff70000011644-2c-5b3cd1a0da53
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D6.10.04183.F91DC3B5; Wed,  4
        Jul 2018 14:54:39 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PBC00MCRHB337A0@eusync4.samsung.com>; Wed, 04 Jul
        2018 14:54:39 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Keerthy <j-keerthy@ti.com>
Cc:     Eduardo Valentin <edubezval@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thermal: ti-soc-thermal: remove dead code
Date:   Wed, 04 Jul 2018 15:54:39 +0200
Message-id: <11602194.yYghWmMIfl@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWy7djP87oLLtpEG1z6Kmgx/8o1VotT25uY
        LC7vmsNmMXtJP4vF594jjBZPHvaxObB57Jx1l91j8Z6XTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoErY/GSmUwFv/grPkwPaGC8z9PFyMkhIWAiMXf9b/YuRi4OIYEVjBLXF95mhnA+M0ps
        OHWBDaaq8ckdVojEMkaJQ++7WEASQgK/GSW2nZMCsdkErCQmtq9iBLFFBOQkpnydDlbDLLCY
        UaK/lxvEFhawk7j18SgTiM0ioCrR9fImK4jNK6AlMf3rY7C4qICXxJZ97WA2J9DMPdufsEHU
        CEr8mHwPaqa8xL79U1khbB2Js8fWMUIcuoJN4lAvE4TtIvF/zhqouLDEq+Nb2CFsGYnLk7tZ
        QJ6REJjOKPHm11IoZz2jxJozx6C6rSUOH78ItYFPYtK26cBw4QCK80p0tAlBlHhI/G5bzwIJ
        lXuMEvfuLmGbwCgzC8mxs5AcOwvJsQsYmVcxiqeWFuempxYb5qWW6xUn5haX5qXrJefnbmIE
        xv7pf8c/7WD8einpEKMAB6MSD++N0zbRQqyJZcWVuYcYJTiYlUR4qzcDhXhTEiurUovy44tK
        c1KLDzFKc7AoifPGadRFCQmkJ5akZqemFqQWwWSZODilGhh9Tr94Mk9nfdTEvu35xy5p8R7y
        2NSa+PC8ncndcA9zVqd7rxkmumVZcLjMT0g50LhRu0ejPEnaaZnlnMjXjK0GgZyy0wP/XWit
        1RWRXVMlJB2nVdQfd+5QjU7Qxz0PbtwqdHmwTF/KjcWrdqr941eMti+/T0ldpMTfFB12pO5B
        Z5DIsx8rpyixFGckGmoxFxUnAgAjxycB+QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsVy+t/xa7rzL9pEG5y7rmUx/8o1VotT25uY
        LC7vmsNmMXtJP4vF594jjBZPHvaxObB57Jx1l91j8Z6XTB7Hb2xn8vi8SS6AJYrLJiU1J7Ms
        tUjfLoErY/GSmUwFv/grPkwPaGC8z9PFyMkhIWAi0fjkDmsXIxeHkMASRom7b28yQjh/GSVu
        bXjNDlLFJmAlMbF9FSOILSIgJzHl63QWkCJmgcWMEt8W/GEFSQgL2Enc+niUCcRmEVCV6Hp5
        EyzOK6AlMf3rY7C4qICXxJZ97WA2J9DQPdufsEFs62KUuDFrPQtEg6DEj8n3wGxmAXmJffun
        skLYWhLrdx5nmsDIPwtJ2SwkZbOQlC1gZF7FKJJaWpybnltspFecmFtcmpeul5yfu4kRGLrb
        jv3csoOx613wIUYBDkYlHl6DczbRQqyJZcWVuYcYJTiYlUR4qzcDhXhTEiurUovy44tKc1KL
        DzFKc7AoifOeN6iMEhJITyxJzU5NLUgtgskycXBKNTByWs3TeNrdvPZQk4DVtRRLJ7mjtysF
        W+xNDpQlMsQHnlzqvs9yzkaNCbeW5n2c3lFnERS+UirJ979/jUhQqePOOW5HXBasneOrs1+k
        1nra0vfexcd0c7l3/zqTxlRd2SJ+dZvvySuG1RUpP7dNeNoX9tT8/V6F2xv2F16s4mPN+sqn
        HPNbKVqJpTgj0VCLuag4EQB+49KFWQIAAA==
X-CMS-MailID: 20180704135439eucas1p15aa9f097aba8d1f12ccb6e31ee6ab46b
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180704135439eucas1p15aa9f097aba8d1f12ccb6e31ee6ab46b
References: <10747698.EAsn0e6Ddm@amdc3058>
        <20180702163010.GA2380@localhost.localdomain>
        <8e1b81d0-2ae4-90aa-b079-7bc778a2f015@ti.com>
        <CGME20180704135439eucas1p15aa9f097aba8d1f12ccb6e31ee6ab46b@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 03, 2018 10:40:25 AM Keerthy wrote:
> 
> On Monday 02 July 2018 10:00 PM, Eduardo Valentin wrote:
> > Keerthy,
> > 
> > On Fri, Jun 29, 2018 at 06:10:26PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >>
> >> Hi,
> >>
> >> On Wednesday, May 02, 2018 03:20:35 PM Bartlomiej Zolnierkiewicz wrote:
> >>> Majority of this code (i.e. functions from ti-bandgap.c) has been
> >>> introduced in May 2013 by commit eb982001dbd8 ("thermal: introduce TI
> >>> SoC thermal driver"). Just remove it altogether (in case it is needed
> >>> it can be easily resurrected from git repo).
> >>>
> >>> While at it fix incorrect "not used" comments.
> >>>
> >>> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> >>> ---
> >>>  drivers/thermal/ti-soc-thermal/dra752-bandgap.h      |   68 ---
> >>>  drivers/thermal/ti-soc-thermal/dra752-thermal-data.c |   65 ---
> >>>  drivers/thermal/ti-soc-thermal/omap3-thermal-data.c  |    6 
> >>>  drivers/thermal/ti-soc-thermal/omap4-thermal-data.c  |   10 
> >>>  drivers/thermal/ti-soc-thermal/omap4xxx-bandgap.h    |   10 
> >>>  drivers/thermal/ti-soc-thermal/omap5-thermal-data.c  |   46 --
> >>>  drivers/thermal/ti-soc-thermal/omap5xxx-bandgap.h    |   41 --
> >>>  drivers/thermal/ti-soc-thermal/ti-bandgap.c          |  370 -------------------
> >>>  drivers/thermal/ti-soc-thermal/ti-bandgap.h          |   43 --
> >>>  9 files changed, 5 insertions(+), 654 deletions(-)
> >>
> >> Gentle ping.
> >>
> >> It would be great to see this patch in v4.19.
> > 
> > Any objections on this removal / cleanup?
> 
> Tested the patch on dra72-EVM.
> cpufreq cooling works well.
> 
> Tested-by: Keerthy <j-keerthy@ti.com>
> Acked-by: Keerthy <j-keerthy@ti.com>
> 
> Thanks for the clean up Bartalomiej!

Thank you for testing & ack.

Could you please also verify the driver simplification patchset:

	https://lkml.org/lkml/2018/5/14/642

?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

