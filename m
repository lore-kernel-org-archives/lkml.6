Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CCBECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC6B205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 20:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC6B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeJREZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:25:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:62491 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbeJREZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:25:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 13:28:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="100107468"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by fmsmga001.fm.intel.com with ESMTP; 17 Oct 2018 13:28:13 -0700
Date:   Wed, 17 Oct 2018 13:24:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Babu Moger <babu.moger@amd.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Arshiya Hayatkhan Pathan <arshiya.hayatkhan.pathan@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 0/7] selftests/resctrl: Add resctrl selftest
Message-ID: <20181017202446.GA45091@romley-ivt3.sc.intel.com>
References: <1539709001-38018-1-git-send-email-fenghua.yu@intel.com>
 <933e752f-2533-c982-cf0f-acd59ac50cde@amd.com>
 <FFF73D592F13FD46B8700F0A279B802F485D47DE@ORSMSX114.amr.corp.intel.com>
 <20181016203215.GA39177@romley-ivt3.sc.intel.com>
 <bc44fb0c-1ce2-031d-f2b4-3941f1517bbf@amd.com>
 <9c99a95d-de9a-6b33-a4c4-074b31515a7e@amd.com>
 <CALBSrqBXdXfNdZ1yJ_-zUSkk_2m_8R-VHNqk8DH3HmxCti4hhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALBSrqBXdXfNdZ1yJ_-zUSkk_2m_8R-VHNqk8DH3HmxCti4hhA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 11:04 AM Moger, Babu <Babu.Moger@amd.com> wrote:
> 
>     Hi Fenghua,
>      My few comments.
> 
>     On 10/17/2018 09:40 AM, Moger, Babu wrote:
>     > On 10/16/2018 03:32 PM, Fenghua Yu wrote:
>     >>> From: Moger, Babu [mailto:Babu.Moger@amd.com]
>     >>> On 10/16/2018 11:56 AM, Fenghua Yu wrote:
>     >>>> With more and more resctrl features are being added by Intel, AMD and
>     >>>> ARM, a test tool is becoming more and more useful to validate that
>     >>>> both hardware and software functionalities work as expected.
>     >>>
>     >>> I like the initiative here. It is always good to have a single code
>     base.
>     >>>
>     >>> One question. I see that there is a tool at https://github.com/intel/
>     intel-cmt-cat to test and verify the functionality of resctrl feature. I
>     also see some of the distros have this tool already.
>     >>> Is this tool going to replace intel-cmt-cat? I have not looked at the
>     >>> patches closely yet.
>     >>
>     >> No, the selftest in this patch set will not replace intel-cmt-cat or
>     >> vice versa.
>     >>
>     >> The selftest in this patch set has a different purpose from
>     intel-cmt-cat:
>     >> the selftest is a test tool which validates resctrl functionalities
>     while
>     >> intel-cmt-cat is mainly a utility that provides base library for higher
>     >> level applications including performance analysis tools, benchmark
>     measurement
>     >> tools, and potential resctrl tests. For example, running MBA test in the
>     >> selftests tells MBA working or not working (fail/pass) right way. The
>     >
>     > Ok. Sure. Let me take a look at selftest closely. Will send my feedback
>     soon.

Thanks.

>     >
>     >> intel-cmt-cat doesn't have this testing capability unless we extend the
>     >> tool.
>     >>
>     >> And intel-cmt-cat is maintained and developed by Intel. I don't think
>     it's
>     >> easy to extend it to AMD and ARM features. The selftest will be
>     maintained
>     >
>     > We1l.. We were hoping to have a common tool across. It makes it easy for
>     > distros. Probably, we can have a separate discussion on this.
>     >
>     >> and developed by the community and will hopefully cover all
>     architectures.
>     >>
>     >> We have seen a few issues recently in resctrl and may see more issues
>     >> while expending the features. A convevient selftest may be useful to
>     help
>     >> identify and fix those potential issues.
> 
>     I don't know the rules for selftest. Here are my general comments.
> 
>      1. File names are not consistent.
>       # ls *.c
>        fill_buf.c  mba.c  mbm.c  resctrl.c  resctrl_membw.c  resctrl_tests.c
>       Few files start with resctrl_ prefix and others don't.

All files are in resctrl directory. It's redundant to have resctrl prefix for
each file. Probably we will remove the resctrl prefix for all files to
keep uniform naming style.

> 
>      2. Do we need README(or USAGE) here? I had too

We can add that in next version.

> 
>      3. I saw lots of these errors.
>         "mba.c:111:2: error: ‘for’ loop initial declarations are only allowed
>     in C99 mode"
>       for (int i = 0; i < 10; i++) {
>       ^
> 
>       I had to change it to
>        int i;
>        for (i = 0; i < 10; i++) {

Will fix the issues.

Thanks.

-Fenghua
