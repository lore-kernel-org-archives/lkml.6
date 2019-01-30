Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ED0C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:50:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC612086C
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="QpOIx62d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbfA3Que (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:50:34 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:54046 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbfA3Qud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:50:33 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 6868224E214B;
        Wed, 30 Jan 2019 08:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548867033; bh=RZPaXkmfDA4GN4ToSvsbELRA7pbqs6LZTY7fmwWmXc4=;
        h=From:To:CC:Subject:Date:References:From;
        b=QpOIx62dWEabj2uL/tA48f7+RRDsp3mgC6Za7MM8BFfuAg/xOzORKQXG82VhZD7GL
         JyXeHHgRH6pZ7glm3hb86Xj680Jvn5iFKs6dJUwv6QwgcsuyvYLv4o1HOKeRawqaMz
         n83Y/jl/yvYH0/lOWAVR6yFaroN6dAabV1/LObDDR+7MO9q1K3JBUTKxhlyvFUDtYg
         BgCwMNuRD9LWpuOS1B/Srr97s8IZibKImB+c1BzUk700C+ecXw4zuGbGyov3oisaJH
         4ZZDefjweeh/0QbzHjk7NVUzTq8M/WWXrvDKQ7/TEL4zoHp3iJAOFDoev6C1hW4f7R
         Nn/e3iSLB+uiA==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2.internal.synopsys.com [10.12.239.237])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5AF58A0091;
        Wed, 30 Jan 2019 16:50:33 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 30 Jan 2019 08:47:52 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Topic: [PATCH 2/5] ARCv2: introduce unaligned access under a Kconfig
 option
Thread-Index: AQHUt8BdV97GEf2KMUGRvvMb2YNphA==
Date:   Wed, 30 Jan 2019 16:47:52 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642D8B6@US01WEMBX2.internal.synopsys.com>
References: <20190129104942.31705-1-Eugeniy.Paltsev@synopsys.com>
 <20190129104942.31705-3-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075014642D58D@US01WEMBX2.internal.synopsys.com>
 <1548866682.29008.31.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 8:44 AM, Eugeniy Paltsev wrote:=0A=
>> I'd prefer to change the define of STATUS_AD_MASK itself and keep all of=
 this=0A=
>> unchanged !=0A=
>>=0A=
> Actually I'd prefer to leave STATUS_AD_MASK untouched. Otherwise we will =
implicitly assign=0A=
> wrong value to STATUS_AD_MASK which is quite misleading.=0A=
>=0A=
> BTW, STATUS_AD_MASK is used in ASM code in v2 patch and it shouldn't be d=
ependent on=0A=
> CONFIG_ARC_USE_UNALIGNED_MEM_ACCESS.=0A=
=0A=
Agree !=0A=
=0A=
-Vineet=0A=
