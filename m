Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82B8C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7952081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7952081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388919AbeKGAFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:05:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:6844 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388754AbeKGAFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:05:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 06:39:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="105851507"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 06 Nov 2018 06:39:48 -0800
Received: from cjloo-mobl.amr.corp.intel.com (unknown [10.255.84.97])
        by linux.intel.com (Postfix) with ESMTP id D063A580384;
        Tue,  6 Nov 2018 06:39:46 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the
 dev memory API
To:     "He, Bo" <bo.he@intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Singh, Guneshwor O" <guneshwor.o.singh@intel.com>,
        "Periyasamy, SriramX" <sriramx.periyasamy@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        "Kesapragada, Pardha Saradhi" <pardha.saradhi.kesapragada@intel.com>,
        "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>,
        "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>,
        "Prakash, Divya1" <divya1.prakash@intel.com>,
        "Diwakar, Praveen" <praveen.diwakar@intel.com>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
References: <CD6925E8781EFD4D8E11882D20FC406D529FE3B6@SHSMSX104.ccr.corp.intel.com>
 <f2e3ffeb-12bd-d60e-e96a-8fa00a17844f@linux.intel.com>
 <CD6925E8781EFD4D8E11882D20FC406D529FE5A9@SHSMSX104.ccr.corp.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <c57e4dcf-7117-72f4-0e07-350a20120742@linux.intel.com>
Date:   Tue, 6 Nov 2018 08:39:46 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D529FE5A9@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18 6:58 PM, He, Bo wrote:
> Hi,
> 	I submit the patch based on tag v4.19.

Please don't post on mailing lists.

> 
> -----Original Message-----
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Sent: Tuesday, November 6, 2018 1:02 AM
> To: He, Bo <bo.he@intel.com>; alsa-devel@alsa-project.org; linux-kernel@vger.kernel.org
> Cc: liam.r.girdwood@linux.intel.com; perex@perex.cz; tiwai@suse.com; Singh, Guneshwor O <guneshwor.o.singh@intel.com>; Periyasamy, SriramX <sriramx.periyasamy@intel.com>; Kale, Sanyog R <sanyog.r.kale@intel.com>; Kesapragada, Pardha Saradhi <pardha.saradhi.kesapragada@intel.com>; kuninori.morimoto.gx@renesas.com; guruprasadx.pawse@intel.com; Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>; Prakash, Divya1 <divya1.prakash@intel.com>; Diwakar, Praveen <praveen.diwakar@intel.com>; Zhang, Yanmin <yanmin.zhang@intel.com>
> Subject: Re: [alsa-devel] [PATCH] fix the kernel panic due to wrong use the dev memory API
> 
> 
> On 11/5/18 2:29 AM, He, Bo wrote:
>> skl->dais is allocated with devm_kcalloc, can't free with
>> the krealloc. Memory allocated with devm API is automatically freed on
>> driver detach, Like all other devres resources.
>>
>> Refer to drivers/base/devres.c devm_kmalloc for more details.
> 
> What code are you looking at?
> 
> I see this in the Mark's tree
> 
> int skl_platform_register(struct device *dev) {
>       int ret;
>       struct snd_soc_dai_driver *dais;
>       int num_dais = ARRAY_SIZE(skl_platform_dai);
>       struct hdac_bus *bus = dev_get_drvdata(dev);
>       struct skl *skl = bus_to_skl(bus);
> 
>       INIT_LIST_HEAD(&skl->ppl_list);
>       INIT_LIST_HEAD(&skl->bind_list);
> 
>       skl->dais = kmemdup(skl_platform_dai, sizeof(skl_platform_dai),
>                   GFP_KERNEL);
>       if (!skl->dais) {
>           ret = -ENOMEM;
>           goto err;
>       }
> 
>       if (!skl->use_tplg_pcm) {
>           dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
>                   sizeof(skl_platform_dai), GFP_KERNEL);
> 
> 
> No trace of devm as you mention it? I checked the Chrome tree as well and it's not there.
> 
> What am I missing?

The code is completely identical in v4.19. skl->dais is allocated with 
kmemdup, which is a kmalloc+memcpy, i just don't understand what you are 
trying to fix.

> 
> 
>>
>> Signed-off-by: he, bo <bo.he@intel.com>
>> ---
>>    sound/soc/intel/skylake/skl-pcm.c | 5 ++---
>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/sound/soc/intel/skylake/skl-pcm.c
>> b/sound/soc/intel/skylake/skl-pcm.c
>> index 823e391..928d314 100644
>> --- a/sound/soc/intel/skylake/skl-pcm.c
>> +++ b/sound/soc/intel/skylake/skl-pcm.c
>> @@ -1438,7 +1438,8 @@ int skl_platform_register(struct device *dev)
>>    	}
>>    
>>    	if (!skl->use_tplg_pcm) {
>> -		dais = krealloc(skl->dais, sizeof(skl_fe_dai) +
>> +		devm_kfree(dev, skl->dais);
>> +		dais = devm_kcalloc(dev, skl->dais, sizeof(skl_fe_dai) +
>>    				sizeof(skl_platform_dai), GFP_KERNEL);
>>    		if (!dais) {
>>    			ret = -ENOMEM;
>> @@ -1472,7 +1473,5 @@ int skl_platform_unregister(struct device *dev)
>>    		}
>>    	}
>>    
>> -	kfree(skl->dais);
>> -
>>    	return 0;
>>    }

