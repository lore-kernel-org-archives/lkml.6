Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A82C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0039321872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 23:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="C98RIvPh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfBAXhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 18:37:38 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:33998 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbfBAXhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 18:37:38 -0500
Received: from mailhost.synopsys.com (dc8-mailhost1.synopsys.com [10.13.135.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 9837324E25B6;
        Fri,  1 Feb 2019 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1549064257; bh=wncI4nIe3+wmRCHsyc1Bn8DY2Vqp1EQFMegf6phNXQM=;
        h=From:To:CC:Subject:Date:References:From;
        b=C98RIvPhudt0jfsfUIQJYOfmIrM8ONFt7JY3IvLDf8CssfbEKou+BTc+oZu4Pd9Fj
         iIIyV1XntcZQBBLLYuMtqco5TUvDZlkKTk8ulhofBgPSqgGqoQW6a0AefUcw24qPii
         AG6wNkSx7LCaoqnomJPf9eEB0kU6FgE6nFW8Q9OCLEAxJU7p8gMdB3OWVa17o12vaj
         sMcyGcMuqBVB5tT+Zd3ygUME94hY7F51f1iR+Q0wAeVWoKl7LJ4+i7KxrL8pBW5iZp
         pccFbVVabzGwNMCBB+RuWW6Z+0tsUT+MQqR3rhUNoVQRyIlvCAqEPl759ISzSimqMH
         jmGA/JGQDnxUQ==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 89824A006A;
        Fri,  1 Feb 2019 23:37:37 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Fri, 1 Feb 2019 15:37:00 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     Alexey Brodkin <alexey.brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/5] ARCv2: introduce unaligned access under a
 Kconfig option
Thread-Topic: [PATCH v2 2/5] ARCv2: introduce unaligned access under a
 Kconfig option
Thread-Index: AQHUuoXgAZHBPd/yM06NsivaDTeWvg==
Date:   Fri, 1 Feb 2019 23:36:59 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642E698@US01WEMBX2.internal.synopsys.com>
References: <20190130163244.10870-1-Eugeniy.Paltsev@synopsys.com>
 <20190130163244.10870-3-Eugeniy.Paltsev@synopsys.com>
 <f95135f7-20e3-1897-d3dc-e8dadf8a2ac5@synopsys.com>
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

On 2/1/19 3:28 PM, Vineet Gupta wrote:=0A=
> Guess there's no solution to this. We could force select the option in re=
levant=0A=
> Kconfig, but this applies to pretty much every platform and defeats the p=
urpose of=0A=
> option in first place.=0A=
=0A=
Answering my own question:=0A=
=0A=
#if defined(__ARC_UNALIGNED__) && !defined(CONFIG_ARC_USE_UNALIGNED_MEM_ACC=
ESS)=0A=
BUILD_BUG_ON_MSG(1, "gcc doesn't support disabling unaligned accesses");=0A=
#endif=0A=
