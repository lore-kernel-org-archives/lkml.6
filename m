Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-814676-1518553337-2-8774489952702945444
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518553336; b=GPqiB1aLKEr86rw+Jmsziv7LxbKX/ioUS2A/nr9TFG4S2E8
    B1arj/ABvRtRs+/zIsBXMoS192nGCqqF8pt7R/S+2N526a3laDUbiIkFz47bz2iR
    Ni/6Fm6yxNddYxNcaQZWZurXCmSXkg8gTiYamwAulTaGCvf0Wil2WsaoBWcTPwu2
    wIhRL7Q1pALWRwu4IoGDgEeWgzldvxbXYaFzWZ1gi5+4UsKVNh1OLZGWePtQ0vSL
    Rl9TU3HNi22dOr8gTcZrj0jV3ZRfCRkXCwJqDrywtEGS7Ryq93CcOgs9NfD6K0vb
    M/8/9J834IWn70lB77oCWomSFbI4IdW0sm0O0Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1518553336; bh=LiNUYVMEz45duZQfB3nq9vbkjPdx8RdPg7bEPs
    svNVg=; b=eMxaW2bLz+AfYFEgAwTBX530yGn7rRpLgy5KRukOccYwsFe7NtO5C3
    PFdZWlR4GovUlNXG6Hn3Gt2V+baAms6dPigcgy7k4egt28KrBcmJDRhtnB0EfGha
    6U3GhN1D58iLsiKofUfcvvOIh3sr3SjaX8/C3qlPdcpnbovjoY/al9ccuSPVfA2q
    E3wFoLJNaQrq1RHHjE2pMDBLke8OraQED9JPsjGCxGcIf/RbaaGthil44HH2uP8p
    mQKifbEGlBgg31TxHivlGoG58SXTzMEW743Yi1gqT/USLPOSAY/IOb7RrpyLoxIm
    XsrfYlmXQxEzJay/GS6U88Mj/zKlBKJA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965619AbeBMUWO (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 15:22:14 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:52933 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965610AbeBMUWN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Feb 2018 15:22:13 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, mhocko@kernel.org,
        mtk.manpages@gmail.com, keescook@chromium.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180213174136.6346-1-dave@stgolabs.net>
Date: Tue, 13 Feb 2018 14:21:31 -0600
In-Reply-To: <20180213174136.6346-1-dave@stgolabs.net> (Davidlohr Bueso's
        message of "Tue, 13 Feb 2018 09:41:33 -0800")
Message-ID: <878tbw3ak4.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1elh5Q-0004UI-Ju;;;mid=<878tbw3ak4.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/F3x3BY5wZaHfrIIdTmSpd9Ie0yWRIOko=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa02.xmission.com
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02 autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Remote-Spam-DCC: XMission; sa02 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ;Davidlohr Bueso <dave@stgolabs.net>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 13703 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.1 (0.0%), b_tie_ro: 2.1 (0.0%), parse: 1.26 (0.0%),
        extract_message_metadata: 31 (0.2%), get_uri_detail_list: 4.2 (0.0%),
        tests_pri_-1000: 8 (0.1%), tests_pri_-950: 2.0 (0.0%), tests_pri_-900: 1.67
        (0.0%), tests_pri_-400: 41 (0.3%), check_bayes: 38 (0.3%), b_tokenize: 15
        (0.1%), b_tok_get_all: 10 (0.1%), b_comp_prob: 5 (0.0%), b_tok_touch_all: 3.4
        (0.0%), b_finish: 0.81 (0.0%), tests_pri_0: 587 (4.3%), check_dkim_signature:
        0.98 (0.0%), check_dkim_adsp: 7 (0.1%), tests_pri_500: 13022 (95.0%),
        poll_dns_idle: 12964 (94.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH -next 0/3] sysvipc: introduce STAT_ALL commands
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Davidlohr Bueso <dave@stgolabs.net> writes:

> Hi,
>
> The following patches adds the discussed[1] new command for shm
> as well as for sems and msq as they are subject to the same discrepancies
> for ipc object permission checks between the syscall and via procfs.
> These new commands are justified in that (1) we are stuck with this
> semantics as changing syscall and procfs can break userland; and (2) some
> users can benefit from performance (for large amounts of shm segments,
> for example) from not having to parse the procfs interface.
>
> Once (if) merged, I will submit the necesary manpage updates. But I'm
> thinking something like:

I am just going to kibitz for a moment.

Could we name this _STAT_ANY or _STAT_NOPERM instead of _STAT_ALL.

I keep thinking a name with _ALL in it should affect all ipc opbjects of
a given type, not simply work any ipc object regardless of permissions.

Eric

> diff --git a/man2/shmctl.2 b/man2/shmctl.2
> index 7bb503999941..bb00bbe21a57 100644
> --- a/man2/shmctl.2
> +++ b/man2/shmctl.2
> @@ -41,6 +41,7 @@
>  .\" 2005-04-25, mtk -- noted aberrant Linux behavior w.r.t. new
>  .\"	attaches to a segment that has already been marked for deletion.
>  .\" 2005-08-02, mtk: Added IPC_INFO, SHM_INFO, SHM_STAT descriptions.
> +.\" 2018-02-13, dbueso: Added SHM_STAT_ALL description.
>  .\"
>  .TH SHMCTL 2 2017-09-15 "Linux" "Linux Programmer's Manual"
>  .SH NAME
> @@ -242,6 +243,18 @@ However, the
>  argument is not a segment identifier, but instead an index into
>  the kernel's internal array that maintains information about
>  all shared memory segments on the system.
> +.TP
> +.BR SHM_STAT_ALL " (Linux-specific)"
> +Return a
> +.I shmid_ds
> +structure as for
> +.BR SHM_STAT .
> +However, the
> +.I shm_perm.mode
> +is not checked for read access for
> +.IR shmid ,
> +resembing the behaviour of
> +/proc/sysvipc/shm.
>  .PP
>  The caller can prevent or allow swapping of a shared
>  memory segment with the following \fIcmd\fP values:
> @@ -287,7 +300,7 @@ operation returns the index of the highest used entry in the
>  kernel's internal array recording information about all
>  shared memory segments.
>  (This information can be used with repeated
> -.B SHM_STAT
> +.B SHM_STAT/SHM_STAT_ALL
>  operations to obtain information about all shared memory segments
>  on the system.)
>  A successful
> @@ -328,7 +341,7 @@ isn't accessible.
>  \fIshmid\fP is not a valid identifier, or \fIcmd\fP
>  is not a valid command.
>  Or: for a
> -.B SHM_STAT
> +.B SHM_STAT/SHM_STAT_ALL
>  operation, the index value specified in
>  .I shmid
>  referred to an array slot that is currently unused.
>
>
> Thanks!
>
> [1] https://lkml.org/lkml/2017/12/19/220
>
> Davidlohr Bueso (3):
>   ipc/shm: introduce shmctl(SHM_STAT_ALL)
>   ipc/sem: introduce shmctl(SEM_STAT_ALL)
>   ipc/msg: introduce shmctl(MSG_STAT_ALL)
>
>  include/uapi/linux/msg.h |  1 +
>  include/uapi/linux/sem.h |  1 +
>  include/uapi/linux/shm.h |  5 +++--
>  ipc/msg.c                | 17 ++++++++++++-----
>  ipc/sem.c                | 17 ++++++++++++-----
>  ipc/shm.c                | 23 ++++++++++++++++++-----
>  security/selinux/hooks.c |  3 +++
>  7 files changed, 50 insertions(+), 17 deletions(-)
