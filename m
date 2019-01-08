Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 607EE2173C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 05:55:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfAHFzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 00:55:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:29566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbfAHFzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 00:55:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jan 2019 21:55:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,453,1539673200"; 
   d="gz'50?scan'50,208,50";a="309909186"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 07 Jan 2019 21:55:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ggkLt-0000Wv-Bp; Tue, 08 Jan 2019 13:55:01 +0800
Date:   Tue, 8 Jan 2019 13:54:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     kbuild-all@01.org, Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        James Cameron <quozl@laptop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, x86@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH v3 04/16] Platform: OLPC: Move OLPC config symbol out of
 x86 tree
Message-ID: <201901081318.SlxJVtvv%fengguang.wu@intel.com>
References: <20190107183439.50626-5-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20190107183439.50626-5-lkundrak@v3.sk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lubomir,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.0-rc1 next-20190107]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Lubomir-Rintel/Add-support-for-OLPC-XO-1-75-Embedded-Controller/20190108-114514
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

>> sound/pci/cs5535audio/cs5535audio_olpc.c:28:6: error: redefinition of 'olpc_analog_input'
    void olpc_analog_input(struct snd_ac97 *ac97, int on)
         ^~~~~~~~~~~~~~~~~
   In file included from sound/pci/cs5535audio/cs5535audio_olpc.c:19:0:
   sound/pci/cs5535audio/cs5535audio.h:131:20: note: previous definition of 'olpc_analog_input' was here
    static inline void olpc_analog_input(struct snd_ac97 *ac97, int on) { }
                       ^~~~~~~~~~~~~~~~~
>> sound/pci/cs5535audio/cs5535audio_olpc.c:51:6: error: redefinition of 'olpc_mic_bias'
    void olpc_mic_bias(struct snd_ac97 *ac97, int on)
         ^~~~~~~~~~~~~
   In file included from sound/pci/cs5535audio/cs5535audio_olpc.c:19:0:
   sound/pci/cs5535audio/cs5535audio.h:132:20: note: previous definition of 'olpc_mic_bias' was here
    static inline void olpc_mic_bias(struct snd_ac97 *ac97, int on) { }
                       ^~~~~~~~~~~~~
>> sound/pci/cs5535audio/cs5535audio_olpc.c:137:6: error: redefinition of 'olpc_prequirks'
    void olpc_prequirks(struct snd_card *card,
         ^~~~~~~~~~~~~~
   In file included from sound/pci/cs5535audio/cs5535audio_olpc.c:19:0:
   sound/pci/cs5535audio/cs5535audio.h:124:20: note: previous definition of 'olpc_prequirks' was here
    static inline void olpc_prequirks(struct snd_card *card,
                       ^~~~~~~~~~~~~~
   sound/pci/cs5535audio/cs5535audio_olpc.c: In function 'olpc_prequirks':
>> sound/pci/cs5535audio/cs5535audio_olpc.c:144:6: error: implicit declaration of function 'olpc_board_at_least' [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board_pre(0xb3)))
         ^~~~~~~~~~~~~~~~~~~
>> sound/pci/cs5535audio/cs5535audio_olpc.c:144:26: error: implicit declaration of function 'olpc_board_pre'; did you mean 'olpc_mic_put'? [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board_pre(0xb3)))
                             ^~~~~~~~~~~~~~
                             olpc_mic_put
   sound/pci/cs5535audio/cs5535audio_olpc.c: At top level:
>> sound/pci/cs5535audio/cs5535audio_olpc.c:148:5: error: redefinition of 'olpc_quirks'
    int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
        ^~~~~~~~~~~
   In file included from sound/pci/cs5535audio/cs5535audio_olpc.c:19:0:
   sound/pci/cs5535audio/cs5535audio.h:126:19: note: previous definition of 'olpc_quirks' was here
    static inline int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
                      ^~~~~~~~~~~
>> sound/pci/cs5535audio/cs5535audio_olpc.c:189:6: error: redefinition of 'olpc_quirks_cleanup'
    void olpc_quirks_cleanup(void)
         ^~~~~~~~~~~~~~~~~~~
   In file included from sound/pci/cs5535audio/cs5535audio_olpc.c:19:0:
   sound/pci/cs5535audio/cs5535audio.h:130:20: note: previous definition of 'olpc_quirks_cleanup' was here
    static inline void olpc_quirks_cleanup(void) { }
                       ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/export.h:45:0,
                    from include/linux/linkage.h:7,
                    from include/linux/kernel.h:7,
                    from drivers/staging/olpc_dcon/olpc_dcon.c:13:
   drivers/staging/olpc_dcon/olpc_dcon.c: In function 'dcon_bus_stabilize':
