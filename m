Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A146FECDFB1
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B7620875
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 02:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vaCswwqA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B7620875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731913AbeGNC0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 22:26:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46459 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731385AbeGNC0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 22:26:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id s11-v6so26712082wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=APG+FQRkArRfdtKb9aTu5d8Q2nD9g8p5jh6vr0AHjS8=;
        b=vaCswwqAGYa21UVXa6pRPf24wbi1jS7LEBgPeeGfHq4OYpCoQDgWvHvqnXTI3kdqNE
         h8kKxJzSZMJE8wfyIbM6W6prCfKgAbBgfikZ0sjYdYFABDNSB1rw6ll0lh9ZEww3JJzm
         Q2UZ7fDIWVCHXWw4SK7UpoOcbcG8lHwf04lsMe1ZwYN8K97+DJV13IBArjEPPtUkSmz6
         P6VlyU5sOfx0Ei08OxA2jJKp/RASp0o8Ep/A9qsJeCV6AWMpU2vY9jo6q5pBV3OTuRGy
         FB0q2VbwzbD9xMdfkZkd6DmrErTejs25lWuT+2zCn3T5myqok6d7Z20s2Vuof+mirpap
         zVhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=APG+FQRkArRfdtKb9aTu5d8Q2nD9g8p5jh6vr0AHjS8=;
        b=bMIHAUnCkNjU9AU4EShj/VrYRWG9+4ZzBjEKpHjeEveCeSftVgm6N5a11cqwfOvgsO
         I8CyVviLL0SYfAnV3m4qjHrzbRKnxJv6x5qvog46IAbkz6zOYNfWuZ9TLsyzGtyOd1Ay
         YiWAc/q01pTdZ/nGZscdxaLtj8rDn6Ja/1fnBApPGoTK2Q0TUOT7DU317UMwVE6MZpqS
         3mYQg+dEKrLX8dRSUMvF+mYQHmQpcml/oVKY65Hce7ilQl+VgOdnYZ5PW5tgwh2BF2yr
         c+KmSPUjQKM7K96M4hrB2AhbLKbaXb0FVyfSowr3idPocTBx/JLjDQv4coDSMZ6V8leQ
         R9vA==
X-Gm-Message-State: AOUpUlG5GVLGd/8NnHtLdP7/E9sAe1dZtfH6VZS+qvyBy4XioT7ughsp
        9xVTKzWw3l8EP8IO3jVbfgj46p398I4yNGzJkYfaZw==
X-Google-Smtp-Source: AAOMgpfcFncOTWtLJPIru4m3TotlLYOt57B3glirdVAupThIvGND2dQQuMUVlEQl0Xoyyy5f9na1NaN2Njjafw8zxzA=
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr6408236wra.120.1531534135391;
 Fri, 13 Jul 2018 19:08:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:d548:0:0:0:0:0 with HTTP; Fri, 13 Jul 2018 19:08:34
 -0700 (PDT)
In-Reply-To: <CAMe9rOoX-x-YezXc_1EE9F0Nv3_SuzN+paXsTO11gcTykMr4Tw@mail.gmail.com>
References: <9548e10a-7403-425e-bf1f-b1eb9d055d99@intel.com>
 <CAMe9rOrHowBX06nihdRRmEqhV8v7cs+PwVY7JYQFpUFOnHC71A@mail.gmail.com>
 <f22ee1e2-9a35-697f-50ab-543ac1631c89@intel.com> <CAMe9rOpPwtPd-R+D9=iDYgbFtnP+=akWic-QBKwq9wKa7uadEQ@mail.gmail.com>
 <2022d212-62f2-a163-2493-abecfbafa07b@intel.com> <CAMe9rOqc0oVw+ZLXCM-nrtPb1OiPFBeHt+Lsx+6K6y=t3HSVhA@mail.gmail.com>
 <cbb38230-9c57-905b-3a11-e2717c5aa615@intel.com> <CAMe9rOqh9saaULM_+jNtzfYarbZScm+6KCEyibxxqn7GLvKwzA@mail.gmail.com>
 <CAMe9rOpV89jWhvAZtqOJnc0eXzRYiLF5pLWRcdb7-kKLigj4rQ@mail.gmail.com>
 <067e2d5d-1abf-efd4-cb50-992ba5ca6748@intel.com> <20180711183126.yo7eyqpd4ggb5kcr@codemonkey.org.uk>
 <9A6C6EEB-85D8-4F59-95ED-EB4DA5947BCA@amacapital.net> <f3e2ca08-e22d-f16c-1c2e-9fb1985771ef@intel.com>
 <CAMe9rOpBm71hnzG0wx=2qaWKHYNE30JJOT=Jt4i+Vqs3Xb4qBQ@mail.gmail.com> <CAMe9rOoX-x-YezXc_1EE9F0Nv3_SuzN+paXsTO11gcTykMr4Tw@mail.gmail.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 13 Jul 2018 19:08:34 -0700
Message-ID: <CALCETrUwUdmRAfaKsP0dGXriU=EdoWs69XMwJwxDOLY_9G+1tw@mail.gmail.com>
Subject: Re: Kernel 4.17.4 lockup
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Jones <davej@codemonkey.org.uk>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not at all convinced that this is the problem, but the series here
will give a better diagnostic if the issue really is an IRQ stack
overflow:

https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=x86/guard_pages

(link currently broken.  should work soon.)
