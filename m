Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A90DEA5250
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2603C21471
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 17:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="ZrdmskWs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2603C21471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeGLSFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:05:17 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33681 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbeGLSFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:05:16 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so21037728pfi.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 10:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/oLEOluK5VW8jRxl1ijH/HwWNUZeCrIQp22drECYiaY=;
        b=ZrdmskWsYrHVOnG4cqx28imWxeqvTniaJOVZzdl8sS+oklXeM3rPillXdRhrnbX/hJ
         TAdWmqSyYmLF64DnVppCTJe9OumLPXGttpBjoMPc75wzUVl/vEr9SkZBvJxVoA9RMUO+
         vUYEjF6MvVlmCsojc1RG+y56SUZjYzLx+2r/nzKLCeDTP9yAp/P2UuAeejn1Lv6B5jFc
         LGv7D1+krgFi3KYrqpa+hZKUlXon75ax9hV5EwSufs82SRExzlZ+5G4JQoAaRGEkXhQR
         hrwmT2AxEf5oIXDpKmdwoZDgzvBlOqInhYAEDVP0TRXMnrw8nzfkNGGG3VuiBoxYT/c/
         VcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/oLEOluK5VW8jRxl1ijH/HwWNUZeCrIQp22drECYiaY=;
        b=BnYDFZ3JOE097RDM17lCgOO5CL/79K8kEgMq6cNHjGsnWhfZSpoZpmlVXSYh3aJJ3u
         dXI/RQbazpprBpXLM7nuEI3sHQb8kK9MT/kUq8WnimilRFDKrSo/I/u7fe4bTGDUYxfn
         y3p5gOCSB8I4qDhVtLCmMn3TJluXhT4JLgRmDCi1uiPfZnfRi1DSAmEHf2ETPivawPvx
         zhHynN7F+HJfrji2dVN4nVbKHy3U7yIg3NQJRlMrY5o5Cll99c45VW65jt1KuCiI2Ja8
         JWUqW3cLDM45NWtUINhhqssSPkiOr8Awhif7YBHwN+P86bxjl1OvSqJHZXucIDrRIacD
         aOJg==
X-Gm-Message-State: AOUpUlHVXZ6Jx9E+UBJqJi1P1EcTF4ZM8DVohaYCXh+ffugBaNux/h+V
        W0YATaiweBvgKBZgrmmBxf8OOA==
X-Google-Smtp-Source: AAOMgpdmoxGVxxJBBZkUgsbKi58hXSUrMdrD7NSceuIEIsw0wIEtHmIPrOtNqxMQBvdJF9+FS3crMg==
X-Received: by 2002:a65:45cc:: with SMTP id m12-v6mr3011361pgr.160.1531418079280;
        Thu, 12 Jul 2018 10:54:39 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id b66-v6sm7797381pgc.15.2018.07.12.10.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 10:54:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180712165821.GY30522@ZenIV.linux.org.uk>
Date:   Thu, 12 Jul 2018 10:54:36 -0700
Cc:     David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, tycho@tycho.ws
Content-Transfer-Encoding: quoted-printable
Message-Id: <719E8034-2E07-45C0-9B04-838431F5309F@amacapital.net>
References: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <7002.1531407244@warthog.procyon.org.uk> <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net> <20180712165821.GY30522@ZenIV.linux.org.uk>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 9:58 AM, Al Viro <viro@ZenIV.linux.org.uk> wrote:
>=20
>> On Thu, Jul 12, 2018 at 09:23:22AM -0700, Andy Lutomirski wrote:
>>=20
>> As a straw man, I suggest:
>>=20
>> fsconfigure(contextfd, ADD_BLOCKDEV, dfd, path, flags);
>>=20
>> fsconfigure(contextfd, ADD_OPTION, 0, =E2=80=9Cfoo=3Dbar=E2=80=9D, flags)=
;
>=20
> Bollocks.  First of all, block device *IS* a fucking option.
> Always had been.  It's not even that it's passed as a separate
> argument for historical reasons - just look at NFS.  That argument
> is a detached part of options, parsed (yes, *parsed*) by filesystem
> in question in whatever way it prefers.

Fine, then generalize it. fsconfigure(context, ADD_FD, =E2=80=9Csome fs-spec=
ific string explaining what=E2=80=99s going on=E2=80=9D, fd);  The point bei=
ng that there are tons of cases where the filesystem wants to identify some b=
acking store by some device node, and it seems like we should support someth=
ing along the lines of a modern *at interface.

If I=E2=80=99m writing a daemon that deals with filesystems, I don=E2=80=99t=
 want an API that looks like do_god_knows_what(context, =E2=80=9Cfilesystem s=
pecific string that may contain a path to a device node or a network address=
=E2=80=9D). That API will be a pain to use, since that opaque string may com=
e from some random config file and I have no clue what it does. If I want to=
 pass a device node or other object to a filesystem, I want to pass an fd (s=
o I can use openat, SCM_CREDS, etc), and I want it to be crystal clear that I=
=E2=80=99m passing some object in. And if I tell a filesystem to access the n=
etwork, I want it to be entirely clear which network namespace is in use.

I realize that doing this right is tricky when there are lots of legacy file=
systems that parse opaque strings. That=E2=80=99s fine. We can convert thing=
s slowly.
