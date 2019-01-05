Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663C2C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32440218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfAECMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:12:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:30791 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfAECMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:12:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="264543476"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO [10.251.139.169]) ([10.251.139.169])
  by orsmga004.jf.intel.com with ESMTP; 04 Jan 2019 18:12:44 -0800
Subject: Re: [GIT PULL] sound updates for 4.21
To:     Azat Khuzhin <dohardgopro@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <s5hk1k48ayx.wl-tiwai@suse.de>
 <CAHk-=wg+hjDa8UGRVnCFytjwYLPk2yDgJoKOESVSE7_6KfaeTg@mail.gmail.com>
 <20181228124303.GA16558@gmail.com> <s5hmuoplgw2.wl-tiwai@suse.de>
 <CAHk-=wjXVPpDWHzvNL=9gGVGNnYg1jOH8hQx=dq4caEzip-n0g@mail.gmail.com>
 <s5hef9zl69r.wl-tiwai@suse.de>
 <82bb7f60-c3c2-4715-a0a0-f1f2a8b14c74@linux.intel.com>
 <s5h1s5ykteg.wl-tiwai@suse.de>
 <CAAW1UO_YDtddPk7-b=c03crPAOL33YWtu_q225um_hxh4SVYtA@mail.gmail.com>
 <47137843-14fc-f6d0-4372-a9ef2456cab8@linux.intel.com>
 <CAAW1UO-P5cWWx-orjCHvHw3deStJTiUmT5BHveTTiJotvB9aNA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <53fa01e6-5cf8-9a42-8efd-8a82cf039770@linux.intel.com>
Date:   Fri, 4 Jan 2019 20:12:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAAW1UO-P5cWWx-orjCHvHw3deStJTiUmT5BHveTTiJotvB9aNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/4/19 6:34 PM, Azat Khuzhin wrote:
>> This is unfortunately a known issue with this driver, Takashi and I had
>> a couple of email threads on this. Even without errors removing the
>> module doesn't seem to release all resources. I don't like this at all,
>> and for the Sound Open Firmware (SOF) driver I mandated module
>> load-unload as a functional requirement along with zero warnings w/
>> Sparse, Coccinelle and friends, but on this legacy code I am afraid
>> there is no simple fix - at least not in a merge window or a single
>> kernel cycle.
> And the fact that kernel crashes after?
> Just want extra confirmation
The kernel crash is related to an HDMI issue that we haven't been able 
to reproduce on our development and validation devices so far but that's 
not an excuse and we do need to figure it out. Things work e.g. fine 
with the KBL Dell XPS13 but not on Linus' SKL Dell XPS13 device, so I'll 
get one and will also work on additional devices remotely.
