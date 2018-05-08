Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2036687-1525748935-2-7886710119667241750
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, RCVD_IN_SORBS_WEB 1.5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525748935; b=Z18ORJX7aTItPsfBBLUyg0HM4IhQfFtztmaHd8bjShVEUITSoc
    CT62mEBW8Er74XoSe5wXlFLYFBPrF6gGqaoUlpYUt694iOHeqFfY3VLmj8k8wSIb
    Oxg3gcDrO1bDIHDA+6rnhOOiB6mAIXCdG8Jmna8M3I2n/enHMUTD1BZ3CWfeUG+A
    m7TLVYoC6cfcqsNGcETrCauVQdtlpWBaipbu8hedu3aRrXmNdUZMmBU9HrcqAHJ0
    QOWs7cw9La0j8U5IDi8fzF6dsiCdheuZfpz2iQwN0JILnxvM4nlps9vIZ3DH6GCf
    /IrzKylZUtv1+YHFkxLHqCGJYFPOoz1VH1bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525748935; bh=k3UTjXwChJ8JZ3KOkgM9MSWnyGeCBw
    3Le//TnKMquVM=; b=J8Un+4QbDv9IY8kP50pev9ds7XlxH/UJDFv8/MYufNrmdO
    DOasOnvkU9Yi2ylmyOs9yPwyMoyGvx8+HFYQJQp/okuQbmKCeUrbZO/XVObdRy57
    iEAavW+5Fjk3mkn2YG+9HleFNydYpjONrV71XRB6+eULLFZpCznnqiTNhecIUhUd
    5GsCWx+0sLdg2tbsQtGylsDXdhg/UePZICz4UrZzSqqxe+CHiUDxubxCkNooasrl
    Eretr/lHHPb3y9ZitweQXVbXdABq4HjEonno0tJvCjQVdSJhcw+7I8+5XohfiIXw
    B9Y8xby6k8PI676n5rxiKnc/RbNPbPtmQx/lMLQQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfMEdSd+EA7WBSVCeiDn53GK3TtcLSLCPnkn43u0woyLGq9uzi/BYpvDI5gv7Kue57O7gy59f6/soebEDQzbIAoIkH4+s0H6LLlMrpuGbw6LYKaicTzSf
    Z6v4kxwEXdjKqXmbPJwqFZWWCwS7UznZ6Zp0e/+r6/ATf0eVwLK7cuCKKdfqgr44fRDQ68o0BKYN/FegO+pqBjy5PR9cTy632acgbCAtzBlamqtOhu4dFmDD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=2yCBVkMr0AGrh4y31QkA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754072AbeEHDIv (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 23:08:51 -0400
Received: from regular1.263xmail.com ([211.150.99.135]:44725 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753896AbeEHDIu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 23:08:50 -0400
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
X-UNIQUE-TAG: <0095e97bf258a81e73bf4537b2056f7a>
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
Subject: [PATCH v3 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Tue,  8 May 2018 11:07:24 +0800
Message-Id: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com>
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
 drivers/usb/dwc2/hcd.c       | 85 ++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc2/hcd.h       | 10 ++++++
 drivers/usb/dwc2/hcd_intr.c  | 11 ++++--
 drivers/usb/dwc2/hcd_queue.c |  3 ++
 5 files changed, 107 insertions(+), 5 deletions(-)

-- 
2.0.0


