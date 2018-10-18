Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF052C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7731620645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7731620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbeJRVpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:45:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:37440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727199AbeJRVpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:45:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D0179AD52;
        Thu, 18 Oct 2018 13:44:03 +0000 (UTC)
Date:   Thu, 18 Oct 2018 15:44:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Randomize free memory
Message-ID: <20181018134402.GE18839@dhcp22.suse.cz>
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181004074457.GD22173@dhcp22.suse.cz>
 <CAPcyv4ht=ueiZwPTWuY5Y4y1BUOi_z+pHMjfoiXG+Bjd-h55jA@mail.gmail.com>
 <20181009112216.GM8528@dhcp22.suse.cz>
 <CAPcyv4gAsyw7Tpp6QKQUA=P3k-Gw=KzutS-PzBiisnxQ1R24gw@mail.gmail.com>
 <20181010084731.GB5873@dhcp22.suse.cz>
 <CAPcyv4j1QZSk_soYY=xpMiv0exYzdGoa0uqWppSs_dJwF4TPnw@mail.gmail.com>
 <20181011115238.GU5873@dhcp22.suse.cz>
 <CAPcyv4i38LAh1-bDE5cAAV=pAWMQeOYSmWF7ucM+Qt2O+GYMWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4i38LAh1-bDE5cAAV=pAWMQeOYSmWF7ucM+Qt2O+GYMWw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 11-10-18 11:03:07, Dan Williams wrote:
> On Thu, Oct 11, 2018 at 4:56 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > In any case, I believe the change itself is not controversial as long it
> > is opt-in (potentially autotuned based on specific HW)
> 
> Do you mean disable shuffling on systems that don't have a
> memory-side-cache unless / until we can devise a security benefit
> curve relative to shuffle-order? The former I can do, the latter, I'm
> at a loss.

Yes, enable when the HW requires that for whatever reason and make add a
global knob to enable it for those that might find it useful for
security reasons with a clear cost/benefit description. Not "this is tha
security thingy enable and feel safe(r)"
-- 
Michal Hocko
SUSE Labs
