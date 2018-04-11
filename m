Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2164128-1523443322-2-5024221799795770322
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523443321; b=B4q7cwIO8oNhdQ59c0KoNJhGjemaILgH67RhZW4lEgbPvF+9XL
    RwhpruqW97rCHjP18Fu8Jcizgvp0k62E1itEd8lz7VmZ68Ni9mKYjy1fCzZBi079
    b4o6jjF3Dyq/D16GyKOoh0bTdOS4Xu+iKFEfHS1U4Iddm3nGrZJOcONaFHSyqiMl
    IF/MgTncjIOHOre4I/q1udV+Ygta2J/6wfA4s/zd/1EkDXA3h9JnD58VDhcasfl7
    gmuxoh8xrg6GiCh6UsfMfSH4bjNr1hDlC1KvaARgMqgq9fdni8lB0yovKKTJK9V7
    hMvDxzxSA4Udogk45sbiUlocwpK1zAnMAuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523443321; bh=XpSMJ9i6EffYp6iY+3OYKfaUabJeSEsl43DO65Az85
    E=; b=XDac6IoKlCJvJOE5/ZOrOaQrrLkSk7s45zBv/g/bLaUwjZBj4i6OoAnE9E
    fI6UvNgVbQuMA4HwD97wAxx7D9TNAI33xgkE5ISIsJ3UaBGyb8Wm5lkNvm6RVoOi
    Axtk/TXVvcl2nXm9Z5+VZKvP9z56LySEDvEgg2Snvhz2n/ZWht36dbACZZ9fcG/5
    qwv3CiN8QIwQPvmpYpKLpN4oEuOBqWJYF/QVjDas6V0Gbh+fNcVj+JJKZBrGCJNw
    Y/tGNQOSLFHjY6cZtJSJpDUgdbobPAqRy/yMzJUlFNvordnwQZUpnTpeEWxcytU8
    x6oTtVdvu+blPUcTy4Gub1sFG1lA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fgKBk2/v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MkqzWRj2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fgKBk2/v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=MkqzWRj2;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAikihP+uSVEdr2BN/uJH5yr6EeNggrBG98o77qOWmnq/7QoNc7yrFv32vNnZJqfF7Kn4voziTCKQrT6ZU2tleeKf75Kc59o/FkKPxDKGSRGgqotVob8
    idW8Qte4sCqmMCKLa+oKyD6Y4lLdGHZgNBO8SCSvL7t/QuSpWK9WvhuT72lo6JVnITXXHup4R62i3QbfHP+8IQEhYyCwuDQEIG752UQOIDlcCuBxj2TCnoca
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=CuB4dlPyrRLz_ZPpBa4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752016AbeDKKl6 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 06:41:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51699 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeDKKl6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 06:41:58 -0400
X-Google-Smtp-Source: AIpwx48K61JtDsN3912m1YVaAW8eXDZopFY1u/EuHvjBl6OjsRUOLCzmFdZWmtgGCSVM37uG3gWKX21v/cLQmpx1sz8=
MIME-Version: 1.0
In-Reply-To: <871sfmhz88.fsf@intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 11 Apr 2018 20:41:56 +1000
Message-ID: <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: rodrigo.vivi@intel.com, anusha.srivatsa@intel.com,
        michal.wajdeczko@intel.com, Greg KH <gregkh@linuxfoundation.org>,
        airlied@linux.ie, joonas.lahtinen@linux.intel.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

<snip>

>
> NAK on indiscriminate Cc: stable. There are zero guarantees that older
> kernels will work with whatever firmware you throw at them.
>

I included 'Cc: stable' so the patch would get added to the v4.16 and
v4.15 kernels
which I have tested with the patch. I found that earlier kernels
didn't support the
'linux-firmware' package required to get wifi working on Intel's new
Gemini Lake NUC.

>
> PS. How is this a "RESEND"? I haven't seen this before.
>

It is a 'RESEND' for that very reason. I initially sent the patch to
the same people as
a similar patch (https://patchwork.kernel.org/patch/10143637/) however
after realising
this omitted required addresses I added them and resent the patch.

Best regards,
Ian
