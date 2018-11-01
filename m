Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374A3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C64BC2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j4+fecVC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C64BC2064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeKAKKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:10:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36784 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbeKAKKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=sbSiP+7IfvcN1rU+9udeormbhDOssFxJcZdVdaYHY9I=; b=j4+fecVCxpp+LcaDWj6ry0y5S
        ykdQWZWPLyC4HIjT3nkjkUt50HmnWuVcXbfyXUG0Zb5fxlVt452CB1P09/RnWz7P676WYwtn/OdEP
        THFZFIqaobN3/xJDNHaNz7f/Xrki90XewzPL5LjWnPaU4+6uO9uKFb7BAthvOtyqC17SV1ihTE7H/
        eBEtsFwc1/MjgeZMszRs0AIVKxWfV3RXrQY4h2JinwKo5jWHbLHIRW//hBtlqbJZ1MIeDdNMxrAAI
        jN+Ws8J6ki6Na9qo5d59ZFbZRPDU6RZrIOrnIYvA4cg9vlOQ3mdIQaZLGYPEK8Q6/G6YcnA8F/wyS
        1z2nwb8zw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gI1UW-0005L3-Pw; Thu, 01 Nov 2018 01:09:45 +0000
Subject: Re: sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration
 of function 'pci_iomap'; did you mean 'pcim_iomap'?
To:     kbuild test robot <lkp@intel.com>,
        Rakesh Ughreja <rakesh.a.ughreja@intel.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Takashi Iwai <tiwai@suse.de>
References: <201811010830.FOhj3s1I%fengguang.wu@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <589ba4c8-ac8f-5828-500b-8df550b38218@infradead.org>
Date:   Wed, 31 Oct 2018 18:09:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <201811010830.FOhj3s1I%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/18 5:48 PM, kbuild test robot wrote:
> Hi Rakesh,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   5b7449810ae6d652629c550d3974c8453836d229
> commit: 6bae5ea9498926440ffc883f3dbceb0adc65e492 ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers
> date:   9 weeks ago
> config: sh-allyesconfig (attached as .config)
> compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6bae5ea9498926440ffc883f3dbceb0adc65e492
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=sh 

Hi lkp robot,

I have a (process) question:

Does the above mean that this build failed on 4.19-rc1 9 weeks ago and that
it still fails on 4.19-rc1?  Has this .config been tested on v4.19, e.g.?

I have tested this .config on v4.19 and don't see the build error that is
listed here (below).  This error happens because CONFIG_PCI is not enabled,
so pci_iomap() is not available.  The drivers in sound/pci/hda/ should not
be enabled since CONFIG_PCI is not enabled and indeed, in v4.19, after running
"make oldconfig", those drivers are not enabled, so the build error does not
happen.

None of these Kconfig symbols (from the attached .config file) is enabled
after running "make oldconfig":

CONFIG_SND_HDA=y
CONFIG_SND_HDA_HWDEP=y
CONFIG_SND_HDA_RECONFIG=y
CONFIG_SND_HDA_INPUT_BEEP=y
CONFIG_SND_HDA_INPUT_BEEP_MODE=1
CONFIG_SND_HDA_PATCH_LOADER=y
CONFIG_SND_HDA_CODEC_REALTEK=y
CONFIG_SND_HDA_CODEC_ANALOG=y
CONFIG_SND_HDA_CODEC_SIGMATEL=y
CONFIG_SND_HDA_CODEC_VIA=y
CONFIG_SND_HDA_CODEC_HDMI=y
CONFIG_SND_HDA_CODEC_CIRRUS=y
CONFIG_SND_HDA_CODEC_CONEXANT=y
CONFIG_SND_HDA_CODEC_CA0110=y
CONFIG_SND_HDA_CODEC_CA0132=y
CONFIG_SND_HDA_CODEC_CA0132_DSP=y
CONFIG_SND_HDA_CODEC_CMEDIA=y
CONFIG_SND_HDA_CODEC_SI3054=y
CONFIG_SND_HDA_GENERIC=y
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0

I conclude that someone has "fixed" the faulty Kconfig file(s) that caused this
problem and that it is no longer a problem.
Or I could be all mussed up.  :)

Thanks.


