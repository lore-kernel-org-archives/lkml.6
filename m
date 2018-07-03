Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E49C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:35:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43B22454
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:35:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="k0NI31+W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D43B22454
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934509AbeGCSff (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:35:35 -0400
Received: from rcdn-iport-2.cisco.com ([173.37.86.73]:14860 "EHLO
        rcdn-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934381AbeGCSfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:35:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1581; q=dns/txt; s=iport;
  t=1530642934; x=1531852534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3NhigFavGuypKnyqj5PVuKWWzcUcqN5DuFXDX9u2gOo=;
  b=k0NI31+W8j777uwnWRBa9gmWzPSTAWdl9+FFgx2hzXE7w6pcLuZnMNWC
   lk3BZmC5JLUoReMS+jmTdusjOitbrSrkrZmAhSEDNBm836k7xn2UjuNtn
   o2p/FI+3uRqgnNbAA29vqa2glqytvcNgoWcb96n1b+AqMhbqJEBGsG8R5
   Y=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DJAAABwTtb/5NdJa1cGQEBAQEBAQE?=
 =?us-ascii?q?BAQEBAQcBAQEBAYNJgWEoCotzjD6CB4Q6kG6BegsYhFQCghkhNBgBAgEBAgE?=
 =?us-ascii?q?BAm0ohTYBAQEBAwF4EAIBCBEEAQEBCSUPGQodCAIEDgWFIKsQiEuBOohtgVY?=
 =?us-ascii?q?/hB6EeoVWAodhhSuEWodlCQKLMINtgUCEDIgLkWICERMBgSQdOIFScBWDJJB?=
 =?us-ascii?q?Sb49fgRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.51,304,1526342400"; 
   d="scan'208";a="422032920"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
  by rcdn-iport-2.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 18:35:33 +0000
Received: from XCH-RTP-003.cisco.com (xch-rtp-003.cisco.com [64.101.220.143])
        by rcdn-core-11.cisco.com (8.14.5/8.14.5) with ESMTP id w63IZWWK013924
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 18:35:33 GMT
Received: from xch-rtp-001.cisco.com (64.101.220.141) by XCH-RTP-003.cisco.com
 (64.101.220.143) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Tue, 3 Jul
 2018 14:35:32 -0400
Received: from xch-rtp-001.cisco.com ([64.101.220.141]) by
 XCH-RTP-001.cisco.com ([64.101.220.141]) with mapi id 15.00.1320.000; Tue, 3
 Jul 2018 14:35:32 -0400
From:   "Nikunj Kela (nkela)" <nkela@cisco.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will.deacon@arm.com>,
        "xe-kernel@external.cisco.com" <xe-kernel@external.cisco.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address
Thread-Topic: [PATCH 2/2] arm64: add support for 43bit physical address
Thread-Index: AQHUEkhUYrA/ILOIpk+9pyia5fOeYaR92oaA///4KMY=
Date:   Tue, 3 Jul 2018 18:35:32 +0000
Message-ID: <1530642932209.57184@cisco.com>
References: <20180702210451.16057-2-nkela@cisco.com>,<20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
In-Reply-To: <20180703145626.g6pb4bgnrle2p2qf@armageddon.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.41.48.45]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are trying to reduce the memory allocation needed for kdump kernel. We w=
ant to reserve less than 32M for kdump kernel if possible. We are able to g=
et ~14M saving by the proposed change. Below are the numbers before and aft=
er the proposed change:=0A=
=0A=
With 48 bit physical address and 30 bit section size:=0A=
--------------------------------------------------------------------=0A=
=0A=
Memory: 23052K/49152K available (3460K kernel code, 296K rwdata, 2436K roda=
ta, 204K init, 179K bss, 26100K reserved, 0K cma-reserved)=0A=
=0A=
With 43 bit physical address and 27bit section size:=0A=
--------------------------------------------------------------------=0A=
=0A=
Memory: 37284K/49152K available (3596K kernel code, 296K rwdata, 2408K roda=
ta, 208K init, 173K bss, 11868K reserved, 0K cma-reserved)=0A=
=0A=
Thanks,=0A=
-Nikunj=0A=
________________________________________=0A=
From: Catalin Marinas <catalin.marinas@arm.com>=0A=
Sent: Tuesday, July 3, 2018 7:56 AM=0A=
To: Nikunj Kela (nkela)=0A=
Cc: Will Deacon; xe-kernel@external.cisco.com; linux-kernel@vger.kernel.org=
; linux-arm-kernel@lists.infradead.org=0A=
Subject: Re: [PATCH 2/2] arm64: add support for 43bit physical address=0A=
=0A=
On Mon, Jul 02, 2018 at 02:04:51PM -0700, Nikunj Kela wrote:=0A=
> This patch adds support for 43bit physical address. Additionally,=0A=
> this patch adds support for 27bit section size. This is useful in=0A=
> reducing kernel memory usage. One usecase is in kdump kernel.=0A=
=0A=
Some numbers please.=0A=
=0A=
--=0A=
Catalin=0A=
