Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-748302-1525471965-2-5500603163884033900
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: yes ("Address greg@kroah.com in From header is in addressbook");
 in-addressbook; shared/fdfaecbe-d8f0-4518-a17e-0d89bf6dc529 ("Greg")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525471965; b=B9i/aAPNBJIxW4LBGdQsKKHgplnDLgBeEr9mxbi/FkqvbPb+Ut
    2N+23dYrsd2U5O0JJo1v87n+QpphTxCc4xGq4yY6PL0xZuEP739ueWQ8NXZxAP3P
    n7iFzWrcRPDmcBE0mCgbMpM5lPOgAfd08hKEhC/Ys5es9wM8h7FobGB5nW+8iw67
    MgWsKLeXQUvZ4Tt3Y0dCEh5JTkVmIJ4rdO2nJ0munPsX1wi5mgJmJF7Th2AbMbaa
    EQLkBRpAQ0p0IIF2JIMkXu7NfCWNKKBxd0vhqqY2XS6jUi66I+720P4YipwwAcSS
    OgBRjbweF/pk1TT2XSlO8LXTj/fLEU5fIdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525471965; bh=mqdPNVt2WhzuaXHMxV0piqZO9Wz6e/
    Xdza4rnDmrCjk=; b=W9FHtloTvA7y16kTaZMkdoWsBSRPc8NDJ63ayy1tT18yAZ
    U1yDCsvEYfjI36fskzgOVQtVJB/fwHz5J/2TAeBNKF2NL2b/+tv5nxiYoIpyXNEs
    5cGx4L11V+pU3WX9SfTk4+xplhQOf2ZuC1gzlMqK554DfmOSvCA93DrOFhzDq0wi
    R0omMxJY151OfAZsMwgbQ9IbRASa91Tuk9mkzwm0/qhvBK7jvwr+0CAvN1/IszZD
    muUIPZN8g03wAAat1xGq4aX9qPbaGrCjF+VScJHYEVgfJPHxOMAj6gAqLS7R922z
    EdKd9ABmNvGZWvuSEfpcQmcsimFHBuyKFjWv3OjA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
    header.i=@messagingengine.com header.b=Q6Sgw8uj x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=messagingengine.com
      header.i=@messagingengine.com header.b=Q6Sgw8uj x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kroah.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kroah.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfL3WDlbvz0trWwyebAVLJRKAIoSy2FuEZLhDMGZfpCqW/AFN4M2PVgoLIchhT6RoQS59119EfZEpIAbE16Gd8GGT+TG37P6e30cs9bZyifsaG6nb0fmo
    Qdd3GszZqKVskCyerZ9aBX7yb+HXGBIe8axqvZsCIOt/IEJHjwCgZd/L5DSi4wskCRpqhe6j4hxtIt3IB/nX0LPwXgrGGuo9lpZU+cODmZXzES4ma3R0UBSm
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VHVRq5sOrH4fqFgflAMA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751651AbeEDWMn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 18:12:43 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:38541 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751630AbeEDWMn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 May 2018 18:12:43 -0400
X-ME-Sender: <xms:2trsWqhSjJb5mw_5UQ7PsfRO0g5zwHIBgemarc5j79bISswl_WYBtw>
Date: Fri, 4 May 2018 15:12:31 -0700
From: Greg KH <greg@kroah.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mtd@lists.infradead.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: v4.4-stable: GPMI nand controller broken
Message-ID: <20180504221231.GB20328@kroah.com>
References: <20180504065621.hclfdfxjxnobt4e7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180504065621.hclfdfxjxnobt4e7@pengutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 04, 2018 at 08:56:21AM +0200, Sascha Hauer wrote:
> The following went into v4.4.120:
> 
> 197190bc5c48 mtd: nand: gpmi: Fix failure when a erased page has a bitflip at BBM
> 
> This patch was backported to far for the stable tree. It only makes sense
> (and only works) together with:
> 
> bd2e778c9ee3 gpmi-nand: Handle ECC Errors in erased pages
> 
> which first appeared in v4.7.
> 
> So either we revert 197190bc5c48 on the v4.4 stable tree or we apply the
> attached patch which is a backport of bd2e778c9ee3 for v4.4.
> 
> I don't know which solution is prefered, personally I would prefer
> applying the attached patch which is also a bugfix. Without it erased
> pages may not be handled properly.

I've now applied this bugfix, thanks!

greg k-h
