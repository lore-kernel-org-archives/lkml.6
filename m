Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D6DECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E35F20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 15:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XWk5DOVN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E35F20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388434AbeGXQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 12:25:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:44699 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388330AbeGXQZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 12:25:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180724151832euoutp029df497bc873cfba5c9ca55abcd041fc1~EVxLuBehZ2016020160euoutp02E;
        Tue, 24 Jul 2018 15:18:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180724151832euoutp029df497bc873cfba5c9ca55abcd041fc1~EVxLuBehZ2016020160euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532445512;
        bh=6ygqiklBxd4WtPJ9apERY/x5j0beJ0pSncTF9gn3hMM=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=XWk5DOVN07e9XaG2Q9wQVA5E/TjlqRwDQYEL9eHyjzKmAc2WPJuHXhVNpUhau4mn6
         NGlb0IYH2kUFpIFdtj8bgCjuUJJsn8YKaepKWQjuEYi8JTYrRxkE/U8FlGGH73VXcd
         RaGJJK/gq91Z+P+XYXTwJeys1jwgo2g1lcSEAD0k=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180724151831eucas1p1f6dde42944407525c35eae8aac21758d~EVxLOuTfM1080310803eucas1p1s;
        Tue, 24 Jul 2018 15:18:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 37.65.61560.743475B5; Tue, 24
        Jul 2018 16:18:31 +0100 (BST)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180724151830eucas1p20b114f1a927e391ba85448105351cd83~EVxKo-mtt2959629596eucas1p2M;
        Tue, 24 Jul 2018 15:18:30 +0000 (GMT)
X-AuditID: cbfec7f5-634db9c00002f078-bd-5b5743474703
Received: from eusync1.samsung.com ( [203.254.199.211]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 03.37.04178.643475B5; Tue, 24
        Jul 2018 16:18:30 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync1.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCD00KSKMIUF710@eusync1.samsung.com>; Tue, 24 Jul
        2018 16:18:30 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Yisheng Xie <ysxie@foxmail.com>
Cc:     keescook@chromium.org, j.w.r.degoede@gmail.com,
        david@lechnology.com, andriy.shevchenko@linux.intel.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 fbdev-for-next 1/2] fbcon: introduce
 for_each_registered_fb() helper
Date:   Tue, 24 Jul 2018 17:18:30 +0200
Message-id: <3211840.FYfgcvebvD@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7djPc7ruzuHRBs9X8lv0Nk1nsljUIGZx
        5et7NovXR5pYLc5051qc6PvAanF51xw2i/O7Eh04PGY3XGTxWNBzntlj56y77B6f+k+yesw7
        Gehxv/s4k8fnTXIB7FFcNimpOZllqUX6dglcGT27L7AVvGGtOHcioIFxJ0sXIyeHhICJxJ/u
        q4xdjFwcQgIrGCUuL3gH5XxmlJj3YANc1acly5kgEssYJQ7eusEO4fxmlHh5/DobSBWbgJXE
        xPZVjCC2iICyxKVJ99hAipgFTjNKbN3WxQ6SEBaIlbh85RJYEYuAqsSaCwuYQGxeAU2Jdz8m
        g9WICnhJbNnXDhbnFHCUeHi4hRmiRlDix+R7YCcxC8hL7Ns/lRXC1pE4e2wd2N0SAifYJE6/
        hLhCQsBF4u3pBnYIW1ji1fEtULaMRGfHQSaIhumMEm9+LWWBcNYzSqw5c4wJospa4vDxi1Ar
        +CQmbZsOdAYHUJxXoqNNCKLEQ2JV01toWExhlHj67DTrBEaZWUiunYXk2llIrl3AyLyKUTy1
        tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMFWc/nf86w7GfX+SDjEKcDAq8fB+sAuPFmJNLCuu
        zD3EKMHBrCTCu0gUKMSbklhZlVqUH19UmpNafIhRmoNFSZw3TqMuSkggPbEkNTs1tSC1CCbL
        xMEp1cB4p4P/sfK+wCCZuez79+3Y4nKu5Y/K6pWLvL7MD40R+XBTY/X6e8v0Bf/tC+UrFrjD
        0b7/yIxOGRf/Hc6HGn+oX2VUcL5bVJLtsXLiyhMr5Ni+bjhjvdc4Id+ktLLuVLLOn+PVi94n
        3klXyvmiG/jdojv304SYAyoqRgE2xbPMRNhLnE4ouxUrsRRnJBpqMRcVJwIApZpCRBEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsVy+t/xy7puzuHRBvtXqln0Nk1nsljUIGZx
        5et7NovXR5pYLc5051qc6PvAanF51xw2i/O7Eh04PGY3XGTxWNBzntlj56y77B6f+k+yesw7
        Gehxv/s4k8fnTXIB7FFcNimpOZllqUX6dglcGT27L7AVvGGtOHcioIFxJ0sXIyeHhICJxKcl
        y5m6GLk4hASWMErcXfAQLCEk8JdR4tSsWBCbTcBKYmL7KkYQW0RAWeLSpHtsIA3MAqcZJe5P
        amQDSQgLxEpcvnIJrIhFQFVizYUFTCA2r4CmxLsfk9lBbFEBL4kt+9rB4pwCjhIPD7cwQ2ye
        xihx5fJiFogGQYkfk++B2cwC8hL79k9lhbC1JNbvPM40gZF/FpKyWUjKZiEpW8DIvIpRJLW0
        ODc9t9hQrzgxt7g0L10vOT93EyMwxLcd+7l5B+OljcGHGAU4GJV4eD0cw6OFWBPLiitzDzFK
        cDArifAuEgUK8aYkVlalFuXHF5XmpBYfYpTmYFES5z1vUBklJJCeWJKanZpakFoEk2Xi4JRq
        YJR0ulSxwia265xOwkz1iCUfsrITDv2acYpPYsL11sL/748dCwk7FOdk5+P4ZRNDjvPeYJdj
        dQZGKcsOcDBuYmyV/qMoJZZTHO01yzl/6dqj6y885StODf4YfFW2oFrtIvshw4PrDy6f9Sjc
        MD79yvI5fa/cTk735vunWlii4GT+edn/Y3fPXVNiKc5INNRiLipOBABp0qGKbQIAAA==
X-CMS-MailID: 20180724151830eucas1p20b114f1a927e391ba85448105351cd83
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180630073004epcas2p2d87aa0abbbae08dafd661c8378ba1de1
References: <CGME20180630073004epcas2p2d87aa0abbbae08dafd661c8378ba1de1@epcas2p2.samsung.com>
        <1530343789-4237-1-git-send-email-ysxie@foxmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 30, 2018 03:29:49 PM Yisheng Xie wrote:
> Following pattern is often used:
> 
>  for (i = 0; i < FB_MAX; i++) {
>         if (registered_fb[i]) {
>                 ...
>         }
>  }
> 
> Therefore, as Andy's suggestion, for_each_registered_fb() helper can
> be introduced to make the code easier to read and write by reducing
> indentation level. It also saves few lines of code in each occurrence.
> 
> This patch convert all part here at the same time.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Yisheng Xie <ysxie@foxmail.com>

Patch queued for 4.19, thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

