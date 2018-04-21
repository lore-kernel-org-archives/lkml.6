Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-970661-1524350774-2-4208725372824335723
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
    1524350773; b=qzRPRQNfbkH0hJwGGlHUkD8GiL45rvYSkPNM5mu86VjT/OdJA0
    u5uWYU9vfMKI5hpld6UQEmbZ8QolIlP9m6U8PDI02QekoyqKUIlDNmpqcCiX55Ey
    R2bY1+q4F8Ypq4qKB+S6120zrKbc/XKptqLlvX8+xtCxTYV6FPXU1tRxKwnUyzlP
    fvW41nN3QXEKAvvbkpNGvL/FBH/5HQRovSzngAK4JZCmQm+pb9oMgMgPG6Ofirwm
    A1C2e87uoypXGHWdbseAWUugypER9uL3SHR8+YxcmxFxy9iO3Jzi+gywlRT2XRoB
    ZWGSOzOuGQ05ImpyRuByhgF0IW0OvgSTUyfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524350773; bh=3zaJiecMk/B/oOXsYjHp2AFvWBUK6/d+03pra+xcJH
    U=; b=Fz4PNC26icPXGwXxCnQ5OXuR9z/GPhI3/mJ8CNf8qhBZUbIhR66jZRTt2H
    kFRaa2CBXrzvmw0K+LHT7GJkNDz3HuvPvkg0pt0VgtUJlkSwTGUaFdoEN1FOZT2V
    oWwSlDiVjfbvnZld32DHNMbVwT4ghGTf93Xc0XTZQFxFkwmO+EL2Vyq1rf2KHbnf
    rZpVh2gHhbNh1ZBf76xamp1AQZ4lc4VNP4yV8RgA3/yNi6H7Jqk2z+Kjk4Y2zrE3
    U1iBBI92q3IpVCfqB87bE3rzlaxAKEbAUZ5p3dypQq6rwBcg7rkx/C/ATO7jWr4q
    wyLYDOMqDoW3PwpvDQ//ci8NPVaQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N71wk202 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iCRP9ydR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=N71wk202 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iCRP9ydR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEbv2akQCn1EGgwIREvPQpn9HkffuZdPs5yVg8+Rcg4VWqZ/qrEDU6QXVSxNc8NO9wH5W077vHtmrLsUEZ2Z/+bSMep5vaJ5J02KXoaVz8Vn9JKul8hi
    B/40coBsL0sEwVpT3QUKzB+mvNbZDqitnHd/2tyVI0xZxQ9Bj1cw/RV6k0U7w8Wf7pOXZjvRMnhrXmEmeXbR6U3TycwcQDtlsL4XTcJTbmsIDiiDCdaQ7TUv
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=unD1LOn5OY8A:10 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=UZXzauO75lWPJ0a12MEA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeDUWqL (ORCPT <rfc822;greg@kroah.com>);
        Sat, 21 Apr 2018 18:46:11 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34837 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753208AbeDUWqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 21 Apr 2018 18:46:10 -0400
X-Google-Smtp-Source: AIpwx4/1wiS+2pm/GxJkV7jZ+TtI6Ebs9N7qcIdvZx0f5Toa1qaAJ2Ej+TLw3Vg1qjjBzHZ5A6uyENvjjWSkjIihXdI=
MIME-Version: 1.0
In-Reply-To: <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <871sfmhz88.fsf@intel.com>
 <CAFXWsS_SvkLvJcibx9LoUw+onN-AAzSLMrRgx3U3hsbMVyty2g@mail.gmail.com>
 <87lgdugc85.fsf@intel.com> <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com>
 <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com> <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Date: Sun, 22 Apr 2018 08:46:08 +1000
Message-ID: <CAFXWsS87X_QVFSA+BqefknE4x0o=7Edfp1iqdTD81YCcoLHsmQ@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
To: "Botello Ortega, Luis" <luis.botello.ortega@intel.com>
Cc: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Martinez Monroy, Elio" <elio.martinez.monroy@intel.com>,
        "Vega, Ricardo" <ricardo.vega@intel.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Greg KH <gregkh@linuxfoundation.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 April 2018 at 11:22, Botello Ortega, Luis
<luis.botello.ortega@intel.com> wrote:
> Hi all:
>
> We tested GLK DMC 1.04 FW in last week of September 2017, using the latest drm-tip version for that time (4.14.0-rc2) and according to our results we could declare this FW as acceptable and healthy to be used with kernel version 4.14 .
> However, we cannot guarantee quality and healthy of this FW if it is used in top of current drm-tip kernel (4.17-rc0).
>
> Best Regards
> Luis Botello
>
>

Your measured response is appreciated and raises at least four
possible alternatives for this patch to proceed:

1. It is normal that firmware is *only* tested at a certain point in
time with the drm-tip version of the mainline kernel so that the
statement 'firmware X is acceptable and healthy to be used with kernel
version Y but is not guaranteed with Y+1 or Y+n' always holds true for
any microarchitecture codename's DMC firmware. Therefore it is
appropriate for this patch to have a restricted 'Cc:
stable@vger.kernel.org # 4.14' tag together with an explicit
'Tested-by: (in 4.14)' tag.
2. As firmware testing was not performed on 4.15 and subsequent
versions, testing is still required on versions 4.15 through to the
current RC of version 4.17 for the patch to receive a 'Tested-by:' tag
together with a 'Cc: stable@vger.kernel.org # 4.14' tag.
3. Further firmware testing will only be undertaken for the current RC
of version 4.17 and on successful completion the patch will only
receive a 'Tested-by:' tag. A 'Cc: stable@vger.kernel.org' tag is not
applicable.
4. The firmware was not tested on 4.15 and subsequent versions as it's
functionality was provided by alternative means and therefore the
patch is only required in version 4.14 and should have a 'Cc:
stable@vger.kernel.org # 4.14 only' tag together with a restricted
'Tested-by: (only in 4.14)' tag.

Could you indicate which alternative is appropriate? If further
firmware testing is required (as in points 2 or 3) then can an
expected completion date be provided?

Best regards,
Ian
