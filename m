Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC412081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC412081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbeLDONF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:13:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:48010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725910AbeLDONE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:13:04 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9EEA6ACED;
        Tue,  4 Dec 2018 14:13:01 +0000 (UTC)
Date:   Tue, 4 Dec 2018 15:13:00 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Petr Mladek <pmladek@suse.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 06/11] livepatch: Use lists to manage patches, objects
 and functions
In-Reply-To: <20181129094431.7801-7-pmladek@suse.com>
Message-ID: <alpine.LSU.2.21.1812041512460.2327@pobox.suse.cz>
References: <20181129094431.7801-1-pmladek@suse.com> <20181129094431.7801-7-pmladek@suse.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Nov 2018, Petr Mladek wrote:

> From: Jason Baron <jbaron@akamai.com>
> 
> Currently klp_patch contains a pointer to a statically allocated array of
> struct klp_object and struct klp_objects contains a pointer to a statically
> allocated array of klp_func. In order to allow for the dynamic allocation
> of objects and functions, link klp_patch, klp_object, and klp_func together
> via linked lists. This allows us to more easily allocate new objects and
> functions, while having the iterator be a simple linked list walk.
> 
> The static structures are added to the lists early. It allows to add
> the dynamically allocated objects before klp_init_object() and
> klp_init_func() calls. Therefore it reduces the further changes
> to the code.
> 
> This patch does not change the existing behavior.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> [pmladek@suse.com: Initialize lists before init calls]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Miroslav Benes <mbenes@suse.cz>

Acked-by: Miroslav Benes <mbenes@suse.cz>

M
