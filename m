Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48918C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0087C20874
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 09:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=colorfullife-com.20150623.gappssmtp.com header.i=@colorfullife-com.20150623.gappssmtp.com header.b="UiEqv0sc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbeLSJEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 04:04:36 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33188 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbeLSJEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 04:04:36 -0500
Received: by mail-wm1-f68.google.com with SMTP id r24so9033590wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 01:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=tkxkQZ8w8uWQO4DOALofQnS99LWAHWpWskK5EeYPAFM=;
        b=UiEqv0scG0jexALnNcnoT8Kkk3LMpQXYyAI+RZmke3yPrbHkBRa3la7phHMrE6orl8
         onHlQmYQwvbpClfMVsawYXHGxCAeB4BqFNvh5DSBECfcvAX/n5uJupiwQh4e7QuBvuRU
         bgHzWm2ul16nWvWi2Hk8IssaOIglHOxmXZ+EzK5c7wqv+tUybsw9IgLtIHdQ4OsZipQf
         tbu7HGwqdmvtNp5iwoYJKYLgjXQXzQMlm4NA7QBK3n5uEpKBvyCfRpxX0m23rbn1Wrwi
         g9kx35kr/tLuadrsL5RgIrZKBSv78xKKlTikqlXR4edKPNMiSAG3pUny+7r6JyfKSEDi
         jBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=tkxkQZ8w8uWQO4DOALofQnS99LWAHWpWskK5EeYPAFM=;
        b=ncI8DT20o0GyxxtngD5vqqcdg7HiD9JZ0SX2YhGJdY1rh+5RYyRpAZtKAyoB7ZRACJ
         sNNA1sc8jmdwoFpp3yKYCImGCyQCNNw6WXctKWWiA00oX8a0lHmI6zTL5GjxguZxoJHy
         Ka1mZqwGIduPiS8oXlWdBRrJ6S/fXkYFfO4mXjCqczBDkg/ks6k2r1XO8Z6BGNQWLJY9
         fiexsG6CgEuC/R8nbu7DQypwirqeAVO6xT8EcUJI+M8NHRgHtiAdqmhSL3DGRslT+YnE
         jCWTVNLevzlMSQtjOL8lfT87iZfkXLuTYgg1krh1kXPsocJWPMkbBptrKdig+fWJQenh
         x9aA==
X-Gm-Message-State: AA+aEWbI4TtDrqWL8f7g7+gHuaFPtw5IBgGi+WGAMyC1HnIERCbbcQPX
        74g6cvV2vaseUsw8dVMi5ssrpw==
X-Google-Smtp-Source: AFSGD/WNUZzl++Zx7804Bl4kkT6yZdOaPvLt1bGGqcFdOSeXqQJEsc6G+XisU7jnzq3nqgskrTlrZw==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr6446342wma.85.1545210272618;
        Wed, 19 Dec 2018 01:04:32 -0800 (PST)
Received: from linux.fritz.box (p200300D993CA0A005CE85F5212CEE306.dip0.t-ipconnect.de. [2003:d9:93ca:a00:5ce8:5f52:12ce:e306])
        by smtp.googlemail.com with ESMTPSA id 129sm4366793wmd.18.2018.12.19.01.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 01:04:31 -0800 (PST)
Subject: Re: general protection fault in put_pid
To:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        ktsanaktsidis@zendesk.com, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Matthew Wilcox <willy@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>
References: <00000000000051ee78057cc4d98f@google.com>
 <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
From:   Manfred Spraul <manfred@colorfullife.com>
Message-ID: <ab2fb696-8d3b-9720-a8a0-99c66a080605@colorfullife.com>
Date:   Wed, 19 Dec 2018 10:04:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YX3=OLqfmWwhHVCQz+HwE=53VH9c1E2M+rgbF=UVTV5A@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------348420D97650A12C69C239A1"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------348420D97650A12C69C239A1
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Dmitry,

On 12/12/18 11:55 AM, Dmitry Vyukov wrote:
> On Tue, Dec 11, 2018 at 9:23 PM syzbot
> <syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    f5d582777bcb Merge branch 'for-linus' of git://git.kernel...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=135bc547400000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=c8970c89a0efbb23
>> dashboard link: https://syzkaller.appspot.com/bug?extid=1145ec2e23165570c3ac
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16803afb400000
> +Manfred, this looks similar to the other few crashes related to
> semget$private(0x0, 0x4000, 0x3f) that you looked at.

