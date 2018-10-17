Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DATE_IN_PAST_03_06,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D63ECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A22512098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 11:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r1F8+IfJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A22512098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeJQTqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 15:46:24 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33922 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeJQTqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 15:46:23 -0400
Received: by mail-ot1-f65.google.com with SMTP id v2so18708427otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 04:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmFzpzLwkb/SlSKZkR9GMeizWWUcvBFzw3hPJEuOTlc=;
        b=r1F8+IfJg1bhpjD7mFcvoGen5x8nI8ooYfgv2kxBDAJb89/hcVM1wVPyviRfas30DJ
         hNymNxYq60Fg6BIMPuzWMTCrZpKCq1JNbTfbBPGlE0PtYrefMJZ3pzLfvwCsw+gImFSa
         tChzxbgQOP4NRSwyEEJHHXELCM581HNCNM2sbo4TLfd2d5S58AqO1ZaVJY8YGXlZ7ezz
         sFyApcD/q6ZA/ujibEA63x3dxkfZcA0himoieWRGeRXTOrB+J8sAs6+h9lOJVfU/yOF8
         6pdudPaE+yvgxGZAaQigPCfVgr7K8Q1e0MSXmRnpWDg/sJ1tpaVVKDzQMWX+IYe1CfF0
         AFbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmFzpzLwkb/SlSKZkR9GMeizWWUcvBFzw3hPJEuOTlc=;
        b=SNo6t8TNPsR0XdMA4EIxyVjeeiE1fVQQxlSSJrzZFpvcKejLjUANZ0Yhvvellb0dQS
         2U3CpDaRUqR3v9FPw3xWMNnUwcNJ6k/+WmfMFbgNCNW1NopWkEKQxZEGJWQKBMTPgsRQ
         GTAcDjaOj27KqVdE4yll8597N9Bmevl1jGY0Bn4h++dZ4MzWQ1yFghTA2nK9K0MBZoUO
         GKQ5h9cnrSNsJMkUQuz5Mi17fKjHCugaitFa9M0Kuj994kBtRCbjxPdMA/7H6vMDKtHu
         AUowwKYkVp5o0EK+kUnAITRPjB9/lxhxpVYxA48iCwzvoCWiYJaDmUU/KO05CIMyOpYm
         w1Yg==
X-Gm-Message-State: ABuFfojFEDVd2El5zek9AuGxdEEIu9s0jGmZJ164Sj3VMK4TA6ymdwLV
        DJNvz+TUdDHbR7RpwM5klnVjkrTllflCVH4bpc8=
X-Google-Smtp-Source: ACcGV63e8sj8goaLlXecRPaqKO+SSXrGSc/petWhSKLCniqUqDD2H2HGPHEEppMB7DJKOhJxQcYywuKmT4YeMlBhPcM=
X-Received: by 2002:a9d:11b2:: with SMTP id v47mr15357823otf.281.1539777062825;
 Wed, 17 Oct 2018 04:51:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-4-tycho@tycho.ws>
 <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
In-Reply-To: <CALCETrXGBZyqDb7DEysHmOkxaBrXUp4s2X08HfqZkpjM28s3Hg@mail.gmail.com>
From:   Michael Tirado <mtirado418@gmail.com>
Date:   Wed, 17 Oct 2018 07:25:00 +0000
Message-ID: <CAMkWEXNN2_saQN-yQ7Pwgau1YTYQQuih+KLnKj5-cOYa6CyMPw@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] seccomp: add a way to get a listener fd from ptrace
To:     Andy Lutomirski <luto@amacapital.net>,
        Tycho Andersen <tycho@tycho.ws>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 12:02 AM Andy Lutomirski <luto@amacapital.net> wrote:
>
> Or we could have a
> seccomp() mode that adds a filter but only kicks in after execve().
>
> --Andy

Hey that's a pretty good idea, then we could block execve in a seccomp
launcher without post-exec cooperation, or that patch I wrote that used
an execve counter which probably should have been through prctl instead.

As for the rest of this long thread,
has anyone mentioned a specific use case that I missed? I didn't see code
patches sent to the linux-kernel mailing list, only this discussion thread
so I'm probably missing some important context.  Was it for loading modules
into kernel from a container?  Couldn't that be handled completely in user
space without using seccomp at all? Do we really want to turn seccomp into
a container IPC mechanism? It seems out of scope IMO, and especially
if it could be handled in user space already.

Why does it have to be a file descriptor, what would you be writing back to?
Could waitid be used somehow instead of ptrace to get notification
from a filter?
tldr, can someone kindly tell me how to find all the details surrounding these
patches so I can stop making really bad guesses?
