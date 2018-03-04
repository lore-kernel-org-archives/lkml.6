Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2187568-1520152165-2-12285062665381223377
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520152164; b=AQU2aiyvevEBtycZIvyK+DYGvLN3PqI/A0WBto4jxsnNkOL
    qgKSwNfu/FYzbdbgCjw80+RLQLxm2ryQPgRlBk6sY1DXhAcvwiPAEVfFiKnvqFBZ
    tgyor3nVlUApbXk8RwEwKMp8K7ue2iAwd5WcTXKJVKUHDssitRV8OudLFGc1MjzU
    IJJNvKqzSNPClqh0HJW/vyIIEfYK6UU2XMi7SiBVBOHo4eK5/RQ6tSwvrSucFGUa
    4xiaLbI0QoNa8FrjlTngxPEoAXXLwU8Y2S/5tf1YubQ4IOSisJswINLPWiE5dHe1
    iHrdqCfE+C0FVaKIqwcNYbyMTziKDmn8rcBP9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520152164; bh=vVAaIXNpCeXcjQ4A0Fog3a4UV2UdheLMhp3vWp
    f8jPY=; b=wFyJmpIhhOdw95hYIkPkX9PKP+oJTaD8HsbxVABeKWJCx2P2Hh50/Z
    aeg/CYPN7paW7TTB2Ppy9Sm4DJ8SWPEULVcEMFh+2NSdpfezeLrXlXDIaMz4CUfp
    Z4w7UjQANI/R1K6/7NlbejJEnLH0MeBTeAkKozXtwZTE99jhkP/9xqlHTVJLZHV1
    qlMQk66fS5HdcCC9u2gf7hUZZ8zNi4xLzEzauPVm9pTNZo0dczVO5XcTlFz5s0yi
    V/fnhag7tsLZcL8wjQfDL4WK9KhEr04ILG80UxF1EIem6p/e2n3S0522jiZn2xby
    XGoYgQOqju7n8+E1SfkOT4Is6wi6VFsQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RfbYeJvR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W2wJIgOS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=RfbYeJvR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W2wJIgOS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752079AbeCDI3U (ORCPT <rfc822;greg@kroah.com>);
        Sun, 4 Mar 2018 03:29:20 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:34385 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeCDI3T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 4 Mar 2018 03:29:19 -0500
X-Google-Smtp-Source: AG47ELtLESeww22IpYaKbNBljgOH5xNGOGTXS1snIMxzd0jUGycWjHkbwsesR9wYiJEPts7a28ETtDKHAGN1uhSUp+o=
MIME-Version: 1.0
In-Reply-To: <201803041449.vUjSizBZ%fengguang.wu@intel.com>
References: <201803041449.vUjSizBZ%fengguang.wu@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Sun, 4 Mar 2018 09:29:17 +0100
X-Google-Sender-Auth: vsdnEZMOqWJWYTGp56am4kznGkk
Message-ID: <CAK8P3a3k5pGWuurWVNmPWZ0AXiDjARux8PU0ve3RjWdC4WtKUA@mail.gmail.com>
Subject: Re: [linux-stable-rc:linux-4.9.y 6083/6211] warning: __mcount_loc
 already exists: drivers/net/wireless/intel/iwlwifi/mvm/rx.o
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Olof Johansson <olof@lixom.net>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Mar 4, 2018 at 7:21 AM, kbuild test robot
<fengguang.wu@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> head:   85afb4e51ccfdb10f2969b24439ae2887fe0fcff
> commit: c0ecbd663fe6961c6ff181a211f090005858656f [6083/6211] scsi: advansys: fix uninitialized data access
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         git checkout c0ecbd663fe6961c6ff181a211f090005858656f
>         # save the attached .config to linux build tree
>         make ARCH=i386
>
> All warnings (new ones prefixed by >>):
>
>>> warning: __mcount_loc already exists: drivers/net/wireless/intel/iwlwifi/mvm/rx.o

I'm pretty sure this is unrelated to my patch, but it's a recurring
problem that we should get
to the bottom of. Olof's autobuilder has reported the same thing for
the 3.18-stable tree
but not any others (for every single file in the kernel, not sure if
this warning only
shows up for all of them, or just one module).

         Arnd
