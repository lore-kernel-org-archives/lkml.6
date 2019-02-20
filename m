Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0655EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87E621738
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 00:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="BKaqIeRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730066AbfBTAiX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 19:38:23 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:39102 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbfBTAiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 19:38:23 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id AF25024E08D3;
        Tue, 19 Feb 2019 16:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1550623102; bh=XuizeOnqPqUjNqzCAh3uN2fp/qdh6MsdZHar7HWf/M8=;
        h=From:To:CC:Subject:Date:References:From;
        b=BKaqIeRaKxaT+xCNNPxgLmEpad86v6BOBwfd8S1AbVwNnynXNtz0Z2UNU/gLutbNd
         u5baE5ZKUxNxukkjk3yEpd0fs8oru7d+Jf/cLRVFosubc6RpMHqjUyPfagkY7Vynwz
         RlrCFrUR/DFAOcQ+AqLbP4Mgfdsu4nUYmJHI8xBXLn6aK0G0EkWPlO2T5duPd1YIDR
         pzTfghwtAOVAxSycBpy+PSdiLDazSeDXBpi5XrYFLiHUvx56Vg+1V+riufPolgdKUT
         Al9NRmjdjTEnQAELL6CR6LX4/Gl3MT+ENXnq4P8TPv+uS3pupfE/2Mlz1KUxDk09cC
         KOPzar9x0TgYw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9FDC1A0090;
        Wed, 20 Feb 2019 00:38:22 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Tue, 19 Feb 2019 16:38:22 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: [plat-hsdk]: Enable AXI DW DMAC support
Thread-Topic: [PATCH] ARC: [plat-hsdk]: Enable AXI DW DMAC support
Thread-Index: AQHUyEE1rMbDb8iGXkmvh4Qg980x7A==
Date:   Wed, 20 Feb 2019 00:38:21 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA230750146435156@US01WEMBX2.internal.synopsys.com>
References: <20190219105226.20062-1-Eugeniy.Paltsev@synopsys.com>
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

On 2/19/19 2:52 AM, Eugeniy Paltsev wrote:=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
> ---=0A=
> NOTE:=0A=
>   Even if this patch have no logical dependency with gpu-enabling-patch=
=0A=
>   (http://patchwork.ozlabs.org/patch/1034722/)=0A=
>   gpu-enabling-patch should be applied first to avoid rebasing.=0A=
=0A=
Can you pester the upstream maintainers to ack/nack that ?=0A=
