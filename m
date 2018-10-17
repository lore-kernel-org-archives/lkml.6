Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF0CC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 783A3205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 06:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 783A3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbeJQOjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:39:37 -0400
Received: from mout.gmx.net ([212.227.15.18]:44809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727080AbeJQOjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:39:37 -0400
Received: from ls3530.fritz.box ([92.116.170.8]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1g31631C9F-00Rs4A; Wed, 17
 Oct 2018 08:45:26 +0200
Received: from ls3530.fritz.box ([92.116.170.8]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MSutp-1g31631C9F-00Rs4A; Wed, 17
 Oct 2018 08:45:26 +0200
Date:   Wed, 17 Oct 2018 08:45:24 +0200
From:   Helge Deller <deller@gmx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [GIT PULL] parisc fix for kernel v4.19
Message-ID: <20181017064524.GA32311@ls3530.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Provags-ID: V03:K1:agnyE2tEAjwf21H7L4Wg42dar5NU3POWv75puAwdgfV55MxeFq4
 Nuqgc//VnjISPqmBLGNjDwCTx+y1tM3a6T4j3F35A2lw3RIp52GuvFjz/wIBzPliaXJn+dJ
 lb68Tqfwklw4cJrbtNCLScCdtnhUOUSAFFTu9MFAAz+qr7VkI20HvucCKAMnYxuUUoc2PFG
 HpnNqogfr92Nn381Vcraw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ta1n/7XYAHg=:rSF9lyqLgR2zkHC6aHNgfq
 jCKKnV5xvyT7XdW5fjMOFbGh13RhYZEifo7eqlBU1w22sGGmBm/zEnvkFq2HDIL+LM0KYaIIL
 /Pvxbjod4pMzJ0x8VL/jpvB6fV/QrWHd/GO6hWkk0cGIjfBbOhcsFMLjSFxlDVKZQ8jcjeozZ
 LSlL/+n1XIE/0rC5rBGIAF9klCIYPtOWpJSSxsUZX4NSb/bYZ31JWD0on7gWmW3b7nc7peloy
 XWKgT3M4iJJesihhEKMW4XrxNuIDyquNEeCDdN7rEPdWcZ5cKL+ZpI4uBegHUCoTsd+G0vXY0
 j925HT398Hsc/OYQOgkV3LYaVmr9eaUKoVorv6ze5Pg7skTfEUjqTLqZw7Kb7G0NZ7gmTCHfW
 vlrMIlQAONkDwAXh21U2jDUeJdtMtpCrUMGUlRuEK2Sf+fnr+Y1gd7+FGNPIsgIEAT049CK0u
 WDtocfKjsrvZevmPpUOupOzRZfXuu6ZnXRTgV+loZ+wdZ6lHPejedN3eRQO53X1bNPiCVySRI
 vlaqdQ3nrwOFJ8KOX38ff4txbprPyJaPiK4y+H0pTgMinVXXDHrXqcsMzMVPTknA5oSQtZ26E
 F57TspIK062oisfSY9BeTOzJL0M+OzQXyXH2BlV5iymmKGwlULfauAGAXNOu83g4UP0UBstNp
 avujsX3nctMRTJwFfs5EWjLKMUCftsbUV9o7JaU9I9FXBJrJEiwkUYQI3Bcw+i2drWhu5fS6s
 Rj1+ORYxaCwLUWwL4/Q3ssL3HIznpXc0LQwaUSItrqhKf3Kd1dlfJM2txKH/tsO0IzwTcrXj4
 nAkLYL+ZMnGHHr3Ojr7+InvaBdFgw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

would you please include the trivial patch below for 4.19?
My older cross-compiler didn't complained, so it went unnoticed for me until
now and the faulty code was added during the 4.19 merge window.

It can be pulled from my git tree as well:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git parisc-4.19-3

Fix an unitialized variable usage in the parisc unwind code.

Thanks,
Helge

----------------------------------------------------------------
Helge Deller (1):
      parisc: Fix uninitialized variable usage in unwind.c

 arch/parisc/kernel/unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


----------------------------------------------------------------

From: Helge Deller <deller@gmx.de>
Date: Tue, 16 Oct 2018 08:21:48 +0200
Subject: parisc: Fix uninitialized variable usage in unwind.c

As noticed by Dave Anglin, the last commit introduced a small bug where
the potentially uninitialized r struct is used instead of the regs
pointer as input for unwind_frame_init(). Fix it.

Signed-off-by: Helge Deller <deller@gmx.de>
Reported-by: John David Anglin <dave.anglin@bell.net>

diff --git a/arch/parisc/kernel/unwind.c b/arch/parisc/kernel/unwind.c
index f329b466e68f..2d14f17838d2 100644
--- a/arch/parisc/kernel/unwind.c
+++ b/arch/parisc/kernel/unwind.c
@@ -426,7 +426,7 @@ void unwind_frame_init_task(struct unwind_frame_info *info,
 			r.gr[30] = get_parisc_stackpointer();
 			regs = &r;
 		}
-		unwind_frame_init(info, task, &r);
+		unwind_frame_init(info, task, regs);
 	} else {
 		unwind_frame_init_from_blocked_task(info, task);
 	}
