Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2263360-1519760713-2-8670649999942209353
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519760713; b=qZ2wcOwpoNLm///gyGAqMVc8LZPVNmkJ9BCpES42sI2sKft
    K+5Fr7QeM7JF4qKYrkwdZXYxjx/27hFuMcE9gEv9xAW7ZyTad+1NTceU3XHB+v9V
    Pn5Q63SdHD72orlxmIvcVFJxD8XJY/xzzJL29sqVXw7qLVHH4a+4PzxKZTDlYO31
    93V2e9mhUWMmQJ21KbB+VYB5jJyf4UhC22OQ1JcR0mPfTImlXoxmB4msJG9uPnb8
    XSfQSXWCejRsx2XDdif20CAjbeKdBzYyYBK/9se5swAnuE2KqMXhtFwDnMupwdfp
    vtr/tSo51TFIUUNcgoR93gG0YGHUPG3LjrIvLYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519760713; bh=c8HF2v9rSosoyAzklOlAf84qNjPi4XH7QXTxNM7JC8w=; b=r
    CMPI3ib9WZfWSeKIUZZjLAm2fQOpEFsV3RHzxXnQnlnLMxIeLRzDvcPZLWEPGNQ0
    V5pgbGo2zq8uT4aKJt6YyPtlj63d9MrJkEepZRTaRK4rpL6j7SFJQclL0NAkSCYy
    MdZ4GWAY9vDAxFwzrFsKJoIxawvogNxG2QEVJgukGCtyD4vE2olLFlQ6zH6GYSV+
    bS/101YoAZISvpoIWQelCHdwVN74Gd/pp0R29+JL8mKa31nsw97m5HPVNAMtynSV
    FOqWOlJcYEZD3Uf8mpn2DW+T9GKKHzzQdtjkBp606WbWrukssuUWTksf5GVoKkiA
    twpmfNlZgWOaT9JjB6mKQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751889AbeB0Toy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 14:44:54 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:33422 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeB0Tox (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 14:44:53 -0500
Date: Tue, 27 Feb 2018 14:44:52 -0500 (EST)
Message-Id: <20180227.144452.1181735676877365462.davem@davemloft.net>
To: bassem.boubaker@actia.fr
Cc: oliver@neukum.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as
 WWAN
From: David Miller <davem@davemloft.net>
In-Reply-To: <1519736684-29586-1-git-send-email-bassem.boubaker@actia.fr>
References: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
        <1519736684-29586-1-git-send-email-bassem.boubaker@actia.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Bassem Boubaker <bassem.boubaker@actia.fr>
Date: Tue, 27 Feb 2018 14:04:44 +0100

>     The Cinterion PL8 is an LTE modem with 2 possible WWAN interfaces.
> 
>     The modem is  controlled via AT commands through the exposed TTYs.
> 
>     AT^SWWAN write command can be used to activate or deactivate a WWAN
>     connection for a PDP context defined with AT+CGDCONT. UE supports
>     two WWAN adapter. Both WWAN adapters can be activated a the same time
> 
> Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>

Applied, thanks.
