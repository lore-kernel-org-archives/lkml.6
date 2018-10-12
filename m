Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C09CC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20D9E2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 21:12:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20D9E2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbeJMEq1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 00:46:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725755AbeJMEq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 00:46:26 -0400
Received: from localhost.localdomain (c-24-4-154-175.hsd1.ca.comcast.net [24.4.154.175])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B78ECF10;
        Fri, 12 Oct 2018 21:12:05 +0000 (UTC)
Date:   Fri, 12 Oct 2018 14:12:03 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] HMM updates, improvements and fixes
Message-Id: <20181012141203.40a0c5272821e43e97382894@linux-foundation.org>
In-Reply-To: <20181012181545.GG6593@redhat.com>
References: <20180824192549.30844-1-jglisse@redhat.com>
        <20181012181545.GG6593@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Oct 2018 14:15:45 -0400 Jerome Glisse <jglisse@redhat.com> wrote:

> On Fri, Aug 24, 2018 at 03:25:42PM -0400, jglisse@redhat.com wrote:
> > From: Jérôme Glisse <jglisse@redhat.com>
> > 
> > Few fixes that only affect HMM users. Improve the synchronization call
> > back so that we match was other mmu_notifier listener do and add proper
> > support to the new blockable flags in the process.
> > 
> > For curious folks here are branches to leverage HMM in various existing
> > device drivers:
> > 
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-nouveau-v01
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-radeon-v00
> > https://cgit.freedesktop.org/~glisse/linux/log/?h=hmm-intel-v00
> > 
> > More to come (amd gpu, Mellanox, ...)
> > 
> > I expect more of the preparatory work for nouveau will be merge in 4.20
> > (like we have been doing since 4.16) and i will wait until this patchset
> > is upstream before pushing the patches that actualy make use of HMM (to
> > avoid complex tree inter-dependency).
> > 
> 
> Andrew do you want me to repost this on top of lastest mmotm ?
> All conflict should be pretty trivial to fix.

Please.  I ducked v1 because a v2 was in the works.  It's very late in
the cycle so you might want to prepare an urgent-for-4.19 series and a
for-4.20 series.  Or, better, a single series with the appropriate
Cc:stable tags.

Please ensure that all review questions which have thus far been
received are appropriately answered in code comments and in changelogs.
Because if one reader was wondering about something, others will
wonder the same thing in the future.

