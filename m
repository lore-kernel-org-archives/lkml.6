Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3458301-1521088871-2-11086269210647909276
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521088871; b=SDbvvu0OqcE92C07doGVgWB4IHj/fyU+qg61Ru4axuENIs1
    9NFqyTqn43gUDY6wYQZtusOwx/RpbQ66RaniokcqOxeDlSyEgr6o3/JdBqQfMfrt
    QiQUmh71W2wXEAYUFmftV9jxvqPQwV6vYBJIJI9PrzvAknQKkfZYgnjnvVJaqPkW
    ElOMxtoYXmBmsSIkbXXRQ0JtP4BDag/9+OligWW1+itJ7tDeqnksiXlcgI84yZLn
    yahUzv3wgqr14tMwW1fpqVtPdqIgnv8psOqCiQ4AHGV4TlQTFwjPSU/HOCzZd5c9
    4+iMrLHTHq6u7biRcUbIqPMIB13W/x1otFVgqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:content-type:sender:list-id; s=arctest; t=1521088871; bh=23f
    wQ3xTwo0cFQeX5nF3eTZsfFq93CGUlrR3s9NodSs=; b=lcQlWqIwH9VusnJHM+O
    H/zfivR+olNaDH97b93YFYaAJnz48yEXCmbSnhsuLVJX7oBXi7Bs0umlIDUZn3Bs
    u+D2c7RWzI0OAu+19a9AXLDyeSZf+L8ZFHgIJuywmLAxLpZjMC7LT2kg8t30aYV1
    REtsjAybAK0bVtmK4oWi3mnGqPMK7FWnutFRsO/PrJEGhV+XYzUGFdhIZ2e3jG7T
    17wOd9QGqtWJAkzqCfWpEgQyhYPjQanw37kBxeNhMYTiapGPj5caRWgscrBbhQIB
    rwY28YvopFV4VfdvvstDRpSRtcO/F94bDhLLbBnHZ6ZPGNBRodsYfZgKtZHXaYBV
    y5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=G3vOaIqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Hk+uc19T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b=G3vOaIqd x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=endlessm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Hk+uc19T;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=endlessm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeCOEkx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 00:40:53 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51875 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751482AbeCOEkv (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Mar 2018 00:40:51 -0400
X-Google-Smtp-Source: AG47ELulcbl7kgDlmJ+DPxwCJHK/6E8GQ4itce0QJgr5jd6aR2ifRdKCJ6zEjxD352ys3k6F8sWUT/+stmq38mDjZTg=
MIME-Version: 1.0
From: Chris Chiu <chiu@endlessm.com>
Date: Thu, 15 Mar 2018 12:40:49 +0800
Message-ID: <CAB4CAwf_k-WsF3zL4epm9TKAOu0h=Bv1XhXV_gY3bziOo_NPKA@mail.gmail.com>
Subject: Intel GemniLake xHCI connected devices can never wake up the system
 from suspend
To: mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,
    I  have a ASUS AIO V222GA and another Acer Desktop XC-830 both
have Intel CPU J5005 and they both hit the same problem. The XHCI
connected USB keyboard/mouse can never wakeup the system from suspend.
It reminds me that similiar thing happens on ApolloLake too which
needs the XHCI_PME_STUCK_QUIRK to get it work. It's also mentioned in
https://www.intel.com/content/dam/www/public/us/en/documents/specification-updates/pentium-celeron-n-series-spec-update.pdf
page #14 for N-seris intel CPU. And I also find the same problem
description in https://www.intel.com/content/dam/www/public/us/en/documents/product-briefs/silver-celeron-spec-update.pdf
page #16 for J-series Intel CPU. Seems that they have different
workaround so I can not simply apply XHCI_PME_STUCK_QUIRK to make it
work.

    Anyone can help here?

Chris
