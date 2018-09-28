Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72554C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797820657
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3797820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeI2AFx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:05:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:16593 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbeI2AFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:05:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Sep 2018 10:41:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,315,1534834800"; 
   d="scan'208";a="92981659"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga004.fm.intel.com with ESMTP; 28 Sep 2018 10:40:53 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.136]) with mapi id 14.03.0319.002;
 Fri, 28 Sep 2018 10:40:53 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     James Morris <jmorris@namei.org>, Jann Horn <jannh@google.com>
CC:     Casey Schaufler <casey@schaufler-ca.com>,
        "kristen@linux.intel.com" <kristen@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: RE: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
Thread-Topic: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
Thread-Index: AQHUVdhkFYvudVbH2U6ou/rRnPpFo6UFIFYAgAAPVgCAAAIMgP//kjvQgAB9doCAAAExgIABGPwA//+XhgA=
Date:   Fri, 28 Sep 2018 17:40:52 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC6732146466E@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
 <alpine.LRH.2.21.1809280744560.8410@namei.org>
 <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com>
 <alpine.LRH.2.21.1809280846280.8410@namei.org>
 <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
 <alpine.LRH.2.21.1809280936290.13517@namei.org>
 <CAG48ez3Jnao-5z3O8s=RdoAx8=b68C_1pfKNKJSm+6R_HyU_fg@mail.gmail.com>
 <alpine.LRH.2.21.1809290233130.15725@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809290233130.15725@namei.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMWZiNjIzNTYtODQ5Yi00N2Y2LTkzNTMtNWExNTFkZDIzODFkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMmw1aGthVnVJRFRwSlNKZU1LVUg3M2loWmM5ZFp2dllkbUhRVnhuZ3N3UXJUeks4R0dlbWJqTEYyWWtiYTE5QSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: James Morris [mailto:jmorris@namei.org]
> Sent: Friday, September 28, 2018 9:33 AM
> To: Jann Horn <jannh@google.com>
> Cc: Schaufler, Casey <casey.schaufler@intel.com>; Casey Schaufler
> <casey@schaufler-ca.com>; kristen@linux.intel.com; Kernel Hardening
> <kernel-hardening@lists.openwall.com>; Dock, Deneen T
> <deneen.t.dock@intel.com>; kernel list <linux-kernel@vger.kernel.org>;
> Hansen, Dave <dave.hansen@intel.com>; linux-security-module <linux-security-
> module@vger.kernel.org>; selinux@tycho.nsa.gov; Arjan van de Ven
> <arjan@linux.intel.com>
> Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
> 
> On Fri, 28 Sep 2018, Jann Horn wrote:
> 
> > > so with this hard-coded logic, you are saying this case is
> > > 'safe' in a sidechannel context.
> > >
> > > Which hints at the deeper issue that containers are a userland
> > > abstraction.  Protection of containers needs to be defined by userland
> > > policy.
> >
> > Or just compare mount namespaces additionally/instead. I think that
> > containers will always use those, because AFAIK nobody uses chroot()
> > for containers, given that the kernel makes absolutely no security
> > guarantees about chroot().
> 
> We can't define this in the kernel. It has no concept of containers.
> 
> People utilize some combination of namespaces and cgroups and call them
> containers,

There is an amazing variety of things called containers out there.
I cite them as a use case, not a requirement.

> but we can't make assumptions from the kernel on what any of
> this means from a security point of view, and hard-code kernel policy
> based on those assumptions.

We can assume that namespaces are being used as a separation mechanism.
That makes processes in different namespaces potentially vulnerable to
side-channel attacks. That's true regardless of whether or not someone is
using namespaces to implement containers. 

> This is violating the principal of separating mechanism and policy, and
> also imposing semantics across the kernel/user boundary. The latter
> creates an ABI which we can then never break.

The effects of the sidechannel security module are not API visible.
The potential impact is on performance. This implementation of
PTRACE_MODE_SCHED does not change what happens, but may affect
when it happens. It is intended to aid in optimizing the use of expensive
anti-side-channel countermeasures.
