Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD6AC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B82F218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731855AbfA3Ujs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:39:48 -0500
Received: from mga11.intel.com ([192.55.52.93]:58419 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfA3Ujr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:39:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jan 2019 12:39:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,542,1539673200"; 
   d="scan'208";a="118762043"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga007.fm.intel.com with ESMTP; 30 Jan 2019 12:39:47 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 46A7F3011E7; Wed, 30 Jan 2019 12:39:47 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        eranian@google.com, vincent.weaver@maine.edu,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: System crash with perf_fuzzer (kernel: 5.0.0-rc3)
References: <7c7ec3d9-9af6-8a1d-515d-64dcf8e89b78@linux.ibm.com>
        <20190130183648.GA24233@krava>
Date:   Wed, 30 Jan 2019 12:39:47 -0800
In-Reply-To: <20190130183648.GA24233@krava> (Jiri Olsa's message of "Wed, 30
        Jan 2019 19:36:48 +0100")
Message-ID: <87zhrhzxpo.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
>
> the patch adds check_eriod pmu callback.. I need to check if there's
> better way to do this, but so far it fixes the crash for me
>
> if you guys could check this patch, that'd be great

There's already a limit_period callback, perhaps that could
be extended. But ok, can do it this way too.

I suspect there are some other cases that need this callback, not
just BTS, e.g. the checks in hsw_hw_config


-Andi
