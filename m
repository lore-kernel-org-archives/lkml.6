Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1033711-1525075144-2-13554265085846715088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525075144; b=PYGJqTLtYCJWhvUbUq5r5S/dWk6mz8KRyoF8nIdMFBhat91e0N
    2Ywvn2DtNVhSdql8+UXt3/myfmaM+wth+5MogirlU7mbqc++Xi5JCMzPY3b4833R
    vWsSJGzwZkhYGpAqjpnHmsRRTY7SFDcz3c4H6BGmJZRfGR9AFCFnIxns6zHNpW1u
    7zVnJlaDd/eQ1dS7aL4hg+MfHlYXCHb8OhDz0jaCQGGBCSEpAzFNQbmPOSAR9WID
    6x4MYHzHtpIqCMM0a4BbQQqEgsuitoy5JP/NcsFVEq0+y8b4ow/1qmZ6gAz6iWBC
    8NEivv9PSN+YhjWfT8Tje6/4SO9Mtjtz9ytA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version
    :content-transfer-encoding:to:from:in-reply-to:cc:references
    :message-id:subject:date:sender:list-id; s=fm2; t=1525075144;
    bh=6QBeB+T4a1jYP6KSG73jCY04Uw8BSgnJDB5ujOApRhM=; b=WyQ7909zPxoz
    EqH+olRC34byeJilWJuSj+e+T4e7sRiG0x9Hg4i0IacqRwf8xbatES5AXvH+u909
    KI761avGYXgUWSucAze2shfXa8VRqbLz8DdI4HTxducCEvAdUbhk3kRzLPsRYrzx
    F7LpW3hoeC0BwjdxpFJOBUfDWU2rmg4BjNdL2PuvPI7raATZe68/qgG+GtM7sJAo
    VscExV/qjp+lCwEjzLF0igFr3k1NOeW8z2WIORxYs+G8FX2cZNK2L9wLIWVTGI0v
    ycu3Bqv5ecoWDyZgszRUQlohDKsVgN3CKhyVbLDh4BQrDk05CAcnzRZE8V1ryQ/A
    Ak+auLdIWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCURA0MC7Sa/vKHQCs2D/2+vt9fUOk3AbFsVclZKrvoPPyuNmLqzgQtZG5f+lErqtwF7wZA9IoVMQwSgDRXHlKk3UTT9izwjRbPGlhUhDGIiK+0lDgHi
    9mRhwlFEhZkXDH6J7iTWcHcYWiX0BFN8p+mHgosDRBYSB9pcbn0PcZRbRkyZsqfFxOazK4uj8D6Kl7CBu5W0GSh9elSRaev3KFyvg3dCzEbH8fn4fuUvR5YL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=x2IAxjU30aJpVcwx17gA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeD3H66 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Mon, 30 Apr 2018 03:58:58 -0400
Received: from mga07.intel.com ([134.134.136.100]:52430 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751759AbeD3H65 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 03:58:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="47102809"
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: "Botello Ortega, Luis" <luis.botello.ortega@intel.com>,
        Ian W MORRISON <ianwmorrison@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>
From: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
In-Reply-To: <87zi1pt37s.fsf@intel.com>
Cc: "Srivatsa, Anusha" <anusha.srivatsa@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        "Martinez Monroy, Elio" <elio.martinez.monroy@intel.com>,
        "Vega, Ricardo" <ricardo.vega@intel.com>, airlied@linux.ie,
        Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "Wajdeczko, Michal" <Michal.Wajdeczko@intel.com>
References: <20180411044213.383-1-ianwmorrison@gmail.com> <87lgdugc85.fsf@intel.com>
 <83F5C7385F545743AD4FB2A62F75B073338FD128@ORSMSX108.amr.corp.intel.com>
 <87r2nefbnn.fsf@intel.com> <20180420180331.GE3304@intel.com>
 <83F5C7385F545743AD4FB2A62F75B0733390B83D@ORSMSX108.amr.corp.intel.com>
 <F53FA74E706C9843B0288AE81EB4F4A35152EC4E@fmsmsx107.amr.corp.intel.com>
 <CAFXWsS87X_QVFSA+BqefknE4x0o=7Edfp1iqdTD81YCcoLHsmQ@mail.gmail.com>
 <CAFXWsS8H8V3RvArLnvGF1z_TuojgBU6pDoqBccCHGV=s9DNJfA@mail.gmail.com>
 <87zi1pt37s.fsf@intel.com>
Message-ID: <152507513190.4284.14002632591679544744@jlahtine-desk.ger.corp.intel.com>
User-Agent: alot/0.6
Subject: Re: [RESEND PATCH 1/1] drm/i915/glk: Add MODULE_FIRMWARE for Geminilake
Date: Mon, 30 Apr 2018 10:58:52 +0300
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Quoting Jani Nikula (2018-04-27 12:20:55)
> On Wed, 25 Apr 2018, Ian W MORRISON <ianwmorrison@gmail.com> wrote:
> > Can I ask if this is on anyone's radar as I'm concerned this patch will
> > stall otherwise?
> 
> Pushed to drm-intel-next-queued, thanks for the patch.
> 
> I opted to drop the Cc: stable for now. This doesn't mean it can't be
> backported later on, I'm just punting on that call right now to make
> some forward progress here.
> 
> Joonas, please do pick f6d3e06f0747 ("drm/i915/glk: Add MODULE_FIRMWARE
> for Geminilake") to drm-intel-fixes to queue it to v4.17.

Done. That's the only drm-intel-fixes patch there seems to be for -rc4.

Regards, Joonas

> 
> BR,
> Jani.
> 
> -- 
> Jani Nikula, Intel Open Source Technology Center
