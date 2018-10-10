Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60C1C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:12:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8DE214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 10:12:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8DE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJJRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 13:33:38 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:45905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeJJRdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 13:33:37 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MF45G-1fuoKI1ptY-00FX0Q; Wed, 10 Oct 2018 12:11:38 +0200
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MF45G-1fuoKI1ptY-00FX0Q; Wed, 10 Oct 2018 12:11:38 +0200
Subject: Re: [RFC v5 1/1] ns: add binfmt_misc to the user namespace
From:   Laurent Vivier <laurent@vivier.eu>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        Jann Horn <jannh@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Eric Biederman <ebiederm@xmission.com>,
        linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20181009103752.21482-1-laurent@vivier.eu>
 <20181009103752.21482-2-laurent@vivier.eu> <20181009151641.GB10149@cisco>
 <409c22e3-1df8-cf7f-2462-ead2bb3020cf@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <485d1157-9d3e-b4e0-4ece-4e80b2f252c4@vivier.eu>
Date:   Wed, 10 Oct 2018 12:11:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <409c22e3-1df8-cf7f-2462-ead2bb3020cf@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RgpptC8ZvNIJIRTylJ3946i3Qb6j6ZiZZVz8n1fw+QPufSf/RyX
 qnIafzYC3eUR+Gw3ya1B7ZtUWyqXGyq38Y0n6igOBwl+M61ceROvbVHJD63pnZLuWWaawLp
 DLEPvlcm2qnE5kWwTMNTBWpy0jyTvWVX+7u4J0s18e1Lwtsu1qJUo2vFCgHiXnJQ4mJ3aib
 BOjVRdi3uVyG9SLBgpsvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:h2iTG+3WqFQ=:nMv1B5YCTv28t+owGbiRbH
 +amn6gJCihK9/PFlrITkji19SJi9IFj4snenrw0/7W4AW7gm9H6brWX3lWyW8Tu4UDjH+bk7J
 fm6GfqoiRvIswje9fTvw3pIzl0MAGdc3CTB/NyyRmQXAGXP27wq/VlaCVQCSnExFc3+Un0jY9
 9+OORdTjVcCC2lwlrnwBsvmx/gYndh13XvvWtCZAz43XXkSxrl8ulK3X4p1pomRYDlAQQOCYU
 5gg6McUk4tt8Dga+R3I+MCPefyKfMv87S+tBKHJjgKXcd6KYV+dJAlhuyZKh0pGdi4joZJp9J
 FnJORk807dtuLxvGg1kgnATpihLcdrZ4dI6348U3U3w8bC+abGCGkyMMqhVI0HZG+UC6rXXlc
 /LfviYrfI64iz5mQYy2Ys95TsrjcISKQfuRus4lFqqfxMgicfa5hzYUyKo6QAtKoBBo9HZlzO
 ++bHLS1vyJ4AjeiHburrq/F/UGhNHac9NKXcae+2VpU0ILrZ6HJvasmL5bzKkh3pId8N4j1lR
 ECchbNpxeDilx9F/D/sy3cumVrIlIUWTo8DerUsVADLHm0uF80omoKYTWX6Av8DO3JUo1wEK1
 0vXex1qTHyomIns2T7J0CiyAC5pHlhgBNNkfmwjgxC63nIBgg+jIGKYyVc8UryaRcIKNLV2i5
 xeZB+7jBqpexQuyFTIQ8neHD3dFGs91YDNzCu3oLd9ILPrRYvGVXP6bAAVfyDxD+/RCT5RGNJ
 L2KOWv1uRQCuisSH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2018 17:19, Laurent Vivier wrote:
> Le 09/10/2018 à 17:16, Tycho Andersen a écrit :
>> On Tue, Oct 09, 2018 at 12:37:52PM +0200, Laurent Vivier wrote:
>>> @@ -80,18 +74,32 @@ static int entry_count;
>>>   */
>>>  #define MAX_REGISTER_LENGTH 1920
>>>  
>>> +static struct binfmt_namespace *binfmt_ns(struct user_namespace *ns)
>>> +{
>>> +	struct binfmt_namespace *b_ns;
>>> +
>>> +	while (ns) {
>>> +		b_ns = READ_ONCE(ns->binfmt_ns);
>>> +		if (b_ns)
>>> +			return b_ns;
>>> +		ns = ns->parent;
>>> +	}
>>> +	WARN_ON_ONCE(1);
>>
>> It looks like we warn here,
>>
>>> @@ -133,17 +141,18 @@ static int load_misc_binary(struct linux_binprm *bprm)
>>>  	struct file *interp_file = NULL;
>>>  	int retval;
>>>  	int fd_binary = -1;
>>> +	struct binfmt_namespace *ns = binfmt_ns(current_user_ns());
>>>  
>>>  	retval = -ENOEXEC;
>>> -	if (!enabled)
>>> +	if (!ns->enabled)
>>
>> ...but then in cases like this we immediately dereference the pointer
>> anyways and crash. Can we return some other error code here in the !ns
>> case so we don't crash?
> 
> My concern here is I don't want to add code to check an error case that
> cannot happen. The first namespace binfmt_ns pointer is initialized with
> &init_binfmt_ns, so the return value cannot be NULL.

Perhaps it could be reasonable to return &init_binfmt_ns rather than
NULL in this case?

Thanks,
Laurent

