Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1551978-1522892746-2-11469940459412184923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522892746; b=rO49hEjB4CfN/VQDZsinPgMyVbgSQg6qXd1SS2agVZJpeMEKZx
    dKCcP+YMR3VuclTiOyoUENlBNa+My1YL2mwrLgIMRnJrS2eW0A/G81esHla2RTjn
    lttNg9vj17zgniTlgtU1uRnGl8szr+eah2AfjVVx5leM0PpkqysSgeXw9XYXoSgl
    houo6e8Npo2JdkfVGKHbu/LPpRRIT41bRdNG8yzHfrvf2EIUR8AJLsoXI7wEsaAs
    wfXvbWu1LvuYLZU6ItJcs7GUq3i1dxKArNfTwzNR4p+tz1FIJtVh8MOyT0XOYh2K
    nG72ZbQTUDM7vVZjGC+6GiJk5I5j01xG4GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522892746; bh=awlFXby0TISYJtOgj0Drmzlnq3jalF
    1jefpsw0sLXQU=; b=nhG+D0MTpGQpxs7coJ1oThp/mlO/KW9QuDG51Y+m5xQniZ
    0YidQNoQ5qVuqPLbFRI6KL4yK+5AzpK09sE+WlcbcAvY2roYu4n/l6ugqDLw/ABM
    Xl2RvxheEu0iJ+T5XBo9ppkFmcq0hni9WV6Txxpdy5O8ymk33rE+ii79E0rIMQ68
    NM2yOjdvOHPGr8DQTPY7m13KTAlfD8tFdyEJxJVwlUdQE/2JP83/8T/q3YHkdmyI
    JXui/VqCwTG0tUSTQw7jGHWZ5LtI0353IeO/p7PdCmfTXVVfqgGxK/pJOjIr1fbN
    8Qv3+ycQoUpdoOWrVLgF4oq72OUSXFB+w8W85htw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO/cHP1dJxxhIyT7N1NM66RiYnHhIgTl158krLtLOV1mIp81cTF5fmhUP8DcVh0nvCRYlJ31vC0cwPNOxUvOdqinZjy7ZelR3Na4s5Ml89xjSeHMKdhk
    QUPERKU1v+YPMwKWVile1zOlafCWEExzISfcLajYf3Za8hs1oyCAXUD0kZnV6FTIeSnoqmkP16w6eaj2scTWLeIMHnMhQDKpIwBpLlRpTnkHImhPHcfMh8az
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=wCyhSim1WySiQ7r30DAA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeDEBpo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 21:45:44 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:40593 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDEBpn (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Wed, 4 Apr 2018 21:45:43 -0400
Date: Thu, 5 Apr 2018 09:45:21 +0800
From: joeyli <jlee@suse.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: An actual suggestion (Re: [GIT PULL] Kernel lockdown for secure
 boot)
Message-ID: <20180405014521.GA7362@linux-l9pv.suse>
References: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUVQLDC6_VEvuAbdCOuGrmcxohqTB6P8eyNojm9AryNkg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Andy,

On Wed, Apr 04, 2018 at 07:49:12AM -0700, Andy Lutomirski wrote:
> Since this thread has devolved horribly, I'm going to propose a solution.
...
> 6. There's a way to *decrease* the lockdown level below the configured
> value.  (This ability itself may be gated by a config option.)
> Choices include a UEFI protected variable, an authenticated flag
> passed by the bootloader, and even just some special flag in the boot
> handoff protocol.  It would be really quite useful for a user to be
> able to ask their bootloader to reduce the lockdown level for the
> purpose of a particular boot for debugging.  I read the docs on

The "mokutil --disable-validation" done a similar bahvior as above.
Just it lets kernel to ignore the secure boot. 

> mokutil --disable-validation, and it's quite messy.  Let's have a way
> to do this that is mostly independent of the particular firmware in
> use.
>

Why the disabl-validation is messy?   
The mokutil is shim specific but not dependent on particular firmware. 
 
> I can imagine a grub option that decreases lockdown level along with a
> rule that grub will *not* load that option from its config, for
> example.
>

The root can modify the grub config to decrease lockdown level in next
boot without physcial accessing. The mokutil's interactive UI is used
to deal with user to confirm the physcial accessing.

Thanks
Joey Lee
