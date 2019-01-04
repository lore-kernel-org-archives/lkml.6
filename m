Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8936EC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF242184B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 07:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfADHdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 02:33:36 -0500
Received: from mga02.intel.com ([134.134.136.20]:39683 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbfADHdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 02:33:36 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jan 2019 23:33:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,437,1539673200"; 
   d="scan'208";a="115385098"
Received: from tiwuxiex-mobl.ccr.corp.intel.com (HELO wfg-t570.sh.intel.com) ([10.254.213.147])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2019 23:33:32 -0800
Received: from wfg by wfg-t570.sh.intel.com with local (Exim 4.89)
        (envelope-from <fengguang.wu@intel.com>)
        id 1gfJz2-0001tF-2B; Fri, 04 Jan 2019 15:33:32 +0800
Date:   Fri, 4 Jan 2019 15:33:32 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "Li, Philip" <philip.li@intel.com>,
        Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] printk: Add caller information to printk() output.
Message-ID: <20190104073332.qxq2pi44xsmgokaq@wfg-t540p.sh.intel.com>
References: <c5b5d660-d217-35f0-c4f1-7252367934d1@i-love.sakura.ne.jp>
 <e3f69846-ef08-c8f5-368f-4dada13c9970@i-love.sakura.ne.jp>
 <20181213121847.mwlr2vyv6qzclhk6@pathway.suse.cz>
 <20181213124255.GB3053@tigerII.localdomain>
 <20181217145452.3kev4rmo2l5lt2qy@pathway.suse.cz>
 <93f19e57-5051-c67d-9af4-b17624062d44@i-love.sakura.ne.jp>
 <20181218083911.qxvlqlwlb4eye72x@pathway.suse.cz>
 <20181218085833.GA460@jagdpanzerIV>
 <CACT4Y+ahbDb7F2B1-z5QxroZcqP+AEUfUi6Sa1ZHRpaCeVmZ=w@mail.gmail.com>
 <CACT4Y+ZKR7eib+ZtK-7mbCw6rD6KOeuWtjWtxAcnHEWnYqyjJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZKR7eib+ZtK-7mbCw6rD6KOeuWtjWtxAcnHEWnYqyjJw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 07:27:41PM +0100, Dmitry Vyukov wrote:
>On Wed, Jan 2, 2019 at 5:09 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>>
>> On Tue, Dec 18, 2018 at 9:58 AM Sergey Senozhatsky
>> <sergey.senozhatsky.work@gmail.com> wrote:
>> >
>> > On (12/18/18 09:39), Petr Mladek wrote:
>> > >
>> > > Sergey, are you okay with this squashed patch, please?
>> > >
>> >
>> > Yeah. There are several minor nitpicks, but here is my
>> > Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>> >
>> >
>> > One final question - can syzbot folks confirm that the patch
>> > helps? Just curious.
>>
>> This slip through the cracks. Tetsuo pinged me and I am testing now.
>> Need to create a set of tests and update parsing code to handle this.
>
>I've pushed support for CONFIG_PRINTK_CALLER to syzkaller/syzbot:
>https://github.com/google/syzkaller/commit/7da2392541a49c3f17b2e7d24e04b84d72b965fb
>Let's see what happens. Limited local testing shows that it's working
>as intended and significatly improves quality of reports and ability
>to make sense out of kernel output.
>
>Tetsuo, thanks for your great persistence with this change!
>Sergey, Petr, thanks for reviews!
>
>+Fengguang, Kevin, maybe you will find this useful for 0-day/kernel-ci.

Thanks! We'll try out CONFIG_PRINTK_CALLER.

Regards,
Fengguang
