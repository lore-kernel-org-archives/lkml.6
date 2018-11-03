Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997C7C0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B532081B
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 04:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLtxaRPS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B532081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbeKCOEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 10:04:43 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42252 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeKCOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 10:04:42 -0400
Received: by mail-pf1-f195.google.com with SMTP id f26-v6so1911971pfn.9;
        Fri, 02 Nov 2018 21:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=l7n3S044w+PwqYAQc1M+hJLY/g+X7NdWQaTg6bNSpz4=;
        b=NLtxaRPSnE8e6a2/VIVV1s4dpdUe0zyXZCjWFkad0gVIGj8C+whKoDHlk4iSkfbido
         IyoJJjhdlCWpMWcs1oWZyDL3SQW7hS1anT3iiv2CEnD3ZiDg/+vX0tNaR/SMigZSCeTb
         lzeBLfFaZniYTTf4CE57NDHDP0eCcOpOCdJ1W1JXKnI93dB3p8ojXptK9dMAI/WDOcPd
         RxOHmoM8pZOXdaNaNi8NwWscpPW5nXMmQxoC3CVQKMkER0QKUcawR8SSHbgzgLqz5JFV
         WSgv+yMh1MbpcwdmjK4424HRAVpm3Wgw+LeQPyN7TovwYq+x48jBTA3316nhpyjjpJP2
         miEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=l7n3S044w+PwqYAQc1M+hJLY/g+X7NdWQaTg6bNSpz4=;
        b=rSvOGApSkkiiBQqs7FshOnER9BbbX+qmcc3TbD1k+Xo75iXyvGZaFDIJQokSoMfnBQ
         0CHxACG02Rq6zHKBhUQx9shULO5+/A6CWvKGONS67cYimHfwmBUelHVCRD8Uqa2hvTx/
         2fZrBXm8UiClUh8TscQAqTmkvB5vwAK30BD5I03NrTx7+8Om8TSPdth/ja2NibLsWxWn
         cNO5X9xDgS2qryoCclJ7ITJpz3tlqwYUz0hCRY2qC5Q1QeLarv+H3uuLP/c3bmtZ94Ua
         vNiN9x9dA75LknZhUxbsJkrHf84AG9eh2r5C++Q5/u010Yhpq92dCLURYEn6B3U+iXY2
         KI5A==
X-Gm-Message-State: AGRZ1gKq7tQ9SN4KeEH9L36kCyjxTAkCxSalNHt1MuXzMTN06foXH47c
        S0UnZgUOim+gAHHuIwlYmOU=
X-Google-Smtp-Source: AJdET5cGqQNTEmQvDMPCoz+duNoZ3dZWxKD/24WtfsfFVN3P0F1oEwB0wC8X2l0yt5EY/Dm1ww7dmw==
X-Received: by 2002:a63:36c8:: with SMTP id d191-v6mr12991921pga.404.1541220882571;
        Fri, 02 Nov 2018 21:54:42 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id g3-v6sm15515686pgr.40.2018.11.02.21.54.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 21:54:41 -0700 (PDT)
Subject: Re: [PATCH v3] of: overlay: user space synchronization
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Tull <atull@kernel.org>
References: <1539736466-28638-1-git-send-email-frowand.list@gmail.com>
 <20181018193216.GA9971@bogus>
 <2f99d700-6276-cfa4-8878-4eb161126330@gmail.com>
 <CAL_Jsq+=OiXTSSEr4QuiyqCzyrKdH0M8HhmOjVha3SWM5Y62Gw@mail.gmail.com>
 <399b1ed0-ac64-d962-5eea-23a99011aada@gmail.com>
Message-ID: <918df992-d21f-b237-1ff3-f0b410b32112@gmail.com>
Date:   Fri, 2 Nov 2018 21:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <399b1ed0-ac64-d962-5eea-23a99011aada@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

First, the point of this patch was to provide a way for userspace (program,
command line interface, whatever -- that is orthogonal) to ensure that its
view of the devicetree via /proc/device-tree/ is consistent since an overlay
apply or remove can alter the devicetree.

For in-kernel use, typically some sort of lock or rcu would be used to
provide this type of functionality.


