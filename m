Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524150122-2-5385237413582098029
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524150120; b=RAdyaOswND3A/Stt5N9cGP4T0nj3y+VSTOHJnNnpnJJG3rANjY
    6hQk4BP01xOLdLIq/HPmAhrSKvRjll3ClypttxuPF31zRhYi9CiRFJxSoy0h6SDh
    gFamhTpO2PMyml9Op7SSgurqWR047rU2E+M5om7hJRX+mdFWfqC6ZczB/5DnOjE6
    HJIFr769SlKqBmZTyS7H5MOQl65Ko10wgqsmhKxfiTIv1ACaTH3QTiT40utF+KKw
    172/iGuRqU/VFyQ9gOjdxcOX7SrlGz/MnHFoee792T1Yqis5YY6Z14rPKu8hefVW
    uYHvqpTT8SYC2KJoBa/93B4q0K9ns3/2P3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1524150120; bh=+HiQUiCIq5ws8baVp0Htf1vOZUt5StjkEbcEOHFH+H
    E=; b=m5QhhkseDWbVd8wlOQdnYrZ7faj4NRi+Eq/Rd5voTcOv7IF3XNxQrIHWk9
    Tu5rlqmXQy868s+EcvsosdIEnHEvy7huGcHV8IAcCa44CsXexSmguthYBZLgNfwi
    oZXdhlkiEXnIdj+319GCe1LiYdwVh4vqGTpgLpHAO6gWAS50eh1sIzht+yh/dI7u
    lq0S13Hs/78RzBZWI6uXrj4BnZqkaOLmULZmhYyljelwdVvqfoFPLgPBdhMWHSvM
    SBTE7fHy5Ql3dE1tbj3PZl7EiZ15qQ7aTikOu0uOGs9zYvJBT28k7tUEuEKa9eKw
    iX4CqdWqFh6dQlSkYyCiDNs7ZW2A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfPvPCB+vlO4RlFAsk7gLIvpryLrNu9g8xIDiV0tTWtVmIbNEdlSLWf+2BdCFUs0Ui1Tuig5sTYghd3BAvrfY3OnG0g5VkOzdvkqR0tIhmQ3kqRUcKGuz
    nU5shZ4MG+KZZhSFsj4de38TWVPy6oHrK+323IIsFDhsqsueE6y1oF40LwxAcw4Xe9Cto2PTDQ1XTQLNHT4pg/SBnO/FdeNVvkkTnoQxN+FwvnPdn5eQGAHt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=CHizfPllgoLgv_JVgOEA:9 a=ieOv6yEV0FDnusPC:21 a=XlTo9wR1hf43R-t5:21
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753048AbeDSPBT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:01:19 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:59405 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDSPBR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 11:01:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        libc-alpha@sourceware.org, tglx@linutronix.de,
        deepa.kernel@gmail.com, viro@zeniv.linux.org.uk,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
References: <20180419143737.606138-1-arnd@arndb.de>
        <20180419143737.606138-2-arnd@arndb.de>
Date: Thu, 19 Apr 2018 09:59:48 -0500
In-Reply-To: <20180419143737.606138-2-arnd@arndb.de> (Arnd Bergmann's message
        of "Thu, 19 Apr 2018 16:37:21 +0200")
