Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E17C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 253B521916
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 22:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549579856;
	bh=tK724BhYJI1b1ug6ERi3UiJ9FRi1HttrSLDyqGnwFgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pXkfgExXUfcLgPKsQ2G102Er3qWSGxd8/MDLLdfIjOOX66QXReFCeR+nF+2ggkhfe
	 efnHZ2Kw7ISJuL29iJ2R2NqAwg7Cy8kfBdePZjUqQagqGuL+HVHwzMhExxfiy5/Na5
	 IUIMT/0/y8rz/a0TrNjEIUjOs2C7ZU7hQip9qPFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfBGWuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 17:50:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51307 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727058AbfBGWuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 17:50:51 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F25D721F49;
        Thu,  7 Feb 2019 17:50:50 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 07 Feb 2019 17:50:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=2PLl/V120Makw5/D9oj8o1udfl+b3JNvXdyz9y+DaR0=; b=5gsJr4Fn
        1LUW0R9O2N9hb/flq7PqxE+/Bo5+NqsKKr2RDzt7Twg8QLUMwdA7/9uMQXSwbWaT
        vvApyvUv8MB93LCh99dclEzn25zXpa0QC6DFRPRK7GFNvhdk7Hw4YWtXUmrouOSC
        LUtqP6uxgwFONrnTS+WsLSDK9/31DEKOclXbBf89Vz4g0MCwIy1hfNeXyQhxuqdH
        qqnNGcOZIgO2zlafIa3QWSayrW/vA+9Kq5uStm48JkKjtyBAvM8JNbC2a0IZtdnE
        3EFDSxOIu+bPOSm+ccLsPkIHs2HZP6aDJnMXv7HUuJolpC25B+7mb3buGN0hcS1G
        nNhorXyrt7GGgw==
X-ME-Sender: <xms:SrZcXFxMFEjwZ0RWMNhNBb_fEj_YJITaCMzLBtVSSQvUcauINMPPmw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrledugddtudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojg
    hfggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhg
    fdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppeduvddurdeggedrudelle
    druddtleenucfrrghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:SrZcXGrCKXz1azCD54qTnudAbDXnZU-kw7KHTsltPNCOktILfq2J-g>
    <xmx:SrZcXInC4SMCvGQScErvSNh1hohlw5xWs8aXjiXhAJxyNqegeESXpw>
    <xmx:SrZcXPygKUR1eis9oWIgKlnZp73RcfgtMQB2cXwE8Zcl7c48EBfUUg>
    <xmx:SrZcXA4Tb4Nv_zRyCTPmLcl5yPNR8hIlbxomh9SvpFCvXUx7X6u9ZQ>
Received: from eros.localdomain (ppp121-44-199-109.bras1.syd2.internode.on.net [121.44.199.109])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1292AE41F3;
        Thu,  7 Feb 2019 17:50:48 -0500 (EST)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     kernel-hardening@lists.openwall.com
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] leaking_addresses: Completely remove --version flag
Date:   Fri,  8 Feb 2019 09:50:25 +1100
Message-Id: <20190207225026.11723-3-tobin@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190207225026.11723-1-tobin@kernel.org>
References: <20190207225026.11723-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently attempt to remove the '--version' flag was made, badly.  I
failed to remove mention of it from the help output.  And also I failed
to actually remove the flag from the options list.

_Completely_ remove --version flag.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 scripts/leaking_addresses.pl | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
index 214c12be8c86..ef9e5b2a1614 100755
--- a/scripts/leaking_addresses.pl
+++ b/scripts/leaking_addresses.pl
@@ -97,7 +97,7 @@ Options:
 	--32-bit			Scan 32-bit kernel.
 	--page-offset-32-bit=o		Page offset (for 32-bit kernel 0xABCD1234).
 	-d, --debug			Display debugging output.
-	-h, --help, --version		Display this help and exit.
+	-h, --help			Display this help and exit.
 
 Scans the running kernel for potential leaking addresses.
 
@@ -108,7 +108,6 @@ EOM
 GetOptions(
 	'd|debug'		=> \$debug,
 	'h|help'		=> \$help,
-	'version'		=> \$help,
 	'o|output-raw=s'        => \$output_raw,
 	'i|input-raw=s'         => \$input_raw,
 	'suppress-dmesg'        => \$suppress_dmesg,
-- 
2.20.1

