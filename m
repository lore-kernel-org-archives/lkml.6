Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3750221-1526032082-2-15000780137353404648
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
    1526032082; b=jG6tJVgVJlsRnZ8lCooLIIHbHGAT5qvvfj3ep3i9ER/9tiCAJR
    MMyy6q0E0KrP2BvoKsaScQHh+psZMFDANB9Z+7LK0b7y2Fl2n5nHCa8FV/cjEJaW
    hgCbyQbswofC6N8LJwP+4rgTaTvARGHdmb0rgwxy80gm46y+RB9oh85t7i1RBCz0
    HncxgpueaL4E1WFaBjrLJvSxyksVvmOL5n3gkjwJXsHpaEkKS2a25aE//aZOI0Pa
    Z11hBlBzaulCun7cma96qVOY5v1Y9FJsWWBxE6sctBABfy0oyu7qrIDMabs4ijRY
    zBVWI0dBv/fSAnJKHGi+/PgDdurVQaF7+epg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526032082; bh=iko+fiTGrmkDN2SpqF9FKFEu3o5+Tb
    9zSCkdBns9gxk=; b=a4ZArzdYpaZGjBg/9g+htYv4jv5cZSoA42fFXo2g7si5Vn
    7iNoFc/zOmzNbxO8bB8IOFiyNZ62KPl87YKKCw/tH2/jRADHdPDWYGi1xFyvSQJ0
    /DFeGNpPH4oIapjQdFZFyoNILbCYDNWEe8aV0pPBhDywnKr/vrxOOd8FWfvpQGZc
    1w0QElF7KGFhEBZDFEMAxvMXiDXTF94c8xhRm4wa9TZDfVMQH7Co4oUEA0sZrmEl
    gYEoNIc0SpPh9Nu5ZyXmg+5pjJqpxhOZd2QG7HvjepdAiU4I07f4k+zz5uDNavj7
    c6Z0pXv7vsqxZPq78O/FIthjm3LinuXQqebYVbIg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPFlT5d+eRZ3lH+gqwvZDFgkmhQGavChaD+BCaa/0hfpm8E5b9cNoh24h0eRUu4IhSgvOC+yzHrtw8lsA78mmQ8hgfFReODLVGue/dlHyfwUgMUIVqxi
    IflBW3FwlbcEtQBThFnHDFWB8b5mF0fahshUcHOJMOKv1svLj4ach5kw5rP2+tn0C67TQQUwNaWIzsflSzAovGBkJ6w0z8UCchQGbUqMIoMVg4T9tCylHKX+
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=magQ0VlHrGo6hfXHAucA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752673AbeEKJr6 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 05:47:58 -0400
Received: from regular1.263xmail.com ([211.150.99.137]:43519 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752604AbeEKJr5 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 11 May 2018 05:47:57 -0400
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
X-UNIQUE-TAG: <c4b4139909022289a211883eb03afe4a>
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
        Allen.Hsu@quantatw.com, StanTsui@AOPEN.com, Spruce.Wu@quantatw.com,
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        Mon-Jer.Wu@quantatw.com, Claud.Chang@quantatw.com,
        San.Lin@quantatw.com, Ren.Kuo@quantatw.com, davidhtwang@aopen.com,
        fonglin@aopen.com, stevencheng@aopen.com, tomchen@aopen.com,
        donchang@aopen.com, milesschofield@aopen.com
Subject: [PATCH v5 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Fri, 11 May 2018 17:46:30 +0800
Message-Id: <1526031992-16565-1-git-send-email-william.wu@rock-chips.com>
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

 drivers/usb/dwc2/core.h      |  3 ++
 drivers/usb/dwc2/hcd.c       | 89 +++++++++++++++++++++++++++++++++++++++++---
 drivers/usb/dwc2/hcd.h       |  8 ++++
 drivers/usb/dwc2/hcd_intr.c  | 11 +++++-
 drivers/usb/dwc2/hcd_queue.c |  3 ++
 5 files changed, 107 insertions(+), 7 deletions(-)

-- 
2.0.0


