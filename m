Return-Path: <kernel-hardening-return-11889-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvr89yvk1eIIJKixBF4IxSZIAyd2R6syXOlH9yVcZoKbMpBsBKr8EcPQxL7uVLxaLV2dSPz
ARC-Seal: i=1; a=rsa-sha256; t=1519293121; cv=none;
        d=google.com; s=arc-20160816;
        b=kFwhNHZDqFwMbHgUFA9/Q0noxwcoFNyZgz1+n36OppWXGuNDZdooVdR711coguI8aP
         fkgEoyBMxUh839OTkpxs5prUAwHq0+QOaEc4/+mV2RrO+Gw7nyMbiZl6uWHElRwtBEke
         pCyrg3gtW+GMYLh7rNzedtuEzqNztEhAUXKtnoh4XX3RnJ36bAm1DYB99ub64TMVbTRP
         dbDHuWZ1Xy2kign/fEwisMPFMWeYd7RvPRq3qa5fOU3hydhDWN7cYl8ep5ydoLU0gqZJ
         8P5u+k0C1ByhFjRsOy4znBvcGPoEr8MuoO2R3JBg96ZXMDbkjdNzazbtlcLGwwjBiHmw
         9pCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :delivered-to:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=mNqpt2CDbSgqJGmwg+cB165ljekSvVTssqF+1qgnEw4=;
        b=0NaVUjKZlPTPhVoibT4JU+qmTZJlpe9q8Vhb5CPGkoqgsTDNUPxNZmhvEI+a1Jachq
         KAKypi6rWUG2HJ2nm4oaXrquDiIgnIf8lvftkrEanPu8hQX2Fq66lKjSIqHp6jcG0Jwt
         mvn+w+1Mg+AUzKORMwqv6VloMOPfrsx2ccpz1Idw3ofWllGZazK12iC6yqWacAe7UjTu
         em+0fxw0aykr5TRxcCbQeeo3YG6owgP4EdcglgjY9R83bFOZ2Yy0wRAUQ9Q2BUc+XOyz
         qkxT7ggW2NEsUy4PeWPZ5sqBcsTzsKFCJtsTiX/OUuJPWDma+ga1tw8A037HJxHZ4xRz
         7kaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11889-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11889-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-11889-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-11889-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: RANDSTRUCT structs need linux/compiler_types.h (Was: [nfsd4]
 potentially hardware breaking regression in 4.14-rc and 4.13.11)
To: Kees Cook <keescook@chromium.org>, Patrick McLean <chutzpah@gentoo.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Emese Revfy <re.emese@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Bruce Fields <bfields@redhat.com>, "Darrick J. Wong"
 <darrick.wong@oracle.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Thorsten Leemhuis <regressions@leemhuis.info>,
 "kernel-hardening@lists.openwall.com" <kernel-hardening@lists.openwall.com>
References: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Message-ID: <6be06ce5-87e6-0d9d-55b9-6c70c3578ecf@maciej.szmigiero.name>
Date: Wed, 21 Feb 2018 23:19:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLc_A1w4FM8FvQHGSPjLfOu80L_vbt_FkcE6+Bh_XMjxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593052828374787895?=
X-GMAIL-MSGID: =?utf-8?q?1593094304697413762?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18.11.2017 06:14, Kees Cook wrote:
> On Fri, Nov 17, 2017 at 5:54 PM, Patrick McLean <chutzpah@gentoo.org> wrote:
>> On 2017-11-17 04:55 PM, Linus Torvalds wrote:
>>> On Fri, Nov 17, 2017 at 4:27 PM, Patrick McLean <chutzpah@gentoo.org> wrote:
>>>>
>>>> I am still getting the crash at d9e12200852d, I figured I would
>>>> double-check the "good" and "bad" kernels before starting a full bisect.
>>>
>>> .. but without GCC_PLUGIN_RANDSTRUCT it's solid?
>>
>> Yes, without GCC_PLUGIN_RANDSTRUCT it's solid.
> 
> That's strange. With d9e12200852d the shuffle_seed variables won't
> ever actually get used. (i.e. I wouldn't expect the seed to change any
> behavior.)
> 
> Can you confirm with something like this:
> 
> 
>         for (i = 0; i < 4; i++) {
>                 seed[i] = shuffle_seed[i];
> 
> 
> You should see no reports of "Shuffling struct ..."
> 
> And if it reports nothing, and you're on d9e12200852d, can you confirm
> that switching to a "good" seed fixes it? (If it _does_, then I
> suspect a build artifact being left behind or something odd like
> that.)
> 
>>> Kees removed even the baseline "randomize pure function pointer
>>> structures", so at that commit, nothing should be randomized.
>>>
>>> But maybe the plugin code itself ends up confusing gcc somehow?
>>>
>>> Even when it doesn't actually do that "relayout_struct()" on the
>>> structure, it always does those TYPE_ATTRIBUTES() games.
> 
> FWIW, myself doing a build at d9e12200852d with and without
> GCC_PLUGIN_RANDSTRUCT _appears_ to produce identical objdump output
> where I did spot-checks.
> 

I have also hit a GPF in nfsd4_encode_fattr() with RANDSTRUCT plugin
enabled.
This function is located in a fs/nfsd/nfs4xdr.c file.

The fault happened at "xdr_encode_hyper(p, exp->ex_path.mnt->mnt_sb->s_maxbytes)"
line, namely when accessing s_maxbytes.

exp->ex_path is of type struct path that has been annotated with
__randomize_layout.
It seems to me that this annotation isn't really taken into consideration
when compiling nfs4xdr.c.
This most likely results in dereferencing a value of exp->ex_path.dentry
instead of exp->ex_path.mnt. Then some member of struct dentry is
dereferenced as struct super_block to access its s_maxbytes member which
results in an oops if it happens to be an invalid pointer (which it was
in my case).

How to reproduce the problem statically (tested on current Linus's tree
and on 4.15.4, with gcc 7.3.0):
1) Enable RANDSTRUCT plugin,

2) Use a RANDSTRUCT seed that results in shuffling of struct path,
Example: "55e5fea7ff662b333a190209ab31f35b6f0f2470f7d0e3c64430936169571106".

3) make fs/nfsd/nfs4xdr.s and save the result,

4) Insert "#include <linux/compiler_types.h>" at the top of
fs/nfsd/nfs4xdr.c as the very first include directive.

5) make fs/nfsd/nfs4xdr.s and compare the result with the one from step 3.

One can see that offsets used to access various members of struct path are
different, and also that the original file from step 3 contains an object
named "__randomize_layout".

This is caused by a fact that the current version of nfs4xdr.c includes
linux/fs_struct.h as the very first included header which then includes
linux/path.h as the very first included header, which then defines
struct path, but without including any files on its own.

This results in __randomize_layout tag at the end of struct path
definition being treated as a variable name (since linux/compiler-gcc.h
that defines it as a type attribute has not been included yet).

It looks like to me that every header file that defines a randomized
struct also has to include linux/compiler_types.h or some other file
that ultimately results in that file inclusion in order to make
the RANDSTRUCT plugin work correctly.

Maciej