> All errors (new ones prefixed by >>):
> 
>    sound/pci/hda/patch_ca0132.c: In function 'patch_ca0132':
>>> sound/pci/hda/patch_ca0132.c:7650:20: error: implicit declaration of function 'pci_iomap'; did you mean 'pcim_iomap'? [-Werror=implicit-function-declaration]
>       spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
>                        ^~~~~~~~~
>                        pcim_iomap
>    sound/pci/hda/patch_ca0132.c:7650:18: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>       spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
>                      ^
>    cc1: some warnings being treated as errors
> 
> vim +7650 sound/pci/hda/patch_ca0132.c
> 
> d5c016b56 Gabriele Martino 2015-05-18  7581  
> 95c6e9cb7 Ian Minett       2011-06-15  7582  static int patch_ca0132(struct hda_codec *codec)
> 95c6e9cb7 Ian Minett       2011-06-15  7583  {
> 95c6e9cb7 Ian Minett       2011-06-15  7584  	struct ca0132_spec *spec;
> a73d511c4 Ian Minett       2012-12-20  7585  	int err;
> d5c016b56 Gabriele Martino 2015-05-18  7586  	const struct snd_pci_quirk *quirk;
> 95c6e9cb7 Ian Minett       2011-06-15  7587  
> 4e76a8833 Takashi Iwai     2014-02-25  7588  	codec_dbg(codec, "patch_ca0132\n");
> 95c6e9cb7 Ian Minett       2011-06-15  7589  
> 95c6e9cb7 Ian Minett       2011-06-15  7590  	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
> 95c6e9cb7 Ian Minett       2011-06-15  7591  	if (!spec)
> 95c6e9cb7 Ian Minett       2011-06-15  7592  		return -ENOMEM;
> 95c6e9cb7 Ian Minett       2011-06-15  7593  	codec->spec = spec;
> 993884f6a Chih-Chung Chang 2013-03-25  7594  	spec->codec = codec;
> 95c6e9cb7 Ian Minett       2011-06-15  7595  
> 225068ab2 Takashi Iwai     2015-05-29  7596  	codec->patch_ops = ca0132_patch_ops;
> 225068ab2 Takashi Iwai     2015-05-29  7597  	codec->pcm_format_first = 1;
> 225068ab2 Takashi Iwai     2015-05-29  7598  	codec->no_sticky_stream = 1;
> 225068ab2 Takashi Iwai     2015-05-29  7599  
> d5c016b56 Gabriele Martino 2015-05-18  7600  	/* Detect codec quirk */
> d5c016b56 Gabriele Martino 2015-05-18  7601  	quirk = snd_pci_quirk_lookup(codec->bus->pci, ca0132_quirks);
> d5c016b56 Gabriele Martino 2015-05-18  7602  	if (quirk)
> d5c016b56 Gabriele Martino 2015-05-18  7603  		spec->quirk = quirk->value;
> d5c016b56 Gabriele Martino 2015-05-18  7604  	else
> d5c016b56 Gabriele Martino 2015-05-18  7605  		spec->quirk = QUIRK_NONE;
> d5c016b56 Gabriele Martino 2015-05-18  7606  
> e24aa0a4c Takashi Iwai     2014-08-10  7607  	spec->dsp_state = DSP_DOWNLOAD_INIT;
> a7e76271b Ian Minett       2012-12-20  7608  	spec->num_mixers = 1;
> 017310fbe Connor McAdams   2018-05-08  7609  
> 017310fbe Connor McAdams   2018-05-08  7610  	/* Set which mixers each quirk uses. */
> 017310fbe Connor McAdams   2018-05-08  7611  	switch (spec->quirk) {
> 017310fbe Connor McAdams   2018-05-08  7612  	case QUIRK_SBZ:
> e25e34450 Connor McAdams   2018-08-08  7613  		spec->mixers[0] = desktop_mixer;
> 017310fbe Connor McAdams   2018-05-08  7614  		snd_hda_codec_set_name(codec, "Sound Blaster Z");
> 017310fbe Connor McAdams   2018-05-08  7615  		break;
> e25e34450 Connor McAdams   2018-08-08  7616  	case QUIRK_R3D:
> e25e34450 Connor McAdams   2018-08-08  7617  		spec->mixers[0] = desktop_mixer;
> e25e34450 Connor McAdams   2018-08-08  7618  		snd_hda_codec_set_name(codec, "Recon3D");
> e25e34450 Connor McAdams   2018-08-08  7619  		break;
> 017310fbe Connor McAdams   2018-05-08  7620  	case QUIRK_R3DI:
> 017310fbe Connor McAdams   2018-05-08  7621  		spec->mixers[0] = r3di_mixer;
> 017310fbe Connor McAdams   2018-05-08  7622  		snd_hda_codec_set_name(codec, "Recon3Di");
> 017310fbe Connor McAdams   2018-05-08  7623  		break;
> 017310fbe Connor McAdams   2018-05-08  7624  	default:
> a7e76271b Ian Minett       2012-12-20  7625  		spec->mixers[0] = ca0132_mixer;
> 017310fbe Connor McAdams   2018-05-08  7626  		break;
> 017310fbe Connor McAdams   2018-05-08  7627  	}
> a7e76271b Ian Minett       2012-12-20  7628  
> 08eca6b1f Connor McAdams   2018-08-08  7629  	/* Setup whether or not to use alt functions/controls/pci_mmio */
> 009b8f979 Connor McAdams   2018-05-08  7630  	switch (spec->quirk) {
> 009b8f979 Connor McAdams   2018-05-08  7631  	case QUIRK_SBZ:
> e42c7c731 Connor McAdams   2018-08-08  7632  	case QUIRK_R3D:
> 08eca6b1f Connor McAdams   2018-08-08  7633  		spec->use_alt_controls = true;
> 08eca6b1f Connor McAdams   2018-08-08  7634  		spec->use_alt_functions = true;
> 08eca6b1f Connor McAdams   2018-08-08  7635  		spec->use_pci_mmio = true;
> 08eca6b1f Connor McAdams   2018-08-08  7636  		break;
> 009b8f979 Connor McAdams   2018-05-08  7637  	case QUIRK_R3DI:
> 47cdf76e4 Connor McAdams   2018-05-08  7638  		spec->use_alt_controls = true;
> 009b8f979 Connor McAdams   2018-05-08  7639  		spec->use_alt_functions = true;
> 08eca6b1f Connor McAdams   2018-08-08  7640  		spec->use_pci_mmio = false;
> 009b8f979 Connor McAdams   2018-05-08  7641  		break;
> 009b8f979 Connor McAdams   2018-05-08  7642  	default:
> 47cdf76e4 Connor McAdams   2018-05-08  7643  		spec->use_alt_controls = false;
> 009b8f979 Connor McAdams   2018-05-08  7644  		spec->use_alt_functions = false;
> 08eca6b1f Connor McAdams   2018-08-08  7645  		spec->use_pci_mmio = false;
> 009b8f979 Connor McAdams   2018-05-08  7646  		break;
> 009b8f979 Connor McAdams   2018-05-08  7647  	}
> 009b8f979 Connor McAdams   2018-05-08  7648  
> 08eca6b1f Connor McAdams   2018-08-08  7649  	if (spec->use_pci_mmio) {
> 08eca6b1f Connor McAdams   2018-08-08 @7650  		spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
> 08eca6b1f Connor McAdams   2018-08-08  7651  		if (spec->mem_base == NULL) {
> 08eca6b1f Connor McAdams   2018-08-08  7652  			codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
> 08eca6b1f Connor McAdams   2018-08-08  7653  			spec->quirk = QUIRK_NONE;
> 08eca6b1f Connor McAdams   2018-08-08  7654  		}
> 08eca6b1f Connor McAdams   2018-08-08  7655  	}
> 08eca6b1f Connor McAdams   2018-08-08  7656  
> 5aaca44d8 Ian Minett       2012-12-20  7657  	spec->base_init_verbs = ca0132_base_init_verbs;
> 5aaca44d8 Ian Minett       2012-12-20  7658  	spec->base_exit_verbs = ca0132_base_exit_verbs;
> 5aaca44d8 Ian Minett       2012-12-20  7659  
> 993884f6a Chih-Chung Chang 2013-03-25  7660  	INIT_DELAYED_WORK(&spec->unsol_hp_work, ca0132_unsol_hp_delayed);
> 993884f6a Chih-Chung Chang 2013-03-25  7661  
> 95c6e9cb7 Ian Minett       2011-06-15  7662  	ca0132_init_chip(codec);
> 95c6e9cb7 Ian Minett       2011-06-15  7663  
> 95c6e9cb7 Ian Minett       2011-06-15  7664  	ca0132_config(codec);
> 95c6e9cb7 Ian Minett       2011-06-15  7665  
> d5c016b56 Gabriele Martino 2015-05-18  7666  	err = ca0132_prepare_verbs(codec);
> d5c016b56 Gabriele Martino 2015-05-18  7667  	if (err < 0)
> cc91ceaf3 Takashi Iwai     2017-09-04  7668  		goto error;
> d5c016b56 Gabriele Martino 2015-05-18  7669  
> a73d511c4 Ian Minett       2012-12-20  7670  	err = snd_hda_parse_pin_def_config(codec, &spec->autocfg, NULL);
> a73d511c4 Ian Minett       2012-12-20  7671  	if (err < 0)
> cc91ceaf3 Takashi Iwai     2017-09-04  7672  		goto error;
> a73d511c4 Ian Minett       2012-12-20  7673  
> 95c6e9cb7 Ian Minett       2011-06-15  7674  	return 0;
> cc91ceaf3 Takashi Iwai     2017-09-04  7675  
> cc91ceaf3 Takashi Iwai     2017-09-04  7676   error:
> cc91ceaf3 Takashi Iwai     2017-09-04  7677  	ca0132_free(codec);
> cc91ceaf3 Takashi Iwai     2017-09-04  7678  	return err;
> 95c6e9cb7 Ian Minett       2011-06-15  7679  }
> 95c6e9cb7 Ian Minett       2011-06-15  7680  
> 
> :::::: The code at line 7650 was first introduced by commit
> :::::: 08eca6b1f1468a4021bac7b3929fd3eb491e2629 ALSA: hda/ca0132 - Add bool variable to enable/disable pci region2 mmio
> 
> :::::: TO: Connor McAdams <conmanx360@gmail.com>
> :::::: CC: Takashi Iwai <tiwai@suse.de>


-- 
~Randy
