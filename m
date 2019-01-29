Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3731C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C5CD2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 23:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="rhqMZ0j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfA2XBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 18:01:40 -0500
Received: from sonic316-20.consmr.mail.bf2.yahoo.com ([74.6.130.194]:38130
        "EHLO sonic316-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729460AbfA2XBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 18:01:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1548802898; bh=p00ezZRbz6B6GWQop1TISHTGkKBUnIWIPR/ZdWffq2I=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=rhqMZ0j41qncth38edn6EOlfU4Sq07IZFnVxtfXE2iRuNSe7cremhWDVWu+9kQi/Zoh4vSr70StR5WGNo0XuPtmjYNJYp1I5XpQYao/J4SxldYuqvDvypK9mrPwMRwigNUwEr/aTcHY4Ra5W0H8k6jdejVaTceLuqKgS0Wd6XC7MZU4NAFfrfkwslv8J2wB6fEYDyi7OpKzCwCI7Y8BaLvo2uWwa0ehoMCvDUzKMNJGEpP/9z6Povka3i2q9r3He6BRjbDtKg17DXH/mzJ1wjKMkZziSbaVDC8EcNZ8S9Ev0Mycq9Kzm186H9SPXWhnYvZflY9nIvdw2OZwH2RcQOg==
X-YMail-OSG: dRkk7YAVM1k8_KMCU.TfB96TvpWOxgWEEzuZKdEa2Hzi0aJr2teEF6Mr0e__.4e
 GdAqrH7mtsGuEmf2igEOXxHeMe7QQgeuAgv5EhvRbAo_zBqrLtlbWgOyGyEgGkWLcqNpU1YVyAx3
 tJ4MqktdvMke.DqhxvRFoOUC1zH8gV_C_damPgWIFyK_jqPBIwOi4sE69sJ8OLcpBNyCyfmZiLQe
 myrDrBzR2q.qmpSxneWzoDswZ2NWAj.JoV0EV2SAAt5h6M6qH9Ac8KXV1IFQwqwaQ9tZN1Njol2i
 CT.lOFE6Eozskt1meNs_4uS1kklMfCSGwJx4FcyKbZYg.ErGjn0_61O9oRRXWwe0zJ5dYeL38i6l
 K6YekeFDODQOPiRc8KNfOs1lZVoxJQPyIflT2iQeKgJwerrv9Bs3Ca_mNqgKbFR01BletMCiNaZf
 gxYnPScP2M7kIQ.q3K1pCvFQrMXH4Ha4f5oJZ5Bfs.p1phRO19Z8NO4d1Vxa336ItBWQX24imNqE
 k6XdVQWcXybfqmh2XKlL31F8e7FB1zjUHyqLwwhKrJUj2KhuDyc9rqtOJo8WvTnrRdp3jxHvlAGH
 QFtSbknVyb_uJjjsqEDVhdngjm8L8aCrS2skGI05DEgvq9KZZKrqKydv1dWkTe8aKPA8v.oZSEtn
 r1.WuBUrMeHj5rEctsoO3Gg8qkJLiAXSZxkb5TM9WHbS2MngNgEZldFFB6_BoOLTt4OlCGUjyT59
 z69c3OYudQcGtJ.6WYHdctxnErqb4JorDxRPa.4MKA9vaMl8WywKAz3zLokPoLvh.yxJj668mUNG
 hc_ZpaUc0R0HgNUgXIC_fFnRJnZiowa7HRX_MYG4RD_D.UwKiUuwBIVzFcbnBRPoqcWojJe2pjAY
 DTSbzwQFpYQgOqzryodeDS3ablkASIdDUOCidGRlazu4FtRJeAPnVp1hLfGqFc4fm.t_tCkjbHTO
 Lyd5g0XooGfajFgOPANgC0SeZqSnlcelhcEYJ2rHcYslMDjl8Ri0Xsy7jl0TssoX45Ulxs.37yNf
 FGdZq1.3wnBWQBCsGet74eSIMur4FJsrFKQIWSYQjo4gvkJQzzU5Z_jfYkGVB18vq3lT.cRBxxzA
 _duqfTLovHNYJHhecbegwMWCfpHtP2L8TNp_vh3bI7zxyHYlSDD7FSzn0VxQpZwuu8dDSGYlIjVm
 JAaT2iChUdB.giqErCA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.bf2.yahoo.com with HTTP; Tue, 29 Jan 2019 23:01:38 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.100]) ([67.169.65.224])
          by smtp426.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 17603ab07badaa647a623d899e339a60;
          Tue, 29 Jan 2019 23:01:35 +0000 (UTC)
