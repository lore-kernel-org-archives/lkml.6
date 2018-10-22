Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4CCC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD8E205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 07:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOIhIb2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FD8E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJVPrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 11:47:45 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38650 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeJVPrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 11:47:45 -0400
Received: by mail-wm1-f67.google.com with SMTP id 193-v6so9145640wme.3;
        Mon, 22 Oct 2018 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U7lCictn8XxVXuplwTIKKYedwak16VWup/ET8e7CcwM=;
        b=tOIhIb2DUi8LDi3o1X9D1jVA3ORI/IK/2v+qFKNJ+TsfYurrvut5AjxrAWhE8x+rax
         kR4Q5BUDl23+Vq7GKS3Uh+8UxUBr/fAe7sYgplqBfrEUlaezW+RSgA9rD3uDXYwDQBLk
         Y/wPYwWhulOf2svqdYPzs2gwRRmKUmTD17uFm/R8IX3kJVg/v3HCTPYpCJ8DmdB3QHHi
         oeEHhoWdrTAQB7KiFjTOhMmDgY3WR3XM9RfPLEqGKN5+HY/1JT18w/s8dugITjwPEQHZ
         O/ef79wCwZ4Ymr/Eg+qlLE0/nHcSG94eBe46ws9GNnWHZ2d0G3CvjaAnnJDT81WF18wv
         PtMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U7lCictn8XxVXuplwTIKKYedwak16VWup/ET8e7CcwM=;
        b=C5GmBLh9sgNCjBKNyrRLVCGlSDMFU90pb/igzL9FGLTAVq3sz0jmUyrZdL1uaYphS1
         vAuA3wFD5A7iz/Lgq2OxI8ie6ewpGzT2ZNT7C2P+X3LZhZzzQ7mta5LBwX0Ne1anMD5x
         XuRQCcxwm3ff2owWe+IxCIhzmv+4UV1IZQIjmKVmmJ9KQ6KyigRE/DMJ5TcmO7E0OWU6
         Yccl00dnbRO7IRU++CYwAWVoPikExUv+00j2BqdRaFsQMxIPioiQnT7Gf9SCXmS9lgJz
         JvpkQjjLl53pWyUnd9xcPeuVl7pNHAAWiYNlyN0DTNImNpB9RIdS8LleIqZW+yj1SYn/
         508A==
X-Gm-Message-State: ABuFfojrj2x34EOwQPFDQ4RCU5vR+RwTgwQiCE9wVl2VAXJFOepQ1bLe
        jIuiOX25fYAyQXyc1CVpZsk=
X-Google-Smtp-Source: AJdET5dq9r+b+uHKTzdh/e38iCWMJSDRe+5uV5AanWUoPmwG3LZQ/r/S2WRV/zYNgfVk1hqtbPiOvA==
X-Received: by 2002:a1c:f514:: with SMTP id t20-v6mr785945wmh.129.1540193423586;
        Mon, 22 Oct 2018 00:30:23 -0700 (PDT)
Received: from [10.15.240.222] ([109.144.218.139])
        by smtp.gmail.com with ESMTPSA id r8-v6sm30670700wrm.14.2018.10.22.00.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 00:30:22 -0700 (PDT)
Subject: Re: [PATCH v3] of: overlay: user space synchronization
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
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <399b1ed0-ac64-d962-5eea-23a99011aada@gmail.com>
Date:   Mon, 22 Oct 2018 00:30:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+=OiXTSSEr4QuiyqCzyrKdH0M8HhmOjVha3SWM5Y62Gw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/19/18 9:06 AM, Rob Herring wrote:
> On Thu, Oct 18, 2018 at 7:06 PM Frank Rowand <frowand.list@gmail.com> wrote:
>>
>> On 10/18/18 12:32, Rob Herring wrote:
>>> On Tue, Oct 16, 2018 at 05:34:26PM -0700, frowand.list@gmail.com wrote:
>>>> From: Frank Rowand <frank.rowand@sony.com>
>>>>
>>>> When an overlay is applied or removed, the live devicetree visible in
>>>> /proc/device-tree/, aka /sys/firmware/devicetree/base/, reflects the
>>>> changes.  There is no method for user space to determine whether the
>>>> live devicetree was modified by overlay actions.
>>>
>>> Because userspace has no way to modify the DT and the ways the kernel
>>> can do modifications is limited.
>>>
>>> Do you have an actually need for this outside of testing/development?
>>
>> I do not know if anyone uses /proc/device-tree for anything outside of
>> testing/development.  If we believe that there is no other use of
>> /proc/device-tree we can simply document that there is no expectation
>> that accessors will see a consistent, unchanging /proc/device-tree.
> 
> I didn't mean whether /proc/device-tree is used outside of testing. It
> is. The question is whether any users care if there are changes
> happening. If so what is the use case?

What is the point of looking at a devicetree if you don't know if it
is in a consistent state or part way through a change?

 
> kexec used to be one of the main users, but I think it has switched
> over to the exported FDT which matches what the kernel was originally
> passed.

Yes, last I checked kexec was using FDT from /sys/firmware/fdt.


>>
>> That would be a much smaller patch.
>>
>>
>>>> Provide a sysfs file, /sys/firmware/devicetree/tree_version,  to allow
>>>> user space to determine if the live devicetree has remained unchanged
>>>> while a series of one or more accesses of /proc/device-tree/ occur.
>>>>
>>>> The use of both (1) dynamic devicetree modifications and (2) overlay
>>>> apply and removal are not supported during the same boot cycle.  Thus
>>>> non-overlay dynamic modifications are not reflected in the value of
>>>> tree_version.
>>>
>>> I'd prefer to see some sort of information on overlays exported and user
>>> space can check if that changed. IIRC, Pantelis had a series to do that
>>> along with a kill switch to prevent further modifications. At least some
>>> of that series only had minor issues to fix.
>>
>> The kill switch addresses a different concern, which was from the security
>> community.  The kill switch is on my todo list.
> 
> Yes, but there could be other uses. It's not a big step from wanting
> to know if the DT has changed to wanting to control it changing or
> not.
> 
> Perhaps the kill switch needs 2 levels: a temporary freeze and a
> permanent freeze. In any case, they don't seem completely unrelated
> and I don't really want to see userspace ABI added bit by bit.

I can add a kill switch patch.

 
>> I don't remember exactly what info the overlay information export patch
>> provided.  I'll have to go find it and re-read it.
>>
>>
>>> Also, shouldn't we get uevents if the tree changes? Maybe that's not
>>
>> Yes (off the top of my head).  But a shell script accessing /proc/device-tree
>> is not going to get uevents.
> 
> No, but userspace can get them. Accessible from a shell script is not
> a requirement of kernel interfaces.

OK for now.  I haven't thought that concept through, but it is not key to
whether this feature is useful.  The same functionality is also needed
by programs.

I'll have to dig into the uevent implementation and architecture to see
whether uevents are a possible solution.  This patch can wait for me to
finish this.

If the current patch ends up being the best method, I still need to
re-work to add memory barriers (or somehow convince myself that they
are not needed).

-Frank


> 
> Rob
> 

