Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AG47ELuCrZNM604Hh2ZNzBd0xtpcmj7kk14mA+E+EQKLBxZKD6Fsg5g+1hm0OM6JKC6T/PBfv8sD
ARC-Seal: i=1; a=rsa-sha256; t=1521696072; cv=none;
        d=google.com; s=arc-20160816;
        b=cCsdtNdzHeo0uqFVqazJDrx8MOFGh1omlRIc66tWa1aALGZmV3yasCkhYu9PVPR59b
         ycgLbW5hRYuChJm2Mlye5/RzfpdAOY6FV5K8eCHQXNVbFQxYPyGIa4KPJQt+FjxGr7lX
         e7tCXu+5qTLxeln9gHQXuPUe+jwHuNJGIGyP77bwIvEFUFrXC9VjS8Hmkgkjp46c/O6R
         KqwqS5gmBgfmPAxJFmhgcum0RJugd7/Jre15bT0N6KnzqUEVg029SbWzFdnapyGaVt/b
         P+MYd65qXcEAhbTwQk1EiqFd7jBvmvs8ln0/NtIhDV/2DMGduj0bKA2/NjB5yVx4ivDz
         L6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:user-agent
         :message-id:in-reply-to:date:references:cc:to:from
         :arc-authentication-results;
        bh=CjoAVe1z9zLvM3i4EAGmVydJudcDfELURJYcEip/2rs=;
        b=lmFHeb3Gq/WlJ7CRqyQd8qOcBL4K/5rCKt6VG9TIYnEgtQT6V3UVsUakEGdzWrNdn0
         TK2R60rK7OexIiwEuWOOsa/6HzEyi0AGqygahNfHLVksoOddqWa3f/2v8DdLDF5WyOs8
         ItulC48Z+pkVMnsyiD1JUbQFJOdPuOiswurgq94wktovVKbzTDXasEZKpuIbW3lRHD/b
         po+343hd1AA3RIfwcP5T4WvzkTua9gVlb3jktJsSpCY7udhtaPmk2BPs5TVjdntlvp34
         CgQroiM0XBlB8WSPaFU6G7zLHKJxolG/uI6ztj+7Y7JSv447SbnYHLsFDdNWWJUcoU2p
         tuIA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.232 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,  Alexander
 Viro <viro@zeniv.linux.org.uk>,  "J. Bruce Fields" <bfields@fieldses.org>,
  Thomas Gleixner <tglx@linutronix.de>,  Daniel P . =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9?= <berrange@redhat.com>,  Kate Stewart
 <kstewart@linuxfoundation.org>,  Dan Williams <dan.j.williams@intel.com>,
  Philippe Ombredanne <pombredanne@nexb.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
References: <20180317142520.30520-1-jlayton@kernel.org>
	<20180317165859.26200-1-jlayton@kernel.org>
Date: Thu, 22 Mar 2018 00:19:59 -0500
In-Reply-To: <20180317165859.26200-1-jlayton@kernel.org> (Jeff Layton's
	message of "Sat, 17 Mar 2018 12:58:59 -0400")
Message-ID: <87bmfgvg8w.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1eysek-0007bq-I5;;;mid=<87bmfgvg8w.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19nLicMZ5LjEAbSgmNbpi0rMuRb1uJG6BQ=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	*  0.0 TVD_RCVD_IP Message was received from an IP address
	*  0.7 XMSubLong Long Subject
	*  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
	*  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
	*      [score: 0.5000]
	* -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
	*      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jeff Layton <jlayton@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15028 ms - load_scoreonly_sql: 0.07 (0.0%),
	signal_user_changed: 3.5 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 1.60 (0.0%),
	extract_message_metadata: 7 (0.0%), get_uri_detail_list: 4.1 (0.0%),
	tests_pri_-1000: 3.2 (0.0%), tests_pri_-950: 1.24 (0.0%), tests_pri_-900:
	1.03 (0.0%), tests_pri_-400: 31 (0.2%), check_bayes: 30 (0.2%), b_tokenize:
	11 (0.1%), b_tok_get_all: 9 (0.1%), b_comp_prob: 3.2 (0.0%), b_tok_touch_all:
	3.6 (0.0%), b_finish: 0.69 (0.0%), tests_pri_0: 319 (2.1%),
	check_dkim_signature: 0.77 (0.0%), check_dkim_adsp: 3.5 (0.0%),
	tests_pri_500: 14651 (97.5%), poll_dns_idle: 14642 (97.4%), rewrite_mail:
	0.00 (0.0%)
Subject: Re: [PATCH v2] locks: change POSIX lock ownership on execve when files_struct is displaced
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595613981112335731?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Jeff Layton <jlayton@kernel.org> writes:

> From: Jeff Layton <jlayton@redhat.com>
>
> POSIX mandates that open fds and their associated file locks should be
> preserved across an execve. This works, unless the process is
> multithreaded at the time that execve is called.

Would this perhaps work better if we moved unshare_files to after or
inside of de_thread.  That would remove any cases where fd->count is > 1
simply because you are multi-threaded.  It would only leave the strange
cases where files struct is shared between different processes.

