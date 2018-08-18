Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162D2C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7BE021767
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 13:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BE021767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbeHRQVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 12:21:08 -0400
Received: from mout.gmx.net ([212.227.17.21]:50073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeHRQVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 12:21:08 -0400
Received: from homer.simpson.net ([185.146.51.55]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfTC1-1gBEd13fPV-00p8IQ; Sat, 18
 Aug 2018 15:13:15 +0200
Message-ID: <1534597992.15909.17.camel@gmx.de>
Subject: Re: [BUG v4.14-rt] kernel BUG at
 /work/rt/stable-rt.git/kernel/sched/core.c:1639!
From:   Mike Galbraith <efault@gmx.de>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Julia Cartwright <julia@ni.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sat, 18 Aug 2018 15:13:12 +0200
In-Reply-To: <1534588142.2516.10.camel@gmx.de>
References: <20180817162340.6e8482fd@gandalf.local.home>
         <1534588142.2516.10.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:3lHXdElgQkuUTDdhQ2qMAJZfiiUl5mmRb1h7VCibaLoTcIwyOfi
 Ywz5Qv/asE3XWQu1YS6xaAXaWJ7FRmeUrA7EsIacpm7sVYLXh7cT1J1bEhHRJbsluNqFnLO
 Sym77RMTyhEGna/azzHegmfKmMs55WMDbX9wiq2JaLwivv7M5l3M5kKGmr9DdKSozzuPyEj
 DWytqUH4YHcEwG+GIWynA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OSh4xTZxyG0=:uYIGc1jwgX4RHGci079CL3
 pOSwIcMg3lGrJoRvZGubD3C9clKj696vwVD5sY2ChKpDTN8TNmpmZpZAFxHsgkiyBI/Dgv2Ne
 EimsFax90nEE5zvlV62B0XTFNADhU7h8KPUvhBf5Ue4fGXOG80hKcefABgwCnG3ui9AdPyedI
 oZo9b35jacb7ei25QPwkVEIAHVRdrmgvST+rB7r+5q+gMkj8bNN/nokAW+Cd1KpG0syDHdF2S
 DOEpSRbU9Z0W7YUO4GTTNjC4+YlGSCvmTDrf78MBWdscvVJEtLQkalvipBzgCkqZGu+bXXiNl
 nM+ShHcj+4X5upGZekmGCsIUL+5dk+5gbjB0qR32fJixHlsv38smpd1Bm0NgcTHOHz0mvevLS
 GpuQz20e7PxTauEF10l3sz0TmJ4VSB8BEKbyPRzguYW/udqvGieNHleQBuY8fLz1iOwZS0ooq
 TAkU/ap2u1VOaO894yaa9pfBD9H3iTnBuPkpC+Q68bdZXkrv194FgEn2GwYnhsjAKKUQWfRUg
 +VkxUSTcLX5UZGfGzFBV4YnTxk6iL9RMP6N4XJV1b198we/x0NOhEiMB/S18PTtFyts+2z+dM
 LoykMD46MYID0bCe53lhrF3rHSOHyPVm1ZZ8A8p3gxK7hxoBhQAJD58C4b592n/RjqILB8+yu
 kuZH6hOCYoo9mXi02ayR/IOYmbO+BUhMGN/J+Bp1N0jJn8Zj2COERVZk90bg3qzEC6TsW4S8i
 w90UvPkeObq+V7MPMPUQDW5JOHr1pzG9G9O3RNeL52JZejiHOTEHlKunZZ2g66gpacybrLG+w
 6D0LxZf
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-18 at 12:29 +0200, Mike Galbraith wrote:
> On Fri, 2018-08-17 at 16:23 -0400, Steven Rostedt wrote:
> > Pulling in stable releases into v4.14-rt I triggered this with my CPU
> > hotplug test:
> > 
> > ------------[ cut here ]------------
> > kernel BUG at /work/rt/stable-rt.git/kernel/sched/core.c:1639!
> > invalid opcode: 0000 [#1] PREEMPT SMP PTI
> > Modules linked in: sunrpc ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 ip6table_filter ip6_tables uinput snd_hda_codec_idt snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer snd shpchp i2c_i801 soundcore floppy i915 drm_kms_helper drm fb_sys_fops sysimgblt sysfillrect syscopyarea i2c_algo_bit iosf_mbi video [last unloaded: speedstep_lib]
> > CPU: 1 PID: 2944 Comm: mkdumprd Not tainted 4.14.63-test-rt40+ #782
> > Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS SDBLI944.86P 05/08/2007
> > task: ffff880037888d80 task.stack: ffffc90000538000
> > RIP: 0010:select_fallback_rq+0xc3/0x122
> 
> I noticed this upstream, and had started hunting for the origin, but
> had thought that 4.14-rt was OK.  Clearly not the case, but it's not
> 4.14.60.. stable changes interacting badly either, virgin 4.14.59-rt37
> just reproduced in a vm clone of my workstation.

4.15.18-rt37 (4.14-rt rolled forward) does not reproduce, nor does
4.16.18-rt12, but 4.17.0-rt5 (v4.16.12-rt5 rolled forward) does, so
seems it has be something from the 4.17 cycle that went back to 4.14-
stable after 4.1[56]-stable trees went extinct.

	-Mike
