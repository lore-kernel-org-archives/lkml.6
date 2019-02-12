Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1721DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D633B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 12:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549973041;
	bh=0qzqDptQ1uhO41LDdqX/qnJIXyJJSXYP5ZR3/cethJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x9QaZ4FQGMFbW98+ACMeVi6gw33cIx1oLNGeIIUFVJlmvUtGQNgzYPHzTHyYgqC5n
	 DaP7wJ/fq5Lnyf1GxREMvhacwh4iyEYB8usnmaR3xsZuh7hLrA8/lCIDlP4rE74eg6
	 3oSlKhtBPGHr9hob6IjCLXv0jB98oE9l5Nv891h8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729187AbfBLMEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 07:04:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:33834 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726026AbfBLMEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 07:04:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEBDCABEC;
        Tue, 12 Feb 2019 12:03:58 +0000 (UTC)
Date:   Tue, 12 Feb 2019 13:03:58 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: fix potential build error in compaction.h
Message-ID: <20190212120358.GC7584@dhcp22.suse.cz>
References: <20190208080437.253322-1-yuzhao@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190208080437.253322-1-yuzhao@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-02-19 01:04:37, Yu Zhao wrote:
> Declaration of struct node is required regardless. On UMA system,
> including compaction.h without proceeding node.h shouldn't cause
> build error.

Anybody requiring struct node shouldn't depend on compaction.h to get
the declaration. Anyway have you seen an actual build breakage?
-- 
Michal Hocko
SUSE Labs
