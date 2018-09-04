Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B27C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35F82082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vCtqrbAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35F82082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbeIDThn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:37:43 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39972 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbeIDThn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:37:43 -0400
Received: by mail-qk1-f193.google.com with SMTP id c126-v6so2624488qkd.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pAwyQEaHEwmDYTVF+IAr3GO6/Dh3nqid5fovpvm0XnY=;
        b=vCtqrbAdnYmAWRfOxvjXJLXOqksByP+a6ORcDl4K7kEgpcgZgMmy02ZtgXg24rIJjM
         0woRSxTKCZWCSqEgAq6Y2L9pUAMh21hWCur/PDXHQbvqVw5ifFNOL+nI/ZV775LrUPbo
         26y4VwQnhxpW2akov3n+UHRwWFLfNfJn0R+Y0HjcssnpXK9qWozdffdcWjz/j4No7zw9
         XBSg82e6Rctb4qKA2ZMTOFBb8bUNCTX2u55jvIbuAaJo7ToSX3OUCbZtFfbHkGCHEQfp
         zEhqsqbTWe7zl/dDvXrzZztMatUUT1P5DHe6ilFGRycAmaLbnxITjBXzmzej88iyzVCi
         8OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pAwyQEaHEwmDYTVF+IAr3GO6/Dh3nqid5fovpvm0XnY=;
        b=V4AiAYODkht3DQXJvMYCv1syEcp02j6jcDOdzh9Ob4u8VxeTfn8J5ltkhgLFtacaJ0
         LEWmc5IPrZSlCv/ikVzn5jBoA0nEfBFaGEkH1kmfthPUe/bpZ7fcGNHvN9n+7mPrTSkW
         Txve8IwN0cseWPSseQ/bpgMYED3OFbCswiq63+hN+4rgzjYESaGjy2h+rUf4IN83rIF6
         9ukhf2VZ4sv/jmf9tPFPw9JQryXEDAU6Gj69CZKSfTWNhrMj2dJbJnNTIOHwwyCzL6KB
         now3W7JXAcwi5daT7FOUWJG9ezYYbq/NjqJL6P8FAjtGyEV0DRV/6TtNuMVHwXjMwFSl
         602g==
X-Gm-Message-State: APzg51DhrpD+i/L9/umZI9r429QhESbwBPuStS0qhHCkOdEBtjUmAEof
        utC/YqK10YopVoYvOdU27g==
X-Google-Smtp-Source: ANB0VdZVhLGPNWUBKbJeblwW6/mfCOXuHDPoDRvfA2jPD70/pIeaMwmH5mim5TFs5p/gWo45ysvbsQ==
X-Received: by 2002:a37:83c6:: with SMTP id f189-v6mr5111577qkd.47.1536073932973;
        Tue, 04 Sep 2018 08:12:12 -0700 (PDT)
Received: from gabell.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id u72-v6sm13215237qki.89.2018.09.04.08.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Sep 2018 08:12:12 -0700 (PDT)
From:   Masayoshi Mizuma <msys.mizuma@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Baoquan He <bhe@redhat.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-kernel@vger.kernel.org, mike.travis@hpe.com, sivanich@hpe.com
Subject: [PATCH v3 2/2] docs: kernel-parameters.txt: document rand_mem_physical_padding parameter
Date:   Tue,  4 Sep 2018 11:11:41 -0400
Message-Id: <20180904151141.20264-2-msys.mizuma@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904151141.20264-1-msys.mizuma@gmail.com>
References: <20180904151141.20264-1-msys.mizuma@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

This kernel parameter allows to change the padding used for the physical
memory mapping section when KASLR memory is enabled.

For some systems, the default value, CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING,
is not enough. The option is useful to adjust the padding size to work
around such issue.

Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0c883029881a..97f54c910c9c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3477,6 +3477,13 @@
 	ramdisk_size=	[RAM] Sizes of RAM disks in kilobytes
 			See Documentation/blockdev/ramdisk.txt.
 
+	rand_mem_physical_padding=
+			[KNL] Define the padding size in terabytes
+			used for the physical memory mapping section
+			when KASLR memory is enabled.
+			The default value is
+			CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING.
+
 	ras=option[,option,...]	[KNL] RAS-specific options
 
 		cec_disable	[X86]
-- 
2.18.0

