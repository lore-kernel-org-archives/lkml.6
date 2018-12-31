Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A24C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98C4D20828
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 00:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeLaAyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 19:54:37 -0500
Received: from mga12.intel.com ([192.55.52.136]:42699 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbeLaAyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 19:54:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Dec 2018 16:54:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,420,1539673200"; 
   d="scan'208";a="122846453"
Received: from mpantoja-mobl.amr.corp.intel.com (HELO [10.254.189.11]) ([10.254.189.11])
  by orsmga001.jf.intel.com with ESMTP; 30 Dec 2018 16:54:35 -0800
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Takashi Iwai <tiwai@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de>
 <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <CAHk-=wgDKUQthwqe_RYm1=uJBKLvGQO9-90BNkO6rE-Ck7hVwQ@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4c7d2929-3e72-b68a-8438-d6131d0d3919@linux.intel.com>
Date:   Sun, 30 Dec 2018 18:54:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgDKUQthwqe_RYm1=uJBKLvGQO9-90BNkO6rE-Ck7hVwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/30/18 6:19 PM, Linus Torvalds wrote:
> On Sun, Dec 30, 2018 at 3:18 PM Pierre-Louis Bossart
> <pierre-louis.bossart@linux.intel.com> wrote:
>> The KabyLake Dell XPS13 was initially used for the ASoC driver for
>> HDaudio, so there is no known hardware-related reason why this problem
>> happens.
> Mine isn't the Kabylake one, it's the older XPS13 9350 (2015 - Skylake) one.
ok. Skylake and Kabylake are nearly identical in terms of audio support 
so the difference should be minor. I'll try to get a Skylake version so 
that this never happens again.
>
>> The simplest way to make the problem go away is to force the legacy
>> driver to bind with the (untested) diff below.
> That diff is wrong, since it changes the meaning of the binding
> numbers, but then the module interface is wrong:
>
>     static int skl_pci_binding;
>     module_param_named(pci_binding, skl_pci_binding, int, 0444);
>     MODULE_PARM_DESC(pci_binding, "PCI binding (0=auto, 1=only legacy,
> 2=only asoc");
>
> so I think Takashi's patch to just change the default value of
> skl_pci_binding is the better one.

You're right, this description should be changed as well to align the 
text to enum values, but the idea is identical to Takashi's: use the 
HDaudio legacy by default.

-Pierre

