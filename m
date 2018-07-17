Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CAFECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6495020C10
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 11:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lcO7Y+B5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6495020C10
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731498AbeGQL6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 07:58:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52408 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730742AbeGQL6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 07:58:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1111978wmh.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OMI0Ql6sn/AbpklOCLUNhqMiv6N+JxLRBSTizEimIEA=;
        b=lcO7Y+B5ZCpCRpxvH2Vk8bUCkQ3thr9BS0WQc9N4jQj65EeVvQFoxCSGTNZZDZ0IM3
         AHSkGSMIivYD/ARUHA1cV8HgCG0rhG5jMLcPInEP//VGoex7pwLfVwD4QQYDXfq8guJh
         cSgCTUgWklJ3z8b+ZIh8HQszGLpoXx9zWif4GnFinpsPTBgF0DbZwns0rSr3BRdPCqAA
         uGyJ0FrMk6W9+Bj8T8PDrjp7mu101M6oaoE8V0IHnRpxEQjOUbNyt4r+UXYpmPC5RP4L
         kCj9rviE8hsql5Wtl8qxINEPYS0xhLKFqpOVv+rmXD9tl7JLMUMN5e4aMw9ZdsjgwB4a
         s8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OMI0Ql6sn/AbpklOCLUNhqMiv6N+JxLRBSTizEimIEA=;
        b=agSEFAYn40Wh/y3zr0QNAyxxSUpnsEGqh7PCOYoOahgdjihftPv4Dvu3DBZQ+Fa+xH
         wkDQ6P7n7Gb7a796qKrVgJAVI5wR0wKvuhXDRkiWxApKS/HWjtiTavsmnJahoycFmOcE
         3iwa8JkaXHF0F3ei3P4ZRFPvOt6485HG4jhVFKHeu+lOtGgRlTLiTJO513XCrATIotfn
         SQQ4pFzQ19mwcQZMd7xvLihnQgz63My5cXtiDeT25yqZAPJRQ5795cSJHAA76fNDrImA
         O85QSRhbgMwv/vXmiX2P9vSvUgUfabKHUeXauKhA/QVxx3GG50pp+gE4S/6lv1rCg60s
         11mg==
X-Gm-Message-State: AOUpUlEOHsK5SKkdLUTePBU1HD5fGU7NzRSNrNjd11Sgr21Ek3Swp1vm
        H7r9PgQPjHCcN1T+JyVAMPsz6IODoadoc9ZBN9qFYQ==
X-Google-Smtp-Source: AAOMgpdlaTip+tvJXR2SRU4bm8rd1G4ep1jHGMp/47MTP0OTH4J/9BaFjYz13bFVSwCnUliFud1+qL1OQalCNR1k4cs=
X-Received: by 2002:a1c:8b81:: with SMTP id n123-v6mr1085195wmd.142.1531826749097;
 Tue, 17 Jul 2018 04:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180717020926.176408-1-toddpoynor@gmail.com> <20180717111600.GA17117@kroah.com>
In-Reply-To: <20180717111600.GA17117@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Tue, 17 Jul 2018 04:25:36 -0700
Message-ID: <CAAW3Ypb-5=oUWdRP=DdR50onROXYn0PD2ofoeCttnP09Qq_pHQ@mail.gmail.com>
Subject: Re: [PATCH 00/32 v2] staging: gasket: sundry fixes and fixups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, sque@chromium.org,
        groeck@chromium.org, Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 4:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jul 16, 2018 at 07:08:54PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Various fixes mainly from the chromium review of the gasket and apex
> > drivers.  More to come.
>
> What changed from v1?
>
> You have to list it somewhere...

I have a list of each changed, dropped, and unchanged patch from v1
here, was hoping it's in the right place for that info, does it need
to be elsewhere farther up?

>
> thanks,
>
> greg k-h
