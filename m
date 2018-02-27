Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1753727-1519744436-2-16631753815123618167
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519744436; b=m1YuGIOJlnKNTnrlI8OJ0r2+zNLycsVJ4aarhopbs6hvqcV
    j1ZZW1H6qz/LsCO+3vQvUtjmTURM0Z2Wg8iJfkKCH5BA6HHxjLYxr4R6sr8K1bdn
    aHHjUAnvC1E0tm/KNdsx6OQ1xwgPBv2501sBSYTBOQVeiUSQCtBAp6/GYeV1EYn8
    Ig9o5cn6PObGHBhVCLvlz3/OG6Pei0E3+ayTkciLelXVQ3DNsxEEsqtS/S5a+3tX
    gHf1vdbOe1XzsCt//UvSNbXKawOww29UfK/b9R4PExNaab9I2i44/ZP//K9mZc/K
    9vh97qwjIhGSkQYSqtaKfHmcbHhe8zPFs9qXd0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519744436; bh=Ou7wN4gJUS+eCr+e/2/CZa+e8jVnVNLL6fT2H5PKmUo=; b=W
    ITBTyx9NagepZvy39jFHfwsTAbz2uDe/Vi+TutGiKpdA1lBQVJmEiwmTyq5LYvjM
    JXAbCAkt1eOlW8sJ3rDdQvNg13W4ViCYxfCw5LYNa6S/E6mIAHMozSJqCS1nhil3
    puhr5Nk/gxVZPqX7hjccZlAEiQsYpfAqRwwusBzQ7WmUHqTkVDnSOG1rk9uxiH44
    yJBJOBggsm9JZCzahCd6WcMQEHVTDTVxLoDMPHkmDYPVZR2ZWsLtvMkf6sPqx2eA
    sKD9/XvhOSCeqM7S+qsLuIyvEthcpF8PXdFXFhwERxQHYSztYVX1cvoLRWMrefAC
    SNZOMd6G1vfN1CSlcEUWw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZC9nv2NG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BDRZ9+bR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZC9nv2NG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BDRZ9+bR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeB0PNY (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 10:13:24 -0500
Received: from mail-pl0-f50.google.com ([209.85.160.50]:44828 "EHLO
        mail-pl0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753292AbeB0PNX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 10:13:23 -0500
X-Google-Smtp-Source: AH8x225xrUSpssqrmo+hjOs3RgTulaic6Q7RNVXpuR6fBXjZBqCkqrVKUyY2fu3zwaqM2lmC4Gg5Gg==
Message-ID: <1519744400.7296.10.camel@gmail.com>
Subject: Re: inconsistent lock state with usbnet/asix usb ethernet and xhci
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
        netdev@vger.kernel.org,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        'Linux Samsung SOC' <linux-samsung-soc@vger.kernel.org>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>,
        Oliver Neukum <oneukum@suse.com>
Date: Tue, 27 Feb 2018 07:13:20 -0800
In-Reply-To: <1519744167.7296.8.camel@gmail.com>
References: <CGME20180227072602eucas1p28dcdba711b3153820bd409d838cc63bd@eucas1p2.samsung.com>
         <c15c90ef-ce1b-4dd7-1d9f-673deb01b6d2@samsung.com>
         <1519740421.7296.6.camel@gmail.com>
         <bac44c1b-d701-2f6b-5e1e-738befc25c9d@samsung.com>
         <1519744167.7296.8.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 2018-02-27 at 07:09 -0800, Eric Dumazet wrote:
> 
> Note that for this one, it seems we also could perform stats updates in
> BH context, since skb is queued via defer_bh()
> 
> But simplicity wins I guess.

Thinking more about this, I am not sure we have any guarantee that TX
and RX can not run on multiple cpus.

Using an unique syncp is not going to be safe, even if we make lockdep
happy enough with the local_irq save/restore.


