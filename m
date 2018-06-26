Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85777C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1331022544
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 23:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1331022544
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933909AbeFZXka (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 19:40:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:25310 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752332AbeFZXk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 19:40:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 16:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="scan'208";a="240918025"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jun 2018 16:40:27 -0700
Message-ID: <b15934467c635e273aec812c894481403481df9f.camel@linux.intel.com>
Subject: Re: [PATCH] Documentation: intel_pstate: Describe hwp_dynamic_boost
 sysfs knob
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 26 Jun 2018 16:40:27 -0700
In-Reply-To: <306013127.TOMvMKusHN@aspire.rjw.lan>
References: <306013127.TOMvMKusHN@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-26 at 17:20 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Document the recently introduced hwp_dynamic_boost sysfs knob
> allowing user space to tell intel_pstate to use iowait boosting
> in the active mode with HWP enabled (to improve performance).
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  Documentation/admin-guide/pm/intel_pstate.rst |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> ===================================================================
> --- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
> +++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -378,6 +378,17 @@ argument is passed to the kernel in the
>  	but it affects the maximum possible value of per-policy P-
> state	limits
>  	(see `Interpretation of Policy Attributes`_ below for
> details).
>  
> +``hwp_dynamic_boost``
> +	This attribute is only present if ``intel_pstate`` works in
> the
> +	`active mode with the HWP feature enabled <Active Mode With
> HWP_>`_ in
> +	the processor.  If set (equal to 1), it causes the minimum
> P-state limit
> +	to be increased dynamically for a short time whenever a task
> previously
> +	waiting on I/O is selected to run on a given logical CPU
> (the purpose
> +	of this mechanism is to improve performance).
> +
> +	This setting has no effect on logical CPUs whose minimum P-
> state limit
> +	is directly set to the highest non-turbo P-state or above
> it.
> +
>  .. _status_attr:
>  
>  ``status``
> 
