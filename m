Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A1DC64EBD
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D39E20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 01:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VRXGEtuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D39E20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeJCITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 04:19:46 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43947 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbeJCITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 04:19:46 -0400
Received: by mail-yw1-f68.google.com with SMTP id j75-v6so1634934ywj.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 18:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=auKnNveIqCKea9JYkkeiwWpZ9jHUjxLcbeslIxDgt6k=;
        b=VRXGEtuMhPe8rUXMlHuLOK3lJ2hTYx8q1G43K1qJpILYXuoseM+Y5ewjMLKmMSnirT
         SH1pQOXRSCO5B4Jan6/sxOi30E111vRCYYXMw7UqDIseKeOWJaWSvnY4bovq6uXBrD8X
         Ijt0VUZlAZBnhslRJm5Yw/79LbDxFOsuT71i1YWecy8fr/1KeMJX/DYJ37KhbbL0zl6r
         RaTTIh4hLWgt+BqQDGpUZsd5daWjtfwaaZSlkLd9s5Dgn575944+GdE6unq2xdCVbe5l
         3UqRafEImwyHAwCerWRnXw6iw7Nirw2OapIAsbzGdutdn+TsRd3rpRCOemfA4QPqBATn
         HwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=auKnNveIqCKea9JYkkeiwWpZ9jHUjxLcbeslIxDgt6k=;
        b=dWyZS93xIFaGqwuL1FaQZU5SG3dtthT4/VARAQpqV6I+Pl6W2jB2GNXrDIH/EMFBRO
         haYBOUU/Jqes+EJd1bGLIFxDmxdsgBontFHWXDGVAHyXeIk/0CDuumnCoLI4TtACKRqG
         cycvu3ZC0xLdDGYDLYlcpSfWRh0PNhcqOxrJVo1wUjUxdn9/1XJr9JpcCcJCu3tt5SP3
         uEfDgDtHxuK56ZZFtxsFpezenMEQ/Bx2PM9qwX2uk761szEzbXrJTV798AAU5nyGLd/n
         LmNU2fptwoOCbjb0JqjeAU3jarpcjHFjg40UqWPtNdWABZOZkjHfeaR8IqHq1bXIGPOA
         DL/w==
X-Gm-Message-State: ABuFfoh7Cs2otgL3qA1ZdG/U2BZoND3ggpT6T52D4qK/NL9bNEmGZaUN
        LeLB+pguhbdZvI4i8FPSTA==
X-Google-Smtp-Source: ACcGV61sHXAtdIPQ31Xac3GQpZt7JVRwYrsDr6JzvcxbaLLMM9eI1gwMkdFTFK3Kna7/GVO2H19eYw==
X-Received: by 2002:a81:9d14:: with SMTP id u20-v6mr10383411ywg.14.1538530416024;
        Tue, 02 Oct 2018 18:33:36 -0700 (PDT)
Received: from gabell.hsd1.ma.comcast.net (c-98-229-178-29.hsd1.ma.comcast.net. [98.229.178.29])
        by smtp.gmail.com with ESMTPSA id x64-v6sm5908556ywx.103.2018.10.02.18.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 18:33:35 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Add a kernel parameter to change the padding size for KASLR
Date:   Tue,  2 Oct 2018 21:33:20 -0400
Message-Id: <20181003013323.4162-1-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are adding an kernel parameter to change
the padding size used for KASLR. It is useful for memory hotplug
capable system. User can adjust the padding size to use it.

It is better if the padding size is calculated automatically,
however, ACPI SRAT is not available at the KASLR initialization
time. So, I add a message for user to tell the suitable padding
size. User can set it on next reboot.

This patch series don't change the current default padding size.

Change log from v5:
 - Fix build error if CONFIG_RANDOMIZE_MEMORY is not defined.

Change log from v4:
 - Fix the padding size check (2nd patch)
 - Add explanation for the parameter in the document. (3rd patch)

Change log from v3:
 - Add a warning message if the padding size for KASLR is not enough.
   And it says the suitable padding size to user.

Change log from v2:
 - Simplify the description. As Baoquan said, this is similar SGI UV issue,
   but a little different. Remove SGI UV description.

Masayoshi Mizuma (3):
  x86/mm: Add a kernel parameter to change the padding used for the
    physical memory mapping
  ACPI/NUMA: Add warning message if the padding size for KASLR is not
    enough
  Documentation/kernel-parameters.txt: Document
    rand_mem_physical_padding=

 .../admin-guide/kernel-parameters.txt         | 19 ++++++++++++++++
 arch/x86/include/asm/setup.h                  |  9 ++++++++
 arch/x86/mm/kaslr.c                           | 22 ++++++++++++++++++-
 drivers/acpi/numa.c                           | 16 ++++++++++++++
 4 files changed, 65 insertions(+), 1 deletion(-)

-- 
2.18.0

