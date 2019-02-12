Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C1C282CE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B63B217FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 00:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbfBLA7V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 19:59:21 -0500
Received: from www262.sakura.ne.jp ([202.181.97.72]:57582 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbfBLA7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 19:59:20 -0500
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C0xFNk071749;
        Tue, 12 Feb 2019 09:59:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp);
 Tue, 12 Feb 2019 09:59:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav304.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x1C0xE24071745;
        Tue, 12 Feb 2019 09:59:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id x1C0xEbp071744;
        Tue, 12 Feb 2019 09:59:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <201902120059.x1C0xEbp071744@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [PATCH] LSM: Ignore =?ISO-2022-JP?B?InNlY3VyaXR5PSIgd2hlbiAibHNtPSIg?=
 =?ISO-2022-JP?B?aXMgc3BlY2lmaWVk?=
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     Kees Cook <keescook@chromium.org>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Date:   Tue, 12 Feb 2019 09:59:14 +0900
References: <201902120021.x1C0LeYB051392@www262.sakura.ne.jp> <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
In-Reply-To: <CAGXu5jJ86XosW71111EaaSKcVwzw+UYvi4j619KwoBn=DNwrNw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:
> On Mon, Feb 11, 2019 at 4:21 PM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > Kees Cook wrote:
> > > To avoid potential confusion, explicitly ignore "security=" when "lsm=" is
> > > used on the command line, and report that it is happening.
> >
> > To maintain the existing behavior of CONFIG_DEFAULT_SECURITY, I also suggest this change.
> > This saves e.g. Ubuntu users who are using only AppArmor from explicitly specifying
> > security=apparmor when they don't want to enable other LSM_FLAG_LEGACY_MAJOR modules.
> 
> No, this completely disables the purpose of lsm=
> 
> I don't understand the use-case you're concerned about?

The purpose of lsm= remains.

I worry that distro users who don't explicitly specify security= parameter
suddenly find TOMOYO messages because TOMOYO is no longer exclusive.
There are two ways for avoiding it. One is to explicitly specify security=
parameter. The other is to remove tomoyo from CONFIG_LSM. This change adds
the third way; preserve current security= behavior until they start explicitly
specifying lsm= parameter.
