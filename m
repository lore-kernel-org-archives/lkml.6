Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-292030-1518535698-2-11438218460156719831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518535698; b=KxOpD31EQ2wK0ofWmHFOawAar9bewAIWIhFeYLWd5csC2ZT
    JRjVUsItn2djKbqmo7DgXc7kQ+FYRqf0WFxl2iZgnX/ksiOAQ6hKqrHLfdLeF8H8
    xjIh4GYCMDwvxPdoKtZceVE9DErA5KwEc1JXy0QaqZA4wtgANZkVs/Jp8j8m/WAk
    3bdVrVsApfbqx0eWZZpe+RQTWgtKrwkynjtCduGQ7uY5N0HSrlnoTS0PRMGBTusM
    rbLs2wfd4N1XL47Sogc8JydsccI0WaHFUS+dAwA+bhe8O15bo7H4/CLT/TB79+bJ
    5AJGnHAx2E3IIHS4h5YeDSVw5NKSrCislmJNPyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518535698; bh=SqP3mpuiLMyNNiHN/VtHbmnGfX4V2a5EhDYr/z
    SJyRw=; b=gdDb+jhmATudmyhdmdhiSHrhx2ZerxwoNq88NFDY/3WYdCjtLRjx1C
    fPVTJRmxs78r9KoqDVzs341cpVKyjXWzsoVBEEU6Lk3NnrmGVyhYXZsJRVUgjKqe
    p6aXgHD2V1o8zij/LjOtM00OjWoBBWBYb+iLX6BJyMvzuNU82mKnumUq0QT4EdK1
    c1IkH1rmDZR8liJermJ2NTbMoeRmIvRj4kMmBlekxH+m9B+vhdgygzxSRHZIkr3S
    5mcbu20zVgJjftglM6R6WPvPZGxrwA2N7D9UL/1RJVj4d+YS/pWFBAtm3bzinbwj
    cB5ouDSZ9bkB22CBxbEY2GhauvaFjdyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L0w4+RCn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eKMQKf4L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=L0w4+RCn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=eKMQKf4L;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964939AbeBMP1u (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 10:27:50 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:42732 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752177AbeBMP1t (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 10:27:49 -0500
X-Google-Smtp-Source: AH8x226RzsdQbnpgoYvclbC6af05hmjbcd5tXgm6vDGbe+FNd4YFivNpLYh4zMQR0zMgCLVBJDr9N4oWBuqmmAZ7MfU=
MIME-Version: 1.0
In-Reply-To: <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
References: <20180209133931.211869118@linuxfoundation.org> <20180209133934.259299920@linuxfoundation.org>
 <CADSoG1tjU2G9FUNOFod4ZsYSw7gOSsza_JWUv5H6pAkbftWywA@mail.gmail.com>
 <20180213150007.GJ26982@kroah.com> <b0680083-5cd2-e152-0d64-f5a931274a8e@linux.intel.com>
From: Nick Lowe <nick.lowe@gmail.com>
Date: Tue, 13 Feb 2018 15:27:47 +0000
Message-ID: <CADSoG1sv4-YmRh8AwD7A93_eDLn4ZTwD0Y7C9jyRyh6nOvwqjQ@mail.gmail.com>
Subject: Re: [PATCH 4.9 43/92] x86/pti: Do not enable PTI on CPUs which are
 not vulnerable to Meltdown
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        gnomes@lxorguk.ukuu.org.uk, ak@linux.intel.com,
        ashok.raj@intel.com, karahmed@amazon.de,
        torvalds@linux-foundation.org, peterz@infradead.org,
        Borislav Petkov <bp@alien8.de>, pbonzini@redhat.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arjan and Greg,

Sorry if I am not being clear enough.

My point is that there is a check for X86_VENDOR_AMD now in two places.

It is still hardcoded for the auto boot option which I think should
not be there. The patch on that basis looked incomplete to me.

Put another way, there is no effect to the auto option where the
contents of cpu_no_meltdown[] are changed and
cpu_vulnerable_to_meltdown returns differently.

The auto option does not make use of a determination of the
X86_BUG_CPU_MELTDOWN state.

This seems wrong to me. It does not seem correct to me for the auto
option to have this duplication with a check for just X86_VENDOR_AMD.

Regards,

Nick
