Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82115C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F41B205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6DD9ZwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F41B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbeJZXMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:12:49 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:38219 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJZXMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:12:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id r22-v6so1442213qtm.5;
        Fri, 26 Oct 2018 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NlnsZzk42kHF/AFKOSNX4T3W+XEjbSfRuxSFB6yr1Cc=;
        b=C6DD9ZwYCT+IYTvqiZyvio+KzLd8zL9541E9LaWtU/GenNTqyOQTF6wAyaZXU21/7m
         26y01zrUPRAzc+0F/H5zm0scxITekdS70hlX99hnVmXWz/6y2CVklMoNy9G5P6QkZJiZ
         az3/GZUKhlodpHuvqtzjdi5EpubKEF3RcWDdt5Y+twe8S7ssk3MqvDgMMTpxm34UWczw
         1yG6cCttcKjlZLyniT5nzuJl8WMtf/brUIM/i+6QHGvLvTeApv4u90ambRKac/ZPqPpl
         6IARGgoxCTNo+aVCo1qammRRtXNBcZFEgv1AjQmED+vQljo3Ug8yrf2u1TOsNyZpgY0M
         oHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NlnsZzk42kHF/AFKOSNX4T3W+XEjbSfRuxSFB6yr1Cc=;
        b=ND6dB+u8rr6m+dY7C/iUblfEuXWmoR6gDCnK+YkHZ93oZkpmRpBeU7r0L7Yn2hWii+
         QTIMYeTmnuKR3f501Cgf1WRtMumcPdUQUm4bMmcjSupUlidnRNVL/+CglDCeF3lEleIE
         fBUdqERbS4sTi5nm+5jaY8okQQ9yEmc4Zx+2m+Wt2nEibsk7sE8STPesOYqHal7pCPhv
         GeE8BZOx5hF7eN2tPYdaCB5nTdI+HjNaS5Igdq9l5LjbZhp00ewOKqfbSTTyiCKv8wIG
         SJRcn4Ed9sE920aA1aPw+K8+lrwU3ofTv5sm6t9772yJz+D/6jc6YmGqoqnso2m5Eqbm
         9RGg==
X-Gm-Message-State: AGRZ1gLRWxTD7MglhJ11N+MZNBxtyuwBenfUB0TAiCMThzO7bEYmG3AU
        Ee4RVqmFMOGVBcahyc6BiK9k8ROEp2tzpY/fx2E=
X-Google-Smtp-Source: AJdET5cYG8qAwG9evy7iKNZrvkYWCuktacfzwW1mhhL4aYAfE9N+O0d7J5AA5IDARmYcOnCmdcGO065bw1MV3G081bg=
X-Received: by 2002:ac8:6899:: with SMTP id m25-v6mr3296809qtq.96.1540564529887;
 Fri, 26 Oct 2018 07:35:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:988d:0:0:0:0:0 with HTTP; Fri, 26 Oct 2018 07:35:28
 -0700 (PDT)
In-Reply-To: <512b7867-b809-9c10-88d1-7177bb522bc3@suse.com>
References: <1540378751.3008.59.camel@HansenPartnership.com>
 <CAK8P3a2R+5kLx=Fo2GTRagAk+4dPP-8GDfH9X7gCtQ7R8=bK_g@mail.gmail.com> <512b7867-b809-9c10-88d1-7177bb522bc3@suse.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Oct 2018 16:35:28 +0200
X-Google-Sender-Auth: Mdyx8dBjPnEnB0HShEIWfvm5E3U
Message-ID: <CAK8P3a1w1M+zWOm_F8jKigj8gvsZ3p-H1mj3JPokXX8-brL=eg@mail.gmail.com>
Subject: Re: scsi: myrs: warning fix, was: [GIT PULL] first round of SCSI
 updates for the 4.19+ merge window
To:     Hannes Reinecke <hare@suse.com>
Cc:     James.Bottomley@hansenpartnership.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18, Hannes Reinecke <hare@suse.com> wrote:
> On 10/26/18 10:16 AM, Arnd Bergmann wrote:
>> On Wed, Oct 24, 2018 at 1:00 PM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
>>>
>>> James Bottomley (1):
>>>        scsi: myrs: fix build failure on 32 bit
>>
>> Hi James and Hannes,
>>
>> Since James mentioned 32-bit compiles during the kernel summit,
>> I'd like to confirm that I hit this on my randconfig builder now,
>> with some latency since the last linux-next tree I tested before
>> flying to Edinburgh did not have the bug, and the latest
>> linux-next tree that is available now (dated last Friday) does, and
>> I see your tree is fixed. During normal times, I should catch these
>> within a short time of the patch getting into scsi-next.
>>
>> However, while looking at this bug, I found two more issues related
>> to the specific computation:
>>
>> percent_complete = ldev_info->rbld_lba * 100 /  ldev_info->cfg_devsize;
>>
>> I see that both rbld_lba and cfg_devsize are reported by the
>> device, but only the former is 64 bit but the latter is 32 bit and
>> also intended to be the larger of the two. I suspect this is a
>> bug, and the same is also present in the old DAC960.c.
>> cfg_devsize is followed by four reserved bytes in the header,
>> so I suppose it was meant to be 64-bit?
>> If you divide two 64-bit numbers, you also have to use div_u64_64()
>> instead of do_div().
>>
>> On top of that, I see we get those values from the device but
>> never do any endianess conversion on them. It seems likely
>> that they are all little-endian and require a le32_to_cpu()
>> conversion to also work on big-endian kernel builds. Alternatively
>> we could make the Kconfig symbol as
>> 'depends on !CPU_BIG_ENDIAN || COMPILE_TEST'.
>>
> It _really_ is questionable if these device ever work on big-endian
> machines, as they rely on the BIOS to start up the RAID engine; I've had
> a hard enough time getting them to work on normal machines :-)

Shall we add the Kconfig dependency then? I can send a patch for that.

> Plus the firmware refused to handle any drive larger than 4GB (!), so
> it's really a purely theoretical issue whether 'cfgsize' was meant to be
> 64 bit ...

I see. It was likely meant as a possible extension for future firmware
version then, which may or may not have been developed or released.
I suppose the do_div() could be replaced with 32-bit arithmetic, but
it's not in a fast path and James' version should be correct as well, so
I won't send another patch for that one.

       Arnd
