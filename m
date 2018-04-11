Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477719-2-8859717424535748837
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477718; b=AFJaluZPbbqDwvbbhsvHiMJ4xej0n26JTERdWR1yTRIG0oOg6n
    1x+OAfabM7hW7r9zjlKnesczVf0EkAnr8h4mxWJSwLDz2nSpgzEaXYHtyR4FZ9ST
    yWzGmaRG+wo8Sp7grPquclKNq3hUNYCXOCLtuFyJ49t0IyvZ0ipuHNEzhIdl8pbV
    VrV3Ldv3lEaoXrLdkcY1gMqaYJcnWG42QB6bHWombua8Bg7MPKwPm3o5ynRrXBNA
    bFgrUBcSG3iGNFIUDu8vhuYnmG8PPbatTV4L9lSbUrZ6jbYOlmwL2LvIr9BYtCMf
    gL64+YEWmwB3o7hT8Wa6m8EO98MM01WhULQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523477718; bh=zftvxMogSVHAuWnsa6LXC7h6vPQlbA
    MKE/htGsM8wB4=; b=sHtv/847sr42ZaAceYxCuk9OC0QeQISps34DAtc4H3wqnG
    sMTORM1Wq4qImO9k+zM9FlEsw6B21nq/O8troUz4jEM9tAc4d3NFZ1smCmyvUQG+
    M7PS1ZTEPCv/1AJDtMAlRTJxLCSvMGfG/+rO6zqLZfiiQgNozztF/EHA4fnaREDW
    EgfbwaDK6bVZ+2btrR11TThfCogI3Biq4pB15PMGYcPm0Haw2QM7FJeYuyqUUS+C
    Ll/ZRZI8fM+x5kWUY6YddhaZpe5PjejV7bASx7wBicpWhDOzLma+hSNfAqL1Agng
    DJ3HzyzpRbM/f2EWTDBZ3eEWKJtphpwYfdNSZw1A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfETKWaHd0bnyiHdN1BPFUE1PqxSJp7v1g9QJxa5KmARhufxsQo2U+tP2A6UbHDrrmqu6GKI17mO6QTojLF5aoc6PGzBXkUBE2G7OQK4njkJgoNM0VWii
    HTkfyZuz52L+zGqElcAQb1VxASreNa+Ii6ZnKBn2+rDKwBagIKshMfuLENiM2pIE28C/zMsp25pCms+lnM00yqeiLRWjEJMw9sIQPL9GdocEVi9NnPk2zOo5
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8
    a=cm27Pg_UAAAA:8 a=mK_AVkanAAAA:8 a=drOt6m5kAAAA:8 a=xVhDTqbCAAAA:8
    a=PtDNVHqPAAAA:8 a=SOq6UgPBAAAA:8 a=hBqU3vQJAAAA:8 a=Z4Rwk6OoAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=rNsULVQiV86SHlLWsYUA:9
    a=HxKWDZkTf5y79ZnT:21 a=BoBft98koqt4epYC:21 a=QEXdDO2ut3YA:10
    a=zvYvwCWiE4KgVXXeO06c:22 a=AjGcO6oz07-iQ99wixmX:22 a=Hx1yvPaMooE3kwe23bt7:22
    a=xmb-EsYY8bH0VWELuYED:22 a=3gWm3jAn84ENXaBijsEo:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=GrmWmAYt4dzCMttCBZOh:22 a=BpimnaHY1jUKGyF_4-AF:22 a=3hv5r9HjGAh9o5iR9qwG:22
    a=WLjMIN4s_96MqnBbPenP:22 a=HkZW87K1Qel5hWWM3VKY:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756438AbeDKUPD (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:15:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33752 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933264AbeDKSxZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:53:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Andrei Vagin <avagin@virtuozzo.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Michael Kerrisk <mtk.manpages@googlemail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ingo Molnar <mingo@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 022/310] pidns: disable pid allocation if pid_ns_prepare_proc() is failed in alloc_pid()
Date: Wed, 11 Apr 2018 20:32:41 +0200
Message-Id: <20180411183623.247331431@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill Tkhai <ktkhai@virtuozzo.com>


[ Upstream commit 8896c23d2ef803f1883fea73117a435925c2b4c4 ]

alloc_pidmap() advances pid_namespace::last_pid.  When first pid
allocation fails, then next created process will have pid 2 and
pid_ns_prepare_proc() won't be called.  So, pid_namespace::proc_mnt will
never be initialized (not to mention that there won't be a child
reaper).

I saw crash stack of such case on kernel 3.10:

    BUG: unable to handle kernel NULL pointer dereference at (null)
    IP: proc_flush_task+0x8f/0x1b0
    Call Trace:
        release_task+0x3f/0x490
        wait_consider_task.part.10+0x7ff/0xb00
        do_wait+0x11f/0x280
        SyS_wait4+0x7d/0x110

We may fix this by restore of last_pid in 0 or by prohibiting of futher
allocations.  Since there was a similar issue in Oleg Nesterov's commit
314a8ad0f18a ("pidns: fix free_pid() to handle the first fork failure").
and it was fixed via prohibiting allocation, let's follow this way, and
do the same.

Link: http://lkml.kernel.org/r/149201021004.4863.6762095011554287922.stgit@localhost.localdomain
Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
Acked-by: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Andrei Vagin <avagin@virtuozzo.com>
Cc: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Michael Kerrisk <mtk.manpages@googlemail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/pid.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -322,8 +322,10 @@ struct pid *alloc_pid(struct pid_namespa
 	}
 
 	if (unlikely(is_child_reaper(pid))) {
-		if (pid_ns_prepare_proc(ns))
+		if (pid_ns_prepare_proc(ns)) {
+			disable_pid_allocation(ns);
 			goto out_free;
+		}
 	}
 
 	get_pid_ns(ns);
