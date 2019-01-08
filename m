Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9F7C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC9D8206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbfAHR6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:58:43 -0500
Received: from shell.v3.sk ([90.176.6.54]:49904 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727484AbfAHR6m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:58:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 07EE3100050;
        Tue,  8 Jan 2019 18:58:36 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id InuCT_yISQSq; Tue,  8 Jan 2019 18:58:25 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 21C26100057;
        Tue,  8 Jan 2019 18:58:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id loLyG6O6AVhW; Tue,  8 Jan 2019 18:58:22 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 2F64310004D;
        Tue,  8 Jan 2019 18:58:22 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>
Cc:     James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/15] Add support for OLPC XO 1.75 Embedded Controller
Date:   Tue,  8 Jan 2019 18:58:03 +0100
Message-Id: <20190108175818.705110-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a fourth spin of the patch set that adds support for the
Embedded Controller on an OLPC XO 1.75 machine.

It hopefully incorporated all feedback received previously and also
fixes the kbuild test bot failures. The failed builds were generally
caused by configurations where the EC driver was built as module.

It turned out that the patch that turned the OLPC EC common code into
a module was not the brightest idea. I now dropped it and modified the
04/15 to not require it.

Also, the 01/15 patch has been added to allow the module to provide a
reboot handler. Patch 15/15 depends on it.

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

[01/15] ARM: export arm_pm_restart()
[02/15] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC bindings
[03/15] Platform: OLPC: Remove an unused include
[04/15] Platform: OLPC: Add XO-1.75 EC driver
[05/15] Platform: OLPC: Avoid a warning if the EC didn't register yet
[06/15] Platform: OLPC: Move EC-specific functionality out from x86
[07/15] Platform: OLPC: Use BIT() and GENMASK() for event masks
[08/15] Platform: OLPC: add a regulator for the DCON
[09/15] dt-bindings: olpc_battery: Add XO-1.5 battery
[10/15] x86, olpc: Use a correct version when making up a battery node
[11/15] power: supply: olpc_battery: Use DT to get battery version
[12/15] power: supply: olpc_battery: Move priv data to a struct
[13/15] power: supply: olpc_battery: Use devm_power_supply_register()
[14/15] power: supply: olpc_battery: Avoid using platform_info
[15/15] power: supply: olpc_battery: Add OLPC XO 1.75 support

Lubo


