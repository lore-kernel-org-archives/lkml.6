Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA41CC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76848214FA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auC+OaKC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76848214FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeIZAR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:17:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34825 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIZAR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:17:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id o16so11010883wrx.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI0hLS/bvI0Hqo/pfglI7FYYUsJ/cwY74alonubtd24=;
        b=auC+OaKCTtg9cJXRa7nmpzJdX50yTxyrVVNvZZnoKthSRJIAXkoq0QJW8U5FvqUbF+
         wUHDJ0HzDVf0tfUlj59ToPdGjq9fH5TMjUHOLzSIzx7aJNXOEbcbPIT2FSicVRaepJet
         1ngKpu4E+3o8RJqRgcVvlLyD9dgD9ifsJdf5fRBnRhcHqE3owMk/Mjt2MptFWHgo2/jJ
         QsMNgO5dxxn0m/81Pfwc2mzfu1t8QmyyUquvaXDeFwotVsl91LgMsnJNTZQiVsv+EwnC
         qf8XWYQX9W56c53iJ091ghM1rKELrOXCaWAZ9nuBGIiOU7OUiLvpWLhKkJTw4zJMOoA1
         xszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CI0hLS/bvI0Hqo/pfglI7FYYUsJ/cwY74alonubtd24=;
        b=BidXDt249x8jlur8H9fIWJiitLIUQW2gfJF2p09ASkUla+WJ80GbviTL/5WCRWT/Sk
         cYEgsdrnB+Uv82OrJ8tbAIzg3sS/wgP+SYT7eAP3/8QpGfexW1BXovE3ZADPN0Z7Z+gl
         nX58fwHflxBb2q3n1HLONPN7m275Q/ygQhhExgSKKIcLdkGmGIFmfj+u+IxQFmm0luR1
         e1ZBxsl3fkcxw/Xs3KARNx9aMbhF1bQzeYzpTL538Q6/ix42wumMBlxq4fgr2yjb+Vvy
         JgVz/fCZReCbTOziSgZ5V7XytUgWrmi75emgI56RyBd+5Xe3I7qRGrViv0CbxLNz7q0j
         4MAA==
X-Gm-Message-State: ABuFfohS62TU4SrUOAvCvs1uIvZeXC9dMeQHml7gOVPZlMPtR/1ByJJu
        QWDiRIELgrOmCYkTlS4DMrKoOe+3ACk=
X-Google-Smtp-Source: ACcGV60fRVuHt4vkMnJmbNqf0FIUohzkZQQchrgpkJqKoDBbpKvqDDa8UWYE/X+zukw+qWjKv+c8aA==
X-Received: by 2002:adf:93a5:: with SMTP id 34-v6mr2114197wrp.244.1537898923546;
        Tue, 25 Sep 2018 11:08:43 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id v6-v6sm2755827wro.66.2018.09.25.11.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:08:43 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] MIPS: Simplify ELF appended dtb handling
Date:   Tue, 25 Sep 2018 21:08:21 +0300
Message-Id: <20180925180825.24659-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series simplifies and cleans up the handling of
CONFIG_MIPS_ELF_APPENDED_DTB in the MIPS tree.

Specifically, it makes sure that the dtb appears in 'fw_passed_dtb'
also under CONFIG_MIPS_ELF_APPENDED_DTB=y.

This allows to remove special platform code that handled the ELF
appended dtb case, and replace it with the generic appended dtb
case (fw_passed_dtb).

There's also a bonus: platforms that already handle 'fw_passed_dtb',
gain now automatic support for detecting a DT blob under
CONFIG_MIPS_ELF_APPENDED_DTB=y.


Patches:
- Patch 1 adds only comments (to make the file more readable for patch 2).
- Patch 2 fixes 'fw_passed_dtb' under CONFIG_MIPS_ELF_APPENDED_DTB=y.
- Patch 3 simplifies CONFIG_MIPS_ELF_APPENDED_DTB handling on the BMIPS platform.
- Patch 4 simplifies CONFIG_MIPS_ELF_APPENDED_DTB handling on the Octeon platform.

Patches 3 and 4 depend on patch 2.

The patches are on top of v4.18.

The patches are also available at:
https://github.com/yashac3/linux-rtl8186/commits/elf_appended_dtb_changes_on_4_18

Please review.

Thanks,
Yasha

Cc: linux-kernel@vger.kernel.org


Yasha Cherikovsky (4):
  MIPS/head: Add comments after #endif and #else
  MIPS/head: Store ELF appended dtb in a global variable too
  MIPS: BMIPS: Remove special handling of CONFIG_MIPS_ELF_APPENDED_DTB=y
  MIPS: Octeon: Remove special handling of
    CONFIG_MIPS_ELF_APPENDED_DTB=y

 arch/mips/bmips/setup.c         |  9 +--------
 arch/mips/cavium-octeon/setup.c | 10 +++-------
 arch/mips/kernel/head.S         | 18 ++++++++++--------
 3 files changed, 14 insertions(+), 23 deletions(-)

-- 
2.19.0

