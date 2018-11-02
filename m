Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796A9C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5F20657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WOSGR6dg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DF5F20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeKCBDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 21:03:54 -0400
Received: from merlin.infradead.org ([205.233.59.134]:35584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeKCBDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 21:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7pT6DRckcRgqT1jXAhj6mHdXBK8OEfmN0Z5g+C9viV4=; b=WOSGR6dg2clgmVDfLA8akR/djr
        1BvIFbk6ReT7LOrlOx0HMtvRd5XrUO+668bqV/H9j4MQhlrx9ruzjAlLp6edhlEdnSIOXN/b2+Q7J
        l4UPL0O/VgZ3qIiV3YbSScQyJkqJnjHXy1vW+x6y5/WoTtTsj7wrF1nT3oQVBteFTaeUhKPVquFnr
        PO9C5ig5BvQ2pPkt658foPM3rDf+KqppEZ89USMPvAQgnY4QYSoJ25nu0O/XF87ta27Xudxau1dwx
        9HnUzrLuR+z4hSgIqEJ1nnBTUycejzS91uh84kAX5c1QcnEj/fthY8J/pJN51bujWyWUwdpT7t83+
        W1djBzzw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIbo3-0003f1-Gw; Fri, 02 Nov 2018 15:56:19 +0000
Subject: Re: linux-next: Tree for Nov 2 (compiler-gcc.h)
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20181102143018.09feb051@canb.auug.org.au>
 <CANiq72m65bQZefAoFF5dTUB-rPzm4vofZFnDn0nYBG3MsGrjZg@mail.gmail.com>
 <20181103002218.3bd015b3@canb.auug.org.au>
 <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <20227164-2ef3-d684-bf4e-fb69ac828789@infradead.org>
Date:   Fri, 2 Nov 2018 08:56:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CANiq72=kHErmujzMgM4akXeoWkSR0Q3VLd-6Mwiaj5mGan8yZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/2/18 6:57 AM, Miguel Ojeda wrote:
> On Fri, Nov 2, 2018 at 2:22 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Its always OK (and actually useful) to move your branch head up to
>> where Linus merged it (this is usually a fast forward anyway) since
>> that doesn't add any new code to linux-next to conflict with code that
>> is still pending to be merged by Linus.
>>
>> Also, adding bug fixes is always fine.
>>
>> I just want to avoid getting conflicts in linux-next between code
>> that Linus will merge during this merge window and new code destined
>> for the next merge window.
> 
> Thanks Stephen! I assumed as much, but I doubted due to the warning
> (and I wanted to avoid giving you an unexpected surprise tomorrow).
> 
> Cheers,
> Miguel
> 

Hi,

on i386 or x86_64, with gcc (SUSE Linux) 4.8.5, I am seeing this problem:

In file included from <command-line>:0:0:
../include/linux/compiler-gcc.h:75:45: internal compiler error: in function_and_variable_visibility, at ipa.c:825
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                             ^
./../include/linux/compiler_types.h:53:23: note: in definition of macro ‘___PASTE’
 #define ___PASTE(a,b) a##b
                       ^
../include/linux/compiler-gcc.h:75:29: note: in expansion of macro ‘__PASTE’
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                             ^
./../include/linux/compiler_types.h:54:22: note: in expansion of macro ‘___PASTE’
 #define __PASTE(a,b) ___PASTE(a,b)
                      ^
../include/linux/compiler-gcc.h:75:37: note: in expansion of macro ‘__PASTE’
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
                                     ^
../include/linux/moduleparam.h:28:10: note: in expansion of macro ‘__UNIQUE_ID’
   struct __UNIQUE_ID(name) {}
          ^
../include/linux/module.h:161:32: note: in expansion of macro ‘__MODULE_INFO’
 #define MODULE_INFO(tag, info) __MODULE_INFO(tag, tag, info)
                                ^
../include/linux/module.h:199:34: note: in expansion of macro ‘MODULE_INFO’
 #define MODULE_LICENSE(_license) MODULE_INFO(license, _license)
                                  ^
../drivers/media/usb/dvb-usb/pctv452e.c:1102:1: note: in expansion of macro ‘MODULE_LICENSE’
 MODULE_LICENSE("GPL");
 ^
Please submit a full bug report,
with preprocessed source if appropriate.
See <http://bugs.opensuse.org/> for instructions.
../scripts/Makefile.build:293: recipe for target 'drivers/media/usb/dvb-usb/pctv452e.o' failed


-- 
~Randy
