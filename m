Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2553435-1520799417-2-5620112748233821172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='iso-8859-15'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520799416; b=wR5yJT9RUQC8qdzKSiR4ktKOEh9W2RTAFEZt9a3+Tr705lO
    WlEXYgkDuUnaGnCBPN20YqIvmLjDJ/XjxAcGiOS3o2Bg5C+ybhVHmssvNe3kmPXf
    Z6ZWV2lUyVjd4OotQ/50vWtRLtunXYu9K6tpQPXNcYA25lageOx91wTqUDQpZGYW
    4oNBZzVMZv7F9iGOPS1RRwrwOeg/i8pW9xQm0wL8DgC/ynZHiYmtkYJPfXj4KBUA
    1eGn1YT7V/f5JZMwBAU9t0jYRktOpGHogHoIJxTjNX1FR85i1wlwked7wvLcU1hk
    tGVGlHM0jJsuoiakvmqawhxVTCz8XYFrSus+xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520799416; bh=Yiu7rYOaWZitCy3W5wiSA870XakBSGq6mhZok3
    sz+gE=; b=OmWtmZgOW3fqf3BeCCBRDW04ggSpt/PHQ+4eN+1J28Brl53KOwi4cg
    0pezPv8OEatVLPuGHeQh3P13UQNPyKvQlDCmAE9PJ8CRK95zbRVNzqGCmXnF5aVB
    aDW0rCTNTdZpv7sQ1ReHjvHrjiuEfj7oKsBCTYdt8X4O/RWBl8nPBLg4mJPmPUqO
    U+xrezFV67+Jl6oyBpDRs0rHphfNYj3xvXUGnDvk4TbclAc3YdUVpyp9Bhja46fa
    DjANCmlMEu2Eht+UGKke1DgHvnj3UlZQ/zAWTp7WJgsbbbz33AKnGyBCgg4wYgEG
    LmXPM9IeZn89o5/6XiaczsfVA00iTZfw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932258AbeCKUQz (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 16:16:55 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:56970 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932144AbeCKUQx (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 11 Mar 2018 16:16:53 -0400
Subject: Re: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
 nameidata
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        John Johansen <john.johansen@canonical.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        linux-fsdevel@vger.kernel.org
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-2-mic@digikod.net>
 <20180227005721.GK30522@ZenIV.linux.org.uk>
 <20180227012329.GL30522@ZenIV.linux.org.uk>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <53e1f50d-6719-aa6c-a0a7-485cf1fd0d2d@digikod.net>
Date: Sun, 11 Mar 2018 21:14:08 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <20180227012329.GL30522@ZenIV.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="cdt5OfIhwr4oaLzUGCrbv9AUTGvyZ36E3"
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cdt5OfIhwr4oaLzUGCrbv9AUTGvyZ36E3
Content-Type: multipart/mixed; boundary="fU5D1iIsVDFbnRIZV7fin7fKso3RelxuQ";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Drysdale
 <drysdale@google.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Sargun Dhillon <sargun@sargun.me>, "Serge E . Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
 Will Drewry <wad@chromium.org>, kernel-hardening@lists.openwall.com,
 linux-api@vger.kernel.org, linux-security-module@vger.kernel.org,
 netdev@vger.kernel.org, James Morris <jmorris@namei.org>,
 John Johansen <john.johansen@canonical.com>,
 Stephen Smalley <sds@tycho.nsa.gov>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 linux-fsdevel@vger.kernel.org
Message-ID: <53e1f50d-6719-aa6c-a0a7-485cf1fd0d2d@digikod.net>
Subject: Re: [PATCH bpf-next v8 01/11] fs,security: Add a security blob to
 nameidata
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-2-mic@digikod.net>
 <20180227005721.GK30522@ZenIV.linux.org.uk>
 <20180227012329.GL30522@ZenIV.linux.org.uk>
In-Reply-To: <20180227012329.GL30522@ZenIV.linux.org.uk>

--fU5D1iIsVDFbnRIZV7fin7fKso3RelxuQ
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 02/27/2018 02:23 AM, Al Viro wrote:
> On Tue, Feb 27, 2018 at 12:57:21AM +0000, Al Viro wrote:
>> On Tue, Feb 27, 2018 at 01:41:11AM +0100, Micka=EBl Sala=FCn wrote:
>>> The function current_nameidata_security(struct inode *) can be used t=
o
>>> retrieve a blob's pointer address tied to the inode being walk throug=
h.
>>> This enable to follow a path lookup and know where an inode access co=
me
>>> from. This is needed for the Landlock LSM to be able to restrict acce=
ss
>>> to file path.
>>>
>>> The LSM hook nameidata_free_security(struct inode *) is called before=

>>> freeing the associated nameidata.
>>
>> NAK.  Not without well-defined semantics and "some Linux S&M uses that=
 for
>> something, don't ask what" does not count.
>=20
> Incidentally, pathwalk mechanics is subject to change at zero notice, s=
o
> if you want something, you'd better
> 	* have explicitly defined semantics
> 	* explain what it is - on fsdevel
> 	* not have it hidden behind the layers of opaque LSM dreck, pardon
> the redundance.
>=20
> Again, pathwalk internals have changed in the past and may bloody well
> change again in the future.  There's a damn good reason why struct name=
idata
> is _not_ visible outside of fs/namei.c, and quietly relying upon any
> implementation details is no-go.
>=20

I thought this whole patch series would go to linux-fsdevel but only
this patch did. I'll CCed fsdevel for the next round. Meanwhile, the
cover letter is here: https://lkml.org/lkml/2018/2/26/1214
The code using current_nameidata_lookup(inode) is in the patch 07/11:
https://lkml.org/lkml/2018/2/26/1206

To sum up, I don't know any way to identify if a directory (execute)
access was directly requested by a process or inferred by the kernel
because of a path walk. This was not needed until now because the other
access control systems (either the DAC or access controls enforced by
inode-based LSM, i.e. SELinux and Smack) do not care about the file
hierarchy. Path-based access controls (i.e. AppArmor and Tomoyo)
directly use the notion of path to define a security policy (in the
kernel, not only in the user space configuration). Landlock can't rely
on xattrs (because of composed and unprivileged access control). Because
we can't know for sure from which path an inode come from (if any),
path-based LSM hooks do not help for some file system checks (e.g.
inode_permission). With Landlock, I try to find a way to identify a set
of inodes, from the user space point of view, which is most of the time
related to file hierarchies.

I needed a way to "follow" a path walk, with the minimum amount of code,
and if possible without touching the fs/namei.c . I saw that the
pathwalk mechanism has evolved over time. With this patch, I tried to
make a kernel object (nameidata) usable in some way by LSM, but only
through an inode (current_nameidata_lookup(inode)). The "only" guarantee
of this function should be to identify if an inode is tied to a path
walk. This enable to follow a path walk and know why an inode access is
requested.

I get your concern about the "instability" of the path walk mechanism.
However, I though that a path resolution should not change from the user
space point of view, like other Linux ABI. Anyway, all the current
inode-based access controls, including DAC, rely on this path walks
mechanism. This patch does not expose anything to user space, but only
through the API of Landlock, which is currently relying on path walk
resolutions, already visible to user space. Did I miss something? Do you
have another suggestion to tie an inode to a path walk?

Thanks,
 Micka=EBl


--fU5D1iIsVDFbnRIZV7fin7fKso3RelxuQ--

--cdt5OfIhwr4oaLzUGCrbv9AUTGvyZ36E3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlqljhgACgkQIt7+33O9
apUEVwgAoNkjdPJXibIfn0WlEL+JT2QbHNoII6AAZyRUKgBTBgmHs0OGeBR0aa5U
bA8cIvDL558Y2crA9gzum00XepwC4JNIhMq3dmSOYZtcNfkN2OIhJGUqSSFWPsRe
q76GTF4esFx9ic9mE8K+V4MmvvVSUQzD/eZWeVtb5V/2t5opQ7zPlzPjPtOYG1Kh
vF2mfOetMES0iFdNT7aM9FCME/PqFGatL2Fh/Zbx/i+AIrA1QoYrzUsAl9BbdBIT
vKprrbgAn0l0cHSLAUWA85G8EpYoT5+fejiwL+bxAhUzgTZWZCTq9rlnDFBfea8J
vFr06ZvGzyeD2wmRlKQRLrRIerFUmA==
=/ydU
-----END PGP SIGNATURE-----

--cdt5OfIhwr4oaLzUGCrbv9AUTGvyZ36E3--