On 10/22/18 12:30 AM, Frank Rowand wrote:
> On 10/19/18 9:06 AM, Rob Herring wrote:
>> On Thu, Oct 18, 2018 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>>
>>> On 10/18/18 12:32, Rob Herring wrote:
>>>> On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
>>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>>
>>>>> When an overlay is applied or removed, the live devicetree visible in
>>>>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>>>>> changes.  There is no method for user space to determine whether the
>>>>> live devicetree was modified by overlay actions.
>>>>
>>>> Because userspace has no way to modify the DT and the ways the kernel
>>>> can do modifications is limited.
>>>>
>>>> Do you have an actually need for this outside of testing/development?
>>>
>>> I do not know if anyone uses /proc/device-tree for anything outside of
>>> testing/development.  If we believe that there is no other use of
>>> /proc/device-tree we can simply document that there is no expectation
>>> that accessors will see a consistent, unchanging /proc/device-tree.
>>
>> I didn't mean whether /proc/device-tree is used outside of testing. It
>> is. The question is whether any users care if there are changes
>> happening. If so what is the use case?
> 
> What is the point of looking at a devicetree if you don't know if it
> is in a consistent state or part way through a change?
> 
>  
>> kexec used to be one of the main users, but I think it has switched
>> over to the exported FDT which matches what the kernel was originally
>> passed.
> 
> Yes, last I checked kexec was using FDT from /sys/firmware/fdt.
> 
> 
>>>
>>> That would be a much smaller patch.
>>>
>>>
>>>>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>>>>> user space to determine if the live devicetree has remained unchanged
>>>>> while a series of one or more accesses of /proc/device-tree/ occur.
>>>>>
>>>>> The use of both (1) dynamic devicetree modifications and (2) overlay
>>>>> apply and removal are not supported during the same boot cycle.  Thus
>>>>> non-overlay dynamic modifications are not reflected in the value of
>>>>> tree_version.
>>>>
>>>> I'd prefer to see some sort of information on overlays exported and user
>>>> space can check if that changed. IIRC, Pantelis had a series to do that
>>>> along with a kill switch to prevent further modifications. At least some
>>>> of that series only had minor issues to fix.
>>>
>>> The kill switch addresses a different concern, which was from the security
>>> community.  The kill switch is on my todo list.
>>
>> Yes, but there could be other uses. It's not a big step from wanting
>> to know if the DT has changed to wanting to control it changing or
>> not.
>>
>> Perhaps the kill switch needs 2 levels: a temporary freeze and a
>> permanent freeze. In any case, they don't seem completely unrelated
>> and I don't really want to see userspace ABI added bit by bit.
> 
> I can add a kill switch patch.

The point behind the kill switch is to allow a way to disable modification
of the devicetree from userspace via an overlay manager.  Since there is
no userspace overlay manager, there is no need for a kill switch.  The
kill switch (or equivalent functionality) should be added as part of
adding the overlay manager, when that occurs.

Addressing adding userspace ABI bit by bit, any discussion of what the userspace
overlay manager interface will look like is purely conjecture.  I do not want
to wait till the overlay manager to be added before the current problem of
user space synchronization is addressed.


>>> I don't remember exactly what info the overlay information export patch
>>> provided.  I'll have to go find it and re-read it.
>>>
>>>
>>>> Also, shouldn't we get uevents if the tree changes? Maybe that's not
>>>
>>> Yes (off the top of my head).  But a shell script accessing /proc/device-tree
>>> is not going to get uevents.
>>
>> No, but userspace can get them. Accessible from a shell script is not
>> a requirement of kernel interfaces.
> 
> OK for now.  I haven't thought that concept through, but it is not key to
> whether this feature is useful.  The same functionality is also needed
> by programs.
> 
> I'll have to dig into the uevent implementation and architecture to see
> whether uevents are a possible solution.  This patch can wait for me to
> finish this.

Getting a uevent does not provide the information needed to ensure that
the devicetree is in a consistent state over a set of accesses to
/proc/device-tree (that is, a "critical section").


> 
> If the current patch ends up being the best method, I still need to
> re-work to add memory barriers (or somehow convince myself that they
> are not needed).

In the current version of the patch, I was reluctant to provide the
synchronization via a lock in the sysfs show function because I did
not find any documentation or discussion that assured me that a lock
was legal in that context.  I have since asked Greg KH if using a
lock for synchronization in the show function is ok and he assured
me that it is.  Based on that, I have a new version of the patch that
is conceptually cleaner, easier to understand, and easier to use.

-Frank

> 
> -Frank
> 
> 
>>
>> Rob
>>
> 
> 

