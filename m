Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85A7C476E8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72494208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VZ0otPOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72494208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732415AbeGLQmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:42:21 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35052 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeGLQmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:42:21 -0400
Received: by mail-io0-f195.google.com with SMTP id q4-v6so28784518iob.2;
        Thu, 12 Jul 2018 09:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FhpM/08uzNucjIkrBK1MW4AOCttLe59TUAf6vhz7Bdo=;
        b=VZ0otPOC5r3NuziRW0eJhXGpsxJdmpnK2cvMu3jjx+5E2jvlVwCIMaH6bOCy8jxFoP
         I2Sn8TwrEWAdApy3+V4LBo5Ru+NpE07+V5WvEnQWzXNAmjI4Bi69XGFU8j9BnAv6DELK
         RYWj5Ngh4iF+g5460ECTyCoxPvA1lOTvAPBFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FhpM/08uzNucjIkrBK1MW4AOCttLe59TUAf6vhz7Bdo=;
        b=TfRuGpBQTDedHSLPZHCInC5VDT6ulaXJHvgtocR5O21czqAYiYbfDcXdozFlm+0HEH
         ybWWX+wj8co9bAwNuYBabrh4uHjIzBdjZFY/P5IUz5R5/RYm/99phLSn2oVJwgosTraZ
         50/5LB/CHBgldn6A8kj8UtS3GZHGNBd696FKjBCfwcs2lmi6h2Rku41qrlm1y+hJ96b5
         k51XFMSS1GocDCpl9jo02aCFyHL7VIBgq6NEVPa4nOw8RfXElcXRUsrUCtP3NmJ23z7s
         KdZC8nUjQI5mnuS9Nw+rIGwz1xD7W9LtsAoBDtBw9phFHdOV/jF9qm7oTqj8hMl5fnZy
         MW4A==
X-Gm-Message-State: APt69E0rshxr4WW7Y3qab2h3Qtwc6M5puzR10NlAKbuWOeF3uhhnmPwH
        77w5a2v5Ooa2owb+sYxpxQWbJ0bEu+0Vh7IhdJOz0cBY
X-Google-Smtp-Source: AAOMgpeSBUUdZPw0H9wa4e3G0rGzKtEcmZcLE8dVpHYmP2IUz+fv3VUZx3PTwhIppMnxKpFVSR3WUnAhmLSNXCqSacc=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr29776048iov.203.1531413123824;
 Thu, 12 Jul 2018 09:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
In-Reply-To: <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 09:31:52 -0700
Message-ID: <CA+55aFxGqLfu1pjT5421k7KbSd94NWU4fw0H-zJe-qSWwBfAeQ@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     David Howells <dhowells@redhat.com>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 9:23 AM Andy Lutomirski <luto@amacapital.net> wrote=
:
>
> (Al- can=E2=80=99t we just stop allowing splice() at all on things that d=
on=E2=80=99t use iov_iter?)

We could add a FMODE_SPLICE_READ/WRITE bit, and let people opt in to
splice. We probably should have.

But again, that really doesn't change the fundamentals.  Using write()
for commands is stupid.

It also means that you have to _parse_ all the damn input at that
level, which is a mistake too. It easily leads to insane decisions
like "you have to use 'write()' calls without buffering", because
re-buffering the stream is a f*cking pain.

Just say no. Seriously. Stop this idiotic discussion.

I'm just happy this came up early, because that way I know to look out
for it and not merge it.

                 Linus
