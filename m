Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05C2C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6855320867
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6855320867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbeITSyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 14:54:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:36360 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387418AbeITSyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 14:54:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A81F6B091;
        Thu, 20 Sep 2018 13:10:40 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 11241DAE2D; Thu, 20 Sep 2018 15:10:39 +0200 (CEST)
Date:   Thu, 20 Sep 2018 15:10:39 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 14/22] btrfs: implement btrfs_debug* in terms of helper
 macro
Message-ID: <20180920131039.GY5847@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20180919220444.23190-1-linux@rasmusvillemoes.dk>
 <20180919220444.23190-15-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919220444.23190-15-linux@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 12:04:36AM +0200, Rasmus Villemoes wrote:
> First, the btrfs_debug macros open-code (one possible definition of)
> DYNAMIC_DEBUG_BRANCH, so they don't benefit from the HAVE_JUMP_LABEL
> optimization.
> 
> Second, changes on x86-64 later in this series require that all struct
> _ddebug descriptors in a translation unit use distinct identifiers.
> 
> Using the new _dynamic_func_call_no_desc helper macro from
> dynamic_debug.h takes care of both of these.
> 
> Cc: linux-btrfs@vger.kernel.org
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: David Sterba <dsterba@suse.com>

Per the cover letter, I assume you'll take it through your git tree.
