Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EEBC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B261720840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733012AbfAPWMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:12:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42593 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbfAPWMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:12:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 52F677F3F1;
        Wed, 16 Jan 2019 22:12:44 +0000 (UTC)
Received: from treble (ovpn-120-232.rdu2.redhat.com [10.10.120.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AF1A217DCB;
        Wed, 16 Jan 2019 22:12:42 +0000 (UTC)
Date:   Wed, 16 Jan 2019 16:12:39 -0600
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Miroslav Benes <mbenes@suse.cz>
Cc:     jeyu@kernel.org, jikos@kernel.org, pmladek@suse.com,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Periodic fake signal
Message-ID: <20190116221239.3mcf5vc33vbrj7rh@treble>
References: <20190115164507.14676-1-mbenes@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190115164507.14676-1-mbenes@suse.cz>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 16 Jan 2019 22:12:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 05:45:05PM +0100, Miroslav Benes wrote:
> I somehow forgot about this patch set. The discussion about v1 was
> inconclusive, so I'm sending it again with changes according to the
> feedback I got. I still think it is useful, so please consider.
> 
> Changes since v1:
> - timeout changed to 15 seconds (Josh)
> - make it wait for 15 seconds, no more, no less (Josh)
> - the message in klp_send_signals() is printed only once per transition
>   (Josh)
> - the counter is zeroed in klp_start_transition(), so that even
>   klp_reverse_transition() starts correctly (Petr)
> 
> Miroslav Benes (2):
>   livepatch: Send a fake signal periodically
>   livepatch: Remove signal sysfs attribute
> 
>  .../ABI/testing/sysfs-kernel-livepatch        | 12 ---
>  Documentation/livepatch/livepatch.txt         | 15 ++-
>  kernel/livepatch/core.c                       | 32 -------
>  kernel/livepatch/transition.c                 | 93 +++++++++++--------
>  kernel/livepatch/transition.h                 |  1 -
>  5 files changed, 59 insertions(+), 94 deletions(-)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh
