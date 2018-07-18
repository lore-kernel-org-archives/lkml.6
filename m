Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1632DECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB2A2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCB2A2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbeGROoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 10:44:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33720 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729333AbeGROoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 10:44:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id s12-v6so4231483ljj.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 07:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=O8BaYOu5SbHyO8N5K98eagX0iw+1ClmX460ELB1HzEg=;
        b=MPvI/7Y9WBF3aQ0p4p8OQzb/s4mM42IK28vTBnZH+VOeIL96/74rU4as4dIQXf/l/M
         mNPDv4NKzxPCli3RQHwDFBff3PklIvzFpJk/BGhbR+W87kTSzLjXW+v0YALb2Lb5nG1D
         fTJCrQYyHuh+erRYz5ValtZ23qjJBaLFTFUDoRVt5Jq0Pbk6qE44+tZjHUQPQe8a1/Cy
         6nePYAk0QWVoFcgQNlpCsCNvmUrzZeRxoYIv7uCCuGR3H8vYjyqM5sJCwthO4v3v+dcn
         Ft9GhHH4ko+qrex9KOSJHLH9tc0DATB1kq27KOT7OHMUvubyTGt23SkB7FkXZizZf6Uk
         C/xw==
X-Gm-Message-State: AOUpUlG3f1svJUmAdjxUEuJYO7DgdygLa4xDBc/I8DF35bLjHpIBHN65
        4Cuq2KtB6MqAUth8EGhLl7gn4/bjAo1oOYr2nx95QQ==
X-Google-Smtp-Source: AAOMgpdorSGRtnK+08EioHv1U/+VC87chEnOLbtpn7UAc6hYzJh+yYiUDfyS8gGs4bibdOt8577oCW1av2puWNcsqGQ=
X-Received: by 2002:a2e:2282:: with SMTP id i124-v6mr1031823lji.11.1531922764956;
 Wed, 18 Jul 2018 07:06:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:4e8a:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 07:05:24
 -0700 (PDT)
In-Reply-To: <20180710151656.5ecaae11@lwn.net>
References: <CAF1GLkkzSzUnGKprz9CroVv=xBoUaym53PUTgi1RDNiEmr6PWw@mail.gmail.com>
 <20180710151656.5ecaae11@lwn.net>
From:   Prashant Dhamdhere <pdhamdhe@redhat.com>
Date:   Wed, 18 Jul 2018 19:35:24 +0530
Message-ID: <CAF1GLkk6fUbpdJhfNYhDL7NBf+chvv0H5SR-9_ofTrcHmqgDfQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: proc.txt: Adding 'HardwareCorrupted'
 parameter and description.
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 2:46 AM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Tue, 10 Jul 2018 20:05:22 +0530
> Prashant Dhamdhere <pdhamdhe@redhat.com> wrote:
>
>> Signed-off-by: Prashant Dhamdhere <pdhamdhe@redhat.com>
>> ---
>>  Documentation/filesystems/proc.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/filesystems/proc.txt
>> b/Documentation/filesystems/proc.txt
>> index 520f6a84cf50..b2fa7e7c4300 100644
>> --- a/Documentation/filesystems/proc.txt
>> +++ b/Documentation/filesystems/proc.txt
>> @@ -870,6 +870,7 @@ Committed_AS:   100056 kB
>>  VmallocTotal:   112216 kB
>>  VmallocUsed:       428 kB
>>  VmallocChunk:   111088 kB
>> +HardwareCorrupted:   0 kB
>>  AnonHugePages:   49152 kB
>>  ShmemHugePages:      0 kB
>>  ShmemPmdMapped:      0 kB
>> @@ -915,6 +916,8 @@ MemAvailable: An estimate of how much memory is
>> available for starting new
>
> This patch, too, was corrupted by your mailer.  Please resubmit it after
> fixing the issue (and with a changelog, please).
>
> Thanks,
>
> jon


Hi Jon,

I have resubmitted this patch with a changelog, please review and share feedback
so that I will be able to submit other patches.

--
Prashant

>
>>         Dirty: Memory which is waiting to get written back to the disk
>>     Writeback: Memory which is actively being written back to the disk
>>     AnonPages: Non-file backed pages mapped into userspace page tables
>> +HardwareCorrupted: The amount of RAM/memory in KB, the kernel identified as
>> +              corrupted.
>>  AnonHugePages: Non-file backed huge pages mapped into userspace page tables
>>        Mapped: files which have been mmaped, such as libraries
>>         Shmem: Total memory used by shared memory (shmem) and tmpfs
>
