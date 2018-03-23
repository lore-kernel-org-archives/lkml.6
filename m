Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807087-2-5899066542825350829
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521807086; b=mBUWOFVc0qNhr2i/6hlUz2BlJrp3U898idrW5knacxU9Qp5
    GfnHAo0xkXEOjXlCKznXJrAAR3hV3panBWiw0M+RUbV30EeheCw/nY5JOD0I62fJ
    4gsKScAUqcEAmfVCVMRqcaq6wAWXuCrN5l8v1YikIgw4Vkq14xq3IS1W4eaOUk/V
    Nrr/wwY8hRrHoXuINw3BTJMXq7Z3cDoXwPpLJcVUZ62nHyHlKXje7TelfbN+tH+z
    xLAwYFyttOxG8CZC4XvhY4B+LNpNfMrnTHrbo98LRMHprwtxQiZqTPhjSmHqZ1Uv
    MqthNQ5veXwwMeW+E9AKYtfUgeAIPx+krFq8eYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807086; bh=Azx9Cl//QC3QjNHyoe7jLA6CCM
    1AoHS4Chr/rqC6l/g=; b=uIaFII/GSn8Ngi2HXoJWdjXRMrcefnspQMJrWqN93o
    8kVkcwQ9Mh4exi48tVrOe3E2wJklJph7H6853hVdZ+IFCgKZdxY99sdPpe9DuCBo
    EBPTlt58Al3FRihR0wJOD2P42TAU3pvveeq6VxZGoykC8RiXsjUTzG7L8o191S/J
    SnCQ+m3KCN3qTMx+AmCOlTBX/KxJXS2hPkhAd9MshYT53LWvzELJonQbFC8Y70pR
    wKjgRb6DJ6rXSu2soStlBQ8yGp8a8lmttAxsrEXWqTHNHRCkHsaUJxKjCwMeRjUs
    QwN5nZOun2GFyFcL/W1lGmeEwbXmjJflb6nsMeb+4HqQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbeCWMLI (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:11:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35474 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752947AbeCWJ5u (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:50 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhoujie Wu <zjwu@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 47/84] mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
Date: Fri, 23 Mar 2018 10:54:01 +0100
Message-Id: <20180323095419.109959552@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhoujie Wu <zjwu@marvell.com>


[ Upstream commit 8d876bf472dba73c015cea9feea80dcb80626a7c ]

According to SD spec 3.00 3.6.1 signal voltage switch
procedure step 6~8,
(6) Set 1.8V Signal Enable in the Host Control 2 register.
(7) Wait 5ms. 1.8V voltage regulator shall be stable within this period.
(8) If 1.8V Signal Enable is cleared by Host Controller, go to step (12).
Host should wait 5ms after set 1.8V signal enable bit in
Host Control 2 register and check if 1.8V is stable or not.

But current code checks this bit right after set it.
On some platforms with xenon controller found the bit is
cleared right away and host reports "1.8V regulator output
did not became stable" and 5ms delay can help.

Implement voltage_switch callback for xenon controller to add 5ms
delay to make sure the 1.8V signal enable bit is set by controller.

Signed-off-by: Zhoujie Wu <zjwu@marvell.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/sdhci-xenon.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -230,7 +230,14 @@ static void xenon_set_power(struct sdhci
 		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
 }
 
+static void xenon_voltage_switch(struct sdhci_host *host)
+{
+	/* Wait for 5ms after set 1.8V signal enable bit */
+	usleep_range(5000, 5500);
+}
+
 static const struct sdhci_ops sdhci_xenon_ops = {
+	.voltage_switch		= xenon_voltage_switch,
 	.set_clock		= sdhci_set_clock,
 	.set_power		= xenon_set_power,
 	.set_bus_width		= sdhci_set_bus_width,
