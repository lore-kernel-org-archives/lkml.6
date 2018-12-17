Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492FCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23E0D2145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 11:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbeLQLln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 06:41:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:54418 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727347AbeLQLln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 06:41:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B91D1ACE3;
        Mon, 17 Dec 2018 11:41:41 +0000 (UTC)
Date:   Mon, 17 Dec 2018 12:41:41 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, Jessica Yu <jeyu@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] livepatch: check kzalloc return values
Message-ID: <20181217114141.qwq5q6zdaikakihw@pathway.suse.cz>
References: <1544806570-21299-1-git-send-email-hofrat@osadl.org>
 <1544806570-21299-2-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1544806570-21299-2-git-send-email-hofrat@osadl.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2018-12-14 17:56:10, Nicholas Mc Guire wrote:
> kzalloc() return should always be checked - notably in example code
> where this may be seen as reference. On failure of allocation in
> livepatch_fix1_dummy_alloc() respectively dummy_alloc() previous
> allocation is freed (thanks to Petr Mladek <pmladek@suse.com> for
> catching this) and NULL returned.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: 439e7271dc2b ("livepatch: introduce shadow variable API")

It is a bit confusing that it was not re-send together with v2
of the other patch. It should not get lost!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
