Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EB9C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B259218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 06:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfAYGvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 01:51:16 -0500
Received: from mgwym04.jp.fujitsu.com ([211.128.242.43]:60493 "EHLO
        mgwym04.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbfAYGvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 01:51:16 -0500
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by mgwym04.jp.fujitsu.com with smtp
         id 15be_1ecd_8d28b7d9_ce94_40fc_8396_706fe2d132de;
        Fri, 25 Jan 2019 15:51:12 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
        by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6A1DEAC01AA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:51:11 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
        by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id D60AEBD6795;
        Fri, 25 Jan 2019 15:51:09 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0415.000; Fri, 25 Jan 2019
 15:51:09 +0900
From:   "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To:     "Zhang, Lei" <zhang.lei@jp.fujitsu.com>,
        'Mark Rutland' <mark.rutland@arm.com>,
        "'james.morse@arm.com'" <james.morse@arm.com>
CC:     "'catalin.marinas@arm.com'" <catalin.marinas@arm.com>,
        "'will.deacon@arm.com'" <will.deacon@arm.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-arm-kernel@lists.infradead.org'" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Topic: [PATCH] arm64 memory accesses may cause undefined fault on
 Fujitsu-A64FX
Thread-Index: AdSvK6W0/Nm6810RQFa/OOuw1JbhXP//gw+A//n57fCADGG/gP/+BGiA//lIR1A=
Date:   Fri, 25 Jan 2019 06:51:08 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A6A2A6045@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A6A29FA8F@G01JPEXMBKW03>
 <20190118141758.GC12256@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A2F44@G01JPEXMBKW03>
 <20190122152339.GD52887@lakrids.cambridge.arm.com>
 <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A6A2A3BED@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-securitypolicycheck: OK by SHieldMailChecker v2.2.3
x-shieldmailcheckerpolicyversion: FJ-ISEC-20140219
x-originating-ip: [10.18.70.198]
Content-Type: text/plain; charset="iso-2022-jp"
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mark, James

> -----Original Message-----
> From: linux-arm-kernel
> [mailto:linux-arm-kernel-bounces@lists.infradead.org] On Behalf Of
> Zhang, Lei
> Sent: Wednesday, January 23, 2019 9:51 PM
> To: 'Mark Rutland'; 'james.morse@arm.com'
> Cc: 'catalin.marinas@arm.com'; 'will.deacon@arm.com';
> 'linux-kernel@vger.kernel.org';
> 'linux-arm-kernel@lists.infradead.org'; Zhang, Lei/張 雷
> Subject: RE: [PATCH] arm64 memory accesses may cause undefined fault on
> Fujitsu-A64FX
> 
> At first thanks for your comments.
> I thinks James's comments is quite similar with above comment.
> I am reviewing this point now.
> I will respond to your questions after I check this.
As your comments, this patch cannot avoid this problem
completely. So I will post a new patch to resolve this 
problem in different way.

Lei Zhang
zhang.lei@jp.fujitsu.com


