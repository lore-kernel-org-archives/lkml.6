Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1646101-1521559294-2-17928715222222853930
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521559293; b=CjHT4bD5HAmJ3Zz1DVHPg8p7lSjv1SDdrtHcZdD/AZF8VAa
    6rwjM2mYTSYv1faJ0MyJz7MCWo61f7CpKq+R22T4HJ27wSp4XCK2FQTxfov8uMkc
    dURFT2hiijzrU4ZHCH3JP/5Xpxikme68mVqJ1nXIo2nkBhcw4N27lkAWmOxXkUyW
    F9ZjFz1puIKv5e5BzAlAHtb08NE0pNHBtuBW4L+qhC9Rd7kfyjj1Oj4/EJmfd29w
    LCwLhwC6zmYow/mh2FrUiYqJ574nJUmWpoDOPOHzKitlQ3g1hVI3mlJXADxqX9KN
    exR+s5NHAAYfTKRAC15AGycvNjrsH128pRntaZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    arctest; t=1521559293; bh=rBZRwUYmAZtrhHAx+1Da5NRC9G5uH04LACCi7h
    btFgY=; b=KXHdcRLs4dXUfz/qfjo616w+Ix+lrhLJ2dSO7Rw0lnN1XI91PnB3bB
    AT1ENh/zNRDf7efIsmSDiHJYRN5/5TIyVFQyaz+QPeYqxqWoCuBiBeXQkVYVOatk
    qSnfGngDQx7c0dQGm4vXQEdh6F/0T+DOpIzfPKWA4fC9jbN0i1EdMJptg9aTgzCL
    j9+wjqjdngq20CpRj/U4S5FF4noaGranIr9y6cjEnKC/6CebS7TIbEz99Jww8dzl
    3DIKncjGRWTg8BRCUktFJahVzrWzzTmOO7b67XqV2eMVBNSZP1t8rsYTn/3w/eT3
    UG18VGCpUTxG4DO52jofsrZC3JUNrqow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751734AbeCTPVU (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 11:21:20 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51156 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTPVR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 11:21:17 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable\@vger.kernel.org" <stable@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc\@vger.kernel.org" <linux-parisc@vger.kernel.org>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
        <20180319154645.11350-118-alexander.levin@microsoft.com>
Date: Tue, 20 Mar 2018 10:20:21 -0500
In-Reply-To: <20180319154645.11350-118-alexander.levin@microsoft.com> (Sasha
        Levin's message of "Mon, 19 Mar 2018 15:49:14 +0000")
Message-ID: <87zi327ozu.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1eyJ4c-0003n4-U1;;;mid=<87zi327ozu.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/K36541h1GfHwcUPLQjbvz4xJX3IZw/sw=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on sa05.xmission.com
X-Remote-Spam-Level: ****
X-Remote-Spam-Status: No, score=4.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,XMSubLong,XMSubMetaSx_00,XMWhlSbjSex autolearn=disabled
        version=3.4.1
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  2.5 XMWhlSbjSex Whole Obfuscated Subjects
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Remote-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: ****;Sasha Levin <Alexander.Levin@microsoft.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 494 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 7 (1.5%), b_tie_ro: 6 (1.2%), parse: 1.28 (0.3%),
        extract_message_metadata: 26 (5.3%), get_uri_detail_list: 4.7 (1.0%),
        tests_pri_-1000: 14 (2.9%), tests_pri_-950: 1.40 (0.3%), tests_pri_-900: 1.12
        (0.2%), tests_pri_-400: 30 (6.2%), check_bayes: 29 (5.9%), b_tokenize: 11
        (2.3%), b_tok_get_all: 9 (1.8%), b_comp_prob: 3.2 (0.6%), b_tok_touch_all:
        3.7 (0.7%), b_finish: 0.58 (0.1%), tests_pri_0: 223 (45.2%),
        check_dkim_signature: 0.55 (0.1%), check_dkim_adsp: 3.3 (0.7%),
        tests_pri_500: 185 (37.4%), poll_dns_idle: 175 (35.5%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a conflict with SI_USER with SIGFPE
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sasha Levin <Alexander.Levin@microsoft.com> writes:

What is the justification for backporting this and the other similar
Documentation commits?

These commits just introduce a define _FIXME with value of 0, to
document that the userspace ABI was handled incorrectly long ago.

These commits do not fix anything.  Thes commits do not change anything
except a little how they are handled in siginfo_layout.  And I don't see
the changes that introduce siginfo_layout in kernel/signal.c being
backported.

Further these commits don't even have a fixes tag so I am curious
what is triggering them for backport.

Eric

> From: "Eric W. Biederman" <ebiederm@xmission.com>
>
> [ Upstream commit b5daf2b9d1c9a2b4f03ca93f75913ba2da3b3eaa ]
>
> Setting si_code to 0 results in a userspace seeing an si_code of 0.
> This is the same si_code as SI_USER.  Posix and common sense requires
> that SI_USER not be a signal specific si_code.  As such this use of 0
> for the si_code is a pretty horribly broken ABI.
>
> Further use of si_code == 0 guaranteed that copy_siginfo_to_user saw a
> value of __SI_KILL and now sees a value of SIL_KILL with the result
> that uid and pid fields are copied and which might copying the si_addr
> field by accident but certainly not by design.  Making this a very
> flakey implementation.
>
> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
> appropriate fields will reliably be copied.
>
> This bug is 13 years old and parsic machines are no longer being built
> so I don't know if it possible or worth fixing it.  But it is at least
> worth documenting this so other architectures don't make the same
> mistake.
>
> Possible ABI fixes includee:
>   - Send the signal without siginfo
>   - Don't generate a signal
>   - Possibly assign and use an appropriate si_code
>   - Don't handle cases which can't happen
>
> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: linux-parisc@vger.kernel.org
> Ref: 313c01d3e3fd ("[PATCH] PA-RISC update for 2.6.0")
> Histroy Tree: https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  arch/parisc/include/uapi/asm/siginfo.h | 7 +++++++
>  arch/parisc/kernel/traps.c             | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/include/uapi/asm/siginfo.h
> index 4a1062e05aaf..be40331f757d 100644
> --- a/arch/parisc/include/uapi/asm/siginfo.h
> +++ b/arch/parisc/include/uapi/asm/siginfo.h
> @@ -8,4 +8,11 @@
>  
>  #include <asm-generic/siginfo.h>
>  
> +/*
> + * SIGFPE si_codes
> + */
> +#ifdef __KERNEL__
> +#define FPE_FIXME	0	/* Broken dup of SI_USER */
> +#endif /* __KERNEL__ */
> +
>  #endif
> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
> index 8453724b8009..c919e6c0a687 100644
> --- a/arch/parisc/kernel/traps.c
> +++ b/arch/parisc/kernel/traps.c
> @@ -629,7 +629,7 @@ void notrace handle_interruption(int code, struct pt_regs *regs)
>  			si.si_signo = SIGFPE;
>  			/* Set to zero, and let the userspace app figure it out from
>  			   the insn pointed to by si_addr */
> -			si.si_code = 0;
> +			si.si_code = FPE_FIXME;
>  			si.si_addr = (void __user *) regs->iaoq[0];
>  			force_sig_info(SIGFPE, &si, current);
>  			return;
