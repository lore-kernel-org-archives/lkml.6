Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A58C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BE020854
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:13:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72BE020854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbeJYXqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:46:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:57462 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727411AbeJYXqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:46:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6C506B005;
        Thu, 25 Oct 2018 15:12:58 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id BF13EDABAA; Thu, 25 Oct 2018 17:12:48 +0200 (CEST)
Date:   Thu, 25 Oct 2018 17:12:48 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Mason <clm@fb.com>, Jeff Mahoney <jeffm@suse.com>
Subject: Re: [PATCH AUTOSEL 4.4 15/65] btrfs: don't create or leak aliased
 root while cleaning up orphans
Message-ID: <20181025151247.GE16290@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Chris Mason <clm@fb.com>, Jeff Mahoney <jeffm@suse.com>
References: <20181025141705.213937-1-sashal@kernel.org>
 <20181025141705.213937-15-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025141705.213937-15-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:16:15AM -0400, Sasha Levin wrote:
> From: Jeff Mahoney <jeffm@suse.com>
> 
> [ Upstream commit 35bbb97fc898aeb874cb7c8b746f091caa359994 ]
> 
> commit 909c3a22da3 (Btrfs: fix loading of orphan roots leading to BUG_ON)
> avoids the BUG_ON but can add an aliased root to the dead_roots list or
> leak the root.
> 
> Since we've already been loading roots into the radix tree, we should
> use it before looking the root up on disk.
> 
> Cc: <stable@vger.kernel.org> # 4.5

Ack for 4.4 stable.
