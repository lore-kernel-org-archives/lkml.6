Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6E3C67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB9620843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:03:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB9620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731208AbeGYVQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:16:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:53402 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729529AbeGYVQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:16:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4EA0EAF55;
        Wed, 25 Jul 2018 20:03:37 +0000 (UTC)
Date:   Wed, 25 Jul 2018 22:03:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Allen <jallen@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kamezawa.hiroyu@jp.fujitsu.com, n-horiguchi@ah.jp.nec.com,
        mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
Message-ID: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 25-07-18 13:11:15, John Allen wrote:
[...]
> Does a failure in do_migrate_range indicate that the range is unmigratable
> and the loop in __offline_pages should terminate and goto failed_removal? Or
> should we allow a certain number of retrys before we
> give up on migrating the range?

Unfortunatelly not. Migration code doesn't tell a difference between
ephemeral and permanent failures. We are relying on
start_isolate_page_range to tell us this. So the question is, what kind
of page is not migratable and for what reason.

Are you able to add some debugging to give us more information. The
current debugging code in the hotplug/migration sucks...
-- 
Michal Hocko
SUSE Labs
