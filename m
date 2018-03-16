Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2392938-1521186451-2-14255799092825445892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521186450; b=uRycAptzITEuPF5Ot5oEzMNrisKIn/Xk0YiWFb5Jq0x2LH7
    fb9ABiifOSZLT1Dj0UdQTVcRnIxEorNf0yhqa6R5FYGlS+ijzVjiHWtrPRUa3/Y2
    tWFtI+GgdxJ0UN8ePnULl6jas0nRYBVAzyq72B76n6OBESuEE4UpxntkTz+yx13I
    ifZuAiPHrFuqUWx5RV4gfg2mYdD56v7xnOKpXZVIHKOug9ZiOmAQsotKoQs7vHGJ
    r6MPgVQcJFVkT9jLTEq46PdFF4f+dsA5JoQQyzyxTkQC95q6uqM9ee20WnTjxJtj
    De6Lgo3lhdTtnnd+I8R1t87cNfIbw31Cs7+Cf8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1521186450; bh=K/rTxP/GHZdSmuLLVSU/BrALPL5sGx9KK7JZCo
    oVKFg=; b=fb1pPcqCmn1spMf6ofasIXj31zCMv2mdJ2cbecRmLvIt7nuKXU5VRX
    ocolOKA09bOqZmWpKBTWbHLyxVkJgurAgPvh41TfwADSwYHxIPzHZFY3PkQnZ0iH
    p82SMsNgA9tIu3Ln4q6MNndcATL+oC5uMLN5IXsiow5/iW6eVB4dtk9IOeycDDEb
    oRPJiXM0uUdS1ur1KePqW6SXa/E/PpiFy/08qGfYrfCudrRQ7uY06vHW4VZ71Ypo
    eA7ziqNFzUA5KbTKy0qOZX0oMPmnyoFfJOknho2NWk6vbcvJfCLvPVJXKvB2AGAU
    9FpOUIXaxab9NlxjUfI0pkDR/23yRAkg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=WUzzMuoX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lxVOszT1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=WUzzMuoX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lxVOszT1;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753343AbeCPHrR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 03:47:17 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:44544 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753165AbeCPHrP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Mar 2018 03:47:15 -0400
X-Google-Smtp-Source: AG47ELsNPZmI4M5JwtsMyHt8tC/5aVkrPNinOsGAHwodZELMDlbTNrLzcyFPR6iKy06YcWrYszKuqO1LEYd/xCFSCvE=
MIME-Version: 1.0
In-Reply-To: <278fe5fa-7b33-02e5-12e3-b7760952b297@linux.intel.com>
References: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
 <6c8df688-b456-6f07-9325-6f4dfd8f0883@linux.intel.com> <CAB4CAwf39wW2LmuY-TZNdfgL=SBiDZuXvRNu7MD7j5Nc8O-bkg@mail.gmail.com>
 <278fe5fa-7b33-02e5-12e3-b7760952b297@linux.intel.com>
From: Daniel Drake <drake@endlessm.com>
Date: Fri, 16 Mar 2018 15:47:14 +0800
Message-ID: <CAD8Lp45tvQP0aA=6zg+1j-_0jTxyyNxnrL=Gt0+0WrzeT6XS0Q@mail.gmail.com>
Subject: Re: Intel GemniLake xHCI connected devices can never wake up the
 system from suspend
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Chris Chiu <chiu@endlessm.com>, mathias.nyman@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

I'm working alongside Chris on this issue.

On Fri, Mar 16, 2018 at 12:11 AM, Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> Scope (_SB.PCI0.XHC) has _PS0 method, so Linux will look for a _S3W to get
> the
> lowest possible D state in S3, but_S3W is missing, so Linux pci-acpi code
> will
> probably default to D0

Yes, _S3W is missing, and in this case, acpi_dev_pm_get_state() is
setting the maximum number permitted device power state to the minimum
value of D0.

So the XHCI controller is in D0 when you go into suspend.

I tried your hack to force it into D3hot. Now the system can wake up
from resume via the USB port. Thanks for finding that.

>> ASUS said the BIOS has no problem on USB wakeup under Windows so I don't
>> think
>> there's any update. Anything else could be cause for this?
>
> Linux and Windows probably check different DSDT values

I've studied the ACPI spec trying to understand better, but I'm
struggling with the question:
What is the maximum number (lowest power) permitted device power state
for a device that is configured as able to wake the system from S3,
**that does not implement the _S3W method**?

As far as I can see, the ACPI spec doesn't give an answer. It's clear
what the behaviour is when _S3W is present, but not unclear what
should happen when it is not there.

As noted above, Linux's interpretation is that in such case, the
device must remain fully on (D0) when going into S3. I am wondering if
Windows just has made an alternative assumption that all available
device power states can wake the system from suspend in such case.

This is working in Windows so hopefully we can find a way to match the
behaviour?

Thanks
Daniel
