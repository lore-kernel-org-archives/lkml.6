Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BF3F20661
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="IMKaAnXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BF3F20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbeLFQeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:34:00 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:39260 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbeLFQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:33:59 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 65E2110C1123;
        Thu,  6 Dec 2018 08:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544114039; bh=iBMJ29eTUPwyYvzTg25NU7GgKbAYuEhgFpK86ItJivo=;
        h=From:To:CC:Subject:Date:References:From;
        b=IMKaAnXfYS8rgQetwEls6X8CxqjVKrjwztrt8loEhD57LyyaCPkRzCOp0/CL5A6RC
         hUyX7DcJn/uv9n30GVCDZyUEmpIJz+I5crcmhFupcfS4O+ZXUty5yWz6AWVJi+02XW
         pJQJ1HJq29iK0qM4JybNzpejILYVtimBBWl1d4KktNfJA6rXS8UEJi/hUpoiSEf9Fj
         EdFAn9oRaWhbiY2TgNSaUZOmHYSbAg9FlaKyIe90BW2mgMlsfiVdChDPlseAlYxWeN
         T1htukTCICeV48Q7P0DEmYk5SDqYhbuYnwrrK7VwMxP4givtf9Skut19Dh8urOZviG
         VWayOK57ul1Vw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id 500ED5514;
        Thu,  6 Dec 2018 08:33:59 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WEHTC2.internal.synopsys.com ([10.12.239.237]) with mapi id
 14.03.0415.000; Thu, 6 Dec 2018 08:33:59 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 4/5] ARC: perf: fix description comment
Thread-Topic: [PATCH 4/5] ARC: perf: fix description comment
Thread-Index: AQHUjLzjZ5gYwzzQWk6w3ya36JgiMw==
Date:   Thu, 6 Dec 2018 16:33:58 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641BCFA@US01WEMBX2.internal.synopsys.com>
References: <20181205170609.18690-1-Eugeniy.Paltsev@synopsys.com>
 <20181205170609.18690-5-Eugeniy.Paltsev@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641B8F6@US01WEMBX2.internal.synopsys.com>
 <1544111364.31297.23.camel@synopsys.com>
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

On 12/6/18 7:49 AM, Eugeniy Paltsev wrote:=0A=
>> Maybe squash this into trivial cleanups 1/5 ?=0A=
> I split cleanup for several patches to make review easier.=0A=
> I can squash them into single patch in v2 if you want it.=0A=
>=0A=
>=0A=
=0A=
Understand, but they are all trivial anyways so yeah better to squash - I c=
an do=0A=
it here as well. Lets wait for PeterZ to comment on 2/5 before v2.=0A=
=0A=
-Vineet=0A=
