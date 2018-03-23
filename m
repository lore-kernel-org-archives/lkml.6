Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521807405-2-15351013044439043387
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
    t=1521807405; b=OMLeHzBzZfklZO0bNAIuYkzsbtfcqaMjeNhmfu1axhfgwoy
    fA01S5jcgEfolRJMMLKI2dt9fpDqPbUR723b52pzh62g3ikmtz+V+vL2yOc3EkWg
    VyJlYzXJ2ruSZ6g5YlvOTf1qNHQSvFtxYznU7beWjA2V4CF1oGleXm0TJNHmLtBH
    i/q+rXfoUMtdwfmy75PqNsIBdpbcgooYPh1nzkwcxdveSS4at2A+oKlyqVWSHdbZ
    SIVXXhDdilQ020SnzHarDQN4yqhO6lYhBWa0p1/csQVJP9brfH63uK9km9nZLd7d
    lszhThhqb04AAPdhlpGIefmxlL8sH3RLUHdrYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807405; bh=UOK5DXvgOYOBKRAacBbibRX7j0
    QPWWrXEbbDxpg5mck=; b=IEj2AzoIxUIZJKOCXfvIv1ocruMKpeRnvxBr+uBF6A
    ae6+3hCJGRuaEB7aUnnw0vaEgoOa1xbyGCI2KJzPw/wb5HDVXfUUncGscfgQRtTX
    KpqtNNvgaPd5D7fzNO/R8TSb23HcjUSy89EA6eb6WZdJxqVaelze01OYDg8xt3Gf
    fDdJ5pK6O91HZAf9sKBeZc0Ve0H8Y67L0llOGELac/za018smFAxFlWZfCXlYaz1
    1pT7pG5Afv8iFBTEPiV3kNowMSeanAQoflxMe9xDpI1l7Xz3aGO2WvyRPFreoUl+
    Rx8813bf/5xZKwSoF5iEqPwBtDTbhV6NJZKHV5mdmc/A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1752740AbeCWMQ3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 08:16:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33992 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752629AbeCWJ4a (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:56:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Meelis Roos <mroos@linux.ee>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 06/84] cpufreq: longhaul: Revert transition_delay_us to 200 ms
Date: Fri, 23 Mar 2018 10:53:20 +0100
Message-Id: <20180323095412.876570801@linuxfoundation.org>
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

From: Viresh Kumar <viresh.kumar@linaro.org>


[ Upstream commit 1d0d064307cbfd8546841f6e9d94d02c55e45e1e ]

The commit e948bc8fbee0 ("cpufreq: Cap the default transition delay
value to 10 ms") caused a regression on EPIA-M min-ITX computer where
shutdown or reboot hangs occasionally with a print message like:

longhaul: Warning: Timeout while waiting for idle PCI bus
cpufreq: __target_index: Failed to change cpu frequency: -16

This probably happens because the cpufreq governor tries to change the
frequency of the CPU faster than allowed by the hardware.

Before the above commit, the default transition delay was set to 200 ms
for a transition_latency of 200000 ns. Lets revert back to that
transition delay value to fix it. Note that several other transition
delay values were tested like 20 ms and 30 ms and none of them have
resolved system hang issue completely.

Fixes: e948bc8fbee0 (cpufreq: Cap the default transition delay value to 10 ms)
Reported-by: Meelis Roos <mroos@linux.ee>
Suggested-by: Rafael J. Wysocki <rjw@rjwysocki.net>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/longhaul.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/cpufreq/longhaul.c
+++ b/drivers/cpufreq/longhaul.c
@@ -894,7 +894,7 @@ static int longhaul_cpu_init(struct cpuf
 	if ((longhaul_version != TYPE_LONGHAUL_V1) && (scale_voltage != 0))
 		longhaul_setup_voltagescaling();
 
-	policy->cpuinfo.transition_latency = 200000;	/* nsec */
+	policy->transition_delay_us = 200000;	/* usec */
 
 	return cpufreq_table_validate_and_show(policy, longhaul_table);
 }
