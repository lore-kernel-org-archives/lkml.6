Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3011300-1522264471-2-9816625274883425880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623, URIBL_SBL_A 0.1, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ie',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522264470; b=ZbUHK7jrBo2S1GeKsQXEHGzy0nDvTuUwrOhybMzwrdEGTFP
    4MQGGrWRifhXLRBdoWsWZk1OIEx5OjNY4gwFd1D/Fea/gvBu6mFrMIwFfGURX0OW
    tpJUpXONJDQ/n6IQeLicmIaR3iHVJV71IPvf31fzNugAMQ5xn8DzOo6+fPWY/QDV
    Y0IETCwcCgV1x6OIOUREsLe6mqT7oG8inKijFYYY9eLrkvpGDSjpMmFoKLM1klT6
    CfsVA8WhjINkCSDNM+H4h4rn1dYs17nQmmCSUVSZb3wchMSCvxSbmm2EBvcoQvvT
    gKvfP+c+NWXsvZrXCNGdYgacAJUZM5DlX7C8YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1522264470; bh=T5JLS+vVSh05587FLkWOYbFy9v
    CfN/6ANbj3XVe3Tw8=; b=sFGL5jHtynzkgKO8IC1ymCNfJLARESl7Z6vcDqyzyO
    QmuY4JYV7IvVQKS4bUQ45KIanIiK3Iij7Vz8unJHKO4vSau/PzcPo0u95YfFle1G
    m4yNxDZQ7yhSbbsZ5WDhwyR2k5YSy3g0bubbdUKqm8o88ULG2MbU/AwelK6xQznA
    fVP4cN4XhCpci+ppOE8P9i4nINCdhgMq/n+zEcqUV3fR9WtNLymvKZAMrSkVY3ny
    EOsttZ3vCVuTx0+41LOpHJt5fTRqc+0sLfwGqFf9NEBU0YRuiU9frRBBAufnsgSa
    0mCcQjYf+OwP6D6mzYEnXtnZiGWnWyoQfEsbvhKwMdZg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=Un1m8HKM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ELi9OCwi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=Un1m8HKM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ELi9OCwi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfASuNTaGx3wsR7eyYryicNfwogB9TEFhcyNcyuevfI0m5SyIwmY03wTJ0QWwbgqcpwGE+l1iqAZYhPwWgpRiAT81GiXk/nbYO9A/VuBeT/Ty6llVT2GD
    ywYFagBH/WpqnJtt03Sio1tH4ORg/90La91z/9utUDhlSbmfm9H32ktlAgPZM5inJC/0wmVreSgyqjJp7DOF2juyylDvqvFdi5gZzAJk6160b5+S4YDm/KkY
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=v2DPQv5-lfwA:10 a=uP1ucDPQAAAA:8
    a=Byx-y9mGAAAA:8 a=3Suf5XRKAAAA:8 a=6ohNodAXAAAA:8 a=KKAkSRfTAAAA:8
    a=VwQbUJbxAAAA:8 a=sfgkyT37IKWEnqeQgUwA:9 a=9a9ggB8z3XFZH39hjkD6:22
    a=VcBebDW0u3KdNpfvOfbI:22 a=0gLUg1G2xj6MhZ7RLP3J:22 a=cvBusfyB2V15izCimMoJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeC1TOQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 15:14:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54138 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753852AbeC1TOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 15:14:14 -0400
X-Google-Smtp-Source: AIpwx4+PT6UovZ6GJM4fmAxm4BqeLU2DiImfR9GDrb4RcPdulxvV7TOvw7oJw3X/DR07eqK1rMbbhA==
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
To: alexandre.belloni@free-electrons.com, linux-kernel@vger.kernel.org
Cc: Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        a.zummo@towertech.it, Pan Bian <bianpan2016@163.com>,
        Guy Shapiro <guy.shapiro@mobi-wize.com>,
        Stefan Agner <stefan@agner.ch>,
        Frank Li <Frank.Li@freescale.com>,
        Shawn Guo <shawn.guo@linaro.org>, linux-rtc@vger.kernel.org,
        "# v3 . 16+" <stable@vger.kernel.org>
Subject: [RESEND] [PATCH] rtc: snvs: Fix usage of snvs_rtc_enable
Date: Wed, 28 Mar 2018 20:14:05 +0100
Message-Id: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.7.4
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
Cc: a.zummo@towertech.it
Cc: alexandre.belloni@free-electrons.com
Cc: Pan Bian <bianpan2016@163.com>
Cc: Guy Shapiro <guy.shapiro@mobi-wize.com>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Frank Li <Frank.Li@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.16+
---
 drivers/rtc/rtc-snvs.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-snvs.c b/drivers/rtc/rtc-snvs.c
index d8ef9e0..9af591d 100644
--- a/drivers/rtc/rtc-snvs.c
+++ b/drivers/rtc/rtc-snvs.c
@@ -132,20 +132,23 @@ static int snvs_rtc_set_time(struct device *dev, struct rtc_time *tm)
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
@@ -288,7 +291,11 @@ static int snvs_rtc_probe(struct platform_device *pdev)
 	regmap_write(data->regmap, data->offset + SNVS_LPSR, 0xffffffff);
 
 	/* Enable RTC */
-	snvs_rtc_enable(data, true);
+	ret = snvs_rtc_enable(data, true);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable rtc %d\n", ret);
+		goto error_rtc_device_register;
+	}
 
 	device_init_wakeup(&pdev->dev, true);
 
-- 
2.7.4
