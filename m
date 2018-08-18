Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CE0C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA78521868
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 10:29:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA78521868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbeHRNgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 09:36:24 -0400
Received: from mout.gmx.net ([212.227.15.18]:59261 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbeHRNgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 09:36:23 -0400
Received: from homer.simpson.net ([185.146.51.55]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhRI2-1fULG93pVS-00Mdpa; Sat, 18
 Aug 2018 12:29:04 +0200
Message-ID: <1534588142.2516.10.camel@gmx.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 18 Aug 2018 12:29:02 +0200
In-Reply-To: <20180817162340.6e8482fd@gandalf.local.home>
References: <20180817162340.6e8482fd@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:u1lsHLAQDBP1Mw9BSPmC19cMnXrM1fEFLldRklKEDKYVunkIVqZ
 dtS25Sx/BYgROIZ3awjCcGX6KQiT8QpM3IUgjMYiQfjUCFsA5hlZ0NaN2ARF1CgbjfhcLaT
 neiL97vaXxQZMeooK83D4R/suK+gpsw1bfRtZPmLNIW8t0Y0zEldjpJ2SKITzLquvdFzRei
 FlX/S6qbcSl/2bRE9PfYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:kyEYQtxlunw=:LxCBm9iiha3PVxBuyeBVPl
 kIRJXp4/OysOxt2rVvFYPzmMb1b4sFvg77QhWcxvLZuh38jg+C0FeKWM6shOjYC3Vu6uKgDQX
 Qorx1TmxeK2SswkQ4cgJJ2znO+ZI2kskZoNdvv0ZK53O2mYOZ7bqacQL6/YttEr+zkY85dmes
 eWUDUsaAyMmiyjsXZ/gmt/OnQruuee8oSYhOSb1WiKYKCgZsgXukkgqIacCR79IHYTvsIXvLi
 HwBqDQhwvXtVD4BxI1ucAKfNFeC0E5Xo9XHefaVKtUUFn0o6CO/hPlVYsZCHV3k6UX5HKUwka
 0UOChPcSbrhKN5AbfwT+ZRUWYO5u+dLjxf5NeaHa8QCEY925qPypTzJzSW182kdONueXu0xG2
 rIjHFG1fAc5Pe9pM38cxtj1Pp22zRgD65tLHgLkGtxt3OxQbBPyQZ32KGKkdA/CN/R089DRsd
 RiCzrW7xmOx6FOqrz4xyMVGnBTJXG6igHyFQSmd03XQAXSnjMnuR4ptOBRUv/5pZypjNpKrZv
 mseI5rnOa2DQcn6mhp3CO7jM2vo+KShIErPmY6+gkgQN0rmUq4j/8J+lR/sfI1MU1jk73oNwc
 aPRaDAefmZpedI8rAc9gbrhieIabq2XkAxSjhRLhJ+R2ovnECiAuvz0HhOZ197eiHXUyWdXEb
 HvLyvKiSuhSDEnbBKFuovuO3LDQmQagTjHlqE/hHDc3ajV6aH3BEFm15WnA+dNpir1VHS1TT8
 KoluYg1KJERtN2JHeI16fgItgtIV5O6mX7j8DyFJ1hYToED25uOPJzlc5j9aPJJvDzdkYDHJ1
 bZ1jE68
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-17 at 16:23 -0400, Steven Rostedt wrote:
> Pulling in stable releases into v4.14-rt I triggered this with my CPU
> hotplug test:
> 
> ------------[ cut here ]------------
> kernel BUG at /work/rt/stable-rt.git/kernel/sched/core.c:1639!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> Modules linked in: sunrpc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables uinput snd_hda_codec_idt snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd shpchp i2c_i801 soundcore floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit iosf_mbi video [last unloaded: speedstep_lib]
> CPU: 1 PID: 2944 Comm: mkdumprd Not tainted 4.14.63-test-rt40+ #782
> Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
> task: ffff880037888d80 task.stack: ffffc90000538000
> RIP: 0010:select_fallback_rq+0xc3/0x122

I noticed this upstream, and had started hunting for the origin, but
had thought that 4.14-rt was OK.  Clearly not the case, but it's not
4.14.60.. stable changes interacting badly either, virgin 4.14.59-rt37
just reproduced in a vm clone of my workstation.

	-Mike
