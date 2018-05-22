Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2247758-1526979908-2-8449370468009143822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, BODY_URI_ONLY 0.998, HEADER_FROM_DIFFERENT_DOMAINS 0.248,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526979908; b=c6fLRNR7S0y0IyUWGxJTgLTTczYdyXg3FmwrseDXT82rdwOzcT
    FqJonGxYuqXomBGM9zIkJ9W/wlF3pMXR2q14VNXtH1AhG45DWXoPaYLTzZfP2Sne
    ttQJOgKrItYPvLyRf9YBDvWnsrtWdHnsjb++J5eCiwWx4jvS0W9o3zVpwmZfCwhR
    VStfwRaU+EHZw4K0cr3sAAjvZaRLhY3XoIzhvdz1uTgX7Vwx1zUpjk/q6/L3eT/O
    g0HYLoYUhMmlnHYzifJuK4JzffaYpW8p9xyuBnAz7BExqtjxQ6iPaqLK31wkD4Uk
    V0oU/50nIqmpuAwrbEQVw5DhflAOJs0Kb9bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526979908;
    bh=D3x4oS4FZA8Tg/nu7R6DRNfzr6hglb+IXZ7lvb9UkUo=; b=TwjJREhrdLQq
    Su+d3n5urjKDWw+UmmYnd8YUEx9Jlf6n9Gp58N9UZBqKMyM44Hh4IvAjX1z/z093
    0yxyg43n/SFI5S5++O5nG8xKMO/6TC364W8xdkkoi/qIKKRZrDsPSZ5VtRRzu2Mb
    X8hiwdf79Pk93UM1Am03l8kR3+eRR4snrdHaEG10F3uymULKsGRD/3oD6S5JK0a7
    D5wPWu8DECXL0ZXGPxt5LT1c0455w/K2oyelntAUdlisK00rzuf6az95l1flxeNy
    s3ntPxFRu9lstBDqgjlJ1wtj1dBUGrpqL6oiPSwcw+XMqLSMOvAUVYOeHfK1Lm+/
    s/roJNd3pA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC4dhNMVc+mSNNZ2pJJn9HvY7aAoGWbdoPdW7BKtjiUgvsgHOCLvLKfnQ6TNBEoC0srIcNVwj3RPsSp4DImnIzBDmVXJVhyG5RUcfRTkaBJDkX+VWobP
    gHH7lyscSflIFG+J9mMZ7NEmh7GvNrERFCdUbdXuBtMlX6mCl1uGArx60vWL+J/fpKADzTsMcqzbZKrvXsUoSRXZc2ZjarmrLSFKJmEN+Hm3ZeElnbqb+IdE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=97dSWYl1AAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=OJayMvquMdr9gCXU5-l_:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751060AbeEVJFD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 05:05:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:42188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeEVJFC (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Tue, 22 May 2018 05:05:02 -0400
Message-ID: <1526979498.30491.1.camel@suse.com>
Subject: Re: [PATCH v2 1/2] [usb-storage] Add support for FL_ALWAYS_SYNC
 flag in the UAS driver
From: Oliver Neukum <oneukum@suse.com>
To: Alexander Kappner <agk@godking.net>, stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, gregkh@linuxfoundation.org
Date: Tue, 22 May 2018 10:58:18 +0200
In-Reply-To: <1526705416-12573-2-git-send-email-agk@godking.net>
References: <Pine.LNX.4.44L0.1805181634000.1645-100000@iolanthe.rowland.org>
         <1526705416-12573-1-git-send-email-agk@godking.net>
         <1526705416-12573-2-git-send-email-agk@godking.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Freitag, den 18.05.2018, 21:50 -0700 schrieb Alexander Kappner:
> The ALWAYS_SYNC flag is currently honored by the usb-storage driver but not UAS
> and is required to work around devices that become unstable upon being
> queried for cache. This code is taken straight from:
> drivers/usb/storage/scsiglue.c:284
> 
> Signed-off-by: Alexander Kappner <agk@godking.net>
Acked-by: Oliver Neukum <oneukum@suse.com>
