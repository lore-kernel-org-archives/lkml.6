Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D85ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C2B520854
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 17:15:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA8wh/ar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2B520854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731210AbeGMRaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 13:30:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729960AbeGMRai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 13:30:38 -0400
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFA0B208E3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531502107;
        bh=tPItqzWUd1hNxjiVqRA0FEq9BtGKWcnD4SXbFcueOZo=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YA8wh/arNlV/g2jslc59Cbsnd2W0bJFbMnja5wwKLR4dSV7Wt9Gkhendiop75ucr9
         +9Qcq+TWbjyoCsTwWiuW22R7LKcpFmL7KHS1T1+7klEn+aB4wmrBcgnuvEuk28hsIm
         7AuoqRfX7XPJV+HNyuAZkjs9+wplaEbEgDZXojIc=
Received: by mail-wm0-f47.google.com with SMTP id z6-v6so5001025wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 10:15:06 -0700 (PDT)
X-Gm-Message-State: AOUpUlGgUdDQxAHLyJ3g+i6BGGoVQ7aqeuTDsisswkQLwpbn9O4Ll4tx
        sH2c0Oivk/F9OkpvDF3Hdgpyu2PFEQN8R39Y3Yc8LA==
X-Google-Smtp-Source: AAOMgpfb+TtUKM/DCy1LNzkTITDUb9e/Qc78UAc97jZYWwcXLm7oKLZ/0FLlSuVml9iMt81mjsXNnq6ECjU4WHpEN+Y=
X-Received: by 2002:a1c:34c9:: with SMTP id b192-v6mr4653307wma.21.1531502105369;
 Fri, 13 Jul 2018 10:15:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 10:14:44
 -0700 (PDT)
In-Reply-To: <26576.1531496428@warthog.procyon.org.uk>
References: <CA+55aFzaTQJp6aHG_9+W2ShxeZncq7k9G3FkVFjFm7W=ECUiMw@mail.gmail.com>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
 <17749.1531429218@warthog.procyon.org.uk> <21131.1531488422@warthog.procyon.org.uk>
 <F80F34FD-CFD3-4A53-AECC-AEC8D9EF3EAE@amacapital.net> <26576.1531496428@warthog.procyon.org.uk>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 13 Jul 2018 10:14:44 -0700
X-Gmail-Original-Message-ID: <CALCETrXS9ShF0k_tiFcBN6NY6ODCvhuZLh15VeHC5JUz9gWQuA@mail.gmail.com>
Message-ID: <CALCETrXS9ShF0k_tiFcBN6NY6ODCvhuZLh15VeHC5JUz9gWQuA@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 8:40 AM, David Howells <dhowells@redhat.com> wrote:
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>> > Whilst I'm at it, do we want the option of doing the equivalent of
>> > mountat()?  I.e. offering the option to open all the device files used by
>> > a superblock with dfd and AT_* flags in combination with the filename?
>> >
>>
>> Isn't that more or less what I was suggesting?
>
> Yes, you suggested that.  I'm asking if we actually need that.
>

Suppose some program in a container chroots itself and then tries to
create an fscontext backed by "/path/to/blockdev".  The syscall gets
intercepted by a container manager.  That manager now has a somewhat
awkward time of mounting the same fs, although it could use
"/proc/PID/root/path/to/blockdev", I suppose.  Even that approach has
some potentially awkward permission issues.  I would defer to the
people who actually write software like this, but I can imagine fds
being considerably easier to work with.
