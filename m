Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72429C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A4672082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RRzgkDgq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A4672082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeLERON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:14:13 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.60.111]:52104 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeLEROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:14:12 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 432E110C1133;
        Wed,  5 Dec 2018 09:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544030050; bh=ymhIQWEXWvGkhjoc6xXuaD2oFTJ7uiy99mRqbF3BsWs=;
        h=From:To:CC:Subject:Date:References:From;
        b=RRzgkDgqrK+XoQ8N5KOJYfw1jxYw/wvWR8CgSZzf28DQ8KCXRu8gaxLNuHC4KprY/
         ihlYmdr7N/xozlsWAawT6VP83jXJVUa17gwzNgfKksx9piq55SukV5BTeidDooy38R
         Jtsfs2FoALf3ZsOeNwk5TwmlEN9KrtKX8OSehtoWO4PKaQp1+Z3g7dYRTVbr8kr+AH
         f2F1vRv47Qg4Orob2b9wrAeF27M1mhyRn6cBcA1a27HSO1UDTeTyMf1HItQiTnaR9s
         L5bQCBEN6L+nDL6Pc8PO+K1u1wT1Qc93WMLdoDINWEqfu8gffSfNUXXRudKpPbBn8l
         aM2wChwhiR29Q==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 278483290;
        Wed,  5 Dec 2018 09:14:10 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Wed, 5 Dec 2018 09:14:10 -0800
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
Subject: Re: [PATCH 5/5] ARC: perf: remove useless ifdefs
Thread-Topic: [PATCH 5/5] ARC: perf: remove useless ifdefs
Thread-Index: AQHUjLzll1cULC1Qb0mO/Uuw7cqfDw==
Date:   Wed, 5 Dec 2018 17:14:09 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641B902@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-6-Eugeniy.Paltsev@synopsys.com>
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

On 12/5/18 9:06 AM, Eugeniy Paltsev wrote:=0A=
> ifdef around 'arc_pmu_match' structure declaration is useless=0A=
> as we refer to 'arc_pmu_match' in several places which aren't=0A=
> guarded with ifdef.=0A=
>=0A=
> Nevertheless 'ARC' option selects 'OF' unconditionally so we=0A=
> can simply get rid of this ifdef.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
=0A=
Maybe squash this into trivial cleanups 1/5 ?=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
