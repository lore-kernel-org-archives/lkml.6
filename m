Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522856728-2-11467737126450783954
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856727; b=f/d1de6SJSnfJwZMVxASLMAqfn3tfK/E99eSFVo03mVqWLdeRv
    gZqmSnXTxfJ9SpaSDjxbtsKYpo4BaGkmfKEQwpu/bXUf9szGFK1F6NuFoNho15db
    Jg6ibcya4Vv7ZZQMbiJfVTbz/vvhcJ2KsCbwwkL0Z1rnQAE/vZDWGbpfmi9aZDxC
    rvWfhP5pGlsixyLCXOakr72ygCeMdvjuq9yb/SzcsFU9jax6zlSiBdfwyLN9JN6h
    4OOlI/aBbs5ScM8d6BVlyoJGSdGLu3/0QhtPKx/xFqN1JeJZPjNvXz63TK5HTnfZ
    93xGibnGhgRvTlHFZutqzhKq4QGXxetsM5Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:references:date:in-reply-to
    :message-id:mime-version:content-type:subject:sender:list-id; s=
    fm2; t=1522856727; bh=iCeJLxw1d0LK+RZh8iN7zDG01NAHeQf/r/76tFe8zw
    c=; b=u8S3Q91AFhAOYCidmNxjuY64GasWEMAf9vceNdG0J7ta7MCI48iIlaI09n
    9Tn3T6f9oAzKra4pLY5Dav0seSQmy2nt7Vkmw4o6e9Ex/xIZgJxF5WSqpb9POs2/
    qP00zyxEPWS8+NkxdAwitKJscYnJkbFy8BRW1j9b32P6/pJf9sPRhImYkMbyRvW8
    ltied8KnBySLtt0G5Fzda1Mowy7RDbtsj8oP33sMQd2qWr1QHYjUxOaunAEMW3EM
    NDNpYO7IEiNubih525zPlaxHR+wDGyRRC0E7JHngEcpKtsAnJWa6POdBFPfu6te/
    YJ0VskvS47fNgLaDrPCnU5nFeg2Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xmission.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfKD0bMdaiKs6aDH3tCKW+4Bhnze3BOmbH9JJXKeOlrVSTRqPLI6vapDgaKcUaJ8x4uBwy97d2KhGpq7hVK3oqsR1xqvvAC/L2lZnDpmihW/753lqRW8L
    ea4GdV3LBgq3j8OLHyGsURe7+SrMwyVDy1ipE33Z8viw1MRQoN+9QE6MYgSnTvQwQvldNQPtwNQW1VKf+iR2WmV9LqdiyeD8DTRrO+Zpi0rR9lu6JiRKMcW2
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8
    a=VwQbUJbxAAAA:8 a=kAg-hELXVX7Yf0cRL_wA:9 a=D6CKdeY2nd0A:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751612AbeDDPpK (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:45:10 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58139 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751466AbeDDPpI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 11:45:08 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
References: <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com>
        <30459.1522739219@warthog.procyon.org.uk>
        <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
        <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
        <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
        <9758.1522775763@warthog.procyon.org.uk>
        <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
        <13189.1522784944@warthog.procyon.org.uk>
        <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
        <9349.1522794769@warthog.procyon.org.uk>
        <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
        <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
        <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
        <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
        <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
        <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
        <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
        <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
        <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
        <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com>
        <20736.1522829117@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 10:43:57 -0500
In-Reply-To: <20736.1522829117@warthog.procyon.org.uk> (David Howells's
        message of "Wed, 04 Apr 2018 09:05:17 +0100")
Message-ID: <87fu4bj7sy.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1f3kav-0007rS-Pt;;;mid=<87fu4bj7sy.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=67.3.145.25;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+Ck+qhCKGvXg7Sf9Tw5GDCuSznbdYMMI4=
X-SA-Exim-Connect-IP: 67.3.145.25
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on sa01.xmission.com
X-Remote-Spam-Level: **
X-Remote-Spam-Status: No, score=2.1 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TVD_RCVD_IP,T_TM2_M_HEADER_IN_MSG,XMSubMetaSxObfu_03,
        XMSubMetaSx_00 autolearn=disabled version=3.4.0
X-Remote-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
X-Remote-Spam-DCC: XMission; sa01 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;David Howells <dhowells@redhat.com>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 476 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.3 (0.7%), b_tie_ro: 2.3 (0.5%), parse: 1.38 (0.3%),
        extract_message_metadata: 4.6 (1.0%), get_uri_detail_list: 1.95 (0.4%),
        tests_pri_-1000: 8 (1.7%), tests_pri_-950: 2.2 (0.5%), tests_pri_-900: 1.72
        (0.4%), tests_pri_-400: 35 (7.3%), check_bayes: 33 (6.9%), b_tokenize: 14
        (2.9%), b_tok_get_all: 8 (1.8%), b_comp_prob: 4.5 (1.0%), b_tok_touch_all:
        2.9 (0.6%), b_finish: 0.82 (0.2%), tests_pri_0: 392 (82.2%),
        check_dkim_signature: 0.88 (0.2%), check_dkim_adsp: 4.4 (0.9%),
        tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
X-Remote-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

David Howells <dhowells@redhat.com> writes:

> Andy Lutomirski <luto@kernel.org> wrote:
>
>> As far as I can tell, what's really going on here is that there's a
>> significant contingent here that wants to prevent Linux from
>> chainloading something that isn't Linux.
>
> You have completely the wrong end of the stick.  No one has said that or even
> implied that.  You are alleging dishonesty on our part.
>
> What we *have* said is that *if* we want to pass the secure boot state across
> kexec, then we have to make sure that:
>
>  (1) no one tampers with the intermediate kernel between boot and kexec
>      otherwise the secure boot state is effectively invalidated, and
>
>  (2) the image that gets kexec'ed is trusted.
>
> Remember: you cannot know (2) if you don't have (1).
>
> And if someone tampers with the aim of breaking, say, Windows, then someone,
> e.g.  Microsoft, might blacklist the shim.

*Wow*   You just denied this isn't about not booting Windows and a few
lines later said that is your concern.

I was thinking I would have to dig up old archives where I had been told
this before, but you just nicely repeated all of the old arguments so I
don't see the point.

Eric
