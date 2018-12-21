Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797B0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45F0521917
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 13:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545398877;
	bh=szRojK07oJznJFJGM7Ecps4BD9FUs1EwllpHI7rKI98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZqbWU/+CCxNiXXZge2w2E3dnRKMcrMKhRK4Pcww2Bw5UuWtxFI6j+Ty+GvLA8Z88O
	 iswndWI4vvP+QiaqQnJlr5turN8CQFCmmYij2f2kGkf1a3LiT1nWN1jN4WOa9uKuPD
	 AFW1CkDkO8FPMYEKVyy59IiVgMZ3jy7m/NHS4ToU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390671AbeLUN14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 08:27:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:44674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729293AbeLUN14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 08:27:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 60910AC9C;
        Fri, 21 Dec 2018 13:27:54 +0000 (UTC)
Date:   Fri, 21 Dec 2018 14:27:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] ARC: show_regs: fix lockdep splat for good
Message-ID: <20181221132753.GB4842@dhcp22.suse.cz>
References: <1545159239-30628-1-git-send-email-vgupta@synopsys.com>
 <1545159239-30628-3-git-send-email-vgupta@synopsys.com>
 <20181220130450.GB17350@dhcp22.suse.cz>
 <C2D7FE5348E1B147BCA15975FBA23075014642389B@US01WEMBX2.internal.synopsys.com>
 <20181221130404.GF16107@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221130404.GF16107@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21-12-18 14:04:04, Michal Hocko wrote:
[...]
> Yes, but you are building on a broken concept I believe. What
> implications does re-enabling really have? Now you could reschedule and
> you can move to another CPU. Is this really safe? I believe that yes
> because the preemption disabling is simply bogus. Which doesn't sound
> like a proper justification, does it?

Well, thinking about it a bit more. What is the result of calling
preempt_enable outside of preempt_disabled section? E.g. __warn which
doesn't disable preemption AFAICS.
-- 
Michal Hocko
SUSE Labs
