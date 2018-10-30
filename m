Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3205BC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E57CE20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 15:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="q6nCH2HN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57CE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbeJaAsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 20:48:10 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:38673 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJaAsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 20:48:09 -0400
Received: by mail-it1-f195.google.com with SMTP id j9so2376315itl.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cjXmaT6rVr4WW7EDTBdm+IVmVRptEFlS1nyxWXVduaQ=;
        b=q6nCH2HNB0J0sX9tCZyhhh5gLF1KyRZ+SleYBfTD3uDT59Iz0gmyFJQRSm2YFGit6W
         JHxg2iCqZ6j3nsTrBLwHIfSKVefQyMDQTem662DkXeaBkfMO7PhhASqcDjw5SZPxMP/s
         79Qojz99vsqSS8EQxKGieCnGhF+hl3NgJpRU6+70XdL6LQ3c2ZZ6556kShYpJ8MD2DyH
         eE8Kh1wXosjwPt59ZG79pXPbwKnhkQnv27oXAyilB0ZSpQXlOREX+s7M0b5s0fF6E4IU
         L0+WcJe3tr4k08UI5jxa62q02IM9M8BBHSLtj02dBKWmfLzDiTqZcX4pOgqeERhkCKRD
         pSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjXmaT6rVr4WW7EDTBdm+IVmVRptEFlS1nyxWXVduaQ=;
        b=WY3HF1TWxjc405DGexEG17JYL8Vmw1XsFTPRIDc3d90OgiwjZciLNT8gWnHzphZ563
         e+AWi4B4coUJnvcUXKZZEX7Gv/bmTr8McPdfOf2ZsD2wGZJocWwtTHir8PPFYm4NFEa7
         pxM1YvCFUJ1ZWGI7q5pbvwjO5oVmh3rkS2kHo7jZiF4hW8UL8Zrm3yBNij+eGXxKCMn7
         jmqw9EegBzIFzv92AcTKDgI43iO8EbenRAX0pQsTn2ZSx6ETzoXscHtssP1MuLIlWBI8
         19ztRLu33NtmXoC1ehfFK8yqj6HkYqvJFjdkMeKorS/hqFCyphJcKM/CIDwptxjXTykU
         M9fQ==
X-Gm-Message-State: AGRZ1gLaHrTSJXk7t9zqFCK5hoXZS/HRXvWLxXCWi7q3fuC4yNia1rz7
        nHjbXHWYRxm6Cz6l3G5g+6gQkg==
X-Google-Smtp-Source: AJdET5dEyrLHc6o8FGhN2S80PjeXzNHPiysmCC6zJaKrjNKaf4C52k/34N4UldqhvUsXHMWF0ieDlg==
X-Received: by 2002:a24:8347:: with SMTP id d68-v6mr995682ite.158.1540914847179;
        Tue, 30 Oct 2018 08:54:07 -0700 (PDT)
Received: from cisco (75-166-175-210.hlrn.qwest.net. [75.166.175.210])
        by smtp.gmail.com with ESMTPSA id j75-v6sm8469258itj.33.2018.10.30.08.54.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 08:54:05 -0700 (PDT)
Date:   Tue, 30 Oct 2018 09:54:03 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Subject: Re: [PATCH v8 1/2] seccomp: add a return code to trap to userspace
Message-ID: <20181030155403.GC7343@cisco>
References: <20181029224031.29809-1-tycho@tycho.ws>
 <20181029224031.29809-2-tycho@tycho.ws>
 <20181030150254.GB3385@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030150254.GB3385@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 04:02:54PM +0100, Oleg Nesterov wrote:
