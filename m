Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28828C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF272064C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730786AbfAJR7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:59:16 -0500
Received: from shell.v3.sk ([90.176.6.54]:58555 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730703AbfAJR7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:59:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 7C7C91002FC;
        Thu, 10 Jan 2019 18:59:09 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D8cQBG2P0Syb; Thu, 10 Jan 2019 18:58:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 0A9BC1002F8;
        Thu, 10 Jan 2019 18:58:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HJb0jpyyW1RC; Thu, 10 Jan 2019 18:58:53 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id C9EC31002F0;
        Thu, 10 Jan 2019 18:58:52 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/10] Add support for OLPC XO 1.75 Embedded Controller
Date:   Thu, 10 Jan 2019 18:58:35 +0100
Message-Id: <20190110175845.1203986-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is a fifth spin of the patch set that adds support for the Embedded
Controller on an OLPC XO 1.75 machine.

It notably removes the patches that adjust the battery driver -- those we=
re
submitted to linux-pm separately [1].

[1] https://lore.kernel.org/lkml/20190110174005.1202564-1-lkundrak@v3.sk/=
T/#m9da9aee9e6482ee680a103280ebb769ebcbb32ef

This DT bindings doc is pretty much independent of the above:

[01/10] dt-bindings: olpc,xo1.75-ec: Add OLPC XO-1.75 EC

The OLPC EC changes follow. Cleanups first, then functionality:

[02/10] Platform: OLPC: Remove an unused include
[03/10] Platform: OLPC: Move EC-specific functionality out from
[04/10] Platform: OLPC: Avoid a warning if the EC didn't
[05/10] Platform: OLPC: Use BIT() and GENMASK() for event masks
[06/10] Platform: OLPC: Add XO-1.75 EC driver
[07/10] Platform: OLPC: Add a regulator for the DCON

The patch 08/10 only makes sense once both the above and the XO 1.75
battery support is merged, otherwise enabling CONFIG_BATTERY_OLPC on
ARM would break build.

[08/10] power: supply: olpc_battery: Allow building the driver

The restart support has been split off, because there's a possibility it
needs to be reworked: the arm_pm_restart export patch was objected to:

[09/10] ARM: export arm_pm_restart
[10/10] Platform: OLPC: Add restart support to XO-1.75 EC

Tested to work on an OLPC XO 1.75 and also tested not to break x86
support with an OLPC XO 1 machine. I don't have a XO 1.5, but it's
unlikely this breaks it when XO 1 works.

Lubo