>> drivers/staging/olpc_dcon/olpc_dcon.c:141:10: error: implicit declaration of function 'olpc_board_at_least' [-Werror=implicit-function-declaration]
      BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
             ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
>> drivers/staging/olpc_dcon/olpc_dcon.c:141:3: note: in expansion of macro 'BUG_ON'
      BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
      ^~~~~~
>> drivers/staging/olpc_dcon/olpc_dcon.c:141:30: error: implicit declaration of function 'olpc_board'; did you mean 'olpc_ec_cmd'? [-Werror=implicit-function-declaration]
      BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
                                 ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
>> drivers/staging/olpc_dcon/olpc_dcon.c:141:3: note: in expansion of macro 'BUG_ON'
      BUG_ON(olpc_board_at_least(olpc_board(0xc2)));
      ^~~~~~
   cc1: some warnings being treated as errors
--
   arch/x86/platform/olpc/olpc-xo15-sci.c: In function 'process_sci_queue':
>> arch/x86/platform/olpc/olpc-xo15-sci.c:106:7: error: implicit declaration of function 'olpc_ec_sci_query'; did you mean 'process_sci_queue'? [-Werror=implicit-function-declaration]
      r = olpc_ec_sci_query(&data);
          ^~~~~~~~~~~~~~~~~
          process_sci_queue
   arch/x86/platform/olpc/olpc-xo15-sci.c: In function 'xo15_sci_add':
>> arch/x86/platform/olpc/olpc-xo15-sci.c:174:2: error: implicit declaration of function 'olpc_ec_mask_write'; did you mean 'olpc_ec_wakeup_set'? [-Werror=implicit-function-declaration]
     olpc_ec_mask_write(EC_SCI_SRC_ALL);
     ^~~~~~~~~~~~~~~~~~
     olpc_ec_wakeup_set
   cc1: some warnings being treated as errors
--
   arch/x86/platform/olpc/olpc.c:189:6: error: redefinition of 'olpc_ec_wakeup_set'
    void olpc_ec_wakeup_set(u16 value)
         ^~~~~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc.c:27:0:
   arch/x86/include/asm/olpc.h:86:20: note: previous definition of 'olpc_ec_wakeup_set' was here
    static inline void olpc_ec_wakeup_set(u16 value) { }
                       ^~~~~~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc.c:195:6: error: redefinition of 'olpc_ec_wakeup_clear'
    void olpc_ec_wakeup_clear(u16 value)
         ^~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc.c:27:0:
   arch/x86/include/asm/olpc.h:87:20: note: previous definition of 'olpc_ec_wakeup_clear' was here
    static inline void olpc_ec_wakeup_clear(u16 value) { }
                       ^~~~~~~~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc.c:205:6: error: redefinition of 'olpc_ec_wakeup_available'
    bool olpc_ec_wakeup_available(void)
         ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc.c:27:0:
   arch/x86/include/asm/olpc.h:89:20: note: previous definition of 'olpc_ec_wakeup_available' was here
    static inline bool olpc_ec_wakeup_available(void)
                       ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc.c: In function 'olpc_ec_wakeup_available':
>> arch/x86/platform/olpc/olpc.c:224:37: error: implicit declaration of function 'olpc_board_pre' [-Werror=implicit-function-declaration]
     if (olpc_platform_info.boardrev >= olpc_board_pre(0xd0)) /* XO-1.5 */
                                        ^~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc.c: In function 'olpc_init':
>> arch/x86/platform/olpc/olpc.c:377:7: error: implicit declaration of function 'olpc_ofw_present'; did you mean 'olpc_ofw_detect'? [-Werror=implicit-function-declaration]
     if (!olpc_ofw_present() || !platform_detect())
          ^~~~~~~~~~~~~~~~
          olpc_ofw_detect
