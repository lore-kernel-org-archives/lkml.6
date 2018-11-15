Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F0BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D400208E7
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 00:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="A9bHlKOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D400208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeKOLBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:01:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42873 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbeKOLBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:01:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id d72so4725365pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 16:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODfQ+SQgTqOYOl8mVBl3YRQtJ5/SB7ioe/Q2aadyAYw=;
        b=A9bHlKOM5+i2d6BC2Ygv+42LYuAkHILEWig9KuXtKUWGaXP+dov2nemV7elSZAFzXV
         NG6G2pTFMYsptfI3Vn8RRbcIJi6DN9OBIy9oQ4fYKaStesZOA86x1/JX/EhwA9YlP+gX
         s8VcMo+rLNokgTvSCTa4sTP1hRjnFIQwkVC5jVhruqGKzvyQ2Aj7tCj+BnHGoQmqLgby
         EZAJ1nm7ukkQA9gxaxxULld1gEC6H4al4yMvDDey44uZX8KA/OXXsj6jz8N+OObjB+L9
         vu7gXhWNCcbRgGA0iiOqnLjlCteJRXddRPnY7h5CzxXhHbjYDvA3/PQPpRLYPR+R/x29
         Taow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ODfQ+SQgTqOYOl8mVBl3YRQtJ5/SB7ioe/Q2aadyAYw=;
        b=fLtE3UhFz3GhyNuSqM1nmLsULePwV3x7pdk5fqZGYzX8/4bcPlM4hg69yFQxotBh9G
         SSWmIQR/L0XHkeaM4nF+4CXiHJjWO9CsmV6IPKknvhVJNf+nW2xTO1CCergulj8domLY
         hCeCc2LtUsBxCJFQKavpUwcZsqz6OMLQEq2K1u/BP8FGt7iyvNI1dGdnEGteJWNI25h1
         rdJd5qMRCNciNKzG4wNQpezGxmHWDZ9CivHpQEgyYoAVjW/gqFMzGjdYciIOW3yVultg
         99gpZkM0ova4usG7bi14HpPMcDlXK5dzmAnmq8XnktCQfXKJDeyXAhpBROHbZPEzeM5l
         SGdg==
X-Gm-Message-State: AGRZ1gJYWE/IXJXHkklHGlDm3QxPtOabV5Q86A8yal1CnzAXkTRHY+I8
        Ei6/pvO2FMGDQqtMyI+2OE2/bGiwMEs=
X-Google-Smtp-Source: AJdET5euSAlgFSyUCjkUtuCDgDCnRIQN7hL5qDYCXmD6CjMzTuKBQ1vkxm9zbo0jBrh3TqkFK+0Kfw==
X-Received: by 2002:a63:77ce:: with SMTP id s197mr3821987pgc.89.1542243377345;
        Wed, 14 Nov 2018 16:56:17 -0800 (PST)
Received: from viisi.sifive.com ([64.114.255.97])
        by smtp.gmail.com with ESMTPSA id m10-v6sm47343509pfg.180.2018.11.14.16.56.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 16:56:16 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Russell King <linux@armlinux.org.uk>,
        Jim Wilson <jimw@sifive.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Walmsley <paul@pwsan.com>, linux-kbuild@vger.kernel.org
Subject: [PATCH v2 0/2] modpost: skip section mismatch warnings on ELF local symbols by default
Date:   Wed, 14 Nov 2018 16:56:00 -0800
Message-Id: <20181115005602.30746-1-paul.walmsley@sifive.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

modpost reports section mismatch warnings on ELF local symbols.  This
caused false positive warnings to be reported for a local symbol name
that would otherwise be elided by matching against a name pattern.
This was observed using a RISC-V gcc 8.2.0 toolchain that generates
section anchors.

To avoid this noise in the common case, this patch series disables
section mismatch warnings on ELF local symbols.  It also drops some
unused command line switches from modpost, per feedback from Sam
Ravnborg <sam@ravnborg.org>.

This modpost series can also be found at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/modpost-elf-local-symbols-v4.20-rc2

The series was tested on a RISC-V build of the SiFive UART serial
driver, at:

https://github.com/sifive/riscv-linux/tree/dev/paulw/serial-v4.19-rc7


Paul Walmsley (2):
  modpost: drop unused command line switches
  modpost: skip ELF local symbols by default during section mismatch
    check

 scripts/mod/modpost.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Cc: Russell King <linux@armlinux.org.uk>
Cc: Jim Wilson <jimw@sifive.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

-- 
2.19.1

