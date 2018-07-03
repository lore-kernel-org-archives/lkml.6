Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1E5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8548824267
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 09:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548824267
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754715AbeGCJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 05:28:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:63176 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933656AbeGCJ1e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 05:27:34 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2018 02:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,302,1526367600"; 
   d="scan'208";a="69686811"
Received: from um.fi.intel.com (HELO um) ([10.237.72.212])
  by orsmga001.jf.intel.com with ESMTP; 03 Jul 2018 02:27:28 -0700
Received: from ash by um with local (Exim 4.91)
        (envelope-from <alexander.shishkin@linux.intel.com>)
        id 1faHao-00016e-B1; Tue, 03 Jul 2018 12:27:26 +0300
Date:   Tue, 3 Jul 2018 12:27:25 +0300
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] perf/aux: Make perf_event accessible to setup_aux()
Message-ID: <20180703092725.j7x2qxiwjgkejox2@um.fi.intel.com>
Mail-Followup-To: Mathieu Poirier <mathieu.poirier@linaro.org>,
        peterz@infradead.org, acme@kernel.org, mingo@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
        will.deacon@arm.com, mark.rutland@arm.com, jolsa@redhat.com,
        namhyung@kernel.org, adrian.hunter@intel.com, ast@kernel.org,
        gregkh@linuxfoundation.org, hpa@zytor.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1530570810-28929-1-git-send-email-mathieu.poirier@linaro.org>
 <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1530570810-28929-5-git-send-email-mathieu.poirier@linaro.org>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 04:33:28PM -0600, Mathieu Poirier wrote:
> It can be advantagous to have access to all the information conveyed by
> a perf_event when setting up the AUX buffer, as it is the case when
> dealing with PMU specific driver configuration communicated to the kernel
> using an ioctl() call.
> 
> As such simply replace the cpu information by the complete perf_event
> structure and change all affected customers.

Ok, but can you provide details about which parts of perf_event you need
and how they are used? Is it the attribute? What's the ioctl command in
question? Also, should we worry that the PMU specific configuration isn't
part of the attribute? Or, if not, why? I think we talked about this
before, but I forgot and this patch needs to explain it anyway.

Thanks!
--
Alex
