Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2182782-1527602708-2-18291085495960906925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527602708; b=CzFgvhA5NqY3bEfFZfhgBUVBzASjfg8ycet6IVr4OTmhpZq+tg
    msuY7eeGKUKyFb2IxaZpce2Pcpso2fygx9zofaNgIvD7t629llku58IpMBHkeixW
    g8ldQiP33AbgQ+E4roc1OHyQgviVxA0J42WWANwSZtUvPCENrL7Yi+P+K8nF12lm
    Mz7JlcDWCwXOxRV2uNn7ujpSrBQ2mDesufXz+9B9sdq4lswns98GmPply3KN/c7A
    IEnmq1PNg1Dx4vJJwWq+DqUSWnC169HDdfHGx330tXtrW/o13hNsVyDR7ZgTgdMf
    LjvIojleALG6DoR4wTpB+m4KMgFFaZQcd5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527602708; bh=iteibNqdKTRKnzJI4WF8J32UPIdvdZQWPPUxNzQHBP
    g=; b=hEf3FTWWsinpEIBupWKxbEWC8pDRSb3AI2iuCeo+0S1LbEFyF37dhwXXPg
    NZ52dtcDLJP/qTgn9A7cQK+vVMh+nQtOl9Ac0rUPDWw7PGSb31Gmynn8SyY+CRVq
    HCcO3MzaMgHVNGc2qnz47osOXrRLbDPHCeo40VD/K3nWBks9vT6c9JHakIQPj2YX
    nDSZhUEV5h8NOWpNMphyZNDIKxyYf75HHpbZuEzBXCckaVBrG/VGqd34JAjM6niq
    L5z+Lwjd0OQgIrV1trZ2IfJ77eT/LkwV6AiifGAy8IQic1gDJB0q/pxNvMIpJuXM
    5QFCv1F9oWEP9huY0sVNsERPLjYw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIQTKrKLBM1i1lvfwb419R8VOHG+pP3QXDIHU9xfxL5usW+VqX+iAmzfZZvnHkwKVsx0L8oRubNaHjYcj7otoZjAx2C9ql/UdxdSbN0RjhVy1z4RRQ3J
    26KS/FYek6pCx+UWNFWyJ29R428v7uQ1aqG3gE1D25oyc+5iLTyioQ+mec3NPe+EEH85IPQQhkqUEEYcdAN0zAzsFcYzLVk4JwNbi1Txv+AOUvGkzgND4eJQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=PtDNVHqPAAAA:8
    a=fZ-IbcNlvkBN4FvK0isA:9 a=BpimnaHY1jUKGyF_4-AF:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934240AbeE2OFC (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 10:05:02 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48075 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751572AbeE2OFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 May 2018 10:05:01 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
        lkml <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87r2mre5b3.fsf@xmission.com> <87wovubbdf.fsf@xmission.com>
        <877enmskec.fsf@xmission.com>
        <CAOssrKdS9gOsZrNfqJbk_j0Z8-hrqrYWW+=_Z5mUEX1KE-Kw6Q@mail.gmail.com>
        <87zi0io90k.fsf@xmission.com>
Date: Tue, 29 May 2018 09:04:46 -0500
In-Reply-To: <87zi0io90k.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 29 May 2018 09:02:03 -0500")
Message-ID: <87tvqqo8w1.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNfFE-0002Xf-1z;;;mid=<87tvqqo8w1.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19AlZoqUXp/VQWju1eNtqP1D+ly1RVhIhA=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Miklos Szeredi <mszeredi@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 409 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.3 (0.8%), b_tie_ro: 2.2 (0.5%), parse: 1.23 (0.3%),
        extract_message_metadata: 29 (7.0%), get_uri_detail_list: 5 (1.3%),
        tests_pri_-1000: 10 (2.5%), tests_pri_-950: 2.1 (0.5%), tests_pri_-900: 1.64
        (0.4%), tests_pri_-400: 28 (6.9%), check_bayes: 26 (6.5%), b_tokenize: 9
        (2.2%), b_tok_get_all: 6 (1.4%), b_comp_prob: 2.9 (0.7%), b_tok_touch_all:
        2.2 (0.5%), b_finish: 0.78 (0.2%), tests_pri_0: 322 (78.7%),
        check_dkim_signature: 0.83 (0.2%), check_dkim_adsp: 4.7 (1.1%),
        tests_pri_500: 7 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] fuse: Allow fully unprivileged mounts
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Now that the fuse and the vfs work is complete.  Allow the fuse filesystem
to be mounted by the root user in a user namespace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 22c76cf8c2e3..48baa26993f3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1222,7 +1222,7 @@ static void fuse_kill_sb_anon(struct super_block *sb)
 static struct file_system_type fuse_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "fuse",
-	.fs_flags	= FS_HAS_SUBTYPE,
+	.fs_flags	= FS_HAS_SUBTYPE | FS_USERNS_MOUNT,
 	.mount		= fuse_mount,
 	.kill_sb	= fuse_kill_sb_anon,
 };
-- 
2.14.1
