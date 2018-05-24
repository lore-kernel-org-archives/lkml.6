Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161467-2-12876409473565269858
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endaro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527161466; b=nfwHZqkiv9rGN+e3GcNP4mhzlkUA+A8aKFXHxFLeZ7cO+Csaur
    h9bp8kIujrDV1ybmgKu4e98Oqf0Cu3rJDDYFQ36hTDHuj0pBV+j/bEdBOCKoaNx/
    Ouc1eLeXYWBCq1QHc2EeJOk4HDJYIffhzYA7qMRLXKOVQZYdeHK3PaThGfnZH3i3
    4CpFbX6DVdPOroiC4bq3YiHTtse+9HXnLeLkIcPH49Z9M549uBm8ON2rMOz2xxLe
    PAfd/EPqtTv6bcNKeTM6JmJxv2TqLjGkGtifKFTcsWr1zOdqlNquIT5jOSasFfOd
    ZBoQwoEYK2tV6C+gt/I9MZ4ZQKSjmv7Fgmfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161466; bh=TfkfKXQujcCCvS78BszO9AgNXxkBP8
    cooWsOtUbAJSQ=; b=W/L6TTrIbvjJqIMOfxgDxTOOFwr/kVDPI8EVpmO2PvtU4S
    8SUNShug6V45WGIbhb1Mpb94jzdtmhx+pP79mM/fzTWuUYW1wscnBVJ6yRMSKGCO
    kLzFsJ78tn4k85mmWsZNvt8miD5i/qvaMyLMAo3cqCwS9TSVMC6P25et9VmAsTDu
    DqbCCtVvBWYUYAtsORZhNCSLkJopMCiVt5J5SJJxFTfKffpUwilgpcK4GU5URKc+
    TnDOLJdq1XEZP5YFRfgU7XgdZcJEEharCqICiMaPWgFDgH0OrGIEE7ixy4WHZU9y
    05h7tbLSQ5W34qtQpoyxsFOn7gInOTbu7fp5AR4w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FKs5Vn7/ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FKs5Vn7/ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOsA9IwcRMBSBxkH9hp9aHOsjK214ROshjfktZtf/wmyfLRNtp/bMZZojkHLILqo1DqC8b1hQokRC44BjxR0DtUF7Iu7RzlLWi1T4ck+JwgGLzuz8yxw
    Eq0pCLmmtbbsBaA8kVyoEqB3vY3dC8jLimof2NQySx9HSaZ/Pcc8lZXyRvJhge8HFo1dws8fRNKv7xmjL0C6PzG2zbtjaMf62E80R7U0vQjqUtmQ1qnR77Zq
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=KKAkSRfTAAAA:8 a=P-IC7800AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=sfgkyT37IKWEnqeQgUwA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=d3PnA9EDa4IxuAV0gXij:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967844AbeEXLbD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:31:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967473AbeEXJvF (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:51:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bryan ODonoghue <pure.logic@nexus-software.ie>,
        Shawn Guo <shawn.guo@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 94/96] rtc: snvs: Fix usage of snvs_rtc_enable
Date: Thu, 24 May 2018 11:39:17 +0200
Message-Id: <20180524093611.297842473@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

[ Upstream commit 1485991c024603b2fb4ae77beb7a0d741128a48e ]

commit 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver") introduces
the SNVS RTC driver with a function snvs_rtc_enable().

snvs_rtc_enable() can return an error on the enable path however this
driver does not currently trap that failure on the probe() path and
consequently if enabling the RTC fails we encounter a later error spinning
forever in rtc_write_sync_lp().

[   36.093481] [<c010d630>] (__irq_svc) from [<c0c2e9ec>] (_raw_spin_unlock_irqrestore+0x34/0x44)
[   36.102122] [<c0c2e9ec>] (_raw_spin_unlock_irqrestore) from [<c072e32c>] (regmap_read+0x4c/0x5c)
[   36.110938] [<c072e32c>] (regmap_read) from [<c085d0f4>] (rtc_write_sync_lp+0x6c/0x98)
[   36.118881] [<c085d0f4>] (rtc_write_sync_lp) from [<c085d160>] (snvs_rtc_alarm_irq_enable+0x40/0x4c)
[   36.128041] [<c085d160>] (snvs_rtc_alarm_irq_enable) from [<c08567b4>] (rtc_timer_do_work+0xd8/0x1a8)
[   36.137291] [<c08567b4>] (rtc_timer_do_work) from [<c01441b8>] (process_one_work+0x28c/0x76c)
[   36.145840] [<c01441b8>] (process_one_work) from [<c01446cc>] (worker_thread+0x34/0x58c)
[   36.153961] [<c01446cc>] (worker_thread) from [<c014aee4>] (kthread+0x138/0x150)
[   36.161388] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)
[   36.168635] rcu_sched kthread starved for 2602 jiffies! g496 c495 f0x2 RCU_GP_WAIT_FQS(3) ->state=0x0 ->cpu=0
[   36.178564] rcu_sched       R  running task        0     8      2 0x00000000
[   36.185664] [<c0c288b0>] (__schedule) from [<c0c29134>] (schedule+0x3c/0xa0)
[   36.192739] [<c0c29134>] (schedule) from [<c0c2db80>] (schedule_timeout+0x78/0x4e0)
[   36.200422] [<c0c2db80>] (schedule_timeout) from [<c01a7ab0>] (rcu_gp_kthread+0x648/0x1864)
[   36.208800] [<c01a7ab0>] (rcu_gp_kthread) from [<c014aee4>] (kthread+0x138/0x150)
[   36.216309] [<c014aee4>] (kthread) from [<c0107e14>] (ret_from_fork+0x14/0x20)

This patch fixes by parsing the result of rtc_write_sync_lp() and
propagating both in the probe and elsewhere. If the RTC doesn't start we
don't proceed loading the driver and don't get into this loop mess later
on.

Fixes: 179a502f8c46 ("rtc: snvs: add Freescale rtc-snvs driver")
Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-snvs.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -132,20 +132,23 @@ static int snvs_rtc_set_time(struct devi
 {
 	struct snvs_rtc_data *data = dev_get_drvdata(dev);
 	unsigned long time;
+	int ret;
 
 	rtc_tm_to_time(tm, &time);
 
 	/* Disable RTC first */
-	snvs_rtc_enable(data, false);
+	ret = snvs_rtc_enable(data, false);
+	if (ret)
+		return ret;
 
 	/* Write 32-bit time to 47-bit timer, leaving 15 LSBs blank */
 	regmap_write(data->regmap, data->offset + SNVS_LPSRTCLR, time << CNTR_TO_SECS_SH);
 	regmap_write(data->regmap, data->offset + SNVS_LPSRTCMR, time >> (32 - CNTR_TO_SECS_SH));
 
 	/* Enable RTC again */
-	snvs_rtc_enable(data, true);
+	ret = snvs_rtc_enable(data, true);
 
-	return 0;
+	return ret;
 }
 
 static int snvs_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
@@ -287,7 +290,11 @@ static int snvs_rtc_probe(struct platfor
 	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
 
 	/* Enable RTC */
-	snvs_rtc_enable(data, true);
+	ret = snvs_rtc_enable(data, true);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable rtc %d\n", ret);
+		goto error_rtc_device_register;
+	}
 
 	device_init_wakeup(&pdev->dev, true);
 
