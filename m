Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520620516-2-10923317217553117287
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520620516; b=E+mTlYwUJjZOsNLBmXG0hYe/X05a22BDsuKWwa0dZYnQd/t
    HMuFiufTwP0Fl3i4j6f0UcLwBpdxy/wMN8R7mQSX/cUQ18rj88AQKXwC0WskbAgx
    7soSFaTvJNlVQ1XR2mgUa2CHjN36y8NllumKRNrgsRHxvAYD/bQvlzmmJnpZU3MV
    akkmGInFJJKL/ecP07NDwllSeWQmjA5ttA7dOUOU6qWJ96AXFxzW9b00asbKDR2q
    5mczZM1WSwSLAGSBeLeX50igBYmofA28/B+lD/FcBNshp9HeSJ5tAGd5TD2LOeVJ
    mAykduXO/TzPTJ58EvDYcM+xfUShqfbQ7HCNd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520620516; bh=BQ+aIwVnWMwdWYoYoyUQELHo9XQTLmWpU4uIa9gWK6Q=; b=p
    XVaSo28Eq5c1bFlvMo7QrneFMzLIiXJPZcPUvDTmfAJRIPtkCuqIaOoToSUIo/hd
    /3KzacNx+/MVL7sNWnZmfytRHy1o/NNHR+rngY4+2x40bQP1lCaEyWTKeQsRBw56
    WR4PoeCz7WQPqh/mNqs4Jkv8+V0AVf5vxx6q2SwsjkWP73BqjS3fDCYzOnD/7SiI
    G8NaJ5089jLEKT/N3GOWMxSMaPoSByeOgRZnkgxewXeOnnTLGdUPJ2U646/549lW
    u+v4AfCaVnGmptK055xpRMAwnytyoZmTYxLTgCuYAO3Ruqmz06mx4qrsd1RDZu1C
    C39igrCn6UHyKG+yj/bxg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932124AbeCISfN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:35:13 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54826 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeCISfM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:35:12 -0500
Date: Fri, 09 Mar 2018 13:35:09 -0500 (EST)
Message-Id: <20180309.133509.1275903267249306409.davem@davemloft.net>
To: torvalds@linux-foundation.org
Cc: ast@fb.com, luto@amacapital.net, keescook@chromium.org,
        ast@kernel.org, tixxdz@gmail.com, viro@zeniv.linux.org.uk,
        daniel@iogearbox.net, gregkh@linuxfoundation.org,
        mcgrof@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
        <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
        <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 9 Mar 2018 10:17:42 -0800

>  - use deny_write_access() to make sure that we don't have active
> writers and cannot get them during the execve.

I agree that this is necessary for image validation purposes.
