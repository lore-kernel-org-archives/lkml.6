Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0851CC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAFFF205F4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:52:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAFFF205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbeJPRmc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:42:32 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:48873 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727059AbeJPRmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:42:32 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhDEo-1fhx9J1AlG-00eO84; Tue, 16 Oct 2018 11:52:23 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MhDEo-1fhx9J1AlG-00eO84; Tue, 16 Oct 2018 11:52:23 +0200
Subject: Re: [PATCH v6 0/1] ns: introduce binfmt_misc namespace
To:     linux-kernel@vger.kernel.org
Cc:     Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrei Vagin <avagin@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
From:   Laurent Vivier <laurent@vivier.eu>
Message-ID: <7ed6f823-547b-922d-59ff-aba9c4c3ab39@vivier.eu>
Date:   Tue, 16 Oct 2018 11:52:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181010161430.11633-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+eFgubRT7KIKX++W5kFvD94HfaFRPsKwx9rCJ99DgYOj0Sy4LGo
 8+nx9NaFulPx8ESLDIdCJBieDBHn0LFafaM48utq8njGefE3df7oLBDBCfxn09sxiZDgXMP
 +lCCYhD8ybgVvCVqaopqnjcxvvp8r8tRf2zN8Kv55QV4vYs7T/Zkn4Zlx5cDn6uaw2vsHCM
 drODH/i45PQnhg33WYokQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GzE1xPFtNdM=:lfZdZAh7tkaDGIEhnNjjmQ
 U1Tw9OxNdh0ilfmOnVNx4MTgZo+AYlPcRpUtuMuZd0nQf6VxzccNcL3oeXh62wkMDEQY2Gsc0
 Fyks+8OGBDW2DpP8s+eBWrPXyW50g67N//Ke+tHxgmPRhk0+zjum+D7DYzHjdQKXcmFMhjV6D
 SfgI8ralYuenDCF/eMxA3PhV70h1DH+bu0xJmaUZwhns9lWYh0gXQws8eZN7FrOUfCEr+7ast
 OWUf/KzOsjeLML8R3MRaSVESdJGU2d653AP1jEm6j+eFNPJcOva6JBS/p9xqs4XQzVWlhJLTq
 fXcIj/nSKdtSLyCxfR14TB5K/y2+vUVJJedNy9L9r5ssmPHt70tOd2TratqAphJEk4CUYc4lb
 JNB2znKEMWkdek9aXmE5LZrXh7aQqvNKfBtl//oQoKU8rpP1Zml3VjJ3s70+u84MdtUiY+W+n
 6yFdxqATa7gE7JiPT86j2wdCYZAl+UYzG4gIFiZ7zWNIxTdyyZ4OFWnbtLzDADwO5posOrE3f
 EE2e6iIp1ACkVNdMVooOhNWk0t4vDChShN2dDdTjdZbBp/eKGhjTl0mi66LZ824DovaKV/azS
 xeFPipiSVoksEi6kzNZq8a3yEH7BA63pepOgvwwQQ3o2LmrbQMYgeAfI/oXjye7OytopkNWk5
 EyOQ1vjeCxf/5+UrkuP2NG2SFBZLSN0O/9E/ONWBlG9fBvJmKVwShscU4M0LRTFr51S+VAjtX
 a6Fpn0OCgK8CELPo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comment on this last version?

Any chance to be merged?

Thanks,
Laurent

