Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC359C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9492081B
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 17:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6FGvY/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9492081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbeKEC14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 21:27:56 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37335 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728688AbeKEC1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 21:27:55 -0500
Received: by mail-wm1-f66.google.com with SMTP id p2-v6so5831334wmc.2;
        Sun, 04 Nov 2018 09:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=K83MXMKnKynCqSGpEAGqilub5PPGoz3eEK23HTZ8YhQ=;
        b=N6FGvY/NYAFUMsnDD39lrWWLMzDPDQefmYJ5naoiet50aA1WqSrX/XiC87EeZffT39
         AoSx98S6LP4rPzTSnKsDcHh8LvtW0TIWKY3ut77+680gFsIUvv/GvXAwPnqIMbMgIUdB
         hMrGE5YgbvJvdOXZdjHLJ18y2Jkx+tGui/E1z1/rm7VZPepjIzecEwXk8+V2SAkB3k9w
         Wq8f8Aqny9zZ4RjW8JyjDb6uQ9xnx7TTh4L9qcEdqZPRMtqzhppTRkHLFvwKnFGf0qy6
         skt/Lft055jd200W9tNnj0yN2mimBBToElCDjc/QR1b5LgJHfyrOVRt/rX/xXZwQAfUo
         zT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=K83MXMKnKynCqSGpEAGqilub5PPGoz3eEK23HTZ8YhQ=;
        b=kIYuLlpiq9kTfoEqOiY0ifVYq8loSd+ztwljAX7AueG8coiwGQ9FoO9HuDSff/OXOV
         yfMpAhufc9SnoGf/2xXoRYUCTn3tE6dk9N5QLiyw3MNnpdY5u87EsSbukP5nSjHMh5iO
         Gi3zMqZqQMI1FYlJDMaEx4WjM7BrEPnXCfSUdoVetD5IjrjChzhoeOPLa3ELvOi5mPCH
         st1RuoluAer5M5ffmWV1tQzGHHqzgmHGXEVgfaz+IHu1vuwCeYPkHQOVCB5EdWAdzhXg
         KyLqVdjsayCk4URiJoe3fk5aBccK935tgTwQj+EZxtHQLRGH8tXSPkqxlqwV/UhQO84P
         jUFQ==
X-Gm-Message-State: AGRZ1gJAX/5bjS9l99rjYw48mafKv6OjPW6BuNABkFXNlsN61xJ6Byp4
        iobj2F5yqimkhvIIENXsOCg=
X-Google-Smtp-Source: AJdET5cQ3WZTW+AYb94a97tNBct6qOTGljjvw5Vecie00821Zbfei8diLvIUTGbfbdyRro7e8kTPQA==
X-Received: by 2002:a1c:2e50:: with SMTP id u77-v6mr3889431wmu.106.1541351534712;
        Sun, 04 Nov 2018 09:12:14 -0800 (PST)
Received: from localhost.localdomain ([41.35.162.9])
        by smtp.gmail.com with ESMTPSA id r2-v6sm23707749wrq.1.2018.11.04.09.12.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Nov 2018 09:12:13 -0800 (PST)
From:   Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmedsoliman0x666@gmail.com, ovich00@gmail.com,
        kernel-hardening@lists.openwall.com, nigel.edwards@hpe.com,
        Boris Lukashev <blukashev@sempervictus.com>,
        Hossam Hassan <7ossam9063@gmail.com>,
        "Ahmed Lotfy igor . stoppa @ gmail . com" <A7med.lotfey@gmail.com>
Subject: [PATCH V6 1/8] KVM: State whether memory should be freed in kvm_free_memslot
Date:   Sun,  4 Nov 2018 19:11:17 +0200
Message-Id: <20181104171124.5717-2-ahmedsoliman0x666@gmail.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
References: <20181104171124.5717-1-ahmedsoliman0x666@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The conditions upon which kvm_free_memslot are kind of confusing,
it will be hard to extend memslot with allocatable data that needs to be
freed, so I replaced the current mechanism by the change flag, it states if
the memory slot should be freed or not.

Signed-off-by: Ahmed Abd El Mawgood <ahmedsoliman0x666@gmail.com>
---
 virt/kvm/kvm_main.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2679e476b6c3..039c1ef9a786 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -549,9 +549,10 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
  * Free any memory in @free but not in @dont.
  */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *free,
-			      struct kvm_memory_slot *dont)
+			      struct kvm_memory_slot *dont,
+			      enum kvm_mr_change change)
 {
-	if (!dont || free->dirty_bitmap != dont->dirty_bitmap)
+	if (change == KVM_MR_DELETE)
 		kvm_destroy_dirty_bitmap(free);
 
 	kvm_arch_free_memslot(kvm, free, dont);
@@ -567,7 +568,7 @@ static void kvm_free_memslots(struct kvm *kvm, struct kvm_memslots *slots)
 		return;
 
 	kvm_for_each_memslot(memslot, slots)
-		kvm_free_memslot(kvm, memslot, NULL);
+		kvm_free_memslot(kvm, memslot, NULL, KVM_MR_DELETE);
 
 	kvfree(slots);
 }
@@ -1063,14 +1064,14 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	kvm_arch_commit_memory_region(kvm, mem, &old, &new, change);
 
-	kvm_free_memslot(kvm, &old, &new);
+	kvm_free_memslot(kvm, &old, &new, change);
 	kvfree(old_memslots);
 	return 0;
 
 out_slots:
 	kvfree(slots);
 out_free:
-	kvm_free_memslot(kvm, &new, &old);
+	kvm_free_memslot(kvm, &new, &old, change);
 out:
 	return r;
 }
-- 
2.18.1

