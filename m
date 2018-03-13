Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933381AbeCMQlv (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:41:51 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:40720 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932752AbeCMQlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:41:47 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christian Brauner <christian.brauner@ubuntu.com>
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, containers@lists.linux-foundation.org
References: <20180313121713.32551-1-christian.brauner@ubuntu.com>
Date: Tue, 13 Mar 2018 11:41:00 -0500
In-Reply-To: <20180313121713.32551-1-christian.brauner@ubuntu.com> (Christian
        Brauner's message of "Tue, 13 Mar 2018 13:17:09 +0100")
Message-ID: <87y3iw0vz7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evmzi-000392-CZ;;;mid=<87y3iw0vz7.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18/5+vnbrVbB2YfVrjTl464xb8XRukKi9s=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christian Brauner <christian.brauner@ubuntu.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 232 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.5 (1.1%), b_tie_ro: 1.65 (0.7%), parse: 0.93 (0.4%),
        extract_message_metadata: 16 (6.9%), get_uri_detail_list: 1.91 (0.8%),
        tests_pri_-1000: 12 (5.2%), tests_pri_-950: 1.73 (0.7%), tests_pri_-900: 1.42
        (0.6%), tests_pri_-400: 26 (11.1%), check_bayes: 25 (10.6%), b_tokenize: 6
        (2.8%), b_tok_get_all: 9 (3.9%), b_comp_prob: 2.1 (0.9%), b_tok_touch_all: 5
        (2.2%), b_finish: 0.65 (0.3%), tests_pri_0: 162 (69.9%),
        check_dkim_signature: 0.64 (0.3%), check_dkim_adsp: 2.5 (1.1%),
        tests_pri_500: 6 (2.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 0/4 v5] devpts: handle bind-mounts correctly
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Brauner <christian.brauner@ubuntu.com> writes:

> Hey everyone,
>
> This is the fith iteration of this patch. Per-patch changes are
> summarized in the individual patches:

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

I guess we need to answer the question do I pick up this series or does
gregkh.  This series would seem to fit in his tty tree.

You haven't copied gregkh so you may need to resend and do that.

Eric


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
