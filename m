Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14352C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85D1214FA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 17:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85D1214FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJJAlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 20:41:12 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:45131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeJJAlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 20:41:11 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsZ7T-1fqkqB3dkZ-00tzv9; Tue, 09 Oct 2018 19:22:41 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MsZ7T-1fqkqB3dkZ-00tzv9; Tue, 09 Oct 2018 19:22:41 +0200
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
To:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Dmitry Safonov <dima@arista.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andrei Vagin (C)" <avagin@gmail.com>,
        "containers@lists.linux-foundation.org" 
        <containers@lists.linux-foundation.org>,
        Jann Horn <jannh@google.com>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu>
 <f14ce318-5a1a-06f3-2e90-91220f39e74b@virtuozzo.com>
 <bc11ca64-8616-f06a-c1fa-c76511e60257@vivier.eu>
 <7d9d7846-d153-f328-f5b4-8dc9d9705339@virtuozzo.com>
From:   Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1661f539-daf8-a66a-4562-03f20ecc9bef@vivier.eu>
Date:   Tue, 9 Oct 2018 19:22:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <7d9d7846-d153-f328-f5b4-8dc9d9705339@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kBuYsYeQk+lsMd+yFSPgQYGaeXVFiJYzKgpqurVWFywkAr4zsuV
 EHvSrBvdjURAbN8B7vi2o8kWiHMVejyrCFuB54Dk8aK3vz06QpSc+RBB8oInhs83ajDnQ5P
 pCfkrcjIRkPEFXYhN3ZHiMpTGL94SuDV7DLsKGjlq8DrGOhTtxMzCWF8jqqnYN4MdcAFrDx
 gRPFEOKjuNtfhCY5wssfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:x/qkoufo4Gk=:vIiL593Fi0tWFKXS+srcA6
 BTZTJczvV/YuqVeHLORaMH14zcPz0Kc0m5QNt16jp99FZcfENhFT7eZvFE2+P1uZ2SAuap/2V
 PXiRy7g1w67xD6gVeke7/ES/U92pz46w4u18l4grH3EqisJcQffNWPyogjozhJ2UxQBeGHxuj
 bvdJh3KQNd7wP8AabjWIzmtWGbVPh7X6gUeQhUGRxTF+ai10bFLTSa5NAlPkLscKH9VJOE0sW
 oBLng4NfKQMTMTiK9twT+PyXiTSTqJHchTm2Tmb4LEIYPbscGYePy7F8GhJ636yVVZWccPHnS
 +qBLnLOd96vuRwrKamaR/AzclLOZrJu/OEHwOOzhtIcYC2znZkPyIiI06OosO1oX96HFRZSWF
 io2ZMqcRdiFlD5WuCgc7+DH1uoNNI+AQcki4hVnL8jIrGtHd7EIxP6QrzqfMjfwtkO/nGmI3/
 RYsa1r9lCciMWc2LPhKy8ul5vA9NKz4Z9Spg8sORpA8KvzLcBeF3IMFjUiBO4foLuxGFP8shq
 0ypEMEvXAE5lDAcOZmxba2X6r76wXnYvRqNA1gStNX/SAebmFaCEZxH1rXwbtdIVA6cKbyPUv
 n06QrmLfXFEZ5eO3RZ4Qs8s3jJNAMVH0AKcX3Sk1ldjTurcjY9mcfa1w5XeQv2YxcL41MvwUB
 vX7Fnb4ukxcNE7aeqnvcq55COuEisgCEIRnQu4ARykuSGkEyK51zkk2gWeXJVIn+fiG4p1y05
 Bph7fWnycmiFpLwE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/10/2018 à 19:01, Kirill Tkhai a écrit :
> On 09.10.2018 19:45, Laurent Vivier wrote:
>> Le 09/10/2018 à 18:15, Kirill Tkhai a écrit :
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
>>>> +	struct binfmt_namespace *b_ns;
>>>> +
>>>> +	while (ns) {
>>>> +		b_ns = READ_ONCE(ns->binfmt_ns);
>>>> +		if (b_ns)
>>>> +			return b_ns;
>>>> +		ns = ns->parent;
>>>> +	}
>>>> +	WARN_ON_ONCE(1);
>>>> +	return NULL;
>>>> +}
>>>> +
>> ...
>>>> @@ -823,12 +847,34 @@ static const struct super_operations s_ops = {
>>>>  static int bm_fill_super(struct super_block *sb, void *data, int silent)
>>>>  {
>>>>  	int err;
>>>> +	struct user_namespace *ns = sb->s_user_ns;
>>>>  	static const struct tree_descr bm_files[] = {
>>>>  		[2] = {"status", &bm_status_operations, S_IWUSR|S_IRUGO},
>>>>  		[3] = {"register", &bm_register_operations, S_IWUSR},
>>>>  		/* last one */ {""}
>>>>  	};
>>>>  
>>>> +	/* create a new binfmt namespace
>>>> +	 * if we are not in the first user namespace
>>>> +	 * but the binfmt namespace is the first one
>>>> +	 */
>>>> +	if (READ_ONCE(ns->binfmt_ns) == NULL) {
>>>> +		struct binfmt_namespace *new_ns;
>>>> +
>>>> +		new_ns = kmalloc(sizeof(struct binfmt_namespace),
>>>> +				 GFP_KERNEL);
>>>> +		if (new_ns == NULL)
>>>> +			return -ENOMEM;
>>>> +		INIT_LIST_HEAD(&new_ns->entries);
>>>> +		new_ns->enabled = 1;
>>>> +		rwlock_init(&new_ns->entries_lock);
>>>> +		new_ns->bm_mnt = NULL;
>>>> +		new_ns->entry_count = 0;
>>>> +		/* ensure new_ns is completely initialized before sharing it */
>>>> +		smp_wmb();
>>>
>>> (I haven't dived into patch logic, here just small barrier remark from quick sight).
>>> smp_wmb() has no sense without paired smp_rmb() on the read side. Possible,
>>> you want something like below in read hunk:
>>>
>>> +		b_ns = READ_ONCE(ns->binfmt_ns);
>>> +		if (b_ns) {
>>> +			smp_rmb();
>>> +			return b_ns;
>>> +		}
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
> smp_rmb() guarantees you see stores in the order you want. If you have:
> 
> [cpu0]					[cpu1]
> new_ns->entry_count = 0; 
> smp_wmb();
> WRITE_ONCE(ns->binfmt_ns, new_ns); 	b_ns = READ_ONCE(ns->binfmt_ns);
> 					smp_rmb();
> 					<access b_ns->entry_count>
> 
> smp_rmb() guarantees you see true entry_count on the cpu1. Without
> smp_rmb() you may see old value of new_ns->entry_count.
> 					
> See Documentation/memory-barriers.txt

Yes, I tried to read this document several times...

What I understand from example line 1077 (7696f9910a9a
Documentation/memory-barriers.txt) is we only need a data dependency
barrier, and as explained by Jann it comes with the READ_ONCE() (and is
only needed for alpha).

Thanks,
Laurent

