Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1425257-1522630635-2-17421931091262123436
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522630635; b=Ni5KGYJQP+qXVGIXPdDtXZrWfwhhThscMr3pxeWBWB3M83czgr
    ByDIdPVhE4WORsgDm1/wGZojZDxwSInVQIKNZOoSSSzlXFFO0DeBMBCB+laBhi2t
    FFeSZ+pbLeTSUoCnwjKSFG7V+w79dpe+ti7XupMHRTPyzi53DDtssVjJ26T4NJCf
    c8ApBqXdVYuW4CM9yZEgOQZPo/AihrK09QYm4sr6wrmj9O2ytODebgbe2MlMlqDO
    A2a35aUliDZtBlel8xACbMQ+p43BANn4t3I5nquLTd+OSHQWK8Ke8xKPxyLWV8s0
    /INzhpOgLekCQpg73ToI5G0Ri4bF2fd4XvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522630635;
    bh=H7eHpF0sFo7B+ZFgn2PxhSnf2sTMNmX2u96rencztaE=; b=ayYPLDyZFuYU
    iVkUjBxA4QRUoJSHxQRFjf1Dgd/jOhaMKEN/bP404ka4CFCLHxogo1OvZpz4Vw0q
    Cz02GII8DGPlzRMbqoTGI6mx8yU18Wf2oSLB6L+9SmyPGqYA48Xw3etOmBv/zl6W
    mE6vc759C0/FqyskOpH1zwQYhxv9tCczZgcHlHxxlPL/+oBe9NzMPcM2njtNx+3m
    DP9B+xKetnZglo9tlu1sZVchzyS1YGbRAofY+S8wcc3XYbOFnr6omgo5HK+OI9RR
    LiAWk+/LVperdFIeN1bN+H1z2hwVUeiFyolvl9x4SorGNmU6+1h1iYKTjo7B3ZtZ
    xQUa/znz8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfJeBK8Bqv+0SIAJL0TEQYo9O+3hQ7DRSgTpzY0HgQ3DMjARMe3ClNIBEttW95U514Vq4lb172ba/hAouOEGAbzSjcUFJzvKHQy7EZCc7YMwdcjqMh0ai
    /AMLhOWPQhZLUgDUwt4TgK8xZUibknSzOKqkDEkieGz+4Or+alImD2e/ctpvpm4l2af8Byav5oLBkq4M8xYZ8Fw3BJAfH9e4znkAZR1QFcvRJiXcfU23w18t
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=danhDmx_AAAA:8 a=VwQbUJbxAAAA:8 a=nUkDqtIDf6Ckfu9B8BgA:9
    a=CjuIK1q_8ugA:10 a=rjTVMONInIDnV1a_A2c_:22 a=P4VdviVPEcjfz_PVVggX:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754085AbeDBA44 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 20:56:56 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59582 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753992AbeDBA4z (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 1 Apr 2018 20:56:55 -0400
Date: Sun, 01 Apr 2018 20:56:54 -0400 (EDT)
Message-Id: <20180401.205654.1143264068550854044.davem@davemloft.net>
To: kai.heng.feng@canonical.com
Cc: mlindner@marvell.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] sky2: Increase D3 delay to sky2 stops working after
 suspend
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180331154203.5562-1-kai.heng.feng@canonical.com>
References: <20180331154203.5562-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Sat, 31 Mar 2018 23:42:03 +0800

> The sky2 ethernet stops working after system resume from suspend:
> [ 582.852065] sky2 0000:04:00.0: Refused to change power state, currently in D3
> 
> The current 150ms delay is not enough, change it to 200ms can solve the
> issue.
> 
> BugLink: https://bugs.launchpad.net/bugs/1758507
> Cc: Stable <stable@vger.kernel.org>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
