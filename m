Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6AC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CFF82080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 08:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CFF82080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeJ3Roh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 13:44:37 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:49769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbeJ3Roh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 13:44:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MI5YN-1gNl0T3Bjz-00F9I0; Tue, 30 Oct 2018 09:51:34 +0100
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MI5YN-1gNl0T3Bjz-00F9I0; Tue, 30 Oct 2018 09:51:34 +0100
Subject: Re: [PATCH v6 1/1] ns: add binfmt_misc to the user namespace
From:   Laurent Vivier <laurent@vivier.eu>
To:     Eric Biederman <ebiederm@xmission.com>
Cc:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        containers@lists.linux-foundation.org,
        Dmitry Safonov <dima@arista.com>
References: <20181010161430.11633-1-laurent@vivier.eu>
 <20181010161430.11633-2-laurent@vivier.eu> <20181016162245.GA7697@gmail.com>
 <0fb09ce6-e006-31a2-1f32-f3f6eda44504@vivier.eu>
Message-ID: <4a1ec0cf-dce7-4193-6946-d46d63398c2d@vivier.eu>
Date:   Tue, 30 Oct 2018 09:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0fb09ce6-e006-31a2-1f32-f3f6eda44504@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3gFO3SVwnxgIr3iwSd86bsSaiXl3McEQmHvEzfX8QQXsr6VUzg0
 FkHA7Nx5zDh6cDONU+IpbbgHaLJms/zb/bNJPrK6cr2voosxmWW7+YrOzio/7oeNn3ZtI2j
 mU2g3z6rqABthGVue9FmzIb2cjBe+jAYIdQ4S5wX7QNKMZrfoQLMrAnbYR+MgobVEJ1XeMc
 z34dSAynvhxhOVjbKUP+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3wNgsPBuC2I=:Ege9K4+ttZK0gTOjYCKFvv
 x6QiIIAAvqbgIL7aSWrIAi6WFFfuxiwpYnoh4Oyi+k/o0z35GNbBxcp9VUVmmTpQ5aLjfZzsd
 mTxiM0RJ/y/Vf/JUzw5xZSJsKoT9YxpSNvd0Zkz6JDAzA/8XlR8791To+AKE6VXlMGSkgPp7z
 F3uvrLM8h8cs4R6RXIvPmcuK5F/eltH+GkGB9MUFVuqih/Q+95bKyzw+tbATHX2voWRCbYNcl
 BjSwc//yMffSO9EzbDSBwi5w54cuURy1w+wYQ4yr0OTFBmQAzbTNSQ3y8PdGnP592tIYlghFd
 zZP/d0I0wfWKbfRrPXI4d0iyZoaqhh8I2z+jmaYZM38nKP11VsXzeAG3BNKy6hI3f8syP5tWB
 vOwNjp9sXoeFIaWEUucPd2VdmmZWj9pojyxpLiXvgmlXCj6FYPHegKcPvmaLoVmDs3EC1ji2N
 yddjkUjQUrITx2E/0vG1b2eElDZc5WaOR77R3gOA2FGxOK8xq+YwrX/ZtDdvVl3Exrmm9ksoX
 PXugw8joTAev/0CS673jhOwXsB54cAX8gqBq2EyBhVgQ4XRBU5rSQX6AMd0QJtnwgXW/pOgzh
 SEWp3OoQEXwdkUhTrsaGfJEuMaAOwmBtGQdKugcOdf10IUGw8BV5+qF4SY65w5m7blCHZCBhJ
 vgVfixGpwEN7VRBUVZlz+v1KtPS2fm2eRotmRCMP2nkj+h+8Fs4URuPpdE6mQ1Fj+74cYBdaU
 OdmY0uHi8CfzxRMA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 24/10/2018 à 19:15, Laurent Vivier a écrit :
> On 16/10/2018 17:22, Andrei Vagin wrote:
>> On Wed, Oct 10, 2018 at 06:14:30PM +0200, Laurent Vivier wrote:
>>> This patch allows to have a different binfmt_misc configuration
>>> for each new user namespace. By default, the binfmt_misc configuration
>>> is the one of the previous level, but if the binfmt_misc filesystem is
>>> mounted in the new namespace a new empty binfmt instance is created and
>>> used in this namespace.
>>>
>>> For instance, using "unshare" we can start a chroot of another
>>> architecture and configure the binfmt_misc interpreter without being root
>>> to run the binaries in this chroot.
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>
>> Acked-by: Andrei Vagin <avagin@gmail.com>
>>
>> Thanks,
>> Andrei
>>
> 
> I don't konw who is the maintainer for this part, but is there any
> chance to have this merged in 4.20?
> 

I'd really want to have this merged.

I have some real use cases for this:

1- to allow a non root user to run a container (with "unshare" for
instance) with its own binfmt_misc configuration. For instance, like we
provide a disk image and ask an ordinary user to run it with his
favorite VM hypervisor, we can provide a tar.gz containing our own
interpreter and just ask him to unshare+chroot to the exploded file tree,

2- to allow to run automatic tests of an interpreter on a machine
without having to change the global configuration of the system. I have
in mind to add some tests in Avocado to automatically test
qemu-linux-user in containers, so the interpreter path can depend on the
build path and possibly run them concurrently,

3- to select an interpreter by container. For instance, on the
qemu-devel mailing list, we have a waiting patch to add the bFLT
interpreter binfmt_misc configuration, but the bFLT doesn't provide the
CPU type in magic/mask. So it would be interesting to be able to select
also a bFLT interpreter by container, as we know the CPU architecture we
have in each chroot/container,

4- another example to select an interpreter by container is qemu-mips
and qemu-misn32 share the same magic/mask because only the kernel API
changes, so we can't configure both on the system (but I agree it's a
QEMU bug: they should be merged and the kernel API be selected at runtime).

Thanks,
Laurent
