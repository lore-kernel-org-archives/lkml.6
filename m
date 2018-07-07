Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C131C3279B
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:55:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1C822ACA
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 00:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1C822ACA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xmission.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbeGGAzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 20:55:43 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52328 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeGGAzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 20:55:41 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fbbVk-0000SR-Ex; Fri, 06 Jul 2018 18:55:40 -0600
Received: from [97.119.167.31] (helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1fbbVj-0004Aq-0N; Fri, 06 Jul 2018 18:55:40 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
References: <1530871650-3582-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
        <CA+55aFzK5z4VQEMQAOqVHXpm+o_gd_eg5Vecck07E=WmoO6BFA@mail.gmail.com>
        <CAGXu5jKrM_3ymnmcJ+AE1A3uVPDJykRj0z5B8sDoxM6zUnX-Rg@mail.gmail.com>
        <945be212-8e82-9dd8-930f-4e5c11dcae77@i-love.sakura.ne.jp>
Date:   Fri, 06 Jul 2018 19:55:26 -0500
In-Reply-To: <945be212-8e82-9dd8-930f-4e5c11dcae77@i-love.sakura.ne.jp>
        (Tetsuo Handa's message of "Sat, 7 Jul 2018 08:35:28 +0900")
Message-ID: <87zhz3sw3l.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fbbVj-0004Aq-0N;;;mid=<87zhz3sw3l.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.167.31;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+sEQcyQSz5Ln9RLAPpnwEvrx7Atb2Ytog=
X-SA-Exim-Connect-IP: 97.119.167.31
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH] uts: Don't randomize "struct uts_namespace".
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> writes:

> I'm waiting for response from makedumpfile developers.
>
> But makedumpfile is a tool for saving kernel crash dump.
> If makedumpfile cannot work, we cannot use kernel crash dump.

I suspect the version string is comparable in size to the pointer to the
version string and as such would be a better candidate to include in the
handful of elf notes we provide for the mkdumpfile & it's ilk to bootstram.

I assume getting the kernel's version string will be enough to track
back to an individual vmlinux and figure out the layout of everything
else.

Eric
