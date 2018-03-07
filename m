Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3808880-1520443378-5-15526959313634620692
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
    t=1520443378; b=TKnvbmCoEuQVaof/+bZ5jEYoxaWoBEOw/Usns1Ym7o1saKk
    3QsClIPqRBVB3ZF16yzCpa6TyV/sxwlY5ex/aW8DwVRtK/0+ag3ttxXZf4QN4RIk
    S3ojJlZZlTcjWxp2+QyNMOWDewQHB2lgizDoEcpECaqcHDRwsO+KR+OT315qTAU6
    krksitHQpJxAeGrTpYy0jNxgEn6EMy7WBrzXFOdQ/u0aQYw8mv/p+4jzMKMe3r/c
    1rAMQEQ4I9AycLbn1cckV3CRa4F7CE1t9cp+g5RgUDPHiccdLKsi9DIWUNs2GZA+
    BTjddzObwTro18PSHfpKTw5vWyUzIrdyxcWiuQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520443378; bh=gqzS9+kecO4RMVFSI4VYuRTTnWYPWynCqHJonhStuqE=; b=w
    u4l4Hi0ig+ZPAPDk9wY7Y7xR+WEgVJqYtjyTHTMYiZU6uOesemqW6DQWUCoXFGTq
    8aq/ekJAK5F1dQ9ZEFeziaGCMXByVE+XUSs+/E3Bq+RHruqhVb4PLRPnG9tmPSIk
    OZTQmM1pPi09bDmGgOuyprjHpEK12n7xycVMoLrcCa7FFX7S/LPuep+LDCNW575I
    v6LJ1HIFvKKG0hWpZwtVh/oIBsmu/IJoAOmOtpMHf4o0t47vsZI0T0/JexinhHaB
    FKixJUJn1u9nXVx32Quv7j+8ADCIj95dcgUe0uZJE8jRb5ZJgCabfzeLmOf5rGRc
    /7vfqeGrfhbnoFXQUNyWQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1754441AbeCGRW5 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 12:22:57 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754333AbeCGRW4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 7 Mar 2018 12:22:56 -0500
Date: Wed, 07 Mar 2018 12:22:53 -0500 (EST)
Message-Id: <20180307.122253.868991244559574396.davem@davemloft.net>
To: ast@kernel.org
Cc: daniel@iogearbox.net, torvalds@linux-foundation.org,
        gregkh@linuxfoundation.org, mcgrof@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306013457.1955486-1-ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexei Starovoitov <ast@kernel.org>
Date: Mon, 5 Mar 2018 17:34:57 -0800

> As the first step in development of bpfilter project [1] the
> request_module() code is extended to allow user mode helpers to be
> invoked.

Looks like there is a little bit of feedback requiring changes, please
take care of that and resubmit.

Thanks!
