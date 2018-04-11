Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389010-1523451852-2-4126204880284187472
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
    1523451851; b=HJeTUnSCl8SykwEHxL+Kd4vZzzRTxiw3Xy+ad9rKKmcq4pcAzT
    mO24lsUTGttGi/hHNi0TdX/titPrzhErALHmDhiqz87A6H1hLONCrpFhl+NyY43k
    6mqUBm47+k27lqjYRon0SFGApBIZasyuv+pS22eUAXgQApxarCD6uXP0aJq5mYWf
    hrTDLDjdbZ5IE3hrFT8o2PDqC6dhsQctfbb/OgP8PY5sO8apZBaQNPO8jOy5RGxK
    pJVI0/tUlLm1/wEuxxu0D5/qvC6I5+K/cS99bCiKTumzVQLm3ZvPE88m4Z1OjjVE
    7zRTuFpyJ42vYOogWJJi+RWw98vwjoDDXtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523451851; bh=LQYd894qCesN1WOWrjIi8WuTxqXuILA/PsWZCVpO46
    A=; b=dSdZsuI+8KEb1CapktVmIY4UEV5oMHfHJWUtYS/O8cdL1hTfC0mQZGPNe+
    1q3jmeJSC0roMMkJzjR9zz4MktymqQjqzJhg0Zne6c/3VFmk39Lt6e7RfgNIDhfo
    h2V/CEkVrBQr46di8UzNPDZI6aUkygu8V1RUfJf2whcR3UhZVCl5OK0WgA1Jf3RA
    5/9v/l0KtKu9t0mOLdOOv0h0v0UBa8yr/Ux7PzmT/DAvwL9Zw38eXUktjLlLEN8i
    +slDMFTACrj23dNFnFbU14IXTypiV+YL9EYCf/PkE9o7jbpYkkHjms7NnvIBLwJw
    o2JWsGLFA1WeNx3r3f4NO1KPGihQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SeXBZsgZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oNNLfhvN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SeXBZsgZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=oNNLfhvN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDbLcWUexeLKYMYtSZiQ+PpSd1ty8LAoQakf8a/JoTsmBvky80zgbXNyUIeqnrxSysQYzq5x/kbSusJTpjaf18DqgdTAwoFHBWXccrS7HLajyc7lDDjK
    h2+qLlEieois0jtz8Q57pylzWuK3Ahss5Q5E0/7Oj9D8sdoxAzsIXgIL+fL3uhphRHLRkqgSkKg2BC0PMzYx8NfJF44PpdntRF3Y+U49sn/csm8GeqmkM+HL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
    a=riMJuovTzz6P4l8tzVkA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753320AbeDKNEI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 09:04:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39737 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753243AbeDKNEH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 09:04:07 -0400
X-Google-Smtp-Source: AIpwx4+yQMa3WNc2ZbjIgEKQuSIn0dC/eJTXEhCIiJ0aKASSINkmtV5s4seXEl21/z1CCL4fu3UP3bR53b1yK25ubog=
MIME-Version: 1.0
In-Reply-To: <87lgdugc85.fsf@intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com> <87lgdugc85.fsf@intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 11 Apr 2018 23:04:06 +1000
Message-ID: <CAFXWsS9NJDPMqESRavO_jSGuzUL3Bp8rWPfP=MjSkMdYBpjtFQ@mail.gmail.com>
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

On 11 April 2018 at 22:27, Jani Nikula <jani.nikula@linux.intel.com> wrote:
> On Wed, 11 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
>> <snip>
>>
>>>
>>> NAK on indiscriminate Cc: stable. There are zero guarantees that older
>>> kernels will work with whatever firmware you throw at them.
>>>
>>
>> I included 'Cc: stable' so the patch would get added to the v4.16 and
>> v4.15 kernels which I have tested with the patch. I found that earlier
>> kernels didn't support the 'linux-firmware' package required to get
>> wifi working on Intel's new Gemini Lake NUC.
>
> You realize that this patch should have nothing to do with wifi?
>

Yes. Runtime power management depends on the patch but when distros
such as Ubuntu are installed on a Intel Gemini Lake NUC as an example,
wifi/bluetooth depends on Intel Wireless-AC 9462 which in turn depends
on v4.15 as a minimum so my logic was to add the patch to 4.15 and later.

> Rodrigo, Anusha, if you think Cc: stable is appropriate, please indicate
> the specific versions of stable it is appropriate for.
>

Thanks you..

Best regards,
Ian
