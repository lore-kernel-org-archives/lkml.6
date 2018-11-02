Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034A7C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0AA2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 10:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0AA2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKBUEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:04:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:57364 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeKBUEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:04:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id ED7BBACF9;
        Fri,  2 Nov 2018 10:57:53 +0000 (UTC)
Date:   Fri, 2 Nov 2018 11:57:49 +0100
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for 4.20, part 2
Message-ID: <20181102105749.GA16067@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

as promised here

  https://lkml.kernel.org/r/20181025073832.GA13240@nazgul.tnic

here's the second part of the EDAC pile which contains the ADXL user
and a build fix which addresses a not-so-sensical .config but fixes
randconfig builds people do.

Please pull,
thanks.

---
The following changes since commit 36168d7123311d52e085c116f6c66e16f0b84615:

  Merge tag 'edac_for_4.20' of git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp (2018-10-25 06:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tags/edac_for_4.20_2

for you to fetch changes up to a324e9396ca3d00e1101476ba067b412e0aba232:

  EDAC, skx: Fix randconfig builds (2018-10-31 19:24:21 +0100)

----------------------------------------------------------------
* skx_edac: Address translation for NVDIMMs (Tony Luck and Qiuxu Zhuo)

* ACPI_ADXL build fix

----------------------------------------------------------------
Borislav Petkov (1):
      EDAC, skx: Fix randconfig builds

Qiuxu Zhuo (1):
      EDAC, skx_edac: Add address translation for non-volatile DIMMs

 drivers/edac/Kconfig    |   1 +
 drivers/edac/skx_edac.c | 193 ++++++++++++++++++++++++++++++++++++++++++++----
 include/linux/adxl.h    |   5 ++
 3 files changed, 186 insertions(+), 13 deletions(-)


-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
