Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7FE4C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6383224C34
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFsEhnU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6383224C34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933677AbeGCHvx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 03:51:53 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42713 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932142AbeGCHvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 03:51:50 -0400
Received: by mail-oi0-f68.google.com with SMTP id n84-v6so1942874oib.9;
        Tue, 03 Jul 2018 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=pQeYGCzlxJmf/QzsmveT9ytBUQMwJrIgK3QOhQVUm3A=;
        b=MFsEhnU3q7mBw7w72RLKRhfVgcL+AmqCHovr4e+9EYtJJM6EeGihoB2fRzWdxlLl8o
         bWReMbe7T7gPGQsBb/gzTx7RHOwB0QU5VoBtrGydlNRiVF6tlA7+RKfjpGmbmqqIL4Pq
         DpxsIrsaVuqNaUU42ezYwelp8dh5rBCqgc9VcuBQ9GOzMflrYh5vzzC0TPyT8kNlPzSp
         e8WfWpI3fnyTE4G2KAeSj4ucm/H8QWGNpE++jKWl47/8iC6kgJefzWPGn4s+2VVWkBHc
         fMD53SoZb66BWtBD2J5ulcF8OdqZViPEc/6UKjlwV/wtR0WdvgNlhAbhL38k7Yq+9RMw
         cRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=pQeYGCzlxJmf/QzsmveT9ytBUQMwJrIgK3QOhQVUm3A=;
        b=f4UMAuWj7fcSpqZhEiCgcyEXnj6PK7cvZ1qXLXBKMYC9LkmBIUkrwRB7jdAbK8NSSJ
         XzdPCop0ujdGPqa2YXrQf7SdcFi9IpM8DZYBo9a0bIaU2AaOK2xkPy+Ifywv8StbTJSR
         RXxRNKt2XTxy/rlPPd2Nwabp+zT0XzDo6V2ngnWduuoUczYhiCF95lejQl7nXwVUR9pg
         QxwdxDQEPpP/jIK6rqGvxcJJtNvuQ46jWAzrEZ5PwDjVHIgdGNcARtoB3+YylcfaCc/5
         9CmlE/NpFiiPk4NmSTGSU+GXlmM5rT+TNTcoHqBYdME+QNt+DvhBjSjDqChd2xlStxMV
         DXTQ==
X-Gm-Message-State: APt69E0U7Jmho+z+W1vll2+asS3XTe6Bx8N+mwgTW2kjI/xGkLdvL4Lt
        8uc48zGT96JtIBo/mHAc4bpYTce2HYOLJ3xOzHY=
X-Google-Smtp-Source: AAOMgpfRua9mWB19JT7C5sVTNGt4M1fFa2zqRPMsFkY+ilRoG+c61D/S9YXPJm6W9/hbIUQcqchK3AjnQeJ2xGhxn5M=
X-Received: by 2002:aca:5b0b:: with SMTP id p11-v6mr12483223oib.116.1530604309167;
 Tue, 03 Jul 2018 00:51:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1427:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 00:51:48 -0700 (PDT)
In-Reply-To: <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com> <CAJZ5v0h5+O8xf_EqRPfdvtjQ7BvxLp8veaxB-7WsD8wq7RUFpA@mail.gmail.com>
 <9a9ef2bc-a66f-2af7-8766-b74426f062a6@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 3 Jul 2018 09:51:48 +0200
X-Google-Sender-Auth: 2pK6yGzz4g9T7BYF96zbj3KLX58
Message-ID: <CAJZ5v0j+9QOw1s3W07QRPDRydsdw7uSAgpvOwF_5302+zeViOg@mail.gmail.com>
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:30 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
> On 07/02/2018 04:52 PM, Rafael J. Wysocki wrote:
>>
>> On Mon, Jul 2, 2018 at 11:41 PM, Jeremy Linton <jeremy.linton@arm.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> I'm experiencing two problems with commit 5088814a6e931 which is "ACPICA:
>>> AML parser: attempt to continue loading table after error"
>>>
>>> The first is this boot failure on a thunderX2:
>>>
>>> [   10.770098] ACPI Error: Ignore error and continue table load
>>> (20180531/psobject-604)
>>>      [   10.777926] Unable to handle kernel NULL pointer dereference at
>>>      [   10.950199] Call trace:
>>>
>>>      [   10.952663]  acpi_ps_peek_opcode+0x1c/0x40
>>>      [   10.956797]  acpi_ps_create_op+0x54/0x278
>>>      [   10.960842]  acpi_ps_parse_loop+0x1b4/0x6c8
>>>      [   10.965063]  acpi_ps_parse_aml+0xe0/0x2b4
>>>      [   10.969108]  acpi_ps_execute_table+0xa0/0x104
>>>      [   10.973505]  acpi_ns_execute_table+0x120/0x194
>>>      [   10.977989]  acpi_ns_parse_table+0x34/0x68
>>>      [   10.982122]  acpi_ns_load_table+0x4c/0xbc
>>>      [   10.986169]  acpi_tb_load_namespace+0x1d4/0x240
>>>      [   10.990744]  acpi_load_tables+0x50/0xbc
>>>      [   10.994614]  acpi_init+0xb8/0x374
>>>      [   10.997959]  do_one_initcall+0x54/0x208
>>>      [   11.001829]  kernel_init_freeable+0x224/0x300
>>>      [   11.006229]  kernel_init+0x18/0x118
>>>      [   11.009747]  ret_from_fork+0x10/0x18
>>>      [   11.013354] Code: aa0003f3 aa1e03e0 d503201f f9400661 (39400020)
>>>      [   11.019535] ---[ end trace 2bd8068593cf8acc ]---
>>>      [   11.024195] Kernel panic - not syncing: Fatal exception
>>>      [   11.029488] SMP: stopping secondary CPUs
>>>      [   11.033480] ---[ end Kernel panic - not syncing: Fatal exception
>>> ]---
>>>
>>> Which does appear to be the result of some bad data in the table, but it
>>> was
>>> working with 4.17, and reverting this commit solves the problem.
>>
>>
>> But this commit fixes another regression which was more widespread.
>>
>> Apparently, we can't work around all of the errors in the tables out
>> there at the same time. :-/
>
>
> NP, Let me see if I can come up with a way to harden the
> parse_loop/create_op code enough that it doesn't crash the machine.

Sure.  I'll look at it too.
