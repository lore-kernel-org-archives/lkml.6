Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481411-2-4283387679810802298
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481411; b=pvH95tW+I+PpSwZea0Qkhub2MlY2/t8it9tb++SD9420sbwLb2
    oGfdwJ5r0c+RyPndiHRQ2x4CBxxCz1Y1Cs2RYP7HMWqRITmr/LhyEzm+a/+wyBY8
    D9rN9L2YZvDALwDkEP2no3746Zc8p5ZQlgdxJwW5D4jEWSxc4rS4C3hYiVmpBE14
    gVqs/TkIEsypY7uItgzVA8nWMUtf3nPz9Lx7v8NGe5CjlyKs8PlHLNk14C0Uif4E
    eBR/12dn4viKbRlUCXUWFnOewoc6ZCKdZtslrzfbktcdIkTpwc7zyn3bXnRgGIPw
    ag8t6p3WVwqtbPgFz1qsNjckYChS5QVA8HqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481411; bh=2m/rV+94nFnwdXOyIvaE/YUkMuix0g
    tUQSq0byVFApM=; b=NOHY0mZA9exNjrZD+MEqlcbuWo+YvfW468PP/zkgVc7FMI
    eVvQ1ji+FfFKcq0VSbGjlgaH/0nUFYF4nZ1aQ9SWOaJvXhFzTdM5gXx7gCmwI9da
    F5K6vp+z7otONpiS9q3Jc7ZjuC9LnbFRH3B/aSex/KcxrTYiGz0d+XZEHNTV4K6g
    g86KLrgLCL3n8BqOAu4suAIE8GS2ePTKwYoIPj77QyGvbtk53OrdUss4ObgXrqzZ
    /ShCkJ6wlFyVffcq1NHK2FZY+gaTBtnleH6YiZPC97kATtbgtABjlKgdPGBp++lX
    WckVMFyYMQ/UmNgFf/VoWVJ1vT92m0+/d2IOHQbw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ/GmOrloWm3dM62SvEuo6UlKem27dE4S7agShcjOFwt6UPCR/sloS2AQIC9NWeYcUX91/gcYdH/FYwCE9toAJkkkeztNaauKeVaG9hNaRYi6RCMiz6E
    0sYRZ8vEzKTOXBvX7qK3DV9JurM57RQYCF3ntunntb+vP975LqrpdJNKfcN9oKcWEcl5M2NGr36iwlSKxjRP/5IWCLcux8YNWwB9RL5oT7S+d9DOVadW2Vdw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Byx-y9mGAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=gDawn3u-IPWhMShO_m0A:9 a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeDKSka (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56454 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeDKSk0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jia-Ju Bai <baijiaju1990@163.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 062/121] qlcnic: Fix a sleep-in-atomic bug in qlcnic_82xx_hw_write_wx_2M and qlcnic_82xx_hw_read_wx_2M
Date: Wed, 11 Apr 2018 20:36:05 +0200
Message-Id: <20180411183500.024221483@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jia-Ju Bai <baijiaju1990@163.com>


[ Upstream commit 5ea6d691aac6c93b790f0905e3460d44cc4c449b ]

The driver may sleep under a write spin lock, and the function
call path is:
qlcnic_82xx_hw_write_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range
qlcnic_82xx_hw_read_wx_2M (acquire the lock by write_lock_irqsave)
  crb_win_lock
    qlcnic_pcie_sem_lock
      usleep_range

To fix it, the usleep_range is replaced with udelay.

Signed-off-by: Jia-Ju Bai <baijiaju1990@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_hw.c
@@ -341,7 +341,7 @@ qlcnic_pcie_sem_lock(struct qlcnic_adapt
 			}
 			return -EIO;
 		}
-		usleep_range(1000, 1500);
+		udelay(1200);
 	}
 
 	if (id_reg)
