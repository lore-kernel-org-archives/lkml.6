Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1668128-1522354157-2-6413332265252634412
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522354156; b=KpBJU7Wp4FxF/an8rf6Sss08uTMP4wUdBhCO6RtC4xgTRp9hvL
    olr4sg7lPoaa0aokBeo67YJNryYuw2BqgxEjz3treK+4lseQtLGctvIV+peEc6rC
    PEgczX4FzFLJaKYbixtJaFryCG2IBaqNTvcRV4ewAtaUBPSJ8muOMiAoot5lMB9v
    2RbqbDU6SQb15Q69cegGUTha+vLOJ7SjjRQeR6ng2p77lQFhbrPTMZ7MZjktReJT
    la0uCdzCNVW6nz8Ynm1yXr0YkkIc732q+K6K7IptLDE3LKG6MwSwxv2jHq1munK0
    Yws8wPrAtE9fWSRvn1tegoRzJLV4h++KCrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:content-transfer-encoding
    :subject:sender:list-id; s=fm2; t=1522354156; bh=nGMQjKnwFuTRtec
    EuyTqPC22e6tDWftB4Nq60hBNOow=; b=v1d1YttUvJ+XvcPZslLroaKQLSDHHRZ
    JgqTlYQ2oaZW0EzglhT1vCQvkMh2u6jmI+RicC1t5NUxxX+Hscj1vEAoJRI9nL9F
    F9uIM+FKxyanOHSp4PNfR1wuDP4qR7gnzV3sUFdq2dOq3Fw1K6Qi/FIQuXsbUBB2
    wL9Wy6rcITkSHx5rbBKEGXzRq0tEUiSg0/gCPFge79Y7Ui1fk0X64Xw5iFtJfDu/
    u2CQBNtl4Xnvi8telVIAiax1GmjUqk3je+u+BW7dK9g0WVnW+6rPdDKZtvIZrE1t
    DPSZ7hvQfCx3qxGH4T9IhOI+vIFn1TFqHMlz5kY8dRGOoE4Z2ocaMmg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAzi7aeZMiteWka7/40rslnx/azVylvKD0g/SLhbUGwy2bH7eAQYidFsZpVDXefNsoCmjgeI6W9GQCi6dMax0Vibrl5PDLbivfHCS2GwxYH1gWnq/XmN
    tdIikbR5HAVsbb+U3UHJIK17p88n0fWYBpZzYryGFQ6ANUc36J1hZ/l1+5wvZNwUKm4UZ6F0EUqniWBhB9jD3aYTuJ2Xt3Bvl1p9XsfHhUqS+qHIGkIumSkk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=MqK6kde1AAAA:8 a=VwQbUJbxAAAA:8 a=v-RI6n78F2ETEq2ysUIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=9aqP8kKXEzZd0rnup5AB:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeC2UJN convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Thu, 29 Mar 2018 16:09:13 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:52496 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751082AbeC2UJM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 29 Mar 2018 16:09:12 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Waiman Long <longman@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Stanislav Kinsbursky <skinsbursky@parallels.com>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-api@vger.kernel.org
References: <1520885744-1546-1-git-send-email-longman@redhat.com>
        <1520885744-1546-5-git-send-email-longman@redhat.com>
        <87woyfyh57.fsf@xmission.com>
        <5d4a858a-3136-5ef4-76fe-a61e7f2aed56@redhat.com>
        <87o9jru3bf.fsf@xmission.com>
        <935a7c50-50cc-2dc0-33bb-92c000d039bc@redhat.com>
        <87woyego2u.fsf_-_@xmission.com>
        <047c6ed6-6581-b543-ba3d-cadc543d3d25@redhat.com>
        <87h8ph6u67.fsf@xmission.com>
        <7d3a1f93-f8e5-5325-f9a7-0079f7777b6f@redhat.com>
        <20180329021409.gcjjrmviw2lckbfk@linux-n805>
        <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com>
Date: Thu, 29 Mar 2018 15:08:01 -0500
In-Reply-To: <3e201de2-bed2-6f7d-0783-700d095142e0@colorfullife.com> (Manfred
        Spraul's message of "Thu, 29 Mar 2018 10:47:45 +0200")
Message-ID: <87y3ia3ase.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1f1dr6-0001mC-GI;;;mid=<87y3ia3ase.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+bzGMlP7Kq5tqGNqizT3u+KsbSXhZ2tZk=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa03.xmission.com
X-Remote-Spam-Level: *
X-Remote-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG
        autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: *;Manfred Spraul <manfred@colorfullife.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1390 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.2%), b_tie_ro: 2.1 (0.2%), parse: 1.60 (0.1%),
        extract_message_metadata: 28 (2.0%), get_uri_detail_list: 4.3 (0.3%),
        tests_pri_-1000: 11 (0.8%), tests_pri_-950: 2.3 (0.2%), tests_pri_-900: 1.90
        (0.1%), tests_pri_-400: 40 (2.9%), check_bayes: 38 (2.7%), b_tokenize: 17
        (1.2%), b_tok_get_all: 9 (0.6%), b_comp_prob: 4.7 (0.3%), b_tok_touch_all:
        3.5 (0.3%), b_finish: 0.89 (0.1%), tests_pri_0: 1273 (91.6%),
        check_dkim_signature: 1.09 (0.1%), check_dkim_adsp: 5.0 (0.4%),
        tests_pri_500: 22 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] ipc: Remove IPCMNI
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Manfred Spraul <manfred@colorfullife.com> writes:

