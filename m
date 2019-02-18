Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 667C5C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2524921479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 22:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731374AbfBRWEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 17:04:31 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:42662 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfBRWE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 17:04:29 -0500
Received: from 79.184.254.15.ipv4.supernova.orange.pl (79.184.254.15) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 1f037ce711af676d; Mon, 18 Feb 2019 23:04:27 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Doug Smythies <dsmythies@telus.net>
Cc:     'Linux PM' <linux-pm@vger.kernel.org>,
        'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>,
        'LKML' <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Rework iowait boosting to be less aggressive
Date:   Mon, 18 Feb 2019 23:03:03 +0100
Message-ID: <2407408.YatPz1rZtD@aspire.rjw.lan>
In-Reply-To: <000c01d4c6f6$914a7f20$b3df7d60$@net>
References: <2038590.kmssd2ZIyd@aspire.rjw.lan> <16144228.tcT5YVROcV@aspire.rjw.lan> <000c01d4c6f6$914a7f20$b3df7d60$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, February 17, 2019 8:25:37 PM CET Doug Smythies wrote:
> On 2019.02.07 03:51 Rafael J. Wysocki wrote:
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The current iowait boosting mechanism in intel_pstate_update_util()
> > is quite aggressive, as it goes to the maximum P-state right away,
> > and may cause excessive amounts of energy to be used, which is not
> > desirable and arguably isn't necessary too.
> >
> > Follow commit a5a0809bc58e ("cpufreq: schedutil: Make iowait boost
> > more energy efficient") that reworked the analogous iowait boost
> > mechanism in the schedutil governor and make the iowait boosting
> > in intel_pstate_update_util() work along the same lines.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >
> > -> v2:
> >   * Follow the Doug's suggestion and drop the immediate jump to
> >     max P-state if boost is max.  The code is simpler this way and
> >     the perf impact should not be noticeable on average.
> 
> Hi Rafael,
> 
> Something has broken on my incoming e-mail sorting stuff, and I
> missed this one (and some others).
> 
> This V2 is not actually what I was proposing. I was O.K. with
> the immediate jump, but I didn't want the set_pstate step
> by-passed if it was already at max because that would also
> by-pass the trace sample, if it was enabled.
> 
> Anyway, this V2 seems O.K. to me. I tested it compared to V1
> and, as you mentioned, wasn't able to detect any energy consumption
> or performance differences.

Thanks for the confirmation!

