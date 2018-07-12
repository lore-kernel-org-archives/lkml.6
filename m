Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173AEB7645
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC5C2124D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="A6J93A4a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5C2124D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeGLSlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 14:41:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44619 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeGLSlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 14:41:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id r1-v6so4149647pgp.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E37e540L8+ObMJcw0Vnf2ZMc+6xdYrH5ye5mgXhzKMs=;
        b=A6J93A4awM9ax6Ic8xWkphJMFyrbFLvbt4UBtxdCQmIHNPB6Wj27q5fWq/+mTHQQAk
         xA6T02+rCpw0oCpeFW6lKVm30CRdsA1MPOKJ2O7nUMc3cC81f5JwK3v8es2FY1XB+zU9
         4nRiUNePpoZoNljg1aXqgLY7JiDTUgd3y0dBSJC9fuGj8mxwDgSVc1sxkf4kcXv2m4ez
         j6DEbvjLsDfsKWVD1OLkmmlKT2uaAfdlXEBzPCD3eGIz17sWvgWEoQAWd2bF4z8M+fwm
         kHMXxolOlJ3q8yjaJ/nJTubeGpIxFjyt89ur2J/ikCeHcpPLl4e01OSIUJ9d+GRovKs2
         E0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=E37e540L8+ObMJcw0Vnf2ZMc+6xdYrH5ye5mgXhzKMs=;
        b=t7o2wFqodx8AEqZyS+joPigvO6M+wEcAnen/shDLB+FoiuFWzLZetmgonusR6K/sZe
         wKc0x5HgIfuONnDZi3RYIgyULNiabtKlGQ3gvzwsKiEwcaIVEcP+V1o7lKA8jXRSPZ4D
         +/zd+W8fbXKpVNrXc8LiYdKZrZVsgcy8S3dgXDxCC3K6viJqMPxshOVTX85CannDQLwF
         RB0g0nCqNbV7XpZoMjVK62yRz4X5Ebg4kO8VUdC0mq8jKLbyacxN50068VUpMsK7gj80
         gNWESTQz0X3z50mO7hUt4K08vb7DH1Gnnmt0JE8vZcq7gAMvomdljAKkgWeFVT3E5yfk
         DNsQ==
X-Gm-Message-State: AOUpUlFqJwPZQXyNTT/WRrUtojTeSePKed4j7O+1o4DJkNRHoGF7Ev4w
        P7Y2BrgOWklz/HG24IWe/k9/xg==
X-Google-Smtp-Source: AAOMgpc8VqC/AHq5RZPQ5fNIY600L0hX+Sl+C2faA2vAb9n6zp7D/a/WwPxm0dQgr1JrElEg0yu87g==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr3571476pfz.103.1531420235789;
        Thu, 12 Jul 2018 11:30:35 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id g16-v6sm52298996pfe.88.2018.07.12.11.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 11:30:34 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180712180304.GA27758@kroah.com>
Date:   Thu, 12 Jul 2018 11:30:32 -0700
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76211EBC-05ED-4FBA-A136-F5EEBFDD9FDF@amacapital.net>
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <20180712171505.GA23780@kroah.com> <20180712172024.GZ30522@ZenIV.linux.org.uk> <20180712180304.GA27758@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 12, 2018, at 11:03 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>=20
>> On Thu, Jul 12, 2018 at 06:20:24PM +0100, Al Viro wrote:
>>> On Thu, Jul 12, 2018 at 07:15:05PM +0200, Greg KH wrote:
>>>> On Tue, Jul 10, 2018 at 11:44:09PM +0100, David Howells wrote:
>>>> Provide an fsopen() system call that starts the process of preparing to=

>>>> create a superblock that will then be mountable, using an fd as a conte=
xt
>>>> handle.  fsopen() is given the name of the filesystem that will be used=
:
>>>>=20
>>>>    int mfd =3D fsopen(const char *fsname, unsigned int flags);
>>>>=20
>>>> where flags can be 0 or FSOPEN_CLOEXEC.
>>>>=20
>>>> For example:
>>>>=20
>>>>    sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
>>>>    write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
>>>>    write(sfd, "o noatime");
>>>>    write(sfd, "o acl");
>>>>    write(sfd, "o user_attr");
>>>>    write(sfd, "o iversion");
>>>>    write(sfd, "o ");
>>>>    write(sfd, "r /my/container"); // root inside the fs
>>>>    write(sfd, "x create"); // create the superblock
>>>=20
>>> Ugh, creating configfs again in a syscall form?  I know people love
>>> file descriptors, but can't you do this with a configfs entry instead if=

>>> you really want to do this type of thing from userspace in this type of
>>> "style"?
>>>=20
>>> Why reinvent the wheel again?
>>=20
>> The damn thing REALLY, REALLY depends upon the fs type.  How would
>> you map it on configfs?
>=20
> /sys/kernel/config/fs/ext4/ would work, right?  Each fs "type" would be
> listed there.
>=20
> Anyway, the whole "write a bunch of options and then do a 'create'" is
> exactly the way configfs works.  Why not use that?
>=20
>=20

How do you mount configfs in the first place?  And how do you use this in a m=
ount namespace without a private configfs instance or where you don=E2=80=99=
t want configfs mounted?=
