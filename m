Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2575028-1523457200-2-14260692956445602424
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
    1523457200; b=QLZzoHOpiJbOCF5kAeHr4KyjTCQGTJgzj9pCuWHIB8KIflWqe7
    szoVGurcVGvM8bL6U1p7DB/8eAhdfpjJizeG6rLnx8Z0QNPq/6ghCkKXZ8cZH2O4
    W9ze1MBwC53X2HWAdAfFkVldA6cb5V+N46oaIc1q7I+aJRipQPYr7JuRSVESkFw8
    Q8r9/O67NMIgtkEjiC/SeXt6ckSHhGk1l5aI9v2qOEt17UYpel2jVlvEX3xe4zfi
    3RBZzZmlDWvZ2mKhgXAXfcGOnpc6QTE7DdKpccgCg0Lf4wfpsX/yXJz7/q7TS5J6
    jDmLSjNzUdskfK1lUCDRAUmYDHGnMsDOesNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523457200;
    bh=uxh6Op9WJFFT4UkImFonRzPUC95SeYfNzPCAHb7yivA=; b=qtOYBvWu+Xgs
    o88hU6N7Mm9a0SqbSBiwaZc2+uT6JCZt4JmtFEYo/rW4DLbn1ktnuYdbEhAl6FJT
    LHY7QGOJ3J4d/soQU2woTdDqTHD2CA0ozMkvDJYKKpaLV3rgtMZnjRMKxk1kMzEm
    bPbxhtVOcQZcZ9grvDjJvzSg4Cb4oKIBBlmSTvGoDq6P4+gIoZWk6epws6v2MND8
    k66jrohyGz9UM64r4DLi/rLtYh3ykzm/nRqUWQlUbQItjhL5JGLmtCdL9bQ1V0Uv
    I1/XRZ60NGmHylDLb1jQZWpuw/S/VC19Q8UMbl95wqQ1skHyWubbnu2ixS+9g19/
    SJ77L0GdDw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
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
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK0YDUGzes1y5NBGX/PChoLDxB9uRhlH5CDSCtCeTaEf3qymYlChlSBMakT28o2RcjSLDZpOHGRjGWbz/tublpEPCpvdYemV+mmEStHxAX7+Sx5OzwOl
    dMeR7IA2952cQmyKftVSyexeM53bgpQeh/EmvI7HAO4OU0HpIMYgUPKES5bfZhXLGYsYan9DMC0WOenRnwyFZ+rHLla7tFzbAk4P5gGm2GsAtdy2wZ9ggFM4
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=VwQbUJbxAAAA:8 a=y0cBCHM656rsqBG7-p8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752981AbeDKOdE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 10:33:04 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41240 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751797AbeDKOdD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 11 Apr 2018 10:33:03 -0400
Date: Wed, 11 Apr 2018 10:33:01 -0400 (EDT)
Message-Id: <20180411.103301.1978874246933299635.davem@davemloft.net>
To: phil@raspberrypi.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lan78xx: Avoid spurious kevent 4 "error"
From: David Miller <davem@davemloft.net>
In-Reply-To: <1523444567-128200-1-git-send-email-phil@raspberrypi.org>
References: <1523444567-128200-1-git-send-email-phil@raspberrypi.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Elwell <phil@raspberrypi.org>
Date: Wed, 11 Apr 2018 12:02:47 +0100

> lan78xx_defer_event generates an error message whenever the work item
> is already scheduled. lan78xx_open defers three events -
> EVENT_STAT_UPDATE, EVENT_DEV_OPEN and EVENT_LINK_RESET. Being aware
> of the likelihood (or certainty) of an error message, the DEV_OPEN
> event is added to the set of pending events directly, relying on
> the subsequent deferral of the EVENT_LINK_RESET call to schedule the
> work.  Take the same precaution with EVENT_STAT_UPDATE to avoid a
> totally unnecessary error message.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

Applied, thank you.
