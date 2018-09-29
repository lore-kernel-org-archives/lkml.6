Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0180C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1D206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="HqxBaHsR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F1D206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeI2Xyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:54:35 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46678 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbeI2Xyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:54:35 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so6607651pga.13
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y9lp7/3pak1VDZ2E9w1R36VwEYsxkJD7BrUo4zbmdEU=;
        b=HqxBaHsRhRIHNm9X0bvbdOAuUm2FVHE+Yso/NbJtm6jddlQOG8cpyTNo4YVeC+1L1T
         oRyCOUMDxMXG35o+bQ5pZ+ONTQ7bDh6jqvkORolFkaxWtvuw8ONOZqtHl3BLxNX8tigV
         uD2S/bMGj2AmOS6aYax0bQsUxxkrs8N+kCt0w46AACOG42g4GiKwuPcOLjTE3DULQGaR
         ZiI9M+EnSrgedw/8TqqTcdLQ0YttD68HYBFG1UM2N1a1ICC2ZWY1JbyBmyf/6EL56mM/
         IdmRY/p22b3q8I7iaEiK7kLHD6R9jf4ARCokIxGbW8loxXjn/G6hU+bC5q6tT9i0w1Kl
         KdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=y9lp7/3pak1VDZ2E9w1R36VwEYsxkJD7BrUo4zbmdEU=;
        b=cFq1PJmsUrwRcO/jNNNJmZMEA4dVZRVRouZMxKXt8ZnMTrkM1HJnVwbtSyAWqcEjfg
         B3XFdqQ44/WPyhNniwEkzVduNL+JA5cq84qQKQpAj6VOLvdlzHtwQz0Ko5ljPGL0J5pm
         N74am8Q0Z/DeIKqtGBuUv/Z+x3ht/7Ww1wqPfcxTOZ+Vm35P1bvmc2FxqmCHRWe4QUb2
         hBgCnbO3GUFuJd9nwFl9DZALmljjChDhgJpIdeB9kNt3jPvSqOhPtsVaL215eSDzcLJi
         d+c3EhnNfzYUH5CQ+rYo2xzGIO/Lg4mwJdlMobRb41z/pzwJxFNwF+F7N9JaBa4dFRXu
         8MFw==
X-Gm-Message-State: ABuFfoj2hGqAc8DnyUCdMg9WTasvDYOR6W55GJsn24utgIu8w+eN89nF
        vpaiXtGf4bgjDy/SFlrY19h1sg==
X-Google-Smtp-Source: ACcGV61ua9bShQk3NC57njAphmhJZen5kGNLdHVpwSYNF3R/TNUCpW6q2hVpIf7TIduXvV1vISckDQ==
X-Received: by 2002:a63:4a09:: with SMTP id x9-v6mr3570006pga.34.1538241920885;
        Sat, 29 Sep 2018 10:25:20 -0700 (PDT)
Received: from ?IPv6:2600:1010:b029:4fc8:d7f:8889:342e:40b? ([2600:1010:b029:4fc8:d7f:8889:342e:40b])
        by smtp.gmail.com with ESMTPSA id d81-v6sm14752421pfj.122.2018.09.29.10.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 10:25:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] namei: implement AT_THIS_ROOT chroot-like path resolution
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
Date:   Sat, 29 Sep 2018 10:25:17 -0700
Cc:     cyphar@cyphar.com, "Eric W. Biederman" <ebiederm@xmission.com>,
        jlayton@kernel.org, Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, shuah@kernel.org,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, christian@brauner.io,
        Tycho Andersen <tycho@tycho.ws>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F0E08B90-F10B-4897-913D-CA18E99A987D@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com> <20180929131534.24472-1-cyphar@cyphar.com> <CAG48ez30WJhbsro2HOc_DR7V91M+hNFzBP5ogRMZaxbAORvqzg@mail.gmail.com>
To:     Jann Horn <jannh@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2018, at 9:35 AM, Jann Horn <jannh@google.com> wrote:
>=20
> +cc linux-api; please keep them in CC for future versions of the patch
>=20
>> On Sat, Sep 29, 2018 at 4:29 PM Aleksa Sarai <cyphar@cyphar.com> wrote:
>> The primary motivation for the need for this flag is container runtimes
>> which have to interact with malicious root filesystems in the host
>> namespaces. One of the first requirements for a container runtime to be
>> secure against a malicious rootfs is that they correctly scope symlinks
>> (that is, they should be scoped as though they are chroot(2)ed into the
>> container's rootfs) and ".."-style paths. The already-existing AT_XDEV
>> and AT_NO_PROCLINKS help defend against other potential attacks in a
>> malicious rootfs scenario.
>=20
> So, I really like the concept for patch 1 of this series (but haven't
> read the code yet); but I dislike this patch because of its footgun
> potential.
>=20

The code could do it differently: do the path walk and then, before acceptin=
g the result, walk back up and make sure the result is under the starting po=
int.

This is *not* a full solution, though, since a walk above the root gas side e=
ffects on timing, various caches, and possibly network traffic, so it=E2=80=99=
s open to Spectre-like attacks in which a malicious container could use a ru=
ntime-initiated AT_THIS_ROOT to infer the existence of directories outside t=
he container.

But what=E2=80=99s the container usecase?  Any sane container is based on pi=
vot_root or similar, so the runtime can just do the walk in the container co=
ntext. IOW I=E2=80=99m a bit confused as to the exact intended use of the wh=
ole series. Can you elaborate?=
