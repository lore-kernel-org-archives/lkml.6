Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1494183-1524698140-2-4274490199715085092
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
    1524698140; b=WLPGnLjxP49F7eMGbcSPGEKXqEcKPCDoLCS3AC3kWScaPYknLr
    Q/hd6VZnP2LCGGis6aFAdlx/BzLXhsKRraDMOrVgwS5xc6TpPxHsNzBP0NbtTsBr
    RxhaGcPNV4ubB2h5NnkNqb+UyWRJcps04/RU6kbHOS12z7wVfNYL9X3uOdqC4hN0
    J3WawDebY0wC71yDtBRZ2znsYOnE74FxgsDBQzh5rlCEEiVhQ7/KhmLt+cSDLNVe
    SJdWnoVVPqI0QF8LQyrw2wVl6mbr5VZEao6MZa3pQn42hzKCs9Ea/UytlaBlhgiu
    7fchRZW1/JBB6X9Hzq72M+1MiC72KqOtJzrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524698140; bh=9wyZ0noqOQLCo0bwnpf+yCp3O1iLI+/2gf7Nxm4HwF
    o=; b=ilap5AE1NhhNJvIuC4gyjfEszvxEDeufvN2jwThy+cldb/Ec4Lg8gFZ+o3
    fGIEwbXAZR8ocIiGa17XqH8tpnD4bYMtaxegCRQF15bYm0C/s7xduWzqO4C67Ce4
    dn1VQq6S4U8qIvB39ifeCmamw3OS4E4YIXTfCaslS5QJAfcJO7I0LCOwGRcy0HDp
    K2DahDf2PyGMr888LpXOykmoaZcHsJg8te8YbCBaTqCyRS6QdvC6mMHMX2+SPXZJ
    qkxJr31uWUmAC9RVnjlD0fK69OVt8iomZkuU9LzNZzJPObHSNK+FsR7e2Q/orGD1
    RgTTmB4xkbL7ZuYazbnD0/de02SQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V6jtBXB3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gx2bgmv9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=V6jtBXB3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Gx2bgmv9;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4ucjb42M5IOwPbhqY88FW4qZSvK3YbxBT/aPee0DyAPCeKghdi8ZCnsuEdTidrvqT4ySSmGIJkhRfvOM+DUTqnl7q3KUvC1MfsHHKY/kCfwHWSvJw0
    FGo51Nz9uDp9Sadkx+s64fIzF5l2KqvbTHU9XI6zY53gg1NE6zkhXPJHIRW+t9LRt19C7G513cH4KNf8XzBAlt6rkEvqy+M1fikDVfx/zh1QLRlYXYg/BYTD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=1XWaLZrsAAAA:8 a=cm27Pg_UAAAA:8
    a=danhDmx_AAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=NA7ewzx0L1RFwzoKjJIA:9 a=QEXdDO2ut3YA:10 a=xmb-EsYY8bH0VWELuYED:22
    a=P4VdviVPEcjfz_PVVggX:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752958AbeDYXPj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 19:15:39 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:37294 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbeDYXPh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 19:15:37 -0400
X-Google-Smtp-Source: AIpwx4+uhHsGhWFdkZfwFM9FBtZMVYTENwuPVg3VFTy9l8YLRneAhPhzoYk+mlUydtPlY02DSSDbgJgoAFMTBaavalw=
MIME-Version: 1.0
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com>
 <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com>
 <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com> <CAFXWsS87X_QVFSA+BqefknE4x0o=7Edfp1iqdTD81YCcoLHsmQ@mail.gmail.com>
In-Reply-To: <CAFXWsS87X_QVFSA+BqefknE4x0o=7Edfp1iqdTD81YCcoLHsmQ@mail.gmail.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Wed, 25 Apr 2018 23:15:26 +0000
Message-ID: <CAFXWsS8H8V3RvArLnvGF1z_TuojgBU6pDoqBccCHGV=s9DNJfA@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
To: "Botello Ortega, Luis" <luis.botello.ortega@intel.com>
Cc: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Martinez Monroy, Elio" <elio.martinez.monroy@intel.com>,
        "Vega, Ricardo" <ricardo.vega@intel.com>, airlied@linux.ie,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Anusha,

Can I ask if this is on anyone's radar as I'm concerned this patch will
stall otherwise?

I see that the significance of testing with the 4.14 kernel enabled the
firmware to be included in the latest Chrome OS kernel (
https://groups.google.com/a/chromium.org/forum/#!topic/chromium-os-reviews/jtpHvZOfZ-Q).
It is important to similarly include in the mainline and stable kernels to
facilitate various distros that are now raising bug reports (for example:
https://bugs.launchpad.net/intel/+bug/1760545).

Many thanks,
Ian
On Sun, 22 Apr 2018 at 08:46, Ian W MORRISON <ianwmorrison@gmail.com> wrote:

> On 21 April 2018 at 11:22, Botello Ortega, Luis
> <luis.botello.ortega@intel.com> wrote:
> > Hi all:
> >
> > We tested GLK DMC 1.04 FW in last week of September 2017, using the
latest drm-tip version for that time (4.14.0-rc2) and according to our
results we could declare this FW as acceptable and healthy to be used with
kernel version 4.14 .
> > However, we cannot guarantee quality and healthy of this FW if it is
used in top of current drm-tip kernel (4.17-rc0).
> >
> > Best Regards
> > Luis Botello
> >
> >

> Your measured response is appreciated and raises at least four
> possible alternatives for this patch to proceed:

> 1. It is normal that firmware is *only* tested at a certain point in
> time with the drm-tip version of the mainline kernel so that the
> statement 'firmware X is acceptable and healthy to be used with kernel
> version Y but is not guaranteed with Y+1 or Y+n' always holds true for
> any microarchitecture codename's DMC firmware. Therefore it is
> appropriate for this patch to have a restricted 'Cc:
> stable@vger.kernel.org # 4.14' tag together with an explicit
> 'Tested-by: (in 4.14)' tag.
> 2. As firmware testing was not performed on 4.15 and subsequent
> versions, testing is still required on versions 4.15 through to the
> current RC of version 4.17 for the patch to receive a 'Tested-by:' tag
> together with a 'Cc: stable@vger.kernel.org # 4.14' tag.
> 3. Further firmware testing will only be undertaken for the current RC
> of version 4.17 and on successful completion the patch will only
> receive a 'Tested-by:' tag. A 'Cc: stable@vger.kernel.org' tag is not
> applicable.
> 4. The firmware was not tested on 4.15 and subsequent versions as it's
> functionality was provided by alternative means and therefore the
> patch is only required in version 4.14 and should have a 'Cc:
> stable@vger.kernel.org # 4.14 only' tag together with a restricted
> 'Tested-by: (only in 4.14)' tag.

> Could you indicate which alternative is appropriate? If further
> firmware testing is required (as in points 2 or 3) then can an
> expected completion date be provided?

> Best regards,
> Ian
