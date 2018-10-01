Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E679C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B68208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qc82TaN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57B68208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbeJAVUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 17:20:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46126 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729497AbeJAVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 17:20:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so2964037pfb.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ul6QiBbxV5z2pPTYYzanuJHWLEHmZoMcjEANN/U8PPc=;
        b=Qc82TaN5KE7nDqBjpZTmKYoI54g3YVnJTTmmrbUaPGZfib4luJ7XoRBxWTWZaJO2BI
         e9YNAybKYBh/zalF8UDgRlP3aq26S7efbY/K5fxKwE8+Y6cyP5KWeuB9nGgARp0LL6uK
         Ad7mBOb9h+2SyKLFOJUOYUErP43TRavl4vj07wf1CgAVN58Ae4YymlbAGdYyyk0jPRAe
         WQHC1asa08GuDxWV9/RLqQ0DfDJ9HeCoCvBBX5OuuGO4r7lfbZ6+9sulYe1VlvJ8+dXS
         rdlPRzvgNB1UkYpU4nbH2BX+jxltuqPqwTyCmQynMgharVKPE5YmRTuzmnc7NIjSPvP/
         +TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ul6QiBbxV5z2pPTYYzanuJHWLEHmZoMcjEANN/U8PPc=;
        b=ZZd+gvLV7Sz04ZPgRRYpBaHJ11tPyTgJS2IAqxQ57sBVdBbzpL/qg+ChQzPppYWkuB
         TXf2RPQNiqyctInWCwzZGpqITk8NaQdrJvc3mLvSr0y8Db+yD8AZWbjlmTkF7yguZ9PP
         QhoRTnYs56nkkVyRH3J5hbaQDrhDF6fGVKjnsvoWWHJ7+DoqvrJeTnFKuu3dYmhZmnkp
         C9wadVzIDWDawuZHxQ/akRtowlHTqHb8FAaYnWohFHyH1sO5ESOhFd8E7hdIz04tT/Qe
         UpnhjIZAQwLyEY1HYY18GDp2CI/FAGlKhhLroD+eZu1dcyS5VS0UEaxgmh82qL+YWx0u
         uQeQ==
X-Gm-Message-State: ABuFfoge+xBp1QN0Wvo7yVMa44r8ALoOBMuLmKdahhZs69Wvg6Q8uWVX
        mlCgCJG7lZZyo0hUbK76hSBLTDM/oJk7gg==
X-Google-Smtp-Source: ACcGV60BCZb0pjyfQcwtbNcH5QzGyG+uN+DJuumHHqcWIW/JhflcD5w1lnbR9CGko1mQWEbPoXlt5w==
X-Received: by 2002:a62:9316:: with SMTP id b22-v6mr4939957pfe.193.1538404949231;
        Mon, 01 Oct 2018 07:42:29 -0700 (PDT)
Received: from nishad ([106.51.27.228])
        by smtp.gmail.com with ESMTPSA id 84-v6sm26484132pfs.108.2018.10.01.07.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 07:42:28 -0700 (PDT)
Date:   Mon, 1 Oct 2018 20:12:22 +0530
From:   Nishad Kamdar <nishadkamdar@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>
Cc:     NeilBrown <neil@brown.name>, devel@driverdev.osuosl.org,
        Christian =?utf-8?Q?L=C3=BCtke-Stetzkamp?= <christian@lkamp.de>,
        linux-kernel@vger.kernel.org, John Crispin <blogic@openwrt.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v5 0/3] Remove #if 0 blocks and fix macros
Message-ID: <cover.1538402548.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset removes #if 0 blocks and removes single statement
macros.

Changes in v5:
  - Split the patch in three different patches.
  - The first patch removes #if 0 blocks.
  - The second one removes msdc_irq_restore() macro.
  - The third one removes other unused macros. 
Changes in v4:
  - Removed #if 0 code blocks and usages of functions defined
    in the #if 0 blocks in dbg.c and dbg.h
Changes in v3:
  - Remove the #if 0 code blocks and usages of the functions
    defined in the #if 0 code block.
  - Delete msdc_irq_restore() and replace its usage directly
    with call to the function being called by the macro.
Changes in v2:
  - Convert msdc_gate_clk() and msdc_ungate_clk() to inline functions.
  - Delete msdc_irq_restore(), msdc_vcore_on(), msdc_vcore_off(),
    msdc_vdd_on() and msdc_vdd_off() and replace their usages directly
    with calls to the function being called by these macros.

Nishad Kamdar (3):
  staging: mt7621-mmc: Remove #if 0 blocks
  staging: mt7621-mmc: Remove single statement macro msdc_irq_restore()
  staging: mt7621-mmc: Remove unused single statement macros

 drivers/staging/mt7621-mmc/dbg.c |  21 +--
 drivers/staging/mt7621-mmc/dbg.h |  14 --
 drivers/staging/mt7621-mmc/sd.c  | 304 +------------------------------
 3 files changed, 2 insertions(+), 337 deletions(-)

-- 
2.17.1

