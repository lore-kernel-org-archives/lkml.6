Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0023CC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BEDC219E8
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:00:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BEDC219E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbeHHPTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 11:19:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:22281 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeHHPTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 11:19:48 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Aug 2018 06:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,457,1526367600"; 
   d="scan'208";a="63290458"
Received: from sofia.sh.intel.com (HELO sofia) ([10.239.147.112])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2018 06:00:11 -0700
Date:   Wed, 8 Aug 2018 20:59:21 +0800
From:   "Liu, Changcheng" <changcheng.liu@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     broonie@opensource.wolfsonmicro.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Subject: Re: [PATCH] ASoC: trace: track dapm type in snd_soc_dapm_widget
Message-ID: <20180808125921.GA145678@sofia>
References: <20180808092927.GA144203@sofia>
 <20180808082412.20f7bd92@gandalf.local.home>
 <20180808123921.GA145536@sofia>
 <20180808085301.2b0617c6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180808085301.2b0617c6@gandalf.local.home>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Steven for the suggestion.
I'll write two patches. One is for cleaning the format issue. The other
is for tracking the dapm up/down sequence in trace events.

B.R.
Changcheng

On 08:53 Wed 08 Aug, Steven Rostedt wrote:
> On Wed, 8 Aug 2018 20:39:22 +0800
> "Liu, Changcheng" <changcheng.liu@intel.com> wrote:
> 
> > > > -	TP_printk("widget=%s val=%d", __get_str(name),
> > > > -		  (int)__entry->val)
> > > > +	TP_printk("widget=%s dapm_id=%d val=%d", __get_str(name),
> > > > +		  (int)__entry->id, (int)__entry->val)  
> > > 
> > > Not sure why it was there before, but the (int) typecast isn't needed
> > > in either case. __field(int, val) makes __entry->val of type int. Same
> > > for id.
> > > 
> > > -- Steve  
> > 
> > @Steve: This patch aims at tracking the dapm up/down sequence. For the
> > (int) typecast format problem, what do you think of using another
> > seperate patch to resolve it?
> 
> Yeah, I was just commenting on that as a general comment. It doesn't
> affect the actual patch, which I don't see anything wrong with it from
> a tracing point of view.
> 
> I agree the typecast removal should be done in a separate clean-up
> patch.
> 
> -- Steve
