Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbeEDMKF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 08:10:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:47895 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750880AbeEDMKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 08:10:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400";
   d="scan'208";a="196710737"
Date: Fri, 4 May 2018 15:09:59 +0300
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Markus Metzger <markus.t.metzger@intel.com>
Subject: Re: [PATCH v2] perf: Suppress AUX/OVERWRITE records
Message-ID: <20180504120959.z6cik4zv6ragblxd@um.fi.intel.com>
References: <20180403173207.GA8921@arm.com>
 <20180404145323.28651-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404145323.28651-1-alexander.shishkin@linux.intel.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 05:53:23PM +0300, Alexander Shishkin wrote:
> It has been pointed out to me many times that it is useful to be able
> to switch off AUX records to save the bandwidth for records that actually
> matter, for example, in AUX overwrite mode.
> 
> The usefulness of PERF_RECORD_AUX is in some of its flags, like the
> TRUNCATED flag that tells the decoder where exactly gaps in the trace are.
> The OVERWRITE flag, on the other hand will be set on every single record
> in overwrite mode. However, a PERF_RECORD_AUX[flags=OVERWRITE] is
> generated on every target task's sched_out, which over time adds up to
> a lot of useless information.
> 
> If any folks out there have userspace that depends on a constant stream of
> OVERWRITE records for a good reason, they'll have to let us know.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Markus Metzger <markus.t.metzger@intel.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>

This one seems to be slipping through the cracks.

Cheers,
--
Alex
