Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F41C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:09:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DC622083D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 11:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC622083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388751AbeHAMy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:54:58 -0400
Received: from ozlabs.org ([203.11.71.1]:51313 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730915AbeHAMy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:54:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41gVv81cFZz9s0R;
        Wed,  1 Aug 2018 21:09:40 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Michal Hocko <mhocko@kernel.org>, John Allen <jallen@linux.ibm.com>
Cc:     n-horiguchi@ah.jp.nec.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, kamezawa.hiroyu@jp.fujitsu.com,
        mgorman@suse.de
Subject: Re: Infinite looping observed in __offline_pages
In-Reply-To: <20180725200336.GP28386@dhcp22.suse.cz>
References: <20180725181115.hmlyd3tmnu3mn3sf@p50.austin.ibm.com> <20180725200336.GP28386@dhcp22.suse.cz>
Date:   Wed, 01 Aug 2018 21:09:39 +1000
Message-ID: <87r2jifimk.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@kernel.org> writes:
> On Wed 25-07-18 13:11:15, John Allen wrote:
> [...]
>> Does a failure in do_migrate_range indicate that the range is unmigratable
>> and the loop in __offline_pages should terminate and goto failed_removal? Or
>> should we allow a certain number of retrys before we
>> give up on migrating the range?
>
> Unfortunatelly not. Migration code doesn't tell a difference between
> ephemeral and permanent failures.

What's to stop an ephemeral failure happening repeatedly?

cheers