I found one unexpected (incorrect?) locking, see the attached patch.

But I doubt that this is the root cause of the crashes.

Any remarks on the patch?

I would continue to search, and then send a series with all findings.

--

     Manfred


--------------348420D97650A12C69C239A1
Content-Type: text/x-patch;
 name="0001-ipc-sem.c-ensure-proper-locking-during-namespace-tea.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ipc-sem.c-ensure-proper-locking-during-namespace-tea.pa";
 filename*1="tch"

From 733e888993b71fb3c139f71de61534bc603a2bcb Mon Sep 17 00:00:00 2001
From: Manfred Spraul <manfred@colorfullife.com>
Date: Wed, 19 Dec 2018 09:26:48 +0100
Subject: [PATCH] ipc/sem.c: ensure proper locking during namespace teardown

free_ipcs() only calls ipc_lock_object() before calling the free callback.

This means:
- There is no exclusion against parallel simple semop() calls.
- sma->use_global_lock may underflow (i.e. jump to UNIT_MAX) when
  freeary() calls sem_unlock(,,-1).

The patch fixes that, by adding complexmode_enter() before calling
freeary().

There are multiple syzbot crashes in this code area, but I don't see yet
how a missing complexmode_enter() may cause a crash:
- 1) simple semop() calls are not used by these syzbox tests,
  and 2) we are in namespace teardown, noone may run in parallel.

- 1) freeary() is the last call (except parallel operations, which
  are impossible due to namespace teardown)
  and 2) the underflow of use_global_lock merely delays switching to
  parallel simple semop handling for the next UINT_MAX semop() calls.

Thus I think the patch is "only" a cleanup, and does not fix
the observed crashes.

Signed-off-by: Manfred Spraul <manfred@colorfullife.com>
Reported-by: syzbot+1145ec2e23165570c3ac@syzkaller.appspotmail.com
Reported-by: syzbot+c92d3646e35bc5d1a909@syzkaller.appspotmail.com
Reported-by: syzbot+9d8b6fa6ee7636f350c1@syzkaller.appspotmail.com
Cc: dvyukov@google.com
Cc: dbueso@suse.de
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 ipc/sem.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index 745dc6187e84..8ccacd11fb15 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -184,6 +184,9 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
  */
 #define USE_GLOBAL_LOCK_HYSTERESIS	10
 
+static void complexmode_enter(struct sem_array *sma);
+static void complexmode_tryleave(struct sem_array *sma);
+
 /*
  * Locking:
  * a) global sem_lock() for read/write
@@ -232,9 +235,24 @@ void sem_init_ns(struct ipc_namespace *ns)
 }
 
 #ifdef CONFIG_IPC_NS
+
+static void freeary_lock(struct ipc_namespace *ns, struct kern_ipc_perm *ipcp)
+{
+	struct sem_array *sma = container_of(ipcp, struct sem_array, sem_perm);
+
+	/*
+	 * free_ipcs() isn't aware of sem_lock(), it calls ipc_lock_object()
+	 * directly. In order to stay compatible with sem_lock(), we must
+	 * upgrade from "simple" ipc_lock_object() to sem_lock(,,-1).
+	 */
+	complexmode_enter(sma);
+
+	freeary(ns, ipcp);
+}
+
 void sem_exit_ns(struct ipc_namespace *ns)
 {
-	free_ipcs(ns, &sem_ids(ns), freeary);
+	free_ipcs(ns, &sem_ids(ns), freeary_lock);
 	idr_destroy(&ns->ids[IPC_SEM_IDS].ipcs_idr);
 	rhashtable_destroy(&ns->ids[IPC_SEM_IDS].key_ht);
 }
@@ -374,7 +392,9 @@ static inline int sem_lock(struct sem_array *sma, struct sembuf *sops,
 		/* Complex operation - acquire a full lock */
 		ipc_lock_object(&sma->sem_perm);
 
-		/* Prevent parallel simple ops */
+		/* Prevent parallel simple ops.
+		 * This must be identical to freeary_lock().
+		 */
 		complexmode_enter(sma);
 		return SEM_GLOBAL_LOCK;
 	}
-- 
2.17.2


--------------348420D97650A12C69C239A1--
