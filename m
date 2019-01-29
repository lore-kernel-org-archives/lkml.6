Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5004C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B058721473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jeZkR60T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfA2R3t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:29:49 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:60254 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfA2R3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:29:49 -0500
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay.synopsys.com (Postfix) with ESMTPS id 27E4124E2051;
        Tue, 29 Jan 2019 09:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1548782989; bh=nlREjU0JtKECr5OhIankWdtxjBgIAonYunWBUS45c4s=;
        h=From:To:CC:Subject:Date:References:From;
        b=jeZkR60TuC2H7lhqG4TLt9Grv7srxlIYgEJDYAZtVIj4UGRJrZjklx/61PTeL8J2t
         Nqp6GE27793/m9iuNhjjHh4qoSntxuAuEXMplQrxjqVi22UKQLtN4tPYuUWvuIouMM
         8lEefZQYfHIHK1IyU9cy8O/dHyNG+hf4DEzYLUTHeWUxTy2C7SF2qshM7hZrI+1ix5
         UgA9xzGZTnDCEp++NYp609oxxBKsXavhqS1CsIUgyk8GuBavygcpYfWjlLml4JjE4K
         ABCJ73jrkH24CTrzSBLwGaysnDJNI1UBsp0ooTGhqcFlFpq9NVWuMbcirYk4t9Lovx
         JKzZs+gKtb73Q==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id C5B44A0091;
        Tue, 29 Jan 2019 17:29:43 +0000 (UTC)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000;
 Tue, 29 Jan 2019 09:28:30 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        "Eugeniy.Paltsev@synopsys.com" <eugeniy.paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>
Subject: Re: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Topic: [PATCH 1/2] ARCv2: Enable unaligned access in early ASM code
Thread-Index: AQHUt/cYghtzynJ35kGCyR1ojJcDBg==
Date:   Tue, 29 Jan 2019 17:28:30 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014642D45B@US01WEMBX2.internal.synopsys.com>
References: <20190116112951.10641-1-Eugeniy.Paltsev@synopsys.com>
 <3c341dd9-f360-640e-a3c9-3291300d02ae@synopsys.com>
 <1548782756.29008.20.camel@synopsys.com>
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

On 1/29/19 9:26 AM, Eugeniy Paltsev wrote:=0A=
>> I presume there is no specific reason to include this conditionally.=0A=
>> irqflags.h already includes the right version.=0A=
> Agree.=0A=
> I've just forgotten about common irqflags.h=0A=
=0A=
No need for this series. Given Alexey's request, I've pushed the minimal pa=
tch.=0A=
You do need to rebase the other unalinged access series on top, however wai=
t for=0A=
me to comment on that.=0A=
=0A=
-Vineet=0A=
