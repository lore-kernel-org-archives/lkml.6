Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B138C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9A34213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9A34213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbeLESpK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:45:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56316 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727297AbeLESpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:45:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9B9E230C57E8;
        Wed,  5 Dec 2018 18:45:09 +0000 (UTC)
Received: from redhat.com (dhcp-17-208.bos.redhat.com [10.18.17.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1173E5D756;
        Wed,  5 Dec 2018 18:45:07 +0000 (UTC)
Date:   Wed, 5 Dec 2018 13:45:07 -0500
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Jason Baron <jbaron@akamai.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 01/11] livepatch: Change unsigned long old_addr ->
 void *old_func in struct klp_func
Message-ID: <20181205184507.teyjmy4bp7tlrtge@redhat.com>
References: <20181129094431.7801-1-pmladek@suse.com>
 <20181129094431.7801-2-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181129094431.7801-2-pmladek@suse.com>
User-Agent: Mutt/1.6.2-neo (2016-08-08)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 05 Dec 2018 18:45:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:44:21AM +0100, Petr Mladek wrote:
> The address of the to be patched function and new function is stored
> in struct klp_func as:
> 
> 	void *new_func;
> 	unsigned long old_addr;
> 
> The different naming scheme and type is derived from the way how
                                                       ^^^^^^^^^^^
s/the way how/the way

> the addresses are set. @old_addr is assigned at runtime using
> kallsyms-based search. @new_func is statically initialized,
> for example:
> 
>   static struct klp_func funcs[] = {
> 	{
> 		.old_name = "cmdline_proc_show",
> 		.new_func = livepatch_cmdline_proc_show,
> 	}, { }
>   };
> 
> This patch changes unsigned log old_addr -> void *old_func. It removes
                     ^^^^^^^^^^^^
s/unsigned log/unsigned long

> some confusion when these address are later used in the code. It is
> motivated by a followup patch that adds special NOP struct klp_func
> where we want to assign func->new_func = func->old_addr respectively
> func->new_func = func->old_func.
> 
> This patch does not modify the existing behavior.
> 
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- Joe
