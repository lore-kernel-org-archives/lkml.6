Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2517369-1527195021-2-8578028378753620046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527195021; b=DA8PxFqI2NRjAV8IoMn7SNaMkCZz2BwZaMQ4lOhrDoH3uEkPCP
    CF6W1iSs4IGEZ9jB4O+Xym+Xk2bOMlTHLBeogh1Ocv/JpwjoabSCq2OiDZUD9yw3
    UQcbyvPDKarkFH844EmB8+B2nkvz+nIvbAGRQjuRqn4Rbc1GT2INOu/Xu0sQYNMg
    epkNwwQTiI8gmPD306yc15aqQ9nlU+4AnJRwnzz2Hgbb5+L7KFtGUPULK3CRGz2N
    cOQAu/tYXzML5Kf2snSduGmTypZ2G6F4E4trxcT3djDSQLN6CGaDAjm3PozGkc6Y
    qu8DOBlm9lW36oFWRqd6nI0ISvAcP7Mt1ogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527195021; bh=OpuxvvKA3owOrl+yskE1DKmGTzcjsJhmD1CGveTqpI
    4=; b=DmtNwjufoniss0cf/fSzY/eQMe71rqmciNapBTVoWRadoXQlNSWn3tslQ1
    IpoZgma2ZjusuA7thMC2mjnqagBqrp1RItP4QmTad8cN4ZgUututUTen+w2XgkAp
    Zw0LYJVMP90CtKn449I8dzoay4l5sxB6sqOdOqUHT8J6IdbX9tOko3BwhGnZ0lvq
    0Qw9qIe6fCRQbhPtiPwTSswsvq3lF/uetsWphmtQ4kX+9pK5RAFyPxqPzqEgN3pV
    1jTQt0q9lyOVJTkcac6cGrU8W56Cv+UQjcJuPolzWthtQL6eV/VNP50z+7aDhTFT
    Usf63eyJts1iOd+zTnEXTcOmTzhA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBhu/DrtqZS6pyxqLT7Z29IsAzzCyCMO6sVUeAPLOcYCUtg68H81B9iUaUAomCymkJlPHYA4WKlMIgqp+AkmeF+qkYNWqrAjspmXgh2WYnIGleADJlZ5
    SIdxA3uDxOHCXFA7/zYG+Ft6qz+k14hY26xoprWD2UE62hdzyybXrykjmQOpI4hq6MXW4Q0CIuU2pQZoYvUYHaXY6QHCfqw8QB6c9QeaFQdozgj3ErTE13ow
    JiSw7vI8bfedSUM44RnxQA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VnNF1IyMAAAA:8
    a=PtDNVHqPAAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8
    a=woq6hQ0zTG0wGgjgKtcA:9 a=x8gzFH9gYPwA:10 a=BpimnaHY1jUKGyF_4-AF:22
    a=AjGcO6oz07-iQ99wixmX:22 a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969479AbeEXUuR (ORCPT <rfc822;linux@kroah.com>);
        Thu, 24 May 2018 16:50:17 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:35175 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966499AbeEXUuO (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Thu, 24 May 2018 16:50:14 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1527160176-29269-3-git-send-email-zohar@linux.vnet.ibm.com>
Date: Thu, 24 May 2018 15:50:03 -0500
In-Reply-To: <1527160176-29269-3-git-send-email-zohar@linux.vnet.ibm.com>
        (Mimi Zohar's message of "Thu, 24 May 2018 07:09:31 -0400")
Message-ID: <87k1rs22ys.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fLxBc-00054m-B0;;;mid=<87k1rs22ys.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18H+yMl6ib3PjPYrgfcPi9KxUpmnZGcqyI=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Mimi Zohar <zohar@linux.vnet.ibm.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1046 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 2.3 (0.2%), b_tie_ro: 1.54 (0.1%), parse: 1.17 (0.1%),
        extract_message_metadata: 16 (1.5%), get_uri_detail_list: 2.5 (0.2%),
        tests_pri_-1000: 10 (1.0%), tests_pri_-950: 1.28 (0.1%), tests_pri_-900: 1.03
        (0.1%), tests_pri_-400: 27 (2.6%), check_bayes: 26 (2.5%), b_tokenize: 10
        (0.9%), b_tok_get_all: 7 (0.7%), b_comp_prob: 3.4 (0.3%), b_tok_touch_all:
        3.3 (0.3%), b_finish: 0.65 (0.1%), tests_pri_0: 177 (17.0%),
        check_dkim_signature: 0.68 (0.1%), check_dkim_adsp: 2.8 (0.3%),
        tests_pri_500: 807 (77.1%), poll_dns_idle: 802 (76.7%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH v3 2/7] kexec: add call to LSM hook in original kexec_load syscall
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Mimi Zohar <zohar@linux.vnet.ibm.com> writes:

> In order for LSMs and IMA-appraisal to differentiate between the
> original and new syscalls, both the original and new syscalls must call
> an LSM hook.  This patch adds a call to security_kernel_read_data() in
> the original kexec syscall.

Until the lsm hook mess gets cleaned up.

Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>

>
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> Cc: Eric Biederman <ebiederm@xmission.com>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: David Howells <dhowells@redhat.com>
> ---
>  kernel/kexec.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index aed8fb2564b3..061ada41c18c 100644
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -11,6 +11,7 @@
>  #include <linux/capability.h>
>  #include <linux/mm.h>
>  #include <linux/file.h>
> +#include <linux/security.h>
>  #include <linux/kexec.h>
>  #include <linux/mutex.h>
>  #include <linux/list.h>
> @@ -195,10 +196,17 @@ static int do_kexec_load(unsigned long entry, unsigned long nr_segments,
>  static inline int kexec_load_check(unsigned long nr_segments,
>  				   unsigned long flags)
>  {
> +	int result;
> +
>  	/* We only trust the superuser with rebooting the system. */
>  	if (!capable(CAP_SYS_BOOT) || kexec_load_disabled)
>  		return -EPERM;
>  
> +	/* Permit LSMs and IMA to fail the kexec */
> +	result = security_kernel_read_data(NULL, READING_KEXEC_IMAGE);
> +	if (result < 0)
> +		return result;
> +
>  	/*
>  	 * Verify we have a legal set of flags
>  	 * This leaves us room for future extensions.
