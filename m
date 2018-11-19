Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D80C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C006206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7IDVX7+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C006206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389547AbeKTDNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 22:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:49566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387988AbeKTDNB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 22:13:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF547206BA;
        Mon, 19 Nov 2018 16:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542646129;
        bh=5xvGvVor5kp5vzGZAcDC+zzsAlFmCw4tdJJu8p2hwUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d7IDVX7+5/6LTMRjcfjJufJSygf283XJmcgJrii0HSyZDABBGZtu3XcUnWiC7OjuB
         mIC0HB5APY/iAJH0GY/vS6XvzH2JUVwCuxiSGDHMKWU5M6CJNcih5i9egY9ZL2cYGa
         yDNOSvWDzv/XVVka7mr026Yw5+yMbmxmRjjIFoOY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Anholt <eric@anholt.net>,
        Allen Wild <allenwild93@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 048/124] thermal: enable broadcom menu for arm64 bcm2835
Date:   Mon, 19 Nov 2018 17:28:22 +0100
Message-Id: <20181119162622.991675706@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162612.951907286@linuxfoundation.org>
References: <20181119162612.951907286@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Allen Wild <allenwild93@gmail.com>

commit fec3624f0bcdb6b20ef9ccf9d9d55d0d75d776f8 upstream.

Moving the bcm2835 thermal driver to the broadcom directory prevented it
from getting enabled for arm64 builds, since the broadcom directory is only
available when 32-bit specific ARCH_BCM is set.

Fix this by enabling the Broadcom menu for ARCH_BCM or ARCH_BCM2835.

Fixes: 6892cf07e733 ("thermal: bcm2835: move to the broadcom subdirectory")
Reviewed-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Allen Wild <allenwild93@gmail.com>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/thermal/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thermal/Kconfig
+++ b/drivers/thermal/Kconfig
@@ -408,7 +408,7 @@ config MTK_THERMAL
 	  controller present in Mediatek SoCs
 
 menu "Broadcom thermal drivers"
-depends on ARCH_BCM || COMPILE_TEST
+depends on ARCH_BCM || ARCH_BCM2835 || COMPILE_TEST
 source "drivers/thermal/broadcom/Kconfig"
 endmenu
 


