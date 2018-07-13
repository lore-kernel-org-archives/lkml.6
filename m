Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5FD6214AB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 00:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dSmX0otC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5FD6214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387817AbeGMAgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:36:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:41340 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeGMAgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:36:40 -0400
Received: by mail-pf0-f195.google.com with SMTP id c21-v6so16936408pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 17:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wPpcCU3p9jYCxBzorwoZM/1CzfSSTO/zU904RZghXVs=;
        b=dSmX0otCKv5e9JrDvnZyQZPjimVZUG0aOLri0+gEsfgQCRhiB/vN6BtNxYByTkYiPo
         S2nPPdvoI1eO1Yrlh7z7ODPXm5lbn8fRHhPKObaa5hKwvntUIqnCb7Ql/4LdoevLm0fS
         HhWEX9t2NCFidGFOIlUJBM5z1REnhK6/AbvN+jOCtrymwLeKS+w70K8TKCub/okC9Sb3
         8ZK/1lwZCLvqHMST0w1x+H9ujO20XsTXmImFofKLfQvQRPE5Seo4EuM52M1Uzf6v1eGD
         TkTSGeAnh/ZyNG1HbsbEjocg9gAvIC6YWisth/5Tvpv3M71EbfnR8KcTspuz2m8n7m9g
         fD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wPpcCU3p9jYCxBzorwoZM/1CzfSSTO/zU904RZghXVs=;
        b=n6C+N6NGBMmlwEOFupq+bcA3Fa5O12ezjdISMF8YP3FnTiVYmW5j+c1RzCaFIkT0MB
         MB2k6yO7rXPOvIqbiLtAkzUipucziDwnjk8s94HhgAxMdTb1F9etwFeOZyvDBEbrJCLu
         jHs2Dn6rGE0TDBPonN2Ovvs9ZvVNKu50nSR7NsnKYXLazJh0BySECuju3jLKuwIByyDG
         ULLmAZMbh0PYl0vBck7CYLP3BI5fB5N3Vwhch5B2t1pfCz/YA2OYCaFyH2lW0Eda8p1J
         yFI7UB1GI43OfdsWyxVoaqyefRUOFeBbawk+1nCCqNe9diTPUQx/UN7e8Ox5fpQyI/tR
         QrxA==
X-Gm-Message-State: AOUpUlH0ltclvOCOZO8CmFyP7iCumjEMJ3kiousyf/mvTiwxDZxJzI1o
        E4r+L0a407fJxkCUEYruqVF7xQ==
X-Google-Smtp-Source: AAOMgpdJVvrU9pU8+1OlT9cS3A6pAdiVotxPwxKOCE7I2iwycj6e4027c6Qwdufj4Cnd6//oNwZAmQ==
X-Received: by 2002:a63:5b0d:: with SMTP id p13-v6mr4064701pgb.202.1531441479989;
        Thu, 12 Jul 2018 17:24:39 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id r19-v6sm12364588pgo.68.2018.07.12.17.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 17:24:37 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <26064.1531440190@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 17:24:36 -0700
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A7CC3BF-5F4E-4624-A129-4BD0434D0747@amacapital.net>
References: <3236C75A-5D74-4BB4-A1EC-06F6E22D810C@amacapital.net> <611054C7-D6E8-4C89-958E-3128C9305E1E@amacapital.net> <20180712223223.GA28610@thunk.org> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk> <22105.1531436081@warthog.procyon.org.uk> <23894.1531438559@warthog.procyon.org.uk> <26064.1531440190@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 5:03 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>>>> I tend to think that this *should* fail using the new API.  The semanti=
cs
>>>> of the second mount request are bizarre at best.
>>>=20
>>> You still have to support existing behaviour lest you break userspace.
>>>=20
>>=20
>> I assume the existing behavior is that a bind mount is created?  If so, t=
he
>> new mount(8) tool could do it in user code.
>=20
> You have a race there.
>=20
> Also you can't currently directly create a bind mount from userspace as yo=
u
> can only bind from another path point - which you may not be able to acces=
s
> (either by permission failure or because it's not in your mount namespace)=
.
>=20

Are you trying to preserve the magic bind semantics with the new API?  If yo=
u are, I think it should be by explicit opt in only. Otherwise you risk havi=
ng your shiny new way to specify fs options get ignored when the magic bind m=
ount happens.=20=
