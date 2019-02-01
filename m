Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7960C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C0F6214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="WLmWICq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfBAWg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:36:29 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43115 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbfBAWg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:36:28 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so3910392plb.10
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 14:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=unIUKIOIpdb0CuvttxDm321eRwR67PyotKPRUKjh8yQ=;
        b=WLmWICq+eZFtEXtjVFPFEyltm1+rOJqMJGpCcEDCFBr4KTDW+FGyUnV5fwV248ZFdh
         pVt3yuc8gIozPBDR6TT5DEa3FSKN8/8Q1XCjEZrx7lbMvJH2kxpPN9Jdy3F5E1OhZ5od
         ynw29HQ+YpbgK2J4EL2VC3vW0SOVeEcCNJeoIp5WQpskl0zDuorVqphfblSz5/3pomZR
         5lN3ZQOWICLj7Ie9Njhl/OZtXbjj8gpcSdYNIgqrlzLjZRP6AyVM5YnJdcSogNbEf5a9
         vD9ud0bg6cOnYnKHrXgR1Xjpo0FO780NnNyfWiEaada4VtndfnMZtnUedUdP234cI/8G
         tB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=unIUKIOIpdb0CuvttxDm321eRwR67PyotKPRUKjh8yQ=;
        b=l77w9FCA+DT9QI2C0cwzK5T9qs8n3IXLqzLcpqUHPgJH9UvUVRerel13QdWUCKCFl0
         OUFsgrs72/uCx6uXPQDdKpEnNZus5DGeB2xQ22XJDYxgZwfDdM2Mcn61X0WfqXDSCiNb
         TxZcosuqVAz9Qjh9wj4QIs966vxqeYIjbhQ6TmZxJetEyaj8TO8x/5qaEjih4xQoQDb9
         e31Y3CrNFV3UAdRwCHp71QAt6DZcU0haRWIC0/eQNtRZsqcFZOyAtgTYjj+ZeV9zvRG+
         G5c5h1F/uo3o8VJ1i+1aNkrPLq+7CQvz1Fotycc2WYPd15BCieyAef9tGkv3uJGou0rR
         XXew==
X-Gm-Message-State: AJcUukd4zZJ5TCmyqO2lhZhf51iTJd6ZGAX5cXNk0GTfGHFmL9e6UE6P
        ATuXASbO9ibjtAKxUo5bnW9peQ==
X-Google-Smtp-Source: ALg8bN6xrd4zu8SvmblEsVPpjMlRbv4Ol0pdsRwKXYAK3lxqxLMiQ3sgKeLOSioBB1/5kIl+mgTzhg==
X-Received: by 2002:a17:902:28e9:: with SMTP id f96mr41726521plb.169.1549060587935;
        Fri, 01 Feb 2019 14:36:27 -0800 (PST)
Received: from ?IPv6:2600:1010:b045:c5fd:90d1:5f19:5eef:2e8c? ([2600:1010:b045:c5fd:90d1:5f19:5eef:2e8c])
        by smtp.gmail.com with ESMTPSA id b5sm17695373pfc.150.2019.02.01.14.36.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 14:36:26 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 20/27] x86: Support global stack cookie
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16C101)
In-Reply-To: <CAJcbSZH3-TVxDsoRLKSuFLU2bHVV9FgDXtUaZFMim3k+4QU8Cg@mail.gmail.com>
Date:   Fri, 1 Feb 2019 14:36:24 -0800
Cc:     Andy Lutomirski <luto@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Juergen Gross <jgross@suse.com>,
        Joerg Roedel <jroedel@suse.de>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <777DD215-A4F5-454F-856F-FFE870F15CDD@amacapital.net>
References: <20190131192533.34130-1-thgarnie@chromium.org> <20190131192533.34130-21-thgarnie@chromium.org> <CALCETrVcU_9cczwbfVg6E2cey5B8O9k4j+jYgp0T-CiX9HELtA@mail.gmail.com> <CAJcbSZH3-TVxDsoRLKSuFLU2bHVV9FgDXtUaZFMim3k+4QU8Cg@mail.gmail.com>
To:     Thomas Garnier <thgarnie@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 1, 2019, at 12:21 PM, Thomas Garnier <thgarnie@chromium.org> wrote:=

>=20
>> On Fri, Feb 1, 2019 at 11:27 AM Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>>> On Thu, Jan 31, 2019 at 11:29 AM Thomas Garnier <thgarnie@chromium.org> w=
rote:
>>>=20
>>> Add an off-by-default configuration option to use a global stack cookie
>>> instead of the default TLS. This configuration option will only be used
>>> with PIE binaries.
>>>=20
>>> For kernel stack cookie, the compiler uses the mcmodel=3Dkernel to switc=
h
>>> between the fs segment to gs segment. A PIE binary does not use
>>> mcmodel=3Dkernel because it can be relocated anywhere, therefore the
>>> compiler will default to the fs segment register. This is fixed on the
>>> latest version of gcc.
>>=20
>> I hate all these gcc-sucks-so-we-hack-it-and-change-nasty-semantics
>> options.  How about just preventing use of both stack protector and
>> PIE unless the version of gcc in use is new enough.
>=20
> So fail the build in this scenario?

Fail the build or use some Kconfig magic to prevent this from being configur=
ed in the first place.

>=20
>>=20
>> Also, does -mstack-protector-guard-reg not solve this?  See
>> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D81708.  Or is there
>> another bug?  Or are you worried about gcc versions that don't have
>> that feature yet?
>=20
> I am worried about gcc versions that don't have this feature, yes.
