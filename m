Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D4C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80D4824585
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="P6a+NFQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80D4824585
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934278AbeFVQJF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:09:05 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:38020 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933961AbeFVQJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:09:02 -0400
Received: by mail-pl0-f68.google.com with SMTP id d10-v6so3712984plo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Aknf5KSP5rADVcwENSz++BxmASuDrwPngcyq5/7MLCc=;
        b=P6a+NFQHWSWEMsb/nWCmMQ+uomVmEKhpMBk0w77cJVHrYULtB5SjZ8O+rLcrvdlgZ6
         3BK4ZgWLm2dW+qVhjPVz9WEYq6M0wBN/OoCr2C0O7Uo/X0q/dadX7U5pml/Q2zkftAhq
         9qMNRlYy8RRiKsRfZ0Vj6tcccpnrCa9QaHxT/ZhYKdLFJCfJNd+PYzWVPVGy2TbJyEJU
         S4WsXtI4prGmOn2XIzrl0cjdZrAy4dwNTaznpjBeUojjlT1UgPZEVACza1lboiqGoxHI
         2m8Nzbt8MjVYvI42wrRMZujdImHLGfZJhY9P/Omvb8+haSo0XWpatGko9C0AA5wANT/H
         grFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Aknf5KSP5rADVcwENSz++BxmASuDrwPngcyq5/7MLCc=;
        b=AYD5vOheoEvGe59w3WA/XL/PoXQzsAQY913MmT7p7SdUg27Kw0gMhY6jii8xw/Lzj0
         9Z3xgq4sbSH+EexZR68H+vRvRtG5sjmDzGsPhbHAjdYe53ctnIqK8i522h57llZiecoz
         izjAnXWcSR+UV2gGPvbmFw7hRq9cfW3fsqtmmaLpbDMn+tlbVraigRmlVlidOSsU0MP6
         7s+/VNADqev0lzptD0BWHmXRFmG59+sqjX+xKeZdZNyuEASqbIJVDKmy+h3zy0NhUYLC
         YdMg8XnDgSbFuRlZI/UmviABcOKaiq6cmGod9HrW0JZvwqECN0LTZBsJsfTlIScRjX8b
         7sfA==
X-Gm-Message-State: APt69E2gYQdDdv3DHJ7ero/MvVQM1UVy74UexTFFbJfgGnP0qotDF5vb
        ju4/wrKPHZxqkGYyrNu+YNCqaw==
X-Google-Smtp-Source: ADUXVKLiVTww/WXj/RKEm0hWhVo49WeT21Y/MxMZTVeQSoYMBB8YNxRPPz/wMTZwJsS2Dk795/KUqg==
X-Received: by 2002:a17:902:b48f:: with SMTP id y15-v6mr2320063plr.261.1529683741866;
        Fri, 22 Jun 2018 09:09:01 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:2cd9:e530:8535:a508:f820? ([2600:1010:b065:2cd9:e530:8535:a508:f820])
        by smtp.gmail.com with ESMTPSA id p16-v6sm14943709pfd.47.2018.06.22.09.09.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 09:09:00 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/7] x86/fsgsbase/64: Introduce FS/GS base helper functions
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <alpine.DEB.2.21.1806221735400.2402@nanos.tec.linutronix.de>
Date:   Fri, 22 Jun 2018 09:08:59 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <851713FF-90E1-434A-BC31-5DE437AB530E@amacapital.net>
References: <1529536506-26237-1-git-send-email-chang.seok.bae@intel.com> <1529536506-26237-2-git-send-email-chang.seok.bae@intel.com> <alpine.DEB.2.21.1806221610500.2402@nanos.tec.linutronix.de> <CALCETrVzLT0AwUFxZGjuREaontqzJe0DEccNFwLTKdLcLxcARA@mail.gmail.com> <alpine.DEB.2.21.1806221735400.2402@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2018, at 8:39 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
>=20
>> On Fri, 22 Jun 2018, Andy Lutomirski wrote:
>> On Fri, Jun 22, 2018 at 7:28 AM Thomas Gleixner <tglx@linutronix.de> wrot=
e:
>>>> +unsigned long read_task_fsbase(struct task_struct *task)
>>>> +{
>>>> +     unsigned long fsbase;
>>>> +
>>>> +     if (task =3D=3D current) {
>>>> +             fsbase =3D read_fsbase();
>>>> +     } else {
>>>> +             /*
>>>> +              * XXX: This will not behave as expected if called
>>>> +              * if fsindex !=3D 0. This preserves an existing bug
>>>> +              * that will be fixed.
>>>=20
>>> I'm late to this party, but let me ask the obvious question:
>>>=20
>>>    Why is the existing bug not fixed as the first patch in the series?
>>=20
>> IIRC that was how I did it in the old version of this code.  I think
>> it did it because it was less messy to fix the bug after cleaning up
>> the code, but I could be remembering wrong.
>=20
> Fair enough. Though the general rule is: Fix bugs first and then do
> features, unless you really need the extra step to fix it proper.
>=20
> Now in that case the real question is whether this is a bug or just a
> slight incorrectness which has no practical impact. If it's the latter,
> then introduce the new function which does the right thing first and make
> the new fs/gs base functions use it without having a blurb about preservin=
g
> bugs.

The idea was to have one patch that was intended to have no observable effec=
t (pure refactor) and another to change behavior in an easily reviewable way=
.  I should probably not have used the word bug :)

>=20
> Thanks,
>=20
>    tglx
>=20
>=20
>=20
