Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6028DECDFC0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161E620865
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SrNg/AC5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SrNg/AC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 161E620865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeIKOZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:25:05 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44420 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeIKOZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:25:04 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id D08E9609BD; Tue, 11 Sep 2018 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536657997;
        bh=je+ux1fNPM0rDNJIXO6MU0PLVknQA2juJxQKvdOojWQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SrNg/AC5tSxxtHDuYxW+R1PeJMJ0GGulqwSwNc+6Zqcozct0+fOnytmZBm4oOkxYS
         2e6F42XnpO4lfh4g8CkzeFiIPJVbMnbfNd7D2+udVLq8VGE2Ei67ojTfTk6qEbfNtM
         Boz297B/7+8z3fm6VTbqqAw5DvJ77RM8dOArLofs=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D9526607EB;
        Tue, 11 Sep 2018 09:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536657997;
        bh=je+ux1fNPM0rDNJIXO6MU0PLVknQA2juJxQKvdOojWQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SrNg/AC5tSxxtHDuYxW+R1PeJMJ0GGulqwSwNc+6Zqcozct0+fOnytmZBm4oOkxYS
         2e6F42XnpO4lfh4g8CkzeFiIPJVbMnbfNd7D2+udVLq8VGE2Ei67ojTfTk6qEbfNtM
         Boz297B/7+8z3fm6VTbqqAw5DvJ77RM8dOArLofs=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D9526607EB
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH] ASoC: Fix UBSAN warning at
 snd_soc_get/put_volsw_sx()
To:     Takashi Iwai <tiwai@suse.de>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
References: <1536600836-12153-1-git-send-email-rohitkr@codeaurora.org>
 <s5hzhwp2oqd.wl-tiwai@suse.de>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3ac92f3a-059f-3513-4942-23eb41222490@codeaurora.org>
Date:   Tue, 11 Sep 2018 14:56:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hzhwp2oqd.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Takashi for reviewing.


On 9/10/2018 11:56 PM, Takashi Iwai wrote:
> On Mon, 10 Sep 2018 19:33:56 +0200,
> Rohit kumar wrote:
>> In functions snd_soc_get_volsw_sx() or snd_soc_put_volsw_sx(),
>> if the result of (min + max) is negative, then fls() returns
>> signed integer with value as 32. This leads to signed integer
>> overflow as complete operation is considered as signed integer.
>>
>> UBSAN: Undefined behaviour in sound/soc/soc-ops.c:382:50
>> signed integer overflow:
>> -2147483648 - 1 cannot be represented in type 'int'
>> Call trace:
>> [<ffffff852f746fe4>] __dump_stack lib/dump_stack.c:15 [inline]
>> [<ffffff852f746fe4>] dump_stack+0xec/0x158 lib/dump_stack.c:51
>> [<ffffff852f7b5f3c>] ubsan_epilogue+0x18/0x50 lib/ubsan.c:164
>> [<ffffff852f7b6840>] handle_overflow+0xf8/0x130 lib/ubsan.c:195
>> [<ffffff852f7b68f0>] __ubsan_handle_sub_overflow+0x34/0x44 lib/ubsan.c:211
>> [<ffffff85307971a0>] snd_soc_get_volsw_sx+0x1a8/0x1f8 sound/soc/soc-ops.c:382
>>
>> Typecast the operation to unsigned int to fix the issue.
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> ---
>>   sound/soc/soc-ops.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
>> index 592efb3..f8e3190 100644
>> --- a/sound/soc/soc-ops.c
>> +++ b/sound/soc/soc-ops.c
>> @@ -373,7 +373,7 @@ int snd_soc_get_volsw_sx(struct snd_kcontrol *kcontrol,
>>   	unsigned int rshift = mc->rshift;
>>   	int max = mc->max;
>>   	int min = mc->min;
>> -	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
>> +	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
> Cat it be simpler like below instead?
> 	unsigned int mask = (1U << (fls(min + max) - 1)) - 1;

Yes, let me just update it.
>
> thanks,
>
> Takashi
>
>>   	unsigned int val;
>>   	int ret;
>>   
>> @@ -418,7 +418,7 @@ int snd_soc_put_volsw_sx(struct snd_kcontrol *kcontrol,
>>   	unsigned int rshift = mc->rshift;
>>   	int max = mc->max;
>>   	int min = mc->min;
>> -	unsigned int mask = (1 << (fls(min + max) - 1)) - 1;
>> +	unsigned int mask = ((unsigned int)(1 << (fls(min + max) - 1)) - 1);
>>   	int err = 0;
>>   	unsigned int val, val_mask, val2 = 0;
>>   
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
Thanks,
Rohit

