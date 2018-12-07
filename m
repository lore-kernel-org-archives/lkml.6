Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68D73C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADC420837
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="YwRORVwq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADC420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbeLGSuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:50:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35506 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLGSuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:50:12 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so2099350pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nnht3jCBryS9HUgUX34dDS3skyULy3W1Q28HHDlxc9U=;
        b=YwRORVwqg21IflGLnDmUsqeyjek2uDpYvvFaC0BXK7DnX3L5aAzZ32Q1ruynaSEVRb
         /9BKIVNGl59ZN/Sx8137RpijJM8uI9WX+OlUMW0KFTCmsjE7VcA0eLsSFcN0WAcweJ70
         rCLYyfCa6Qo5uDrxRoMN1CtqaF3iEIHlErubjDIRYJRQQjgg+P4lNR9gAGlP7EWXNGFn
         Is7a/+6zDKV/dfeLzh6a2rxOHvXNaz1jdC8j/cob1/oRyJu0J9r/s/1y9iXaJtKl2wkL
         mjS8qjwL2N+9CtsDFJsnPzX8DB5AelpD76K08eIq+krW6FxkWiBumHsZpXlWR8m7FCgh
         5uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Nnht3jCBryS9HUgUX34dDS3skyULy3W1Q28HHDlxc9U=;
        b=l9g8rgPe44bhp7wg7O0GvHiN5EdItCVnRVD4NAVXw9dQbOk+yXJ0VOfMb2L9cz3kye
         N2NlKyP1OoaLOnUYx9toB7lJ4xjUCsuDbG8d0pok9S/i1LEA/KTw8pV4ChjrMi6iacdm
         dovEWaKX1kPCcoYwYBnzOVJW5WopM2PXgTFv6T6Bhdx0XufNPLN7KpU4ooxCNSi5i6Qu
         w4hmUoeDbgJwKWt5bNCG7h/PzZxiBvS8yogzwMlwnR/sIKrF3GJL0qW9x0E6ocGOl5/E
         efdUJX1FiNDDM0+z7W/6JC/aLmgdOE03ts6wCn3Fp0CNgqIF8MpAjiUGOiKD2W8/Pc8E
         xh0w==
X-Gm-Message-State: AA+aEWa5MIXuqlK3Zd0xgwSSqlTYQe7BLOZei0FO4Hj2hukJVPlB0eoX
        pSjAG0LWlngtw75fGcTcPSxlJqF0efM=
X-Google-Smtp-Source: AFSGD/X0krLt2ZrsMojk9HTEGTIE9UI961YmlMXczbjDw2yiHonHskLVftOu3PWdf7AU4GdmYPYolw==
X-Received: by 2002:a62:5182:: with SMTP id f124mr3377934pfb.238.1544208611377;
        Fri, 07 Dec 2018 10:50:11 -0800 (PST)
Received: from ?IPv6:2600:1010:b02e:9276:b497:ca3d:93db:f61e? ([2600:1010:b02e:9276:b497:ca3d:93db:f61e])
        by smtp.gmail.com with ESMTPSA id z127sm5835307pfb.80.2018.12.07.10.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 10:50:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 4/4] x86/vdso: Add __vdso_sgx_enter_enclave() to wrap SGX enclave transitions
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16B92)
In-Reply-To: <59c989a1-e699-9665-780f-6dd263f41ce4@intel.com>
Date:   Fri, 7 Dec 2018 10:50:08 -0800
Cc:     Jethro Beekman <jethro@fortanix.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Haitao Huang <haitao.huang@linux.intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Dr. Greg" <greg@enjellic.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <85EE19AF-C085-4E17-A673-44242996AF75@amacapital.net>
References: <20181206221922.31012-1-sean.j.christopherson@intel.com> <20181206221922.31012-5-sean.j.christopherson@intel.com> <f2b7df05-20ef-ac16-fc99-258c39d84666@fortanix.com> <59c989a1-e699-9665-780f-6dd263f41ce4@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 7, 2018, at 10:44 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
>> On 12/7/18 10:15 AM, Jethro Beekman wrote:
>> This is not sufficient to support the Fortanix SGX ABI calling
>> convention, which was designed to be mostly compatible with the SysV
>> 64-bit calling convention. The following registers need to be passed in
>> to an enclave from userspace: RDI, RSI, RDX, R8, R9, R10. The following
>> registers need to be passed out from an enclave to userspace: RDI, RSI,
>> RDX, R8, R9.
>=20
> Are you asking nicely to change the new Linux ABI to be consistent with
> your existing ABI?  Or, are you saying that the new ABI *must* be
> compatible with this previous out-of-tree implementation?

I think that allowing the enclave to return at least a few registers is quit=
e reasonable, but I don=E2=80=99t have a strong opinion.=
