Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1682199-1525729021-2-10252977829173803445
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525729020; b=WXewk7cnvYtveIgf2IvaQNvAhAFmgObwMaws6gZ0XmEHNohr/Z
    pTX3/jHV9UU6wwvQQ7Wb6+vDvkuw2gfAolRteh+61uLjKVfCouIkMJb1abfTS21v
    neVMXtOZzWFZFSP3rKYA4TTxTFc/5jHE0VcJCCIvXTxj78sj7MU4QkBi7CwSKMc/
    Fi+68cUWwLXD1x/K+KmqTI/hNjYaYUnxbNW/98sQavNgBCkpYGtDSgI7j3ECQe64
    OXBEU91giZQbn+k8uEyOVHE3+v6hNKdQECx9UpGppOiyM0ZSumm8LjUGzerZ40tN
    l/QwNUfMklJTMmxiZeNE8ZrfmXeiQgR2KwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525729020; bh=P9j2ePghHOLYj4v3sIvtN9w0tWPS9K
    q64CQ61E279uE=; b=U6sKME4XRhwO/o4GSVfEL7Ujx0L7UdtkDvTslxnD/1ReGg
    dPLWE8EuiUz09XW7wOE7VR4hndKFnIxXdc9wjuxu9wN7rWJOC68x0OVZsYYyb85g
    LE/tl+hcamSs3jYj+kimMutnN3BPmNZCf0kq2gj7M9/jFrJ4a3K6xPu+zgO8383Q
    aJlaDnH8M59FTRwE6lWMFZQT15qKEYqEUz/KrsdVgbr7YUf3UMyiyF5aKpbIJskM
    uf0yAF4xX2Zp+EWsPEtUM9wT1GqmkwpQ2mOmvn19o1SXNEuDmqUh8ImelYYelv9I
    nYMa2raxiMBIG1DcUXmzLSsAXF3mpkJaqpN+O8Vg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=collabora.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=collabora.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=collabora.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-49 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAkakSr3YfLdJVA7tKXyebrPu2EVK9xYUrPXLiuxDPU1Ibff/pVbXXbLgpcugVl8xOQnkx4gqAaJ+PznHfav0XYAE6/dd5hx1kFFoGdmJbmeQIddgyoQ
    gKUfIzw1GfcLcBV6BynQunUF+VB+0WdGVDy1GklIhwlKZOjrFza7rrXZU2VrAwKb/V2cBM5dstLYj57qWVVP7jwqLXfeeu/909klNbQO8pBmRJB3mmzP+NS2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeEGVgP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:36:15 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43694 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753141AbeEGVgO (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 17:36:14 -0400
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
        <u.kleine-koenig@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH 0/2] serial: imx: cleanup shutdown
Date: Mon,  7 May 2018 23:36:08 +0200
Message-Id: <20180507213610.17330-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

Here is a simple cleanup patch for the imx serial driver. The second
one fixes a missing dma resource free. I tested both patches on imx53
based GE PPD device.

-- Sebastian

Sebastian Reichel (2):
  serial: imx: cleanup imx_uart_disable_dma()
  serial: imx: dma_unmap_sg buffers on shutdown

 drivers/tty/serial/imx.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

-- 
2.17.0

