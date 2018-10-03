Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D79C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA37213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 23:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uyl1yBa3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BA37213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbeJDFzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 01:55:50 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38155 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbeJDFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 01:55:49 -0400
Received: by mail-qt1-f195.google.com with SMTP id l9-v6so7894577qtf.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 16:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NtgnYGX5TZTIsyzBGTGdTLrxLpQU1HQo3yABRuackGY=;
        b=Uyl1yBa3C1Zgg87PteEYTyBFxzSDCOviMifTelcLHDc+dwADdP8gbWd1YielQztIR8
         whIy4UVgUOubBDBbVdwAlXEmWc+Z8IrWiMmmZg2trcGcBAbZF6oVEAUCSyQ9u1+GcNYB
         t8hhF96PKOpUp+D3Buhz0tE9FYqXxgeME9eOepysa2iyvK8R8scLkVIOtQxJ4htOi8od
         8g0N5QrP3M6kBmD1riY5Rh0egK7Z/+kA5Tw7kHHHpS0OuT6ISVy1RRcnl8U7sFDf8W8Q
         VNwi1LQjMpxFLZRvtE+oMPAumLIpTB/St9XCzm7c7Nd3Tca2/fOtCRvsyKiSYxJom6BW
         KSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NtgnYGX5TZTIsyzBGTGdTLrxLpQU1HQo3yABRuackGY=;
        b=mXUAzUW7A8opye8cwrFk5MW7jnWdrfInItSGFzLPasJ6l+yyPAJStY/EUwIUAmTKlk
         lDKhWpMo5ZygKloj1xpVo2W0SnDhzXQk20+QQrld5kPC3gCjZ63pyM0TQNChbxx9aw5y
         SjkrKNzrPkSuO0I78VUG/I4U+uSq5qw71uTmJBE42MeAS3pB43LuJGvkvfURWOKL1qrC
         zf8JP+oDxfIkF/tsI9ttpXFb7ac4RHAxEq+mIJBrcGT2ahYIlE617oV3djBMcLM325eD
         yW3ZQ01c0XJ4LtPeZHsRvV86uDOE+j1pjLD5QFqDUeXyYcwEynKlEdzFbFwJQ5FCyZT+
         9ezg==
X-Gm-Message-State: ABuFfogQvl0vR5JBji0hqPmfHuwNfNbE6BKPlsPNsmV4VMBosmJ0ZcFv
        Dlciw2aAkfxS5EwX7kgqzMc=
X-Google-Smtp-Source: ACcGV612bW91pttUf9pvRokWDEZ0vDRolfNIfVS3U8s+dK7vRLzqFsJhQZq5xNfV8TESIGBIVx56nQ==
X-Received: by 2002:ac8:185d:: with SMTP id n29-v6mr3286963qtk.10.1538607922180;
        Wed, 03 Oct 2018 16:05:22 -0700 (PDT)
Received: from oc6857751186.ibm.com ([2601:1c2:1b7f:e860:c35a:1d95:8a0f:9ad0])
        by smtp.gmail.com with ESMTPSA id b128-v6sm1498412qkc.21.2018.10.03.16.05.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 16:05:21 -0700 (PDT)
Subject: Re: [PATCH] migration/mm: Add WARN_ON to try_offline_node
To:     Michael Bringmann <mwb@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mathieu Malaterre <malat@debian.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
        Juliet Kim <minkim@us.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Nathan Fontenot <nfont@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        YASUAKI ISHIMATSU <yasu.isimatu@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        Oscar Salvador <osalvador@suse.de>
References: <20181001185616.11427.35521.stgit@ltcalpine2-lp9.aus.stglabs.ibm.com>
 <20181001202724.GL18290@dhcp22.suse.cz>
 <bdbca329-7d35-0535-1737-94a06a19ae28@linux.vnet.ibm.com>
 <df95f828-1963-d8b9-ab58-6d29d2d152d2@linux.vnet.ibm.com>
 <20181002145922.GZ18290@dhcp22.suse.cz>
 <d338b385-626b-0e79-9944-708178fe245d@linux.vnet.ibm.com>
 <20181002160446.GA18290@dhcp22.suse.cz>
 <e7dd66c1-d196-3a14-0115-acdaf538ebfd@linux.vnet.ibm.com>
 <bbc5f219-614f-b024-0888-8ad216c5eaf8@linux.vnet.ibm.com>
 <17781f9e-abfb-8c1e-eb18-39571d1b5cd6@linux.vnet.ibm.com>