>>>>> On 03/14/2018 08:49 PM, Eric W. Biederman wrote:
>>>>>> To make it possible to keep checkpoint/restore working I have renamed
>>>>>> the sysctls from xxx_next_id to xxx_nextid.  That is enough change that
>>>>>> a smart CRIU implementation can see that what is exported has changed,
>>>>>> and act accordingly.  New kernels will be able to restore the old id's.
>>>>>>
>>>>>> This code still needs some real world testing to verify my assumptions.
>>>>>> And some work with the CRIU implementations to actually add the code
>>>>>> that deals with the new for of id assignment.
>>>>>>
> It means that all existing checkpoint/restore application will not work with a
> new kernel.
> Everyone must first update the checkpoint/restore application, then update the
> kernel.
>
> Is this acceptable?

There is no nead.

I just reread through how next_id is implementated in ipc/util.c and I
had been reading it wrong.  There is no need to change the sysctl.

What criu needs is an interface that specifies the next_id to allocate
both the high and the low bits and that is what this the sysctl
provides.

The implemenation could use a little cleanup so it is easier to
understand something like this perhaps:

diff --git a/ipc/util.c b/ipc/util.c
index 3783b7991cc7..2d4ec6e5b70b 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -192,46 +192,32 @@ static struct kern_ipc_perm *ipc_findkey(struct ipc_ids *ids, key_t key)
 	return NULL;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
-/*
- * Specify desired id for next allocated IPC object.
- */
-#define ipc_idr_alloc(ids, new)						\
-	idr_alloc(&(ids)->ipcs_idr, (new),				\
-		  (ids)->next_id < 0 ? 0 : ipcid_to_idx((ids)->next_id),\
-		  0, GFP_NOWAIT)
-
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
-{
-	if (ids->next_id < 0) { /* default, behave as !CHECKPOINT_RESTORE */
-		new->seq = ids->seq++;
-		if (ids->seq > IPCID_SEQ_MAX)
-			ids->seq = 0;
-	} else {
-		new->seq = ipcid_to_seqx(ids->next_id);
-		ids->next_id = -1;
-	}
 
-	return SEQ_MULTIPLIER * new->seq + id;
-}
-
-#else
-#define ipc_idr_alloc(ids, new)					\
-	idr_alloc(&(ids)->ipcs_idr, (new), 0, 0, GFP_NOWAIT)
-
-static inline int ipc_buildid(int id, struct ipc_ids *ids,
-			      struct kern_ipc_perm *new)
+static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 {
+	int id;
+#ifdef CONFIG_CHECKPOINT_RESTORE
+	if (unlikely(new->id >= 0)) {
+		int idx = ipcid_to_idx(new->id);
+		id = idr_alloc(&ids->ipcs_idr, new, idx, 0, GFP_NOWAIT);
+		if (id < 0)
+			return id;
+		if (id != idx) {
+			idr_remove(&ids->ipcs_idr, id);
+			return -EBUSY;
+		}
+		new->seq = ipcid_to_seqx(new->id);
+		return id;
+	}
+#endif
+	id = idr_alloc(&ids->ipcs_idr, new, 0, 0, GFP_NOWAIT);
 	new->seq = ids->seq++;
 	if (ids->seq > IPCID_SEQ_MAX)
 		ids->seq = 0;
-
-	return SEQ_MULTIPLIER * new->seq + id;
+	new->id = SEQ_MULTIPLIER * new->seq + id;
+	return id;
 }
 
-#endif /* CONFIG_CHECKPOINT_RESTORE */
-
 /**
  * ipc_addid - add an ipc identifier
  * @ids: ipc identifier set
@@ -269,6 +255,10 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	new->cuid = new->uid = euid;
 	new->gid = new->cgid = egid;
 
+	new->id = ids->next_id;
+	if (new->id >= 0)
+		ids->next_id = -1;
+
 	id = ipc_idr_alloc(ids, new);
 	idr_preload_end();
 
@@ -290,8 +280,6 @@ int ipc_addid(struct ipc_ids *ids, struct kern_ipc_perm *new, int limit)
 	if (id > ids->max_id)
 		ids->max_id = id;
 
-	new->id = ipc_buildid(id, ids, new);
-
 	return id;
 }
 

Eric