>> arch/x86/platform/olpc/olpc.c:382:3: error: implicit declaration of function 'olpc_ec_driver_register'; did you mean 'platform_driver_register'? [-Werror=implicit-function-declaration]
      olpc_ec_driver_register(&ec_xo1_driver, NULL);
      ^~~~~~~~~~~~~~~~~~~~~~~
      platform_driver_register
>> arch/x86/platform/olpc/olpc.c:388:6: error: implicit declaration of function 'olpc_board_at_least' [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board(0xb1)))
         ^~~~~~~~~~~~~~~~~~~
>> arch/x86/platform/olpc/olpc.c:388:26: error: implicit declaration of function 'olpc_board'; did you mean 'olpc_init'? [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board(0xb1)))
                             ^~~~~~~~~~
                             olpc_init
   arch/x86/platform/olpc/olpc.c: At top level:
>> arch/x86/platform/olpc/olpc.c:408:1: warning: data definition has no type or storage class
    postcore_initcall(olpc_init);
    ^~~~~~~~~~~~~~~~~
>> arch/x86/platform/olpc/olpc.c:408:1: error: type defaults to 'int' in declaration of 'postcore_initcall' [-Werror=implicit-int]
>> arch/x86/platform/olpc/olpc.c:408:1: warning: parameter names (without types) in function declaration
   arch/x86/platform/olpc/olpc.c:373:19: warning: 'olpc_init' defined but not used [-Wunused-function]
    static int __init olpc_init(void)
                      ^~~~~~~~~
   arch/x86/platform/olpc/olpc.c:42:19: warning: 'olpc_ec_timeout_set' defined but not used [-Wunused-function]
    static int __init olpc_ec_timeout_set(char *str)
                      ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
>> arch/x86/platform/olpc/olpc_ofw.c:23:13: error: redefinition of 'setup_olpc_ofw_pgd'
    void __init setup_olpc_ofw_pgd(void)
                ^~~~~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc_ofw.c:11:0:
   arch/x86/include/asm/olpc_ofw.h:34:20: note: previous definition of 'setup_olpc_ofw_pgd' was here
    static inline void setup_olpc_ofw_pgd(void) { }
                       ^~~~~~~~~~~~~~~~~~
>> arch/x86/platform/olpc/olpc_ofw.c:92:13: error: redefinition of 'olpc_ofw_detect'
    void __init olpc_ofw_detect(void)
                ^~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc_ofw.c:11:0:
   arch/x86/include/asm/olpc_ofw.h:33:20: note: previous definition of 'olpc_ofw_detect' was here
    static inline void olpc_ofw_detect(void) { }
                       ^~~~~~~~~~~~~~~
--
   arch/x86/platform/olpc/olpc_dt.c: In function 'olpc_dt_getsibling':
>> arch/x86/platform/olpc/olpc_dt.c:34:6: error: implicit declaration of function 'olpc_ofw' [-Werror=implicit-function-declaration]
     if (olpc_ofw("peer", args, res) || (s32)node == -1)
         ^~~~~~~~
   arch/x86/platform/olpc/olpc_dt.c: In function 'olpc_dt_fixup':
>> arch/x86/platform/olpc/olpc_dt.c:250:19: error: implicit declaration of function 'olpc_board_pre' [-Werror=implicit-function-declaration]
     if (board_rev >= olpc_board_pre(0xd0)) {
                      ^~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc_dt.c: At top level:
>> arch/x86/platform/olpc/olpc_dt.c:268:13: error: redefinition of 'olpc_dt_build_devicetree'
    void __init olpc_dt_build_devicetree(void)
                ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/platform/olpc/olpc_dt.c:24:0:
   arch/x86/include/asm/olpc_ofw.h:35:20: note: previous definition of 'olpc_dt_build_devicetree' was here
    static inline void olpc_dt_build_devicetree(void) { }
                       ^~~~~~~~~~~~~~~~~~~~~~~~
   arch/x86/platform/olpc/olpc_dt.c: In function 'olpc_dt_build_devicetree':
>> arch/x86/platform/olpc/olpc_dt.c:272:7: error: implicit declaration of function 'olpc_ofw_is_installed' [-Werror=implicit-function-declaration]
     if (!olpc_ofw_is_installed())
          ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   drivers/input/mouse/hgpk.c: In function 'hgpk_reconnect':
>> drivers/input/mouse/hgpk.c:763:6: error: implicit declaration of function 'olpc_board_at_least' [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board(0xb2)))
         ^~~~~~~~~~~~~~~~~~~
