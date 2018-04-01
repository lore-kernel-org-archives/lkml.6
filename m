Return-Path: <kernel-hardening-return-12842-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+zpTP1/m+wvX6Ym+DqUDCKmeOjWS6ra+lPBr9ZlsdyOxfvmboB8FJ6IsaD3SDnZFMpkUP1
ARC-Seal: i=1; a=rsa-sha256; t=1522623002; cv=none;
        d=google.com; s=arc-20160816;
        b=f+6Of1PQ8naGch7LveSdzO72dS+dZF/qd+Nnlf5kL2Wivz05VY5tLMT0ftM7sYC7q1
         2dmCrB4yURjZA4Rix66WZW+jdIhQBBDycNUOy9jXXJ4M6JHzagkZnRp8WD+1bpjYScOJ
         h/spVeBEyPO4Nd1BWPL6+d38LBImu7QvRxJX+sTUcA47OtIo8JKoWsiDZ1ZxTK6PWXFi
         fQ3MwHaLjGq/mV8lRap/9bfOv97ACwrkhzJpyABhr1czEP8j8m1pmnJFRo5PXZLBnVGp
         h6ruEI43FZjAP9ONaSR5r7+styY+ts5X6PsKARC+wR6lRP7ehNdGRYuKEFK0K2e1hAYk
         sCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:autocrypt
         :openpgp:from:references:cc:to:subject:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=IaklgzID3i+adL48jYqDM1m4mTsr6TJfnz+t8CIhcOs=;
        b=qOAEJkqQpj6A0c+6rBbK24432/b9DQqCUegmbvwVf7RV3gM+ggKeleupS8iI9cxi1c
         nKNzr66oSfrsRkqkjOv8/hhQB+ucaAH4i6M8oLM9vipxgzSVQPARsG+zK8ZJzOTvsD6O
         x5Naoqp5oupIYlfjbGnf+90Rds8j6X0QQnKPRE6Wq1Q14X5/7RJTsCnhmqpzlBvkINM0
         IPDkQ3ViyugPMvuYyxFtDa7wRCFIppNypOIUS3F4uOnvb6nB63MfO12vSMti+QS7FxmO
         eWZ2lU6l56VJUhUwag1FFZAcMlVm/PKFyxDXjZaEL0Z5KTmIWJlKiWXP8Eg0RDli17nI
         klUQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12842-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12842-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12842-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12842-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale
 <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tycho Andersen <tycho@tycho.ws>, Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
 <D6B96EE0-8932-4845-BFA5-4C65E5189AFB@amacapital.net>
 <0e7d0512-12a3-568d-aa55-3def4b91c6d0@digikod.net>
 <CALCETrUTiUeV71jgYWup0CZwG8eQ3=W7X5FgJqmgPxnYbFsccw@mail.gmail.com>
 <CALCETrV_BVc44YYq6g8PCpeUYuqQaooVoQSQ7Y=VpuaBshQgQg@mail.gmail.com>
 <f560a30d-10fd-31fc-adba-911961915937@digikod.net>
 <CALCETrW5v1sa17jPJuTskW5vdvcXqjFtRvAd0auWBmKvnAX-zQ@mail.gmail.com>
 <679089bb-c0ac-ff68-71b1-1813d66c6aa7@digikod.net>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; keydata=
 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
 RjVFnCHFbtPhnyvGdQQ=
Message-ID: <63c56227-7394-92d5-d663-59dbe0efe20f@digikod.net>
Date: Mon, 2 Apr 2018 00:48:55 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <679089bb-c0ac-ff68-71b1-1813d66c6aa7@digikod.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Hm7bzBjMedEZq5T95smQuMfPMscRewwT9"
X-Antivirus-Code: 0x100000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512859761492731?=
X-GMAIL-MSGID: =?utf-8?q?1596585937419713715?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hm7bzBjMedEZq5T95smQuMfPMscRewwT9
Content-Type: multipart/mixed; boundary="FOcscaVWkHHqGJfqTL970AuU7bacqfRtS";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Drysdale
 <drysdale@google.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 James Morris <jmorris@namei.org>, Jann Horn <jann@thejh.net>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Sargun Dhillon <sargun@sargun.me>, "Serge E . Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
 Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Message-ID: <63c56227-7394-92d5-d663-59dbe0efe20f@digikod.net>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
 <D6B96EE0-8932-4845-BFA5-4C65E5189AFB@amacapital.net>
 <0e7d0512-12a3-568d-aa55-3def4b91c6d0@digikod.net>
 <CALCETrUTiUeV71jgYWup0CZwG8eQ3=W7X5FgJqmgPxnYbFsccw@mail.gmail.com>
 <CALCETrV_BVc44YYq6g8PCpeUYuqQaooVoQSQ7Y=VpuaBshQgQg@mail.gmail.com>
 <f560a30d-10fd-31fc-adba-911961915937@digikod.net>
 <CALCETrW5v1sa17jPJuTskW5vdvcXqjFtRvAd0auWBmKvnAX-zQ@mail.gmail.com>
 <679089bb-c0ac-ff68-71b1-1813d66c6aa7@digikod.net>