Message-ID: <87efjbnswr.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f9B3h-0006yH-EO;;;mid=<87efjbnswr.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18pl9tgkmh2hKvB1qcFOJ340F7Yw13/C8g=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa01.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,XMSubLong
        autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Arnd Bergmann <arnd@arndb.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 1164 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.9 (0.3%), b_tie_ro: 1.98 (0.2%), parse: 1.53 (0.1%),
        extract_message_metadata: 30 (2.6%), get_uri_detail_list: 7 (0.6%),
        tests_pri_-1000: 11 (0.9%), tests_pri_-950: 2.0 (0.2%), tests_pri_-900: 1.70
        (0.1%), tests_pri_-400: 48 (4.1%), check_bayes: 46 (3.9%), b_tokenize: 23
        (2.0%), b_tok_get_all: 11 (0.9%), b_comp_prob: 5 (0.5%), b_tok_touch_all: 3.3
        (0.3%), b_finish: 0.77 (0.1%), tests_pri_0: 1056 (90.7%),
        check_dkim_signature: 0.98 (0.1%), check_dkim_adsp: 4.9 (0.4%),
        tests_pri_500: 6 (0.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Arnd Bergmann <arnd@arndb.de> writes:

> Most architectures now use the asm-generic copy of the sysvipc data
> structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
> __kernel_time_t on 32-bit architectures but have padding behind them to
> allow extending the type to 64-bit.
>
> Unfortunately, that fails on all big-endian architectures, which have the
> padding on the wrong side. As so many of them get it wrong, we decided to
> not bother even trying to fix it up when we introduced the asm-generic
> copy. Instead we always use the padding word now to provide the upper
> 32 bits of the seconds value, regardless of the endianess.
>
> A libc implementation on a typical big-endian system can deal with
> this by providing its own copy of the structure definition to user
> space, and swapping the two 32-bit words before returning from the
> semctl/shmctl/msgctl system calls.
>
> ARM64 and s/390 are architectures that use these generic headers and
> also provide support for compat mode on 64-bit kernels, so we adapt
> their copies here as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/uapi/asm-generic/msgbuf.h | 17 ++++++++---------
>  include/uapi/asm-generic/sembuf.h | 26 ++++++++++++++++----------
>  include/uapi/asm-generic/shmbuf.h | 17 ++++++++---------
>  3 files changed, 32 insertions(+), 28 deletions(-)
>
> diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
> index fb306ebdb36f..d2169cae93b8 100644
> --- a/include/uapi/asm-generic/msgbuf.h
> +++ b/include/uapi/asm-generic/msgbuf.h
> @@ -18,23 +18,22 @@
>   * On big-endian systems, the padding is in the wrong place.
>   *
>   * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
>   * - 2 miscellaneous 32-bit values
>   */
>  
>  struct msqid64_ds {
>  	struct ipc64_perm msg_perm;
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t msg_stime;	/* last msgsnd time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused1;
> -#endif
>  	__kernel_time_t msg_rtime;	/* last msgrcv time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused2;
> -#endif
>  	__kernel_time_t msg_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused3;
> +#else
> +	unsigned long	msg_stime;	/* last msgsnd time */
> +	unsigned long	msg_stime_high;
> +	unsigned long	msg_rtime;	/* last msgrcv time */
> +	unsigned long	msg_rtime_high;
> +	unsigned long	msg_ctime;	/* last change time */
> +	unsigned long	msg_ctime_high;
>  #endif

I suspect you want to use __kernel_ulong_t here instead of a raw
unsigned long.  If nothing else it seems inconsistent to use typedefs
in one half of the structure and no typedefs in the other half.

>  	__kernel_ulong_t msg_cbytes;	/* current number of bytes on queue */
>  	__kernel_ulong_t msg_qnum;	/* number of messages in queue */
> diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
> index cbf9cfe977d6..0bae010f1b64 100644
> --- a/include/uapi/asm-generic/sembuf.h
> +++ b/include/uapi/asm-generic/sembuf.h
> @@ -13,23 +13,29 @@
>   * everyone just ended up making identical copies without specific
>   * optimizations, so we may just as well all use the same one.
>   *
> - * 64 bit architectures typically define a 64 bit __kernel_time_t,
> + * 64 bit architectures use a 64-bit __kernel_time_t here, while
> + * 32 bit architectures have a pair of unsigned long values.
>   * so they do not need the first two padding words.
> - * On big-endian systems, the padding is in the wrong place.
>   *
> - * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
> - * - 2 miscellaneous 32-bit values
> + * On big-endian systems, the padding is in the wrong place for
> + * historic reasons, so user space has to reconstruct a time_t
> + * value using
> + *
> + * user_semid_ds.sem_otime = kernel_semid64_ds.sem_otime +
> + *		((long long)kernel_semid64_ds.sem_otime_high << 32)
> + *
> + * Pad space is left for 2 miscellaneous 32-bit values
>   */
>  struct semid64_ds {
>  	struct ipc64_perm sem_perm;	/* permissions .. see ipc.h */
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t	sem_otime;	/* last semop time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused1;
> -#endif
>  	__kernel_time_t	sem_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long	__unused2;
> +#else
> +	unsigned long	sem_otime;	/* last semop time */
> +	unsigned long	sem_otime_high;
> +	unsigned long	sem_ctime;	/* last change time */
> +	unsigned long	sem_ctime_high;
>  #endif
>  	unsigned long	sem_nsems;	/* no. of semaphores in array */
>  	unsigned long	__unused3;
> diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
> index 2b6c3bb97f97..602f1b5b462b 100644
> --- a/include/uapi/asm-generic/shmbuf.h
> +++ b/include/uapi/asm-generic/shmbuf.h
> @@ -19,24 +19,23 @@
>   *
>   *
>   * Pad space is left for:
> - * - 64-bit time_t to solve y2038 problem
>   * - 2 miscellaneous 32-bit values
>   */
>  
>  struct shmid64_ds {
>  	struct ipc64_perm	shm_perm;	/* operation perms */
>  	size_t			shm_segsz;	/* size of segment (bytes) */
> +#if __BITS_PER_LONG == 64
>  	__kernel_time_t		shm_atime;	/* last attach time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused1;
> -#endif
>  	__kernel_time_t		shm_dtime;	/* last detach time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused2;
> -#endif
>  	__kernel_time_t		shm_ctime;	/* last change time */
> -#if __BITS_PER_LONG != 64
> -	unsigned long		__unused3;
> +#else
> +	unsigned long		shm_atime;	/* last attach time */
> +	unsigned long		shm_atime_high;
> +	unsigned long		shm_dtime;	/* last detach time */
> +	unsigned long		shm_dtime_high;
> +	unsigned long		shm_ctime;	/* last change time */
> +	unsigned long		shm_ctime_high;
>  #endif
>  	__kernel_pid_t		shm_cpid;	/* pid of creator */
>  	__kernel_pid_t		shm_lpid;	/* pid of last operator */
