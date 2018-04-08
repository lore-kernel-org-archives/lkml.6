Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1705864-1523174888-5-7962784162727232067
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523174887; b=fMpRHxRxDsw627f/kPP2Y6QgWLkJaTDFsIh+y3nbEpJSm7rzu5
    LXE4ac6fX2U5ckGWHxKOuGwQrjymwePyJM24VrAcWohiErjb6dGcqnStFCd87fhf
    rjLi1anzv0y50upqcgqKhieZOQ010iy/VERPmmhWiUO9QSBH5HxXihOa+vSbwwIC
    xQ6/QKjPIk8xdqc2UBSMGbouJaLpNxoItXpQts2PRx6yRnhyEfhZ77s3R+EqwxXA
    lp5ZVxUEClg3zLMz/qe/DDw1lNqAmqLBzDticUYfCUzDM7qNTwZhUlCdsb931Ci8
    jp+mWutWEK3kMKQk0Esf5wYhfltiukzr1gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523174887; bh=lIYjZMwCvbAWR0CSIXclKtRCQZYF9v
    8CRWdw9zkSd/Y=; b=OM+zfLjgIPKB4v8+++Wsd2CQ1dJaSTWqGxhS/vo0QGpqZF
    q4HyEE+GtMvc+arUag+Birc3TAsOtRW6ixd1Gaw5G9TOkdSZRS0qefYzkoQlmHcC
    vED4lnbGdxv4fBRZfK0B4u7ks5mWUR3IhTDjeZrvXTG+DbeXmu4MGN18O7hyiBo8
    NcuOk/bUYnwVKLT3UtwBHvP5UVfypJ6xB9+VAJ40f8yTRlV2ViYzj//VhKujS9PV
    a/qWYWpi2ACK+cm2lkl9s/7wjH10mn8RPeXChUerWowlFpRxhItCmn1hxoefDKZR
    bWlXFijSqr6do3BOARK0oqAMEQ4SQKyLBpqJp27Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEPY61aJ+54KtX2t4+WAet6m7AkNqDvRSInQ8PuvZBlJhGgK/TochMkCpBT27/CXrPcywOd1384UuPiGvVDh2LY+7cqLHpIeCedQO6Tcc0WTIc8nkNSk
    sc1EQSZhFz+fk9b1Xrdk/LEUBLZ0fwGphC0SDoO4UEypCoBl3F9jnBCZFPU2mXJFb+XY99hrkZoixv4VsX/aMtJxlXB8u3CbOmVSfKdjG58UumAdsuMPYi70
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gQGbs8_HAAAA:8 a=9eUR4hBT7iw1T6XgGNQA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=1pMqk7AwgTXjlBDkgM7h:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751309AbeDHIID (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 04:08:03 -0400
Received: from smtp.nue.novell.com ([195.135.221.5]:46642 "EHLO
        smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750891AbeDHIIC (ORCPT
        <rfc822;groupwise-linux-api@vger.kernel.org:0:0>);
        Sun, 8 Apr 2018 04:08:02 -0400
Date: Sun, 8 Apr 2018 16:07:42 +0800
From: joeyli <jlee@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
Message-ID: <20180408080742.GE7362@linux-l9pv.suse>
References: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQLu5EZLJ1C9-dd4=K+sed6+38oy047+nqCMfuPFB=wttw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 07:34:25PM -0700, Alexei Starovoitov wrote:
> On Tue, Apr 3, 2018 at 9:26 AM, Andy Lutomirski <luto@kernel.org> wrote:
> > On Tue, Apr 3, 2018 at 8:41 AM, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Tue, Apr 03, 2018 at 08:11:07AM -0700, Andy Lutomirski wrote:
> >>> >
> >>> >> "bpf: Restrict kernel image access functions when the kernel is locked down":
> >>> >> This patch just sucks in general.
> >>> >
> >>> > Yes - but that's what Alexei Starovoitov specified.  bpf kind of sucks since
> >>> > it gives you unrestricted access to the kernel.
> >>>
> >>> bpf, in certain contexts, gives you unrestricted access to *reading*
> >>> kernel memory.  bpf should, under no circumstances, let you write to
> >>> the kernel unless you're using fault injection or similar.
> >>>
> >>> I'm surprised that Alexei acked this patch.  If something like XDP or
> >>> bpfilter starts becoming widely used, this patch will require a lot of
> >>> reworking to avoid breaking standard distros.
> >>
> >> my understanding was that this lockdown set attemps to disallow _reads_
> >> of kernel memory from anything, so first version of patch was adding
> >> run-time checks for bpf_probe_read() which is no-go
> >> and without this helper the bpf for tracing is losing a lot of its power,
> >> so the easiest is to disable it all.
> >
> > Fair enough.
> 
> Actually looking at the patch again:
> https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?h=efi-lock-down&id=78bb0059c3b8304a8d124b55feebc780fb3e0500
> 

The bpf is totally disabled in this patch.

> If the only thing that folks are paranoid about is reading
> arbitrary kernel memory with bpf_probe_read() helper
> then preferred patch would be to disable it during verification
> when in lockdown mode

Sorry for I didn't fully understand your idea...
Do you mean that using bpf verifier to filter out bpf program that
uses bpf_probe_read()?
.
> No run-time overhead and android folks will be happy
> that lockdown doesn't break their work.
> They converted out-of-tree networking accounting
> module and corresponding user daemon to use bpf:
> https://www.linuxplumbersconf.org/2017/ocw/system/presentations/4791/original/eBPF%20cgroup%20filters%20for%20data%20usage%20accounting%20on%20Android.pdf

Thanks
Joey Lee
