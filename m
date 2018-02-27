Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1537459-1519737456-2-2048031043430220189
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, BODY_URI_ONLY 0.999, HEADER_FROM_DIFFERENT_DOMAINS 0.249,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519737456; b=oe+X0xGiOfyuD47zwBz2d8VRsxHqyR/lwwVk33CaeEv8jKR
    ubWvr00inzTQ4x9o9aTwe62giMGRv51DL99ybbePcbphP7x70ltoNJCSkiFEtMye
    jmEaI64GKS8wIBiZoRH1vSi0UEETMsN1bSLqHpl62QOjG947c10FUxb5D6pYRTpl
    XWtRzvcsAyND5eyxRv1UmzSttvVmgQjjGXYGwWsawy3JpffOp9fQt2xIp6sI2LiV
    54oNUr+xms/3PvWWLW/nSB7Ib2mvfyE0A/lqEe4/06CWHS4r4POtIQue4hk3IAsX
    twDoAPT5wNakPMsvj9z/Bvac7ijhwVDCc44QpXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519737456; bh=DyfuB8kN78mdQyHUYqZbDIAixu7wlnOY3WYq//80VII=; b=c
    zQ8aEOq1/bajy6GyATMPt8C01MbMGggjF4BXlffElmctkdeWPKbssRqZXacTgSaR
    rBlvqtRq7y6Lgexu2US81AFETexaktKZdZRgjY0i8v0xI0kqN3r8dgvuaKFsGumA
    JgImeGIBFJREw+i8FnK0mwz/870aTdE82JQ3lOWE0exFmXEdywUYphGLhKpDExCz
    W3AfGMSGrvNNQgrFE8aondR6S6jrONWpLyk4eZcsSwweHOMqo+LmU5B6mi2BH3+d
    0JUQXaMcT5QG5eBWnChcU6ykzLK6hXMXp0mhIiUmbCsfKRjXbCtCn4p+VJE9hU01
    KTasa6Wh2gaFZh4D+/SPA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753210AbeB0NRR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 08:17:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:54336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752888AbeB0NRQ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 27 Feb 2018 08:17:16 -0500
Message-ID: <1519737095.2649.0.camel@suse.com>
Subject: Re: [PATCH] cdc_ether: flag the Cinterion PLS8 modem by gemalto as
 WWAN
From: Oliver Neukum <oneukum@suse.com>
To: Bassem Boubaker <bassem.boubaker@actia.fr>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org
Date: Tue, 27 Feb 2018 14:11:35 +0100
In-Reply-To: <1519736684-29586-1-git-send-email-bassem.boubaker@actia.fr>
References: <1519732192-29332-1-git-send-email-bassem.boubaker@actia.fr>
         <1519736684-29586-1-git-send-email-bassem.boubaker@actia.fr>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, den 27.02.2018, 14:04 +0100 schrieb Bassem Boubaker:
>     The Cinterion PL8 is an LTE modem with 2 possible WWAN interfaces.
> 
>     The modem is  controlled via AT commands through the exposed TTYs.
> 
>     AT^SWWAN write command can be used to activate or deactivate a WWAN
>     connection for a PDP context defined with AT+CGDCONT. UE supports
>     two WWAN adapter. Both WWAN adapters can be activated a the same time
> 
> Signed-off-by: Bassem Boubaker <bassem.boubaker@actia.fr>
Acked-by: Oliver Neukum <oneukum@suse.com>
