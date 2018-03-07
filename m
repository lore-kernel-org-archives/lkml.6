Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751116-1520412489-2-18285212657684576418
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520412489; b=q314Dn9fCxLLMEKdpVimkORRk7zr87o6aRsRLBvlRFrya1a
    lZ8nm1h6z76pVM0vyw2TzwiIkgRKaVEiaoUmRlc2fMK9zDBbVkUE6t3IPFrFRd6p
    jNL/D/aTfQ1id9CFldzQ8sgSTxcMLovC3lIzgSZ/fIoLvDw/7YvwdKmBUrKdhszT
    UGYt0JdYAjjzTe6eMuIVhE/ePVVKFbm6j+2Cs6jLAqhw7lHVfYPwzvLy1OqD6LuA
    ZzetFE8cmO2jedS7re9HGbhrBcAZ3vZCV3osG5jg+oGnqElloDv95Pa8Lk+gb5LI
    6Ok+uzLgvZJXk7keWwCLhDHRWaSJsNXZERz9oDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520412489; bh=KeGmvLkWPHfSVdQB+Kk8+lhfLwFPwIgSc2X58T
    Ud3O4=; b=MFPyErTdk7e4JaKxRc28AyCyidr14Vh0d3ulQzVBQPiE6BcEYKrexA
    fc0DVuZZ4rRNPxVG3x4sLSN/dYbLAwcflnfFyb5DEgvN9lV+/wsYAoddM8boD0Yx
    iLMjt+lBon5pgZvECY4Pq9zyWkfQDiTf9XO15KdzGkJPmTBUmWDbrdM17oIcu/cM
    IVDd2MHE41ooHFPmmfGPtj2i/Q3g4H9IBUK5hFQZI0Lb2lt/WysHySGHTM7ZVZqU
    BvnqlYy6Q6/n0M2Tj0ADQHVEJ16eERFqgll1I21Nkg5FGVG+PtdpcaPLdh4ZN6GE
    xgyEShYvnFsWfzYr/PfsjR5q1IkVZesw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CpVNnG3O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r+dj4yFA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CpVNnG3O x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=r+dj4yFA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751177AbeCGIsH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 03:48:07 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:37843 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbeCGIsH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 03:48:07 -0500
X-Google-Smtp-Source: AG47ELvxU90sW8oaSKZe+Bp96mT9a4ZaY/W/mTtn9QSSqcrmcCiWfTlV2Lvkq+1y9LBmN6HSO4fJcH9FTeuOmzP7dzU=
MIME-Version: 1.0
In-Reply-To: <20180307012941.GA27250@redhat.com>
References: <20180222155627.1800948-1-arnd@arndb.de> <20180222160432.GA16971@redhat.com>
 <CAK8P3a1jpj0ZCs81YJu0Dx3QFSypQ+VBr348UfEaagcuvM_1gA@mail.gmail.com> <20180307012941.GA27250@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 09:48:05 +0100
X-Google-Sender-Auth: h0uD5fUx_lQxGsNBYtz7oJC80aU
Message-ID: <CAK8P3a3fnHYRSZ8X5G7fd5oVORM3fm7PLcuuPytkR9VQWHJygg@mail.gmail.com>
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

On Wed, Mar 7, 2018 at 2:29 AM, Mike Snitzer <snitzer@redhat.com> wrote:
> On Tue, Mar 06 2018 at  4:33pm -0500,
> Arnd Bergmann <arnd@arndb.de> wrote:
>
>> On Thu, Feb 22, 2018 at 5:04 PM, Mike Snitzer <snitzer@redhat.com> wrote:
>> > On Thu, Feb 22 2018 at 10:56am -0500,
>> > Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> >
>> > Mikulas already sent a fix for this:
>> > https://patchwork.kernel.org/patch/10211631/
>> >
>> > But I like yours a bit better, though I'll likely move the declaration
>> > of 'noio_flag' temporary inside the conditional.
>> >
>> > Anyway, I'll get this fixed up shortly, thanks.
>>
>> I see the fix made it into linux-next on the same day, but the build bots still
>> report the warning for mainline kernels and now also for stable kernels
>> that got a backport of the patch that introduced it on arm64.
>>
>> I assume you had not planned to send it for mainline, any chance you
>> could change that and send it as a bugfix with a 'Cc:
>> stable@vger.kernel.org' tag to restore a clean build?
>
> I did/do plan to send to Linus this week.
>
> But I've updated the commit header to include the CC: stable like you
> asked.

Got it, thanks a lot, that brings us down to two kernelci warnings for 4.16
and one for 4.15-stable then.

      Arnd
