Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841677-1519418886-2-11259377252087222719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519418885; b=ddgZSyXjtCI2tOTIRERyAX6sNoQENAS4Rabbam4zxhVZRCF
    ZpjIXNSXiWYgu1fizWE3YyUnTvXgMU/1eQmgnFPMzozGgRBcrKUCAognLa/F8HLm
    sw6nZzxBKUHX7RRbLVXowdVCyP4gJXn+JBop+Ehkf2ds83w+rYkioevftes0FJz+
    qh6QZg71bc2bCcDO1uiEAmMk7aoKoFPLpXaVkeD0EO2xkm4RyRP0nxOFrgPPjNAP
    ZvOmHL1qFVX9vDEJ/Xdo1Q7XyHe3Oj2Pj8dgKi+bBUNzKG2Cx9Bhoz84qw4U5nNZ
    401Ouxl3pkMlHJA02URoi0pF28PI89Q2UCSe1gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519418885; bh=2dyWEP9l0k6bcOCEpyRPYrw1ti
    efxMwkaNDsPQ5kOtM=; b=baH8nrtyOIim1F3Bwe4CO6yZgwnQ+HQ7W40DtBmrl6
    4ftmDaDAYEWoEHBEFjHsWicRYxgu37vKDMv2HM/Lywj+c3rUMvit1L9fmgj7+1MA
    di8cmEIomZxkamncOwIlg21c+dZ84xq5/KcO2CduxJ0eUw+Ora32nJXt1ExO0822
    zM53ePNgfwWmIoFS9oAWzMKVOz3uIzCQ0G7D0tQK4Mi/az4/Epjv3XfPsRelxgyl
    /I6hSDaHUihzgDgoD0l/gCh8frDCF1lNodAUdE7uL2n5ht20OG0JmEoy7uelvsnj
    tPbkeWVaEHaZLY0OYR8swG6WBpbcFm+edf7zHRelILLw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752726AbeBWScE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:32:04 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35624 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752716AbeBWSb7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:31:59 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Takuo Koguchi <takuo.koguchi.sw@hitachi.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 50/58] spi: sun4i: disable clocks in the remove function
Date: Fri, 23 Feb 2018 19:26:49 +0100
Message-Id: <20180223170214.617686521@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170206.724655284@linuxfoundation.org>
References: <20180223170206.724655284@linuxfoundation.org>
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

From: Takuo Koguchi <takuo.koguchi@gmail.com>


[ Upstream commit c810daba0ab5226084a56893a789af427a801146 ]

mclk and hclk need to be disabled. Since pm_runtime_disable does
not disable the clocks, use pm_runtime_force_suspend instead.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-sun4i.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -458,7 +458,7 @@ err_free_master:
 
 static int sun4i_spi_remove(struct platform_device *pdev)
 {
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_force_suspend(&pdev->dev);
 
 	return 0;
 }
