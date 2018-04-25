Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653022-2-6099833343933612502
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
    1524653021; b=JYlk6RbPkDfQqPpLfJYDxZ4ie1NeAy1E/0qMGlKKmrqCe2ZkU5
    HlHZ3esvZPtMI0zCGWt3eruaNS6zgcT3omBEKvDBzYHGsYw3wiierWwxXLZpxb5F
    UI/u9n9jliGs1jFZ3OzPR1VMTEESHk94Id7x5nxGUOMohsEgcL3Qscjawq3hxb9G
    eNHebl7a5OBtHo4GOjuQgCUJT+53tEeyv3p4aawnxZ1j/u18h/jaCTZd64IiSziP
    aaGenRrZ0KvvIbSPHdBfeAXUx7voToCrpi2PcPhlStGudp1r0M1rkOJa8ZoZ8KAJ
    3rz9kLfPrD8ZB2F3F4rVjsImJUfTs1OErnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653021; bh=VyD7Up3LcV9UqnZakITpxicJML6LWl
    DYLv/yhb7LXe4=; b=BDECOfl+NBGM/D1/08HxdFP9VnpSo7OV+BO2GaGbZYpy65
    f73DqXy6XhP7aVgcdERBmAEVY7ZXdMfoTIxbkWIZNHOYEdZ1D/5sf4dGwpK9d0RK
    mAtYqYsWJqL3kfHPKv/nn4qCVklE8yaXp3DtgNUsIO0JxmwlgIMCB51mwyXJF+2i
    sdJ5EbV3xzWtvC6K/+AAQem6yDM8oPMK1yRZ6lJlgXrLHcfzgqeA+gBu1Kb5jGRS
    JeUAweySVQucxezNhkBA79IRrMfULr95lvSqFjwVkhs6tpWLqm8UikU0+Uc/Bt1U
    bOEJqsd+0z9FVflTQIYmEiI6JR96zzaCyG3+ajrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfGARtT0DBkQKCTqyhYj2Vcevar6VavzPc9qHG4qpoMroturXSTxzkSsW74M0oiEYv1b0J+nGWnYAtowccl/ijVmUWs0J3QmcnTbWf1F3oLhLoh9qQto5
    fzwHasJJygiqILoatKllv5vbWfKogyOFBivBwx02UO+JoTgMrCtBd6mV9Ma0USspeJU0nc5kUbsmthhs3bmhCQdNHSmXjigAEUoe4D7Apl9bfc8d9SGFAYpa
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=LpQP-O61AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=8kmFWWlJgvVvTF_OhDYA:9 a=J1DmWDvOpag1ekLv:21
    a=CRoenY_a-S6jsnGm:21 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753915AbeDYKnf (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:43:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752819AbeDYKnc (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:43:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 145/183] PM / domains: Fix up domain-idle-states OF parsing
Date: Wed, 25 Apr 2018 12:36:05 +0200
Message-Id: <20180425103248.371130623@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
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

From: Ulf Hansson <ulf.hansson@linaro.org>


[ Upstream commit a3381e3a65cbaf612c8f584906c4dba27e84267c ]

Commit b539cc82d493 (PM / Domains: Ignore domain-idle-states that are
not compatible), made it possible to ignore non-compatible
domain-idle-states OF nodes. However, in case that happens while doing
the OF parsing, the number of elements in the allocated array would
exceed the numbers actually needed, thus wasting memory.

Fix this by pre-iterating the genpd OF node and counting the number of
compatible domain-idle-states nodes, before doing the allocation. While
doing this, it makes sense to rework the code a bit to avoid open coding,
of parts responsible for the OF node iteration.

Let's also take the opportunity to clarify the function header for
of_genpd_parse_idle_states(), about what is being returned in case of
errors.

Fixes: b539cc82d493 (PM / Domains: Ignore domain-idle-states that are not compatible)
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/power/domain.c |   76 ++++++++++++++++++++++++++------------------
 1 file changed, 45 insertions(+), 31 deletions(-)

--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2206,6 +2206,38 @@ static int genpd_parse_state(struct genp
 	return 0;
 }
 
+static int genpd_iterate_idle_states(struct device_node *dn,
+				     struct genpd_power_state *states)
+{
+	int ret;
+	struct of_phandle_iterator it;
+	struct device_node *np;
+	int i = 0;
+
+	ret = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
+	if (ret <= 0)
+		return ret;
+
+	/* Loop over the phandles until all the requested entry is found */
+	of_for_each_phandle(&it, ret, dn, "domain-idle-states", NULL, 0) {
+		np = it.node;
+		if (!of_match_node(idle_state_match, np))
+			continue;
+		if (states) {
+			ret = genpd_parse_state(&states[i], np);
+			if (ret) {
+				pr_err("Parsing idle state node %pOF failed with err %d\n",
+				       np, ret);
+				of_node_put(np);
+				return ret;
+			}
+		}
+		i++;
+	}
+
+	return i;
+}
+
 /**
  * of_genpd_parse_idle_states: Return array of idle states for the genpd.
  *
@@ -2215,49 +2247,31 @@ static int genpd_parse_state(struct genp
  *
  * Returns the device states parsed from the OF node. The memory for the states
  * is allocated by this function and is the responsibility of the caller to
- * free the memory after use.
+ * free the memory after use. If no domain idle states is found it returns
+ * -EINVAL and in case of errors, a negative error code.
  */
 int of_genpd_parse_idle_states(struct device_node *dn,
 			struct genpd_power_state **states, int *n)
 {
 	struct genpd_power_state *st;
-	struct device_node *np;
-	int i = 0;
-	int err, ret;
-	int count;
-	struct of_phandle_iterator it;
-	const struct of_device_id *match_id;
+	int ret;
 
-	count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
-	if (count <= 0)
-		return -EINVAL;
+	ret = genpd_iterate_idle_states(dn, NULL);
+	if (ret <= 0)
+		return ret < 0 ? ret : -EINVAL;
 
-	st = kcalloc(count, sizeof(*st), GFP_KERNEL);
+	st = kcalloc(ret, sizeof(*st), GFP_KERNEL);
 	if (!st)
 		return -ENOMEM;
 
-	/* Loop over the phandles until all the requested entry is found */
-	of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
-		np = it.node;
-		match_id = of_match_node(idle_state_match, np);
-		if (!match_id)
-			continue;
-		ret = genpd_parse_state(&st[i++], np);
-		if (ret) {
-			pr_err
-			("Parsing idle state node %pOF failed with err %d\n",
-							np, ret);
-			of_node_put(np);
-			kfree(st);
-			return ret;
-		}
+	ret = genpd_iterate_idle_states(dn, st);
+	if (ret <= 0) {
+		kfree(st);
+		return ret < 0 ? ret : -EINVAL;
 	}
 
-	*n = i;
-	if (!i)
-		kfree(st);
-	else
-		*states = st;
+	*states = st;
+	*n = ret;
 
 	return 0;
 }
