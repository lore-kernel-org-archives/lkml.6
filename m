Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C0FC64EB5
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B03D2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 16:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B03D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbeJBXcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 19:32:07 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:34163 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbeJBXcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 19:32:04 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXxi-1gK7YF2kyY-00MaE3; Tue, 02 Oct 2018 18:47:17 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MPXxi-1gK7YF2kyY-00MaE3; Tue, 02 Oct 2018 18:47:17 +0200
Subject: Re: [RFC v2 v2 0/1] ns: introduce binfmt_misc namespace
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20181002102054.13245-1-laurent@vivier.eu>
 <1538496810.14607.5.camel@HansenPartnership.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <a9997ce3-d63d-44b4-6a2a-09fd207a1550@vivier.eu>
Date:   Tue, 2 Oct 2018 18:47:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1538496810.14607.5.camel@HansenPartnership.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vyIQSkDYG89Djpn5nynY9BvNOqS8BNuuL/pGxPXGSkVFDflaG8c
 1R9IBVLusxFa+Nc17VVdRJ9Zo3fiox6mGpgUE+L0xiJ/d83flBSh4xyYieVZEoDvFOubBsr
 9b/FfOKi5hts1UoqOqZ3qM5sircKkOJlJ/govs83K2BLayXUYi185QV8TpvbTjjgb8HegM4
 C11t+rsX3WLo+otMyfxJA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:F2YMhq6s3sM=:26Yuk9KikPq/Ftl3RYnApA
 YqGnwJ2jU9w81xK7Juu6X/azpKTwFSLX8hzXahMySoxXEUUazFLA1VbI4UE66vHzfEFYwaA6x
 u1lJjXRPrqb7eIDUwxxtQfbOj8AHz9ZDZQhIH6TLM0goHUlqcE8G+zxwe2O9iuAgn6y4Vq9z9
 nx1fhvZuXsoqU84F6Ndpy/bMmWHGbXJ2LSnANrYIALJDIVdlX8za9Oz5N59Fp//DA+05ed7WP
 eMyFfW8UQaq9E25PNAgrrsknFJBUPEWBjHbzhpZCBCNQ4Q3C1gAulHPBZuAzvhJY3tJuGcdlp
 alE2Ahy2y+ofBOLihWOa6vnbNbOX5HzbDEVOllzU/Z5ZGpnVSPxTrlGRKleH4lk2ITAfRl5TW
 jGkXtvUnlzw2yOt/PvA0mWmgZ4D9y/cvWOBmcwODkeJGvFE0VV/LgfjX3dy8MJWaQtny1DJl5
 7FgGiA92VVQnqMHZWZLVM/e5LP0sLxSklqSyAaKsjpUeZF7YQDcK3ofCuV6pjpaNHdRJ1JECq
 7OUv885pVDsFCJ8JuBb++BTS0VVNbKyoA7GeAwdgk62T8tbzHzPOMs/2hbx3e2rvZK5JNSHJ1
 IycB19dxZ1BRnoPb7pFTpPpFrpKxEFg4V9Fctlhv7b3O4yTfcXZrJkNCfg4j2rFvNOfZ2ffmI
 rrNnnS/X5vqTEOBbqpOzqmFWBA4VYMwuSBpUyLKx1TtwifrVluYCk34SKTydM3RPQbk3fnL3a
 WsN0IsS6PxNK3eFm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 02/10/2018 à 18:13, James Bottomley a écrit :
> On Tue, 2018-10-02 at 12:20 +0200, Laurent Vivier wrote:
>> v2: no new namespace, binfmt_misc data are now part of
>>     the mount namespace
>>     I put this in mount namespace instead of user namespace
>>     because the mount namespace is already needed and
>>     I don't want to force to have the user namespace for that.
>>     As this is a filesystem, it seems logic to have it here.
>>
>> This allows to define a new interpreter for each new container.
>>
>> But the main goal is to be able to chroot to a directory
>> using a binfmt_misc interpreter without being root.
> 
> Reading all this, I don't quite understand why this works for me and
> not for you (I think I get from your explanation that it doesn't work
> for you, but I might have missed something):
> 
> jejb@jarvis:~> uname -m
> x86_64
> jejb@jarvis:~> unshare -r -m
> root@jarvis:~# chroot /home/jejb/containers/aarch64
> jarvis:/ # uname -m
> aarch64
> 
> Of course to get that to work I have an 'F' entry in
> /etc/binfmt.d/qemu-aarch64.conf
> 

I'd like to configure the interpreter without being root.

As a simple user can run a VM and a full system inside, I'd like to be
able to start a container/chroot without having to configure something
at the host level.

For instance, I'd like to provide to "someone" (with no admin rights) a
tar file with inside an OS environment for a given target and the
interpreter, and allow him to run the binaries inside just by running a
simple command (like qemu-system-XXX -hda my.img)

It's also interesting for a test purpose: I can test concurrently
different interpreters for the same target without modifying the target
root filesystem (with the 'F' flag but on a per directory basis) or the
host configuration.

Another case is we can't configure qemu-mips/qemu-mipsel (old kernel
API) and qemu-mipsn32/qemu-mipsne32el (new kernel API) interpreters on
the same system because they share the same ELF signature (to be honest
qemu should have only one binary for the old and the new interface and
dynamically change it according to the ELF binary that is loaded, as it
is done for ARM).

But if no one thinks it's useful, I don't want to push this more than
that...

Thanks,
Laurent
