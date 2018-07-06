Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7FC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8565B2409E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8565B2409E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932448AbeGFFZr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:25:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45685 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932197AbeGFFZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:25:46 -0400
Received: from 162-237-133-238.lightspeed.rcsntx.sbcglobal.net ([162.237.133.238] helo=sec.l.tihix.com)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <tyhicks@canonical.com>)
        id 1fbJFX-0001Jc-VX; Fri, 06 Jul 2018 05:25:44 +0000
From:   Tyler Hicks <tyhicks@canonical.com>
To:     John Johansen <john.johansen@canonical.com>
Cc:     James Morris <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>,
        Seth Arnold <seth.arnold@canonical.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix AppArmor issues found through static analysis
Date:   Fri,  6 Jul 2018 05:24:59 +0000
Message-Id: <1530854701-7348-1-git-send-email-tyhicks@canonical.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set fixes three issues, discovered by CoverityScan, that I don't
believe are serious in practice but are worth fixing to make the
AppArmor code more robust and prevent them from becoming more serious
issues in the future. The first patch fixes possible out of bounds
access issues when mapping a permissions mask to a string. The second
fixes an uninitialized struct that could have some of its contents
leaked to userspace during a permissions query.

I've tested the patches with the AppArmor regression test suite. The
test results are the same with and without these patches applied. There
are identical failures, in both situations, from the aa_policy_cache
test but that's likely due to some unrelated, recent changes in the
AppArmor userspace code.

Tyler

