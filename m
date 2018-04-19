Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524149027-5-16180240210916200337
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524149027; b=xDfIiNKLucGtTwq0bNGvzOtjWyE5HvzXnr6JdCsz20FJo5UawJ
    s/CDkQRygpW6pPTUkh21OHTXqFDiWgXz2wklYjIf1nOzz/PGBKsLYHLu3k24MEMd
    5ArKO1eVh9lZiIlaH0wfAfFeA0ua1eyuXGUXPCCbjYCkvhhZo0mDiv81WKKSkVp5
    HlmB3qkKGp9cly5p8reqrHoyHw//R0ilkYVKBgpQ1rMUDXn7ADKoGv+i0hEVy2JY
    WUXnay7EK3UrJqAR9YZ/6l+KnLbF3kGAouXTf6hSuqmk8ZFWP/SxYWb0OU6JA+34
    kDh27HNojL7IbF/uXNh/MFZiyAX1EJRkGYNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524149027; bh=
    LsvS7DcQxJZUIppftglfQwvXwMzRU28QlAmbrIgqmyQ=; b=NW6pIUPeLdodQpPS
    ul1P3azRPpvGBrq+GxamMO1qKs9CwIK+aNeRVv5AxqpG4IVXrGVKp4hReH79gwt8
    yQtnbQJPRWvuKTyE4fEGHmRa+dy8oIxQl9q4pS1XLN0PoEklp4+8nfZAM8VCVKGc
    1is282ZzeZ+gzCpRshLEewPpP1ztV5Gr65Z5FeXxiCOnI6ChNouW39tu7xiAfbrd
    6K65tLRzFGgQmFdielrIrT5V1AOJHL8QV+T81JT4/dICgXWlB0quq/OXWPOP7lDd
    PsNMc7Dlo9LW1aOicKVYtINpn2Ahix1+axtuK2YuH6FV3nUFzplVwPAXZGHNB+jP
    0AR4jA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCL3dBEajN2msgzAJ3CvPS/iVXBGRX4fwOiCmB99SQG4tNkrRfsii38w8iRhNUkSM0QHGDvQBpWhxeyZu5fr6K6aJPtMLmi8sxyp+bcYpXlNPtJz3SOW
    h3ETB/Xg0YHUcgm0Esg6gp+afAnmk39P/gZiy2iIRwKAohyToeLw6ewnPjdqc84L93T1SpCopeqjZMDtjGxPX3augm8xseytwjCoZXFkJlHLDqmeS1Tt1u8O
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=5QZOrnP-N_GQhJ_ZMqEA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeDSOnJ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 10:43:09 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54107 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDSOit (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 10:38:49 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: y2038@lists.linaro.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, libc-alpha@sourceware.org,
        tglx@linutronix.de, deepa.kernel@gmail.com,
        viro@zeniv.linux.org.uk, ebiederm@xmission.com,
        albert.aribaud@3adev.fr, linux-s390@vger.kernel.org,
        schwidefsky@de.ibm.com, x86@kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-mips@linux-mips.org, jhogan@kernel.org,
        ralf@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 05/17] y2038: arm64: Extend sysvipc compat data structures
