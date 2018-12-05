Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88853C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FE012082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="kAcYjltJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE012082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbeLERMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:12:47 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:52048 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbeLERMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:12:46 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 49F0010C08D9;
        Wed,  5 Dec 2018 09:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544029966; bh=cG9SQjjtp/x7r+Lgk5yyPcD3K5kzbVecbcQM43c5gb0=;
        h=From:To:CC:Subject:Date:References:From;
        b=kAcYjltJ4VUX1rs6P5//gR2W2i0XPg8YVMER+3QP/NVYur9pLqcu5H00b3cquqdex
         puNc1iefex+zkxCoklz6mgZa6ocRWvJB9yVew88fHDq+ZGJupanB0XSAZeZJNbV+yw
         rjc/DUzDg+3O7ozJRYNN+d9gP01TiFRUu8DLWMFk0iPalzL1ElTPcf4bJFfthEF3Ow
         wKSRo/S2SFig9xK3elwS1tInki3RinAeDYjD6UCi3LibhcfjlU+dI+h0e4XW8aaSL3
         /emzue1yzqYQogPuXxvf8kNCF+eN63/Yh9RxY1vIzHqazOnUlgEo86IzVlGTB46IBm
         kvlGRGjU1/RvQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 295A53615;
        Wed,  5 Dec 2018 09:12:46 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 5 Dec 2018 09:12:45 -0800
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
Subject: Re: [PATCH 1/5] ARC: perf: trivial code cleanup
Thread-Topic: [PATCH 1/5] ARC: perf: trivial code cleanup
Thread-Index: AQHUjLzfqmZSihSsM0OugkFSf7IozQ==
Date:   Wed, 5 Dec 2018 17:12:45 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641B8E0@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-2-Eugeniy.Paltsev@synopsys.com>
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
> Use BIT(), lower_32_bits(), upper_32_bits() macroses,=0A=
> fix code style violations.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
Acked-by: Vineet Gupta <vgupta@synopsys.com>=0A=
=0A=
Thx,=0A=
-Vineet=0A=
