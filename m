Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92744C282C3
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273E217D4
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 02:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbfAWCBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 21:01:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:60351 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbfAWCBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 21:01:20 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 18:01:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,509,1539673200"; 
   d="scan'208,223";a="140471162"
Received: from ankitgu1-mobl1.amr.corp.intel.com (HELO [10.254.15.171]) ([10.254.15.171])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jan 2019 18:01:16 -0800
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Curtis Malainey <cujomalainey@google.com>
Cc:     rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        linux-kernel@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com,
        lgirdwood@gmail.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Matthias Reichl <hias@horus.com>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Mark Brown <broonie@kernel.org>,
        srinivas.kandagatla@linaro.org, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com>
 <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk>
 <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan>
 <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com>
 <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
 <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
 <c6721670-cf89-5d21-953d-c1fa10d87367@linux.intel.com>
 <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <44029078-2749-5a3b-7b03-f38461bf268f@linux.intel.com>
Date:   Tue, 22 Jan 2019 20:01:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAOReqxgG4TJDXKCEVcDVXvpi_mnLUzqLwF7Rp0H5iAPdbMuZ_Q@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------B0C56BB01237A674EAD19B5B"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------B0C56BB01237A674EAD19B5B
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit


On 1/22/19 7:36 PM, Curtis Malainey wrote:
> Curtis Malainey | Software Engineer | cujomalainey@google.com | 650-898-3849
>
>
> On Wed, Jan 23, 2019 at 4:11 AM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>> The issue was that we were seeing a memory corruption bug on an AMD
>>> chromebooks with that function already (not observed on Intel). I was
>>> testing some SOF integrations and was seeing this in the kernel logs.
>>> I had Dylan verify my logic before I sent the patch because it took so
>>> long to identify the bug and it was traced to the patch that introduce
>>> soc_init_platform.
>>>
>>> [   10.922112] cz-da7219-max98357a AMD7219:00: ASoC: CPU DAI
>>> designware-i2s.1.auto not registered
>>> [   10.922122] cz-da7219-max98357a AMD7219:00:
>>> devm_snd_soc_register_card(acpd7219m98357) failed: -517
>>> [   11.001411] cz-da7219-max98357a AMD7219:00: ASoC: Both platform
>>> name/of_node are set for amd-max98357-play
>>> [   11.001423] cz-da7219-max98357a AMD7219:00: ASoC: failed to init
>>> link amd-max98357-play
>>> [   11.001431] cz-da7219-max98357a AMD7219:00:
>>> devm_snd_soc_register_card(acpd7219m98357) failed: -22
>>> [   11.001577] cz-da7219-max98357a: probe of AMD7219:00 failed with error -22
>>>
>>> of_node was never getting set but the pointer was becoming populated
>>> (outside of the probe call) which traced to soc_init_platform function
>>> which was not reallocating memory on a EPROBE_DEFER even though it was
>>> getting freed by devm. I am not very familiar with devm but my local
>>> maintainers say that it should be freeing the memory even on a
>>> PROBE_DEFER.
>>> The patch should mirror the memory behaviour in
>>> snd_soc_init_multicodec which also reallocates its memory on every
>>> probe. I'm not sure how the patch is causing you to defer, is your
>>> component list corrupt?
>>>
>>> Sorry for the duplicate spam, forgot to send via plain text mode,
>>> re-sending for the mailing list so it gets accepted.
>> There is no defer issue with the intel stuff, but we call this routine
>> multiple times
>>
>> snd_soc_register_card
>>
>> --soc_init_dai_link
>>
>> ----snd_soc_init_platform
>>
>> -- soc_soc_bind_card
>>
>> ----snd_soc_instantiate_card
>>
>> ------ soc_check_tplg_fes
>>
>> -------- snd_soc_init_platform << ALLOC1
>>
>> --------soc_init_dai_link
>>
>> ----------snd_soc_init_platform << ALLOC2
>>
> Ah that explains it, in my testing I didn't have the patch that
> brought in the call from within tplg_fes
>> Initially dai_link->legacy_platform is 0, so gets set after the first
>> first devm_kzalloc (ALLOC1) and after that we always allocate new memory
>> (ALLOC2). The end result is that whatever we set in soc_check_tplg_fes
>> is lost with the new/unnecessary alloc.
>>
>> I would guess your solution is also a work-around, if devm_ effectively
>> freed the memory then the pointer would become NULL. Or may that's the
>> issue is that no one actually resets it.
>>
>>
> Yes, its a work around to fix the memory issue. If you set the
> platform in the machine driver the code will ignore it and not reset
> it. That being said that is not a full proof workaround and a better
> solution is definitely needed. We could go and clean up the pointers
> in soc_instantiate_card based on the flag being set. That way we only
> relocate on a NULL pointer like we used to but still don't affect
> statically allocated memory. I will draft a patch, test it on the AMD
> device, reply to this thread later with it, Pierre can you test it as
> well?
>
> I am curious why soc_check_tplg_fes is calling snd_soc_init_platform.
> It should have already been called earlier, in soc_init_dai_link at
> the beginning of snd_soc_register_card so the memory should already be
> initialized. Unless I am missing somewhere where links are getting
> added between the calls.

