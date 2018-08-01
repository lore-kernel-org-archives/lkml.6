Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B42FC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 264E1208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 14:56:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 264E1208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389622AbeHAQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 12:42:08 -0400
Received: from mga18.intel.com ([134.134.136.126]:2429 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389256AbeHAQmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 12:42:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Aug 2018 07:56:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,432,1526367600"; 
   d="scan'208";a="76422426"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 01 Aug 2018 07:56:01 -0700
Received: from wljorns-mobl.amr.corp.intel.com (unknown [10.252.193.238])
        by linux.intel.com (Postfix) with ESMTP id 72A6E580335;
        Wed,  1 Aug 2018 07:56:00 -0700 (PDT)
Subject: Re: [alsa-devel] [PATCH 9/9] ALSA: intel_hdmi: remove redundant
 variable cfg_val
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org,
        Olivier Moysan <olivier.moysan@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        kernel-janitors@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Colin King <colin.king@canonical.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jaya Kumar <jayakumar.alsa@gmail.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-10-colin.king@canonical.com>
 <s5hin4unyh0.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <105efe0e-237e-dba0-3bfe-0f88b9ccd152@linux.intel.com>
Date:   Wed, 1 Aug 2018 07:55:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <s5hin4unyh0.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/18 4:00 AM, Takashi Iwai wrote:
> On Wed, 01 Aug 2018 12:47:42 +0200,
> Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Variable cfg_val is being assigned but is never used hence it is
>> redundant and can be removed.
>>
>> Cleans up clang warning:
>> warning: variable 'cfg_val' set but not used [-Wunused-but-set-variable]
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>   sound/x86/intel_hdmi_audio.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
>> index edc9f5a34eff..fa7dca5a68c8 100644
>> --- a/sound/x86/intel_hdmi_audio.c
>> +++ b/sound/x86/intel_hdmi_audio.c
>> @@ -290,7 +290,6 @@ static void had_reset_audio(struct snd_intelhad *intelhaddata)
>>   static int had_prog_status_reg(struct snd_pcm_substream *substream,
>>   			struct snd_intelhad *intelhaddata)
>>   {
>> -	union aud_cfg cfg_val = {.regval = 0};
>>   	union aud_ch_status_0 ch_stat0 = {.regval = 0};
>>   	union aud_ch_status_1 ch_stat1 = {.regval = 0};
>>   
>> @@ -298,7 +297,6 @@ static int had_prog_status_reg(struct snd_pcm_substream *substream,
>>   					  IEC958_AES0_NONAUDIO) >> 1;
>>   	ch_stat0.regx.clk_acc = (intelhaddata->aes_bits &
>>   					  IEC958_AES3_CON_CLOCK) >> 4;
>> -	cfg_val.regx.val_bit = ch_stat0.regx.lpcm_id;
> 
> Actually this made me wonder what is the definition of val_bit.
> It seems always 1 in the current code after the commit 964ca8083c02.
> Pierre?

I'll look into it, give me a couple of days. I vaguely remember this is 
the AES validity bit but I am not sure why it's set with a pcm id, looks 
like a mixup.
