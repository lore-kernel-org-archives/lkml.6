Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85225C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDFE20657
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbfAJRmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:42:17 -0500
Received: from shell.v3.sk ([90.176.6.54]:58360 "EHLO shell.v3.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfAJRmP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:42:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 3DDFD10018D;
        Thu, 10 Jan 2019 18:42:12 +0100 (CET)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id WDWuzRt2kPun; Thu, 10 Jan 2019 18:42:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id B25E01002ED;
        Thu, 10 Jan 2019 18:42:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BOFm8bVcZ3AE; Thu, 10 Jan 2019 18:42:02 +0100 (CET)
Received: from belphegor.brq.redhat.com (nat-pool-brq-t.redhat.com [213.175.37.10])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 4FCF01002E1;
        Thu, 10 Jan 2019 18:42:02 +0100 (CET)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/7] Add support for XO 1.75 to OLPC battery driver
Date:   Thu, 10 Jan 2019 18:39:58 +0100
Message-Id: <20190110174005.1202564-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch set modifies the OLPC battery driver so that it could eventual=
ly
be used on an Arm-based OLPC XO 1.75 machine once the Embedded Controlled
driver gets merged.

It has been split off from the EC driver patch set after four re-spins.

Tested on an OLPC XO 1. I don't have a XO 1.5, but it's similar enough.

[1/7] dt-bindings: olpc_battery: Add XO-1.5 battery
[2/7] x86, olpc: Use a correct version when making up a battery node
[3/7] power: supply: olpc_battery: Use DT to get battery version
[4/7] power: supply: olpc_battery: Move priv data to a struct
[5/7] power: supply: olpc_battery: Use devm_power_supply_register()
[6/7] power: supply: olpc_battery: Avoid using platform_info
[7/7] power: supply: olpc_battery: Add OLPC XO 1.75 support

Appart from the dt-bindings patch, the patches need to be applied in orde=
r.

Lubo


