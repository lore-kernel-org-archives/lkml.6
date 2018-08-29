Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A79C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEE7520858
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 11:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DB2fTUZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE7520858
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbeH2PcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 11:32:16 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38200 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbeH2PcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 11:32:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id t25-v6so5154209wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 04:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WeSMiuMtzDEN1FdWmqPLXOd7CyZ+jfvYb8JwPl6GEEQ=;
        b=DB2fTUZPwYG/vC54X0ylcYITM5VLrqYbpoKAgttKvxIgjM/CMpHyEfZop0XiAxCjAR
         SqefjUTWrUaMFbrzlRaCkfPP2ENFxVz4o+3GyKyWZfACMcIkY8BvkKjpZ5rLUNzQv+vC
         UaiuKzQpQaLSdmSwRMrFir9YX1tzVhMmHfnFRDWuVX9c7EM0JdeHcgrdRy8butdZgjsO
         O5jsznGZWbNwzg1Hwvpy4cG2lxNJ8pAsWYQXASFciem61/ZlgRxIf1J82I/AV/Gi5n/V
         efOWPmlesPVvERDd7ijRqLcvXF7OOC/l5jMPEgZPmfTjC7dW6V65A5vbC7e7im+oXG2d
         LbdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WeSMiuMtzDEN1FdWmqPLXOd7CyZ+jfvYb8JwPl6GEEQ=;
        b=ZREFtjEXTfHHKM6T4a+GRSMwRHTdIMg3iFIMEXgsQg3JtzRqLLJWKbsFI3BByPr3K8
         YimuWMnOzVORbGJaWp4q4Q1Cm9wtO03P3X3SGtJUBjEasdO+1dh6jHd5Wg6RWL/4ocmy
         givnLpXZu+gWLi1myt8ESftR5aezHSKJCRa5Pf4pZMbOVxBCsGEHh7K4kx35Z9adoboN
         hJoLQkAVajOMBswcvx3YKF5mdIfdsxEPLMA5xpX9V2TloDhpAsHmHxUfFLVTmUhZMm9G
         StZBFaebLA17Z67X/8dGE5P8XkK2l6lS69uwsGZxOdwMHq514VsUUDGomaHqS2PehSRn
         TgGg==
X-Gm-Message-State: APzg51CjuPb8zpfQEbppsCqaEuJEvW/fFAPRCMzs74GVClAba3BQxGK7
        wzxUeR58YTt0V5IweQrPcQnIRg==
X-Google-Smtp-Source: ANB0Vdbc1gSJCzQt/c4lE4zyKdI4J/AL4sF1sTjGC2+4JWrxUIp67ZMN/Z0VxXD8BaXnDRSB0wO+UQ==
X-Received: by 2002:a1c:200c:: with SMTP id g12-v6mr4128408wmg.102.1535542545044;
        Wed, 29 Aug 2018 04:35:45 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id s10-v6sm7800454wmd.22.2018.08.29.04.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 04:35:44 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sparse@vger.kernel.org, linux-mm@kvack.org,
        linux-kbuild@vger.kernel.org
Cc:     Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Jann Horn <jannh@google.com>,
        Mark Brand <markbrand@google.com>,
        Chintan Pandya <cpandya@codeaurora.org>,
        Vishwath Mohan <vishwath@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v6 11/18] khwasan, mm: perform untagged pointers comparison in krealloc
Date:   Wed, 29 Aug 2018 13:35:15 +0200
Message-Id: <a13a41e3ca65116eb5614c4dd396b23182e98fed.1535462971.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535462971.git.andreyknvl@google.com>
References: <cover.1535462971.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The krealloc function checks where the same buffer was reused or a new one
allocated by comparing kernel pointers. KHWASAN changes memory tag on the
krealloc'ed chunk of memory and therefore also changes the pointer tag of
the returned pointer. Therefore we need to perform comparison on untagged
(with tags reset) pointers to check whether it's the same memory region or
not.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/slab_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 3abfa0f86118..0d588dfebd7d 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1513,7 +1513,7 @@ void *krealloc(const void *p, size_t new_size, gfp_t flags)
 	}
 
 	ret = __do_krealloc(p, new_size, flags);
-	if (ret && p != ret)
+	if (ret && khwasan_reset_tag(p) != khwasan_reset_tag(ret))
 		kfree(p);
 
 	return ret;
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog

