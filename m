Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC94C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DEA208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2DEA208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728334AbeLETeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:34:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727388AbeLETeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:34:21 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE808307EA8A;
        Wed,  5 Dec 2018 19:34:20 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D960C5D96E;
        Wed,  5 Dec 2018 19:34:19 +0000 (UTC)
Date:   Wed, 5 Dec 2018 14:34:19 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v14 06/11] livepatch: Use lists to manage patches,
 objects and functions
Message-ID: <20181205193419.pyqbctefkypdpitf@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-7-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-7-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Wed, 05 Dec 2018 19:34:21 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:26AM +0100, Petr Mladek wrote:
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
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
