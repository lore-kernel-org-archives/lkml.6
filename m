Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E611EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1332086A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 13:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUuaJYs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE1332086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729924AbeKEXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:11:26 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39494 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKEXL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:11:26 -0500
Received: by mail-qk1-f196.google.com with SMTP id e4so14693267qkh.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 05:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xkosleulG3JXCOYkWyXDfCwTpAjMrSZKbQYqjNHEjLo=;
        b=ZUuaJYs8moHi4C4/+JQnVsJdfoMHiXibncYRDtFGE7JsV8fiB7kwiBoZFDcxEwYgSD
         gZqxYbN7YNWwVb/pLIbStW9zr7obfnaWeRqF7ZY2cbBq+X1TavcloN282zQY/wbayI1L
         EqHyAedLKiWCgUE690ki9I6E1+/Q7ZtTjNa5/uH4RttXsKND9/qgMH219HUyVah0QXys
         9u4S2anYDMq29bdxzFcPZTi8uDHFZvler9RqNsL89LZRrvVC6rcHE7j0UTZIj24lvNS+
         fFJrbr5um5AQ3CmwpoFgQAD3V2aM0QC64ix9o0v6ZRjFK08rHRodDscUav2EKgQ1X3Z+
         7f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xkosleulG3JXCOYkWyXDfCwTpAjMrSZKbQYqjNHEjLo=;
        b=TikAEl7yczpH04r/uFPk++BPwo71UbLvkzEUAv79RvgAvmqQFTmt8lxVJrNvc90AgD
         zemkYBHC+N6zsCDidzNnsLLKUXe2Vf1KS3oGZCpiqTxkTon35GmfnPP74pfRfQ11hwY3
         DUL4BaBjVX7Va+Yrn7rGwmPNHCdTLdTvpD5cHU/C1K14L2MvDFnMPRDrizEeTh6fzBF6
         5aIYk28yyZpDljXhoXz1YwGUHL6pUT2iMgOCIYzTg3RQjNCWRJaqRzeDFWCcA04OEBVL
         DutBuHEd5hnj4wWHGjdXyFD+7bObU6it9whHBrsernTGvqu19xGFR+VZIDt/9xQV5c9j
         6esQ==
X-Gm-Message-State: AGRZ1gLj24mi8ge/Tc981/dMxyKTo1wAPa8uTUFBeWcV7ZWVznAsdDOS
        UlKd2jqrkCNkUljEliAan+o/Lh850S6LbU16g6w=
X-Google-Smtp-Source: AJdET5dL2IAwW3iokujRJKl6sLUkshy9GyWnWB4sg6tQpf1Vl+WEWZIllFrQFES34y/l+ud4ijiDEjPAJfh/boNKNc0=
X-Received: by 2002:a0c:d992:: with SMTP id y18mr22061687qvj.161.1541425894314;
 Mon, 05 Nov 2018 05:51:34 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a0c:9881:0:0:0:0:0 with HTTP; Mon, 5 Nov 2018 05:51:33 -0800 (PST)
In-Reply-To: <20181105090852.GA14924@infradead.org>
References: <CAAhSdy0Y_jdc=2Lf8epof_+7HigCfhDxMNe8EF0fHfncqhs-zA@mail.gmail.com>
 <mhng-01f0ac6a-c2fd-41be-9d53-44d1c139d453@palmer-si-x1c4>
 <20181101174857.du2zu4vnrhpu5asf@excalibur.cnev.de> <20181105065807.GA1286@andestech.com>
 <20181105070551.GA7274@infradead.org> <CAK8P3a2c98VVPArCkdAR=-nnDBq1gYRCLDDgQB71eGiTSRdb4A@mail.gmail.com>
 <20181105090852.GA14924@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 5 Nov 2018 14:51:33 +0100
X-Google-Sender-Auth: UVcM89bK9AjWEg2bVYa3d_3uM7U
Message-ID: <CAK8P3a2MSK-S+AzDGjq6t8WjcKrkj0XmynNL+fMPvL=JgnoEVA@mail.gmail.com>
Subject: Re: [RFC 0/2] RISC-V: A proposal to add vendor-specific code
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vincent Chen <vincentc@andestech.com>, aou@eecs.berkeley.edu,
        alankao@andestech.com, greentime@andestech.com, palmer@sifive.com,
        linux-kernel@vger.kernel.org, zong@andestech.com,
        kito@andestech.com, linux-riscv@lists.infradead.org,
        deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/18, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Nov 05, 2018 at 09:52:52AM +0100, Arnd Bergmann wrote:
>> > I fundamentally disagree with this=E2=80=A6 and think it should be the
>> > contrary.
>> >
>> > 1. The kernel shall support no vendor specific instructions whatsoever=
,
>> > period.
>>
>> I think what was meant above is
>>
>> 1. If a vendor extension requires kernel support, that support
>> must be able to be built into a kernel image without breaking support
>> for CPUs that do not have that extension, to allow building a single
>> kernel image that works on all CPUs.
>
> No.  This literally means no vendor extensions involving instructions
> or CSRs in the kernel.  They are fine for userspace, or for the M-mode
> code including impementation of the SBI, but not for the kernel.

I was trying to interpret what Vincent wrote, not what you wrote,
you were pretty clear already ;-)

With the stricter policy you suggest, we'd loose the ability to support
some extensions that might be common:

- an extension for user space that adds new registers that must be
  saved and restored on a task switch, e.g. FPU, DSP or NPU
  instructions. ARM supports several incompatible extensions like
  that in one kernel, and this is really ugly, but I suspect RISC-V
  will already need the same thing to support all combinations of
  standard extensions, so from a practical perspective it's not
  much different for custom extension, aside from the question
  how far you want to go to discourage custom extensions by
  requiring users to patch their kernels.

- A crypto instruction for a cipher that is used in the kernel
  for speeding up network or block data encryption.
  This would typically be a standalone loadable module, so
  the impact of allowing custom extensions in addition to
  standard ones is minimal.

       Arnd
