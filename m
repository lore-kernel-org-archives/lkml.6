Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792F7C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18BDE214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9vlvx3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BDE214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeIZR3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:29:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38770 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbeIZR3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:29:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id z16-v6so1881880wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 04:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uTy+mmOaZ76/eGRokeLFBv4J+yiuPWsYbtjpghyX7A=;
        b=U9vlvx3xFnm5Dnl2bL/EMvO+Sqb9RrBBBlKjy9WtUesqDY93j7qesBt78fctkPugOF
         kdAud/pEu0358FazKHXp53PqACJSI+VO4JPnPeqJuJDGl3N8pEXL3S2YrJnlwhVqrkFo
         0PRG09ULDJgJEXqvtD2tLg7NDiHPESrbz/ChGwulHS1Ua6YUc7n3km7/hk7oNcdZO2rH
         AvLiClvmZZ9cPr9BjL/Vqq+0KwjnKMHWcWTZJWcObV4XdeDfZxP3pB7DC3wtXDa4fGr4
         ZtLZ6aP2+2BSmqdE4XT2/rzzeKf2NYKZaSaKhf9vNVFcz1VDL2+5kuv4m7FPeKKj9fUu
         hXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4uTy+mmOaZ76/eGRokeLFBv4J+yiuPWsYbtjpghyX7A=;
        b=MNYW2LldB5EnHygf90yZHL9slfTYgR/LLfdvgg5hkqP3QOLyk0XuEO3qXoqaK0PhLB
         N6/2aBsY7a7xDGGdXODna5sB5unk+veukzJLJD+66QDcqOU8kErgdBOk/MOPjzuIjMF5
         AbSgvNlQ6qvFpsnEdBcrqpuBxFDdNJPkQgeIJWRiSmTp03UkPNXe/XZ9QDn7iYCv0gZM
         8cNAYdQuwUqpwYfX6RAKjlS+gY3BG7WPdW8CpgWVwNS8Bbt63VwMV6kpG1n4YBiib0J+
         EQRbzn1nMyLZaT7RJUGNJC6BgU00xc40/F05rHUMiEaWk4Aq8k7eDCchC/PlWEQZUrbb
         Bzrg==
X-Gm-Message-State: ABuFfojSc17VFSeqp1iDLf0dYhpVQ1eehcLDV8Vp9wpSHzesXqGSzKA7
        SnSkLpg0tAdl+Vd9QKrAvjk=
X-Google-Smtp-Source: ACcGV63wr7yD/mp0J65zlEV62C2QP0xzu4rPFGUWU1nuJHeBvvT2xFLYmgdbzgs86D7RRUq4YFBK2g==
X-Received: by 2002:a1c:ef15:: with SMTP id n21-v6mr2613205wmh.151.1537960595212;
        Wed, 26 Sep 2018 04:16:35 -0700 (PDT)
Received: from laptop.localdomain ([37.122.159.87])
        by smtp.gmail.com with ESMTPSA id r64-v6sm3885724wme.42.2018.09.26.04.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 04:16:34 -0700 (PDT)
From:   Yasha Cherikovsky <yasha.che3@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Cc:     Yasha Cherikovsky <yasha.che3@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/1] MIPS: Lexra CPU support, prerequisite patch
Date:   Wed, 26 Sep 2018 14:16:14 +0300
Message-Id: <20180926111615.6780-1-yasha.che3@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the v2 of:
https://www.linux-mips.org/archives/linux-mips/2018-09/msg00641.html

Changelog:

v1 -> v2:
- Rebased on v4.19-rc5
- Addressed Paul's comments:
  https://www.linux-mips.org/archives/linux-mips/2018-09/msg00735.html


The patch is also available at:
https://github.com/yashac3/linux-rtl8186/commits/unaligned_load_store_on_4_19


Please review.

---

This is a prerequisite patch required for adding Lexra CPU [1] support in
arch/mips.
It does not add any Lexra CPU support yet, but it is required for such future
support.

The patch is written on top of v4.19-rc5.

Background:
I'm currently working on porting Linux/MIPS to run on the Realtek RTL8186 SoC [1],
which has Lexra LX5280 CPU [2].

The complete Lexra+RTL8186 support is still WIP [3] so I'm not sending that
for review right now.

Thanks,
Yasha

[1] https://wikidevi.com/wiki/Realtek_RTL8186
[2] https://www.linux-mips.org/wiki/Lexra
[3] https://github.com/yashac3/linux-rtl8186/commits/rtl8186-porting-for-upstream-4.18

Cc: linux-kernel@vger.kernel.org

Yasha Cherikovsky (1):
  MIPS: Add Kconfig variable for CPUs with unaligned load/store
    instructions

 arch/mips/Kconfig            | 35 +++++++++++++++++++++++++--
 arch/mips/kernel/unaligned.c | 47 ++++++++++++++++++------------------
 arch/mips/lib/memcpy.S       | 10 ++++----
 arch/mips/lib/memset.S       | 12 ++++-----
 4 files changed, 67 insertions(+), 37 deletions(-)

-- 
2.19.0

