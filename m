Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DCCC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D1A2087C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 13:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="PWrj2PHk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7D1A2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbeH1RCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 13:02:43 -0400
Received: from sonic306-20.consmr.mail.ir2.yahoo.com ([77.238.176.206]:46055
        "EHLO sonic306-20.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727853AbeH1RCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 13:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1535461864; bh=LJ818FOFnnGoFeYTjrHES8uDLFpcPatjg2oq7Gg/ybA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=PWrj2PHkGpm1CV8q9GKO+apFa5IGnyBtPzi1v4wBPcO5RIRCc4M1sJUCBRPr9CFxLyEwuPw5L78p0CSYrn7fHeRKEj6t0kGId9q6OWWsJoFdyrc0UxNY+sAiyJg9duV0ZRXDD8NieKisTLXtRNjzfSp11U0r+Ts/fv8ckUQ3iPG3FkOsaU36AoGpueakdpwwUqklryQ749u4Rw/8WK2rvkLlC8CaF/ZcVJFYkFyO7b9OrWElJLsN1dMaufoODVBek87BGM/2U9V3aQLSwIs2k50Ut4dyk+JFEn/mSTgvd95i4LaOrh+2KbS6z3YuUbKMUlFQAYBfEU7xxcFlHV3k6g==
X-YMail-OSG: eenw3nIVM1nsrpZuSc0S3fK4GV9iF6X1eucnxI5ccOM2D2xKuRMeyqARTqZfhW9
 mVPF9Q0mH_PEnucXjbapGdB8XrvcsIdA0qo79OVl9SzcBYb3iDJUjnqPle0T6hkWD2Nf_7yQXYaB
 pC7iNXJjU_UwBJngqxaDzHR6qbXSYAOxvZLEeRio1_ppQsr_gtQgAB19lEaxjmzISkjMpltu7Jq9
 _yhc4hXEYmWX1zJ7IFz.sQ1J2P3Mp9PgMwbBwzzorXYVAj.f6CejpTMnJAl_Qktc55CfP53d_ADJ
 LS3oFOfaLLPmft5YrldtJFxc4rSiz0sN4QoDAeNwN7WoLdyxisGe404_OKtkxES.r8uHjHlIkjr7
 Ku1KjqrTJmbqnz9htkzvgbgQu4hagY1OQTAREi1ekFxWxernmtSe1pLOlQxIZrr6EHx2gOpZcCLM
 JS8qkq4y9Vy2SA5Y6md4yLUFum69TE7J4kvW8t4jM7jvfn.8YRc_vHI_jZ4Qoey4qnMn4.SnKVtu
 L4t9PWnloPh_zLir56NlUZcBaWFxOjC0aNc3d9_L_ZXoOwzMfuwyh9do8wTVtPUCGdaU7F7KvPY9
 PvKAJNiIQJy9MW4u9Fb.lDYCEG6VkHhqtXl4fzoYzGtE6AYRpRF49x.vbHZRlEjuNlZKbj2j4cat
 B9XcwXTdWdUr0tKPCtIu0spyFYwOSpPIrpaX58ZACXjy6.66Bg.COAU7oZxRf4xaQ24pSpeQY2zs
 fnYwhLkzXDoT8Icd1I3OGQAp5pk3upIFZyT9G7WtEjWAYo6Dv3PVc8_H3.oaVaFL_yylfnoYO2rJ
 AjmFk3szQHuunLhXuJIWfEvBU1gNNRZrGsr4Bm9eofVNZwdNqF.49RrVSh5b0O3WgQP3roDnaw5y
 KrhK9nmBBUY5krMD9guNG0SqE9xYxnqxiIB_FjrlIyA.aR68j923ARhu83YTM2Xj75txMGxAeaT5
 3S6EA6NHQop0UQyAkGHlexj4NxXbR0QHSrlffoS0x.0D1JqwpM8zJVYzzOn_yFfku9gtUx4_Az_e
 00BdyX.zDEic-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ir2.yahoo.com with HTTP; Tue, 28 Aug 2018 13:11:04 +0000
Received: from 116.226.251.211 (EHLO [192.168.1.7]) ([116.226.251.211])
          by smtp416.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID a6a6276edd10934b2724508b71c8a3a1;
          Tue, 28 Aug 2018 13:11:02 +0000 (UTC)
Subject: Re: [PATCH] Revert "staging: erofs: disable compiling temporarile"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>
Cc:     devel@driverdev.osuosl.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>, weidu.du@huawei.com,
        Miao Xie <miaoxie@huawei.com>
References: <1535427588-69630-1-git-send-email-gaoxiang25@huawei.com>
 <20180828054444.GA4453@kroah.com>
 <0c701b3c-5553-cf4c-c0b3-ad151b84662c@huawei.com>
 <f12ae5df-3130-f293-5863-3d9ff0802e92@huawei.com>
 <20180828130559.GA5427@kroah.com>
From:   Gao Xiang <hsiangkao@aol.com>
Message-ID: <12034d69-befb-7981-0ebb-97a3015c01da@aol.com>
Date:   Tue, 28 Aug 2018 21:10:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828130559.GA5427@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2018/8/28 21:05, Greg Kroah-Hartman wrote:
> On Tue, Aug 28, 2018 at 04:56:43PM +0800, Chao Yu wrote:
>> Hi Greg,
>>
>> On 2018/8/28 14:28, Gao Xiang wrote:
>>> Hi Greg,
>>>
>>> On 2018/8/28 13:44, Greg Kroah-Hartman wrote:
>>>> On Tue, Aug 28, 2018 at 11:39:48AM +0800, Gao Xiang wrote:
>>>>> This reverts commit 156c3df8d4db4e693c062978186f44079413d74d.
>>>>>
>>>>> Since XArray and the new mount apis aren't merged in 4.19-rc1
>>>>> merge window, the BROKEN mark can be reverted directly without
>>>>> any problems.
>>>>>
>>>>> Fixes: 156c3df8d4db ("staging: erofs: disable compiling temporarile")
>>>>> Cc: Matthew Wilcox <willy@infradead.org>
>>>>> Cc: David Howells <dhowells@redhat.com>
>>>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>>> Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
>>>>> ---
>>>>>
>>>>> Hi Greg,
>>>>>
>>>>>  Could you please apply this patch to enable EROFS from 4.19-rc2, thanks...
>>>>>
>>>>>  p.s. We would like to provide a more stable EROFS when linux-4.19 is out,
>>>>>       and there are also two patchsets (the one is already sent out by Chao
>>>>>       and me, the other is previewing in linux-erofs mailing list and it will
>>>>>       be sent out after gathering enough testdata and feedback from community
>>>>>       and carefully reviewed), could you also please consider applying these
>>>>>       two patchsets in the later 4.19-rc (both >2, or the first patchset
>>>>>       could be in rc2 in advance) if it is convenient to do so, or the next
>>>>>       4.20 is also ok...
>>>>>
>>>>>  LINK: https://lore.kernel.org/lkml/20180821144937.20555-1-chao@kernel.org/
>>>>>        https://lore.kernel.org/lkml/1535076160-99466-1-git-send-email-gaoxiang25@huawei.com/
>>>>
>>>> I applied those patch sets to my -next branch already, right?  So those
>>>
>>> Yes, Thank you for applying those patches. :)
>>>
>>>> would be going into 4.20-rc1, it is time now for "bugfixes only" for
>>>> 4.19-final.
>>>>
>>>> So perhaps we should just leave it as "BROKEN" for now for 4.19 and add
>>>> this to my tree now and let people work on it for the next few months in
>>
>> I'm worry about that once we plan to reenable erofs in next x.xx-rc1, in the
>> merge window, if there are any other features change common api or structure in
>> vfs/mm/block, but related patch didn't cover erofs, that would make conflict
>> with erofs.
>>
>> So if that happens, we can just reminder them to cover erofs? or we should
>> handle this by just delay removing 'BROKEN' state?
>>
>> Thanks,
>>
>>>> linux-next so that 4.20 has a solid base to start with?
>>>>
>>>
>>> EROFS is be marked as "BROKEN" just because of conflict with
>>> XArray and the new mount apis, as Stephen Rothwell suggested in
>>>
>>> https://lore.kernel.org/lkml/20180802010705.24a72730@canb.auug.org.au/
>>>
>>>> It might be easiest for Greg to add the disabling CONFIG_EROFS_FS patch
>>>> to the staging tree itself for his first pull request during the merge
>>>> window and then send a second pull request (after the vfs and maybe the
>>>> Xarray stuff has been merged by Linus) with these patches followed by a
>>>> revert of the disabling patch.
>>>
>>> But these two features was still discussing in the mailing list even at the
>>> last time of 4.19-rc1 merge window. I cannot decide whether they were eventually
>>> get merged in 4.19 or not. But it seems that it is regretful that linux-4.19
>>> is out without XArray and the new mount apis.
>>>
>>> Therefore, I think EROFS should work for linux-4.19 without any modification
>>> if just revert the BROKEN mark.
> 
> Ok, you are right, I'll go apply this.

I am so happy to see that, thanks for understanding :)

> 
>>> EROFS works fine with the 4.19-rc1 code except that it has some __GFP_NOFAIL
>>> and BUG_ONs on error handling paths and very rarely race between memory
>>> reclaiming and decompression... :( I personally think it is complete enough
>>> for people to test since it is an independent and staging filesystem driver (no
>>> other influence...) Anyway, removing EROFS BROKEN mark at 4.20 is also ok of course...
>>>
>>> On the other head, if XArray and the new mount apis is still pending for 4.20,
>>> should EROFS uses the same policy as Stephen suggested? I have no idea how to do next...
> 
> As the code is now part of the common tree that everyone works off of,
> any filesystem changes that happen will normally cover erofs as well.
> So this shouldn't be an issue anymore.
> 
That is so helpful for us... :)

Thanks,
Gao Xiang

> thanks,
> 
> greg k-h
> 
