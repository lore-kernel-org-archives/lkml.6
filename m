Return-Path: <ebiederm@xmission.com>
X-Google-Smtp-Source: AG47ELsACvoQgpORTcUH48MkQh04Bs1BuNnWPINIzqS2tuMJndCCtuZxdogaI1iG0D6iOrGVJem9
ARC-Seal: i=1; a=rsa-sha256; t=1521697056; cv=none;
        d=google.com; s=arc-20160816;
        b=qEW37K7yF5EaiWDsIIOI4yFLkk0m1D2FtAlXBoeK+WXT6jak3teXpnG6tjfTuvMVkP
         xtOb8JkAOI8RNeSEJqBoE1cgbpHU2e1x56idCkXDIqA/Yd7wXIpu37cLK+Dl56Md91we
         SfH7/pPz9DG7+7IJfjaOwrsda1IJPaBAWHrH2tKvvIAHEChSDPcG1npUANrLML8+lH/K
         B+h9YfyJpFqnHa8RUBKXQ9MLcnHrWV/PS7U2onVZzwX/PZexAQ4yECGXkmc/YLzk5lPG
         z2L8epC7BcHoN8xedzTO7A+9QFMdJK7OkOMMSju6/8fFA24qLOkHSjMQPQeIIehv6J/K
         lvig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:mime-version:user-agent
         :message-id:in-reply-to:date:references:cc:to:from
         :arc-authentication-results;
        bh=TOcjoIQG1AifGImdnMbCr8oC3i1xJwcfCCJaX9Mt/4E=;
        b=Ln6fYh9RVofzW8K2cY4piIH2m9HkSRtC5cqPDaplI2DHMi1zB+qaZpXmG4DfpaivVn
         JcGrsknDubfkIzjefVvyi/cepn+7lozHy9j3mdK+smh5+SgKVltOFWpahGjfmZ9Y3PsB
         /GZoBlmWL3Ba+wnsUtzKacc1yAL7MTRlXBycnb5GJSvDQHmU7BF0uOg2Mi3qBhpKEPQS
         dHWEmOhsagGUyEi0U3HDqY0jZAIBHIq2NFamQPTXqkAVeMHaLu+kGVZmOMzjyb2y5oTT
         fFOL2I/n6RX2KXY2BkEUKRZKiTUuDlXNEhl4Exw0yFLpyK5NlfL2iU3O3pJHL7SiyZRp
         ZTlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ebiederm@xmission.com designates 166.70.13.231 as permitted sender) smtp.mailfrom=ebiederm@xmission.com
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
	<87bmfgvg8w.fsf@xmission.com>
Date: Thu, 22 Mar 2018 00:36:36 -0500
In-Reply-To: <87bmfgvg8w.fsf@xmission.com> (Eric W. Biederman's message of
	"Thu, 22 Mar 2018 00:19:59 -0500")
Message-ID: <871sgcvfh7.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1eysup-0007UM-JU;;;mid=<871sgcvfh7.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/RR1GvPYEjuQfqt0j/d6vBY+r0rBFUg/Q=
X-SA-Exim-Connect-IP: 97.119.121.173
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
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Jeff Layton <jlayton@kernel.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 316 ms - load_scoreonly_sql: 0.04 (0.0%),
	signal_user_changed: 3.8 (1.2%), b_tie_ro: 2.5 (0.8%), parse: 0.97 (0.3%),
	extract_message_metadata: 12 (3.7%), get_uri_detail_list: 3.3 (1.0%),
	tests_pri_-1000: 4.7 (1.5%), tests_pri_-950: 1.08 (0.3%), tests_pri_-900:
	0.89 (0.3%), tests_pri_-400: 29 (9.1%), check_bayes: 28 (8.8%), b_tokenize: 9
	(2.9%), b_tok_get_all: 11 (3.4%), b_comp_prob: 2.2 (0.7%), b_tok_touch_all:
	3.9 (1.2%), b_finish: 0.63 (0.2%), tests_pri_0: 258 (81.7%),
	check_dkim_signature: 0.50 (0.2%), check_dkim_adsp: 2.6 (0.8%),
	tests_pri_500: 3.2 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] locks: change POSIX lock ownership on execve when files_struct is displaced
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595195233416759536?=
X-GMAIL-MSGID: =?utf-8?q?1595615013377208035?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ebiederm@xmission.com (Eric W. Biederman) writes:

> Jeff Layton <jlayton@kernel.org> writes:
>
>> From: Jeff Layton <jlayton@redhat.com>
>>
>> POSIX mandates that open fds and their associated file locks should be
>> preserved across an execve. This works, unless the process is
>> multithreaded at the time that execve is called.

> Would this perhaps work better if we moved unshare_files to after or
> inside of de_thread.  That would remove any cases where fd->count is > 1
> simply because you are multi-threaded.  It would only leave the strange
> cases where files struct is shared between different processes.

