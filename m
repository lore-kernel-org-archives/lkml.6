Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55F14C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C5FF247B8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 16:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gaNaEnmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5FF247B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965686AbeF0QNy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 12:13:54 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:34887 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935022AbeF0QNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 12:13:47 -0400
Received: by mail-it0-f41.google.com with SMTP id l16-v6so7507474ita.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 09:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGwK2AAg3aD74rLUjf00h6vYrMjJyn0ZMtqiVqUuXeA=;
        b=gaNaEnmKht+zCn9K8s63+eAQZnlE6XcEc7Npm4PGupYdtOtjaJQWiRDdJ3KZJjulAX
         TigcPga8ZmCtpA5mUDSOTV2CqkeEyI454cN4uWDTa93nEjkNWi5gm3WszJ05nwu4yTsv
         6V84GAMVKXMLECkO6+bkmaur5JbIqDsNgoEAc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGwK2AAg3aD74rLUjf00h6vYrMjJyn0ZMtqiVqUuXeA=;
        b=KC5r/FIJdHYOVGOF7rjPrlQ5ArrUzGcgUxULNrdvWf/ae0WNW0ItIZo8WtMlnOSPi/
         UbsSIr+yD2hAQQGB3bfZbn2HL2QiMdfkK2LtwpEaAw/BlRzOon9R71jFY8mg0SzPQduL
         jwLL0yF2nQuC4Sr1/k+dFEeTesRpSP2e4NXTq1vt9vcqWgv8NXoQ6gfu9V/+gUGayp/6
         XPKLnx0WeH+f6EEZG5BCx2lwamIAC0pyaUPWU2FbjO7FRtyif99V96rnoX58TwBoZ3M6
         eG0696MPH0A3/tBFU9gdE8rIWxEcDMsUvxO92Ri7aDQhcrXBkKNqRM4nsXhB8961uNdc
         bYYw==
X-Gm-Message-State: APt69E1UF72+j6hja4EvbdM4GKAa3ftD47vhTCgQXoUgB5N3C0nHJF7g
        MR8wjBEDSLVmYKaXEcSCBXmPZP+TRf+t36JYBHE=
X-Google-Smtp-Source: AAOMgpd63HAjI0FN3BahsOq03lgDbtmHgWzcNulHsEcaWZnUfTxWfJd6FeBzWjcNllKMh0U9GJAI6BnHqEr2uexU+8E=
X-Received: by 2002:a02:664b:: with SMTP id l11-v6mr5724824jaf.70.1530116026070;
 Wed, 27 Jun 2018 09:13:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180626141300.4tkw3lculx6seyeh@pathway.suse.cz>
In-Reply-To: <20180626141300.4tkw3lculx6seyeh@pathway.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 27 Jun 2018 09:13:35 -0700
Message-ID: <CA+55aFwStj80KBHxn31r=Rk_M-zEMph3P6EWaT4-aJYCuvXuRw@mail.gmail.com>
Subject: Re: [GIT PULL] printk for 4.18-rc3
To:     Petr Mladek <pmladek@suse.com>
Cc:     SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        thierry.escande@linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 7:13 AM Petr Mladek <pmladek@suse.com> wrote:
>
> please pull one revert from
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/pmladek/printk tags/printk-for-4.18

That tag doesn't actually contain any revert.

              Linus
