Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-886641-1526504172-2-6882977581515887788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526504172; b=eo8qd/gpOrShjdqQem9wgVMuS9vvea70FfNOcnbGteLvv60LTw
    vSa4v5JGcJ9SG5uko2aOIXZbPckVW/2z4QEq0XjomzfQv745hNvpMt4ha2iA7p/w
    KUSm6UBidnH1Lfrxi0yayYCNT2w90IVxjOkOdREvO3BJVLZrXBLT+kMny36xpo5Y
    0STDRb6H3kNx7kR1toGrEMknUiezmZE537zZk0T2+bNlmKfh7VmpDgoQ7tEAMwwH
    mqJHLS28nsjqzmdZRnAgTu/Wz27VVgDverfAK6F7vIcRTdm/iAOrLDhtvqb0eI3A
    WThUtfvnPqxqpUxL7qbYN04YyML2a85ZjY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:cc:content-type:sender:list-id; s=fm2; t=1526504172; bh=0cDd
    Fqte1CWz6Fi4VRRI8FF8pV5F7lYRb+HbBCeQWEQ=; b=G1ElEfbXV9f5ijIGoeNe
    jcQ3GGbSDIki0D3XXNEzlrdllwZ3zqRSP+O6F5X5jefPWb7fqFuT22Ybqj4LWcgU
    VwN71CX7mESY5eOPUBQ9dzPklYj//onGu9Iu8+T8qmsEXIt0GbI/ksCtSiVhIj+a
    VXI2kVCbV4w8LQC0p25vQlORRq9k4F+Jum9kPCUU9pc6gBb0i3Ve9hg7symbKVst
    jYnb6HmQA04Efod9UNnn94UuzECHGlxLozHy+iTYlarYPFHpTAM7JpzSpj41gdwe
    SYemTRpYBQRWOEsUauUEFZFSSNGsdvlF23WIPggLTwO5NmcYs+78R488Z1kdtJmC
    Jg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=paul-moore-com.20150623.gappssmtp.com
    header.i=@paul-moore-com.20150623.gappssmtp.com header.b=oZ2+W3Uw
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=VwvrOZtF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=paul-moore.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=paul-moore-com.20150623.gappssmtp.com
      header.i=@paul-moore-com.20150623.gappssmtp.com header.b=oZ2+W3Uw
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=VwvrOZtF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=paul-moore.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFT8FvTDGD8HxzFzuHbbS5+cPtK/93bVgUbvLMQcLLj4qt1GiSFefN1py8F/RfayUa/anIH36r3wWoEYm47wRfStz6E7MX8tW2YOpD3yRyzUPedI7Z8x
    nTweWOHBX8cUJip/7Rn/kXt9TDYJXDRJFpaaoSqzJa5u+/UZNsS/2FfMHikyMn3m19h1MRV+KmgR06FYGNtxWJcGvboYF66pR7GKni+lmMCICLTIBGLqDvzk
    hE0UT10VWLhsnCdflK6JMA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=xVhDTqbCAAAA:8 a=yCOx7083dxSEFXcUPX0A:9
    a=UoK8bPlv_A4Fo60R:21 a=h_TDiobR3riGgBI9:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=GrmWmAYt4dzCMttCBZOh:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751467AbeEPU4K (ORCPT <rfc822;linux@kroah.com>);
        Wed, 16 May 2018 16:56:10 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:39901 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750953AbeEPU4J (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 16 May 2018 16:56:09 -0400
X-Google-Smtp-Source: AB8JxZqGnx2T3wOlxsQ6avWzaADR8qX8tt81Gdx83jfHECw8AFrTSNU7yeQIQAzReVykclN2B14zFCYUQ4cra2+GqZ0=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 16 May 2018 16:56:07 -0400
Message-ID: <CAHC9VhQfFXGXqx9seQy-EdTHauyqarYnCVChjd3s6BexQ+tE6A@mail.gmail.com>
Subject: [GIT PULL] SELinux fixes for v4.17 (#1)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Linus,

A small pull request to fix a few regressions in the SELinux/SCTP code
with applications that call bind() with AF_UNSPEC/INADDR_ANY.  The
individual commit descriptions have more information, but the commits
themselves should be self explanatory.  Please merge.

Thanks,
-Paul

--
The following changes since commit 6b6bc6205d98796361962ee282a063f18ba8dc57:

 selinux: wrap AVC state (2018-03-20 16:58:17 -0400)

are available in the Git repository at:

 git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
   tags/selinux-pr-20180516

for you to fetch changes up to 4152dc91b5932e7fe49a5afed62a068b2f31d196:

 selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()
   (2018-05-14 15:20:59 -0400)

----------------------------------------------------------------
selinux/stable-4.17 PR 20180516

----------------------------------------------------------------
Alexey Kodanev (3):
     selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()
     selinux: fix address family in bind() and connect() to match address/port
     selinux: correctly handle sa_family cases in selinux_sctp_bind_connect()

security/selinux/hooks.c | 50 +++++++++++++++++++++++++++---------------------
1 file changed, 28 insertions(+), 22 deletions(-)

-- 
paul moore
www.paul-moore.com
