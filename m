Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2218510-1524537925-2-9449458821090537993
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524537924; b=JzJtmoWvV2BtKAbdpQAL2sqqME5YakEVC947X95lTFXDrwKZDg
    Oqg8pFsqxiagXe16qblBgXhfMY6GLyuFiWEzvJ4+34GZkxV9IfLsP8AGaDpaHG0e
    5s5fswvG3JAd87x3ZOciTe5KikzG3SoEsb723vnsGukQk5iaJrj1iH0QBOQcBQXt
    3f1ZCOYYON5a3VFk8a8INSiikC3KdEpUWKWFa+Pg1KiKWPqK5/ODUs2sUdIRAovA
    sdd08cuukiThQnkAGoziNG6zlr5bUq70tgqE/dTPRnpdqNsr3dWarnEgcn5MA7jG
    iaEdRaVKe4pJ4QAmJ07JuFqWzv0zldOrSBFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524537924; bh=87moivpugfiBGobvjag8KDYC7WtC4I
    o6sptqVxJtlHo=; b=WC4gK2adE2dDJNWs5hKhXcypQKLrjIODjJmc+QjlSOllOM
    Rrl4NopA6VQ2U2ZMVypZzYVyPItlasQipHq0MuAggyTiyfzxjQJokxTf6PHrJ2Jv
    6b0fRc+afIPWtGhcKm+355ikmrdFtu87paLS9fjPOorr9X0JaY5ehLhwi0p4Qvjk
    FV59pdkakN9iMv4clAHnTHbJB1KECPPqlE+WGGUo7/HZso4oMwuAemynuwwV8Imi
    lktfTpY1R3CKAhRpKDy3i8VtjAkg+QPcxBqmsedEUzhSFY4hpP3I8EE9Rcf3DO+K
    fFAkihGSUjQ1kSbZMTAI85RCmEBOFRnTPd6+veRQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rock-chips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGfooso0tXXqBHXH430A1RDE4qFl1bDXD5qYHa/3nlVFqP7iVJC7WsnTCVPlAn5m1BJ7JDdNNxxEE43w6R7NBIe8+rhBLZn4ucb3iUqz2EDi47bYFCYd
    ANAV1Wp880JYBQs+OROCER5d8rr7uBwef5ifNjj91PBQsQTq9AZBJb1VIkyUW5grf6CusXrRiSXKXDpvQodD5qpf6PC7vEtWcp2Dxo8qTYmY7wHHiKDHZ6Qg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeDXCpU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 22:45:20 -0400
Received: from regular1.263xmail.com ([211.150.99.134]:34584 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932721AbeDXCpK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 22:45:10 -0400
X-263anti-spam: KSV:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ABS-CHECKED: 4
X-IP-DOMAINF: 1
X-RL-SENDER: william.wu@rock-chips.com
X-FST-TO: hminas@synopsys.com
X-SENDER-IP: 58.22.7.114
X-LOGIN-NAME: william.wu@rock-chips.com
X-UNIQUE-TAG: <91098536c97872e2a6ffb1fb628477ac>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: heiko@sntech.de, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-rockchip@lists.infradead.org,
        frank.wang@rock-chips.com, huangtao@rock-chips.com,
        dianders@google.com, daniel.meng@rock-chips.com,
        John.Youn@synopsys.com, william.wu@rock-chips.com,
        wzz@rock-chips.com, zsq@rock-chips.com, Allen.Hsu@quantatw.com,
        StanTsui@AOPEN.com
Subject: [PATCH 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Tue, 24 Apr 2018 10:43:42 +0800
Message-Id: <1524537824-22010-1-git-send-email-william.wu@rock-chips.com>
X-Mailer: git-send-email 2.0.0
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This patch fix dma unaligned problem and data lost problem for
isoc split in transfer.

Test on rk3288 platform, use an usb hs Hub (GL852G-12) and an usb
fs audio device (Plantronics headset) to capture and playback.

William Wu (2):
  usb: dwc2: alloc dma aligned buffer for isoc split in
  usb: dwc2: fix isoc split in transfer with no data

 drivers/usb/dwc2/hcd.c       | 63 +++++++++++++++++++++++++++++++++++++++++---
 drivers/usb/dwc2/hcd.h       | 10 +++++++
 drivers/usb/dwc2/hcd_intr.c  | 10 ++++++-
 drivers/usb/dwc2/hcd_queue.c |  8 +++++-
 4 files changed, 86 insertions(+), 5 deletions(-)

-- 
2.0.0


