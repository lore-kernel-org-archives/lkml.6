Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0B2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B84924347
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84924347
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934258AbeFZJYx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:24:53 -0400
Received: from osg.samsung.com ([64.30.133.232]:50701 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933291AbeFZJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:24:47 -0400
Received: from localhost (localhost [127.0.0.1])
        by osg.samsung.com (Postfix) with ESMTP id 36FEA30B39;
        Tue, 26 Jun 2018 02:24:46 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at dev.s-opensource.com
Received: from osg.samsung.com ([127.0.0.1])
        by localhost (localhost [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ilWt8d4QgfxI; Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from smtp.s-opensource.com (177.41.130.70.dynamic.adsl.gvt.net.br [177.41.130.70])
        by osg.samsung.com (Postfix) with ESMTPSA id 9EFA930B26;
        Tue, 26 Jun 2018 02:24:44 -0700 (PDT)
Received: from mchehab by smtp.s-opensource.com with local (Exim 4.91)
        (envelope-from <mchehab@smtp.s-opensource.com>)
        id 1fXkDJ-0000XV-U4; Tue, 26 Jun 2018 06:24:41 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org
Subject: [PATCH 0/4] Fix a broken/missing documentation at sound
Date:   Tue, 26 Jun 2018 06:24:36 -0300
Message-Id: <cover.1530004939.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After running ./scripts/documentation-file-ref-check I noticed that it
was complaining about the lack of a MultiSound file that used to be
inside the old OSS sound system.

That's actually a script, with seems to be needed in order to make
the multisound driver to work. Also, it contains some instructions
about how to use the module.

Granted, this is old ISA stuff, but, as long as the driver remains in
Kernel, it probably makes sense to keep the script somewhere.

So, this patch restores the file from the git log, moving it to an
existing directory and updates the module names. 

It also fixes the script, as it has some issues that prevents it to work
with modern distributions (basically, include stuff at C files it
produces).

-

Please notice that I don't have such hardware to test. So, I have no 
means to know if the produced exec file still makes sense.

Mauro Carvalho Chehab (4):
  sound: restore MultiSound script
  alsa: multisound.sh: fix script to make it build with modern tools
  alsa: multisound.sh: update module namespace
  alsa: Fix references to Documentation/.*/MultiSound

 Documentation/sound/alsa-configuration.rst |    2 +-
 Documentation/sound/cards/multisound.sh    | 1139 ++++++++++++++++++++
 sound/isa/Kconfig                          |    2 +-
 3 files changed, 1141 insertions(+), 2 deletions(-)
 create mode 100755 Documentation/sound/cards/multisound.sh

-- 
2.17.1


