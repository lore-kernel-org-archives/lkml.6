Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1353193-1520372032-2-16515507669596340624
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
    t=1520372031; b=p3HRbrStheYyei3KNr7YjFt25RGMpSssh9SmtX4z90YBd9b
    sN6rSbQRsSbhQPrt/KEHNoMLLlE78PTKo1bO70FS0JtWD393tc/TsH+lX4VMaAAR
    xHKkBGb2qPfkLmHkXz7bHmT+lAAo+G770qm8nI+TTkrdnCGcEalWiF9q2pHU5ysF
    ECu1zRnrod2G8/5MfPlFU2B1UsWPB1bJUUiMtJ2iTFF7tlTBKCgkMN0U3ine+HqC
    v5d+TTassrBzYstBXDor522KDNwuBzmJuXveR6mq8fe6UzcQ35uVPxjbghaLjknV
    Oz8P+/2Pde7emBPemoHCv4NukkqxDp4L2E8jCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520372031; bh=n6N/HdpOtzkGkM9iWF42mJY/27ecOzRwBIde8Z
    D0sHY=; b=HM4UM/LX4W00SS/3FmMbQawJEsEUxE8oQ6sbnTrAMbqWyMDZepB+j6
    aOZjDcuCtKSxIjUxMNB/jK/jyh28MNVG4NwbqqCwrhCOUOMY1/n6d4RvjJKvtVCa
    RsLPSX7bo5+BqSeLNt7KoCuXaRLyy+FB8UZbyeRzhcZC1Z4XP0TBDpAx76ljhlzq
    MhwTjMNhoyIDSa+rb2Y6SB8ZaBpx0vZbZ5067HdTB5cOEWoIjVz2NHm5pRx60HlG
    EvMSJOo/JZOGj7wx4wKCMEy/xRWI6B4/SYho/gv/F+3Tb60qnqnBDkxylfqwqpuh
    alwylglHzmN72Da1y/DCCzah+t7HqJgQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ettC2Gww x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jMyajYzQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ettC2Gww x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=jMyajYzQ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeCFVdt (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 16:33:49 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:39806 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbeCFVds (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 16:33:48 -0500
X-Google-Smtp-Source: AG47ELsuvacIiDIRd3BH9jBve3pHMP+N7u7KZmAa/fGf3FzIE3qtnfVzusiV1IF5t2VM8ZRByYuug2sI2V0gMyEnsNY=
MIME-Version: 1.0
In-Reply-To: <20180222160432.GA16971@redhat.com>
References: <20180222155627.1800948-1-arnd@arndb.de> <20180222160432.GA16971@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Mar 2018 22:33:46 +0100
X-Google-Sender-Auth: 6i29Pf7p3MYgoodUNjz73azYA8Q
Message-ID: <CAK8P3a1jpj0ZCs81YJu0Dx3QFSypQ+VBr348UfEaagcuvM_1gA@mail.gmail.com>
Subject: Re: dm-bufio: avoid false-positive Wmaybe-uninitialized warning
To: Mike Snitzer <snitzer@redhat.com>
Cc: Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Aliaksei Karaliou <akaraliou.dev@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 22, 2018 at 5:04 PM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Thu, Feb 22 2018 at 10:56am -0500,
> Arnd Bergmann <arnd@arndb.de> wrote:

>
> Mikulas already sent a fix for this:
> https://patchwork.kernel.org/patch/10211631/
>
> But I like yours a bit better, though I'll likely move the declaration
> of 'noio_flag' temporary inside the conditional.
>
> Anyway, I'll get this fixed up shortly, thanks.

I see the fix made it into linux-next on the same day, but the build bots still
report the warning for mainline kernels and now also for stable kernels
that got a backport of the patch that introduced it on arm64.

I assume you had not planned to send it for mainline, any chance you
could change that and send it as a bugfix with a 'Cc:
stable@vger.kernel.org' tag to restore a clean build?

       Arnd
