Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-501008-1524849898-2-12030637215865344704
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524849897; b=W9fdp8d6k1vbQ1OMyC/eQhvby8ZgqL9dD4YreT0qAduGK3JHe7
    6Hsftzr4Tqfc6R/huGB361uo2kd/EwtByJa+CU1tXMkfKgh4tyt3hWyFlz8Lh9D1
    0gDAciLFG3geJ+DrDCwrq1MHcijefmqGqM9qA+1U0bEhGx5qRd9zb61kZoYUzb/H
    TV1wcpyTCA7kKxBdrv5brfUjecLJX5yLdV7UaHhKyShT/qyer8DPRgsK7aaLbubt
    fNAfBQXPdQMRHa0yWYt+QVMlbejf0xeEvTjqpJmHYC8lP0N/uJj2JhosUJDHY5dm
    b9nZhp3pqzFQYkTmOC9XVXfdc4YbQ+4B+Qfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524849897;
    bh=YLR19P06CO56R4SBCHmREB8UtdccDuor5ZWo+zpQQ6g=; b=MhhRCN99isN1
    ZqaSMfgCEsBS5xhuLiR3AsEGn7OActipmV1wzunegEFaE4/Ic42Yn9yUZdLDOTjD
    sYhfbeTFIIZUmNpbc5qFB/JQrviPYgW5bJ0vDggF7Pq9OeO+kBCFhscslC+pObet
    5/W9NfdHX65lNYfqChJWQ/JnfpXCU5mfB1cs8FK2LH40cSUgMscmiarfMrvzM7dB
    v/mJCQ8hgxQL6f4ERLY8MIO4cyJvgq7rgXwAqeK1uNc6NUyJmeWg4jsVsYZwd7dB
    pvxPL8UuEEbf+Oz3FtiXgc68qevvSofNtZvho1zEQciW34BGGA+AmBZYNddbEL1y
    4TEmFvvNHw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFz8C6ST7PRF7+xlxw5QjRpT8S2JwjDXQV0NKY0Xd4nxZEo13PZHf+aih0FSj+hcWjWEOMXuC9AMUAcrShkM/wk6v9cyXRkot+OD8BRvogvF10VPnE5q
    Wse5c5xMX0RiztyFTv27esWGhvvwlTrXZSWsa+UEDnZbrsUlX1HI38KrRkJCiI7WLY+mxKM4EbqTaCXChdJeJbmDynG+yZEt5z6h1G77XeR8cqOnu7dlRNaz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=ZPSk82zQDygA:10 a=Kd1tUaAdevIA:10
    a=dZ7Af3Q_AAAA:8 a=VwQbUJbxAAAA:8 a=a0FVfuwijLIR0kPl4fEA:9 a=UAVRJdkkkM0A:10
    a=xnyMoErWsJe9py2mg6Iw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758606AbeD0RYz (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 13:24:55 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55204 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758271AbeD0RYy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 27 Apr 2018 13:24:54 -0400
Date: Fri, 27 Apr 2018 13:24:52 -0400 (EDT)
Message-Id: <20180427.132452.583189737343918915.davem@davemloft.net>
To: sz.lin@moxa.com
Cc: stable@vger.kernel.org, bjorn@mork.no, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NET: usb: qmi_wwan: add support for ublox R410M PID
 0x90b2
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180426063013.453-1-sz.lin@moxa.com>
References: <20180426063013.453-1-sz.lin@moxa.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: SZ Lin (林上智) <sz.lin@moxa.com>
Date: Thu, 26 Apr 2018 14:30:13 +0800

> This patch adds support for PID 0x90b2 of ublox R410M.
> 
> qmicli -d /dev/cdc-wdm0 --dms-get-manufacturer
> [/dev/cdc-wdm0] Device manufacturer retrieved:
>         Manufacturer: 'u-blox'
> 
> qmicli -d /dev/cdc-wdm0 --dms-get-model
> [/dev/cdc-wdm0] Device model retrieved:
>         Model: 'SARA-R410M-02B'
> 
> Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
> Cc: stable <stable@vger.kernel.org>

Applied.
