Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4101065-1525230376-2-10424378256944707375
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
    1525230375; b=YNY+cKKn5GjcDuO5BfHe6NF8kPaRy3+eLQhkUSG9/Gda8v8UZB
    jPhMgKBTjBYoWMem3DrPBfZCxJfSuvr/SJ8SL4g9Ds3nCO8Gm6wi6OnQ7GqezFOn
    rvvhT8I24k+XdkLRqUHuMf98yvgXwQXNMBu0iFidHUUr2UzkiWnv3Hf564DQPJKZ
    CjZpqmvx2Wzh8XzK/Qn9/fQDzRoijM6rE6O9fNhM2fha9fUSh/khcAb+Fdm4lu3d
    3BTGjjea5t2KgTr33wMRNW5gOfdM9a6JNo73V+0y8jcE6db20Tj3zMMXVd8RuqDO
    z7TZvKrG6k2lEoI/jaHcTcWMdo36P/mKCeUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525230375; bh=87moivpugfiBGobvjag8KDYC7WtC4I
    o6sptqVxJtlHo=; b=girOiJ+ly/E5Bx3WT9vdbjze9vNSBY43OzJ5289q9XHQe+
    mCNJFWCwBW9GPtvhX/K8OsBgZfDiF38JmwtD1VqrDTyDuavn8gNBvHHP1X/IIRtB
    csEFBSUCluiNqYF01MRhPsYKB9AloI9+ujtKQTb8+sEBu18WDKTFnnGMIBU/t+tX
    htJBq72ou6cafsHuvL0TnoUI5cQGE1RkZ1vjZgwWRNoJGTrpU0LRtb36MlC0dK8F
    LY9I4AWNq/HCNWKe2473js9v8U/aN43NRnYGgmbNFnrw2RTVoRVUa/rsvdAkC5nu
    f+9GEtp1QWqjuyqHyyWymwRc7C29KltyN9yhUbmA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=rock-chips.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rock-chips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=rock-chips.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOOLDVh1rIm12hBrIBL6ZAQaQftuWs1bc2w6rA3zrR/fhlN8uiSKLPzNXYAN2mNqOblSA9noZMCFlzP/y7kRSo1anzIJAYSmS0aThThjKtERv/gXQCqU
    7wCuct/DWgAX5m9jVCQD555EqsLepFF6BydjtRgaOSi6wQWfXOHA5XBxgZnTylSRGM5N4sRh+HpG8lQLVskD4duoXaz9RETxP9WmG5ARSIKQ7wtQWDAbL+l0
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751809AbeEBDGM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 1 May 2018 23:06:12 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:33901 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751763AbeEBDGK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 1 May 2018 23:06:10 -0400
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
X-UNIQUE-TAG: <42b11df21b18771cf7ca8eba497602ad>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: William Wu <william.wu@rock-chips.com>
To: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org
Cc: sergei.shtylyov@cogentembedded.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        william.wu@rock-chips.com, wzz@rock-chips.com, zsq@rock-chips.com,
        Allen.Hsu@quantatw.com, StanTsui@AOPEN.com
Subject: [PATCH v2 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Wed,  2 May 2018 11:04:46 +0800
Message-Id: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com>
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