Le 10/10/2018 à 18:14, Laurent Vivier a écrit :
> v6: Return &init_binfmt_ns instead of NULL in binfmt_ns()
>     This should never happen, but to stay safe return a
>     value we can use.
>     change subject from "RFC" to "PATCH"
> 
> v5: Use READ_ONCE()/WRITE_ONCE()
>     move mount pointer struct init to bm_fill_super() and add smp_wmb()
>     remove useless NULL value init
>     add WARN_ON_ONCE()
> 
> v4: first user namespace is initialized with &init_binfmt_ns,
>     all new user namespaces are initialized with a NULL and use
>     the one of the first parent that is not NULL. The pointer
>     is initialized to a valid value the first time the binfmt_misc
>     fs is mounted in the current user namespace.
>     This allows to not change the way it was working before:
>     new ns inherits values from its parent, and if parent value is modified
>     (or parent creates its own binfmt entry by mounting the fs) child
>     inherits it (unless it has itself mounted the fs).
> 
> v3: create a structure to store binfmt_misc data,
>     add a pointer to this structure in the user_namespace structure,
>     in init_user_ns structure this pointer points to an init_binfmt_ns
>     structure. And all new user namespaces point to this init structure.
>     A new binfmt namespace structure is allocated if the binfmt_misc
>     filesystem is mounted in a user namespace that is not the initial
>     one but its binfmt namespace pointer points to the initial one.
>     add override_creds()/revert_creds() around open_exec() in
>     bm_register_write()
> 
> v2: no new namespace, binfmt_misc data are now part of
>     the mount namespace
>     I put this in mount namespace instead of user namespace
>     because the mount namespace is already needed and
>     I don't want to force to have the user namespace for that.
>     As this is a filesystem, it seems logic to have it here.
> 
> This allows to define a new interpreter for each new container.
> 
> But the main goal is to be able to chroot to a directory
> using a binfmt_misc interpreter without being root.
> 
> I have a modified version of unshare at:
> 
>   git@github.com:vivier/util-linux.git branch unshare-chroot
> 
> with some new options to unshare binfmt_misc namespace and to chroot
> to a directory.
> 
> If you have a directory /chroot/powerpc/jessie containing debian for powerpc
> binaries and a qemu-ppc interpreter, you can do for instance:
> 
>  $ uname -a
>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 x86_64 x86_64 x86_64 GNU/Linux
>  $ ./unshare --map-root-user --fork --pid \
>    --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/qemu-ppc:OC" \
>    --root=/chroot/powerpc/jessie /bin/bash -l
>  # uname -a
>  Linux fedora28-wor-2 4.19.0-rc5+ #18 SMP Mon Oct 1 00:32:34 CEST 2018 ppc GNU/Linux
>  # id
> uid=0(root) gid=0(root) groups=0(root),65534(nogroup)
>  # ls -l
> total 5940
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 bin
> drwxr-xr-x.   2 nobody nogroup    4096 Jun 17 20:26 boot
> drwxr-xr-x.   4 nobody nogroup    4096 Aug 12 00:08 dev
> drwxr-xr-x.  42 nobody nogroup    4096 Sep 28 07:25 etc
> drwxr-xr-x.   3 nobody nogroup    4096 Sep 28 07:25 home
> drwxr-xr-x.   9 nobody nogroup    4096 Aug 12 00:58 lib
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 media
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 mnt
> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 13:09 opt
> dr-xr-xr-x. 143 nobody nogroup       0 Sep 30 23:02 proc
> -rwxr-xr-x.   1 nobody nogroup 6009712 Sep 28 07:22 qemu-ppc
> drwx------.   3 nobody nogroup    4096 Aug 12 12:54 root
> drwxr-xr-x.   3 nobody nogroup    4096 Aug 12 00:08 run
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:58 sbin
> drwxr-xr-x.   2 nobody nogroup    4096 Aug 12 00:08 srv
> drwxr-xr-x.   2 nobody nogroup    4096 Apr  6  2015 sys
> drwxrwxrwt.   2 nobody nogroup    4096 Sep 28 10:31 tmp
> drwxr-xr-x.  10 nobody nogroup    4096 Aug 12 00:08 usr
> drwxr-xr-x.  11 nobody nogroup    4096 Aug 12 00:08 var
> 
> If you want to use the qemu binary provided by your distro, you can use
> 
>     --load-interp ":qemu-ppc:M::\x7fELF\x01\x02\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x14:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff:/bin/qemu-ppc-static:OCF"
> 
> With the 'F' flag, qemu-ppc-static will be then loaded from the main root
> filesystem before switching to the chroot.
> 
> Laurent Vivier (1):
>   ns: add binfmt_misc to the user namespace
> 
>  fs/binfmt_misc.c               | 111 ++++++++++++++++++++++++---------
>  include/linux/user_namespace.h |  15 +++++
>  kernel/user.c                  |  14 +++++
>  kernel/user_namespace.c        |   3 +
>  4 files changed, 115 insertions(+), 28 deletions(-)
> 

