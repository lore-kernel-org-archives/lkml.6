Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45F7C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F4420671
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 19:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="A1y2A1KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F4420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389351AbeG0VHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 17:07:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39841 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388815AbeG0VHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 17:07:36 -0400
Received: by mail-wr1-f65.google.com with SMTP id h10-v6so6117738wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 12:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IbnwVp5MZEwj785JUfzZdK9LdSvpo7Vav5Q34iUp4GE=;
        b=A1y2A1KN1rbUU/3loC7YyHzyr6Wf5FrBpioq7L4DGz4j+FYi0zLFBUtWGSq27gC0jP
         m9b1Wk1tl8PEVUDcyXUx7Om37+i/ZBjlyTG8xJxKmp6acYOJpWMoQ0rzwjb4I1cDPnw4
         ipE3C15sWlmPsqk6ViOO69peUj1LpaMwoblyzSvhQhRNqxTvqzGeu1wnIxg64mBy3yMF
         yejABa/sNetZ5X0Me2iYHREWWVJjB1/LBjYM949Jor8GMAuOXSDDmXLftotUFFJYHdNf
         YpAK//ZafYFtbi2OVbdaI01R6CITntxTPRX2gewEZSROXcH4p01IRtxmnkUnG8X5GMwT
         QJyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IbnwVp5MZEwj785JUfzZdK9LdSvpo7Vav5Q34iUp4GE=;
        b=tMLNvSqqmz6ByqttNqD+78mfDg7smCLaDhue3d2WHCPj1q4QyoTsm7GAjx1lfX0TXK
         +SN0FzW/Giz3svPwJ7GsBRzus+KXCgRbAhZ6OFqMehbB4PENuymT8sRzPqChyNmn9UPP
         wvSvfvX9sTHUGmuiJKgENn9x9kPwDOwizrXic/7W5o7mTzvjGBdorW2p3S/MqMvTMc6H
         nUKKVyZ7y9yrCPjiayHNLb3cAu26Vfg02uSZsKKgB96D9CqRSmwgiNAvp4fVnZbumfYS
         DeEPvgX50N2pvtIf1pCh6oFZBo1fbH1B+JK8HYbZW3g8kXjsdYWGQE83kjoWZT5rxSty
         wofA==
X-Gm-Message-State: AOUpUlHEYvkXNoqFGZZSJykvPcFft+bRjiacx68Yos8IPCPqQxcVIuDQ
        d7dKbipnfqZ9LjvU8NVgaaoHdpkNXs42mOO4dbgD8Q==
X-Google-Smtp-Source: AAOMgpeNsnvxN7sAVFOhoYhBPZFsZkpnjUT6QicyZCiGctY3Wxe+3Te2ugofX3FG4Er+qzdp3i1BnTYjDMzLkQWxAPQ=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr6165595wra.120.1532720653907;
 Fri, 27 Jul 2018 12:44:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:548:0:0:0:0:0 with HTTP; Fri, 27 Jul 2018 12:43:53 -0700 (PDT)
In-Reply-To: <D09916DC-DA22-48AA-A62B-F874BB3C15BC@amacapital.net>
References: <153271267980.9458.7640156373438016898.stgit@warthog.procyon.org.uk>
 <153271288242.9458.18050138471208178879.stgit@warthog.procyon.org.uk> <D09916DC-DA22-48AA-A62B-F874BB3C15BC@amacapital.net>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jul 2018 12:43:53 -0700
Message-ID: <CALCETrVmZKeFv7b+c8hBQ-3Dcryv7VXTHdyWftvNG1G4aQk9Mw@mail.gmail.com>
Subject: Re: [PATCH 30/38] vfs: syscall: Add fsmount() to create a mount for a
 superblock [ver #10]
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 27, 2018 at 12:27 PM, Andy Lutomirski <luto@amacapital.net> wro=
te:
>
>
>> On Jul 27, 2018, at 10:34 AM, David Howells <dhowells@redhat.com> wrote:
>>
>> Provide a system call by which a filesystem opened with fsopen() and
>> configured by a series of writes can be mounted:
>>
>>    int ret =3D fsmount(int fsfd, unsigned int flags,
>>              unsigned int ms_flags);
>>
>> where fsfd is the file descriptor returned by fsopen().  flags can be 0 =
or
>> FSMOUNT_CLOEXEC.  ms_flags is a bitwise-OR of the following flags:
>
> I have a potentially silly objection. For the old timers, =E2=80=9Cmount=
=E2=80=9D means to stick a reel of tape or some similar object onto a reade=
r, which seems to imply that =E2=80=9Cmount=E2=80=9D means to start up the =
filesystem. For younguns, this meaning is probably lost, and the more obvio=
us meaning is to =E2=80=9Cmount=E2=80=9D it into some location in the VFS h=
ierarchy a la vfsmount. The patch description doesn=E2=80=99t disambiguate =
it, and obviously people used to mount(2)/mount(8) are just likely to be co=
nfused.
>
> At the very least, your description should make it absolutely clear what =
you mean. Even better IMO would be to drop the use of the word =E2=80=9Cmou=
nt=E2=80=9D entirely and maybe rename the syscall.
>
> From a very brief reading, I think you are giving it the meaning that wou=
ld be implied by fsstart(2).
>

After further reading, maybe what you actually mean is:

int mfd =3D fsmount(...);

where you pass in an fscontext fd and get out an fd referring to the
root of the filesystem?  In this case, maybe fs_open_root(2) would be
a better name.

This *definitely* needs to be clearer in the description.
