Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AG47ELuToMy5fnkJjynODDUkulOC2CjZgCm4COvh6Vphg7RJqvGFFJHcT5qufjM4Lm2xN2CmHhJd
ARC-Seal: i=1; a=rsa-sha256; t=1520962419; cv=none;
        d=google.com; s=arc-20160816;
        b=wy9aX65LrDqQDL987jJuk4ezIvqXOanpPD2wX2PyGyZHnivJ8HUcEbw68Xooa+yqD0
         9C1vr+pXHAwcdZy+hZQeFQefvZjSY1yi+4ofZ8ErgfnIBc85W781tCmMgP3jHilqrO7v
         Pq9R8uGDjUKwtJ7GkbP3b35q9HNrlblLqlmjIxeEghcnWoOMu1Dh5/SqT3xyQ2fzI6fN
         0oLwkpZ7xy8ztb6HL5xq4hLDJ280KJ7iG6U4tMkZCfWG8T58ABJTQZsATuVPDrP29qMp
         7OVJp+X6Ng/29yRbx4bMIoHCw5dKlaZbBnXMqg+JUoEePruGFuBSEgzvaYbTTl3QowUa
         Iwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:mime-version:user-agent:message-id:in-reply-to:date
         :references:cc:to:from:arc-authentication-results;
        bh=waWZDWbkYUtvyZGaNoSkYL8aP26gTbMXPIRf7VXeuj0=;
        b=pE+HzIxZwnYiDsxMfAoNkEygFWR3v4Xm0nCpUUVz815ZLT3F4y2mirWDjp9Hw5tRTG
         bH9LiGRAetLVCEK9PjxA+Y4C/0DQ+VdmCFgLjXBgAhder0Jso4Oxf0w+d7YCPQ6STndr
         QKVORYIvcumHobstwXwvvv9w9HEzH7DH0oP4QrbxXA8eJC9n4W8eo/w/lMcThuDM1CB2
         jUXjX1Qr2rqmclV2H8zDThtJKUDaGckz+yywaUP+dxs8i0Voto3yzdeunAkZlVBwGf/3
         AHp+Xu2Nsa/WJXwUL90+EWz3zsqBzgcxXI7NSt0OYIO+zSnMJJXwSUWidTWGbN2Mri9F
         k1Jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk,  linux-kernel@vger.kernel.org,  torvalds@linux-foundation.org,  gregkh@linuxfoundation.org,  containers@lists.linux-foundation.org
References: <20180313165527.24038-1-christian.brauner@ubuntu.com>
Date: Tue, 13 Mar 2018 12:32:37 -0500
In-Reply-To: <20180313165527.24038-1-christian.brauner@ubuntu.com> (Christian
	Brauner's message of "Tue, 13 Mar 2018 17:55:23 +0100")
Message-ID: <87o9jr285m.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evnnf-0008Mq-NK;;;mid=<87o9jr285m.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8zONZg2y9RCLuJMzl1CUJ0MZ/IJm+q5I=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.7 XMSubLong Long Subject
	*  1.5 XMNoVowels Alpha-numberic number with no vowels
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
	*  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15024 ms - load_scoreonly_sql: 0.06 (0.0%),
	signal_user_changed: 2.4 (0.0%), b_tie_ro: 1.57 (0.0%), parse: 0.82 (0.0%),
	extract_message_metadata: 13 (0.1%), get_uri_detail_list: 1.64 (0.0%),
	tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
	0.98 (0.0%), tests_pri_-400: 27 (0.2%), check_bayes: 26 (0.2%), b_tokenize: 6
	(0.0%), b_tok_get_all: 9 (0.1%), b_comp_prob: 1.96 (0.0%), b_tok_touch_all: 7
	(0.0%), b_finish: 0.55 (0.0%), tests_pri_0: 167 (1.1%), check_dkim_signature:
	0.55 (0.0%), check_dkim_adsp: 3.6 (0.0%), tests_pri_500: 14807 (98.6%),
	poll_dns_idle: 14798 (98.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4 v5 RESEND] devpts: handle bind-mounts correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594842295484827893?=
X-GMAIL-MSGID: =?utf-8?q?1594844690435373980?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Resending to CC grekh.



Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

And the first two patches can also have
Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

Greg this patchset looks read or just about ready to be merged.  Do you
want to take this through your tty tree or should I take it through my
tree.

Eric



>
> Hey everyone,
>
> This is the fith iteration of this patch. Per-patch changes are
> summarized in the individual patches:
>
> ChangeLog v4->v5:
> * added non-functional patch to document devpts_mntget().
>   Reason for putting this in a separate patch is that it allows you,
>   Linus and Eric, to simply drop it if judged useless.
> * reverse error handling logic to further simplify
> * dput() dentry in the non-function patch. This was not really a problem
>   since the following patch included a fix for it. But better to get it
>   right in all individual patches.
> * I did another rewrite of the problem analysis for
>   posterity in the patch "Subject: [PATCH 2/3 v3] devpts: resolve devpts
>   bind-mounts" and in this cover letter.
>
> ChangeLog v3->v4:
> * small logical simplifications
> * add test that bind-mounts of /dev/pts/ptmx to locations that do not
>   resolve to a valid slave pty path under the originating devpts mount
>   fail
>
> ChangeLog v2->v3:
> * rewritten commit message to thoroughly analyse the problem for
>   posterity in the patch "Subject: [PATCH 2/3 v3] devpts: resolve devpts
>   bind-mounts" and in this cover letter.
> * extended selftests to test for correct handling of /dev/pts/ptmx
>   bind-mounts to /dev/ptmx and non-standard devpts mounts such as
>   mount -t devpts devpts /mnt
>
> ChangeLog v1->v2:
> * see individual patches
> ChangeLog v0->v1:
> * see individual patches
>
> Christian Brauner (4):
>   devpts: hoist out check for DEVPTS_SUPER_MAGIC
>   devpts: resolve devpts bind-mounts
>   devpts: comment devpts_mntget()
>   selftests: add devpts selftests
>
>  fs/devpts/inode.c                                |  66 +++--
>  tools/testing/selftests/Makefile                 |   1 +
>  tools/testing/selftests/filesystems/.gitignore   |   1 +
>  tools/testing/selftests/filesystems/Makefile     |   2 +-
>  tools/testing/selftests/filesystems/devpts_pts.c | 313 +++++++++++++++++++++++
>  5 files changed, 363 insertions(+), 20 deletions(-)
>  create mode 100644 tools/testing/selftests/filesystems/devpts_pts.c
