Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-198351-1525860792-2-5903517363974387612
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
    1525860792; b=bzQIHdXhWSyuptoZFg6XagLAi1++uqOikXnIzox+10IyR7HWjt
    0MvnjGgGKx6K4X4tPDTkz72sIEJlHiBkVSiVz63YcpyGK01x1RzV4JrPxID7sOxs
    I5bG04vh0SSRJwtc9JXxy0LZ2JkmW9cZkYRF9MURIMzkNjnggbmaZN5SMPhsaAhl
    aNd4FwvNbvuffLHgfm5sfRqmWwU6+8rSHo63RfiZqt5L6064418/DScxcYgjSYPx
    YOV8ElRJgko5Qo2+oLB+fLm7aWsp1Q2YZ5REt3jgggMxpudj+1cWt6W7twMFzYrj
    pHE85u1a6zFb9vqwyE6WZN5iKgkrUM9NFucg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525860792; bh=hkd/nIOoTmg5MAS1I7TCYcEeFZEgHQ
    wr++sRbglh1m8=; b=L0+sX5O9gV2/Rl6Z1mBHdFvbCmKXrNTDnwzptgyybTFCSC
    m4AYSiZfiZm/Teak2y8Tzg6ulCkukMcjANsgDCa5Q8GBtDB5kWkQGhXBylMDLFf/
    38Ra066vwv37iwNIKOBcn1Z5Ys19I4EVTLGXNOCMS6HkKDE+OVPjTdSfUF6Ipps9
    ehACJX29Wmjzg4Hwjxfu4/DU1D4ZO8P5NSr04OlTMBQMra/yE+4sEzW3KywVMjeR
    bNOlPngIoa4/IRfiO1FdttE06DOshDKMUR0hXM6mYRRQv0CDYu0nyegBYjqe7lm7
    htx04+zC3i2Qi8UlgK+wt+o2UvAI3AbkeM4CoMvA==
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
X-CM-Envelope: MS4wfNFP4+/9gIUy5igrr8qjTElwvU1LpW0K3N16EuW5EoljXQcazjXCEMGcJOsAlGNDAm9L/Hvf0WwBuM7MHkKvanbpnt/6nLI0M8/e5AyDEsCy9H7btkWY
    tWpt4n5L63+RpRg04w3u9YDj8WAIhKdyAwdQw1PGP4KsQY3t0FBT2/W5Rro4FsjWHptFR8xiU2oCfXikZtg0AxJxFxgQj85fTGhxTaPocoNkB8ETuRwmzGK5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=0Qkj4BVdLmVWEne4eYYA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933968AbeEIKMY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 06:12:24 -0400
Received: from regular1.263xmail.com ([211.150.99.139]:39747 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932215AbeEIKMX (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 9 May 2018 06:12:23 -0400
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
X-UNIQUE-TAG: <89b4113af024d7b078dad8c96ea1259f>
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
Subject: [PATCH v4 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Wed,  9 May 2018 18:10:59 +0800
Message-Id: <1525860661-18619-1-git-send-email-william.wu@rock-chips.com>
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
 drivers/usb/dwc2/hcd.c       | 87 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc2/hcd.h       |  8 ++++
 drivers/usb/dwc2/hcd_intr.c  | 11 +++++-
 drivers/usb/dwc2/hcd_queue.c |  3 ++
 5 files changed, 106 insertions(+), 6 deletions(-)

-- 
2.0.0


