Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CBEC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6C620871
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 11:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gEb2w0bC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D6C620871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753880AbeFTLVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 07:21:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36610 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752798AbeFTLVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 07:21:37 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so6176998wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 04:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kfuM+QqMo8C47J35MPSRaW1g1Bmx4l235kl4ixxHm8k=;
        b=gEb2w0bC3nH3yzR9db1B3GJTar8YvBByQDfucra1pRyioxqUKYxUTYtrUiCpSpXw5K
         Rq1Y2vLphRnlIFHaa7kNZZl8Fb3dleVMwEKqizufHHheyEWUsApANI0iJOlNHK2sZZQG
         opspJERSYeFG5u88ZacbPccMQhlBZIx5pFBiQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kfuM+QqMo8C47J35MPSRaW1g1Bmx4l235kl4ixxHm8k=;
        b=gCgzzEta8r4eG+dvFxP4ZKEP2H+e8O2fsJkHgsd2kbrlNXfydeCT/LuTnNV+cGUeHG
         EzvjsOybfxgjLOfvMwq3J7nsld/kRomHuuGP0QeNlxaIf5hHtAFJXORQ0uPBxthyRL+X
         VFnh9aDTfORTaP6ywLOAjQzAjq3D+nbdhDGfc0hZdVLVNtemH1mzWm6qoImOMRfoamMN
         x6vJfpdKstznWi/LGx7n/xfSeqwSZqf3VE4FKRjDpZgYMotHaJ8go82EhOrlA6DtB8h0
         pZ+eoM/6ZWWJY8ln2UT1O9Qf58582Yk6Npji+8CPRSG+XKOK8aAL2h9YiVhyD/tFqjSs
         dptQ==
X-Gm-Message-State: APt69E0H0BUc2asOxFN1kZtOonV+pAsP+l9C+Ng8pnJFAZ0pumq7bDRz
        bSgcLtegMziHs9i+4ZyLoD4hya0v8ESaNXYKk5+0hg==
X-Google-Smtp-Source: ADUXVKKExfP8CK2dRv79qVXzFWqFohOm7SGUXRUtHYJ6OD3RPZkYY7NlaJQNrdMwRhVijrTmvQLXoq6dSw9JjCfKR1k=
X-Received: by 2002:a1c:3ac6:: with SMTP id h189-v6mr1515492wma.64.1529493696084;
 Wed, 20 Jun 2018 04:21:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c389:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 04:20:55
 -0700 (PDT)
In-Reply-To: <CA+G9fYtoML7G7f_sXB6hQJJAQOG94TsBXujmQgHxy-rKABaTtA@mail.gmail.com>
References: <CA+G9fYsRgGsmi-tE8dU=pfSDDLg3bUuii_0KUPZ71jFLNre-5g@mail.gmail.com>
 <20180620072138.yrz76kmms3oviv7i@linux-d8ym> <CA+G9fYtoML7G7f_sXB6hQJJAQOG94TsBXujmQgHxy-rKABaTtA@mail.gmail.com>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 20 Jun 2018 08:20:55 -0300
Message-ID: <CADtBP2CBSLCJEvUk-kkF3LKKfoYBgQ7ch-+QhdxCJeLF8fm-dw@mail.gmail.com>
Subject: Re: LTP CVE cve-2017-17053 test failed on x86_64 device
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     mmoese@suse.de, dave.hansen@linux.intel.com, ltp@lists.linux.it,
        open list <linux-kernel@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>, ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I believe the error message on boot is solved by LKML thread:

[PATCH] locking/rwsem: Fix up_read_non_owner() warning with DEBUG_RWSEMS

Looks like that is what is tainting the kernel.

On 20 June 2018 at 08:11, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> On 20 June 2018 at 12:51, Michael Moese <mmoese@suse.de> wrote:
>> Hi,
>>
>> On Wed, Jun 20, 2018 at 12:14:22PM +0530, Naresh Kamboju wrote:
>>> Test FAIL case output,
>>> tst_test.c:1015: INFO: Timeout per run is 0h 15m 00s
>>> tst_taint.c:88: BROK: Kernel is already tainted: 512
>> The kernel is already tainted. In this case, the test refuses to run,
>> because it could not tell if the test is pass or fail.
>>
>> Could you please check if you could run the test directly after a
>> reboot?
>
> This single test ran immediately after the boot and bug reproduced.
>
> tst_taint.c:88: BROK: Kernel is already tainted: 512
> https://lkft.validation.linaro.org/scheduler/job/293222#L1204
>
> Test command for 10 iterations and it failed for all 10 iterations.
> + ./runltp -s cve-2017-17053 -I 10
>
> NOTE:
> We still see kernel warning while booting the x86_64 machine.
> DEBUG_LOCKS_WARN_ON(sem->owner !=3D ((struct task_struct *)(1UL << 0)))
>
> - Naresh
>
>>
>> Regards,
>> Michael
>> --
>> SUSE Linux GmbH, GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norto=
n, HRB 21284 (AG N=C3=BCrnberg)
