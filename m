Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CB2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80E6A2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 19:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iGuXtt15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80E6A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbeKTF4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 00:56:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39656 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeKTF4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 00:56:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kFvZtKAwH/GQCN1nClozLsRgbXuCdljHmNLW4saMjls=; b=iGuXtt15UArSMUJeULWFTUVdka
        jR+XJ+Imqw8eFsjClLsTHfvaC8fOCkXd1V6de+xDY3UGmhnKkvAGlCyO+7iciVossLzFZ0lCs0QHV
        znut9fby8xj5j3hWBkRlJH+foaX4dwyKxa2aNNVl7LgQbkMMHDRtxbZsJ5xRk5t6XdWm2cGbalRxn
        7nQMzmGhFwYlhnH5rY4idio0VFG1HeH7ox4ZwbA6lPWRx1kk8eseT4aY/gnCJCV37praUYtXS7na3
        IBL8OSHhuuDuNhJVgQBn8NuEBr30hZHMNpF42bxADyffSVq4DsgZPfaCLlPbr0h35/WCsoXqPPgII
        fE0kuZog==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gOpGY-0004wv-Va; Mon, 19 Nov 2018 19:31:27 +0000
Subject: Re: Magic Sysrq key option ... What is the option to record the boot
 logs to my hard disk before i issue a reboot command ?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        AIAMUZZ <muzafsh.113@gmail.com>, linux-kernel@vger.kernel.org
References: <CAC_t1uu7DDwA6do9sXnNhjcY4T=Q5PhmP2JtejSJ+FfpwJkaeg@mail.gmail.com>
 <20181119184803.GB19377@thunk.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e901d13d-68e7-c9be-96d6-9f49d3a44ceb@infradead.org>
Date:   Mon, 19 Nov 2018 11:31:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181119184803.GB19377@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/18 10:48 AM, Theodore Y. Ts'o wrote:
> On Mon, Nov 19, 2018 at 08:51:17PM +0530, AIAMUZZ wrote:
>> Hi,
>>
>> I have this nagging and frustrating boot freeze i often face on my
>> Deepin OS boot ... Deepin OS i think uses 'journalctl' to record logs
>> on its system.
>>
>> 'journalctl' however seems to record boot logs ONLY for successful
>> boots ... boot logs for instances of boot freezes/hangs that are
>> issued with a ... 'Ctrl+Alt+Del' ... key combination or the ... Magic
>> Sysrq 'b' ... key combination to get out of the frozen/hung machine
>> state are just not aved in the 'journalctl' log ...
>>
>> Is there any option using Magic Sysrq that will enable me to record
>> the failed/frozen/hung boot information to a file for troubleshooting
>> before i reboot the system using the option 'b' ?
>>
>> If not ... Isn't it a good idea to have such an option added to Magic
>> Sysrq options, that can save/record the boot/system logs upto that
>> point, until just before we restart the machines ?
> 
> This is a hard problem to solve, because there's no place to store the
> information, at least not in the general case.  The problem is on an
> unsuccessful boot, the root file system may not have been mounted yet.
> Heck, the storage devices might not have been probed at all!
> 
> If your hardware has a place to store dmesg output across reboots (via
> one of the CONFIG_PSTORE_* kernel configuration options) then this
> would be an easy problem --- in fact, it would be the default even
> with out needing a magic sysrq to request it.  The problem is that
> most x86 devices do not have hardware capable of supporting
> CONFIG_PSTORE.  If you have a custom BIOS which doesn't clear memory
> across a warm reset, that would make things easy.  Unless, unless you
> are a big cloud company using custom hardware and/or a custom BIOS,
> life is much more difficult.  :-(
> 
> One alternative solution you can use is to simply use a serial
> console, and have a another computer monitoring the output from the
> serial console.  This will allow you to see all of the kernel messages
> during early bootup and afterwards.  So this is also useful for when
> your X server dies and your system mysteriously reboot; either
> CONFIG_PSTORE_* hardware or using a serial console might allow you to
> see the kernel oops message which took out your desktop machine.  (Or
> in the case of servers, you can cross connect your servers' serial
> ports so that one server is monitoring another server's serial
> consoles.)
> 
> Cheers,

Yes, all of that.
Having some kind of pstore on x86 would be wonderful.

kexec/kdump used to be an option also.  I haven't tried it lately.

-- 
~Randy
