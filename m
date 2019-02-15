Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C904C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559521927
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 03:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387969AbfBODtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 22:49:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45854 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730046AbfBODtK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 22:49:10 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E794637EC;
        Fri, 15 Feb 2019 03:49:10 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 47F8B60A9B;
        Fri, 15 Feb 2019 03:49:10 +0000 (UTC)
Date:   Thu, 14 Feb 2019 22:49:09 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.20 42/77] dm: fix clone_bio() to trigger
 blk_recount_segments()
Message-ID: <20190215034909.GB17226@redhat.com>
References: <20190215020855.176727-1-sashal@kernel.org>
 <20190215020855.176727-42-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215020855.176727-42-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 15 Feb 2019 03:49:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14 2019 at  9:08pm -0500,
Sasha Levin <sashal@kernel.org> wrote:

> From: Mike Snitzer <snitzer@redhat.com>
> 
> [ Upstream commit 57c36519e4b949f89381053f7283f5d605595b42 ]
> 
> DM's clone_bio() now benefits from using bio_trim() by fixing the fact
> that clone_bio() wasn't clearing BIO_SEG_VALID like bio_trim() does;
> which triggers blk_recount_segments() via bio_phys_segments().
> 
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Mike Snitzer <snitzer@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Please no, I later effectively reverted this change with commit
fa8db4948f522 ("dm: don't use bio_trim() afterall")

(As and aside, I really shouldn't have to defend against stable@ bots
picking up a commit, like 57c36519e4b949f, that wasn't marked for
stable@.)
