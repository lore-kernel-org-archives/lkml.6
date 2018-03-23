Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1990790-1521832360-2-12861563440572360337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521832360; b=t04VScQk2qWBDPC1lvhizrYv6p3HbQ36n7Xn8OEKvuMjIUw
    Y40Z8X1ELNmNDwFXrRbaeKROPTQYSojAllYCnZ3O/UNl75pUoU5TsE41NBUKNNzo
    BaPtQZG5mzRakcAwuCC0xUk6RQ9GzHunJUyRA7KctwuyRa7bEQVhi6KQabLcU4UL
    1PfEDA5g+UcFPiSbVwBqCM9jfGNa81i0/r/gBsT8uLuAEGN3kmOmtpJNLtiZXoPA
    gDqQCoc0hth9dShlkSMeZk6uwwCzqpwX+5FzGpaBTccF2DouLeBV4Fbmw7g2whG5
    HKrvr4hWXZjc1TvhIryZ9uFCE5CILWsNa6cTK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521832360; bh=7mqNDnN7LxwS9wp3F8LddOgerNZV2TyPvuSHb+
    mv7GA=; b=ZQgIvew42SU5GTfNm3/65N2bcXjNxV4qYeflH1B/q5gNf0Mcw1r60L
    SWoVks6vVVJOIY2vij5oQqsF9AZ5nJ8MjuuMScOD8gvA5QqyilUafCmWc5ByU4Xf
    jr1u0EIzp8e4Yf0oCQtadWz12K8+raz7eY6+SJNShgyqbmyin9cyHyQRpWH9dGcB
    n07sWs1tSheE3f8SDEHizA/0pkOKXC8aWlSbemS9KWOLVo81PwKdeVJGP7Fa3TWG
    19VNA2HWzbqlxAXf5WXIXUby9ZUncK3XI/C+rFtNPGww5/SRfakMP1XGydPv+HdX
    t87ONwWdNwcI1Iw3c83vObsGoMnhSGSA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbeCWTM0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 15:12:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:38150 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCWTMX (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 23 Mar 2018 15:12:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linux Containers <containers@lists.linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        khlebnikov@yandex-team.ru, prakash.sangappa@oracle.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        serge.hallyn@ubuntu.com, esyr@redhat.com, jannh@google.com,
        linux-security-module@vger.kernel.org,
        Pavel Emelyanov <xemul@openvz.org>,
        Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
References: <1520875093-18174-1-git-send-email-nagarathnam.muthusamy@oracle.com>
        <87vadzqqq6.fsf@xmission.com>
        <990e88fa-ab50-9645-b031-14e1afbf7ccc@oracle.com>
        <877eqejowd.fsf@xmission.com>
        <3a46a03d-e4dd-59b6-e25f-0020be1b1dc9@oracle.com>
        <87a7v2z2qa.fsf@xmission.com>
Date: Fri, 23 Mar 2018 14:11:23 -0500
In-Reply-To: <87a7v2z2qa.fsf@xmission.com> (Eric W. Biederman's message of
        "Tue, 20 Mar 2018 19:33:49 -0500")
Message-ID: <87vadmobdw.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezS6u-0003RW-GQ;;;mid=<87vadmobdw.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+HUW0WzLjMq2RIl2kmFx/6hMspRguewWg=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa06.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,TVD_RCVD_IP,XMNoVowels autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;Linux Containers <containers@lists.linux-foundation.org>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 307 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 3.4 (1.1%), b_tie_ro: 2.3 (0.8%), parse: 1.21 (0.4%),
        extract_message_metadata: 4.6 (1.5%), get_uri_detail_list: 2.2 (0.7%),
        tests_pri_-1000: 4.2 (1.4%), tests_pri_-950: 1.26 (0.4%), tests_pri_-900:
        1.07 (0.3%), tests_pri_-400: 24 (7.9%), check_bayes: 23 (7.5%), b_tokenize: 8
        (2.6%), b_tok_get_all: 8 (2.5%), b_comp_prob: 2.4 (0.8%), b_tok_touch_all:
        3.1 (1.0%), b_finish: 0.68 (0.2%), tests_pri_0: 254 (82.8%),
        check_dkim_signature: 0.55 (0.2%), check_dkim_adsp: 3.0 (1.0%),
        tests_pri_500: 4.3 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: [REVIEW][PATCH 00/11] ipc: Fixing the pid namespace support
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


While discussing a proposal by Nagarathnam Muthusamy I realized that
the ipc namespace has never been given proper pid namespace support.
In particular if objects in a single ipc namespace are accessed from
different pid namespaces they will return the wrong pids.

Then when trying to test this I discovered that definitions that are
only used in msg.c, sem.c, and shm.c are included in linux/sched.h
resulting in what should be simple local modifications requring
nearly a full kernel rebuild.

So this patchset does several things.
- Changes the types that are passed into the security hooks to struct
  kern_ipc_perm because that is all the security hooks use.
- Moves definitions from include/{msg,sem,shm}.h into ipc/{msg,sem,shm}.c
  So the code can be modified without excessive development time.
- Instead of storing pids as intergers stores struct pid * instead.

I took a careful look to see if it seems likely the performance
regression in credential passing that af_unix experienced after
a similar conversion would be likely, but I don't see it.

So I think the biggest concern is if someone in the last 10 years
has come to depend on the buggy behavior.  If either the performance
is problematic or the there are regression caused by the change
in behavior we can revert.

Still I would like to see this fixed and I plan on merging this code.

Eric W. Biederman (11):
      sem/security: Pass kern_ipc_perm not sem_array into the sem security hooks
      shm/security: Pass kern_ipc_perm not shmid_kernel into the shm security hooks
      msg/security: Pass kern_ipc_perm not msg_queue into the msg_queue security hooks
      sem: Move struct sem and struct sem_array into ipc/sem.c
      shm: Move struct shmid_kernel into ipc/shm.c
      msg: Move struct msg_queue into ipc/msg.c
      ipc: Move IPCMNI from include/ipc.h into ipc/util.h
      ipc/util: Helpers for making the sysvipc operations pid namespace aware
      ipc/shm: Fix shmctl(..., IPC_STAT, ...) between pid namespaces.
      ipc/msg: Fix msgctl(..., IPC_STAT, ...) between pid namespaces
      ipc/sem: Fix semctl(..., GETPID, ...) between pid namespaces

include/linux/ipc.h        |  2 -
 include/linux/lsm_hooks.h  | 32 ++++++++--------
 include/linux/msg.h        | 18 ---------
 include/linux/security.h   | 67 ++++++++++++++++-----------------
 include/linux/sem.h        | 40 +-------------------
 include/linux/shm.h        | 23 ------------
 ipc/msg.c                  | 54 ++++++++++++++++++---------
 ipc/sem.c                  | 73 ++++++++++++++++++++++++++----------
 ipc/shm.c                  | 60 +++++++++++++++++++++---------
 ipc/util.c                 |  9 +++++
 ipc/util.h                 | 12 ++++++
 security/security.c        | 32 ++++++++--------
 security/selinux/hooks.c   | 92 +++++++++++++++++++++++-----------------------
 security/smack/smack_lsm.c | 68 +++++++++++++++++-----------------
 14 files changed, 297 insertions(+), 285 deletions(-)


Eric