The fact we have a problem here appears to be a regression caused by:
fd8328be874f ("[PATCH] sanitize handling of shared descriptor tables in
failing execve()")

So I really think we are calling unshare_files in the wrong location.

We could perhaps keep the benefit of being able to fail exec cleanly
if we freeze the threads and then only unshare if the count of threads
differs from the fd->count.  I don't know if it is worth it.

Eric


>> In that case, we'll end up unsharing the files_struct but the locks will
>> still have their fl_owner set to the address of the old one. Eventually,
>> when the other threads die and the last reference to the old
>> files_struct is put, any POSIX locks get torn down since it looks like
>> a close occurred on them.
>>
>> The result is that all of your open files will be intact with none of
>> the locks you held before execve. The simple answer to this is "use OFD
>> locks", but this is a nasty surprise and it violates the spec.
>>
>> On a successful execve, change ownership of any POSIX file_locks
>> associated with the old files_struct to the new one, if we ended up
>> swapping it out.
>
> If we can move unshare_files I believe the need for changing the
> ownership would go away.  Which seems like easier to understand
> and simpler code in the end.  With fewer surprises.
>
> Eric
>
>
>> Reported-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Jeff Layton <jlayton@redhat.com>
>
>
>> ---
>>  fs/exec.c          |  4 +++-
>>  fs/locks.c         | 60 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>>  include/linux/fs.h |  8 ++++++++
>>  3 files changed, 71 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 7eb8d21bcab9..35b05376bf78 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1812,8 +1812,10 @@ static int do_execveat_common(int fd, struct file=
name *filename,
>>  	free_bprm(bprm);
>>  	kfree(pathbuf);
>>  	putname(filename);
>> -	if (displaced)
>> +	if (displaced) {
>> +		posix_change_lock_owners(current->files, displaced);
>>  		put_files_struct(displaced);
>> +	}
>>  	return retval;
>>=20=20
>>  out:
>> diff --git a/fs/locks.c b/fs/locks.c
>> index d6ff4beb70ce..ab428ca8bb11 100644
>> --- a/fs/locks.c
>> +++ b/fs/locks.c
>> @@ -993,6 +993,66 @@ static int flock_lock_inode(struct inode *inode, st=
ruct file_lock *request)
>>  	return error;
>>  }
>>=20=20
>> +struct posix_change_lock_owners_arg {
>> +	fl_owner_t old;
>> +	fl_owner_t new;
>> +};
>> +
>> +static int posix_change_lock_owners_cb(const void *varg, struct file *f=
ile,
>> +					  unsigned int fd)
>> +{
>> +	const struct posix_change_lock_owners_arg *arg =3D varg;
>> +	struct inode *inode =3D file_inode(file);
>> +	struct file_lock_context *ctx;
>> +	struct file_lock *fl, *tmp;
>> +
>> +	/* If there is no context, then no locks need to be changed */
>> +	ctx =3D locks_get_lock_context(inode, F_UNLCK);
>> +	if (!ctx)
>> +		return 0;
>> +
>> +	percpu_down_read_preempt_disable(&file_rwsem);
>> +	spin_lock(&ctx->flc_lock);
>> +	/* Find the first lock with the old owner */
>> +	list_for_each_entry(fl, &ctx->flc_posix, fl_list) {
>> +		if (fl->fl_owner =3D=3D arg->old)
>> +			break;
>> +	}
>> +
>> +	list_for_each_entry_safe_from(fl, tmp, &ctx->flc_posix, fl_list) {
>> +		if (fl->fl_owner !=3D arg->old)
>> +			break;
>> +
>> +		/* This should only be used for normal userland lockmanager */
>> +		if (fl->fl_lmops) {
>> +			WARN_ON_ONCE(1);
>> +			break;
>> +		}
>> +		fl->fl_owner =3D arg->new;
>> +	}
>> +	spin_unlock(&ctx->flc_lock);
>> +	percpu_up_read_preempt_enable(&file_rwsem);
>> +	return 0;
>> +}
>> +
>> +/**
>> + * posix_change_lock_owners - change lock owners from old files_struct =
to new
>> + * @files: new files struct to own locks
>> + * @old: old files struct that previously held locks
>> + *
>> + * On execve, a process may end up with a new files_struct. In that cas=
e, we
>> + * must change all of the locks that were owned by the previous files_s=
truct
>> + * to the new one.
>> + */
>> +void posix_change_lock_owners(struct files_struct *new,
>> +			      struct files_struct *old)
>> +{
>> +	struct posix_change_lock_owners_arg arg =3D { .old =3D old,
>> +						    .new =3D new };
>> +
>> +	iterate_fd(new, 0, posix_change_lock_owners_cb, &arg);
>> +}
>> +
>>  static int posix_lock_inode(struct inode *inode, struct file_lock *requ=
est,
>>  			    struct file_lock *conflock)
>>  {
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 79c413985305..65fa99707bf9 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -1098,6 +1098,8 @@ extern int lease_modify(struct file_lock *, int, s=
truct list_head *);
>>  struct files_struct;
>>  extern void show_fd_locks(struct seq_file *f,
>>  			 struct file *filp, struct files_struct *files);
>> +extern void posix_change_lock_owners(struct files_struct *new,
>> +				     struct files_struct *old);
>>  #else /* !CONFIG_FILE_LOCKING */
>>  static inline int fcntl_getlk(struct file *file, unsigned int cmd,
>>  			      struct flock __user *user)
>> @@ -1232,6 +1234,12 @@ static inline int lease_modify(struct file_lock *=
fl, int arg,
>>  struct files_struct;
>>  static inline void show_fd_locks(struct seq_file *f,
>>  			struct file *filp, struct files_struct *files) {}
>> +
>> +static inline void posix_change_lock_owners(struct files_struct *new,
>> +					    struct files_struct *old)
>> +{
>> +}
>> +
>>  #endif /* !CONFIG_FILE_LOCKING */
>>=20=20
>>  static inline struct inode *file_inode(const struct file *f)
