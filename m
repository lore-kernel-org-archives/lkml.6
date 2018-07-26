Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60D6C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C72A2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 14:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QW3VQtRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C72A2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731273AbeGZPwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 11:52:05 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:40809 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729923AbeGZPwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 11:52:05 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180726143455euoutp01cad51788aaa858d4d7da29a0596bb714~E8drPHWnN1765617656euoutp01B;
        Thu, 26 Jul 2018 14:34:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180726143455euoutp01cad51788aaa858d4d7da29a0596bb714~E8drPHWnN1765617656euoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1532615695;
        bh=YmR3C4vh2L8Q6PFGq13UgDypEQcunQpHR905biFEyLc=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=QW3VQtRYn7A+kk888us2QHOWlXi4cQPZ5q41TCe+6c8SzYZlKEUEDCmlUtAn36GAt
         TpBc3HnOg69CQH1Nh7hlJzaMi2Pk+giqunxVFfmPVwyAcDXg7xp6RIUXM6ve/ZpY7F
         ur7FBVgvS/RUJ5ZVvug0n18lI9pnaesjRZDwnKsE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180726143454eucas1p27fe2de26588295c5dcbc802db371a5ef~E8dqzldp51246512465eucas1p2E;
        Thu, 26 Jul 2018 14:34:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.3C.61560.E0CD95B5; Thu, 26
        Jul 2018 15:34:54 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180726143454eucas1p202f3b7d108ecc9130480d3d493c4c3fb~E8dqI7E653149531495eucas1p2J;
        Thu, 26 Jul 2018 14:34:54 +0000 (GMT)
X-AuditID: cbfec7f5-207ff7000002f078-8e-5b59dc0ed81e
Received: from eusync4.samsung.com ( [203.254.199.214]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5B.23.04183.D0CD95B5; Thu, 26
        Jul 2018 15:34:53 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync4.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PCH003AS9U5Z590@eusync4.samsung.com>; Thu, 26 Jul
        2018 15:34:53 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     bai <baijiaju1990@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [BUG] video: fbdev: broadsheetfb: Possible null function
 pointers
Date:   Thu, 26 Jul 2018 16:34:53 +0200
Message-id: <2568790.PcaMMF1rzM@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7djPc7p8dyKjDY59k7VYN3Ehk8WVr+/Z
        LE70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj/tnfzAWn2CsW
        fT/P3sD4lrWLkZNDQsBE4v6/icxdjFwcQgIrGCWaL/yGcj4zSmy4vBWoigOsavJdH4j4MkaJ
        dava2CCc34wSe45cYgcZxSZgJTGxfRUjiC0ioCDRvOYuC4jNLJAgcXrRPTBbWCBA4u/OJjYQ
        m0VAVWL/xGdgvbwCmhJHu+eB1YgKeEls2dfOBGJzCthKvLn9lAWiRlDix+R7UDPlJfbtn8oK
        YetInD22jhHkIAmBGWwS25++Zof4zUVi2pZGqD+FJV4d3wIVl5G4PLmbBaJhOqPEm19LoZz1
        jBJrzhxjgqiyljh8/CLUCj6JSdumM0PCgleio00IosRDorV3PzS8JjBKXLlwh3kCo8wsJNfO
        QnLtLCTXLmBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iREY4af/Hf+6g3Hfn6RDjAIc
        jEo8vBdmRkQLsSaWFVfmHmKU4GBWEuFdcz0yWog3JbGyKrUoP76oNCe1+BCjNAeLkjivtA9Q
        tUB6YklqdmpqQWoRTJaJg1OqgdFhsvObKeErDv8qsb2Us+7+r9V7V3kdjiifKDR7epT5jG2s
        fkJzRS6xcPFXCZxPK6rj27HZcvLjfzue33fR+m4856GehEHb9aAFAt3OzxerO2wVDUjMSNvM
        HN2j++psZ4T/D6Z74Uynj1z+dnTa9Rf+TJLhomrsk3N6UgOObfk7S+HTu7WPJz9SYinOSDTU
        Yi4qTgQATDoJN+wCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t/xa7q8dyKjDabPMbVYN3Ehk8WVr+/Z
        LE70fWC1uLxrDpsDi8fOWXfZPe53H2fy+LxJLoA5issmJTUnsyy1SN8ugSvj/tnfzAWn2CsW
        fT/P3sD4lrWLkYNDQsBEYvJdny5GLg4hgSWMEtfef2eHcP4ySiz708fcxcjJwSZgJTGxfRUj
        iC0ioCDRvOYuC0gzs0CCxLN5KSCmsICfxOV3eSAVLAKqEvsnPmMHsXkFNCWOds9jAbFFBbwk
        tuxrZwKxOQVsJd7cfsoCsWoSo8S3V1tYIBoEJX5MvgdmMwvIS+zbP5UVwtaSWL/zONMERv5Z
        SMpmISmbhaRsASPzKkaR1NLi3PTcYiO94sTc4tK8dL3k/NxNjMCw3Hbs55YdjF3vgg8xCnAw
        KvHwXpgZES3EmlhWXJl7iFGCg1lJhHfN9choId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rznDSqj
        hATSE0tSs1NTC1KLYLJMHJxSDYw+97Vdrh1d4Lzif7JP6rrNVXXHOlrXCNeHPC9we5K35P48
        69McsitqZ3hV7dbn3rlEr/mG3OUH158d72GemnVmoptaYdbyx5GKnasCHIR1Iss0UvOv3eto
        Efwd/u4U65TEKrmAFol3UbPkXk6dYXAu+eo0qQD+G0HaDyQv5V5f/SbSydlsKbcSS3FGoqEW
        c1FxIgDEmeqJRwIAAA==
X-CMS-MailID: 20180726143454eucas1p202f3b7d108ecc9130480d3d493c4c3fb
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc
References: <CGME20180726141748epcas1p28f6f11fea0152ed22113351e3a0affbc@epcas1p2.samsung.com>
        <cb43741a-83af-0b55-f53b-489bf7cb8b61@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 26, 2018 10:17:44 PM bai wrote:
> In Linux-4.16, drivers/video/fbdev/broadsheetfb.c,
> 
> 158. static void broadsheet_mmio_send_cmdargs(...) {
>              ......
> 163.     par->board->mmio_write(...);
>              ......
> 166.     par->board->mmio_write(...);
> 167. }
> 
> For x86 kernel configuration, I find that there is no assignment of the 
> function pointer ".mmio_write" in the kernel code.
> So calling the function pointer in lines 163 and 166 may cause a null 
> pointer dereference.
> 
> In this file, there are many calls to this function pointer...

This is a platform driver and it won't be used on x86 (actually it is
used only by single ARM PXA board). The dependency for FB_BROADSHEET
in Kconfig file could be improved to i.e.

	depends on FB && (ARCH_PXA || COMPILE_TEST)

but there is no bug there.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

