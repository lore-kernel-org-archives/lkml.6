Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-94349-1527277892-2-1919662618560650147
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527277892; b=QObqkmmo3FVmNLglMmlajlOKMgHHOh/ZpIOGbL1D9giV7QpbWw
    Kep8nVUOXqJ5kgOuPuPPsMhoK3wyz4ajfL72PbSg3mDA96yqiS5pVZ8XPz+pxLCZ
    8uC/4sU0f86k5S+eIP1p9ikrksJdKTLA+et/R40o8Q4UQxlJ56QYrJiaRLB5QJkn
    ruW68VADhB8qDGfXqmNEBv+zKoH2mfmxO2jQZrV+pUdplcc5xQ4wnjQ6QRN9Gt6h
    ELwPPj/8KnWxL/wKQzWu/BFhyYTVFx/62FzoaHibxh03XNLoTUwAkdo3kxot6f/i
    DfVZAOnYjY+5qcIXLBV0lugQHW0JFgXBSEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527277892; bh=mYUxSNe1PfFvm+bXevzzZ8r7cwKBiGpvDhf6BpOK2s
    0=; b=PldfR1ICqnqUg7KQJiKCvdHFX1pj1s77VIYJmtl82qIMnCWySqZHgl405M
    ePlWlCoTW1dYI9OAwZ7pAQD/0+05bJYbnARB7fTbtWJSDuesPNlt54LmvtObPYOW
    7MSs5cHpsKRqFZTTQrRUh8GZMuuk3SkWeRMV71cFNa6Bw31G6mK5ygxbfx8vuHJM
    IFfUP1nPlNuoebVy3iExYqA+Earvv5PN4jsdByp73QWyzA3x3vzViAY561+/Kafv
    RFNPkdM2zvuPXumpTb1l/d5CujP47+L0Vg3dLveKsC1DjDc115UMKxNAzi64Vt2r
    KIDhH1YYgI6xRdnOruUyRnEp9O4g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfDpWc6ZaSaD4tMP4Jx39XqHaNwc6v9FwwpZPzgPHEFnFoCcb1ByhfGjV3NY+cHA9+gMEL3CgczLuNlQ8oHCWzOWALoXIJ7MSk5Lp41TfcmFduUzcl+Al
    9wqYTmmh6PdHV/DJPTjtzsEw7829hf8CWMCtPdZ+SvraTMQo/GmogroBheiuglJplWiZuztWCDBiQ9UD7z0srG3S/cJn82TkemnkFrra30g1wdG31E3zOqVm
    8Nwfs6dQamhJRKz18iTEig==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=K6HrmWtEAAAA:8
    a=VwQbUJbxAAAA:8 a=bEVomc3nWN40d8qWoEIA:9 a=x8gzFH9gYPwA:10
    a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967960AbeEYTv3 (ORCPT <rfc822;linux@kroah.com>);
        Fri, 25 May 2018 15:51:29 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:45986 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967823AbeEYTv2 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Fri, 25 May 2018 15:51:28 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Morris <jmorris@namei.org>
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        kexec@lists.infradead.org, Andres Rodriguez <andresx7@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <1527160176-29269-1-git-send-email-zohar@linux.vnet.ibm.com>
        <1527160176-29269-2-git-send-email-zohar@linux.vnet.ibm.com>
        <87po1k2304.fsf@xmission.com>
        <alpine.LRH.2.21.1805260139030.11624@namei.org>
Date: Fri, 25 May 2018 14:51:00 -0500
In-Reply-To: <alpine.LRH.2.21.1805260139030.11624@namei.org> (James Morris's
        message of "Sat, 26 May 2018 01:41:52 +1000 (AEST)")
Message-ID: <871sdzy0nv.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fMIk3-0004Ue-6K;;;mid=<871sdzy0nv.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.174.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+Sq/j99736fEu/+klTaZZOzsWTLZodYo=
X-SA-Exim-Connect-IP: 97.119.174.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4604]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;James Morris <jmorris@namei.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15021 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 2.6 (0.0%), b_tie_ro: 1.83 (0.0%), parse: 0.76 (0.0%),
        extract_message_metadata: 10 (0.1%), get_uri_detail_list: 0.96 (0.0%),
        tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.16 (0.0%), tests_pri_-900:
        0.99 (0.0%), tests_pri_-400: 19 (0.1%), check_bayes: 18 (0.1%), b_tokenize: 6
        (0.0%), b_tok_get_all: 6 (0.0%), b_comp_prob: 1.92 (0.0%), b_tok_touch_all:
        2.6 (0.0%), b_finish: 0.54 (0.0%), tests_pri_0: 152 (1.0%),
        check_dkim_signature: 0.46 (0.0%), check_dkim_adsp: 3.4 (0.0%),
        tests_pri_500: 14830 (98.7%), poll_dns_idle: 14821 (98.7%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

James Morris <jmorris@namei.org> writes:

> On Thu, 24 May 2018, Eric W. Biederman wrote:
>
>> Below is where I suggest you start on sorting out these security hooks.
>> - Adding a security_kernel_arg to catch when you want to allow/deny the
>>   use of an argument to a syscall.  What security_kernel_file_read and
>>   security_kernel_file_post_read have been abused for.
>
> NAK. This abstraction is too semantically weak.
>
> LSM hooks need to map to stronger semantics so we can reason about what 
> the hook and the policy is supposed to be mediating.

I will take that as an extremely weak nack as all I did was expose the
existing code and what the code is currently doing.  I don't see how you
can NAK what is already being merged and used.

I will be happy to see a better proposal.

The best I can see is to take each and every syscall that my patch
is calling syscall_kernel_arg and make it it's own hook without an
enumeration.  I did not see any real duplication between the cases in my
enumeration so I don't think that will be a problem.  Maybe a bit of a
challenge for loadpin but otherwise not.

Thank you in this for understanding why I am having problems with the
current hook.

Eric

