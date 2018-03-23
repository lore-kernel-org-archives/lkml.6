Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805984-2-10851723354409682430
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
    t=1521805983; b=l3ALkeqfV9Yy8HJeow55kPIdR4r4xIK/r82y9JiuCfIt1dK
    BIDzVAM8hewYtRQCxGYEt0LT8ClFM6KNFVnHOKNSlStkzo1EgkIZKiZRVM940e4c
    fAoV79rZJYodM3bp2TAL/Z2r7rOkMCD8CUt5qUFfcUf59nziKY/tXLejYRRd0UNb
    GXEZ67FS0orrnoeb19e4VpxZ2dtGdGIN1geLSAaMc2q9rneHU4KMNuT8I935xCTO
    up8mL9DInmlE09bH6QzuEzsz2O2emjrkdqzYAyGvDloRkshbIHpGyfaTfMFOyQCm
    wU11n9aju43//nZE4VfVrpvv46UgDNDUEbiQT8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805983; bh=s3ea8UzYKymDDgUwnZqa8A/MB5
    hdA8nR6FiSZAYSvV0=; b=QFJ9Rej5OfoDaKljGV3j8/2Q9lqpu+TuzuoLGExqfu
    roJERB7KVziXuVApEVmCVjjGQupBLbAEK3zSaD1JefF5FeHZZ6KvxqzUK8FnSIig
    1ldVrwklx4xK12QhbKnZdLPyjw4xxrW9LkxWRtvfVDKChVf2amGSTeCAuG1cPG2k
    Wbjz/0ASAD48iURUyZn/k0IMYVh/cm6cluIWPDF9s3tctBSOb2TOK3AcXJpDQ2Dt
    eTwEadUX9OAb5RelNRP1g3m/2eRoRRtZGwDGzfN4zUbYWiop2sRMvb2uPJsRsLPr
    KlvpsUeOan5RepRZITwqxP6uo1XK9aG2PSQtGqjAwg4Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1751966AbeCWKB4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754029AbeCWKBy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhoujie Wu <zjwu@marvell.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 41/77] mmc: sdhci-xenon: wait 5ms after set 1.8V signal enable
Date: Fri, 23 Mar 2018 10:54:15 +0100
Message-Id: <20180323094145.036289033@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
