Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2635071-1523457480-2-14456604606699214675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523457480; b=wItVuoAotYk2JGocWeRNCs4QtEVQ4oZEFg6i/XDYsBOOHpl3S2
    CGZQKxgSWQ/LEMPExOY5Fu093W/vTOWSyTyvJ/fQPMg7w0Mu7WHHGENBKyT7e83d
    YgO1XBlXtSRBUgOhf6895L3jqbK6B20AFRHqwIIHuLeSpZgYTumbXE+NK7ikChzU
    sH/+73n7URRimu+geZ08h5+QTNV8uQkgtRNKJGGKPUinDd/aDg9B32XyNhFqTYNc
    TcW/AEeG28uCDufTFsIcGxQIgRQanTYwW8kmUQvYNwavud2z1hway4xwTFVkb17E
    dUBmEIhB+rT3P/yFjS+oBC58KcwDXzP0PFag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523457480;
    bh=KrYmklOnI4RJVDx6y0QVgSdHsUu8vSHVUaiRLsektQo=; b=ULutpb/u67on
    wAD0tVvJ7WQuD86SJFGkSjgWEie9PoyR9X+2O6bA0j9F7cPv3xRFi+9YFOX+35/7
    mNSxeZzWPHWGgl1fRJXLf/WJMM6AnsNRWps3e6F6QpC+JydRgVL0TgSlaEOf+w4+
    HALtTe/iO87bovXBU0FEcZSJyvYw7xPrHvK7s7dVNDmVypEnQRFvQCwkecJ3VLsN
    ZkW3V2ID39OTei0+bzW73W9KzXIVozyZ2O/h/SQ6ph3i39ixKi7sLbYBWB84jksJ
    1PLBDp0WgsavEjFSlZesb1BxH80gEWgvx3cr6NBJVP13nb9Ygn1XN7f2bS1C4zWk
    DZLiK0w9rA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfMK0GHswDhW7R388Ihvy46CKySHf2rVJkWegbM6vWdK8cU95/ZHZIb2mvHkQmOoLcThEIE91+C9bkeq8AWHdQzgh11VevxfYD6YsQmv3WwYcKA409v9n
    NoT8qFD81ybqppauWS5kp3F2ZK4fPGqKHBM34HKLTqsz0b3ro/anE9QZEvl75Ox+eTEjimqcTIXlfIvnFenq7rVQx3LlgHuumJJayeztAxdsZtTvGidznwPs
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=t1lQT1hK1NyX8ZWG198A:9 a=wPNLvfGTeEIA:10
    a=x8gzFH9gYPwA:10 a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752879AbeDKOhH convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 11 Apr 2018 10:37:07 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41312 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752335AbeDKOhG (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 10:37:06 -0400
Date: Wed, 11 Apr 2018 10:37:04 -0400 (EDT)
Message-Id: <20180411.103704.1631418753044192382.davem@davemloft.net>
To: oneukum@suse.com
Cc: bassem.boubaker@actia.fr, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] cdc_ether: flag the Cinterion AHS8 modem by gemalto as
 WWAN
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523445938.22084.3.camel@suse.com>
References: <1523445353-7631-1-git-send-email-bassem.boubaker@actia.fr>
        <1523445938.22084.3.camel@suse.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Oliver Neukum <oneukum@suse.com>
Date: Wed, 11 Apr 2018 13:25:38 +0200

> Am Mittwoch, den 11.04.2018, 13:15 +0200 schrieb Bassem Boubaker:
>>     The Cinterion AHS8 is a 3G device with one embedded WWAN interface
>>     using cdc_ether as a driver.
>> 
>>     The modem is  controlled via AT commands through the exposed TTYs.
>> 
>>     AT+CGDCONT write command can be used to activate or deactivate a WWAN
>>     connection for a PDP context defined with the same command. UE supports
>>     one WWAN adapter.
>> 
>> Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
> Acked-by: Oliver Neukum <oneukum@suse.com>

Applied and queued up for -stable.
