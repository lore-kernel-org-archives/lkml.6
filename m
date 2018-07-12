Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7987C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F80208E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 04:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0+UtpTz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F80208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeGLESe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 00:18:34 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44824 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbeGLESe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 00:18:34 -0400
Received: by mail-qt0-f193.google.com with SMTP id b15-v6so23038344qtp.11;
        Wed, 11 Jul 2018 21:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+IKdtuWkNqzwDQqXuQsEADiThUrOkLcMxed/2zaFQ84=;
        b=i0+UtpTzCwK1IJtZI0ZyNoY6BmYQSuKdobzkPY4gdnBHfBD37WM9HMNrJ5y/FcfzsD
         k/RSUEb2TTPXN29izI49Jpb7mzhhJJ271j9zMUOFqnUBY1j4DhYBwN/8mHy2+5HSTQc/
         bYafSJv74Ot6JOC4LFSWn1vzbbnt/hgAswZ/QStRWz/8dqfxynIEIbuQAbTxcXD/+t52
         EwMORfOClKaJRhNs6cRA+hOfVIkxwse5nhaNsiXao/pxAsSShrQNdmWEeP45mAyyWzpC
         IGLgdKYt9PkPkexwOtNAJViNo/+1jNdI6qAasCB5KqX8rGcEMpmBKIy2iXkiiAj/abK0
         MzXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+IKdtuWkNqzwDQqXuQsEADiThUrOkLcMxed/2zaFQ84=;
        b=RTGfh0lpiFRefOiIK2PVjMD845pPVNUS9NQ5rJ2Y2JYcz6/PlKXnR3nxm0BIKVIE/e
         tiIj9UfgZlixsV2LVIYoW2jfRga+gvB+y/AoydBavLIbkBg+8z6tcdB4hrpjdT/nU1kl
         DuzDmDj0uz+c/4ryRrzXPfEjlSh4Juda8UnmWJqWQU/PFyVBD1MuvyL0Nt48G6TFVEt5
         Dt1HKLymjHIQUwbMnUnbMRxYuKj7oruzDX54sotdmYTm/XRbdCY8kVDlRMw/34PL+vd3
         Z2cb1VprVM93Qac7ijF9Tqg0Pia5i4+oo8YEnVmYIM4+5+IUi+almgtkOLwi0nY6H0mw
         UIOQ==
X-Gm-Message-State: AOUpUlHY2YAbM2tKcT9cJxqDoxOE+OtL2OqM5FnVx7SLX69JbmOvMxPa
        RCCmKAV1isuwlxeSSECcvPw=
X-Google-Smtp-Source: AAOMgpe6pSfkVuY0R5J1E6SNByV1z6LhHDJBHAJmkBcE/oroXZntccRkPMLcTMt880xZmIDk3Rn2XQ==
X-Received: by 2002:aed:2518:: with SMTP id v24-v6mr480834qtc.151.1531368654220;
        Wed, 11 Jul 2018 21:10:54 -0700 (PDT)
Received: from localhost.localdomain (186-106-119-105.baf.movistar.cl. [186.106.119.105])
        by smtp.gmail.com with ESMTPSA id m51-v6sm7260115qtc.85.2018.07.11.21.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 21:10:53 -0700 (PDT)
From:   Luis Araneda <luaraneda@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Luis Araneda <luaraneda@gmail.com>
Subject: [PATCH v3 3/6] dt-bindings: xilinx: zynq: Improve boards description
Date:   Thu, 12 Jul 2018 00:10:21 -0400
Message-Id: <20180712041024.20583-4-luaraneda@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712041024.20583-1-luaraneda@gmail.com>
References: <20180712041024.20583-1-luaraneda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the description of some boards to make it similar
to the value of the model property from their respective
device-tree, using the format "<manufacturer> <model>"

Signed-off-by: Luis Araneda <luaraneda@gmail.com>
---
 Documentation/devicetree/bindings/arm/xilinx.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
index b9043bc35c14..4f1759b2bea7 100644
--- a/Documentation/devicetree/bindings/arm/xilinx.txt
+++ b/Documentation/devicetree/bindings/arm/xilinx.txt
@@ -8,10 +8,10 @@ Required root node properties:
 
 Additional compatible strings:
 
-- Xilinx internal board cc108
+- Xilinx CC108 internal board
   "xlnx,zynq-cc108"
 
-- Xilinx internal board zc770 with different FMC cards
+- Xilinx ZC770 internal board, with different FMC cards
   "xlnx,zynq-zc770-xm010"
   "xlnx,zynq-zc770-xm011"
   "xlnx,zynq-zc770-xm012"
-- 
2.18.0

