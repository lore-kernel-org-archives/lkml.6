Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73ACDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB1820C01
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oVKEBn6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfB0NCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:02:17 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:42228 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbfB0NCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:02:17 -0500
Received: from [192.168.0.21] (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2E2C249;
        Wed, 27 Feb 2019 14:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1551272534;
        bh=Y5iv9l/qp3ETWGeYHS/LNBQz2zkw8Sua33py/0p3CwY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oVKEBn6eM/RlU9ymcOjdz5GfBlVHS/kJC9VCW9ISG7UWh//cpwOQf2wj1D9bb9NgR
         eMnBZwc8wDzTXN+z88eE65WDWWEcJxeiDaHD3B4ws8PC2ysYwFZqxYOIj6Fjfikif7
         h7EtXXOAVek5WiHXTV7gdzCuqF4xhR8BSHAu0oKI=
Reply-To: kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 5/5] scripts/gdb: refactor rules for symlink creation
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1550568787-18710-1-git-send-email-yamada.masahiro@socionext.com>
 <1550568787-18710-5-git-send-email-yamada.masahiro@socionext.com>
 <acfea6b8-0986-3fc2-86a6-2553c9ef11e0@ideasonboard.com>
 <CAK7LNATtUnSV-OKnrH+xvmWU1scJCCFr-EH-qJ_5djhgwf8BpA@mail.gmail.com>
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Openpgp: preference=signencrypt
Autocrypt: addr=kieran.bingham@ideasonboard.com; keydata=
 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
 sbsRB8KNNvVXBOVNwko86rQqF9drZuw=
Organization: Ideas on Board
Message-ID: <ae17de18-a839-f2dd-cf45-bb4fd5a6a7ee@ideasonboard.com>
Date:   Wed, 27 Feb 2019 13:02:11 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATtUnSV-OKnrH+xvmWU1scJCCFr-EH-qJ_5djhgwf8BpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yamada-san,

On 27/02/2019 12:32, Masahiro Yamada wrote:
> Hi Kieran,
> 
> 
> On Wed, Feb 27, 2019 at 8:56 PM Kieran Bingham
> <kieran.bingham@ideasonboard.com> wrote:
>>
>> Hi Yamada-san,
>>
>> On 19/02/2019 09:33, Masahiro Yamada wrote:
>>> gdb-scripts is not a real object, but (ab)used like a phony target.
>>>
>>> Rewrite the code in a more Kbuild-ish way. Add symlinks to extra-y
>>> and use if_changed.
>>>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>>> ---
>>>
>>>  scripts/gdb/linux/Makefile | 18 +++++++++++-------
>>>  1 file changed, 11 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/scripts/gdb/linux/Makefile b/scripts/gdb/linux/Makefile
>>> index 7545806..3df395a 100644
>>> --- a/scripts/gdb/linux/Makefile
>>> +++ b/scripts/gdb/linux/Makefile
>>> @@ -1,13 +1,17 @@
>>>  # SPDX-License-Identifier: GPL-2.0
>>> -always := gdb-scripts
>>>
>>> -SRCTREE := $(abspath $(srctree))
>>> -
>>> -$(obj)/gdb-scripts:
>>>  ifneq ($(KBUILD_SRC),)
>>> -     $(Q)ln -fsn $(SRCTREE)/$(obj)/*.py $(objtree)/$(obj)
>>> +
>>> +symlinks := $(patsubst $(srctree)/$(src)/%,%,$(wildcard $(srctree)/$(src)/*.py))
>>> +
>>> +quiet_cmd_symlink = SYMLINK $@
>>> +      cmd_symlink = ln -fsn $(patsubst $(obj)/%,$(abspath $(srctree))/$(src)/%,$@) $@
>>> +
>>> +extra-y += $(symlinks)
>>> +$(addprefix $(obj)/, $(symlinks)): FORCE
>>> +     $(call if_changed,symlink)
>>> +
>>>  endif
>>> -     @:
>>>
>>>  quiet_cmd_gen_constants_py = GEN     $@
>>>        cmd_gen_constants_py = \
>>> @@ -18,4 +22,4 @@ extra-y += constants.py
>>>  $(obj)/constants.py: $(src)/constants.py.in FORCE
>>>       $(call if_changed_dep,gen_constants_py)
>>>
>>> -clean-files := *.pyc *.pyo $(if $(KBUILD_SRC),*.py)
>>> +clean-files := *.pyc *.pyo
>>
>> Perhaps this answers my earlier question.
>> I guess the extra-y hook is somehow handling the clean up of these files?
>>
>> Aha - yes, I've just found it in
>>
>> Documentation/kbuild/makefiles.txt:
>>> === 5 Kbuild clean infrastructure
>>> ...
>>> Kbuild knows targets listed in $(hostprogs-y), $(hostprogs-m), $(always), $(extra-y) and $(targets). They are all deleted during "make clean".
>>
>> Perfect, so this is much better.
> 
> Exactly.
> 
> If you are interested in the real code,
> see scripts/Makefile.clean
> 
> 
> __clean-files   := $(extra-y) $(extra-m) $(extra-)       \
>                    $(always) $(targets) $(clean-files)   \
>                    $(hostprogs-y) $(hostprogs-m) $(hostprogs-) \
>                    $(hostlibs-y) $(hostlibs-m) $(hostlibs-) \
>                    $(hostcxxlibs-y) $(hostcxxlibs-m)
> 

Thank you - that makes it very clear.

Thanks again for you work :)

--
Kieran


> 
>> Reviewed-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
>>
>> --
>> Regards
>> --
>> Kieran
> 
> 
> 

-- 
Regards
--
Kieran
