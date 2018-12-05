Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69F6C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A462082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D3C3U5Ge"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A462082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeLERPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:15:47 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:52172 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727475AbeLERPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:15:46 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 881EC10C0ACD;
        Wed,  5 Dec 2018 09:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544030146; bh=Q7i0vP4op/czna0dHpGbxZhRG+D2TI9I9KW2YwD83dA=;
        h=From:To:CC:Subject:Date:References:From;
        b=D3C3U5GeWyyZeW5bLh9yKY/z5+5xTEems1KWS+9JwySl2qVrejnJFHWiN+OgbHiud
         HnpQvThCiyyqp+h+fIik8Q0ccgjr1/69rFkQwC8+MiBkhqfTJUuXv5CNyKq8lx08/G
         2M1FX2NSgEJBn0xoB4qRzwYAVDuKUuAupPpOx4gnZpQkHIp+ID//kLvyp2Sq6J5N15
         918fzyJI/mptSZHpWTDmM98Ig1irI7qSmWVitFmDqy+9sfXoUIBywbFZqSsXPjZJzd
         0w2Vro/r7/AIrPjJA6eb2HQlTpPEfW1ltC1utzrnZos+u5HeNUEW4tqwsQwYavPvnE
         wxVy/4OYEE9aw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 710E35817;
        Wed,  5 Dec 2018 09:15:46 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 09:15:46 -0800
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
Subject: Re: [PATCH 3/5] ARC: perf: fix of kernel data types using
Thread-Topic: [PATCH 3/5] ARC: perf: fix of kernel data types using
Thread-Index: AQHUjLzhlRR+XbBr/0msXgnUICyTug==
Date:   Wed, 5 Dec 2018 17:15:45 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641B931@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-4-Eugeniy.Paltsev@synopsys.com>
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
> Use u32, u64, s64 instead of uint32_t, uint64_t, int64_t=0A=
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
