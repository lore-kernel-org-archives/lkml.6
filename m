Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964953AbeBLQeS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 11:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:48396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964902AbeBLQeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 11:34:17 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 603E121774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Tue, 13 Feb 2018 01:34:14 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH] x86/decoder: Update UD0 to have operands
Message-Id: <20180213013414.bc8ee339bf7999149acc6636@kernel.org>
In-Reply-To: <201802110336.UCMZHvli%fengguang.wu@intel.com>
References: <151810306983.8735.9310416186567188423.stgit@devbox>
        <201802110336.UCMZHvli%fengguang.wu@intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Feb 2018 03:26:12 +0800
kbuild test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on tip/auto-latest]
> [also build test WARNING on v4.15 next-20180209]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/x86-decoder-Update-UD0-to-have-operands/20180211-013327
> config: x86_64-acpi-redef (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/regulator/devres.o: warning: objtool: devm_regulator_unregister_notifier()+0x2e: can't decode instruction
> --
> >> sound/core/info.o: warning: objtool: snd_info_get_line()+0x9: can't find jump dest instruction at .text+0x8b5
> --
> >> sound/core/sound_oss.o: warning: objtool: snd_oss_kernel_minor()+0x5: can't find jump dest instruction at .text+0x36
> --
> >> sound/core/hwdep.o: warning: objtool: snd_hwdep_dsp_load()+0x78: can't find jump dest instruction at .text+0x5fa
> --
> >> sound/core/timer.o: warning: objtool: snd_timer_notify()+0x49: return with modified stack frame
> --
> >> sound/core/hrtimer.o: warning: objtool: snd_hrtimer_callback()+0x62: can't find jump dest instruction at .text+0x108
> --
> >> sound/core/pcm_lib.o: warning: objtool: snd_pcm_playback_silence()+0x17b: can't find jump dest instruction at .text+0x9b9
> --
> >> sound/drivers/opl3/opl3_lib.o: warning: objtool: snd_opl3_create()+0x1f5: can't find jump dest instruction at .text+0x628
> --
> >> sound/drivers/opl3/opl3_midi.o: warning: objtool: snd_opl3_kill_voice()+0x9: can't find jump dest instruction at .text+0x12
> --
> >> drivers/media/dvb-core/dvb_math.o: warning: objtool: intlog2()+0x2: can't find jump dest instruction at .text+0x9
> --
> >> drivers/gpu/drm/ttm/ttm_execbuf_util.o: warning: objtool: ttm_eu_backoff_reservation()+0x64: can't find jump dest instruction at .text+0xb5
> ..

Ugg, OK this is what I worried about :(
This might mean gcc generated UD0 without MODRM binary but the tool check it with MODRM...
I will check it.

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
