Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0CAC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D903320652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 08:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D903320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeJAPXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:23:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51229 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728749AbeJAPXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:23:01 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDQqe-1fzmHi1npG-00AX61; Mon, 01 Oct 2018 10:45:40 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDQqe-1fzmHi1npG-00AX61; Mon, 01 Oct 2018 10:45:40 +0200
Subject: Re: [RFC 0/2] ns: introduce binfmt_misc namespace
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
References: <20180930234628.25528-1-laurent@vivier.eu>
 <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
 <874le63zei.fsf@xmission.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5b4f0798-eb22-2684-775c-c038c104e190@vivier.eu>
Date:   Mon, 1 Oct 2018 10:45:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <874le63zei.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:WYPYAB2f0le+PnioG36Z9Rfaa737vADZX8dc/mx7haHSyddAVby
 MLBltYAkQK4TXcjUXvrs90HlcupqV1nfnmAraSlE0rm3+uJwLTzboqxTPVyMTnFH1jrzsYJ
 kVsIfoZX47jGzvS64G9Xu6LRB3AzJTgbzD1OVMSvArHIkUqfvE8Uda/eZHUn+oX88a8B0d8
 aoEw+aZ7Hw7bIeO7Kzk6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g2sFyIOrZYo=:uTf58aK62WvgiOVrHazHPO
 dfagLoKYfb4Aw6uXHM1AK/sR82u7wuuMk7Hn4t2BIDxEKmuIoRMo1j4WEaZZlGUDH5wxVU9lD
 S/9gOE6WvCgx3bV2WB820BUmFfV3XGyxRxRneKkrcmQGGvM1o9xQL5XcG4uCQBCYylgBaVbOB
 Y0xKyFkKmEtsKRG2krLGclipeKdQn93EL3z+0bIsM402uCy2Hm4kaHu17o+tt1ZGWWY47/3HB
 wREQF5RsgE5zrzN7t5cvHj7zisLSDuk0O1rGMqV9ZPjNwLDLD/3kZy06wBvA7HnT1z/eOweKj
 0W8bRcyIVmLDFlhLHRgMeH0E66kVv1pKVHO+efDgKvXvsO8/nRuJaZZ1AlnNxiMTVPniaVhuK
 iMLQMpoTyTJLKKhORokMsNmODHgWYOnsdmxg+wg1ScR5h7b5pNAYo7KUChlFWcEChBTtnldud
 gEusUGhQkIY3tuc0dGGs7+Tyb9GFzxd31Vbq+wBXXERu93stZGYsQPnFMN6mGRJZ7ODG5f8DR
 d7UBU3XMRV1PlcG1c35mG5jmq2wceK+0JuztvBY5BbTzQ6NT8jDlFxY4SE/hzRp0Kiu/LdvAr
 OeqDPENupKRaaqNbIbSJvmufySK3scqN43LSiVmK+oY13xnVBt/p9zPoQNg+b0w/k95qyAogX
 Y8yaagaJrj1c1tLrMSyoJ1BkzqY4IjXGqGOa1pIsSVSlqHqX+vt0vChcQrP8MFWIy7p2+SvgU
 36Eg9Ca7FDGXXGLn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/10/2018 à 09:21, Eric W. Biederman a écrit :
> Andy Lutomirski <luto@kernel.org> writes:
> 
>> On Sun, Sep 30, 2018 at 4:47 PM Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> This series introduces a new namespace for binfmt_misc.
>>>
>>
>> This seems conceptually quite reasonable, but I'm wondering if the
>> number of namespace types is getting out of hand given the current
>> API.  Should we be considering whether we need a new set of namespace
>> creation APIs that scale better to larger numbers of namespace types?
> 
> I would rather encourage a way to make this part of an existing
> namespace or find a way to make a mount of binfmt_misc control this.
> 
> Hmm.  This looks like something that can be very straight forwardly be
> made part of the user namespace.  If you ever mount binfmt_misc in the
> user namespace you get the new behavior.  Otherwise you get the existing
> behavior.

Thank you. I'll do that.

> A user namespace will definitely be required, as otherwise you run the
> risk of confusing root (and suid root exectuables0 by being able to
> change the behavior of executables.
> 
> What is the motivation for this?  My impression is that very few people
> tweak binfmt_misc.

I think more and more people are using an interpreter like qemu
linux-usermode to have a cross-compilation environment: they bootstrap a
distro filesystems (with something like debootstrap), and then use
binfmt_misc to run the compiler inside this environment (see for
instance [1] [2] [3] or [4] [5]). This is interesting because you have
more than a cross-compiler with that: you have also all the libraries of
the target system, you can select exactly which target release you want
to build to, with the exact same compiler and libraries versions (and
you can re-use it you want to do maintenance on your project 10 years
later...)

The problem with this is you need to be root:
1- to chroot
2- to configure binfmt_misc

We already can use "unshare --map-root-user chroot" to address the point
1, and this series tries to address the point 2.

I think it's also interesting to have a per container configuration for
binfmt_misc when the server administrator configures it and don't want
to share each user configuration with all the other user ones (in
something like docker or a cloud application).

> I also don't think this raises to the level where it makes sense to
> create a new namespace for this.

OK.

Thanks,
Laurent

[1] https://wiki.debian.org/Arm64Qemu
[2] https://wiki.debian.org/M68k/sbuildQEMU
[3] https://wiki.debian.org/RISC-V#Manual_qemu-user_installation
[4] https://kbeckmann.github.io/2017/05/26/QEMU-instead-of-cross-compiling/
[5] https://wiki.gentoo.org/wiki/Crossdev_qemu-static-user-chroot
