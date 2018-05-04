Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-140621-1525441365-4-9797157031102459247
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525441365; b=EPxDMdXyrdju3VVAxTgBHwJ6+KEWUVH7geUunkilT/ZYzvmh2S
    FtmChtu882ap4/QUSswH/8i1q8m9Q012NokD+zYgIxt97+G1oWFnY0zqe9JYJuE0
    i6SPqHpI/pPKWTdjkbWf0n+PnNtnX4hcfi7g75N4EPbbeoTcJ8Qnhur9JnjwW7wx
    MaFrsiiisyJk1J6vkT4oZn246Y9Hzaq19Mv36YqI1kPUrerBXmgmN2hW7fDVdLzm
    CKMmTQLZxij1SBO8wEIzHGGQM1rBxTu3Yd1C4ntXiwoeWtXqkCAFwAW6U2TaqmIC
    csYuaohj1Kf+ubWk17EXHKZlhRoWJT4l6Cqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525441365; bh=42JYO5C4/drRHHfPVXnbyo4o6yDs1k
    OGIhpOmtR8euI=; b=HkZRn9EoZeo4YGTnIvytn/y9fIC8dEF3dCnoicrGRFj2cQ
    VFmsu+l0ELFpwX2spV2wBEF6+sq0VF0paWGU05dvR5rt3UJC8P7q245rinbnOBIk
    4lSOOHsPWTDD85c3HRKBhsNV700I6UbECA11e9ic1PBTgxXME+bWkhEbBr7Z3UxH
    w40ps5PqWoWv8ed5NhZWGL6cEP1GGfArXIcmer3G0ZrM18d1eKk6YwQAwIBGYjBA
    +eQDkhF+VQ5eFu7iYISy1M6pR9R+pKipGdvChVzV31uUR6rcFg3ZJyUwOJKNZHD1
    BoPgjrxwpGEs7cwJmtya+Cum1CtmzEnKEECoKF+w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=tycho-ws.20150623.gappssmtp.com
    header.i=@tycho-ws.20150623.gappssmtp.com header.b=ZmzpbNyZ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=MpTFU3A3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=tycho-ws.20150623.gappssmtp.com
      header.i=@tycho-ws.20150623.gappssmtp.com header.b=ZmzpbNyZ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=MpTFU3A3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDFHDqLCTR6mJTpyxMdc1GbFc8k3OIC2gnxuUbAoKJzAEqNFH40BO+Px9LfQ4YWhPrxMchQA8mIaeTktaC/ahKEm8ZgcLzGokFL8F2AZAwHsioLYrZRS
    Ah8R8U2m+T7+Gl46tCGQjGiESKa7MI0eBAHavz9iIURdHpWoRf9/1waWv1KO018X29D64NQ3RraKFRgJKdiQX7mbhWhQXzqVzShCiyYYQ8E/iWkZLAP7r8QM
    R7rZD5PBDL70Mu+1v7tHmA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=MKtGQD3n3ToA:10
    a=VUJBJC2UJ8kA:10 a=MQS611LM3gAA:10 a=ZZnuYtJkoWoA:10 a=VwQbUJbxAAAA:8
    a=6nUXITN49fC6jhMlmTEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDNmm (ORCPT <rfc822;linux@kroah.com>);
        Fri, 4 May 2018 09:42:42 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35899 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751172AbeEDNml (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 4 May 2018 09:42:41 -0400
X-Google-Smtp-Source: AB8JxZpW7TbK/Gy1n5eT2zcydiVS+e8Oc6AbdHzLYFJpDKAUF/YAasNpMm2L3UDEB+3bIrOVTM1bpw==
Date: Fri, 4 May 2018 07:42:38 -0600
From: Tycho Andersen <tycho@tycho.ws>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH v3 1/3] big key: get rid of stack array allocation
Message-ID: <20180504134238.GA26578@cisco>
References: <20180424202639.19830-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424202639.19830-1-tycho@tycho.ws>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Any thoughts on this series?

Thanks,

Tycho
