Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3937186-1523632646-5-7739524412611772146
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523632645; b=WGjcOxshIJn5ZXD/UpTP5jdMLxiU97B/wKngYae6OXHz6lbbg5
    4uD5jrNmdu1YMJYT6CCnbWwjS7G/TdO/H7bSkVbd1XmTy8ccTXdoKd54v9Ah1uId
    5BPA3hlvzMN+Gyljfk77AcOao3bxlH5HW7ThVRvlzTHFIgBVZvSZcN68fi3okh0J
    mVebMqYQBO3WXrmfov9HiWBUr5BpakJhFcW31bAJ60Qe7ZM860HOzgdcljA87zzG
    Nl/cLJWWZUMC53TfqhJjUHaR6GIe9FLEpV/EsXH/RNuqZPMLUen3KykwNXQVmHxe
    vsBvCI5k2rftSmqgUwC3wegOZChTHs5VtJtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523632645; bh=
    YiT2AOy4m11pO92HYe/1LpL7AgLVPRIH7lEEEIiwP3w=; b=UE8mdC6NjhqpDf5h
    3wZwFaQAZvI6RuwRmYA+N/kOUJsYjDaN82DxjzLXy6ytqoLMawmIu1yTU+OunaU4
    bCzYVq64s8L4tkEVrkOxNRjWfr/e2meggj99RU8In4TjFnDhiSE5LUUV1KzOY6MD
    z4emzm/WE9/kqn7JP5VRMuVuGzxDBYHXtZWMVzpyN0M1FoJH0mKd8mlHFLQsVWog
    hvJDHtOG9aIgF9+nbduTXXMBCzbsddh8gTIKuHXuu2iTe9xfKa9zJ+CoflGrwxKw
    Ls/VKNmQQD3nfOFV/E/Y7ARQJ1esNbJwlTRCX8zVtQKGB3orUFPNgY0KnjlUEucI
    Ox/7yA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OXLtG9vg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WkUO4HDy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OXLtG9vg x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WkUO4HDy;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA2oqE2UtCz3KW48OENNDyd2vJGhuDVM20JIsK1TpB3dcUVfi9H8MmHbn9NoGpDQv6MlgyMpfaj5Cl3vPyhnaQjjeTIS+kIvwwY536zOvxGF7ofs3kam
    QQuS4KtqZ6smJWqN6f2YRS8hwQ875FgraihjuP1ur654KNjeCfzRWlCcFFzn8vceQ335RWQ7hANH0Oa/YNCcPdunddjnUNkv8Vno00aTabr0fq3drn354GAD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=mK_AVkanAAAA:8
    a=VwQbUJbxAAAA:8 a=Rx9jPjVhjFHgyKRT4X0A:9 a=x8gzFH9gYPwA:10
    a=3gWm3jAn84ENXaBijsEo:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeDMPRV (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 11:17:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33203 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeDMPRS (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 11:17:18 -0400
X-Google-Smtp-Source: AIpwx49m2oW6xoFhaGIDnAxM9wcKsaoXNkDBVzfJZH9go07Z78TZbR148Xe+6VUca0gEZwrFZWpr/Q==
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/3] USB: musb: host: prevent core phy initialisation
Date: Fri, 13 Apr 2018 17:15:04 +0200
Message-Id: <20180413151505.32663-3-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413151505.32663-1-johan@kernel.org>
References: <20180413151505.32663-1-johan@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Set the new HCD flag which prevents USB core from trying to manage our
phys.

This is needed to be able to associate the controller platform device
with the glue device device-tree node on the BBB which uses legacy USB
phys. Otherwise, the generic phy lookup in usb_phy_roothub_init() and
thus HCD registration fails repeatedly with -EPROBE_DEFER (see commit
178a0bce05cb ("usb: core: hcd: integrate the PHY wrapper into the HCD
core")).

Note that a related phy-lookup issue was recently worked around in the
phy core by commit b7563e2796f8 ("phy: work around 'phys' references to
usb-nop-xceiv devices"). Something similar may now be needed for other
USB phys, and in particular if we eventually want to let USB core manage
musb generic phys.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/musb_host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 3a8451a15f7f..4fa372c845e1 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2754,6 +2754,7 @@ int musb_host_setup(struct musb *musb, int power_budget)
 	hcd->self.otg_port = 1;
 	musb->xceiv->otg->host = &hcd->self;
 	hcd->power_budget = 2 * (power_budget ? : 250);
+	hcd->skip_phy_initialization = 1;
 
 	ret = usb_add_hcd(hcd, 0, 0);
 	if (ret < 0)
-- 
2.17.0

