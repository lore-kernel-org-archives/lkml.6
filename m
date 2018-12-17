Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892D2C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605C320874
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732912AbeLQRDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:03:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37066 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbeLQRDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:03:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 998B5C067838;
        Mon, 17 Dec 2018 17:03:09 +0000 (UTC)
Received: from treble (ovpn-120-179.rdu2.redhat.com [10.10.120.179])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 51A6E6012D;
        Mon, 17 Dec 2018 17:03:08 +0000 (UTC)
Date:   Mon, 17 Dec 2018 11:03:05 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        mingo@kernel.org, bp@alien8.de, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] kbuild: error for CONFIG_ORC_UNWINDER is too much
Message-ID: <20181217170305.chni6e5vmev7hp4r@treble>
References: <869bc700-1d6d-b950-76c7-5d0fc589152c@lca.pw>
 <20181217161728.6875-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181217161728.6875-1-cai@lca.pw>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Mon, 17 Dec 2018 17:03:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 11:17:28AM -0500, Qian Cai wrote:
> Since ifdef will be evaluated immediately in the first phrase of the
> Makefile read-in, there is no guarantee that the value for
> CONFIG_ORC_UNWINDER will be up-to-date until in the second phrase that
> this recipe is ran.
> 
> include/config/%.conf: $(KCONFIG_CONFIG) include/config/auto.conf.cmd
> 	$(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> 
> Hence, change error to warning as this is essentially a best guess. The
> original bug can be reproduced this way,

But this still doesn't fix the root of the problem, that the check
relies on a stale auto.conf.

-- 
Josh
