Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2698890-1527628241-2-14474494183394135507
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527628240; b=My634DOj1Jt5yL28wM4NaLYzXeoBe3lMV2nJwkqxfM6AYc2MLu
    0aKAxSriyhFrHoc73guctzQebUx7VdUhOcSVW7VLwnyCZ1kVPWMEoQGM0Fpk7f0H
    YISGIoHvNzNr61Z1YCAE/primbQjoFOx8vODhrS2JIEWv8IDu4hgmts8dJ/J2WMt
    Msi6mevMMpDPIVOlV8oOenLtmQiepM1twAdVzKmBV3n/mQq/gbUz1bs/JgBNhDBD
    eLPd1MsC6jLSijF7aGs6uVvV89Wu64k4lXzDVbFMWyHJB31iIAjBL5ZYSAVKF+5a
    xteWfd+BOHnuWKutG6NLa4X9l+Nx+eKTcogQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1527628240; bh=dUvQ1fENl6tVKGXSVlAh7rH0HDurEmMrHMPF0iIKjV
    s=; b=kE2qZxXmTS84/Cv2OxIrTbWrblbE3QBfEe0rox87PVcjh7BwYOoEwGN32B
    zDFpSHrl6YMBlbJ8A8AWrgenlvj+VyBRvgQ+W7L/s5HT/0xum6BQ9ydXXoHOjfXw
    PYN1Olekod59eFNULjyMLUDx/50RFjCswIhBSwsrvujbhfN7jILCGgb1OJ3vxZCA
    iAttUpbKemBBN5VTUpz8nc0IxZOnXjrE8LCI1DWmxilN9ZJq0cYkTA8sUpYChRgd
    a/vBvT4whanm+FJ586U/pegDDC0xMBLPbGRSAkQzcz1kaURJ5VXG5iF62lLq0GqH
    rPrw18XTxJVeSNzP1OSiWCmEaWvQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEIi8hyUJGYYos0kpNiFWCiU7SIwtP5fp8O+S2o0XzUjsICEW+rT9I9zjiY0Ty15zH0R2ZgIj5CIZfpBLDdb5Hgb4mNRu/bujwDVvoc3L4wRoFnFUe45
    FqSakU5A5czvE3ISpHgWY1uNG+AY3KVK6CDkd32uBEFxPeU2DwHhmgZ6sGm9xh6xG37Ieki4IJ/TO/vbIYV+as+Moy39wEJlOQkY36AAYOebC0Sy4ZAMUn7j
    zEG9tKojUqQa1dIcoXnisQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=K6HrmWtEAAAA:8
    a=VwQbUJbxAAAA:8 a=WXCfvSjPL_C3uikGotYA:9 a=x8gzFH9gYPwA:10
    a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937009AbeE2VKh (ORCPT <rfc822;linux@kroah.com>);
        Tue, 29 May 2018 17:10:37 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:44093 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933907AbeE2VKf (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 29 May 2018 17:10:35 -0400
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
        <871sdzy0nv.fsf@xmission.com>
        <alpine.LRH.2.21.1805300629220.2647@namei.org>
Date: Tue, 29 May 2018 16:10:30 -0500
In-Reply-To: <alpine.LRH.2.21.1805300629220.2647@namei.org> (James Morris's
        message of "Wed, 30 May 2018 06:32:16 +1000 (AEST)")
Message-ID: <87y3g2kw1l.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1fNlt3-0007u7-W5;;;mid=<87y3g2kw1l.fsf@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.124.205;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+iZ1lU4Fl4UGi5EiQCqKh5cNqEjq7vy2s=
X-SA-Exim-Connect-IP: 97.119.124.205
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4871]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_12 obfuscated drug references
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;James Morris <jmorris@namei.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 229 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.3 (1.5%), b_tie_ro: 2.2 (1.0%), parse: 1.05 (0.5%),
        extract_message_metadata: 12 (5.2%), get_uri_detail_list: 1.64 (0.7%),
        tests_pri_-1000: 6 (2.6%), tests_pri_-950: 1.19 (0.5%), tests_pri_-900: 0.98
        (0.4%), tests_pri_-400: 21 (9.3%), check_bayes: 20 (8.9%), b_tokenize: 7
        (2.9%), b_tok_get_all: 7 (3.0%), b_comp_prob: 2.1 (0.9%), b_tok_touch_all:
        2.7 (1.2%), b_finish: 0.63 (0.3%), tests_pri_0: 176 (76.7%),
        check_dkim_signature: 0.49 (0.2%), check_dkim_adsp: 2.4 (1.0%),
        tests_pri_500: 4.5 (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3 1/7] security: rename security_kernel_read_file() hook
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

James Morris <jmorris@namei.org> writes:

> On Fri, 25 May 2018, Eric W. Biederman wrote:
>
>> James Morris <jmorris@namei.org> writes:
>> 
>> > On Thu, 24 May 2018, Eric W. Biederman wrote:
>> >
>> >> Below is where I suggest you start on sorting out these security hooks.
>> >> - Adding a security_kernel_arg to catch when you want to allow/deny the
>> >>   use of an argument to a syscall.  What security_kernel_file_read and
>> >>   security_kernel_file_post_read have been abused for.
>> >
>> > NAK. This abstraction is too semantically weak.
>> >
>> > LSM hooks need to map to stronger semantics so we can reason about what 
>> > the hook and the policy is supposed to be mediating.
>> 
>> I will take that as an extremely weak nack as all I did was expose the
>> existing code and what the code is currently doing.  I don't see how you
>> can NAK what is already being merged and used.
>
> It's a strong NAK.

We are either not understading each other or you have just strong NAK'd
part of the existing LSM api.  Not my proposal.

> LSM is a logical API, it provides an abstraction layer for security 
> policies to mediate kernel security behaviors.

The way it deals with firmware blobs and module loading is not logical.
It is some random pass a NULL pointer into some other security hook.

> Adding an argument to a syscall is not a security behavior.
>
> Loading a firmware file is.

It is a firmware blob not a file.  Perhaps the blob is stored as a file
on-disk, perhaps it is not.

The similar case with kexec never stores all of the data in a file.

Why module_init (which does not take a file) is calling a file based lsm
hook is also bizarre.


Perhaps that means all 3 of these cases should have their own void
security hooks.  Perhaps it means something else.  I just know the name
on the security hook, how it is getting called, and how it is getting
used simply do not agree.

Eric
