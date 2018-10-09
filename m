Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21097ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE595214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:58:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE595214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeJJAQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:16:20 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:54813 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeJJAQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:16:20 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSI6i-1gGTrM3eem-00Sbg7; Tue, 09 Oct 2018 18:57:45 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MSI6i-1gGTrM3eem-00Sbg7; Tue, 09 Oct 2018 18:57:45 +0200
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Jann Horn <jannh@google.com>
Cc:     ktkhai@virtuozzo.com, kernel list <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>, dima@arista.com,
        Linux API <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        containers@lists.linux-foundation.org
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
 <f14ce318-5a1a-06f3-2e90-91220f39e74b@virtuozzo.com>
 <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
 <CAG48ez0pAxC+yetPfM+XyS8kfqA4hw1hxjKG55gbF-4qcNWUiA@mail.gmail.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <795fea1a-97bd-87f5-6a14-6d47a4e42f74@vivier.eu>
Date:   Tue, 9 Oct 2018 18:57:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0pAxC+yetPfM+XyS8kfqA4hw1hxjKG55gbF-4qcNWUiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZigYeYJpxcZLFV1LRiTgj6M2wi85ilW5twU2J5i95X7FzPQ+UxK
 Y3u0uHlG5anDaGUVgJiLIlGJciJ4ISzq8Nv5fVbCqh9Jj7u+0bEkTsEzSJ+nkiusXSozL/W
 ChOuiGMakIbmDfAllnCRdczQD63SG4Hqn7GZwmJJMs4s3wEVhA2IjSk0XRQbgN7gEFbSAbF
 S2sbeP2CvPaJfhqQBxM5A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:EX5Zsbm1LFM=:ycoAsIImTKiYQ2lDEpQeaZ
 LC5JkkltoFVZF08g+7+8mdITwCiuJJH15oPPxe+5qDW5/Vj4ua/TQuqOLBmIn8nNriGOvoxNj
 VBKuwzOwq4XUzGu2sQkDB3OgF+j9AhuKfSASa1OKozyt5nRwkxbGQTVCU4Irwvp7OMfrRB4AY
 aszKDgj9kFwYJoTSqBgmj5exJGSx5zp7IkJm2mfOQ/9o9lBm50DoLJfmWLICzjwGbG1Iv9gJV
 3M6skcQspTHue9IHzn9qqzZIeggttEo+c12gNNkfU94uZgda2bxfEq4oZTXQltUO5TDFlEUCm
 kcjvNY/hDfaciYtTN1C2pL8lRcTZD4snDw85ai7mgcx1etx0+NUpdtjZfBA+rUpzqPiUSCUni
 cc5Jrd3J4g8cPlqyTnmYdKh+GKP69JtVUdH8w/9GW/iMroouPSzdzwozyA4KL83tuGoYC/uUb
 gwH9J6ySAUqecGph5LsUknsvTOQBcVfZJ5xcqOCmK8jIzGmcElIReVHJ9RiOOMsI7We6jqT7B
 2Kowd9QbRI5dLAJBXeZCLDChV4Z+Aip64+MwwjHr5GEKmoCaTjeE/4XWQVvIjkM9ihsS1L8Bu
 NTbXNK23vI8bOqVQUFaWG5PGu/t2MH1iEpIozQ5ZVq1zLYcMcpgqMJEkWq7eRjT9xIibk6J7T
 f6MDsRlPPOBImQCHtZ6YcszV8x0pM6+/Ut3tSAMPgh/DP+NowIjdUFLBRsKyI/qufIhLfm18Q
 TeHTk+jcZphjTgxG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/10/2018 à 18:53, Jann Horn a écrit :
