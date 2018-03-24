Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3533675-1521882341-2-144115816086951059
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521882341; b=ojCCnE9Ay1Z9p+sAZEmyBnzB3bv/8MNr7itGjcoKOPbT6cK
    ZRW5zCkKOOEZhbjB7P+yY15Srfp2i0Sfdg5FoOVEGrFjJonRq9pblKaf8hsjw9CU
    Gl7HWC48hIxzWwRyKtrDIdd3VMMrA8HoOVDPM3f0xRFMH+OtzgXyv25LWqBs38xE
    yJVPtseN85cDoH92Ic0JbkHqX8nNg0yCvFCE2ov0g3oZPRjtRrOqEWAlwqFVEZrn
    cZvQPFyD9qeVuMr9yNawhEpBC+I6EAMOpzJITlSC8b9EGPc7Yxba+NCVom2Aj0IE
    LPOuToxHKukLgTgh1OQ8+x8bAeW6WOEIUuHpmpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521882341; bh=/2xRLAw
    WyWrw9dHVAF/8wjpeMJh6ccK+2XFlAyWsEXE=; b=I+JHYSbkE02hrW/OgO/QL9s
    AjI+UllvQ3EQjlicd4/DQ2YAZTfGnKeqhj/cZdG2HwhUOiD4KvhPFmkqrLpBF+b2
    1udkbyKgy4gAucCdCygbmgpnGy7Jz7y80z+RWRf/yXdky6BpbDaS5Dz9vFd4s9hq
    w9CBQURfA3JFwbAZNpUaKXdXFb9+fcCrZRoJXIw/aQMPnpENTZhcw3RZwlKOkKFX
    e2lE0x6utoSmo1Kxu/aM0wWl6UhGB4VuIH0ISvaUtyLVBhcsZuAkoq8OkpVHM9TZ
    GJItpiwW+UPKn8dqtA+BlQOrQKJ1xd0iq20dsf/1DlcEc8ANcIjk2M2Qfv5Kj9g=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750801AbeCXJFj (ORCPT <rfc822;greg@kroah.com>);
        Sat, 24 Mar 2018 05:05:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52566 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750797AbeCXJFi (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 24 Mar 2018 05:05:38 -0400
Date: Sat, 24 Mar 2018 10:05:33 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 4.15 00/84] 4.15.13-stable review
Message-ID: <20180324090533.GA1170@kroah.com>
References: <20180323095411.913234798@linuxfoundation.org>
 <CA+G9fYtYBMr84wUTshzryQRLuH5o1u8q71SnKVp_cq0ohofFsg@mail.gmail.com>
 <20180323164026.GB5063@kroah.com>
 <CA+G9fYvdedeRG8+omRFGWUOd34rYps0-Lgptu1ToOLFEY-Zipg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvdedeRG8+omRFGWUOd34rYps0-Lgptu1ToOLFEY-Zipg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 24, 2018 at 01:22:36PM +0530, Naresh Kamboju wrote:
> On 23 March 2018 at 22:10, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:

<snip>

Please properly trim your emails :(

> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Great!

> NOTE:
> Due to Infrastructure issues test did not run on Hikey and dragon board.

Not great!

Anyway, thanks for testing and letting me know.

greg k-h
