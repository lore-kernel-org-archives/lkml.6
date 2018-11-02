Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D98C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FF70204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aagOFjKf";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dvYEZnvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF70204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbeKBVNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:13:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:57136 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbeKBVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:13:54 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0B70860ADB; Fri,  2 Nov 2018 12:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541160416;
        bh=UUGzCln5PxWGa+m2qMi8SbFWy84NeN5/2RVQxaZEiE8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=aagOFjKfXp+y4ZDXBKeQzC6M0n7jarLzxokmtR3es5SLbitWVCLPYf0ej3MNawUlv
         KCsEfbVmZ6cxsNI6IVOBOXXXCDevs8qPDM2gC5XvCxovqQinlXVKSIa18oljdXgreA
         PBFuibK3Op2kiDcWb6tHcNjGwWyypwE6ztyTMeqE=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 620566074C;
        Fri,  2 Nov 2018 12:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1541160414;
        bh=UUGzCln5PxWGa+m2qMi8SbFWy84NeN5/2RVQxaZEiE8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dvYEZnvft2EhyAoyb6Z20AGJ571GWDjqLFYGpTt7HEF2jLq430BXoudVJAxiiVhgK
         YYn7lucszNYr45r525bkP8YxFZb7kSQXGg+nd32NKNAWgD6VX6Qiz8sXsRY9gVAMrQ
         hQiD9VcUyD4gbY/TG4OxJsB25UV5X94C1w/zT7H4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 620566074C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH] ASoC: core: Invoke pcm_new() for all
 DAI-link
To:     Takashi Iwai <tiwai@suse.de>, olivier.moysan@st.com
Cc:     plai@codeaurora.org, bgoswami@codeaurora.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.org
References: <1541075929-29323-1-git-send-email-rohitkr@codeaurora.org>
 <s5htvl0exil.wl-tiwai@suse.de>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <48c78f67-8178-2d07-e35d-2e4eca51ccbc@codeaurora.org>
Date:   Fri, 2 Nov 2018 17:36:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5htvl0exil.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/2018 1:12 PM, Takashi Iwai wrote:
> On Thu, 01 Nov 2018 13:38:49 +0100,
> Rohit kumar wrote:
>> Remove no_pcm check to invoke pcm_new() for backend dai-links
>> too. This fixes crash in hdmi codec driver during hdmi_codec_startup()
>> while accessing chmap_info struct. chmap_info struct memory is
>> allocated in pcm_new() of hdmi codec driver which is not invoked
>> in case of DPCM when hdmi codec driver is part of backend dai-link.
>>
>> Below is the crash stack:
>>
>> [   61.635493] Unable to handle kernel NULL pointer dereference at virtual address 00000018
>> ..
>> [   61.666696]   CM = 0, WnR = 1
>> [   61.669778] user pgtable: 4k pages, 39-bit VAs, pgd = ffffffc0d6633000
>> [   61.676526] [0000000000000018] *pgd=0000000153fc8003, *pud=0000000153fc8003, *pmd=0000000000000000
>> [   61.685793] Internal error: Oops: 96000046 [#1] PREEMPT SMP
>> [   61.722955] CPU: 7 PID: 2238 Comm: aplay Not tainted 4.14.72 #21
>> ..
>> [   61.740269] PC is at hdmi_codec_startup+0x124/0x164
>> [   61.745308] LR is at hdmi_codec_startup+0xe4/0x164
>>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
> Did you check whether all drivers have no side-effect by this change?
> The hdmi-codec isn't the only driver that has pcm_new ops, so we have
> to make sure that such a fundamental change wouldn't bring any
> regressions.
>
Below are the drivers calling pcm_new() other than hdmi codec driver.
sound/soc/meson/axg-frddr.c
sound/soc/meson/axg-toddr.c
These two drivers are frontend DAI drivers and should not be impacted
because of this.

Other than this, pcm_new() is called from sound/soc/stm/stm32_sai_sub.c
I could not get much info about this driver. However, it is just adding
kcontrols in pcm_new() which uses internal private structs in get()/put().
Olivier Moysan can too confirm on this.

Thanks,
Rohit
> thanks,
>
> Takashi

-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

