Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E9DC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24F820A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 23:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0CQva+zC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C24F820A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732339AbeGKABH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 20:01:07 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41580 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732263AbeGKABH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 20:01:07 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so8317177ply.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 16:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PKtacqW7CvbYDKpjBkPOV7OOwj3aRe1DGnBJgjtB2bU=;
        b=0CQva+zCmdw5qFMuyH5nOaVC5cijEUWLvbJY1X28hnLYI4Dvv/QG7U72puRP43e/Zu
         asT3VUCkBvyRlXiSWlx9r7oqUhSWEgE+w8xojXq4zsk/jeNUYFAT9NNSi8ITmAghqA8y
         8nuPpVygt/Gk8TJE7B7GkytVQ3JTU0STN7lqcrqa4wFF5NTJBpgH3cp+O3KqeZp8Nby/
         ych3J1QnAopIfizI/zo94YtlN/0TaiLvld3DTpqzDXY8sK0UqGwECcUaSp1Oe8dmOfue
         a64/3946fm6RKgebdpJyYbn7ih6bF1/2FY2HS/xksu0KoCuPZ23+abNWKl8wzCDAoAiz
         Urhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PKtacqW7CvbYDKpjBkPOV7OOwj3aRe1DGnBJgjtB2bU=;
        b=h+mBCPnZSvWFGxeXbhmoI1dLQflEvYduj6mAeDaYIbHG+7FtXSwqJ0VYMiwqUCiax3
         RGtQqarwyLsKhOnpOOfU8MCgzizU37J2tw5eMlOAh1VWKKHuZAQ6781mmCixsApc8jId
         g933QO+NGnDvqTX25tMSCB/vTwB7rQNZ0Lbbyk6TDiFSMfhwT16WqWbIx3OLZqyqKaQ+
         tsjAILr+VsaMZdl1Ge9JQ1IOn2BtoOD8KzMoIwGh95x7Z1bTJt9Q4F6ms9UMJg+AG/XX
         uY5xTv0Yz1iDIEAIVLshWaMyeCrWaQFpdKjyfjoq/lVGein6YKsce9o+LhsNT+EiY2k/
         +2eg==
X-Gm-Message-State: APt69E0i/BroNxUD733xDBRFay86zAM76/8I8DQUAHmBy6x75E2JKSP5
        h2ZgWuJztNuIrBLyS9QDuTeVsQ==
X-Google-Smtp-Source: AAOMgpdNodCSF8upg9LPCaW7EVNozItiMc4WmJ4M0RtNOo3DSSi7PWqrN4bfI9+lXwjY03BL9EdTpA==
X-Received: by 2002:a17:902:b596:: with SMTP id a22-v6mr26079784pls.154.1531267176884;
        Tue, 10 Jul 2018 16:59:36 -0700 (PDT)
Received: from ?IPv6:2600:1010:b01a:526d:c00:ee53:3df2:3508? ([2600:1010:b01a:526d:c00:ee53:3df2:3508])
        by smtp.gmail.com with ESMTPSA id g15-v6sm19082636pfg.98.2018.07.10.16.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 16:59:35 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
Date:   Tue, 10 Jul 2018 16:59:34 -0700
Cc:     viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, jannh@google.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[cc Jann - you love this stuff]

> On Jul 10, 2018, at 3:44 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Provide an fsopen() system call that starts the process of preparing to
> create a superblock that will then be mountable, using an fd as a context
> handle.  fsopen() is given the name of the filesystem that will be used:
>=20
>    int mfd =3D fsopen(const char *fsname, unsigned int flags);

This is great in principle, but I think you=E2=80=99re seriously playing wit=
h fire with the API.=20

>=20
> where flags can be 0 or FSOPEN_CLOEXEC.
>=20
> For example:
>=20
>    sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
>    write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg

Imagine some malicious program passes sfd as stdout to a setuid program. Tha=
t program gets persuaded to write =E2=80=9Cs /etc/shadow=E2=80=9D.  What hap=
pens?  You=E2=80=99re okay as long as *every single fs* gets it right, but t=
hat=E2=80=99s asking a lot.

>    write(sfd, "o noatime");
>    write(sfd, "o acl");
>    write(sfd, "o user_attr");
>    write(sfd, "o iversion");
>    write(sfd, "o ");
>    write(sfd, "r /my/container"); // root inside the fs
>    write(sfd, "x create"); // create the superblock

=46rom cursory inspection of a bunch of the code, I think the expectation is=
 that the actual device access happens in the =E2=80=9Cx=E2=80=9D action. Th=
is is not okay. You can=E2=80=99t do this kind of thing in a write() handler=
, unless you somehow make every single access using f_cred, which is a real p=
ain.

I think the right solution is one of:

(a) Pass a netlink-formatted blob to fsopen() and do the whole thing in one s=
yscall. I don=E2=80=99t mean using netlink sockets =E2=80=94 just the nlattr=
 format.  Or you could use a different format. The part that matters is usin=
g just one syscall to do the whole thing.

(b) Keep the current structure but use a new syscall instead of write().

(c) Keep using write() but literally just buffer the data. Then have a new s=
yscall to commit it.  In other words, replace =E2=80=9Cx=E2=80=9D with a sys=
call and call all the fs_context_operations helpers in that context instead o=
f from write().=
