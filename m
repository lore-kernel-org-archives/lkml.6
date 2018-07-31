Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29839C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8081B20841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8081B20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731865AbeGaUZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:25:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729772AbeGaUZW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:25:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F02187C6A9;
        Tue, 31 Jul 2018 18:43:45 +0000 (UTC)
Received: from treble (ovpn-120-73.rdu2.redhat.com [10.10.120.73])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CACC7C5C;
        Tue, 31 Jul 2018 18:43:45 +0000 (UTC)
Date:   Tue, 31 Jul 2018 13:43:44 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jeremy Cline <jcline@redhat.com>
Cc:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 0/2] fs/quota: Fix potential spectre v1 gadgets
Message-ID: <20180731184344.yspy7sjbec74d5w6@treble>
References: <20180731013731.1987-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180731013731.1987-1-jcline@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 18:43:46 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 31 Jul 2018 18:43:46 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jpoimboe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:37:29AM +0000, Jeremy Cline wrote:
> Hi folks,
> 
> This series unifies XQM_MAXQUOTAS with MAXQUOTAS, which were both being
> used to perform bounds checks on arrays, and then sanitizes 'type' so it
> can't be used in speculative out-of-bounds array access.
> 
> Jeremy Cline (2):
>   fs/quota: Replace XQM_MAXQUOTAS usage with MAXQUOTAS
>   fs/quota: Fix spectre gadget in do_quotactl
> 
>  fs/quota/quota.c               | 14 +++++++-------
>  include/linux/quota.h          |  8 +-------
>  include/uapi/linux/dqblk_xfs.h |  5 -----
>  3 files changed, 8 insertions(+), 19 deletions(-)

Looks good to me, though this might hinge on the discussion with
Andreas:

  https://lkml.kernel.org/r/E3E7B6AF-3819-4998-9B12-DACB4EBC14F1@dilger.ca

-- 
Josh
