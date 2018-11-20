Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C84C18DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B4D206B2
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aLBNi9Ms"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29B4D206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729045AbeKUBNM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:13:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeKUBNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:13:12 -0500
Received: by mail-qt1-f193.google.com with SMTP id z16so215309qtq.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzCcWYsD+UTNiISg748ippafAvv89tYKpp8xGRH3LJU=;
        b=aLBNi9Msbt3OHRGbvE31rPK6Ycv6uzcd4E1X+Wc+41tCiXPJn7EJL13/3ly4LEZ+Qf
         Jtrcw0LkX2KEduIY7o2N2b5I/VX4tC5MaN0eEvVaMNCvTjVUw+3OtNos4HHfZ0ENFFtU
         E2mLnhuykBQwzKuomZQz/9F8guGdxlmh+5Wv5unGs7nkZduCMFn/U723g9KKJVz6m7cH
         YYiq7Mse09dN6NlbQgp1pkcE6ml8hzRCUzQNxx32GhR6foCIWm9AwsRsDyuJSzYbICJ5
         IaRbzvnO7yCIb/DrKFSVjqL8tqbfN3lmdVBuhHqmfGwKQB11yhTa4MAlYegrmXDSk4RJ
         cFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qzCcWYsD+UTNiISg748ippafAvv89tYKpp8xGRH3LJU=;
        b=NVTUQ74OR0VnEkCh/yQyQhjRVaasM3q6kaysXETUIsoYVIq+xpzZivumcRwtB75MrH
         MnATnqH5yQzfLct0pF7lg+Howh5MjJOouCooda1a39mR/Ab8SmyISWD9p5jXhdRJd2so
         73mwXC6c5mn7w53rapuEeaxVn5sjZVFAt4MjN4Ly8tIEnmGJX9rzHHYFx59KaJybIf67
         mz77oElAI/FzzyOgrNV/vZVozKToFV/JSajzhw9J/PQBkgpFFBgNmrCgxSRLysrRrwQY
         ngoHgMNBIUttSBpr/pfN8YQWahRFfrMmFRBVig1/FfTMZpya/3EWdlhXUMvzsu5/IpUu
         2vgQ==
X-Gm-Message-State: AA+aEWYobTG/INmkAFWWgrledpF51gz+y4e88rfeireIng2cpcvEPNJZ
        RigT8cG51mFpxpeJpsd7WkOw4w==
X-Google-Smtp-Source: AFSGD/U1/HAJFPRjSyNFX/rpp6DQhibBVAKdsYmABetBUsk3aC+CCYAa3b3jXonBQ3jM84uYwOCPTg==
X-Received: by 2002:a0c:c192:: with SMTP id n18mr2030055qvh.99.1542725023032;
        Tue, 20 Nov 2018 06:43:43 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r16sm30046529qkh.71.2018.11.20.06.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 06:43:42 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 0/1] Early boot time stamps for arm64
Date:   Tue, 20 Nov 2018 09:43:39 -0500
Message-Id: <20181120144340.30201-1-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog:

v1 - v2
	Addressed comments from Marc Zyngier

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin@oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.

Pavel Tatashin (1):
  arm64: Early boot time stamps

 arch/arm64/kernel/setup.c            | 25 +++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  8 ++++----
 include/clocksource/arm_arch_timer.h |  3 +++
 3 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.19.1

