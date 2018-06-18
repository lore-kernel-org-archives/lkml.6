Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C44C5AE59
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3E92083D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 22:56:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3E92083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mess.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755506AbeFRW4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 18:56:08 -0400
Received: from gofer.mess.org ([88.97.38.141]:47727 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755329AbeFRW4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 18:56:06 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id D9A566028F; Mon, 18 Jun 2018 23:56:03 +0100 (BST)
Date:   Mon, 18 Jun 2018 23:56:03 +0100
From:   Sean Young <sean@mess.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Daniel Borkmann <daniel@iogearbox.net>,
        Y Song <ys114321@gmail.com>, Matthias Reichl <hias@horus.com>,
        linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Devin Heitmueller <dheitmueller@kernellabs.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: Re: [PATCH v3] bpf: attach type BPF_LIRC_MODE2 should not depend on
 CONFIG_CGROUP_BPF
Message-ID: <20180618225603.uve4vrt5m3vittav@gofer.mess.org>
References: <20180618171216.gearpr755pm3wot7@gofer.mess.org>
 <201806190203.kfm0Xhda%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201806190203.kfm0Xhda%fengguang.wu@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 02:46:29AM +0800, kbuild test robot wrote:
> Hi Sean,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.18-rc1 next-20180618]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Sean-Young/bpf-attach-type-BPF_LIRC_MODE2-should-not-depend-on-CONFIG_CGROUP_BPF/20180619-023056
> config: i386-tinyconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from kernel///events/core.c:45:0:
> >> include/linux/bpf.h:710:1: error: expected identifier or '(' before '{' token
>     {
>     ^

Oh dear I never tested that with CONFIG_INET off (no ip? madness!). I'll
send out a v4 soon.


Sean
