Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1988021-1519752667-2-16963608960212479755
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519752666; b=k1Y7ea7tjMGSMnmJCogWFTqfPN9fpDAlOZVqV9l9D6faIEX
    pjRlzTjV3yV6J3m8n1K2ISOmjpMLav/CJcrtA08TSqNlkINMGowM3Or6BOwJayO6
    YYJSLq8Ehb9TvPIWUNSxWEHWOsSForaSwJITzz+y0+9d70Mu1ikMWzoOopOTqpdE
    NWtNhzWcH9XyJh/T17s1QDZyQYgYwCKiAd7PtWnqWQW6hfiMl0E0EP2nQyJl0GiK
    AQmBm/kSLqYgOJWed2I45qdV7vMI9mprl32YCiweHyw+PBikBXdr0n22NkGQC4gP
    zy5BtgUdt06bddl2QlytMrKwTjkg54KkghRKcxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519752666; bh=l7IpwceIUJEpy8J8D6R3zAG1kxhwx1ij7nu6R3WH1tU=; b=g
    rz/p7csU0lfT//dGyEvbpqeVh2iRtDxMFO11DQeMg2GmFtmWrRinJFdlzsfdHead
    L0luIMFiDG8Jfc5n0tQziYufyuKeJCLGtdF4TtLfIibS2CApExSqYCqhdCqvUH7r
    ln3wjV5bqmy3C4ZnL1NLX4Rq/Ftpkqz83OHs2traEtrQY8w7/QVzlW1qG2nYo1zW
    755if2BSP7Xy/UER4F1BpfqfhGxsCY1MmwoR5mTK8gTaFlfiPUfLp+5GFZpgtNCn
    zSWH2FXkGmLdXwZ8jwDuGRehSD5scpnArQdC+5K2l2ruJQg7Jo6/nmEbQ/2BqdE6
    eFvcpjXRk4ryKiPtjp2Fw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=jbbc6kxZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=yahoo.com header.i=@yahoo.com header.b=jbbc6kxZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=s2048;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=schaufler-ca.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=schaufler-ca.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeB0Raq (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 12:30:46 -0500
Received: from sonic302-28.consmr.mail.gq1.yahoo.com ([98.137.68.154]:35760
        "EHLO sonic302-28.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751723AbeB0Rao (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 12:30:44 -0500
X-YMail-OSG: v_Y0UgEVM1noO1onQB5Q77ZzMi5KizWj9ZjTdboF4A.QqMGF7rgKCF9ZYJ9cdR.
 A8dvCBlchQ3DSrRvXPk1PKXYv1k5idSn.EOG4NHJUnyF4IYs8mjwJf39dT1VI4K9o7YmyBBfWmRS
 .ZnmEYr7EWHKGceGbbWUHM6hhrrorN7NiMBsDnXV6fIqK4PWrVnEWl6xXqSWj70aE.nXBaJ4ZiwT
 eTdK4iGBLX0eKaGPFcAhe11V0XCLzdHC3MVMHE2iYCfDFNjTk58DO38je.8zg4ea12xSOjj7qAr1
 DrQVueCSQckEzQdnUcFmfERi16zOzr1c.QWGwzh75nJkoCERg2rdsDxReiPvOAYnT6VAscVpTWA5
 t8iqzKCvDe3yFML3eersIQ8KiRzeah2qKAJQ84FHF9_IwG5fNeuQQH2m33ll8kIGRzk7rvCTqy4i
 LtLuy8pGmcyQfeTwCAbYoSAdsA5WFEc_lOWyFkdzVxNB6vOdnAwnPJp9OUN_FsdsH3S_sKUawUNt
 WJLF9nW4N_pUVRSsGZTfWxklD4jIgvKZ0JmLMYg--
Subject: Re: [PATCH bpf-next v8 05/11] seccomp,landlock: Enforce Landlock
 programs per process hierarchy
To: Andy Lutomirski <luto@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
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
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-6-mic@digikod.net>
 <20180227020856.teq4hobw3zwussu2@ast-mbp>
 <CALCETrVKRYnGJ9XNW-x7eHdMt+eGP90j7cAed-KTzp1KT_kMeQ@mail.gmail.com>
 <20180227045458.wjrbbsxf3po656du@ast-mbp>
 <CALCETrXZ=xJEd53RhA67_VDoAKBWgUeyBi9XN7ibrE7V6nzk5Q@mail.gmail.com>
 <20180227053255.a7ua24kjd6tvei2a@ast-mbp>
 <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
From: Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <b9579dae-625e-cd91-0656-821a8d1f2893@schaufler-ca.com>
Date: Tue, 27 Feb 2018 09:30:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUqc0wbig4ntQe9KNS-fOgYOpD+MPodXYruCRyJ7bhagA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/27/2018 8:39 AM, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 5:32 AM, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>> [ Snip ]
> An earlier version of the patch set used the seccomp filter chain.
> Mickaël, what exactly was wrong with that approach other than that the
> seccomp() syscall was awkward for you to use?  You could add a
> seccomp_add_landlock_rule() syscall if you needed to.
>
> As a side comment, why is this an LSM at all, let alone a non-stacking
> LSM?  It would make a lot more sense to me to make Landlock depend on
> having LSMs configured in but to call the landlock hooks directly from
> the security_xyz() hooks.

Please, no. It is my serious intention to have at least the
infrastructure blob management in within a release or two, and
I think that's all Landlock needs. The security_xyz() hooks are
sufficiently hackish as it is without unnecessarily adding more
special cases.


