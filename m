Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E58C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE8520657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:38:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="yYwHEQV1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EE8520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeKAFiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:38:19 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40575 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbeKAFiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:38:19 -0400
Received: by mail-pf1-f194.google.com with SMTP id g21-v6so8174617pfi.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 13:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wYRl2nIl2oqguxZ1X8ZXF9UQZmSmIAImxumc+qMW7uM=;
        b=yYwHEQV1z936eZGT73F4i1zeJvZgJT+mRzd61T/yXHTpY6lkMgGnk9ySULYd/z4TDr
         7wK2+G5FFHnGQQg0Nt7oWyaMew/+Kn2lUIKddj6iWjA2RDIesgRLCBd9gyjWWyQ4NlCN
         +OElytpIGOKKbblEF3EOWmnW76/BaX5yyKvcv1tEu/28RH7A0YQ7MO13kZygdWN6t+bY
         DXLr/cIm8mjfLEYYnrkSYB4LE3PMQemSKPYvr50eCa0EWS9fB022PKRX6FqDtrOiEDuP
         uUlLLfw88TRSqULS9OwnA1uVCSz87vowRQ71zf7SnAIWBeUs4IOU3cdVMtBXXgMSMsMH
         bJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wYRl2nIl2oqguxZ1X8ZXF9UQZmSmIAImxumc+qMW7uM=;
        b=MAxjLOscAhxQS9ASvPsoVYoP3/HQk2jEGy3cjV/RXZkyVCY5SqVfoH3605QfjkPOCU
         E6ocXd4YF4iEefpciplBewQ0kkkFa7ucB46CAxSkc0+9ccxG/N5lOcH3pVDYbVXPkqhJ
         i9dMdlhSoMbbKfK8FTWjAgn20qrtsv39GmPWGdok56Pin6k5MoZB/H4m5/mMENTY5UVN
         CXakQ0dBnbzTvX8d0N5J5yD57TEOTSFQrWggWp32oyEq1QPTG/s8bR7TKE7B7ff9YBEI
         lf8RbGum9znIcPlq6lyOZ8daVMAnY8neQQVcg5x9CxBDe1rSbUXdIrBlmbwxPXVvC61B
         JyKg==
X-Gm-Message-State: AGRZ1gLgD8SNAdTBSzhd7rLRuHRL1Sjye62MuCTf0RavQNI6EYvSdES0
        2wVkb/VRTqIiCWqHbXWrMG1BZQ==
X-Google-Smtp-Source: AJdET5c+EaPrQ5LWWxciDUVeLJ1+axxIo3aKXaiHyGx1n04jXAmNLWuxXaImo7eByjBlTkJSrGrPzQ==
X-Received: by 2002:a62:ce8e:: with SMTP id y136-v6mr4905988pfg.201.1541018319739;
        Wed, 31 Oct 2018 13:38:39 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:fdea:9bef:2d79:82f? ([2601:646:c200:7429:fdea:9bef:2d79:82f])
        by smtp.gmail.com with ESMTPSA id m7-v6sm34221842pgq.59.2018.10.31.13.38.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 13:38:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 10/17] prmem: documentation
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181031101124.GO744@hirez.programming.kicks-ass.net>
Date:   Wed, 31 Oct 2018 13:38:37 -0700
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
Message-Id: <34204E6C-53C2-427D-A3B2-3D2E091D3E4B@amacapital.net>
References: <40cd77ce-f234-3213-f3cb-0c3137c5e201@gmail.com> <20181030152641.GE8177@hirez.programming.kicks-ass.net> <CAGXu5jJftJ+Hq+jrZGHX5CTDLWOog7kGsd_Ne=yMvrRs__skSg@mail.gmail.com> <0A7AFB50-9ADE-4E12-B541-EC7839223B65@amacapital.net> <20181030175814.GB10491@bombadil.infradead.org> <20181030182841.GE7343@cisco> <20181030192021.GC10491@bombadil.infradead.org> <9edbdf8b-b5fb-5a82-43b4-b639f5ec8484@gmail.com> <BAA65A07-F3AF-4209-9D18-7075CEF11EE8@amacapital.net> <2cfb3835-0c18-b3fb-1722-5d693ae0ecd2@gmail.com> <20181031101124.GO744@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 31, 2018, at 3:11 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>> On Wed, Oct 31, 2018 at 12:15:46AM +0200, Igor Stoppa wrote:
>> On 30/10/2018 23:02, Andy Lutomirski wrote:
>=20
>>> But I dislike allowing regular writes in the protected region. We
>>> really only need four write primitives:
>>>=20
>>> 1. Just write one value.  Call at any time (except NMI).
>>>=20
>>> 2. Just copy some bytes. Same as (1) but any number of bytes.
>>>=20
>>> 3,4: Same as 1 and 2 but must be called inside a special rare write
>>> region. This is purely an optimization.
>>=20
>> Atomic? RCU?
>=20
> RCU can be done, that's not really a problem. Atomics otoh are a
> problem. Having pointers makes them just work.
>=20
> Andy; I understand your reason for not wanting them, but I really don't
> want to duplicate everything. Is there something we can do with static
> analysis to make you more comfortable with the pointer thing?

I=E2=80=99m sure we could do something with static analysis, but I think see=
ing a real use case where all this fanciness makes sense would be good.

And I don=E2=80=99t know if s390 *can* have an efficient implementation that=
 uses pointers. OTOH they have all kinds of magic stuff, so who knows?=
