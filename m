Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BE0C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08A222081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:25:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A222081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbeKHC4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:56:25 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:41498 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbeKHC4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:56:25 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKRZb-0004R5-L6; Wed, 07 Nov 2018 18:24:59 +0100
Message-Id: <20181107171149.074948887@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 07 Nov 2018 18:10:11 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [patch 1/2] Documentation/process: Add maintainer handbooks section
References: <20181107171010.421878737@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline;
 filename=Documentation-process--Add-maintainer-handbooks-section.patch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

General rules for patch submission, coding style and related details are
available, but most subsystems have their sub-system specific extra rules
which differ or go beyond the common rules.

Mark suggested to add a subsystem/maintainer handbook section, where
subsystem maintainers can explain their specific quirks.

Add the section and link to it from the submitting-patches document.

Suggested-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/process/index.rst                |    1 +
 Documentation/process/maintainer-handbooks.rst |   14 ++++++++++++++
 Documentation/process/submitting-patches.rst   |    4 ++++
 3 files changed, 19 insertions(+)

--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -27,6 +27,7 @@ Below are the essential guides that ever
    submitting-patches
    programming-language
    coding-style
+   maintainer-handbooks
    maintainer-pgp-guide
    email-clients
    kernel-enforcement-statement
--- /dev/null
+++ b/Documentation/process/maintainer-handbooks.rst
@@ -0,0 +1,14 @@
+.. _maintainer_handbooks_main:
+
+Subsystem and maintainer tree specific development process notes
+================================================================
+
+The purpose of this document is to provide subsystem specific information
+which is supplementary to the general development process handbook
+:ref:`Documentation/process <development_process_main>`.
+
+Contents:
+
+.. toctree::
+   :numbered:
+   :maxdepth: 2
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -18,6 +18,10 @@ submitting code.  If you are submitting
 for device tree binding patches, read
 Documentation/devicetree/bindings/submitting-patches.txt.
 
+Some subsystems and maintainer trees have additional information about
+their workflow and expectations, see :ref:`Documentation/process
+<maintainer_handbooks_main>`.
+
 Many of these steps describe the default behavior of the ``git`` version
 control system; if you use ``git`` to prepare your patches, you'll find much
 of the mechanical work done for you, though you'll still need to prepare


