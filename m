Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E06FC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BB9213F2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="EvrxbjAs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbfAJVVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:21:41 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40199 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbfAJVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:21:40 -0500
Received: by mail-lf1-f66.google.com with SMTP id v5so9355299lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 13:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3KKJR9mTp8vNKTtSkcixpVbJb6gM3FrmsSjS+sCyukE=;
        b=EvrxbjAsiYFqiZvxKTS0RdzWN+nI2SRsmDR8x3evrkwWwCPjLp/700cfw7ZEDAFJ3P
         Rv6nvhzMA62v4VFcHUFRlpuzDnwfLwIRce1Hx0DNhVLmfrK1tE8Y74muo/0hEcJFTlub
         jJZH/Yg9OjXRFYi45EkXJslyfcaDLUXN3a7CEsENMcoeiheyMrI4+PXyeU3YLv4NoMhb
         1/ZbU4J5MuDV9F/uoVcAdsQU/WA5zXQGkTj4aHtUr5BjDzKjUBvjPAXOdkSw7owD+Hh5
         1mULws79rxvf0MDRG1O/FPgwqA0YScxQq85fxch+S1IGog7DRX7tYknxreWBIvJETVR0
         gNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3KKJR9mTp8vNKTtSkcixpVbJb6gM3FrmsSjS+sCyukE=;
        b=tjs28ayFeFR6sSVWNdj0PGPcbhWlcEEuJ3hS7Noy9U/H5vmx8vQwtwiIY2TpihAtDU
         j7UMXFGj+TyU/NG0n9b+vSFqUTw5MQ6W+gxrIwYIwfWeR1+HWEA2bOYmNJ7Cu8uPm1J9
         4O2JZyWjg2UBYpTDBXogox7UtmsR4bsc7tx6aZgrmnJh0Z8BNQnNvM8V9NbB9n+lDTte
         hdg9IxvBDXXKU7gdRCxsc6mo+79TErThSnsc4MgFuAYWMJHn7cq6lGUr4jqysrnicUTX
         JkU2KFbfyx3bUT/BsUCEyaj6/uoJCxhNSpW0UbVmy9OSyVNajpuNyU7COo7NeDZz9MTY
         pqGg==
X-Gm-Message-State: AJcUukfbogrMPZYaN50hMSim1bSuA87/mePSxNMOyWboYeMw4awUBT8j
        Ems35XkDMvblvhMvrfBgqG2O7iTAfJk4NQCAzDd2
X-Google-Smtp-Source: ALg8bN5gXDWM+tRzq3cBe/urd+abfBRRKq8/EQHSqFWsdvgU7Ms/mcGUkG6JLGICVYAxv3gmiRvmhRTwzglRRnv6NRg=
X-Received: by 2002:a19:f115:: with SMTP id p21mr6500257lfh.20.1547155298379;
 Thu, 10 Jan 2019 13:21:38 -0800 (PST)
MIME-Version: 1.0
References: <20190108213504.GA32901@beast> <alpine.LRH.2.21.1901110733060.7043@namei.org>
In-Reply-To: <alpine.LRH.2.21.1901110733060.7043@namei.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 10 Jan 2019 16:21:27 -0500
Message-ID: <CAHC9VhSma5JCGf6Fi9NS1841kuWAKm4h9d7qW94yJNEO5t8oHg@mail.gmail.com>
Subject: Re: [GIT PULL] blob-stacking updates for security-next
To:     James Morris <jmorris@namei.org>
Cc:     Kees Cook <keescook@chromium.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 3:34 PM James Morris <jmorris@namei.org> wrote:
> On Tue, 8 Jan 2019, Kees Cook wrote:
> > Hi James,
> >
> > Please pull these blob-stacking changes for security-next.
> >
> > Thanks!
>
> Merged to
> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git next-general
> and next-testing.
>
> This passes the SELinux testsuite on my system, and I'm now running this
> on my laptop.
>
> Please test!

While not exhaustive by any stretch of the imagination, you might want
to throw the audit-testsuite at it too.

* https://github.com/linux-audit/audit-testsuite

-- 
paul moore
www.paul-moore.com
