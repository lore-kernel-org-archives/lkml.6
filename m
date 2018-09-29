Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43770C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E707A20882
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="dp2HqnQN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E707A20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbeI2XDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:03:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38422 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbeI2XDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:03:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id r77-v6so6594789pgr.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KvTQtdedXDeU8JGJReEkH+sFmgNPFAPXy0iwMsr+Kg8=;
        b=dp2HqnQNBLql1PVLsSR4DDXGqS/XUljVtl9wYPjuDxzzBQGZ3FzMeMuYXw9Oaxh8G+
         MlGQU+y0/+U7rLcUHtNk8aq1+v1jTAHCZyX/nF8GjBPQSGg/Z18P+DzXqqgW+0uOTP4Y
         r+KSllKVzWu2/NcpGA+l2gWrun8wALOytkYFdoszKZO45fCm07RDaNw4efjpgdBtXBCB
         9dHmLuZsgjoz+DTRSIb6jaDN9wISj902rkQbR+zUn3RjWijHVq0VerHU+Vp+CzT2xhkU
         0aVccfqMi4u90oCz9ikZOhAaDMiaJ7R3uR+XMzuKCIy7stX6dzT5BcJxEA5o2LIVMGDS
         gwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KvTQtdedXDeU8JGJReEkH+sFmgNPFAPXy0iwMsr+Kg8=;
        b=nBL725Er+Vb4usjqq0mUSoVmHTQSpAD2djNlmjfuzf/QLrrmCnpKkjuZHnZS5O7dBX
         Rtfup+WzsEkEHvcwryHiNSKK3Vq2tS9+TXrQuUZUI3AxxW/oVHDMlBwtcYUhFb5AJyCz
         tfPdj5gKkB25Mt9SZcTkIgQxgjNRYo/l8Nyfo9s3xgtIfnymf0UopMfOgtzTKgZUswy9
         UIOuO/tj4qN0L5HEHxeE8PvndOj37+MpIe2gGNxHZpMxiSOwomsCfDb+WmVt17lu2G5N
         7I+Acp0hnFQrSz1MJSYt/+KYXVEBPLYEh317lT4qzK92o9PrZ83fIpSWbqm25aAzunER
         GqOw==
X-Gm-Message-State: ABuFfojNO+9M9NvzaE1x5OyDfarSvxPchNkkGNIt+MFdtQ9ZoK2gOEO5
        ou45DkGco/dvL9y4mYYQ3YlKIg==
X-Google-Smtp-Source: ACcGV63vRXO6MPOax3QRgSEnYwFsYowTtHQj0YN0eSXw45X34l4WKWVCFatNAOliCpaSr1i6nmmopg==
X-Received: by 2002:a62:2056:: with SMTP id g83-v6mr3774816pfg.165.1538238867851;
        Sat, 29 Sep 2018 09:34:27 -0700 (PDT)
Received: from ?IPv6:2600:1010:b029:4fc8:d7f:8889:342e:40b? ([2600:1010:b029:4fc8:d7f:8889:342e:40b])
        by smtp.gmail.com with ESMTPSA id x4-v6sm11082814pfm.119.2018.09.29.09.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 09:34:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
Date:   Sat, 29 Sep 2018 09:34:24 -0700
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9D01A225-05BE-4B4A-873A-94168D17F687@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com> <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net> <20180929154551.jsi6dt3xjxdxoqeh@ryuk>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2018, at 8:45 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> On 2018-09-29, Andy Lutomirski <luto@amacapital.net> wrote:
>>> The most obvious change is that AT_NO_JUMPS has been split as dicussed
>>> in the original thread, along with a further split of AT_NO_PROCLINKS
>>> which means that each individual property of AT_NO_JUMPS is now a
>>> separate flag:
>>>=20
>>> * Path-based escapes from the starting-point using "/" or ".." are
>>>   blocked by AT_BENEATH.
>>=20
>> Seems useful.
>>=20
>>> * Mountpoint crossings are blocked by AT_XDEV.
>>=20
>> Seems useful.
>>=20
>>> * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
>>>   correctly it actually blocks any user of nd_jump_link() because it
>>>   allows out-of-VFS path resolution manipulation).
>>>=20
>>=20
>> So how do I disable following symlinks? ISTM the most natural way
>> would be to have AT_NO_SYMLINKS, and to have that flag disable proc
>> links.
>=20
> So, this patchset has both AT_NO_SYMLINKS and AT_NO_PROCLINKS.

And AT_THIS_ROOT, which is neat. Want to update your cover letter to include=
 all of this?  Or at I just reading the wrong thing?

>=20
> * AT_NO_SYMLINKS blocks *all* symlinks (which is something Linus requested=

>  in the original thread[2] -- apparently this is something that would
>  be useful to git even if wouldn't violate AT_BENEATH). This implies
>  AT_NO_PROCLINKS.
>=20
> * AT_NO_PROCLINKS only blocks procfs-style "symlinks" (filesystem
>  "symlinks" that call nd_jump_link() themselves -- currently only
>  procfs and nsfs).
>=20

Hmm. I=E2=80=99m not sure that blocking nsfs links is always what the contai=
ner runtime wants, but the overall concept sounds quite useful.  Maybe call i=
t AT_NO_TELEPORT?  Or AT_NO_MAGIC_LINKS?

Also, as a perhaps-silly suggestion: if you end up adding a new syscall, I c=
an see a use for a mode that does the path walk but, rather than failing on a=
 disallowed link, stops early and indicates where it stopped. Then web serve=
rs, samba, etc can more efficiently implement custom behavior when links are=
 encountered.  And it may also be useful to have a variant of AT_THIS_ROOT w=
here trying to escape is an error instead of having it just get stuck at the=
 root.=
