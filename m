Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3264639-1517600995-2-5647996687377611516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517600995; b=uYf8Wj33K5i6eVKaThgFfRAP+4PHsUIaK2pElVo532PjLKv
    DZpuoxPGg3GlZcmTY/qw+Uj/XB9c5YF7zovk6e09HWXuu5RQlqzsgUNDEH92RjWo
    H9zD/HBtoGGH6UwRLHKEpQg0oErMjnFhcB9gCvWUDgT6pfpcxlXgC9EzApkvT4m8
    wgpipz/pRpgJn+te8MZvmLomDuNCgw3GJrEEEkysywHhb3nh1zpFaYg4PPKBQplj
    dVxyreJVDwMR68r9KSR8wKRBau/dzfabmRo6fUhtBG5PG1IK7BZb/b4q5iIldHzK
    xplGcOQ7p7fVGwOScDoAtQW25fWjSjHAnnWq/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517600995; bh=Pq7damavTKNZibz/AVxhT19BTt5wsJFFba/QldhoZWk=; b=T
    2K64xZK1lNYa/RcCwm3/OaDxnk+07WgGANRYlLKxnC7MLv8RJvaiL5kQsEH0iUc8
    A0CvzNY1UXAAucg9GzX0lhavHzPm5E+1UUomwwM13WOXH1aRBaHk/e12Qme3ZnTv
    MCFM2LKI32fgYYRgExcdH2puuzc7M/9DncJPoQ8j/WX5+1eTT+FY/6uhz2oyJCaf
    zaIb+VF1Amu3UJEblBWd7NNnBGTnCfR1qTkg7gVx2ViIabD5SIqeTn8sTjFQRNEH
    +2bxd5yIAhXfi1dGwNTx1vX67JCqE1nhw+lhp7LTi50Nskyqp0JLmuC2Ysnw22wm
    TKGBNOaxMirQBm4QrBxSA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeBBTty (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 14:49:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52634 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752815AbeBBTtx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 14:49:53 -0500
Date: Fri, 2 Feb 2018 11:49:51 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nicolas Pitre <nico@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Babu Moger <babu.moger@oracle.com>,
        Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Kbuild: always define endianess in kconfig.h
Message-Id: <20180202114951.99d33fb09f8b7d899872b7d7@linux-foundation.org>
In-Reply-To: <20180202154104.1522809-2-arnd@arndb.de>
References: <20180202154104.1522809-1-arnd@arndb.de>
        <20180202154104.1522809-2-arnd@arndb.de>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Thanks.  I've queued both for 4.16-rc2 (or maybe -rc3).
