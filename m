Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE6DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A314F208FA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A314F208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGPTXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 15:23:49 -0400
Received: from mga05.intel.com ([192.55.52.43]:14694 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbeGPTXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 15:23:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2018 11:55:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,362,1526367600"; 
   d="scan'208";a="73246163"
Received: from acox1-desk1.ger.corp.intel.com ([10.252.0.209])
  by orsmga001.jf.intel.com with ESMTP; 16 Jul 2018 11:55:04 -0700
Message-ID: <1531767303.4364.109.camel@linux.intel.com>
Subject: Re: cpu_no_speculation omissions?
From:   Alan Cox <alan@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rich Felker <dalias@libc.org>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 16 Jul 2018 19:55:03 +0100
In-Reply-To: <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com>
References: <20180716160513.GA6080@brightrain.aerifal.cx>
         <alpine.DEB.2.21.1807161851290.1693@nanos.tec.linutronix.de>
         <193fb2f5-8f6c-8fe6-298f-a6af4fae862a@linux.intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-16 at 10:28 -0700, Dave Hansen wrote:
> On 07/16/2018 09:56 AM, Thomas Gleixner wrote:
> > On Mon, 16 Jul 2018, Rich Felker wrote:
> > > At least the Centerton (late-generation Bonnell uarch) Atom
> > > family is
> > > omitted from the cpu_no_speculation table added by commit
> > > fec9434a12f3
> > > to arch/x86/kernel/cpu/common.c. Is this intentional? Would a
> > > patch
> > > adding it and possibly other omissions be welcome?
> > 
> > Probably. Dave?
> 
> IIRC, Alan Cox was compiling a list on what is affected vs. not.  He
> would know way better than I.

The pre Silvermont atom cores are in order. When I did the original
list I didn't bother with all the 32bit cores as we didn't have any
32bit mitigations then.

Alan

