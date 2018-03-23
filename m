Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806141-2-1919148652401122734
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
    t=1521806140; b=RnqkMUOzx5jN9BFfBjjjXIUA6xQ25r6SBfa9t554BCia2U0
    VAB12GSw/XMrU7DxLRq2fMQGs3Vc6iodzCRifTQhNORSo2U3PKJnCu01r+GCOebk
    KDQ6zFzqQaNvgFsXBa6S79GETMMbPYDgQ+QGsnHaCiDCi3f7J6aLcqQ9as3YFL5Q
    WkXTAp4MTrglovjK2hslIgm4bzLuGNBxV8LLugf2HrQzxoLfX5pQMXXTbTyctRcx
    cOA1OqGnWEP6Gutl29wYn8NhSYjGDFacpxUB/mpIyrJEy7dXOjVZbHbsbEulqSDQ
    y5FQSexg6OUtSYDQMCfeZGF+NTTDDTxK1zrjYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806140; bh=wiPvB3WTydSZQyHngAbdLJdAm3
    QD8XnosPkcKaXfku0=; b=GCOVXoCpJYtnjU3BqUyfMmj82elEvHPntkHcWr7jk9
    yN+ccC+5rO6xNjU0OyQdqhonwETNofXr1cN/O5NzmSyrUdFFvEWiUG7r37bkCD/A
    Pq/3pVaHSdQUxRBiBTZxJyVFVwgXowgPZxADNXsMqvYD/gLY3XmG5U+00IV3tesP
    eFm6IdZY+FGdirDPgBygnjTdg44W3AcwavAHygyoFs6pFEVF2hI4tZKrvEGYi7Uh
    Dd8MBjATUrWdfPG4RLnQ3lFBYmOKD+QJpuuoftRlMkwAhZAypPx4+SUnWSiXlUdZ
    or+7U6dRdz623pdNcRxhtB9sVGVuQI1a7UkUeZ7GoDcw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753380AbeCWKBN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:01:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753166AbeCWKBM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:01:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 27/77] mmc: avoid removing non-removable hosts during suspend
Date: Fri, 23 Mar 2018 10:54:01 +0100
Message-Id: <20180323094144.037440001@linuxfoundation.org>
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

From: Daniel Drake <drake@endlessm.com>


[ Upstream commit de8dcc3d2c0e08e5068ee1e26fc46415c15e3637 ]

The Weibu F3C MiniPC has an onboard AP6255 module, presenting
two SDIO functions on a single MMC host (Bluetooth/btsdio and
WiFi/brcmfmac), and the mmc layer correctly detects this as
non-removable.

After suspend/resume, the wifi and bluetooth interfaces disappear
and do not get probed again.

The conditions here are:

 1. During suspend, we reach mmc_pm_notify()

 2. mmc_pm_notify() calls mmc_sdio_pre_suspend() to see if we can
    suspend the SDIO host. However, mmc_sdio_pre_suspend() returns
    -ENOSYS because btsdio_driver does not have a suspend method.

 3. mmc_pm_notify() proceeds to remove the card

 4. Upon resume, mmc_rescan() does nothing with this host, because of
    the rescan_entered check which aims to only scan a non-removable
    device a single time (i.e. during boot).

Fix the loss of functionality by detecting that we are unable to
suspend a non-removable host, so avoid the forced removal in that
case. The comment above this function already indicates that this
code was only intended for removable devices.

Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/core.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2751,6 +2751,14 @@ static int mmc_pm_notify(struct notifier
 		if (!err)
 			break;
 
+		if (!mmc_card_is_removable(host)) {
+			dev_warn(mmc_dev(host),
+				 "pre_suspend failed for non-removable host: "
+				 "%d\n", err);
+			/* Avoid removing non-removable hosts */
+			break;
+		}
+
 		/* Calling bus_ops->remove() with a claimed host can deadlock */
 		host->bus_ops->remove(host);
 		mmc_claim_host(host);
