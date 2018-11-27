Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C45C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECDE213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:17:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECDE213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbeK1APD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:15:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:55780 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726425AbeK1APD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:15:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24CCEAF60;
        Tue, 27 Nov 2018 13:17:08 +0000 (UTC)
Date:   Tue, 27 Nov 2018 14:17:07 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     William Kucharski <william.kucharski@oracle.com>
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
Message-ID: <20181127131707.GW12455@dhcp22.suse.cz>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-4-mhocko@kernel.org>
 <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-11-18 17:33:32, William Kucharski wrote:
> 
> 
> This determines whether the page can theoretically be THP-mapped , but
> is the intention to also check for proper alignment and/or preexisting
> PAGESIZE page cache mappings for the address range?

This is only about the process wide flag to disable THP. I do not see
how this can be alighnement related. I suspect you wanted to ask in the
smaps patch?

> I'm having to deal with both these issues in the text page THP
> prototype I've been working on for some time now.

Could you be more specific about the issue and how the alignment comes
into the game? The only thing I can think of is to not report VMAs
smaller than the THP as eligible. Is this what you are looking for?
-- 
Michal Hocko
SUSE Labs
