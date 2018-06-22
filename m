Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2220BC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE63523DE4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 06:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GjxyuNMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE63523DE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751313AbeFVGma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 02:42:30 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:34967 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750865AbeFVGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 02:42:28 -0400
Received: by mail-wr0-f180.google.com with SMTP id y12-v6so512526wrs.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 23:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8bc+MtI/hHSh62WX5/kM6C3xNRmCY/IUl4Pi0zcMnY8=;
        b=GjxyuNMin7Fac5TUTcecQyzjN14pQEseLc9hgObn67XangBWVoj5gRvVyKCwk83pDT
         GuOvt9/2DOgtmDcf5qWu15Ryb1pJqCKbxQOGdqDjFRbbWl3j3eu3HKJyAmCyzGv6kqgd
         Yhr01i1Zxmoe7WfvbyS7VF7JrKnD+mgN4Brys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8bc+MtI/hHSh62WX5/kM6C3xNRmCY/IUl4Pi0zcMnY8=;
        b=VNFw/IiDuYWY6qNuZ5NcE7I/6WgJ+R5dOxw+5BWLiEZBQU1trs/HGp+46MB7PjFKsH
         jGMLvIbr86NrdRmP7OeucDhqR2qzGivGwLyZmzt+4v1KYrRH8Hib+eQzOB3Afniusmtj
         TNVF0ukCUVX9fzPGmksBILCyPO1BVl9zlIztOSSLJHRbVrjmkqU8RUhaW2PWnYAP/NFn
         9dDZ5dwL8dU88H0c/ctrta9v+ig1ZwLlKp/lOqCOLSH5+552d4mdvHwwFS4nQqgUEEP8
         Bks9+pl+gNNzYIPcT6PvoYxThVc7rhLhPq32BoyN7xsOBPOv+Qt2fazpOcr0F/zVMrIF
         lpoQ==
X-Gm-Message-State: APt69E1KgeeXprOPdvgxr2qPQIbvisxprmU6x7k6U9r6j2+Z+KBSU/bU
        MMobwLeRc3GXLcHey2r0BFUG/KSujCE=
X-Google-Smtp-Source: AAOMgpc7XLnvSHUEPL/UzVWKXjcmy6ZhcWc5fjSTT8SbK2Wj4Jtat7VlPo8Is3haD6IgvttKhfkEJw==
X-Received: by 2002:adf:a9b3:: with SMTP id b48-v6mr380352wrd.159.1529649747292;
        Thu, 21 Jun 2018 23:42:27 -0700 (PDT)
Received: from dogfood.home ([2a01:cb1d:112:6f00:d0d9:3abb:8cc4:581c])
        by smtp.gmail.com with ESMTPSA id h77-v6sm1627156wmd.9.2018.06.21.23.42.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 23:42:26 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL 0/1] EFI fix for v4.18
Date:   Fri, 22 Jun 2018 08:42:21 +0200
Message-Id: <20180622064222.11633-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:

  Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent

for you to fetch changes up to 9cd00e314dee25f9b2e2c47759988cb353165011:

  efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode (2018-06-22 08:36:20 +0200)

----------------------------------------------------------------
EFI fix for v4.18:
- initialize some efi_physical_addr_t variables to 0 so that buggy 32-bit
  TPM UEFI code that only sets the lower 32 bits will work as expected.

----------------------------------------------------------------
Hans de Goede (1):
      efi/libstub/tpm: Initialize efi_physical_addr_t vars to zero for mixed mode

 drivers/firmware/efi/libstub/tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
