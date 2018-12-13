Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3460C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 818EA2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 08:47:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 818EA2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=orcon.net.nz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbeLMIrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 03:47:07 -0500
Received: from smtp-2.orcon.net.nz ([60.234.4.43]:56038 "EHLO
        smtp-2.orcon.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeLMIrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 03:47:06 -0500
X-Greylist: delayed 1251 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Dec 2018 03:47:06 EST
Received: from [121.99.228.40] (port=12898 helo=tower)
        by smtp-2.orcon.net.nz with esmtpa (Exim 4.86_2)
        (envelope-from <mcree@orcon.net.nz>)
        id 1gXMJx-0006YS-O0; Thu, 13 Dec 2018 21:26:13 +1300
Date:   Thu, 13 Dec 2018 21:26:12 +1300
From:   Michael Cree <mcree@orcon.net.nz>
To:     linux-alpha@vger.kernel.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Generic kernel fails to boot on Alpha bisected to b38d08f3181c
Message-ID: <20181213082612.bi2dcd6uhzp3t6iq@tower>
Mail-Followup-To: Michael Cree <mcree@orcon.net.nz>,
        linux-alpha@vger.kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-GeoIP: NZ
X-Spam_score: -2.9
X-Spam_score_int: -28
X-Spam_bar: --
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A kernel built for generic UP Alpha had been noted to fail to boot
for quite some time (since the release of 3.18).  The kernel either
locks up before printing any messages to the console or just falls
back into the SRM with a HALT instruction again before any messages
are printed to the console.  A work around is to either use a kernel
built for generic SMP or to build a machine specific kernel as these
boot correctly.

Because there were other compile errors at the time it proved
difficult to bisect, but we are continuing to get complaints about
it as it renders the Debian Alpha installer somewhat useless, so I
returned to trying to find the problem and managed to bisect it to:

commit b38d08f3181c5025a7ce84646494cc4748492a3b
Author: Tejun Heo <tj@kernel.org>
Date:   Tue Sep 2 14:46:02 2014 -0400

    percpu: restructure locking

Any suggestions as to what might be the problem and a fix?

Cheers,
Michael.
