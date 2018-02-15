Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691801-2-17827241004282620259
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: cc='ISO-8859-2', plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691800; b=WmjwLhYBeUjVXQRLQQY8/8uZTHhVtfBR/WetRskrG4LyVyv
    TDs7tZ7T1eZspd/g8ZM0rPhjXdf8dDwnMiJjA66fXpM2WF53D/NmIFUCuXmqtUvK
    ctbT5E+A7vhA3p+vxq+IIPNO7xyth3FMMCWuByoK+DCy+BnTB3aOQuT8u3NwqD3p
    AG2iU2Gg0/nUpqIKRhTbpnijfjnkjRjPoUlVtfQEPxgI/xz7xByZwsyGg0Xyw1ZD
    2Ia3ZpIirasDAr+mNS4sUJxdTINCVNpCg/pItoHygrt8jTa5QGt5DtySHMkrimsn
    MGBPNSR80RvOC0XoLv96I9JmJ+4zJNYVyTwCPdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=arctest; t=1518691800; bh=NEsLP1TaF11qu93Cc04QcHPpx0XY55wvRBI
    dttotJ3I=; b=OlfiySlrjSTncNptE0g8CCf+MhxFABjjWqi1BjCDf5jRbgu1Jgf
    Jw2ammjCSXOefpz21Bw8ozYiYdOcRNOeE6DAwNbQGgVX1McVAmIV2w51ONdlFfIT
    l0Mq2apxVao42A+EpRfSdwFbtiY3XlbRa6MNyXXPwgExQ/5p9OBU5BpeH0RGSSUU
    BZHIz2SDXM+U8TaI3B8Ozztg8eExKeklSaKPhUAfBrrInN91xnU0T951Kz3il+H0
    GL/mKJrNfhhMa3+PKDARLreLoHJAIFnocfGC1yUbPeHW3scO28v+u4iE4SIfrrNG
    tpNn3RhyQJpk4SGfNY6j8ixwr+AUUG7xUng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lio96.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lio96.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lio96.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lio96.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755302AbeBOKt7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:49:59 -0500
Received: from er-systems.de ([148.251.68.21]:36770 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755283AbeBOKt6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Feb 2018 05:49:58 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on er-systems.de
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.1
Date: Thu, 15 Feb 2018 11:49:54 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To: Greg KH <gregkh@linuxfoundation.org>
cc: David Woodhouse <dwmw@amazon.co.uk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>, stable@vger.kernel.org
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
In-Reply-To: <20180215102341.GA19398@kroah.com>
Message-ID: <alpine.LSU.2.20.1802151148570.14387@er-systems.de>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk> <alpine.LSU.2.20.1802151109550.14387@er-systems.de> <20180215102341.GA19398@kroah.com>
User-Agent: Alpine 2.20 (LSU 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.99.3/24316/Thu Feb 15 02:21:10 2018 signatures .
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 15 Feb 2018, Greg KH wrote:

> On Thu, Feb 15, 2018 at 11:15:41AM +0100, Thomas Voegtle wrote:
>>
>> Hello,
>>
>> On Tue, 6 Feb 2018, David Woodhouse wrote:
>>
>>> I've put together a linux-4.9.y branch at
>>> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
>>
>>
>> Are there any plans for a backport to v4.4?
>>
>> I would volunteer for testing ;)
>
> Care to volunteer to do the backport?  :)
>
> Why do you need/want this type of thing for 4.4.y?  What is keeping you
> from moving to 4.9.y instead?  Or even better yet, 4.14.y or 4.15, where
> everything is fixed "correctly"?


Puhh, I would love to do the backport but I had a quick look at the patch
series and that is beyond my scope, I'm afraid. I'm a tester ;)

If there are no plans I know I have to move to a newer kernel, sadly.


    Thomas
