Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2055499-1519753027-2-2807456681199765745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519753027; b=bXiNN0ujpu44s+2vToFIrzxCtcb94sRQMCotsKPW9KK6ONe
    D0vut4pQPwWvz/0dE87AY167s3kg8fkaOjKAV31ikoiul5/9qrqvGp8wkGS65gOx
    BjZoZR/9St/CerMe1am5ostfsyGqXj2V12eVjnJuUEzYuvsvZ2JPSAaBqYZ2+R7u
    MyHiVfYEYxPrjdM+Edt1P0Zw7oysPRxQxmUHdhRavmf8DxraxcKV4A0FRAOBYQlf
    JeEGzRS5dSs4mL6ufpxpErSxKZ3I1oJtgMIr4N8mXraeeirI57K3390RuWsja0/Y
    M8OIcXFGG0BHnjIm4A5NDSH2dHyKdKESO6UmEsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519753027; bh=Wn2GP0NOZRbbNjR56xuVoCfE5L2uEH4uSVQCQltzIuk=; b=b
    RLNabfIY+AVIiRvkJf49rwC72TBtLPMkDEeZ/td6mIlyXy/lxmaylBDW+XE+KunF
    DAIMIjBoZxK4xz3kgv8UkR7qLEPO0rW8prXMSLRnGEP+tZAPlbHm6XLV33LZ6vGb
    ongOu1tUqm2PrHH9iLlCKicmB9CD95SRisoWYJEl9jAtS+CIDmKQdhA37Ip4zoik
    HTiKw5NAOPlm+gx0+Kz2Z8w9jqlZIr9esJ4riAc7LJo0h7098eMOhFEEDccXfSXD
    Ws7u2sJ0SzVtfNAp89bKUzjR5TRSa+iCMMVhswU/tgNna+hwhar/OtYJ3SwnJBgb
    LSdT7Gb/vCwHfEefLufrw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751531AbeB0Rg6 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 27 Feb 2018 12:36:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:45086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751754AbeB0Rg5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Feb 2018 12:36:57 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B33217BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELs3qDNO3vxCPEhTfLNrZ+ZVFuMXUzIlhKSc1CKCbfCmu6q8iUsl58XceqF4AExfG0ARx4It+G8+12AMsgPITyM=
MIME-Version: 1.0
In-Reply-To: <b9579dae-625e-cd91-0656-821a8d1f2893@schaufler-ca.com>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp> <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp> <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp> <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
 <b9579dae-625e-cd91-0656-821a8d1f2893@schaufler-ca.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 27 Feb 2018 17:36:34 +0000
X-Gmail-Original-Message-ID: <CALCETrVo61UOGHJ6AgrLN_AyzUYuz-JRgET4d6ut-ErwUg_vZA@mail.gmail.com>
Message-ID: <CALCETrVo61UOGHJ6AgrLN_AyzUYuz-JRgET4d6ut-ErwUg_vZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 5:30 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 2/27/2018 8:39 AM, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
>> <alexei.starovoitov@gmail.com> wrote:
>>> [ Snip ]
>> An earlier version of the patch set used the seccomp filter chain.
>> Mickaël, what exactly was wrong with that approach other than that the
>> seccomp() syscall was awkward for you to use?  You could add a
>> seccomp_add_landlock_rule() syscall if you needed to.
>>
>> As a side comment, why is this an LSM at all, let alone a non-stacking
>> LSM?  It would make a lot more sense to me to make Landlock depend on
>> having LSMs configured in but to call the landlock hooks directly from
>> the security_xyz() hooks.
>
> Please, no. It is my serious intention to have at least the
> infrastructure blob management in within a release or two, and
> I think that's all Landlock needs. The security_xyz() hooks are
> sufficiently hackish as it is without unnecessarily adding more
> special cases.
>
>

What do you mean by "infrastructure blob management"?
