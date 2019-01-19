Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1D5C5AE5E
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D05F20883
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PFvPk6ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730308AbfASBPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:15:46 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37438 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbfASBPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:15:46 -0500
Received: by mail-lj1-f193.google.com with SMTP id t18-v6so13151263ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ai/3EqVwjKdKihIaDWbiezFneEQ02hmxK1pG86MT2l0=;
        b=PFvPk6ONsHcHb3GlkWx5ex5JGr5p/x3q8dB6aq+im8gWbekS03kCkgmfP/He+lQm8E
         amdV2/lJieqCrtiWVevdi/ExgTRAMlcbAHupjB/hlPHsMkTAtmHx7xIMqzzSVvHmhViw
         d78vn1UaCKADfyShBlPwvGQN0p4g0uqraXVTBDVMD2aM4Ni4uMlUuaBFaFj0yRSRa72Y
         0kOXf9wPI94+z/gwExfM/fq4DK/J6pE2tib1MteQYuDG/+85GuNgp6pZE2Wt8sHkTwHT
         IfTgDbHISxCs4B/8Ha8wEwIK21f9pJlZ1cnTF1pP6l4+OAkhYvFW/F4bMfjLEV3bpRaS
         X4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ai/3EqVwjKdKihIaDWbiezFneEQ02hmxK1pG86MT2l0=;
        b=CVF/2X9Pe5lJDbluJTf4JjAbP6uab6+hasM7Vr94MvMj1ezVs4cIoM/+54MjU+NP/z
         uog7W+E1Jl+c6uiYx6Qh0lrW9gefvkKsp2Tqj7kB0RQzb1iRTCN67mLGPsYj/ouuXOsn
         8ZRYjQsSS9ueiQzGb35GoihH07Ghkl4cJFg06QTAHtGRWIvc+sGGIpXAjSePh35HCOKq
         nUZ6xd+L7XdUJD/NSBNRNewC9jOBjyTMIsoburJpxSuZ25ZBsNXBC7Ls51Tz8HgnD0Yg
         4FV1oBFjG3poyjhsYz5WntgiDAWjA68Q2M0zdY8YQbO7FSL3BoHtay9+TJxp7yuXweGI
         CnnQ==
X-Gm-Message-State: AJcUukeBBMW9Puy+24OdGdSzt92WfBerF6P4EGiMlPti/ggdvg8Xt9Ty
        ZN9UxqEFjhvrpa0bjwd+5RqyNKsRiXeSfmsLvIK0fA==
X-Google-Smtp-Source: ALg8bN67QLb6geepsm0d/M3abM8HkKoOmaPrujJJ2Ti+MN1AIVWwjFtnwjr2InlTp7v/7ySoOIbflTPsDbOdvwGeiyY=
X-Received: by 2002:a2e:9c7:: with SMTP id 190-v6mr12247520ljj.120.1547860543446;
 Fri, 18 Jan 2019 17:15:43 -0800 (PST)
MIME-Version: 1.0
References: <1547194442-1487-1-git-send-email-rohitkr@codeaurora.org>
 <d8726e9a-3477-a573-8c1a-dd8245068802@linux.intel.com> <4886ed21-65d2-159d-afcd-bb26dcde636e@linux.intel.com>
 <20190115000610.GM11073@sirena.org.uk> <796a856c-a9a6-022d-da63-947279090198@linux.intel.com>
 <20190115211137.rhdyjadu7fppp3p4@lenny.lan> <af2e9555-444f-7c40-865b-347f3db8fa76@linux.intel.com>
 <044d59ba-094e-727d-14a9-6ebfc54cbbf4@linux.intel.com> <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
In-Reply-To: <CAOReqxjhZAzOpr-bGcV6uxPsOEid--Ym2Y0YZMHkybgZSePvtQ@mail.gmail.com>
From:   Curtis Malainey <cujomalainey@google.com>
Date:   Fri, 18 Jan 2019 17:15:32 -0800
Message-ID: <CAOReqxjLcdN6rT9w3_6MJaqE-hpiCsZ+3Luic+e793GwPde+Qg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: soc-core: Fix null pointer dereference
 in soc_find_component
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Matthias Reichl <hias@horus.com>, Mark Brown <broonie@kernel.org>,
        rohkumar@qti.qualcomm.com, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, vinod.koul@linaro.org,
        lgirdwood@gmail.com, plai@codeaurora.org,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        srinivas.kandagatla@linaro.org,
        Rohit kumar <rohitkr@codeaurora.org>, asishb@codeaurora.org,
        Ajit Pandey <ajitp@codeaurora.org>,
        Curtis Malainey <cujomalainey@chromium.org>,
        Dylan Reid <dgreid@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 5:12 PM Curtis Malainey <cujomalainey@google.com> wrote:
>
>
>
> On Fri, Jan 18, 2019 at 3:02 PM Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> wrote:
>>
>>
>> On 1/15/19 3:16 PM, Pierre-Louis Bossart wrote:
>> >
>> >>> Beyond the fact that the platform_name seems to be totally useless,
>> >>> additional tests show that the patch ('ASoC: soc-core: defer card probe
>> >>> until all component is added to list') adds a new restriction which
>> >>> contradicts existing error checks.
>> >>>
>> >>> None of the Intel machine drivers set the dailink "cpu_name" field
>> >>> but use
>> >>> the "cpu_dai_name" field instead. This was perfectly legit as
>> >>> documented by
>> >>> the code at the end of soc_init_dai_link()
>> >> This should be fixed by the patch
>> >> "ASoC: core: Don't defer probe on optional, NULL components" which Mark
>> >> already applied to his tree. See
>> >> http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144323.html
>> >>
>> >
>> > Ah yes, I missed this patch while I was debugging. Indeed this fixes
>> > the problem and my devices work again with Mark's for-next branch.
>> > Thanks Matthias!
>>
>> This PROBE_DEFER support actually breaks the topology override that
>> we've been relying on for SOF (and which has been in Mark's branch for
>> some time now). This override helps us reuse machine drivers between
>> legacy and SOF-based solutions.
>>
>> With the current code, the tests in soc_register_card() complain that
>> the platform_name can't be tied to a component and stop the card
>> registration, but that's mainly because the tests are done before the
>> topology overrides are done in soc_check_tplg_fes(). Moving
>> soc_check_tplg_fes() from soc_instantiate_card() to an earlier time in
>> soc_register_card() works-around the problem but looks quite invasive
>> (mutex lock, etc).
>>
>> There is also a second problem where we seem to have a memory management
>> issue root caused to the change in snd_soc_init_platform() added by
>> 09ac6a817bd6 ('ASoC: soc-core: fix init platform memory handling')
>>
>> The code does this
>>
>> static int snd_soc_init_platform(struct snd_soc_card *card,
>>                   struct snd_soc_dai_link *dai_link)
>> {
>>      struct snd_soc_dai_link_component *platform = dai_link->platform;
>>
>>
>>      /* convert Legacy platform link */
>>      if (!platform || dai_link->legacy_platform) {
>>          platform = devm_kzalloc(card->dev,
>>                  sizeof(struct snd_soc_dai_link_component),
>>                  GFP_KERNEL);
>>          if (!platform)
>>              return -ENOMEM;
>>
>>          dai_link->platform      = platform;
>>          dai_link->legacy_platform = 1;
>>
>> This last assignment guarantees that memory will be allocated every time
>> this function is called, and whatever overrides are done later will
>> themselves be overridden by the new allocation. I am not sure what the
>> intent was here, Curtis can you please double-check?
>>
The issue was that we were seeing a memory corruption bug on an AMD
chromebooks with that function already (not observed on Intel). I was
testing some SOF integrations and was seeing this in the kernel logs.
I had Dylan verify my logic before I sent the patch because it took so
long to identify the bug and it was traced to the patch that introduce
soc_init_platform.

[   10.922112] cz-da7219-max98357a AMD7219:00: ASoC: CPU DAI
designware-i2s.1.auto not registered
[   10.922122] cz-da7219-max98357a AMD7219:00:
devm_snd_soc_register_card(acpd7219m98357) failed: -517
[   11.001411] cz-da7219-max98357a AMD7219:00: ASoC: Both platform
name/of_node are set for amd-max98357-play
[   11.001423] cz-da7219-max98357a AMD7219:00: ASoC: failed to init
link amd-max98357-play
[   11.001431] cz-da7219-max98357a AMD7219:00:
devm_snd_soc_register_card(acpd7219m98357) failed: -22
[   11.001577] cz-da7219-max98357a: probe of AMD7219:00 failed with error -22

of_node was never getting set but the pointer was becoming populated
(outside of the probe call) which traced to soc_init_platform function
which was not reallocating memory on a EPROBE_DEFER even though it was
getting freed by devm. I am not very familiar with devm but my local
maintainers say that it should be freeing the memory even on a
PROBE_DEFER.
The patch should mirror the memory behaviour in
snd_soc_init_multicodec which also reallocates its memory on every
probe. I'm not sure how the patch is causing you to defer, is your
component list corrupt?

Sorry for the duplicate spam, forgot to send via plain text mode,
re-sending for the mailing list so it gets accepted.
>
>> Details, test code and logs are available here:
>> https://github.com/thesofproject/linux/issues/565
>>
>> Have a nice week-end everyone, that's it for me until Tuesday.
>>
>> -Pierre
>>
>>
>>
