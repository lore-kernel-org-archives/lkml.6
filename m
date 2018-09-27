Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D672CC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CF2216C4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 23:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48CF2216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeI1FkZ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 01:40:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:34316 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726083AbeI1FkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 01:40:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Sep 2018 16:19:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,312,1534834800"; 
   d="scan'208";a="266553082"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 27 Sep 2018 16:19:29 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Thu, 27 Sep 2018 16:19:29 -0700
Received: from orsmsx107.amr.corp.intel.com ([169.254.1.14]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.194]) with mapi id 14.03.0319.002;
 Thu, 27 Sep 2018 16:19:29 -0700
From:   "Schaufler, Casey" <casey.schaufler@intel.com>
To:     James Morris <jmorris@namei.org>,
        Casey Schaufler <casey@schaufler-ca.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
        "arjan@linux.intel.com" <arjan@linux.intel.com>
Subject: RE: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
Thread-Topic: [PATCH v5 5/5] sidechannel: Linux Security Module for
 sidechannel
Thread-Index: AQHUVdhkFYvudVbH2U6ou/rRnPpFo6UFIFYAgAAPVgCAAAIMgP//kjvQ
Date:   Thu, 27 Sep 2018 23:19:28 +0000
Message-ID: <99FC4B6EFCEFD44486C35F4C281DC67321463CE3@ORSMSX107.amr.corp.intel.com>
References: <20180926203446.2004-1-casey.schaufler@intel.com>
 <20180926203446.2004-6-casey.schaufler@intel.com>
 <alpine.LRH.2.21.1809280744560.8410@namei.org>
 <025d4742-5947-545e-f603-502a0c5ee03f@schaufler-ca.com>
 <alpine.LRH.2.21.1809280846280.8410@namei.org>
In-Reply-To: <alpine.LRH.2.21.1809280846280.8410@namei.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODQyZjBhNWYtNzRhYy00NDA2LWEyZTUtZTBjODE0ZWQ2ZDdhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTGdMMzFKR3BGWHBpSXNzN05veEtpdjhEbWFsYkFsQkt4YU1yb0NQT3JRSlVySmVQWkEwVUNGbjNNbWVpak8xSyJ9
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
> Sent: Thursday, September 27, 2018 3:47 PM
> To: Casey Schaufler <casey@schaufler-ca.com>
> Cc: Schaufler, Casey <casey.schaufler@intel.com>; kristen@linux.intel.com;
> kernel-hardening@lists.openwall.com; Dock, Deneen T
> <deneen.t.dock@intel.com>; linux-kernel@vger.kernel.org; Hansen, Dave
> <dave.hansen@intel.com>; linux-security-module@vger.kernel.org;
> selinux@tycho.nsa.gov; arjan@linux.intel.com
> Subject: Re: [PATCH v5 5/5] sidechannel: Linux Security Module for sidechannel
> 
> On Thu, 27 Sep 2018, Casey Schaufler wrote:
> 
> > On 9/27/2018 2:45 PM, James Morris wrote:
> > > On Wed, 26 Sep 2018, Casey Schaufler wrote:
> > >
> > >> +	/*
> > >> +	 * Namespace checks. Considered safe if:
> > >> +	 *	cgroup namespace is the same
> > >> +	 *	User namespace is the same
> > >> +	 *	PID namespace is the same
> > >> +	 */
> > >> +	if (current->nsproxy)
> > >> +		ccgn = current->nsproxy->cgroup_ns;
> > >> +	if (p->nsproxy)
> > >> +		pcgn = p->nsproxy->cgroup_ns;
> > >> +	if (ccgn != pcgn)
> > >> +		return -EACCES;
> > >> +	if (current->cred->user_ns != p->cred->user_ns)
> > >> +		return -EACCES;
> > >> +	if (task_active_pid_ns(current) != task_active_pid_ns(p))
> > >> +		return -EACCES;
> > >> +	return 0;
> > > I really don't like the idea of hard-coding namespace security semantics
> > > in an LSM.  Also, I'm not sure if these semantics make any sense.
> >
> > Checks on namespaces where explicitly requested.
> 
> By whom and what is the rationale?

The rationale is to protect containers. Since those closest thing
there is to a definition of containers is "uses namespaces" that
becomes the focus. Separating them out does not make too much
sense as I would expect someone concerned with one to be concerned
with all.
 
