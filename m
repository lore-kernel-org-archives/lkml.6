Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF7B0C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FF220647
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 23:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtyO2jwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FF220647
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389173AbeG1BXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 21:23:00 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45158 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388870AbeG1BXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 21:23:00 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so11958805oic.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 16:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SMN4Vbw3eQemnz0Xkl7waLDH3Q4LcOUFWxVf2C6cb8I=;
        b=CtyO2jwTR+7nnjrkMKUQoUZ9HbrkI72tJ4lB4wjksJi5JTNOnvjDF/cR1nmfi0VqIU
         foUHqifUWmXb2Pb+tJF/c5pT04Z1tL593Cl7Z+VcPzYF5LWa3pUyl9+zogtL9voZKtqv
         XuLtmvZXe2QMmiAODRKW4vssISFo1expomBa0vbTufN8t5B+uO+6fakpy06l03G0GnP+
         SPLISj7Upw62FWpzoOVZXNUcyI+qhGR6YiCNiJH+ofquO/SIlWG7zh6sHW5E0Fbe0uge
         R9dsiw/NxTcu9HyUdRAihxFVCEjxo+QowRClntbkQR6MP33x948C0JUsgNFsRlb4Ox+q
         Qtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SMN4Vbw3eQemnz0Xkl7waLDH3Q4LcOUFWxVf2C6cb8I=;
        b=SH3kr7e6unGhglW6Ph/2aTn5kO3Kw1kZTUA6RFV66lHHfiiqMQ3hfcG16xzronUkTR
         qH+ki1+lF6E5YYjy7ZXXBAjXyMTWGu5NqIiSyMsvFAKUFXOKzEX99VhtoGoB6ghaacvN
         AhmHBjxLp9fNhQrXgbydEZ2vzbUhO0BJCY4RayAulYvtgRCTzgLM7iuODKe64XFoTTcG
         uRrSTF4sRoRRnS3unqvqxmbBVE21YnEzVw+3G1Kvh6eT+Q5GzsWQuR56LHG9MlYUQ4WN
         j/buAGkbAi3Z3v7Fi+EgWXGsGbghQLvSoEb7GyFDOWe4OUZcJW+KaCAF/81XtldO4iqi
         qVcg==
X-Gm-Message-State: AOUpUlFPk6hLo8QlbM+5TkWGKIIy/kcO1+PUj0+hPp3Hwx6ISV7w9lYF
        5obOdY3ouTdcdeWvpnRl0eCDehJuF+8EEp6rcI0nZw==
X-Google-Smtp-Source: AAOMgpeZ+NYze2VkLRG0RWxU3bXLkIqLpbFuuCtV3q1hB/To3Miw7dQL1zdNGk3zJf6a122LHiMAbTQLU09r5Ikkujw=
X-Received: by 2002:aca:1c04:: with SMTP id c4-v6mr9094351oic.173.1532735926272;
 Fri, 27 Jul 2018 16:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0SdSPkimsk-MW7oSQO-Y64X-LD4JXnuPsZXKuz=y1_Kg@mail.gmail.com>
 <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271291017.9458.7827028432894772673.stgit@warthog.procyon.org.uk>
 <21395.1532735340@warthog.procyon.org.uk> <21746.1532735504@warthog.procyon.org.uk>
In-Reply-To: <21746.1532735504@warthog.procyon.org.uk>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 28 Jul 2018 01:58:19 +0200
Message-ID: <CAG48ez3vVEEbJzbK8Nc6HA-W7Sp7==ZXanzFUKo527p4U=OFpA@mail.gmail.com>
Subject: Re: [PATCH 34/38] vfs: syscall: Add fsinfo() to query filesystem
 information [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 28, 2018 at 1:51 AM David Howells <dhowells@redhat.com> wrote:
> David Howells <dhowells@redhat.com> wrote:
>
> > One thing I'm confused about is that fat has both a codepage and a charset and
> > I'm not sure of the difference.
>
> In fact, it's not clear that the codepage is actually used.
>
>         warthog>git grep '[.>]codepage'
>         fs/fat/inode.c: opts->codepage = fat_default_codepage;
>         fs/fat/inode.c:                 opts->codepage = option;
>         fs/fat/inode.c: sprintf(buf, "cp%d", sbi->options.codepage);

        sprintf(buf, "cp%d", sbi->options.codepage);
        sbi->nls_disk = load_nls(buf);
        if (!sbi->nls_disk) {
                fat_msg(sb, KERN_ERR, "codepage %s not found", buf);
                goto out_fail;
        }