In-Reply-To: <679089bb-c0ac-ff68-71b1-1813d66c6aa7@digikod.net>

--FOcscaVWkHHqGJfqTL970AuU7bacqfRtS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 03/06/2018 11:28 PM, Micka=C3=ABl Sala=C3=BCn wrote:
>=20
> On 28/02/2018 01:09, Andy Lutomirski wrote:
>> On Wed, Feb 28, 2018 at 12:00 AM, Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>>>
>>> On 28/02/2018 00:23, Andy Lutomirski wrote:
>>>> On Tue, Feb 27, 2018 at 11:02 PM, Andy Lutomirski <luto@kernel.org> =
wrote:
>>>>> On Tue, Feb 27, 2018 at 10:14 PM, Micka=C3=ABl Sala=C3=BCn <mic@dig=
ikod.net> wrote:
>>>>>>
>>>>>
>>>>> I think you're wrong here.  Any sane container trying to use Landlo=
ck
>>>>> like this would also create a PID namespace.  Problem solved.  I st=
ill
>>>>> think you should drop this patch.
>>>
>>> Containers is one use case, another is build-in sandboxing (e.g. for =
web
>>> browser=E2=80=A6) and another one is for sandbox managers (e.g. Firej=
ail,
>>> Bubblewrap, Flatpack=E2=80=A6). In some of these use cases, especiall=
y from a
>>> developer point of view, you may want/need to debug your applications=

>>> (without requiring to be root). For nested Landlock access-controls
>>> (e.g. container + user session + web browser), it may not be allowed =
to
>>> create a PID namespace, but you still want to have a meaningful
>>> access-control.
>>>
>>
>> The consideration should be exactly the same as for normal seccomp.
>> If I'm in a container (using PID namespaces + seccomp) and a run a web=

>> browser, I can debug the browser.
>>
>> If there's a real use case for adding this type of automatic ptrace
>> protection, then by all means, let's add it as a general seccomp
>> feature.
>>
>=20
> Right, it makes sense to add this feature to seccomp filters as well.
> What do you think Kees?
>=20

As a second though, it may be useful for seccomp but it should be
another patch series, independent from this one.

The idea to keep in mind is that this ptrace restriction is an automatic
way to define what is called a subject in common access control
vocabulary, like used by SELinux. A subject should not be able to
impersonate another one with less restrictions (to get more rights).
Because of the stackable restrictions of Landlock (same principle used
by seccomp), it is easy to identify which subject (i.e. group of
processes) is more restricted (or with different restrictions) than
another. This follow the same principle as Yama's ptrace_scope.

Another important argument for a different ptrace-protection
mechanism than seccomp is that Landlock programs may be applied (i.e.
define subject) otherwise than with a process hierarchy. Another way to
define a Landlock subject may be by using cgroups (which was previously
discussed). I'm also thinking about being able to create (real)
capabilities (not to be confused with POSIX capabilities), which may be
useful to implement some parts of Capsicum, by attaching Landlock
programs to a file descriptor (and not directly to a group of
processes). All this to highlight that the ptrace protection is specific
to Landlock and may not be directly shared with seccomp.

Even if Landlock follows the footprints of seccomp, they are different
beasts.


--FOcscaVWkHHqGJfqTL970AuU7bacqfRtS--

--Hm7bzBjMedEZq5T95smQuMfPMscRewwT9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlrBYdgACgkQIt7+33O9
apVKrQf+K+rJsgAAjeWuJAd0c5iCLG/3/eyy8Ioxr7BXFBsj4/I3+GZNohC+r7Q/
cIQGPOhEXh1LoB/FLTpUwkbic8LudVKm6qB+2e3OCta1WEZKxWO/QaI9Hf0g6Flk
/v7WBBghhZt/RkIMkHl0QNzx41ZJbBRrwP3yMsxhcgToyEZDBywcJq83hKyczDO7
fJxMVugDgh7rdMwhdGdJj9RQrKOl5DKlWQXvAr1d8D1g4RkwT9nQLYfbc2JXNaC/
miJ0Eo2F8le8UtTmf89fkO0tEMFmA45s4+CRkDz6Qd8zRjpW2vWi8LKdNwMmPIM0
ne5ynEnMA8YlvNwz8pSxXHBO71G0ag==
=p4QM
-----END PGP SIGNATURE-----

--Hm7bzBjMedEZq5T95smQuMfPMscRewwT9--
