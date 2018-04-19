Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3664253-1524159652-2-12145749133827634827
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
    1524159652; b=sNBiBHmLGfWh+5vnWCDZAuqzI4jU+Jzl3kvM+zyCODcS749CVJ
    9tPCh4L8HoTXRfTCnjRQZ7peEfGbxLvc0ZlNX70RJ9bhZyLM7eovOd1LqQ5MAAHL
    Bm2JtwCqHCLKk8L2i1GUVZX4y97VTxsr8f/zpCSMg0+qNtJLIxC+6TY/nvQZfb0b
    7KzRpWC/ia2Xbgos5iw/02xNfbBWC0ho1y0tWe4ODq88yjxney2Cpki6H9GWdRMP
    OP91F/X53gYTsxFGdaTamMwqyn95UmEjPusz5hq3vPnitWDuHJtUqltZJc4CY3GA
    YttljFHOh5NAG29MsLe9PVuz72AHgryi+SIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524159652;
    bh=uMoGw6n9dp0UayjQnaJa9S5d8Y0v5XazB9eUpBVvR9M=; b=vgQC0ZsGTXOL
    vomu6C4sQOD8N4z9dc3un4XCZNvdo9Sb2QuXjhe7hMbnK70kC/XTq0zHzRFINSDm
    TlbSbQqsjdDurwo2ZohaODQkBKj5XUS4R/8B9Tt1Q6OYxU99OozefLiuL6cb0kIk
    SE/LlGxKMxAVSU5y6RE809qEoovAMm1YoCGVSdngWyDa3R8rezZIT7BRMJ5P949n
    vB0yOKsrp7VjEPAAfV8fYl4IRikc/hdhLfmauXTrTiu/0fWGul+85OqANC+Pij7u
    24edPdY/244m4gQ2LZ6P3hHI1paP81liY8mPb1rvjsH+GuVAuvaevQ83c+a1LPh0
    p8ITOZ8NqQ==
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
X-CM-Envelope: MS4wfCvtYUtNz+DNAfY9g6CIZK2ZJJ7DVPoEYc5WQ+jVP28xdMwUaozhEAF/Lbfc9ZVGO96jQ9Ngt5t+5h3o6AlEhmt6fQ+UhOMtVsHFHlnFSYLYkPfvinMB
    bJYkvGvkQF+b1TD984nl1lC3fltm/2w/aOH48dEFh9PlsYdkVQPiD+GRHFj5MXxQA0BY+mug6MKmdWkQyh/jQ/HGS65lyRQmcuj+ofDCi4MhRogf8SnMHCKW
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=mY6ybJ_1bN7vPflYsgIA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbeDSRih (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 13:38:37 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752887AbeDSRig (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 13:38:36 -0400
Date: Thu, 19 Apr 2018 13:38:34 -0400 (EDT)
Message-Id: <20180419.133834.872161634453489004.davem@davemloft.net>
To: paweldembicki@gmail.com
Cc: bjorn@mork.no, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qmi_wwan: add Wistron Neweb D19Q1
From: David Miller <davem@davemloft.net>
In-Reply-To: <1524060204-7814-1-git-send-email-paweldembicki@gmail.com>
References: <1524060204-7814-1-git-send-email-paweldembicki@gmail.com>
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
Date: Wed, 18 Apr 2018 16:03:24 +0200

> This modem is embedded on dlink dwr-960 router.
> The oem configuration states:
 ...
> Tested on openwrt distribution
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

Applied and queued up for -stable.
