Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C49FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A731218C3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 17:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730157AbeLSRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 12:21:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55494 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728199AbeLSRVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 12:21:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9BF2781DED;
        Wed, 19 Dec 2018 17:21:31 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2DD79101E5A5;
        Wed, 19 Dec 2018 17:21:30 +0000 (UTC)
Date:   Wed, 19 Dec 2018 11:21:27 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Miroslav Benes <mbenes@suse.cz>, yamada.masahiro@socionext.com,
        michal.lkml@markovi.net, jeyu@kernel.org, pmladek@suse.com,
        linux-kbuild@vger.kernel.org, live-patching@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: use -flive-patching when CONFIG_LIVEPATCH is
 enabled
Message-ID: <20181219172127.o753af7pkrsttcgl@treble>
References: <20181219141744.32392-1-mbenes@suse.cz>
 <20181219165428.5udrppedpdvf2u7k@treble>
 <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YFH.7.76.1812191756450.17216@cbobk.fhfr.pm>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 19 Dec 2018 17:21:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2018 at 05:58:53PM +0100, Jiri Kosina wrote:
> On Wed, 19 Dec 2018, Josh Poimboeuf wrote:
> 
> > This option only makes sense for source-based patch generation, so isn't 
> > it a bit premature to make this change without proper source-based patch 
> > tooling?
> 
> The reality is though that before the full-fledged patch tooling exists, 
> people are actually already writing livepatches by hand, so this option is 
> useful for them.

Fair enough.

Though, upstream, almost everybody seems to use kpatch-build, for which
this patch doesn't help.  And people will continue to do so until we
have decent source-based tooling.  Will the klp-convert patches be
revived soon?

-- 
Josh