Subject: Re: [RFD] A mount api that notices previous mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-api@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        LSM <linux-security-module@vger.kernel.org>
References: <87va2716mh.fsf@xmission.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <03e0993b-21db-1cc4-7a33-0236de7be20d@schaufler-ca.com>
Date:   Tue, 29 Jan 2019 15:01:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87va2716mh.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/2019 1:44 PM, Eric W. Biederman wrote:
> All,
>
> With the existing mount API it is possible to mount a filesystem
> like:
>
> mount -t ext4 /dev/sda1 -o user_xattr /some/path
> mount -t ext4 /dev/sda1 -o nouser_xattr /some/other/path
>
> And have both mount commands succeed and have two mounts of the same
> filesystem.  If the mounter is not attentive or the first mount is added
> earlier it may not be immediately noticed that a mount option that is
> needed for the correct operation or the security of the system is lost.
>
> We have seen this failure mode with both devpts and proc.  So it is not
> theoretical, and it has resulted in CVEs.
>
> In some cases the existing mount API (such as a conflict between ro and
> rw) handles this by returning -EBUSY.  So we may be able to correct this
> in the existing mount API.  But it is always very tricky to to get
> adequate testing for a change like that to avoid regressions, so I am
> proposing we change this in the new mount api.
>
> This has been brought up before and I have been told it is technically
> infeasible to make this work.  To counter that I have sat down and
> implemented it.
>
> The basic idea is:
>  - get a handle to a filesystem
>    (passing enough options to uniquely identify the super block).
>    Also capture enough state in the file handle to let you know if
>    the file system has it's mount options changed between system calls.
>    (essentially this is just the fs code that calls sget)
>
>  - If the super block has not been configured allow setting the file
>    systems options.
>
>  - If the super block has already been configured require reading the
>    file systems mount options before setting/updating the file systems
>    mount options.
>
> To complement that I have functionality that:
>  - Allows reading a file systems current mount options.
>  - Allows reading the mount options that are needed to get a handle to
>    the filesystem.  For most filesystems it is just the block device
>    name.  For nfs is is essentially all mount options.  For btrfs
>    it is the block device name, and the "devices=" mount option for
>    secondary block device names.

Are you taking the LSM specific mount options into account?

>
> Please find below a tree where all of this is implemented and working.
> Not all file systems have been converted but the most of the unconverted
> ones are just a couple minutes work as I have converted all of the file
> system mount helper routines.
>
> Also please find below an example mount program that takes the same set
> of mount options as mount(8) today and mounts filesystems with the
> proposed new mount api.
>  - Without having any filesystem mount knowledge it sucessfully figures
>
> out which system calls different mount options needs to be applied
>    to.
>
> - Without having any filesystem specific knowledge in most cases it
>    can detect if a mount option you specify is already specified to an
>    existing mount or not.  For duplicates it can detect it ignores them.
>    For the other cases it fails the mount as it thinks the mount options
>    are different.
>
>  - Which demonstrates it safe to put the detection and remediation of
>    multiple mount commands resolving to the same filesystem in user
>    space.
>
> I really don't care whose code gets used as long as it works.  I do very
> much care that we don't add a new mount api that has the confusion flaws
> of the existing mount api.
>
> Along the way I have also detected a lot of room for improvement on the
> mount path for filesystems.  Those cleanup patches are in my tree below
> and will be extracting them and sending them along shortly.
>
> Comments?
>
> git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git no-losing-mount-options-proof-of-concept
>
>
>
> Eric
>
