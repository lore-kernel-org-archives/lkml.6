Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79E7ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8734E21477
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 20:34:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DwVBxvjB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8734E21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbeGLUqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 16:46:06 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35407 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732461AbeGLUqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 16:46:06 -0400
Received: by mail-it0-f65.google.com with SMTP id l16-v6so8614891ita.0;
        Thu, 12 Jul 2018 13:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05Aiq0Kf6T/X33YBNKlI0zJhPSuRJ+K7UU2Ba1x3VDQ=;
        b=DwVBxvjBcQALo09PAkfelrEKTsQcVY1ewbJsWceC5AjSIcwcYVPkVtWrQNRqd2HZx5
         UNltbN9jfH48INC2Gakivm4BmTPF4Mm61e5fZ7UJy5/qomXduzk2Nh/bqy4FOUT9Lw8Y
         qisd236fPeAyadINkrNKclblgUkvL9LimBtFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05Aiq0Kf6T/X33YBNKlI0zJhPSuRJ+K7UU2Ba1x3VDQ=;
        b=B57+Co9riGuiFDvBeB1SmA1aQdT/580PbGNHTTay0ngtHI4Xd+Ld2iRZyjgplrs0Nc
         PTNwwlSAxXYmSyR7W2UxZanD9cueaYC0VW6gVRrYqTVn2YN2QDdjLD335CdQOJ1uVYv5
         mz4+ITRjiPQCpyT0ymVlxMmNljN43Wl/Eu3NGuqw20jcah2E+Ze/1YOZXUpvrSE8v4HX
         kgtbJ7aBylgGvvl2338B97M6nI5gWZ3U2WYElgxAtPxjVe/VCO4GP7ZwDe6ATNOSrJ8/
         5deXrZ7F9rWmFpLTbmwvpHnDPjRdfGk1yEvR4O5Ctl7KgT5EZfY6PG+KRB2CfZ9XhDzc
         Eryw==
X-Gm-Message-State: AOUpUlHoQeB4rca6zGu6pz6vAwL/m5x0Fuas2vrHrabdZ8nYiS5SXAsK
        Sq5Wpsr4sTVCDifMpIHOL0700aIwTwFxYXmuKQCjiA==
X-Google-Smtp-Source: AAOMgpfsT2Y1qBxCRzr9G2Jd2W6fAe0Q0f0+g3DWOTnqJWkSOpKmYGJolJx4W+uc/dRxRcch7h+boeSLV9TpJYtm184=
X-Received: by 2002:a24:d0d7:: with SMTP id m206-v6mr2518873itg.1.1531427694109;
 Thu, 12 Jul 2018 13:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk>
In-Reply-To: <16699.1531426991@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 13:34:42 -0700
Message-ID: <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 1:23 PM David Howells <dhowells@redhat.com> wrote:
>
> It's all very well to say "use file->f_creds".  The problem is this has to be
> handed down all the way through the filesystem and down into the block layer
> as appropriate to anywhere there's an LSM call, a CAP_* check or a pathwalk -
> but there's not currently any way to do that.

.. and the reason is simple: you damn well shouldn't do that.

The unix semantics are that credentials are checked at open time.

If your interface involves checking credentials at write() time, your
interface is garbage shit.

Really.

This is the whole "write() is only for data". If you ever have
credentials mattering at write time, you're doing something wrong.

Really really.

Don't do it.

             Linus