From:   Tyrel Datwyler <turtle.in.the.kernel@gmail.com>
Message-ID: <e7c0f7cc-02a4-47ff-9d7c-0b63f106932e@gmail.com>
Date:   Wed, 3 Oct 2018 16:05:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <17781f9e-abfb-8c1e-eb18-39571d1b5cd6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/2018 06:27 AM, Michael Bringmann wrote:
> On 10/02/2018 02:45 PM, Tyrel Datwyler wrote:
>> On 10/02/2018 11:13 AM, Michael Bringmann wrote:
>>>
>>>
>>> On 10/02/2018 11:04 AM, Michal Hocko wrote:
>>>> On Tue 02-10-18 10:14:49, Michael Bringmann wrote:
>>>>> On 10/02/2018 09:59 AM, Michal Hocko wrote:
>>>>>> On Tue 02-10-18 09:51:40, Michael Bringmann wrote:
>>>>>> [...]
>>>>>>> When the device-tree affinity attributes have changed for memory,
>>>>>>> the 'nid' affinity calculated points to a different node for the
>>>>>>> memory block than the one used to install it, previously on the
>>>>>>> source system.  The newly calculated 'nid' affinity may not yet
>>>>>>> be initialized on the target system.  The current memory tracking
>>>>>>> mechanisms do not record the node to which a memory block was
>>>>>>> associated when it was added.  Nathan is looking at adding this
>>>>>>> feature to the new implementation of LMBs, but it is not there
>>>>>>> yet, and won't be present in earlier kernels without backporting a
>>>>>>> significant number of changes.
>>>>>>
>>>>>> Then the patch you have proposed here just papers over a real issue, no?
>>>>>> IIUC then you simply do not remove the memory if you lose the race.
>>>>>
>>>>> The problem occurs when removing memory after an affinity change
>>>>> references a node that was previously unreferenced.  Other code
>>>>> in 'kernel/mm/memory_hotplug.c' deals with initializing an empty
>>>>> node when adding memory to a system.  The 'removing memory' case is
>>>>> specific to systems that perform LPM and allow device-tree changes.
>>>>> The powerpc kernel does not have the option of accepting some PRRN
>>>>> requests and accepting others.  It must perform them all.
>>>>
>>>> I am sorry, but you are still too cryptic for me. Either there is a
>>>> correctness issue and the the patch doesn't really fix anything or the
>>>> final race doesn't make any difference and then the ppc code should be
>>>> explicit about that. Checking the node inside the hotplug core code just
>>>> looks as a wrong layer to mitigate an arch specific problem. I am not
>>>> saying the patch is a no-go but if anything we want a big fat comment
>>>> explaining how this is possible because right now it just points to an
>>>> incorrect API usage.
>>>>
>>>> That being said, this sounds pretty much ppc specific problem and I
>>>> would _prefer_ it to be handled there (along with a big fat comment of
>>>> course).
>>>
>>> Let me try again.  Regardless of the path to which we get to this condition,
>>> we currently crash the kernel.  This patch changes that to a WARN_ON notice
>>> and continues executing the kernel without shutting down the system.  I saw
>>> the problem during powerpc testing, because that is the focus of my work.
>>> There are other paths to this function besides powerpc.  I feel that the
>>> kernel should keep running instead of halting.
>>
>> This is still basically a hack to get around a known race. In itself this patch is still worth while in that we shouldn't crash the kernel on a null pointer dereference. However, I think the actual problem still needs to be addressed. We shouldn't run any PRRN events for the source system on the target after a migration. The device tree update should have taken care of telling us about new affinities and what not. Can we just throw out any queued PRRN events when we wake up on the target?
> 
> We are not talking about queued events provided on the source system, but about
> new PRRN events sent by phyp to the kernel on the target system to update the
> kernel state after migration.  No way to predict the content.

Okay, but either way shouldn't your other proposed patches to update memory affinity by re-adding memory and changing the time topology updates are stopped to include the post-mobility updates put things in the right nodes? Or, am I missing something? I would assume a PRRN on the target would assume the target was up-to-date with respect to where things are supposed to be located.

-Tyrel

> 
>>
>> -Tyrel
>>>
>>> Regards,
>>>
> 
> Michael
> 

