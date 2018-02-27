Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751706AbeB0DP2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 22:15:28 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:54393 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751530AbeB0DP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 22:15:26 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>,
        Seth Forshee <seth.forshee@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>, Dongsu Park <dongsu@kinvolk.io>,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <87po4rz4ui.fsf_-_@xmission.com>
        <20180226235302.12708-3-ebiederm@xmission.com>
        <CA+55aFySgJyR6JLcS9HLC9wEpWU1isdyTkchHxZHbJWsh7HFpg@mail.gmail.com>
        <87r2p7rvn5.fsf@xmission.com>
Date: Mon, 26 Feb 2018 21:14:52 -0600
In-Reply-To: <87r2p7rvn5.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 26 Feb 2018 20:53:02 -0600")
Message-ID: <87tvu3qg2b.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eqVjg-0005Hj-1u;;;mid=<87tvu3qg2b.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18lciZOkS3VvAKUd8tgK9bGbCtcAsgMIbI=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa08 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 265 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.8 (1.4%), b_tie_ro: 2.7 (1.0%), parse: 0.86 (0.3%),
        extract_message_metadata: 11 (4.3%), get_uri_detail_list: 2.7 (1.0%),
        tests_pri_-1000: 4.4 (1.7%), tests_pri_-950: 1.07 (0.4%), tests_pri_-900:
        0.88 (0.3%), tests_pri_-400: 24 (9.0%), check_bayes: 23 (8.6%), b_tokenize: 7
        (2.6%), b_tok_get_all: 8 (3.2%), b_comp_prob: 2.1 (0.8%), b_tok_touch_all:
        3.1 (1.2%), b_finish: 0.81 (0.3%), tests_pri_0: 213 (80.2%),
        check_dkim_signature: 0.41 (0.2%), check_dkim_adsp: 3.3 (1.3%),
        tests_pri_500: 3.5 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v7 3/7] fs/posix_acl: Document that get_acl respects ACL_DONT_CACHE
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

2> So the purpose for having a patch in the first place is that
> 2a3a2a3f3524 ("ovl: don't cache acl on overlay layer")
> which addded ACL_DONT_CACHED did not result in any comment updates
> to get_acl.
>
> Which mean that if you read the comments in get_acl() that you
> don't even think of ACL_DONT_CACHED.
>
> Which means that this comment:
> 	/*
> 	 * If the ACL isn't being read yet, set our sentinel.  Otherwise, the
> 	 * current value of the ACL will not be ACL_NOT_CACHED and so our own
> 	 * sentinel will not be set; another task will update the cache.  We
> 	 * could wait for that other task to complete its job, but it's easier
> 	 * to just call ->get_acl to fetch the ACL ourself.  (This is going to
> 	 * be an unlikely race.)
> 	 */
>
> Which presumes the only reason the acl could be anything other
> ACL_NOT_CACHED is because get_acl() is already being called upon it in
> another task.
>
> I wanted something to mention ACL_DONT_CACHED so someone would at least
> think about that case if they ever step up to modify the code.
>
> The code is perfectly clear, the comment is not.   That scares me.
>
> And I had to read the code about a dozen times before I realized the
> ACL_DONT_CACHED case even exists.   Not useful when I am need to use
> that to preserve historical fuse semantics.
>
> So something is missing here even if my wording does not improve things.
>
>
>
> Then we get this comment:
> 	/*
> 	 * Normally, the ACL returned by ->get_acl will be cached.
> 	 * A filesystem can prevent that by calling
> 	 * forget_cached_acl(inode, type) in ->get_acl.
> 	 */
>
> Which was added in b8a7a3a66747 ("posix_acl: Inode acl caching fixes")
> That comment is and always has been rubbish.
>
> I don't have a clue what it is trying to say but it is not something
> a person can use to write filesystem code with.
>
>
> Truths:
> - forget_cached_acl(inode, type) can be used to invalidate the acl
>   cache.
>
> - Calling forget_cached_acl from within the filesystems ->get_acl
>   method won't prevent a cached value from being returend because
>   ->get_acl will be set.
>
> - Calling forget_cached_acl from within the filesystems ->get_acl
>   method won't prevent a returned value from being cached
>   because it the caching happens after ->get_acl returns.

Sigh.  Yes it will because we set the special sentinel value,
and forget_cached_acl will replace the sentinel value with
ACL_NOT_CACHED.

It is a terribly brittle and racy thing to do, and it probably won't
work to say cache this acl but not this one on a case by case bases
in ->get_acl.

As such I believe that usage of forget_cached_acl should be subsumed by
using ACL_NOT_CACHED.  If not we should really come up with a different
helper function name to call from ->get_acl.  Preferably one that does
"cmpxchng(p, sentinel, ACL_NOT_CACHED)" so that we remove the races.


> - Setting inode->i_acl = ACL_DONT_CACHE is the only way to prevent
>   a value from ->get_acl from being cached.
>   
>
> In summary I only care about two things.
> 1) ACL_NOT_CACHED being mentioned somewhere in get_acl so people looking
>    at the code, and people updating the code will have a hint that they
>    need to consider that case.
>
> 2) That misleading completely bogus comment being removed/fixed.
>
>
> And yes I agree the code is clear.  The comments are not.
>
>
> Does this look better as a comment updating patch?
>
> diff --git a/fs/posix_acl.c b/fs/posix_acl.c
> index 2fd0fde16fe1..5453094b8828 100644
> --- a/fs/posix_acl.c
> +++ b/fs/posix_acl.c
> @@ -98,6 +98,11 @@ struct posix_acl *get_acl(struct inode *inode, int type)
>         struct posix_acl **p;
>         struct posix_acl *acl;
>  
> +       /*
> +        * To avoid caching the result of ->get_acl
> +        * set inode->i_acl = inode->i_default_acl = ACL_DONT_CACHE;
> +        */
> +
>         /*
>          * The sentinel is used to detect when another operation like
>          * set_cached_acl() or forget_cached_acl() races with get_acl().
> @@ -126,9 +131,7 @@ struct posix_acl *get_acl(struct inode *inode, int type)
>                 /* fall through */ ;
>  
>         /*
> -        * Normally, the ACL returned by ->get_acl will be cached.
> -        * A filesystem can prevent that by calling
> -        * forget_cached_acl(inode, type) in ->get_acl.
> +        * The ACL returned by ->get_acl will be cached.
>          *
>          * If the filesystem doesn't have a get_acl() function at all, we'll
>          * just create the negative cache entry.
>
> Eric
