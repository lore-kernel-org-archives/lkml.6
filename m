Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08B9C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716F4223A4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:13:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716F4223A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934702AbeGFTNE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:13:04 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:33666 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932751AbeGFTNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:13:02 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 503C090024;
        Fri,  6 Jul 2018 22:13:01 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 322052206AD; Fri,  6 Jul 2018 22:12:59 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 2AC58220307;
        Fri,  6 Jul 2018 22:12:59 +0300 (EEST)
Date:   Fri, 6 Jul 2018 22:12:59 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
Subject: HH DL585 warm boot fail (old)
Message-ID: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a first gen HP Proliant DL585 ("G1" but the name was not used 
back then) that boots up fine from poweron but usually fails bootup from 
warm reboot, somewhere in PCI detection (will try to photographs the 
screen some time).

I just stumbled upon an old OpenSolaris thead about the same DL585 and 
same symptoms: 
http://opensolaris-discuss.opensolaris.narkive.com/T0UTXYGZ/solaris-10-06-06-x86-hp-dl585-boot-hang-aftrer-reboot-help

Their conclusion was the wfollowing and they seem to have found a fix 
(although I have not tested any version of Solaris on this DL585 
myself):

"The hang is caused when, during PCI enumeration, a PCI-PCI bridge is 
partially disabled when the PCI command register bits which enable IO 
and memory windows are cleared."

Is this information useful in some way for debugging it?

What else besides screenshot of the can be useful in debugging?

-- 
Meelis Roos (mroos@linux.ee)
