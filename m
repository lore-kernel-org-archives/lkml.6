Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31577C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE9892064C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="Z5StMnW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9892064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730159AbeKAFw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:52:57 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36499 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729921AbeKAFw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:52:57 -0400
Received: by mail-pg1-f195.google.com with SMTP id z17-v6so7948587pgv.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T43vL0uiUWLMgJnYgtALRl2GDqUTpSZ128iFcN3LwTs=;
        b=Z5StMnW+uJcea8edu3fwrTJ39z9eAu2Wk0XnPj3naZRd/dpQStWTMG2aH3xR2E977+
         g3jPQNe8t15BIwnEk6zsenrJAHJ5fVfvGcP8bbAFG26PkqrtMCXeU8mkxNuXopND8mGm
         nraD9oeGDKCfAk55EeFAyt1Yv2LFza0K+u9C6T70GCYTmEbtHK3Xtxp8VYAlFirFewOF
         Oaz2TNIuw2vm2KyHQgEliv+Py8fS7jRDvYapkil5b6XOIHBGu+jJx0IAjE9DSiUbYcIh
         f7OtNQoy+r2G1i3i1cmSBnLvEDSiSdRf0dDLy2+zjSfLGHjSVWRvdF4Py7YEcYLU3sdd
         UyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=T43vL0uiUWLMgJnYgtALRl2GDqUTpSZ128iFcN3LwTs=;
        b=eA7rIuHgGMpvEzlFKqfakMQq3AyN/sofeI5x7/Ggor4Brf6n4DzuTOgreInp0CKFyR
         Z67i+w6vJXodNG1FDLqzFM4mXjqljY29a3nYIlYC7Z7Z4cGC715Rp+ObIiJVoMg76lHL
         SVywPdHNa7ayacsriSEjhAZaMJDZ7JgmD+Sa5i1VK/mnyZJtXY8URRJABGlQXyeL7GYV
         jIP80HhUNkSUtdvRyTjqjXYQlYQG8joM+1LVjSmDLdID19fkeFZ5Wq7rupgADzy7IITX
         ZGIcsLw3Qc22jUZOAENN2ZNT+UAKVXMqH5WgIRgxk60B+nzQmkDpcCC2RgusBBSISaWQ
         Jtnw==
X-Gm-Message-State: AGRZ1gKwEQTb3YLQs42DkL8sv989j1DQytFPDUljjJcewjzhxRXR2LU5
        WAmrSC4W3wjqyd7uT+GmMANhug==
X-Google-Smtp-Source: AJdET5chQ7Cp9Q+mzYtWkZ5r8Db3lPrfyTqiRzxCHmrtmu2KH6bMrEOo4RqqGRkjBz1wz8+iKI4riQ==
X-Received: by 2002:a63:5664:: with SMTP id g36mr4522707pgm.313.1541019194338;
        Wed, 31 Oct 2018 13:53:14 -0700 (PDT)
Received: from ?IPv6:2600:1010:b021:f9e6:a9a5:9545:35ee:19c8? ([2600:1010:b021:f9e6:a9a5:9545:35ee:19c8])
        by smtp.gmail.com with ESMTPSA id t26-v6sm37407658pfa.158.2018.10.31.13.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:53:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <34204E6C-53C2-427D-A3B2-3D2E091D3E4B@amacapital.net>
Date:   Wed, 31 Oct 2018 13:53:11 -0700
Cc:     Igor Stoppa <igor.stoppa@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dave Chinner <david@fromorbit.com>,
        James Morris <jmorris@namei.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <83ED6142-A370-42FD-BBA4-95E5C3F998B3@amacapital.net>
References: <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com> <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com> <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco> <20181030192021.GC10491@bombadil.infradead.org> <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com> <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net> <2cfb3835-0c18-b3fb-1722-5d693ae0ecd2@gmail.com> <20181031101124.GO744@hirez.programming.kicks-ass.net> <34204E6C-53C2-427D-A3B2-3D2E091D3E4B@amacapital.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 31, 2018, at 1:38 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>=20
>=20
>>> On Oct 31, 2018, at 3:11 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>>>=20
>>> On Wed, Oct 31, 2018 at 12:15:46AM +0200, Igor Stoppa wrote:
>>> On 30/10/2018 23:02, Andy Lutomirski wrote:
>>=20
>>>> But I dislike allowing regular writes in the protected region. We
>>>> really only need four write primitives:
>>>>=20
>>>> 1. Just write one value.  Call at any time (except NMI).
>>>>=20
>>>> 2. Just copy some bytes. Same as (1) but any number of bytes.
>>>>=20
>>>> 3,4: Same as 1 and 2 but must be called inside a special rare write
>>>> region. This is purely an optimization.
>>>=20
>>> Atomic? RCU?
>>=20
>> RCU can be done, that's not really a problem. Atomics otoh are a
>> problem. Having pointers makes them just work.
>>=20
>> Andy; I understand your reason for not wanting them, but I really don't
>> want to duplicate everything. Is there something we can do with static
>> analysis to make you more comfortable with the pointer thing?
>=20
> I=E2=80=99m sure we could do something with static analysis, but I think s=
eeing a real use case where all this fanciness makes sense would be good.
>=20
> And I don=E2=80=99t know if s390 *can* have an efficient implementation th=
at uses pointers. OTOH they have all kinds of magic stuff, so who knows?

Also, if we=E2=80=99re using a hypervisor, then there are a couple ways it c=
ould be done:

1. VMFUNC.  Pointers work fine.  This is stronger than any amount of CR3 tri=
ckery because it can=E2=80=99t be defeated by page table attacks.

2. A hypercall to do the write. No pointers.

Basically, I think that if we can get away without writable pointers, we get=
 more flexibility and less need for fancy static analysis. If we do need poi=
nters, then so be it.=
