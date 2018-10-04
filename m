Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A37C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99AA21470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A99AA21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeJDOgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:36:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:38526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727589AbeJDOgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:36:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A174AC36;
        Thu,  4 Oct 2018 07:44:58 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:44:57 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Randomize free memory
Message-ID: <20181004074457.GD22173@dhcp22.suse.cz>
References: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <153861931865.2863953.11185006931458762795.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03-10-18 19:15:18, Dan Williams wrote:
> Changes since v1:
> * Add support for shuffling hot-added memory (Andrew)
> * Update cover letter and commit message to clarify the performance impact
>   and relevance to future platforms

I believe this hasn't addressed my questions in
http://lkml.kernel.org/r/20181002143015.GX18290@dhcp22.suse.cz. Namely
"
It is the more general idea that I am not really sure about. First of
all. Does it make _any_ sense to randomize 4MB blocks by default? Why
cannot we simply have it disabled? Then and more concerning question is,
does it even make sense to have this randomization applied to higher
orders than 0? Attacker might fragment the memory and keep recycling the
lowest order and get the predictable behavior that we have right now.
"

> [1]: https://lkml.org/lkml/2018/9/15/366
-- 
Michal Hocko
SUSE Labs
