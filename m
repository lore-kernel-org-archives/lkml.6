Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-865074-1527118051-2-4346747561875451623
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527118051; b=D9SL0WSYh/p1KX868q5yL4Rptd0dAKHokTZPsTavBvlRncoY57
    rVaEs9eC9fsjWBBjgCbDUzVHJIy8FKRURg0t2un+xty421yIlr6affEP4O+KN2CM
    zqf26d8DWMZort3bvdQ02cLUiIBIY7a+IsH9xEYFTH7JF3MENx6jST82PzkTd8WQ
    ltsduifF/AD66llfHpUicVy9xSoRmr8gSO7Bg0zhfaED9hrXAMd6EcVYQowMev6S
    8TaFt8x7gGDGdu80E9csVgrzQLbDKN4AKGcMOMz537JJUAY6hGCDPQQxodVcOYin
    hvvf4gVrjFoZD+d1/RMPHBZmXBIu9eBKnbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:date:message-id:in-reply-to
    :references:subject:sender:list-id; s=fm2; t=1527118051; bh=77G7
    GW58lYKdDoQfUhYC6LT5q4BZBJVIfqiOHZSFYPE=; b=WoTD62KxGefIJa4sc487
    0H68w7x3Tbtgb3dhlkKGMFdNDn2HEEGqWD8FWsqlt8Xj1QtN9BR5UGOhD/2sEH3Q
    V2l/K32hSCyV7fazzrSmFhC+HphFLPr89AfLERYuohM3zCU0/wmUrZzm8yDLUcAb
    XTbu5VEaaGGYEP0LiCESOC0WNC2mGms8KR7kHrh6a8aWp+HPUkJJNr3kT+uPJYGd
    VDRC3Nsypsc5U4oOLPJWSXuiJ1UTRSskWbZDytFOsOjrMTNjOk+kUajDac5+J9nk
    dBJA+SBvm/BcQmBgg4tI/tY3xVPqZwxrCPZ1AeUzVdLsVBxwhOPfqF7P+axBD4iQ
    iA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJJJuAZPDR+8J//+Q5xE6RG8Yhij4UoiMEdTINd16B8+oNF5y3yCqugC56gix4aBg/w9IXl5qHMHgOr3XrB3cCQUXcK8sbhRYc16wdGNpSjRF6Xnn4j+
    RL7rLDzunVo1kBgWGaAoQonwX8/Ww2Or5+wvHR4LbRL8oSAwECI4UasaFlcNCr+tye3SJQKiFUPcONJfpzMpMZEWE6T3V1BQuPQp0/GfR+e0hlCXt5wQHWMb
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=DfNHnWVPAAAA:8
    a=PtDNVHqPAAAA:8 a=C-0Pfo1iK-InrBjRf6sA:9 a=rjTVMONInIDnV1a_A2c_:22
    a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935206AbeEWX1Z (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 19:27:25 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:48391 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934671AbeEWX0w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 May 2018 19:26:52 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
        Seth Forshee <seth.forshee@canonical.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>
Date: Wed, 23 May 2018 18:25:38 -0500
Message-Id: <20180523232538.4880-6-ebiederm@xmission.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <87o9h6554f.fsf@xmission.com>
References: <87o9h6554f.fsf@xmission.com>
X-XM-SPF: eid=1fLd9f-0004ID-1l;;;mid=<20180523232538.4880-6-ebiederm@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/I61cfMWaen0e5W957GYQ4fe/6YGdNFRE=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Linux Containers <containers@lists.linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 162 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.8 (1.7%), b_tie_ro: 1.89 (1.2%), parse: 0.67 (0.4%),
        extract_message_metadata: 12 (7.7%), get_uri_detail_list: 0.97 (0.6%),
        tests_pri_-1000: 7 (4.1%), tests_pri_-950: 1.15 (0.7%), tests_pri_-900: 0.95
        (0.6%), tests_pri_-400: 16 (9.9%), check_bayes: 15 (9.3%), b_tokenize: 4.8
        (3.0%), b_tok_get_all: 4.5 (2.8%), b_comp_prob: 1.38 (0.9%), b_tok_touch_all:
        2.5 (1.5%), b_finish: 0.60 (0.4%), tests_pri_0: 115 (71.0%),
        check_dkim_signature: 0.43 (0.3%), check_dkim_adsp: 2.7 (1.7%),
        tests_pri_500: 4.0 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 6/6] fs: Allow CAP_SYS_ADMIN in s_user_ns to freeze and thaw filesystems
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Seth Forshee <seth.forshee@canonical.com>

The user in control of a super block should be allowed to freeze
and thaw it. Relax the restrictions on the FIFREEZE and FITHAW
ioctls to require CAP_SYS_ADMIN in s_user_ns.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index 4823431d1c9d..b445b13fc59b 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -549,7 +549,7 @@ static int ioctl_fsfreeze(struct file *filp)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* If filesystem doesn't support freeze feature, return. */
@@ -566,7 +566,7 @@ static int ioctl_fsthaw(struct file *filp)
 {
 	struct super_block *sb = file_inode(filp)->i_sb;
 
-	if (!capable(CAP_SYS_ADMIN))
+	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 
 	/* Thaw */
-- 
2.14.1
