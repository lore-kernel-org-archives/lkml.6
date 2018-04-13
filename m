Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3962825-1523632679-2-715599125504452195
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523632678; b=V//UDQ4oo6mFlvjQMzbeDDWcB3DsGiNNq8uDG4ufGDBhC1JGPh
    jIOsI36/JvPHsv2YJidTL0EaGUFQ1mhvQlOIR+EhHkqHbNMtKqj5/W5iUqtXW3wY
    ZyCXHjuh28p6TPOEU7XQRqtA5qIcO9Opvr0yrZ51V1tJZkAGxVtJ8GsqlCtZfQzL
    UOYdnTMTUzzl5XEw2GRHifdG8T9DLzuDaz9PSw0bP+8XfOgfvQKVAfNwx4P/CRqU
    4sEAxHcpf++5tBU3VgHxvjL/nnsUHyrxoL9ouYm0OZ7BMZ1xegw1lSMsEsShtVzq
    gfkHZhL+3IFgdR4oHdXp6k6L7t0t3adIzadg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=fm2; t=1523632678; bh=8if5CadPDeT7feCcBXlw1M31ka5WXf
    Le9aXBks3BcsQ=; b=Fd86wwDKGK68TehGZ8ThnaAqRkJS2MskyQynsqffuIm7vY
    i6m6WkfjPnnGRJAIsuO3NkvjSxTkCsD+c5lFyagqG7v6isYudnZhJbMTJhRDqv4S
    a1VfPrQ6Xh42vLYTPClOCOGg+uOeWAu5QYPPAgOpKgw8cTYOW9uT6v0IizsPTWlJ
    MohoK2p1nUhiG1It4U82H2Va5v2k/qCiyMkak7wFUCml8U5Kl1AyOl9C+o0McdR2
    wl4NhGvbh3atmLVbXduMDbi5As/LOq+Tt5SviUiFx2ged8FCgXW6C8MoCHJyZ2YA
    GWk36tIdwOnGiAVag4VY++SnE2bgjTWxIYNnOHRQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JCS1rz2Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BpYoYA08;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JCS1rz2Q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BpYoYA08;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfAZBIbezTgttaVj2qi3x+YOsSxNEIP50D3Wh055BSIiZXcbSIyxDBend7bVhB0NFS9Be77pDe+eBSaSOrMZ74qAZXeD0SMxc0N3wNN4Zr4kxI5cc6c
    aCcA8KWD96eRDvnzf2IfGLwRB2AS5V9XVPY3chs2XnswIJUfq7G89Wcw3LN7zj+txcPlmD0OOhZdgMfZOV0tHuL/cxZx2XbN/LAvs6Dsonn0RgbH4kV1FI70
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=vPq8ayLaFMKpPRGixPQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751011AbeDMPRR (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 11:17:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34363 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeDMPRQ (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 11:17:16 -0400
X-Google-Smtp-Source: AIpwx4+l28nmaqtDh6mTR5TaLy+gxbM3DI3DYV/W2waoNCXX2MkU+x7WuFFPGJmqjSaZQwccdP1XVQ==
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
Date: Fri, 13 Apr 2018 17:15:02 +0200
Message-Id: <20180413151505.32663-1-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I've been carrying a patch out-of-tree since my work on improving the
USB device-tree support which is needed to be able to describe USB
topologies for musb based controllers.

This patch, which associates the platform controller device with the
glue device device-tree node, did not play well with the recent changes
which added generic phy support to USB core however.

Like the recent dwc2 regression fixed by Arnd after the device-tree
#phy-cell changes, the generic phy code in USB core can now also fail
indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
phy.

The second patch addresses this for musb, which handles its own (legacy
and generic) phys, but something more may possibly now be needed for
other platforms with legacy phys.

In the process of debugging this, I stumbled over another issue which
caused the dsps legacy phy init two be called twice on every probe and
which is fixed by the first patch.

Johan


Johan Hovold (3):
  USB: musb: dsps: drop duplicate phy initialisation
  USB: musb: host: prevent core phy initialisation
  USB: musb: dsps: propagate device-tree node

 drivers/usb/musb/musb_dsps.c | 3 +--
 drivers/usb/musb/musb_host.c | 1 +
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.0

