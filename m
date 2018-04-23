Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-826942-1524472782-2-42337123967770457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524472779; b=lfzjLDqQuTh9oys+y0LroejsNUDis1bw542q+I/3EHiVIHjr27
    NZ/7d5dzT3RNeus7lVj1XNR7/uB/uw3BN9bYLs1CschjdkkhBHMfd37eANHYM3/1
    eFfx2W1l+LpflG6Ig6nPZztCC8iM4of+vP4sn8arjl0DTeitxIP2THepU9zIMOXq
    kk5FKWCb8g+kjJa4KvPzhab5+2XDfl08+ch2ahYyK5/EsLCmWO0zztosT77QPOyM
    Irax3YKdIna7Bq6FtE4w5g0yffFqCUEJ4iuXk0j9V+87sU+zinq0M6Nv0uRMu7n9
    G5OkNpID9kzjD21sYHwRO2ZlP5/f/DISXosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1524472779; bh=D4I0F13bhy
    QftQFurfXqdYjbHcNRWKqbVo6GDC4kkhw=; b=sweGE3ddJxTWGyuyfsyW1twlEO
    KtisAYSqLHUP9DIl53zXIqks07P3WJUJ8Lo/d7y5oMZ2j2qi3H7TFNiyTlrke3yg
    hXBEiYPx8O/miINbQtWl13kcJ7mJKjiOrG56HDKiTnW8CzjRTkIBW6z5o/LvoJ5y
    5bOWnjclOQ56sZ8CHSEIK2HBePrUwVZfcAqPh/qfEaZom5HZznSQ71PyoI2DSVmJ
    YpjT7V+3CNwVzxO3nF3+L9Xv7s0I/sTDxdU2B+czJ6Yity11SkkT8k1eOB+b9d68
    FsNhu2BA467ShgDHdm/okUkfj31oKcQyqeePE7vhdt3jYkOH3Zpap/d/P6AA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lichtvoll.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lichtvoll.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwGePWTM1T+qRSDbeDnTsPq91kuMlJLXaO4/KttudBd16YKLqsi6irLfhAD9NRGD/oVj08TDHx+p2XirzVKxHHrnCzN1JVDPxIxjIem1JS5ggvmfnqY
    FvxBNU34rPgvgBKDIM4d0AbLkZdtsaSLSC4oxlT2fLORHqX5l1nn4BkAMYfMvrO/7FlwPm8/8ygLdtnKvqjLZZATPgH4GIpL9x6ajuMHza//sq+GtmMTrmkY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=35TgCRFZ9th_9eKezrUA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754222AbeDWIjg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 04:39:36 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:48673 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbeDWIjf (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 04:39:35 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: axboe@kernel.dk, bart.vanassche@wdc.com, tj@kernel.org,
        ming.lei@redhat.com, stable@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] blk-mq: start request gstate with gen 1
Date: Mon, 23 Apr 2018 10:39:27 +0200
Message-ID: <2502316.XbMSM6V44W@merkaba>
In-Reply-To: <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
References: <1523936780-1589-1-git-send-email-jianchao.w.wang@oracle.com> <2612135.Ur0PZolWSD@merkaba> <3737bdcd-f04b-4510-2673-baa6dcdcb557@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jianchao.

jianchao.wang - 17.04.18, 16:34:
> On 04/17/2018 08:10 PM, Martin Steigerwald wrote:
> > For testing it I add it to 4.16.2 with the patches I have already?
> 
> You could try to only apply this patch to have a test. :)

I tested 4.16.3 with just your patch (+ the unrelated btrfs trimming fix 
I carry for a long time already) and it did at least 15 boots 
successfully (without hanging). So far also no "error loading smart data 
mail", but it takes a few days with suspend/hibernation + resume cycles 
in order to know for sure.

Thanks,
-- 
Martin
