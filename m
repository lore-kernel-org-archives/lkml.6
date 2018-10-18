Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEED8ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F272145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="uarRnX8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84F272145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbeJSAuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:50:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47058 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbeJSAuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:50:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id r190-v6so2828511pgr.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 09:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W5M0O91h1zilecFVIvojkqO4Kgg7jr2Hm/mKMJRZStc=;
        b=uarRnX8AtRrtBkdlZK5nsyY1g/frifkttZOjCG56bhd/gJH9ozomJiaAb7SWU9+XAm
         xXSVCJ/uVCzh6+gyfFn00AHK2GLeibxRW9rnBlg72h1bYqPrMpvOB8/KFvOOkWvDV6Ic
         NZfHj069HYK9pxjpyZ54cxqz/CAdRzJpENig3cz/RbvaRok12rr6lc3ZmcP8XlISPRvs
         rWyS0LW6QTn/jy+eP2NibO49lTmv740cstwKpvwo6Vgpf6+USRtowjirTDzcBoXbrSRN
         mVpmt0KC4ycb5V1mEbldECOql+Xhb/EreY3O72v8ZTrZSB3FJgy7e4P1fkyUe4+XjUjd
         X0SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W5M0O91h1zilecFVIvojkqO4Kgg7jr2Hm/mKMJRZStc=;
        b=m8Q6cWz519Fnj8ZveA3dGWtM7s7606Nw2GDlGPV78C1KSwPOk+P3nAadO7oD/xd+8O
         BJwStxXB/XSv5dipGVaKtWSJfvFaDk3DyEJ8GaJkcRfi3JnbWzEWM8zrEXdLgZWcoN0k
         CBB261LALx5ftSD5iEOufImKtvVOXZVSGPizcZC7spJAbglkyCP+aU2wL5eIPIyA62iP
         v1M8v+VO6csPsZR7iIcyGgsE4CjHSj2dqjwy/4X0ZIf1mFEr099Vki4MPmfOjxQdnseG
         BfI6+latDdVAGCSaMXjVKpR4U0leql/Adse11GXVZmZ0ab6J0ZuuuwhDOPRv5WYvz04k
         6veA==
X-Gm-Message-State: ABuFfohT8FwT/ovln/0Z/I1M4EV8nJVpSi6OPLgw+2JTWwx4VYhNpTYY
        rXIpe4WLzQa1JHJAGASRvVW2IgLQDs4=
X-Google-Smtp-Source: ACcGV61sMAqYhw58qfRx8L/vPbleoBbRL4nIeCtVhN6aUABcl4a6GDU/cnPCdlkTzSkkZzLlqyJ9fA==
X-Received: by 2002:a63:cc0b:: with SMTP id x11-v6mr28838816pgf.33.1539881306671;
        Thu, 18 Oct 2018 09:48:26 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:3007:d8c7:a746:3822? ([2601:646:c200:7429:3007:d8c7:a746:3822])
        by smtp.gmail.com with ESMTPSA id z25-v6sm35054702pfl.58.2018.10.18.09.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 09:48:25 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 05/11] x86/fpu: set PKRU state for kernel threads
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20181018162644.qqjkzoqn2fleyi2b@linutronix.de>
Date:   Thu, 18 Oct 2018 09:48:24 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC7B46F7-7A6E-4CAF-A1EB-91271CC7B092@amacapital.net>
References: <20181004140547.13014-1-bigeasy@linutronix.de> <20181004140547.13014-6-bigeasy@linutronix.de> <39e0a55f-4920-cfde-9bef-09c51109d211@linux.intel.com> <CALCETrUdxsFA5g0M9uRFktfdi=mxK_g3kBfs-VxwDZ0xWqjFAQ@mail.gmail.com> <20181018162644.qqjkzoqn2fleyi2b@linutronix.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 18, 2018, at 9:26 AM, Sebastian Andrzej Siewior <bigeasy@linutronix=
.de> wrote:
>=20
>> On 2018-10-12 11:02:18 [-0700], Andy Lutomirski wrote:
>> On Fri, Oct 12, 2018 at 10:54 AM Dave Hansen
>> <dave.hansen@linux.intel.com> wrote:
>>>=20
>>>> On 10/04/2018 07:05 AM, Sebastian Andrzej Siewior wrote:
>>>> The PKRU value is not set for kernel threads because they do not have
>>>> the ->initialized value set. As a result the kernel thread has a random=

>>>> PKRU value set which it inherits from the previous task.
>>>> It has been suggested by Paolo Bonzini to set it for kernel threads, to=
o
>>>> because it might be a fix.
>>>> I *think* this is not required because the kernel threads don't copy
>>>> data to/from userland and don't have access to any userspace mm in
>>>> general.
>>>> However there is this use_mm(). If we gain a mm by use_mm() we don't
>>>> have a matching PKRU value because those are per thread. It has been
>>>> suggested to use 0 as the PKRU value but this would bypass PKRU.
>>>>=20
>>>> Set the initial (default) PKRU value for kernel threads.
>>>=20
>>> We might want to do this for cleanliness reasons...  Maybe.
>>>=20
>>> But this *should* have no practical effects.  Kernel threads have no
>>> real 'mm' and no user pages.  They should not have do access to user
>>> mappings.  Protection keys *only* apply to user mappings.  Thus,
>>> logically, they should never be affected by PKRU values.
>>>=20
>>> So I'm kinda missing the point of the patch.
>>=20
>> use_mm().
>=20
> So. I would drop that patch from queue. Anyone feels different about it?
>=20

I think we *do* want the patch. It=E2=80=99s a bugfix for use_mm users, righ=
t?

> Sebastian