Date: Thu, 19 Apr 2018 16:37:25 +0200
Message-Id: <20180419143737.606138-6-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180419143737.606138-1-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de>
X-Provags-ID: V03:K1:0JzYSZcHr7NxbSRG/1MxgZaJ5JU+b3m4LiNGtOkxl/QzRgNqGf9
 HDvtz0qrMIjJMP1YuATtpumjuElGmO3EPCUs2FdfOtyJAJxiyzWX+oSL4Oad9KGjqQ0LLY/
 fK/s1hgkMF2ydYQatBY4p2CWjH0UybJtbktZR/PkiyJazDMpQej0ek+vTUtcXxvo+95GFTt
 qPX8dlcqBNUzSaaGi+7DA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yqv5fC47tG0=:pnVW2fG3BmXOs6HCM/g/Fi
 kaWsTJEz6m3QVPtBL+1rMrb/IWI3iJc24yNU9uM7fgC5tshukHsB5u7DFEgE4dBu5/afNgvit
 JubdB2GJHb+C0IMhPRWlg7WQxlFF/wo3DurvbPpYvuFWDJFYQ+eqdEKtrfyCBmD8/ztCeDUWY
 MABvtlTPUNlXzajX7Bj/XPF8s6wPNaUMXBHd24E4wtAwqQnah0WI5W/C4jqv9Y8oLa620ShEc
 ObzDvuoxm1fkaJBEKaSat7pP162+r0pF5T3BuuVtaJfBR39XojRYXuNuiTG8gePnRfaWqf99K
 XA0idEDa4WNW6tIFoh9SXQyhoDbXPskOMdZrJj3xAON5IdTi4rh5aWwKaZ4RVhs80El5WHDZD
 Yj5jutOkcGUjw904K3RXhginebeUVy/tBny9elvakEt3tMKZgTYr9aK0ppSNrrc1rH9R3Csmq
 MUZrWRt+uSKJUZJKpaezFKGxD9bf/PFVBoCAdfnsJVJ8qOiK+oR7+0pJKhZR/L1wg7/4xYlzU
 /bo+4e4sWK2UiREfL16ll4Qq5p57Omqm0j5+zH1fnTADBp0Y8jG1654xluyDQn7AxzXflJf29
 sSiLnCRHV2G+CmNIiV+tSNWvGbVxuSC3pjmFccCJwzcqVLiHpdULQn5WFFp0jNCGRILvlKLWV
 djUwOvdXzN798OtHSlo9GnACZfgGU6BfP24DztxUeVlKX1hg5/sS/vF5joRP1Cr5fvAmjOSS7
 svQXWOUUGmfMqYn47kAV+ti4RbBUuCQ4sofKiw==
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Both 32-bit amd 64-bit ARM use the asm-generic header files for their
sysvipc data structures, so no special care is needed to make those
work beyond y2038, with the one exception of compat mode: Since there
is no asm-generic definition of the compat mode IPC structures, ARM64
provides its own copy, and we make those match the changes in the native
asm-generic header files.

There is sufficient padding in these data structures to extend all
timestamps to 64 bit, but on big-endian ARM kernels, the padding
is in the wrong place, so the C library has to ensure it reassembles
a 64-bit time_t correctly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/compat.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/compat.h b/arch/arm64/include/asm/compat.h
index 0030f79808b3..1a037b94eba1 100644
--- a/arch/arm64/include/asm/compat.h
+++ b/arch/arm64/include/asm/compat.h
@@ -181,10 +181,10 @@ struct compat_ipc64_perm {
 
 struct compat_semid64_ds {
 	struct compat_ipc64_perm sem_perm;
-	compat_time_t  sem_otime;
-	compat_ulong_t __unused1;
-	compat_time_t  sem_ctime;
-	compat_ulong_t __unused2;
+	compat_ulong_t sem_otime;
+	compat_ulong_t sem_otime_high;
+	compat_ulong_t sem_ctime;
+	compat_ulong_t sem_ctime_high;
 	compat_ulong_t sem_nsems;
 	compat_ulong_t __unused3;
 	compat_ulong_t __unused4;
@@ -192,12 +192,12 @@ struct compat_semid64_ds {
 
 struct compat_msqid64_ds {
 	struct compat_ipc64_perm msg_perm;
-	compat_time_t  msg_stime;
-	compat_ulong_t __unused1;
-	compat_time_t  msg_rtime;
-	compat_ulong_t __unused2;
-	compat_time_t  msg_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t msg_stime;
+	compat_ulong_t msg_stime_high;
+	compat_ulong_t msg_rtime;
+	compat_ulong_t msg_rtime_high;
+	compat_ulong_t msg_ctime;
+	compat_ulong_t msg_ctime_high;
 	compat_ulong_t msg_cbytes;
 	compat_ulong_t msg_qnum;
 	compat_ulong_t msg_qbytes;
@@ -210,12 +210,12 @@ struct compat_msqid64_ds {
 struct compat_shmid64_ds {
 	struct compat_ipc64_perm shm_perm;
 	compat_size_t  shm_segsz;
-	compat_time_t  shm_atime;
-	compat_ulong_t __unused1;
-	compat_time_t  shm_dtime;
-	compat_ulong_t __unused2;
-	compat_time_t  shm_ctime;
-	compat_ulong_t __unused3;
+	compat_ulong_t shm_atime;
+	compat_ulong_t shm_atime_high;
+	compat_ulong_t shm_dtime;
+	compat_ulong_t shm_dtime_high;
+	compat_ulong_t shm_ctime;
+	compat_ulong_t shm_ctime_high;
 	compat_pid_t   shm_cpid;
 	compat_pid_t   shm_lpid;
 	compat_ulong_t shm_nattch;
-- 
2.9.0