This is actually a second order problem, the main issue i have is that 
the very first call to init_dai_link fails with the new DEFER_PROBE 
handling.

I don't quite understand what Linaro/AMD folks are doing but I trust 
their changes are legitimate. To move forward, maybe it's not worth 
spending too much time on a grand unification of string theory, there 
are simpler solutions: the Intel machine drivers already do get the 
platform driver name as an platform_data argument, so we could modify 
the dailinks platform names before even registering the card. I tested 
with the attached proof-of-concept patch, it adds 2 lines of code per 
machine driver if we use a common helper (after the transition to the 
"modern" dailink representation that's needed anyways) so maybe it's 
better in the end? the override we care about is really the automatic 
handling of all the hard-coded front-ends, the platform-name override 
isn't really a battle i want to pick or spend time on.




--------------B0C56BB01237A674EAD19B5B
Content-Type: text/x-patch;
 name="0001-ASoC-add-helper-to-change-platform-name-for-all-dail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ASoC-add-helper-to-change-platform-name-for-all-dail.pa";
 filename*1="tch"

From 5680c64b09964b134e20bf96142d1ce5dcf0f77f Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Tue, 22 Jan 2019 18:53:43 -0600
Subject: [PATCH] ASoC: add helper to change platform name for all dailinks

To reuse the same machine drivers with Atom/SST, Skylake and SOF, we
need to change the default platform_name (or platforms->name in the
"modern" representation).

So far, this override was done with an automatic override, which was
broken by a set of changes for DT platforms related to deferred probe
handling.

This automatic override is actually not really needed, the machine
driver can already receive the platform name as a platform_data
parameter. This is used e.g. for HDaudio support where we have
different PCI aliases used for different platforms. We can reuse the
same mechanism and modify the machine drivers to override the dailinks
prior to registrating the card.

This will require additional work for SOF, but with this helper it'll
be just two lines of additional code per machine driver which is
reused, not the end of the world.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index b71b05019c68..59873084f3bd 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1583,6 +1583,29 @@ struct snd_soc_dai *snd_soc_card_get_codec_dai(struct snd_soc_card *card,
 	return NULL;
 }
 
+static inline
+int snd_soc_fixup_dai_links_platform_name(struct snd_soc_card *card,
+					  const char *platform_name)
+{
+	struct snd_soc_dai_link *dai_link;
+	int i;
+
+	if (!platform_name) /* nothing to do */
+		return 0;
+
+	/* set platform name for each dailink */
+	for_each_card_prelinks(card, i, dai_link) {
+		/* only single platform is supported for now */
+		dai_link->platforms->name = devm_kstrdup(card->dev,
+							 platform_name,
+							 GFP_KERNEL);
+		if (!dai_link->platforms->name)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *snd_soc_debugfs_root;
 #endif
-- 
2.17.1


--------------B0C56BB01237A674EAD19B5B--
