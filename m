Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A8C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AABD20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 17:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bDmPD71u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AABD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729733AbeLMRWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:22:00 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:38932 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729196AbeLMRV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 12:21:58 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id B2F1010C1804;
        Thu, 13 Dec 2018 09:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544721717; bh=iM3tty5sEBIwEcW2k042XW5kanV2CwYKjIIsWapDXeY=;
        h=From:To:CC:Subject:Date:References:From;
        b=bDmPD71uiZGTx2G+zmmnIkjKdF/j5jAhbVRtJQl5yUymM1VC6Vs1uKts8MqNozj/w
         0mm0815wOkZ40DeGT7sBx0TDcNTvyqAicFDe0UdVPqCNxghBI9AV8YEsrzCy1n4irC
         l7jI3Q00EkebGLOZBfi5kHmg9Cnwa99buHavz+1HQvigtSdySiT60DqkffX1ogL1gw
         +tvvIEGERC+3hXGqHXxdeebu8fD2Sn4V7JRS9xQUYE2X0JPjVQxDI2mt20GEEtI8Am
         oFlal6nlID/Ot/MHrb22Ot+U8a/FI3ZMs+WbnDdD4K/QdtyGDl/5fKjEAX0PoMychN
         i3m/AiN+G6FZw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9C235383E;
        Thu, 13 Dec 2018 09:21:57 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Thu,
 13 Dec 2018 09:21:57 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <alexey.brodkin@synopsys.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 1/4] ARC: perf: trivial code cleanup
Thread-Topic: [PATCH v2 1/4] ARC: perf: trivial code cleanup
Thread-Index: AQHUkwTP5/gt24tZc0icQ7a9STUNcQ==
Date:   Thu, 13 Dec 2018 17:21:57 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641F684@US01WEMBX2.internal.synopsys.com>
References: <20181213165621.20817-1-Eugeniy.Paltsev@synopsys.com>
 <20181213165621.20817-2-Eugeniy.Paltsev@synopsys.com>
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

On 12/13/18 8:56 AM, Eugeniy Paltsev wrote:=0A=
> * Use BIT(), lower_32_bits(), upper_32_bits() macroses,=0A=
>   fix code style violations.=0A=
> * Use u32, u64, s64 instead of uint32_t, uint64_t, int64_t=0A=
> * Fix description comment as this code doesn't belong only to=0A=
>   ARC700 anymore.=0A=
> * Use SPDX License Identifier.=0A=
> * Remove useless ifdefs. ifdef around 'arc_pmu_match' structure=0A=
>   declaration is useless as we refer to 'arc_pmu_match' in=0A=
>   several places which aren't guarded with ifdef. Nevertheless=0A=
>   'ARC' option selects 'OF' unconditionally so we can simply=0A=
>   get rid of this ifdef.=0A=
>=0A=
> Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
Applied !=0A=
=0A=
Thx,=0A=
-Vineet=0A=
