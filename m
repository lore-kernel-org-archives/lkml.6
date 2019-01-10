Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3782C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EECE20665
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 07:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="HjbuhuyY";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M/y5sLSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727545AbfAJHJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 02:09:23 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:57980 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfAJHJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 02:09:23 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 597D3608D2; Thu, 10 Jan 2019 07:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547104162;
        bh=7U1wqjObICvNsKQnkAqwEHTPjZfoFIZ2MDuJ8nTXh/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=HjbuhuyY6OLOPbjCf43yylNin1r8bV4yUIPVR7Nc88IGfeTpDBb0SDdV0AAp7M/XY
         85cxtIx1l8C6mGM/K7t+z1LPlGPpqiv+/FcbZO7w0nhXob10uT5VTr6HIi6/rro17G
         uC20+r//w3FKaxrm3vEGpD9R0B7+PKBniWydyYK8=
Received: from [10.204.110.203] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rohitkr@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B43C460132;
        Thu, 10 Jan 2019 07:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1547104160;
        bh=7U1wqjObICvNsKQnkAqwEHTPjZfoFIZ2MDuJ8nTXh/s=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M/y5sLSO/0ast6kXAJiQrloigh37oAhHie6UyhRVu/KU2Dv++3az2HokyZaHpLkRm
         QO9Fd2Ro+9PPK20fh+lAmGOEdu+a46EkufezxEzQMcYyLeLV3ufS5n52TnhE+NNDvf
         M8Q4l4kLa3l7+TCYoMfzwzyMdAQK2Irz53dr9oGE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B43C460132
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] Applied "ASoC: soc-core: defer card probe until all
 component is added to list" to the asoc tree
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Ajit Pandey <ajitp@codeaurora.org>, rohkumar@qti.qualcomm.com,
        alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com,
        asishb@codeaurora.org, srinivas.kandagatla@linaro.org
References: <1547023627-30312-1-git-send-email-rohitkr@codeaurora.org>
 <20190109124902.672EB1127528@debutante.sirena.org.uk>
 <874lahb6bi.wl-kuninori.morimoto.gx@renesas.com>
From:   Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <961ef85b-86a5-1db8-260b-6c5cb27399fe@codeaurora.org>
Date:   Thu, 10 Jan 2019 12:39:13 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <874lahb6bi.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Kuninori for reporting the issue.

On 1/10/2019 8:02 AM, Kuninori Morimoto wrote:
> Hi Mark, Ajit
>
>> From: Ajit Pandey <ajitp@codeaurora.org>
>> Date: Wed, 9 Jan 2019 14:17:07 +0530
>> Subject: [PATCH] ASoC: soc-core: defer card probe until all component is added
>>   to list
>>
>> DAI component probe is not called if it is not present
>> in component list during sound card registration.
>> Check if component is available in component list for
>> platform and cpu dai before soundcard registration.
>>
>> Signed-off-by: Ajit Pandey <ajitp@codeaurora.org>
>> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> ---
> I got below WARNING by this patch.
> I guess we need mutex_lock() on snd_soc_register_card() ?

Right, we should have client_mutex lock before calling 
soc_find_component().

We will post fix.

>
> 	...
> 	[drm] Device feb00000.display probed
> 	[drm] Cannot find any crtc or sizes
> 	[drm] Cannot find any crtc or sizes
> 	WARNING: CPU: 0 PID: 76 at sound/soc/soc-core.c:739 soc_find_component+0xb8/0xc0
> 	CPU: 0 PID: 76 Comm: kworker/0:1 Not tainted 5.0.0-rc1+ #1360
> 	Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
> 	Workqueue: events deferred_probe_work_func
> 	pstate: 60000005 (nZCv daif -PAN -UAO)
> 	pc : soc_find_component+0xb8/0xc0
> 	lr : soc_find_component+0xb4/0xc0
> 	sp : ffff00001217ba10
> 	x29: ffff00001217ba10 x28: 0000000000000000
> 	x27: ffff000010a82920 x26: 0000000000000000
> 	x25: ffff8006f9c59900 x24: ffff0000105f33a0
> 	x23: ffff000010948d70 x22: 0000000000000000
> 	x21: ffff000010af1720 x20: ffff8006ff80b6d8
> 	x19: ffff8006f8523080 x18: 0000000000000010
> 	x17: 0000000000000000 x16: 0000000000000000
> 	x15: ffffffffffffffff x14: 0720072007200720
> 	x13: 0720072007200720 x12: 0720072007200720
> 	x11: 0720072007200720 x10: 0720072007200720
> 	x9 : 0000000000000000 x8 : ffff000010a85000
> 	x7 : ffff000010114bd4 x6 : 0000000000000001
> 	x5 : 0000000000000018 x4 : 0000000000000001
> 	x3 : 0000000000000000 x2 : 0000000000000003
> 	x1 : ffff000010af17b0 x0 : 0000000000000000
> 	Call trace:
> 	 soc_find_component+0xb8/0xc0
> 	 soc_init_dai_link+0x18c/0x210
> 	 snd_soc_register_card.part.16+0x138/0x198
> 	 snd_soc_register_card+0x30/0x48
> 	 devm_snd_soc_register_card+0x4c/0xa0
> 	 graph_probe+0x2d8/0x388
> 	 platform_drv_probe+0x58/0xa8
> 	 really_probe+0x1c0/0x2a0
> 	 driver_probe_device+0x5c/0xf0
> 	 __device_attach_driver+0x9c/0xe0
> 	...

Regards,
Rohit
-- 
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the Linux Foundation.

