Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A75ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D3D220854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D3D220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbeGWLNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:13:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:46936 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388071AbeGWLNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:13:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8C6D2AFCD;
        Mon, 23 Jul 2018 10:12:31 +0000 (UTC)
Date:   Mon, 23 Jul 2018 12:12:30 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Validate module/old func name length
In-Reply-To: <1532080002-10724-1-git-send-email-kamalesh@linux.vnet.ibm.com>
Message-ID: <nycvar.YFH.7.76.1807231212190.997@cbobk.fhfr.pm>
References: <1532080002-10724-1-git-send-email-kamalesh@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jul 2018, Kamalesh Babulal wrote:

> livepatch module author can pass module name/old function name with more
> than the defined character limit. With obj->name length greater than
> MODULE_NAME_LEN, the livepatch module gets loaded but waits forever on
> the module specified by obj->name to be loaded. It also populates a /sys
> directory with an untruncated object name.
> 
> In the case of funcs->old_name length greater then KSYM_NAME_LEN, it
> would not match against any of the symbol table entries. Instead loop
> through the symbol table comparing them against a nonexisting function,
> which can be avoided.
> 
> The same issues apply, to misspelled/incorrect names. At least gatekeep
> the modules with over the limit string length, by checking for their
> length during livepatch module registration.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

