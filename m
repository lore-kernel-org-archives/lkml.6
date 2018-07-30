Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B825916256E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71F0E20892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 17:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71F0E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbeG3Snr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 14:43:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:38256 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726762AbeG3Snq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 14:43:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 10:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,422,1526367600"; 
   d="scan'208";a="79063553"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga002.jf.intel.com with ESMTP; 30 Jul 2018 10:07:18 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 30 Jul 2018 10:07:17 -0700
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.242]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.2]) with mapi id 14.03.0319.002;
 Mon, 30 Jul 2018 10:07:17 -0700
From:   "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Hansen, Dave" <dave.hansen@intel.com>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: RE: [PATCH] x86/speculation: Support Enhanced IBRS on future CPUs
Thread-Topic: [PATCH] x86/speculation: Support Enhanced IBRS on future CPUs
Thread-Index: AQHUI5CB01KrMjG5ck2pZsXG/OeZWaSoLwKAgAAikICAACmqAP//jMTw
Date:   Mon, 30 Jul 2018 17:07:17 +0000
Message-ID: <FFF73D592F13FD46B8700F0A279B802F475225F1@ORSMSX114.amr.corp.intel.com>
References: <1532465636-25240-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <alpine.DEB.2.21.1807301423260.2518@nanos.tec.linutronix.de>
 <d65cbf8c-27b6-63fb-23ce-d26017953245@intel.com>
 <alpine.DEB.2.21.1807301856470.1725@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1807301856470.1725@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNDkzY2VjMDItNjJjYS00Yzk2LWIwNzItNjI3ZmZkNjQxODcyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVXRhVDFKSm9pZ1M2OWRyb3VVM0ZWenZXb2M0eHp3Q200MUZ0ZCtaMncxeDVqbEtNK1RwXC9VWUVjNVdJXC9rdG1EIn0=
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

> > >> From: Sai Praneeth <sai.praneeth.prakhya@intel.com> Some future
> > >> Intel processors may support "Enhanced IBRS" which is an "always
> > >> on" mode i.e. IBRS bit in SPEC_CTRL MSR is enabled once and never
> > >> disabled. According to specification[1], this should simplify
> > >> software enabling and improve performance.
> > > SHOULD is not really helpful. The question is whether it does
> > > improve performance in practice or not. You really want to add
> > > numbers comparing retpoutine and enhanced IBRS.
> >
> > One thing to remember from Intel's retpoline paper:
> >
> > > Retpoline is known to be an effective branch target injection
> > > (Spectre variant 2) mitigation on Intel processors belonging to
> > > family 6 (enumerated by the CPUID instruction) that do not have
> > > support for enhanced IBRS. On processors that support enhanced IBRS,
> > > it should be used for mitigation instead of retpoline.
> >
> > That's both a statement of "Intel would like you to use enhanced IBRS
> > over retpoline where available" and "retpoline provides less
> > mitigation on processors with enhanced IBRS compared to those without".
> >
> > In other words, we can _do_ performance deltas, but they won't be as
> > meaningful because they won't really have apples-to-apples mitigation
> > properties.
> 
> Fair enough, but this wants to be spelled out in the change log explicitely instead
> of unspecific blurbs.

Sure! Makes sense. Would you like me to send a V2 with updated change log?

Regards,
Sai