>> drivers/input/mouse/hgpk.c:763:26: error: implicit declaration of function 'olpc_board'; did you mean 'Elf_Word'? [-Werror=implicit-function-declaration]
     if (olpc_board_at_least(olpc_board(0xb2)))
                             ^~~~~~~~~~
                             Elf_Word
   cc1: some warnings being treated as errors

vim +/olpc_analog_input +28 sound/pci/cs5535audio/cs5535audio_olpc.c

c8974be546 Jordan Crouse  2008-11-06   17  
c8974be546 Jordan Crouse  2008-11-06   18  #include <asm/olpc.h>
57d4bf6d8e Jaya Kumar     2008-11-06  @19  #include "cs5535audio.h"
57d4bf6d8e Jaya Kumar     2008-11-06   20  
3c55494670 Andres Salomon 2009-12-14   21  #define DRV_NAME "cs5535audio-olpc"
3c55494670 Andres Salomon 2009-12-14   22  
d6276b7802 Andres Salomon 2008-11-06   23  /*
d6276b7802 Andres Salomon 2008-11-06   24   * OLPC has an additional feature on top of the regular AD1888 codec features.
d6276b7802 Andres Salomon 2008-11-06   25   * It has an Analog Input mode that is switched into (after disabling the
d6276b7802 Andres Salomon 2008-11-06   26   * High Pass Filter) via GPIO.  It is supported on B2 and later models.
d6276b7802 Andres Salomon 2008-11-06   27   */
d6276b7802 Andres Salomon 2008-11-06  @28  void olpc_analog_input(struct snd_ac97 *ac97, int on)
d6276b7802 Andres Salomon 2008-11-06   29  {
d6276b7802 Andres Salomon 2008-11-06   30  	int err;
d6276b7802 Andres Salomon 2008-11-06   31  
0fb497f5b6 Andres Salomon 2008-11-06   32  	if (!machine_is_olpc())
0fb497f5b6 Andres Salomon 2008-11-06   33  		return;
0fb497f5b6 Andres Salomon 2008-11-06   34  
d6276b7802 Andres Salomon 2008-11-06   35  	/* update the High Pass Filter (via AC97_AD_TEST2) */
d6276b7802 Andres Salomon 2008-11-06   36  	err = snd_ac97_update_bits(ac97, AC97_AD_TEST2,
d6276b7802 Andres Salomon 2008-11-06   37  			1 << AC97_AD_HPFD_SHIFT, on << AC97_AD_HPFD_SHIFT);
d6276b7802 Andres Salomon 2008-11-06   38  	if (err < 0) {
00980aa9c7 Takashi Iwai   2014-02-25   39  		dev_err(ac97->bus->card->dev,
00980aa9c7 Takashi Iwai   2014-02-25   40  			"setting High Pass Filter - %d\n", err);
d6276b7802 Andres Salomon 2008-11-06   41  		return;
d6276b7802 Andres Salomon 2008-11-06   42  	}
d6276b7802 Andres Salomon 2008-11-06   43  
d6276b7802 Andres Salomon 2008-11-06   44  	/* set Analog Input through GPIO */
3c55494670 Andres Salomon 2009-12-14   45  	gpio_set_value(OLPC_GPIO_MIC_AC, on);
d6276b7802 Andres Salomon 2008-11-06   46  }
57d4bf6d8e Jaya Kumar     2008-11-06   47  
bf1e527835 Andres Salomon 2008-11-06   48  /*
bf1e527835 Andres Salomon 2008-11-06   49   * OLPC XO-1's V_REFOUT is a mic bias enable.
bf1e527835 Andres Salomon 2008-11-06   50   */
bf1e527835 Andres Salomon 2008-11-06  @51  void olpc_mic_bias(struct snd_ac97 *ac97, int on)
bf1e527835 Andres Salomon 2008-11-06   52  {
bf1e527835 Andres Salomon 2008-11-06   53  	int err;
bf1e527835 Andres Salomon 2008-11-06   54  
0fb497f5b6 Andres Salomon 2008-11-06   55  	if (!machine_is_olpc())
0fb497f5b6 Andres Salomon 2008-11-06   56  		return;
0fb497f5b6 Andres Salomon 2008-11-06   57  
bf1e527835 Andres Salomon 2008-11-06   58  	on = on ? 0 : 1;
bf1e527835 Andres Salomon 2008-11-06   59  	err = snd_ac97_update_bits(ac97, AC97_AD_MISC,
bf1e527835 Andres Salomon 2008-11-06   60  			1 << AC97_AD_VREFD_SHIFT, on << AC97_AD_VREFD_SHIFT);
bf1e527835 Andres Salomon 2008-11-06   61  	if (err < 0)
00980aa9c7 Takashi Iwai   2014-02-25   62  		dev_err(ac97->bus->card->dev, "setting MIC Bias - %d\n", err);
bf1e527835 Andres Salomon 2008-11-06   63  }
bf1e527835 Andres Salomon 2008-11-06   64  
466ae3055b Andres Salomon 2008-11-06   65  static int olpc_dc_info(struct snd_kcontrol *kctl,
57d4bf6d8e Jaya Kumar     2008-11-06   66  		struct snd_ctl_elem_info *uinfo)
57d4bf6d8e Jaya Kumar     2008-11-06   67  {
57d4bf6d8e Jaya Kumar     2008-11-06   68  	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
57d4bf6d8e Jaya Kumar     2008-11-06   69  	uinfo->count = 1;
57d4bf6d8e Jaya Kumar     2008-11-06   70  	uinfo->value.integer.min = 0;
57d4bf6d8e Jaya Kumar     2008-11-06   71  	uinfo->value.integer.max = 1;
57d4bf6d8e Jaya Kumar     2008-11-06   72  	return 0;
57d4bf6d8e Jaya Kumar     2008-11-06   73  }
57d4bf6d8e Jaya Kumar     2008-11-06   74  
466ae3055b Andres Salomon 2008-11-06   75  static int olpc_dc_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *v)
57d4bf6d8e Jaya Kumar     2008-11-06   76  {
3c55494670 Andres Salomon 2009-12-14   77  	v->value.integer.value[0] = gpio_get_value(OLPC_GPIO_MIC_AC);
57d4bf6d8e Jaya Kumar     2008-11-06   78  	return 0;
57d4bf6d8e Jaya Kumar     2008-11-06   79  }
57d4bf6d8e Jaya Kumar     2008-11-06   80  
466ae3055b Andres Salomon 2008-11-06   81  static int olpc_dc_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *v)
57d4bf6d8e Jaya Kumar     2008-11-06   82  {
466ae3055b Andres Salomon 2008-11-06   83  	struct cs5535audio *cs5535au = snd_kcontrol_chip(kctl);
57d4bf6d8e Jaya Kumar     2008-11-06   84  
466ae3055b Andres Salomon 2008-11-06   85  	olpc_analog_input(cs5535au->ac97, v->value.integer.value[0]);
57d4bf6d8e Jaya Kumar     2008-11-06   86  	return 1;
57d4bf6d8e Jaya Kumar     2008-11-06   87  }
57d4bf6d8e Jaya Kumar     2008-11-06   88  
bf1e527835 Andres Salomon 2008-11-06   89  static int olpc_mic_info(struct snd_kcontrol *kctl,
bf1e527835 Andres Salomon 2008-11-06   90  		struct snd_ctl_elem_info *uinfo)
bf1e527835 Andres Salomon 2008-11-06   91  {
bf1e527835 Andres Salomon 2008-11-06   92  	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
bf1e527835 Andres Salomon 2008-11-06   93  	uinfo->count = 1;
bf1e527835 Andres Salomon 2008-11-06   94  	uinfo->value.integer.min = 0;
bf1e527835 Andres Salomon 2008-11-06   95  	uinfo->value.integer.max = 1;
bf1e527835 Andres Salomon 2008-11-06   96  	return 0;
bf1e527835 Andres Salomon 2008-11-06   97  }
bf1e527835 Andres Salomon 2008-11-06   98  
bf1e527835 Andres Salomon 2008-11-06   99  static int olpc_mic_get(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *v)
bf1e527835 Andres Salomon 2008-11-06  100  {
bf1e527835 Andres Salomon 2008-11-06  101  	struct cs5535audio *cs5535au = snd_kcontrol_chip(kctl);
bf1e527835 Andres Salomon 2008-11-06  102  	struct snd_ac97 *ac97 = cs5535au->ac97;
bf1e527835 Andres Salomon 2008-11-06  103  	int i;
bf1e527835 Andres Salomon 2008-11-06  104  
bf1e527835 Andres Salomon 2008-11-06  105  	i = (snd_ac97_read(ac97, AC97_AD_MISC) >> AC97_AD_VREFD_SHIFT) & 0x1;
bf1e527835 Andres Salomon 2008-11-06  106  	v->value.integer.value[0] = i ? 0 : 1;
bf1e527835 Andres Salomon 2008-11-06  107  	return 0;
bf1e527835 Andres Salomon 2008-11-06  108  }
bf1e527835 Andres Salomon 2008-11-06  109  
bf1e527835 Andres Salomon 2008-11-06  110  static int olpc_mic_put(struct snd_kcontrol *kctl, struct snd_ctl_elem_value *v)
bf1e527835 Andres Salomon 2008-11-06  111  {
bf1e527835 Andres Salomon 2008-11-06  112  	struct cs5535audio *cs5535au = snd_kcontrol_chip(kctl);
bf1e527835 Andres Salomon 2008-11-06  113  
bf1e527835 Andres Salomon 2008-11-06  114  	olpc_mic_bias(cs5535au->ac97, v->value.integer.value[0]);
bf1e527835 Andres Salomon 2008-11-06  115  	return 1;
bf1e527835 Andres Salomon 2008-11-06  116  }
bf1e527835 Andres Salomon 2008-11-06  117  
e23e7a1436 Bill Pemberton 2012-12-06  118  static struct snd_kcontrol_new olpc_cs5535audio_ctls[] = {
57d4bf6d8e Jaya Kumar     2008-11-06  119  {
57d4bf6d8e Jaya Kumar     2008-11-06  120  	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
466ae3055b Andres Salomon 2008-11-06  121  	.name = "DC Mode Enable",
466ae3055b Andres Salomon 2008-11-06  122  	.info = olpc_dc_info,
466ae3055b Andres Salomon 2008-11-06  123  	.get = olpc_dc_get,
466ae3055b Andres Salomon 2008-11-06  124  	.put = olpc_dc_put,
b5ccc57b06 Andres Salomon 2008-11-06  125  	.private_value = 0,
bf1e527835 Andres Salomon 2008-11-06  126  },
bf1e527835 Andres Salomon 2008-11-06  127  {
bf1e527835 Andres Salomon 2008-11-06  128  	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
bf1e527835 Andres Salomon 2008-11-06  129  	.name = "MIC Bias Enable",
bf1e527835 Andres Salomon 2008-11-06  130  	.info = olpc_mic_info,
bf1e527835 Andres Salomon 2008-11-06  131  	.get = olpc_mic_get,
bf1e527835 Andres Salomon 2008-11-06  132  	.put = olpc_mic_put,
bf1e527835 Andres Salomon 2008-11-06  133  	.private_value = 0,
bf1e527835 Andres Salomon 2008-11-06  134  },
57d4bf6d8e Jaya Kumar     2008-11-06  135  };
57d4bf6d8e Jaya Kumar     2008-11-06  136  
e23e7a1436 Bill Pemberton 2012-12-06 @137  void olpc_prequirks(struct snd_card *card,
3556d18465 Andres Salomon 2008-11-06  138  		    struct snd_ac97_template *ac97)
3556d18465 Andres Salomon 2008-11-06  139  {
3556d18465 Andres Salomon 2008-11-06  140  	if (!machine_is_olpc())
3556d18465 Andres Salomon 2008-11-06  141  		return;
3556d18465 Andres Salomon 2008-11-06  142  
3556d18465 Andres Salomon 2008-11-06  143  	/* invert EAPD if on an OLPC B3 or higher */
3556d18465 Andres Salomon 2008-11-06 @144  	if (olpc_board_at_least(olpc_board_pre(0xb3)))
3556d18465 Andres Salomon 2008-11-06  145  		ac97->scaps |= AC97_SCAP_INV_EAPD;
3556d18465 Andres Salomon 2008-11-06  146  }
3556d18465 Andres Salomon 2008-11-06  147  
e23e7a1436 Bill Pemberton 2012-12-06 @148  int olpc_quirks(struct snd_card *card, struct snd_ac97 *ac97)
57d4bf6d8e Jaya Kumar     2008-11-06  149  {
466ae3055b Andres Salomon 2008-11-06  150  	struct snd_ctl_elem_id elem;
bf1e527835 Andres Salomon 2008-11-06  151  	int i, err;
466ae3055b Andres Salomon 2008-11-06  152  
c8974be546 Jordan Crouse  2008-11-06  153  	if (!machine_is_olpc())
c8974be546 Jordan Crouse  2008-11-06  154  		return 0;
c8974be546 Jordan Crouse  2008-11-06  155  
3c55494670 Andres Salomon 2009-12-14  156  	if (gpio_request(OLPC_GPIO_MIC_AC, DRV_NAME)) {
00980aa9c7 Takashi Iwai   2014-02-25  157  		dev_err(card->dev, "unable to allocate MIC GPIO\n");
3c55494670 Andres Salomon 2009-12-14  158  		return -EIO;
3c55494670 Andres Salomon 2009-12-14  159  	}
3c55494670 Andres Salomon 2009-12-14  160  	gpio_direction_output(OLPC_GPIO_MIC_AC, 0);
3c55494670 Andres Salomon 2009-12-14  161  
466ae3055b Andres Salomon 2008-11-06  162  	/* drop the original AD1888 HPF control */
466ae3055b Andres Salomon 2008-11-06  163  	memset(&elem, 0, sizeof(elem));
466ae3055b Andres Salomon 2008-11-06  164  	elem.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
57a4451d26 Takashi Iwai   2013-10-29  165  	strlcpy(elem.name, "High Pass Filter Enable", sizeof(elem.name));
466ae3055b Andres Salomon 2008-11-06  166  	snd_ctl_remove_id(card, &elem);
466ae3055b Andres Salomon 2008-11-06  167  
bf1e527835 Andres Salomon 2008-11-06  168  	/* drop the original V_REFOUT control */
bf1e527835 Andres Salomon 2008-11-06  169  	memset(&elem, 0, sizeof(elem));
bf1e527835 Andres Salomon 2008-11-06  170  	elem.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
57a4451d26 Takashi Iwai   2013-10-29  171  	strlcpy(elem.name, "V_REFOUT Enable", sizeof(elem.name));
bf1e527835 Andres Salomon 2008-11-06  172  	snd_ctl_remove_id(card, &elem);
bf1e527835 Andres Salomon 2008-11-06  173  
bf1e527835 Andres Salomon 2008-11-06  174  	/* add the OLPC-specific controls */
bf1e527835 Andres Salomon 2008-11-06  175  	for (i = 0; i < ARRAY_SIZE(olpc_cs5535audio_ctls); i++) {
bf1e527835 Andres Salomon 2008-11-06  176  		err = snd_ctl_add(card, snd_ctl_new1(&olpc_cs5535audio_ctls[i],
57d4bf6d8e Jaya Kumar     2008-11-06  177  				ac97->private_data));
3c55494670 Andres Salomon 2009-12-14  178  		if (err < 0) {
3c55494670 Andres Salomon 2009-12-14  179  			gpio_free(OLPC_GPIO_MIC_AC);
bf1e527835 Andres Salomon 2008-11-06  180  			return err;
bf1e527835 Andres Salomon 2008-11-06  181  		}
3c55494670 Andres Salomon 2009-12-14  182  	}
bf1e527835 Andres Salomon 2008-11-06  183  
c8f0eeebc1 Andres Salomon 2008-11-06  184  	/* turn off the mic by default */
c8f0eeebc1 Andres Salomon 2008-11-06  185  	olpc_mic_bias(ac97, 0);
bf1e527835 Andres Salomon 2008-11-06  186  	return 0;
57d4bf6d8e Jaya Kumar     2008-11-06  187  }
3c55494670 Andres Salomon 2009-12-14  188  
e23e7a1436 Bill Pemberton 2012-12-06 @189  void olpc_quirks_cleanup(void)

:::::: The code at line 28 was first introduced by commit
:::::: d6276b78028dfab944dd4a58124aefcc9aa580da ALSA: cs5535audio: create function for setting OLPC's Analog Input mode

:::::: TO: Andres Salomon <dilinger@queued.net>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--jRHKVT23PllUwdXP--
