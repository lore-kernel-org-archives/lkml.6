Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-176773-1518788166-2-2682589794996819497
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518788165; b=aAA1TxfFWcs24Yo9Lgir5vIcG73HTsi2fCQIFoAYuEb+udg
    9mRRWxKwsOj4jZ98pd47lSttJe5BZRhAixxYuHimzhGAYY1fEYrHDOe42wNFySmZ
    CIDP3wLFNP6bLHCjOpUcNvCTkcG2kf1xBwt89QzBxPRoNdhXjFfFxDmbV339zmix
    AyN8r1iL3PLQLl6RR5ysuzSCfv5wUd3sar4y+SIa+G+iqMebd07iSwGCZLEnu2qm
    nERtv92iKA+wAmvfpC0FAGzuFXiKH9dyFAICYo/JfZD3/AdO16KjjYGE5JcK/Nuo
    U5hUql1XDpwPqbUu4ayHkwMxXl5wHb8112RP9fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518788165; bh=GAQrjeYUPb8lRTyJSjW4ungv8G9BR7O0LOOya6
    ze4+s=; b=Jj8dm5IeMRjhDcHU+sftx53b/6XyahXDUlf9Yy2sv2vWMNJupX29sk
    KOaI1axiK7VwmJU6zjK5WI1kVJjT2G7G0IuYVe92VieLgfK17AAgd074WW4EKoMg
    Ex5/l0fwaA2MkAjPdLbWWG/utCWc0TN7HtlZKjbthTyFgHKTbcVFIUITADVjsVXU
    /cph/ksz17kaTH+XKDa4i74gxsO3P7ECN0qZ1xSVwP2o9mZbUhO/2rOVqq1v32fM
    viEHVN67VR/XuoNvV6k3kdiIxsL2n3w2O+GZoQ0fO0iEaMkzohS2CVTmDzn86xL9
    llhT9HCAZ0WPFYc4W7A6KW+ZvN18vxuQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WivK01qf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HOYIxiyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=WivK01qf x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HOYIxiyR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031418AbeBPNgD (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 08:36:03 -0500
Received: from mail-qk0-f173.google.com ([209.85.220.173]:32827 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031222AbeBPNgC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 16 Feb 2018 08:36:02 -0500
X-Google-Smtp-Source: AH8x224AszT0csaoznCwlxWQDuY+nSr3I8mwW+KG4rwUbKeINM1KGJWOwg+38v30yjpmw/BfnqubOrzXTxP0l7gbjQM=
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-1-hdegoede@redhat.com>
References: <20180216104751.8371-1-hdegoede@redhat.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 16 Feb 2018 15:36:00 +0200
Message-ID: <CAHp75VdmCCdX01Yfts1kkkLN9ZvrN5iOWbzcGRM3raK5+8Kczw@mail.gmail.com>
Subject: Re: [PATCH 00/12] USB Type-C device-connection, mux and switch support
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 16, 2018 at 12:47 PM, Hans de Goede <hdegoede@redhat.com> wrote:

While I'm going through patches, one notice to all of them: be
consistent with xHCI abbreviation.
Also check others, like vBus (or whatever is standard de facto to show
it in comments and to the user in messages).

-- 
With Best Regards,
Andy Shevchenko
