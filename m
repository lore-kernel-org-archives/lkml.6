Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1163969-1520621849-2-7926977055245679918
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
    t=1520621848; b=YRwWmTqOQTipnvWE+iaFSz1opJQSSsBRq5zC8Om3MCsTyj/
    s/C3MwesD9Xy8MJom9WYYAQGOIFH/ZugpoWBp0A1v26GUyKd0eg0qzVahiDVW8bY
    jcRCnvxiwRcDt22D6sw8nnZmstywGmjigwy+W5dFCE7gEpLm3mxJCn+rtKU6g+9k
    XC3X3IqrXMagj/xuup5s9fgTJAYgwGRctmjUNvrweKyMzaESIpDh8V2fdwr/saDJ
    72rXMvcZVtoASS5iEjjvKbQrHC5GZfgskYfX5uStLXARiZwJ6Y0p7QQ7k/cne8O9
    QLZOJSpxOazQ71m+/NKc/5YxXZRxkJDoCH8JX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520621848; bh=k5WjyfcmcUVY/thJTgPPlJ+oc8j3M2rep2RMWfnZ3f0=; b=E
    aUtYtJBAlFSdY0r5b6dxU/CPOco36Tnc12sC+UwtvOZWYiAbBRv0Xi1sDfK4lT6M
    ol45PRtA5FNra4zB73aSqA2PmEBEect4HyExQHWemOvOQB/YWjESVM33CA4GlB+g
    QuckOibTJiOrLpyzHNV4lmANxajNDBAexKwvs7UxhpUmxzEwz9jfE6l8/kP46VQ/
    DOKF8XUjP6mM1wlPM7dsnXFQSKUuZ5+5kdwuqWTu1Ur2HiWmDmocT//6WAoMqh0f
    UVjHsb8rCi7cwmXiA/3UOCjQ2WdZ7kOfjzNjWJDyl/4W1zR1AtGRzCbTQqMZM//L
    cwNNXZ2EmJdgmcGUZCtzg==
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
        id S932267AbeCIS51 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 13:57:27 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55254 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932074AbeCIS50 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 13:57:26 -0500
Date: Fri, 09 Mar 2018 13:57:24 -0500 (EST)
Message-Id: <20180309.135724.452219538059491199.davem@davemloft.net>
To: torvalds@linux-foundation.org
Cc: luto@amacapital.net, ast@fb.com, keescook@chromium.org,
        ast@kernel.org, tixxdz@gmail.com, viro@zeniv.linux.org.uk,
        daniel@iogearbox.net, gregkh@linuxfoundation.org,
        mcgrof@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        linux-api@vger.kernel.org
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
From: David Miller <davem@davemloft.net>
In-Reply-To: <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
        <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
        <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
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
Date: Fri, 9 Mar 2018 10:53:45 -0800

> Anyway, see my other suggestion that makes this all irrelevant. Just
> wait synchronously (until the exit), and just use deny_write_access().

What exit?

Once the helper UMH is invoked, it runs asynchronously taking eBPF
translation requests.
