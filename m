Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2086647-1522909889-2-753692041386346857
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522909888; b=cBPGC/3an/AKdLwJgcM2H9VqeKEcx9THqha6AZmO+r4YmbuJUR
    9a86+dqLP1lNZfcpe4qGpCgzU8zfWj2KP1puzP8AKp6YvYf8TWemzg57oPswAuo0
    F7uaIq2jRTdgJYJYFtj5i14C4iLw0s5JqlkQvGmTlIWl5tvpoB9x+fB8Q+otSIvj
    THpiMxTfVA8/xE2e2/FVZn5D7Bixx+V+uIjbfaPUZ10q4YyyFfg47fUw0Q80LBre
    ClTC2Hgr29iICuBfildOH/xg7IHxzulje06kTy+QYnBaHqbxWRQhTkyFXVp/msvA
    nLjjDD+6s0h3tLSZOFQ7VN+F6sMPc5zqAyNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522909888; bh=gTGlZa19U/B0qBx8NT6VJ1Ny1ooid390vYmhH6S3RP
    4=; b=DXauNj6oPLMevq+Poycj5nJqypfAvsRvlBmyK87gSDv+0EPENwrQ/EBWfY
    Njxy7pE+AsIZy8bIo2H9coERdegfvseL36FrTY9fAFXhNmhVJkxm8kst+cCWKhg0
    UIn5bZBk29VgYlSRTccUqj8UtSqwsgGr+b9BQ8ViIXo4sgXsTwFbdjkdkdbG4AW7
    bwqtjCACA/+Er7pztacPMC2tYxQvcRcTvqrUQKQF85DKs5x5RVYagt5UAVch+wgi
    9/H6A5V7CoK7Jhpvpp49Z28MW326Plt20Zf8NULQMF+p9emgf62xi2kyxs/ZdVy7
    6awZVJbCwIbf6y3Jiy/go/h5rpIw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=I8YnJJm3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kxcdmA5u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lis/z1tI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=I8YnJJm3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kxcdmA5u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lis/z1tI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMUcAFSm0IMdXwW/TwZMpbPN745C+SA2JzcHuB9MbNs8rxkfjeiwqXVpwcrBTG1JsueDiEM5w2J1eY8GqD42pcwtsXMMHF6hsx3X7ZHSS/YCb9C7Jv8A
    /zHZzYMn25X1eutGGvheWlEiRlnQrRxYyCsiHKHkEtWm+GSmciDqkFVIP8GcCjOit6CfZtGdhfNL9pwtJHl56ATS04T3uOSocxgy1N0f48znkbQpzSCmU3OS
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=G77Pg39t-HBJMwQ3zWYA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeDEGbN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 02:31:13 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:41401 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbeDEGbJ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 5 Apr 2018 02:31:09 -0400
X-Google-Smtp-Source: AIpwx48bNl6NJyvfFwl/AL+t3jzVz3CzpXU/uajHfA54nMvqas0Wj03mJq02ZPYzoj8aZoufej4rDdY5/exvm0kYIkg=
MIME-Version: 1.0
In-Reply-To: <20180404103121.GA7420@kroah.com>
References: <20180404103121.GA7420@kroah.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 4 Apr 2018 23:31:07 -0700
X-Google-Sender-Auth: D6DFjaiCr_pal-TaKtagLMZPYjI
Message-ID: <CAGXu5jKHivZfs_1KfCMM2i1Z4Q5Vs2k7CX8P2twtuVQ_tWmT7A@mail.gmail.com>
Subject: Re: [GIT PULL] USB/PHY driver patches for 4.17-rc1
To: Greg KH <gregkh@linuxfoundation.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 3:31 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> Lars-Peter Clausen (2):
>       usb: gadget: ffs: Execute copy_to_user() with USER_DS set

https://git.kernel.org/linus/4058ebf33cb0be88ca516f968eda24ab7b6b93e4

Isn't there a better way to do this without the set_fs() usage? We've
been try to eliminate it in the kernel. I thought there was a safer
way to use iters now?

-Kees

-- 
Kees Cook
Pixel Security
