Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B9AC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D213420645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D213420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeJMBtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:49:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:21533 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725929AbeJMBtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:49:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id ED575C0740E4;
        Fri, 12 Oct 2018 18:15:47 +0000 (UTC)
Received: from redhat.com (ovpn-125-5.rdu2.redhat.com [10.10.125.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60C8F79453;
        Fri, 12 Oct 2018 18:15:47 +0000 (UTC)
Date:   Fri, 12 Oct 2018 14:15:45 -0400
From:   Jerome Glisse <jglisse@redhat.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HMM updates, improvements and fixes
Message-ID: <20181012181545.GG6593@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180824192549.30844-1-jglisse@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 12 Oct 2018 18:15:48 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 03:25:42PM -0400, jglisse@redhat.com wrote:
> From: Jérôme Glisse <jglisse@redhat.com>
> 
> Few fixes that only affect HMM users. Improve the synchronization call
> back so that we match was other mmu_notifier listener do and add proper
> support to the new blockable flags in the process.
> 
> For curious folks here are branches to leverage HMM in various existing
> device drivers:
> 
> https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-nouveau-v01
> https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-radeon-v00
> https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-intel-v00
> 
> More to come (amd gpu, Mellanox, ...)
> 
> I expect more of the preparatory work for nouveau will be merge in 4.20
> (like we have been doing since 4.16) and i will wait until this patchset
> is upstream before pushing the patches that actualy make use of HMM (to
> avoid complex tree inter-dependency).
> 

Andrew do you want me to repost this on top of lastest mmotm ?
All conflict should be pretty trivial to fix.

Cheers,
Jérôme