> In that case, we'll end up unsharing the files_struct but the locks will
> still have their fl_owner set to the address of the old one. Eventually,
> when the other threads die and the last reference to the old
> files_struct is put, any POSIX locks get torn down since it looks like
> a close occurred on them.
>
> The result is that all of your open files will be intact with none of
> the locks you held before execve. The simple answer to this is "use OFD
> locks", but this is a nasty surprise and it violates the spec.
>
> On a successful execve, change ownership of any POSIX file_locks
> associated with the old files_struct to the new one, if we ended up
> swapping it out.

If we can move unshare_files I believe the need for changing the
ownership would go away.  Which seems like easier to understand
and simpler code in the end.  With fewer surprises.

Eric


> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>


> ---
>  fs/exec.c          |  4 +++-
>  fs/locks.c         | 60 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/fs.h |  8 ++++++++
>  3 files changed, 71 insertions(+), 1 deletion(-)
>
> diff --git a/fs/exec.c b/fs/exec.c
> index 7eb8d21bcab9..35b05376bf78 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1812,8 +1812,10 @@ static int do_execveat_common(int fd, struct filen=
ame *filename,
>  	free_bprm(bprm);
>  	kfree(pathbuf);
>  	putname(filename);
> -	if (displaced)
> +	if (displaced) {
> +		posix_change_lock_owners(current->files, displaced);
>  		put_files_struct(displaced);
> +	}
>  	return retval;
>=20=20
>  out:
> diff --git a/fs/locks.c b/fs/locks.c
> index d6ff4beb70ce..ab428ca8bb11 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -993,6 +993,66 @@ static int flock_lock_inode(struct inode *inode, str=
uct file_lock *request)
>  	return error;
>  }
>=20=20
> +struct posix_change_lock_owners_arg {
> +	fl_owner_t old;
> +	fl_owner_t new;
> +};
> +
> +static int posix_change_lock_owners_cb(const void *varg, struct file *fi=
le,
> +					  unsigned int fd)
> +{
> +	const struct posix_change_lock_owners_arg *arg =3D varg;
> +	struct inode *inode =3D file_inode(file);
> +	struct file_lock_context *ctx;
> +	struct file_lock *fl, *tmp;
> +
> +	/* If there is no context, then no locks need to be changed */
> +	ctx =3D locks_get_lock_context(inode, F_UNLCK);
> +	if (!ctx)
> +		return 0;
> +
> +	percpu_down_read_preempt_disable(&file_rwsem);
> +	spin_lock(&ctx->flc_lock);
> +	/* Find the first lock with the old owner */
> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
> +		if (fl->fl_owner =3D=3D arg->old)
> +			break;
> +	}
> +
> +	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
> +		if (fl->fl_owner !=3D arg->old)
> +			break;
> +
> +		/* This should only be used for normal userland lockmanager */
> +		if (fl->fl_lmops) {
> +			WARN_ON_ONCE(1);
> +			break;
> +		}
> +		fl->fl_owner =3D arg->new;
> +	}
> +	spin_unlock(&ctx->flc_lock);
> +	percpu_up_read_preempt_enable(&file_rwsem);
> +	return 0;
> +}
> +
> +/**
> + * posix_change_lock_owners - change lock owners from old files_struct t=
o new
> + * @files: new files struct to own locks
> + * @old: old files struct that previously held locks
> + *
> + * On execve, a process may end up with a new files_struct. In that case=
, we
> + * must change all of the locks that were owned by the previous files_st=
ruct
> + * to the new one.
> + */
> +void posix_change_lock_owners(struct files_struct *new,
> +			      struct files_struct *old)
> +{
> +	struct posix_change_lock_owners_arg arg =3D { .old =3D old,
> +						    .new =3D new };
> +
> +	iterate_fd(new, 0, posix_change_lock_owners_cb, &arg);
> +}
> +
>  static int posix_lock_inode(struct inode *inode, struct file_lock *reque=
st,
>  			    struct file_lock *conflock)
>  {
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79c413985305..65fa99707bf9 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1098,6 +1098,8 @@ extern int lease_modify(struct file_lock *, int, st=
ruct list_head *);
>  struct files_struct;
>  extern void show_fd_locks(struct seq_file *f,
>  			 struct file *filp, struct files_struct *files);
> +extern void posix_change_lock_owners(struct files_struct *new,
> +				     struct files_struct *old);
>  #else /* !CONFIG_FILE_LOCKING */
>  static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>  			      struct flock __user *user)
> @@ -1232,6 +1234,12 @@ static inline int lease_modify(struct file_lock *f=
l, int arg,
>  struct files_struct;
>  static inline void show_fd_locks(struct seq_file *f,
>  			struct file *filp, struct files_struct *files) {}
> +
> +static inline void posix_change_lock_owners(struct files_struct *new,
> +					    struct files_struct *old)
> +{
> +}
> +
>  #endif /* !CONFIG_FILE_LOCKING */
>=20=20
>  static inline struct inode *file_inode(const struct file *f)
