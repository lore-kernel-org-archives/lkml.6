Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D74C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DE9920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="imK2xbSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE9920874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388470AbeGXQZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:25:44 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44760 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXQZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:25:44 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724151845euoutp026cefd2b70ccbfebcf1d6e659b9e8d5cd~EVxYFYFit2016020160euoutp02K;
        Tue, 24 Jul 2018 15:18:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724151845euoutp026cefd2b70ccbfebcf1d6e659b9e8d5cd~EVxYFYFit2016020160euoutp02K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532445525;
        bh=aNNKrpghZ63dH4BbD6z+Xoql7h8p3/7h6FBHqsP+yM0=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=imK2xbSnwIkr4xYsNaMASQuwoiMISFlViQIXKYsiHpQFqTvvZAG1A2AX0REcrvzaY
         UtkZ0vgGL4+EomqBJYg0foaLJITEAXk4ykW+I3EI6A/lhJ7PeqPziYwDrfQNcLO2Gn
         nRpR9Cj7y4qNrojWV4+YVZymLvsEocQjEliBRTbI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724151844eucas1p1f2f5dfeda7c5c93e36942fbd1ff6c732~EVxXbsMhE1894318943eucas1p1q;
        Tue, 24 Jul 2018 15:18:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 6C.65.61560.453475B5; Tue, 24
        Jul 2018 16:18:44 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724151843eucas1p15070fb6d107c9521b14b992651e0b308~EVxWwCrVn0217902179eucas1p1b;
        Tue, 24 Jul 2018 15:18:43 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-dc-5b57435498f4
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F9.37.04178.353475B5; Tue, 24
        Jul 2018 16:18:43 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00K2VMJ7W790@eusync4.samsung.com>; Tue, 24 Jul
        2018 16:18:43 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Yisheng Xie <ysxie@foxmail.com>
Cc:     keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com, andriy.shevchenko@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 fbdev-for-next 2/2] fbdev: fix typo in comment
Date:   Tue, 24 Jul 2018 17:18:43 +0200
Message-id: <1602185.kBaRQmmtAZ@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1530343848-4344-1-git-send-email-ysxie@foxmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7djPc7ohzuHRBkdXCVr0Nk1nsljUIGZx
        5et7NovXR5pYLc5051qc6PvAanF51xw2i/O7Eh04PGY3XGTxWNBzntlj56y77B6f+k+yesw7
        Gehxv/s4k8fnTXIB7FFcNimpOZllqUX6dglcGa9/VxesYqro3hHTwPiBsYuRk0NCwERiZ/8R
        li5GLg4hgRWMElen/GSHcD4zSjy5uooNpmrVj6esEIlljBLbnn1ng3B+M0qcmH2bCaSKTcBK
        YmL7KrC5IgLKEpcm3QMrYhY4zSixdVsXO0hCWMBVYt/cP2A2i4CqxM5ds5hBbF4BTYndX5eC
        rRMV8JLYsq8dbCingKPEo7NvWCBqBCV+TL4HZjMLyEvs2z+VFcLWkTh7bB0jyDIJgRNsEsub
        F7JC3O0icWB/A5QtLPHq+BZ2CFtGorPjIBNEw3RGiTe/lrJAOOsZJdacOcYEUWUtcfj4RagV
        fBKTtk0HOpUDKM4r0dEmBFHiIfFheisTJCymMErsWt3GOIFRZhaSa2chuXYWkmsXMDKvYhRP
        LS3OTU8tNs5LLdcrTswtLs1L10vOz93ECEwUp/8d/7qDcd+fpEOMAhyMSjy8H+zCo4VYE8uK
        K3MPMUpwMCuJ8C4SBQrxpiRWVqUW5ccXleakFh9ilOZgURLnjdOoixISSE8sSc1OTS1ILYLJ
        MnFwSjUwKk6c2hoi8v9jlaPrxMTI+5tVFslmp1cqlfnLqPvV/65QLbqjWm163P5fiUnifI/3
        vE21+fEyJ85qXwiWlc8Jb3muMKFx4oGV7z9s+xAU9Usv64CawHrpqysWfPDjP/Xg1oVfYTJV
        rBv2t/jI88nOstn+V8GlconE4fZocb9+9m9Kl8pXlVQpsRRnJBpqMRcVJwIA9uj6CRADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xa7rBzuHRBnOOq1j0Nk1nsljUIGZx
        5et7NovXR5pYLc5051qc6PvAanF51xw2i/O7Eh04PGY3XGTxWNBzntlj56y77B6f+k+yesw7
        Gehxv/s4k8fnTXIB7FFcNimpOZllqUX6dglcGa9/VxesYqro3hHTwPiBsYuRk0NCwERi1Y+n
        rF2MXBxCAksYJY72XGWEcP4ySvw7OIEVpIpNwEpiYvsqsA4RAWWJS5PusYEUMQucZpS4P6mR
        DSQhLOAqsW/uH3YQm0VAVWLnrlnMIDavgKbE7q9LwWpEBbwktuxrZwKxOQUcJR6dfcMCsW0a
        o8TmN72sEA2CEj8m32MBsZkF5CX27Z/KCmFrSazfeZxpAiP/LCRls5CUzUJStoCReRWjSGpp
        cW56brGhXnFibnFpXrpecn7uJkZgiG879nPzDsZLG4MPMQpwMCrx8Ho4hkcLsSaWFVfmHmKU
        4GBWEuFdJAoU4k1JrKxKLcqPLyrNSS0+xCjNwaIkznveoDJKSCA9sSQ1OzW1ILUIJsvEwSnV
        wDgluP9YTN+txKVCC3U/cusc/3fF7Ms6XS5JZuHzvH27HRNeWqt4ua3eGeH/aIPLH7PdD40F
        qq5Pf/dqVS1T51KHu6fPTr4cukjNzVfAoG/vwsLY+/nuv5oaD24zcT0U+8Ly70e9Qx+bXzzs
        X7Y77MWFJzc/fFU6cOnO2/Od87Zu/9Z9gJ/pzo5wJZbijERDLeai4kQAXY5Z3m0CAAA=
X-CMS-MailID: 20180724151843eucas1p15070fb6d107c9521b14b992651e0b308
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180630073100epcas3p3825d4952b345f9850c4c45ece19a5d59
References: <CGME20180630073100epcas3p3825d4952b345f9850c4c45ece19a5d59@epcas3p3.samsung.com>
        <1530343848-4344-1-git-send-email-ysxie@foxmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 30, 2018 03:30:48 PM Yisheng Xie wrote:
> change beeng to being and occured to occurred.
> 
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

