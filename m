Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776D5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2384C21537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zXXwH1QB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2384C21537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeI0A0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:26:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44884 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbeI0A0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:26:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id k21-v6so13836766pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WRECapT9iwQ9XnNNunbGV9PQQnR1+IXTYDz92KESlFY=;
        b=zXXwH1QBnjrx2m+eeVtpOy7gmfrAzxUw0cC/aRMnJ48n6XGyMduX+kRRDA+uczConr
         AGixhvK4bHNqLZqpwYxIBpI3EDRX6s+94rWbwV6jPrQWklFC4uxVDzmYDc11Bwl1M3ZI
         kI8xC9aesDCJ5jNKTIY80uvZzTZAO2pwF31d2abjQ5Kw8jUxgo6T6ZL1h6+uzy0cbvuf
         up6Sn3fM2/okBSO2L/7Wy1V1EycGn5goI1e4edX/NaJr3x0XrFxvkRx4p8zcGYeVuwPW
         kDTunN+Sjh2G1SClS0L/FrEaV3UCU8EfXoEF4a+DCE7qdtU4zzb4z5eYnTg6i7IRN0S3
         w+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WRECapT9iwQ9XnNNunbGV9PQQnR1+IXTYDz92KESlFY=;
        b=QIy7K6ZmRjlwbjBod80jC65xL2syCOyBOAkEzNtE1GA2P69fc1ghtGcohZneWQZltZ
         pfVC45CJd9ldFlSiYn6GaoJEQai9FNPT+nY39DJqnkg5FJ7TGAlxOtUvAYLyTRxIjiuv
         BTTGAQq3gI3VsVpRycZRJMmLlUJ/CgsFKVQxQbJhIB//hRqxB9tWmoskzuLxDzkiNV5i
         FW0tDICr6emdqrxfTlKj7cm++1zPTDcTVEx6Wfrvj+8ch7odkO7RusPN2jhQmA/TPA2u
         DJFGIcP9/At25bZALWdLa+Q+p8DnqGgq6khbJZmuV3cl1lZbzv4Sp+B19yfeVOBWU0hS
         zNHA==
X-Gm-Message-State: ABuFfoi1a7FY1yVTITnOk3spw4o1l/OLgeZIXARIsKqLSLgSCDgoX/fg
        E/lMtkjps0UYHxV/C6HKVGbDdg==
X-Google-Smtp-Source: ACcGV606rfHoRFtX2UAZdTjz1OXQMHprrLkAgbxy/UhFA7kflV5QWgzATLO0TEIMw3OJwRYETiUpJw==
X-Received: by 2002:a62:c4c5:: with SMTP id h66-v6mr7456726pfk.39.1537985549794;
        Wed, 26 Sep 2018 11:12:29 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:a5d9:1a1e:1c7a:c36e? ([2601:646:c200:7429:a5d9:1a1e:1c7a:c36e])
        by smtp.gmail.com with ESMTPSA id o12-v6sm9440407pfh.20.2018.09.26.11.12.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 11:12:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v14 09/19] x86/mm: x86/sgx: Signal SEGV_SGXERR for #PFs w/ PF_SGX
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180926173516.GA10920@linux.intel.com>
Date:   Wed, 26 Sep 2018 11:12:27 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        X86 ML <x86@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, nhorman@redhat.com,
        npmccallum@redhat.com, "Ayoun, Serge" <serge.ayoun@intel.com>,
        shay.katz-zamir@intel.com, linux-sgx@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <2D60780F-ADB4-48A4-AB74-15683493D369@amacapital.net>
References: <20180925130845.9962-1-jarkko.sakkinen@linux.intel.com> <20180925130845.9962-10-jarkko.sakkinen@linux.intel.com> <CALCETrVAhiwv+g5fzVO3ZSHZgcQKbeeG8r3HUcXO9k7Gi94NdQ@mail.gmail.com> <20180926173516.GA10920@linux.intel.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Sep 26, 2018, at 10:35 AM, Sean Christopherson <sean.j.christopherson@i=
ntel.com> wrote:
>=20
>> On Tue, Sep 25, 2018 at 03:53:48PM -0700, Andy Lutomirski wrote:
>> Minor nit:
>>=20
>> On Tue, Sep 25, 2018 at 6:12 AM Jarkko Sakkinen
>> <jarkko.sakkinen@linux.intel.com> wrote:
>>>=20
>>> From: Sean Christopherson <sean.j.christopherson@intel.com>
>>>=20
>>=20
>>> by (c) as the kernel doesn't really have any other reasonable option,
>>> e.g. we could kill the task or panic, but neither is warranted.
>>=20
>> Not killing the task is quite nice, but...
>>=20
>>> +       /*
>>> +        * Access is blocked by the Enclave Page Cache Map (EPCM),
>>> +        * i.e. the access is allowed by the PTE but not the EPCM.
>>> +        * This usually happens when the EPCM is yanked out from
>>> +        * under us, e.g. by hardware after a suspend/resume cycle.
>>> +        * In any case, there is nothing that can be done by the
>>> +        * kernel to resolve the fault (short of killing the task).
>>=20
>> Maybe s/killing the task/sending a signal/?
>=20
> My intent was to document that, unlike all other page faults, the
> kernel can't fix the source of the fault even if it were omniscient.
>=20
> How about this?  With formatting changes since it's long-winded...
>=20
>        /*
>         * Access is blocked by the Enclave Page Cache Map (EPCM), i.e. the=

>         * access is allowed by the PTE but not the EPCM.  This usually hap=
pens
>         * when the EPCM is yanked out from under us, e.g. by hardware afte=
r a
>         * suspend/resume cycle.  In any case, software, i.e. the kernel, c=
an't
>         * fix the source of the fault as the EPCM can't be directly modifi=
ed
>         * by software.  Handle the fault as an access error in order to si=
gnal
>         * userspace, e.g. so that userspace can rebuild their enclave(s), e=
ven
>         * though userspace may not have actually violated access permissio=
ns.
>         */
>=20

Looks good to me.=
