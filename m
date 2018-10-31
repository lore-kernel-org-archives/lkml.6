Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C2BDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CFC920664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CFC920664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeJaWCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:02:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58748 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729130AbeJaWCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:02:44 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 03832C04C26D;
        Wed, 31 Oct 2018 13:04:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6A47D194B7;
        Wed, 31 Oct 2018 13:04:44 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 31 Oct 2018 14:04:45 +0100 (CET)
Date:   Wed, 31 Oct 2018 14:04:42 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181031130442.GB9007@redhat.com>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030150254.GB3385@redhat.com>
 <20181030155403.GC7343@cisco>
 <20181030162752.GB7643@redhat.com>
 <20181030163926.GC7643@redhat.com>
 <20181030172143.GD7343@cisco>
 <CAGXu5j+MYbAiSxdhLnQHdOZC-B=FWZoODxzwkYVEUqDc9SHnBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5j+MYbAiSxdhLnQHdOZC-B=FWZoODxzwkYVEUqDc9SHnBQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 31 Oct 2018 13:04:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Kees Cook wrote:
>
> I'd like to avoid changing the return value of __secure_computing() to
> just avoid having to touch all the callers. And I'd prefer not to
> change __seccomp_filter() to a bool, since I'd like the return values
> to be consistent through the call chain.

Sure, please forget.

> I find the existing code more readable than a single-line return, just
> because it's very explicit. I don't want to have to think any harder
> when reading seccomp. ;)

Heh ;) Again, please forget, this is cosmetic.

But I simply can't resist. I asked this question exactly because I was
confused by these 2 lines:

		if (__seccomp_filter(this_syscall, NULL, true))
			return -1;

		return 0;

to me it looks as if we need to filter out some non-zero return values and
turn them into -1. I had to spend some time (and think harder ;) to verify
that this is just the recursive call and nothing more.

nevermind, please ignore.

Oleg.

