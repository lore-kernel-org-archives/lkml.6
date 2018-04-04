Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522856556-2-14600433356044193621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856555; b=Rl/kQbK+d7emjFJpuG2KNKRQF/pFUvjkVoa/xPPWew0tWGlUlD
    zL9RKMIWYtxFhWhmxHCCQF4b5+XkG8nJBT/hxdCFpcrNA6i94xMCewws66/ZSzN5
    5LqyI7R6S5aBA0wGIL0FnjO2TivITTu1nxl+GGMMMqbF+DUgGP+57Dza02dLqlNr
    3bRqVLyykmIWM7Ri0zkpV14Vd/W9pRWmhIjoqUisZ0re8GDdmam9qZ0ZE+BB9ulV
    3Oqx26DchLJgIbnVl0akKiQTxYc3CaFSi0Cas8C5kfWxGte+GOalcCN5b9BWCex6
    YfyhPATvIcwFv8hTT/vqBXYD77k8E4X++G3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522856555;
    bh=/2JY51psHwgz+zx1FVr3SPYczgHQH9aZqF6P2xndMJc=; b=T8iWiXGQtW0M
    bIFcTUFUmkQy0l4wbEF4s6a1Zth+AvkmFfc82roSSsRRlinxnHPHO+s5Lt5zbyMc
    w6Ur7jntN52ApftMXh6E+pgFDYqCcIfzBos958oEAJVuSU9ek4Aj6HJ25daezHlY
    ZbxarbtawyTpubbTav901+4VsE2jUYOr81eu2uBGzC5E0DBFOFZHRcT7cgN8qbfU
    0TvsVVEFSS4Ekt1kLtiSeKBNdCUIBD4GTZdFDlD2TeDsw0MlUoKajhJIEcnxrayu
    3hbvYvD21q13OZJ5R4Kls8bOnHEbCe5vFa302DVwNVXNhGUxIRqlG73zIUysNu24
    vJDpqDCJqA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAq5purHWEHW5gga5ST+WR67oWu2PhYsN/o8/1hrFuNjUogGbcqB/vb+zLqeVUlfe6nQriCXiNvMxHrg/vTbatbzKS5Bv7o7mCdSI7x8hnyZa/Z4b9Hd
    Iua/yzpQBXM2RW8E8eJH7qsj9OJ2OPQfaHuadOINyfReDCHephWUYzJCwivTXHQo8Ta0KkDe78vicX/WtPbbgttkrUyOL7wiMcOHEjbpQwLWwMQCQ4IpIyak
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=GSUNSa8qvEzEB3GOCJ8A:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751906AbeDDPmA (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:42:00 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40442 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751780AbeDDPl7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 11:41:59 -0400
Date: Wed, 04 Apr 2018 11:41:56 -0400 (EDT)
Message-Id: <20180404.114156.2277005234997416804.davem@davemloft.net>
To: agraf@suse.de
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nisar.Sayed@microchip.com,
        Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com,
        tbogendoerfer@suse.de, phil@raspberrypi.org, andrew@lunn.ch,
        RaghuramChary.Jallipalli@microchip.com
Subject: Re: [PATCH v2] lan78xx: Connect phy early
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180403221935.51099-1-agraf@suse.de>
References: <20180403221935.51099-1-agraf@suse.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alexander Graf <agraf@suse.de>
Date: Wed,  4 Apr 2018 00:19:35 +0200

> When using wicked with a lan78xx device attached to the system, we
> end up with ethtool commands issued on the device before an ifup
> got issued. That lead to the following crash:
> 
 ...
> The culprit is quite simple: The driver tries to access the phy left and right,
> but only actually has a working reference to it when the device is up.
> 
> The fix thus is quite simple too: Get a reference to the phy on probe already
> and keep it even when the device is going down.
> 
> With this patch applied, I can successfully run wicked on my system and bring
> the interface up and down as many times as I want, without getting NULL pointer
> dereferences in between.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>

Applied, thank you.