> On 10/29, Tycho Andersen wrote:
> >
> > +static long seccomp_notify_recv(struct seccomp_filter *filter,
> > +				void __user *buf)
> > +{
> > +	struct seccomp_knotif *knotif = NULL, *cur;
> > +	struct seccomp_notif unotif;
> > +	ssize_t ret;
> > +
> > +	memset(&unotif, 0, sizeof(unotif));
> > +
> > +	ret = down_interruptible(&filter->notif->request);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mutex_lock(&filter->notify_lock);
> > +	list_for_each_entry(cur, &filter->notif->notifications, list) {
> > +		if (cur->state == SECCOMP_NOTIFY_INIT) {
> > +			knotif = cur;
> > +			break;
> > +		}
> > +	}
> > +
> > +	/*
> > +	 * If we didn't find a notification, it could be that the task was
> > +	 * interrupted by a fatal signal between the time we were woken and
> > +	 * when we were able to acquire the rw lock.
> > +	 *
> > +	 * This is the place where we handle the extra high semaphore count
> > +	 * mentioned in seccomp_do_user_notification().
> > +	 */
> > +	if (!knotif) {
> > +		ret = -ENOENT;
> > +		goto out;
> > +	}
> > +
> > +	unotif.id = knotif->id;
> > +	unotif.pid = task_pid_vnr(knotif->task);
> > +	if (knotif->signaled)
> > +		unotif.flags |= SECCOMP_NOTIF_FLAG_SIGNALED;
> > +	unotif.data = *(knotif->data);
> 
> Tycho, I forgot everything about seccomp, most probably I am wrong but let me
> ask anyway.
> 
> __seccomp_filter(SECCOMP_RET_TRACE) does
> 
> 		/*
> 		 * Recheck the syscall, since it may have changed. This
> 		 * intentionally uses a NULL struct seccomp_data to force
> 		 * a reload of all registers. This does not goto skip since
> 		 * a skip would have already been reported.
> 		 */
> 		if (__seccomp_filter(this_syscall, NULL, true))
> 			return -1;
> 
> and the next seccomp_run_filters() can return SECCOMP_RET_USER_NOTIF, right?
> seccomp_do_user_notification() doesn't check recheck_after_trace and it simply
> does n.data = sd.
> 
> Doesn't this mean that "unotif.data = *(knotif->data)" can hit NULL ?
> 
> seccomp_run_filters() does populate_seccomp_data() in this case, but this
> won't affect "seccomp_data *sd" passed to seccomp_do_user_notification().

Oof, yes, you're right. Seems like there are no other users of sd in
__seccomp_filter(). Seems to me like we can just do the
populate_seccomp_data() one level higher in __seccomp_filter()?

Tycho


From 9e0f75ea51a2c328567910df3122a236ebeccab0 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.ws>
Date: Tue, 30 Oct 2018 09:51:14 -0600
Subject: [PATCH] seccomp: hoist struct seccomp_data recalculation higher

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 4c5fb6ced4cd..1525cb753ad2 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -257,7 +257,6 @@ static int seccomp_check_filter(struct sock_filter *filter, unsigned int flen)
 static u32 seccomp_run_filters(const struct seccomp_data *sd,
 			       struct seccomp_filter **match)
 {
-	struct seccomp_data sd_local;
 	u32 ret = SECCOMP_RET_ALLOW;
 	/* Make sure cross-thread synced filter points somewhere sane. */
 	struct seccomp_filter *f =
@@ -267,11 +266,6 @@ static u32 seccomp_run_filters(const struct seccomp_data *sd,
 	if (unlikely(WARN_ON(f == NULL)))
 		return SECCOMP_RET_KILL_PROCESS;
 
-	if (!sd) {
-		populate_seccomp_data(&sd_local);
-		sd = &sd_local;
-	}
-
 	/*
 	 * All filters in the list are evaluated and the lowest BPF return
 	 * value always takes priority (ignoring the DATA).
@@ -821,6 +815,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	u32 filter_ret, action;
 	struct seccomp_filter *match = NULL;
 	int data;
+	struct seccomp_data sd_local;
 
 	/*
 	 * Make sure that any changes to mode from another thread have
@@ -828,6 +823,11 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 	 */
 	rmb();
 
+	if (!sd) {
+		populate_seccomp_data(&sd_local);
+		sd = &sd_local;
+	}
+
 	filter_ret = seccomp_run_filters(sd, &match);
 	data = filter_ret & SECCOMP_RET_DATA;
 	action = filter_ret & SECCOMP_RET_ACTION_FULL;
-- 
2.17.1

