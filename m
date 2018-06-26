Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5936C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D7126D1A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 15:22:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6D7126D1A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752017AbeFZPWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 11:22:05 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47911 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751950AbeFZPWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 11:22:03 -0400
Received: from 79.184.255.183.ipv4.supernova.orange.pl (79.184.255.183) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 30a794575fddc1af; Tue, 26 Jun 2018 17:22:00 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     Linux Documentation <linux-doc@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: intel_pstate: Describe hwp_dynamic_boost sysfs knob
Date:   Tue, 26 Jun 2018 17:20:43 +0200
Message-ID: <306013127.TOMvMKusHN@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Document the recently introduced hwp_dynamic_boost sysfs knob
allowing user space to tell intel_pstate to use iowait boosting
in the active mode with HWP enabled (to improve performance).

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/admin-guide/pm/intel_pstate.rst |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
===================================================================
--- linux-pm.orig/Documentation/admin-guide/pm/intel_pstate.rst
+++ linux-pm/Documentation/admin-guide/pm/intel_pstate.rst
@@ -378,6 +378,17 @@ argument is passed to the kernel in the
 	but it affects the maximum possible value of per-policy P-state	limits
 	(see `Interpretation of Policy Attributes`_ below for details).
 
+``hwp_dynamic_boost``
+	This attribute is only present if ``intel_pstate`` works in the
+	`active mode with the HWP feature enabled <Active Mode With HWP_>`_ in
+	the processor.  If set (equal to 1), it causes the minimum P-state limit
+	to be increased dynamically for a short time whenever a task previously
+	waiting on I/O is selected to run on a given logical CPU (the purpose
+	of this mechanism is to improve performance).
+
+	This setting has no effect on logical CPUs whose minimum P-state limit
+	is directly set to the highest non-turbo P-state or above it.
+
 .. _status_attr:
 
 ``status``

