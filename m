Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932278AbeBSXRn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 18:17:43 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:53422 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932169AbeBSXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 18:17:41 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Dongsu Park <dongsu@kinvolk.io>
Cc: linux-kernel@vger.kernel.org, containers@lists.linux-foundation.org,
        Alban Crequy <alban@kinvolk.io>, Miklos Szeredi <mszeredi@redhat.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, linux-fsdevel@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>
References: <cover.1512741134.git.dongsu@kinvolk.io>
        <d055925e5d5c0099e9e9c871004fb45fab67e4bc.1512041070.git.dongsu@kinvolk.io>
Date: Mon, 19 Feb 2018 17:16:59 -0600
In-Reply-To: <d055925e5d5c0099e9e9c871004fb45fab67e4bc.1512041070.git.dongsu@kinvolk.io>
        (Dongsu Park's message of "Fri, 22 Dec 2017 15:32:33 +0100")
Message-ID: <87d110lgd0.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1enugW-0005c8-Dm;;;mid=<87d110lgd0.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+L2xJyiCvahVAxZ+yJz8e0OoMMokcsfjI=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Dongsu Park <dongsu@kinvolk.io>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15037 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 3.3 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 1.23 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 2.8 (0.0%),
        tests_pri_-1000: 3.5 (0.0%), tests_pri_-950: 1.40 (0.0%), tests_pri_-900:
        1.03 (0.0%), tests_pri_-400: 23 (0.2%), check_bayes: 22 (0.1%), b_tokenize: 8
        (0.1%), b_tok_get_all: 7 (0.0%), b_comp_prob: 2.1 (0.0%), b_tok_touch_all:
        3.0 (0.0%), b_finish: 0.66 (0.0%), tests_pri_0: 183 (1.2%),
        check_dkim_signature: 0.56 (0.0%), check_dkim_adsp: 3.2 (0.0%),
        tests_pri_500: 14796 (98.4%), poll_dns_idle: 14782 (98.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 09/11] fuse: Restrict allow_other to the superblock's namespace or a descendant
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongsu Park <dongsu@kinvolk.io> writes:

> From: Seth Forshee <seth.forshee@canonical.com>
>
> Unprivileged users are normally restricted from mounting with the
> allow_other option by system policy, but this could be bypassed
> for a mount done with user namespace root permissions. In such
> cases allow_other should not allow users outside the userns
> to access the mount as doing so would give the unprivileged user
> the ability to manipulate processes it would otherwise be unable
> to manipulate. Restrict allow_other to apply to users in the same
> userns used at mount or a descendant of that namespace. Also
> export current_in_userns() for use by fuse when built as a
> module.
>
> Patch v4 is available: https://patchwork.kernel.org/patch/8944671/
>
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> Cc: Serge Hallyn <serge@hallyn.com>
> Cc: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
> Signed-off-by: Dongsu Park <dongsu@kinvolk.io>

Reviewed-by: "Eric W. Biederman" <ebiederm@xmission.com>

> ---
>  fs/fuse/dir.c           | 2 +-
>  kernel/user_namespace.c | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index ad1cfac1..d41559a0 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1030,7 +1030,7 @@ int fuse_allow_current_process(struct fuse_conn *fc)
>  	const struct cred *cred;
>  
>  	if (fc->allow_other)
> -		return 1;
> +		return current_in_userns(fc->user_ns);
>  
>  	cred = current_cred();
>  	if (uid_eq(cred->euid, fc->user_id) &&
> diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
> index 246d4d4c..492c255e 100644
> --- a/kernel/user_namespace.c
> +++ b/kernel/user_namespace.c
> @@ -1235,6 +1235,7 @@ bool current_in_userns(const struct user_namespace *target_ns)
>  {
>  	return in_userns(target_ns, current_user_ns());
>  }
> +EXPORT_SYMBOL(current_in_userns);
>  
>  static inline struct user_namespace *to_user_ns(struct ns_common *ns)
>  {
