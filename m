Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43553C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF2B220862
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 00:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ab07OqSN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF2B220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732257AbeHBCmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 22:42:08 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37158 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730431AbeHBCmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 22:42:07 -0400
Received: by mail-qt0-f194.google.com with SMTP id n6-v6so550724qtl.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 17:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EaMsRMnPbdN9XzgYzXY6VXWamivpWZRby7r92p5UiuU=;
        b=ab07OqSN006xvtkPRBGIMAAgoelraGLnEJnnHEmXm7aLn1CnA6uTepY9ihKe1UAYe6
         1bvYBYzHuSpansOz4t/wcPv/2la+/aVdUZxyQU9qEReogCviGhyC+fdyAsPxoto1Wrgg
         N2sufjzts08JzNdhn4S7671fIeVgkkQnyf220=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EaMsRMnPbdN9XzgYzXY6VXWamivpWZRby7r92p5UiuU=;
        b=CDbKsAcpXEr+FX7JfJ586LniaFFbyzfeB33iq3+kLSP1hwGyA05qc2cPVCSG3ypl2U
         VUVN/bNUqaoxI5KEGhHkgNIPa4htngSEYSkvmRVSS2gbWjYSNDRxwRHmtjYHh37VOyht
         76VRBCULiFrdRScMcaggPWLCinz2Wn44GqN8M20nfBCUkzoVe5FXLltSw7jcySmmZ1XH
         w8962mDH1/ngoCnqh/jdjmBfPkX0bjSeKiR0zsbo0ngDgVD6U33kH3ytmBuG4caMhJ7a
         fzH2ubG6jVdj35IfA3q3YraY6kwZnd7W7nRxF9ejZUoE7TSvhyFkZHcpMeVoEBB99xCk
         WY2w==
X-Gm-Message-State: AOUpUlHKp5Xe7gO7LlVF0Yt9Ng/Q40N9fvrDe5SeloK8SxzcXS3RPfcq
        AwOyJu3xDFQrGl92XDNyih5inQ==
X-Google-Smtp-Source: AAOMgpcOEuabOXnFXswqUIStlgufFbjc2ie9+uy03xiVlUE64lajtn4bRHg6s0LVrZhqmtCOAqsJKw==
X-Received: by 2002:ac8:35c8:: with SMTP id l8-v6mr601444qtb.409.1533171217469;
        Wed, 01 Aug 2018 17:53:37 -0700 (PDT)
Received: from lbrmn-lnxub86.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id e81-v6sm325116qka.3.2018.08.01.17.53.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 17:53:36 -0700 (PDT)
From:   Arun Parameswaran <arun.parameswaran@broadcom.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Arun Parameswaran <arun.parameswaran@broadcom.com>
Subject: [PATCH v4 0/8] Add clock config and pm support to bcm iProc mdio mux
Date:   Wed,  1 Aug 2018 17:53:45 -0700
Message-Id: <1533171233-14557-1-git-send-email-arun.parameswaran@broadcom.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The patchset is based on David Miller's "net-next" repo.

The patchset extends the Broadcom iProc mdio mux to add support for
suspend/resume and the ability to configure the internal clock
divider. The patchset also sets the scan control register to
disable external master access.

The base address of the mdio-mux-bcm-iproc is modified to point to the
start of the mdio block's address space, to be able to access all the
mdio's registers. The missing registers are required to configure the
internal clock divider registers in some of the Broadcom SoC's.

Changes from v3:
 - Removed 'platform_set_drvdata(pdev, NULL)' call (in patch 5/8)
 - Fixed the return code handling for the devm_clk_get() call (in patch
   7/8)
 - Added Reviewed-by tag to Patch 8/8

Changes from v2:
 - Addressed Andrew's comments:
     - Moved to using devm_mdiobus_alloc. Added this as a separate patch.
     - Changed to reverse christmas tree order for variable declaration in
       the clock patch
 - Addressed Florian's comments:
     - Removed null checks for the clock before calling unprepare in
       both clock and pm patches.
     - Added check for EPROBE_DEFER when fetching the clock in the clock
       patch.
 - The patch to use the devm API has been added before the clock & pm
   patches. This patch is now patch '5' in the series.
 - Added reviewed-by tags to commit messages of patches which remain
   unmodified from v2.
 - Modified PM patch to use platform_get_drvdata() in suspend/resume
   API's, similar to the recent fix that went in for the remove()
   api.

Changes from v1:
 - Addressed Andrew's comments.
   - Reworked the patches to be based on 'net-next'
   - Removed 'fixes' from the commit messages, the changes are related
     to the new features being added.
   - Maintained backward compatibility to older dt-blob's specifying
     base addresse with an offset. The correction is applied in the
     driver and a message is printed to update the dt-blob.
   - Re-worked and re-ordered the last four patches (4-7).
     - Added setting of the scan control register as a new patch
     - Added a call to 'clk_prepare_enable()' in the patch that adds
       the clock config support, removed the debug message when clock
       is not passed.
     - Simplified the pm support patch (removed the array used for the
       save/restore logic).

Thanks

Arun Parameswaran (8):
  dt-bindings: net: Fix Broadcom iProc mdio mux driver base address
  net: phy: Fix the register offsets in Broadcom iProc mdio mux driver
  arm64: dts: Fix the base address of the Broadcom iProc mdio mux
  net: phy: Disable external master access in bcm mdio mux driver
  net: phy: Use devm api for mdio bus allocation in bcm iproc mdio mux
  dt-bindings: net: Add clock handle to Broadcom iProc mdio mux
  net: phy: Add support to configure clock in Broadcom iProc mdio mux
  net: phy: Add pm support to Broadcom iProc mdio mux driver

 .../bindings/net/brcm,mdio-mux-iproc.txt           |   7 +-
 arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi   |   4 +-
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |   4 +-
 drivers/net/phy/mdio-mux-bcm-iproc.c               | 108 ++++++++++++++++++---
 4 files changed, 106 insertions(+), 17 deletions(-)

-- 
1.9.1

