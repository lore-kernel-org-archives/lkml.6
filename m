Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3170045-1524143279-2-5737124417157970716
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524143278; b=w8+SMSjHrf2Kzg+kSQSsou6RWir6AcxuBQYr/WPJRS4EWrfbjl
    Ph76k4q9jup2O0qCDWz/hrMmFFcjYWVSrXEmLf9iDP93YgYOYgXD/35W5jliCEAy
    99Xjt22kHbEOf4xraJuHH8x9x54WcLGCB2WWHSGHLqSYLXJmCquNQypc/PAYY/lW
    bABjFT13j9vxD4fB62Y+ARanxQqbOPY9uemBDZZkpZHgyRwPZbfAIxMR97Mcpxxf
    zcj7oZpolfdfr7CS3P2IVvjKrpjXl0ooOZAc4GjTupMBqord6xbbWwd82SVbu/eI
    DvmqwbViXkG6omh5BtG2ti76c6WGoeEzxQiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524143278;
    bh=ct15Ol0iNDqriJPWcIm9tgvJw/+tqsueS510DuMW+p8=; b=qIvfuh4994cN
    f/JJ1vDwAJ9e8DteHGLEZXztj8ELZ5z0eOy4mA+0ZVzVqNjWofZSZeE1/eXEV4jZ
    WMfDpdjyFpiVRKcMP+92O6hFtYX1wlvE9o04ovvAEgp2hn0ds/YvlsNSZE46Q5qp
    iP/dRVE0WyKwsiZzD660A1+OmbAdjTQe87ukOGrybFIOoR07jfeTFMr2P1ZX2hAV
    4L5G/UFkb9/2ljieZzMDab8TZX1qtJuZyOCfJT8UI4FNcpn3kL9XmeEU5Lg7TE64
    E3ejIe+qDamJ1qsxC8tleSxlQW6m5beAeGb8BDQ3as4jh43saiDl+sXTO+p51B8W
    gDo3kWV7eA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elektrobit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=elektrobit.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=elektrobit.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=elektrobit.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHVZXlcibgNvnvk/PbsSgVov3U6H3M2OvOSkUk0rUUsawtgswJYwtL7LWInuuqpSFFiXD20rr6WkCTGl/6EpOAz3Qql6J2xIyrX4igfi6OxxIY7k9qr8
    gRpc2og+CZvh+r3cRqHGfK1qLPhn0SATAJuJHI46g8vjZGm0hfUMVR7sY9zzh9CcrJg3zyj4AFabiWYcYyaQABnbqtWmDbIcX/icxdAtpcAORzomoMO6bx5N
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=HH5vDtPzAAAA:8 a=r5xRmG6aAAAA:8 a=VwQbUJbxAAAA:8 a=CJQnokyGUJMpm3WMKx8A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=QM_-zKB-Ew0MsOlNKMB5:22
    a=K5o92ufZVrFAm5YEHcMt:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDSNH4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 09:07:56 -0400
Received: from agrajag.zerfleddert.de ([88.198.237.222]:55498 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbeDSNHz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 Apr 2018 09:07:55 -0400
Date: Thu, 19 Apr 2018 15:02:28 +0200
From: Stefan Potyra <Stefan.Potyra@elektrobit.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ldv-project@linuxtesting.org, sil2review@lists.osadl.org
Subject: [PATCH] Check for an error when the clock is enabled.
Message-ID: <20180419130228.rdee6hwsjcui5py7@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Found by Linux Driver Verification project (linuxtesting.org).

Fixes: 0814e8d5da2b sc16is7xx: enable the clock
Signed-off-by: Stefan Potyra <Stefan.Potyra@elektrobit.com>
---
 drivers/tty/serial/sc16is7xx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 65792a3539d0..243c96025053 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1168,7 +1168,10 @@ static int sc16is7xx_probe(struct device *dev,
 		else
 			return PTR_ERR(s->clk);
 	} else {
-		clk_prepare_enable(s->clk);
+		ret = clk_prepare_enable(s->clk);
+		if (ret)
+			return ret;
+
 		freq = clk_get_rate(s->clk);
 	}
 
-- 
2.17.0

