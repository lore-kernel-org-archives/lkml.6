Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD10AC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 789202082A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 789202082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbeJBUos (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 16:44:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:51732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729502AbeJBUor (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 16:44:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EABFAEAE;
        Tue,  2 Oct 2018 14:01:15 +0000 (UTC)
Date:   Tue, 2 Oct 2018 16:01:11 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>, linux-mm@kvack.org,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2 0/3] mm: Fix for movable_node boot option
Message-ID: <20181002140111.GW18290@dhcp22.suse.cz>
References: <20180925153532.6206-1-msys.mizuma@gmail.com>
 <alpine.DEB.2.21.1809272241130.8118@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1809272241130.8118@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-09-18 22:41:36, Thomas Gleixner wrote:
> On Tue, 25 Sep 2018, Masayoshi Mizuma wrote:
> 
> > This patch series are the fix for movable_node boot option
> > issue which was introduced by commit 124049decbb1 ("x86/e820:
> > put !E820_TYPE_RAM regions into memblock.reserved").
> > 
> > First patch, revert the commit. Second and third patch fix the
> > original issue.
> 
> Can the mm folks please comment on this?

I was under impression that Pavel who authored the original change which
got reverted here has reviewed these patches.
-- 
Michal Hocko
SUSE Labs
