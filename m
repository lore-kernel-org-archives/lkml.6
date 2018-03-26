Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1424330-1522082175-2-16425913408592095294
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
    t=1522082175; b=cvg41vxQENf+xb4fQwiKTfswIjD1T7K4q8ja1ml7H06fKXd
    eVe+ZtS1f/Xlg+sD5Qq27PvzaMDiJ8nhc1uRYBJLrAfUgvCGQZEdjDIvrWZhUVLv
    cg9i0DniK6+RpmohVlvGOHhk14Gmip2oGJi1ERl8s2dLliclHdQrX1S/jgn+cxb2
    LSlrURPitD3O7Jkpy6ygNfvREq/h4wMVU+Ybdj9RYUn80Nd8UR9wjLzh9D7oNqdS
    5MKt/riJnFDFKgWZOIfNbB7eyspUTziIGQfsUErUxiPinS3OJodbLtZSNZv6Wgzp
    X3gKvz07/3dtimQfcVv12nHblpcyw8MdzoYcEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1522082175; bh=eFP/m4pO4zvlydeQKQDjLoSrGUuXwaUXoQCJQWykQXM=; b=B
    5eyLyYZ5vWGLnBzGxjTmzxeaW68ne3Q20YNOw5qHka8SuuRsgiJoCR035D4eATQT
    5II2k1BwdLB9QYH7SMtKw8Zfoya5LBjSIHeepuSt0TS5dxmjd69QmSIg9+/gKxw6
    tn7142s8IBLJJL5yOPnSOwxtqlFf2/x5PIUd81LuWMW+4eTKsFOIQzPTMJh3SEhs
    OX3H/bb2TUAWufk2qAPPFb9f0Cfdh/bXTSFzggkvrU5mIQzu0f3iCWPusKsUx+R0
    XXeDLMxUrQCF5A9JEKlAJToo7h2PP0r7FZL1Z4tL7692uEYedlrjEishIlIIpqwV
    zKOmORTxbk+8uPwovm1mg==
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
X-CM-Envelope: MS4wfJ/dmvLaLfkaEW/XnLUiExg5CFoxXrU7gNqFVjlqL/Tza1Be7zKo9Kqa7F0oQQKCUYGKL8stPoX2p/pcDxAGAlFAd1ORV7bzveO5R4ayZ7kotsbsk8a8
    X1ZQU1aat02hcTUCh4r0F7h4MDwCc7iS+6toG2K3QlIDaAIZsjC3NClQtZ9KoN5x4YFMnbfHA9DKn7xmkPR1UdzJs1lrOzOQZSlr9yaCdWdnjuFZytpSnsW9
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=o_fhE8N-VaUA:10
    a=v2DPQv5-lfwA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=pKzKe6g4VulozWyHghMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeCZQf4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 12:35:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52998 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751099AbeCZQf4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 26 Mar 2018 12:35:56 -0400
Date: Mon, 26 Mar 2018 12:35:54 -0400 (EDT)
Message-Id: <20180326.123554.114587967412246898.davem@davemloft.net>
To: paweldembicki@gmail.com
Cc: linux-usb@vger.kernel.org, bjorn@mork.no, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qmi_wwan: add BroadMobi BM806U 2020:2033
From: David Miller <davem@davemloft.net>
In-Reply-To: <1521925694-15433-1-git-send-email-paweldembicki@gmail.com>
References: <1521925694-15433-1-git-send-email-paweldembicki@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pawel Dembicki <paweldembicki@gmail.com>
Date: Sat, 24 Mar 2018 22:08:14 +0100

> BroadMobi BM806U is an Qualcomm MDM9225 based 3G/4G modem.
> Tested hardware BM806U is mounted on D-Link DWR-921-C3 router.
> The USB id is added to qmi_wwan.c to allow QMI communication with
> the BM806U.
> 
> Tested on 4.14 kernel and OpenWRT.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Applied.
