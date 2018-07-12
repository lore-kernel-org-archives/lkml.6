Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25847ECDFB0
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0CEF20BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 23:50:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="m2JhyE4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CEF20BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387760AbeGMACJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 20:02:09 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44951 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387740AbeGMACJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 20:02:09 -0400
Received: by mail-pl0-f67.google.com with SMTP id m16-v6so11345824pls.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 16:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/nUSTiQggfUKI5LhouiCJcMtpyh+XjXP8/cng7yWptU=;
        b=m2JhyE4eNmVUUpsKBQDfRKdrV8c5wG//fKckUPRx+qrwlRctPGZ9Xa3D37Jda76UHL
         MVIHnTedCkieha3KOOMBtj11RirMZuA7KIKQ12fLdFivk1mybR5EzOY3T713OzhJyNVZ
         Bba3UUSicyKxTHTd7iHFjxDfVgPMpOVtD2RKRVKDxAvhMJGZe5/wmfyFrFlhEohZ1eJx
         QeJLH1Y8PyAWadeqTiEcvhGhxTF0+ZDoxhDMOBM3XGdKi2HI/SRS+u67/JZxTHy3QXTD
         4UR7aTXy8WvhSw3BixCapv40fs81qRLh9k/1BmboBnUcNMbpc9AI8+V0nM9c1aNrbsRs
         ZvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=/nUSTiQggfUKI5LhouiCJcMtpyh+XjXP8/cng7yWptU=;
        b=UzbM/rELXxq3ujf5b/bnG8l8kwrlQ/pWJ477fCEoM76OlQ97VgW94NOhii5ugHErfV
         7xsdeYgLk7+e1fzUAOU09AEVpGEMJMwV4UYeKRs2mlOYPprLsr8Ai3iuvB4EtfMGJ047
         rUCa91kfjVA55ADDBXMsFkwDcuCSThyLZbPhjZB+iHcPr12ijfsMshZ4cuZa7Ei54rU4
         Yvsymbv8vmext9kY5FOna0TWsL5Xxl6YM2lgPOFeud80qYHTxp9XR/CllqNiDNM94Wcd
         vmkxf0r07ealWy8u7MORkZ+MagleM/qpGoayEeIbsx1QFGnYMjF60a/Ge/J+UvBMC60j
         dZRw==
X-Gm-Message-State: AOUpUlFHaPGEZVrfiyY6Y8Ul74bH1gS+CwPBzviCDf6PsnuGxi8FRa3z
        J4PtGNKPxwYPbOz+KMo0QUviFg==
X-Google-Smtp-Source: AAOMgpeiUqYlI8devJ8WQLoPGQmi5bbXDkbbUXv73u5s1f1xgp5qKZfUuM396bk5LTIwFegtwa2KiQ==
X-Received: by 2002:a17:902:3281:: with SMTP id z1-v6mr4127643plb.226.1531439415780;
        Thu, 12 Jul 2018 16:50:15 -0700 (PDT)
Received: from ?IPv6:2600:1011:b01e:e4d1:54df:ba07:cac1:aeab? ([2600:1011:b01e:e4d1:54df:ba07:cac1:aeab])
        by smtp.gmail.com with ESMTPSA id n86-v6sm43822452pfj.68.2018.07.12.16.50.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 16:50:14 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <23894.1531438559@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 16:50:13 -0700
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3236C75A-5D74-4BB4-A1EC-06F6E22D810C@amacapital.net>
References: <611054C7-D6E8-4C89-958E-3128C9305E1E@amacapital.net> <20180712223223.GA28610@thunk.org> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com> <16699.1531426991@warthog.procyon.org.uk> <18233.1531430797@warthog.procyon.org.uk> <22105.1531436081@warthog.procyon.org.uk> <23894.1531438559@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 4:35 PM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>> I tend to think that this *should* fail using the new API.  The semantics=
 of
>> the second mount request are bizarre at best.
>=20
> You still have to support existing behaviour lest you break userspace.
>=20

I assume the existing behavior is that a bind mount is created?  If so, the n=
ew mount(8) tool could do it in user code.=
