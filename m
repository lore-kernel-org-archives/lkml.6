Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C0ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4726208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="0mVp8KiA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4726208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbeGMPRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:17:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:39859 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729676AbeGMPRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:17:00 -0400
Received: by mail-pf0-f194.google.com with SMTP id s21-v6so22815534pfm.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6xJ/Xf3cuHjZTcEzylG7SrD9VrFah5VdnZ+dUl5LKUc=;
        b=0mVp8KiAwXo0Wq8kvPrV3Z1tnLcQwvKWmKPg7PkGFe5pRz1JzNwo5/sIcJUJ8mq/XA
         yuTRu0DUShxQXuJHYRy3KmnNnM6HDjg189QVwtjwKg318fvALufnW2Q+/vplmBn265R5
         mihLnBiRrqxLgrWNf4c25QvT20V2Eud1k0fznWPuSg7Pmvmg4vrvwgL7rWQ2pjH5Y5go
         f/xB3OME+LBRmcFwQI2Dj3kEqnxj2lvCuqICZI8NoZvn+Ob9z1pOn7l+4tX6YhE8fFOG
         wfmI6zW/+wySeE5rHr8iHMUKEunKXYgz1ky/fYxb3tpei0qSnpT+fYL0jk8GiEoSTHee
         foZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=6xJ/Xf3cuHjZTcEzylG7SrD9VrFah5VdnZ+dUl5LKUc=;
        b=ItFd/6EORHcVOyOPRhHBvaKDI15cPPeXvxolwwdeBGsOIOytHo2WNIcdyT4bbpx1Cx
         0SuA7yCzE63MAsHVQmRtfCZlh0fJk7yTX44y0Mo52cGYKf/rJLezJl36YeuZAXwjyVpB
         TqQuxCnqgvbeOzmgWoVpMfZG8VaPWXzZpUnRm84Ivh7KVqOcutUMkc51cFSY7nDcNyxX
         7aPxzWBjAHDIVeGzvuM231T+SySFlqcMuD9s1IPArIWNOI8iITrmqxiWpmJd5Mp4DLq1
         ri3dDvCrPdnA4VZ68EUcsBANNf7TDaaib1ziE9XKNw48VkLPzCfR1ORULzNEa5QjZf9x
         yIVw==
X-Gm-Message-State: AOUpUlHpTUh1dp/t/nAHFH8EhyszwIAq4km7gm5df2aQgejIr7AODcIA
        3UAHsR3P0kugZKLdUpFx2AmlKA==
X-Google-Smtp-Source: AAOMgpcUCcKC2Cz4tiBI60HEPG9ec1iNCW/9SA+n8kL4wx1l/Z+lhNTSR4FxSOYt5n3VeNDkWAa76Q==
X-Received: by 2002:a65:5683:: with SMTP id v3-v6mr6294757pgs.176.1531494120191;
        Fri, 13 Jul 2018 08:02:00 -0700 (PDT)
Received: from ?IPv6:2600:1011:b010:c408:9b8:4cb7:ed0e:1060? ([2600:1011:b010:c408:9b8:4cb7:ed0e:1060])
        by smtp.gmail.com with ESMTPSA id x2-v6sm48992555pfi.166.2018.07.13.08.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 08:01:58 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <21131.1531488422@warthog.procyon.org.uk>
Date:   Fri, 13 Jul 2018 08:01:56 -0700
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, Tycho Andersen <tycho@tycho.ws>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F80F34FD-CFD3-4A53-AECC-AEC8D9EF3EAE@amacapital.net>
References: <CA+55aFzaTQJp6aHG_9+W2ShxeZncq7k9G3FkVFjFm7W=ECUiMw@mail.gmail.com> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net> <17749.1531429218@warthog.procyon.org.uk> <21131.1531488422@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 13, 2018, at 6:27 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Whilst I'm at it, do we want the option of doing the equivalent of mountat=
()?
> I.e. offering the option to open all the device files used by a superblock=

> with dfd and AT_* flags in combination with the filename?
>=20

Isn=E2=80=99t that more or less what I was suggesting?  I suggested dfd and p=
ath and I also suggested just an fd and letting the caller open the file its=
elf.

> David