> On Tue, Oct 9, 2018 at 6:45 PM Laurent Vivier <laurent@vivier.eu> wrote:
>> Le 09/10/2018 à 18:15, Kirill Tkhai a écrit :
>>> On 09.10.2018 13:37, Laurent Vivier wrote:
>>>> This patch allows to have a different binfmt_misc configuration
>>>> for each new user namespace. By default, the binfmt_misc configuration
>>>> is the one of the previous level, but if the binfmt_misc filesystem is
>>>> mounted in the new namespace a new empty binfmt instance is created and
>>>> used in this namespace.
>>>>
>>>> For instance, using "unshare" we can start a chroot of an another
>>>> architecture and configure the binfmt_misc interpreter without being root
>>>> to run the binaries in this chroot.
>>>>
>>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>>> ---
>>>>  fs/binfmt_misc.c               | 106 ++++++++++++++++++++++++---------
>>>>  include/linux/user_namespace.h |  13 ++++
>>>>  kernel/user.c                  |  13 ++++
>>>>  kernel/user_namespace.c        |   3 +
>>>>  4 files changed, 107 insertions(+), 28 deletions(-)
>>>>
>>>> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
>>>> index aa4a7a23ff99..1e0029d097d9 100644
>>>> --- a/fs/binfmt_misc.c
>>>> +++ b/fs/binfmt_misc.c
>> ...
>>>> @@ -80,18 +74,32 @@ static int entry_count;
>>>>   */
>>>>  #define MAX_REGISTER_LENGTH 1920
>>>>
>>>> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
>>>> +{
>>>> +    struct binfmt_namespace *b_ns;
>>>> +
>>>> +    while (ns) {
>>>> +            b_ns = READ_ONCE(ns->binfmt_ns);
>>>> +            if (b_ns)
>>>> +                    return b_ns;
>>>> +            ns = ns->parent;
>>>> +    }
>>>> +    WARN_ON_ONCE(1);
>>>> +    return NULL;
>>>> +}
>>>> +
>> ...
>>>> @@ -823,12 +847,34 @@ static const struct super_operations s_ops = {
>>>>  static int bm_fill_super(struct super_block *sb, void *data, int silent)
>>>>  {
>>>>      int err;
>>>> +    struct user_namespace *ns = sb->s_user_ns;
>>>>      static const struct tree_descr bm_files[] = {
>>>>              [2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
>>>>              [3] = {"register", &bm_register_operations, S_IWUSR},
>>>>              /* last one */ {""}
>>>>      };
>>>>
>>>> +    /* create a new binfmt namespace
>>>> +     * if we are not in the first user namespace
>>>> +     * but the binfmt namespace is the first one
>>>> +     */
>>>> +    if (READ_ONCE(ns->binfmt_ns) == NULL) {
>>>> +            struct binfmt_namespace *new_ns;
>>>> +
>>>> +            new_ns = kmalloc(sizeof(struct binfmt_namespace),
>>>> +                             GFP_KERNEL);
>>>> +            if (new_ns == NULL)
>>>> +                    return -ENOMEM;
>>>> +            INIT_LIST_HEAD(&new_ns->entries);
>>>> +            new_ns->enabled = 1;
>>>> +            rwlock_init(&new_ns->entries_lock);
>>>> +            new_ns->bm_mnt = NULL;
>>>> +            new_ns->entry_count = 0;
>>>> +            /* ensure new_ns is completely initialized before sharing it */
>>>> +            smp_wmb();
>>>
>>> (I haven't dived into patch logic, here just small barrier remark from quick sight).
>>> smp_wmb() has no sense without paired smp_rmb() on the read side. Possible,
>>> you want something like below in read hunk:
>>>
>>> +             b_ns = READ_ONCE(ns->binfmt_ns);
>>> +             if (b_ns) {
>>> +                     smp_rmb();
>>> +                     return b_ns;
>>> +             }
>>>
>>>
>>
>> The write barrier is here to ensure the structure is fully written
>> before we set the pointer.
>>
>> I don't understand how read barrier can change something at this level,
>> IMHO the couple WRITE_ONCE()/READ_ONCE() should be enough to ensure we
>> have correctly initialized the pointer and the structure when we read
>> the pointer back.
>>
>> I think the pointer itself is the "barrier" to access the memory
>> modified before.
> 
> Things don't work that way on alpha, but that's why READ_ONCE()
> includes an smp_read_barrier_depends():
> 
> #define __READ_ONCE(x, check)                                           \
> ({                                                                      \
>         union { typeof(x) __val; char __c[1]; } __u;                    \
>         if (check)                                                      \
>                 __read_once_size(&(x), __u.__c, sizeof(x));             \
>         else                                                            \
>                 __read_once_size_nocheck(&(x), __u.__c, sizeof(x));     \
>         smp_read_barrier_depends(); /* Enforce dependency ordering from x */ \
>         __u.__val;                                                      \
> })
> #define READ_ONCE(x) __READ_ONCE(x, 1)
> 

So my questions are:

- do we need a smp_wmb() barrier if we use READ_ONCE() and WRITE_ONCE()?

- if we need an smp_wmb() barrier, do we need an smp_rmb() barrier as
the data we want to "protect" are behind an access to the pointer?

Thanks,
Laurent
