Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B84AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3787E20863
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iawOKUse"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3787E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGIV2u (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:28:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43583 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeGIV2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:28:48 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so38626201oib.10;
        Mon, 09 Jul 2018 14:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RPKUhfdS7MBupVqAKIJje+fwONiQ0Jn1NjQyDZ7cduk=;
        b=iawOKUseT7nA8gDwu47DtvcynxQGd5Cv7dm7cxAF/xtl0uMsXl117Zo0t1mNDKhgdG
         slN+ceYHX7zisVDE1dN7/xZVSy8JuM2eSQqfZZQl/i8qphXKrzBtPTGqHKSS48fOE66r
         Nbf7gMOjXbOWRdWg318ycWCu/xXhVOl2NTOw/s+qYHGdMj4vGmGjTapF4VfZ8+yb/i7Z
         KNR2zYkqnmOek9y2BC5z1/QkWnvOeMM8XnWAXbYaFcmgWHZ9m1vovwhTY7ahvNTe+PHr
         +VdkUfSQHjHEkh5GjOhIUU706FlW3kGlm6gWuu9o4+dMLT8d7lUKWhfHnjdAuFajt0HO
         InNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RPKUhfdS7MBupVqAKIJje+fwONiQ0Jn1NjQyDZ7cduk=;
        b=MDCwC0JcKf/S/2Yt9gSOUPwF9mi/Qg/irMDASVnxsk9zYrVBlGvqhmNE3ulWzH18zq
         fVbA/naF3C/NBZ9OTG/uYE05KlKP8rvsJjDFChiH9YCk5yRj7p1Ew11dBv7NGHWjkMsF
         fVfksmfhf6EQTmB3bE8dsUgFQovCoDNJGXTY7YWW0mlJlMxw2zpUqo0bMZN6ZHHVAZiO
         LPrnk6S+WJ4bfi0vhj69UlcGapFMOtSwddmwwclPmlAziuiD1hlg6LmgaHfw9sGcuvMM
         R0Xcc2q2I5bQ5pWhMiaeb2/xLSwJk40JK6kyLPF3/xzUKlo9athy9cdkrRcxx9ukIQiB
         Hiug==
X-Gm-Message-State: APt69E0MmT9mJ1zzP7YjP9CodcdKKttZEnBU5263Yk0xKMVSxUrhSPgG
        W47QlFgTs2MLpoilwcb+El6ls6SBs0IDYiRd39k=
X-Google-Smtp-Source: AAOMgpdAcg6TQqhhSc0kKJSiM8iESGAVCoNGrPRtYKaWg1PLWfyNRVNWfaYJJSYrXfhAaO5cZ7pypyFVEhoYcA+Gj7A=
X-Received: by 2002:aca:ccc4:: with SMTP id c187-v6mr23278568oig.282.1531171727524;
 Mon, 09 Jul 2018 14:28:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Mon, 9 Jul 2018 14:28:47 -0700 (PDT)
In-Reply-To: <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com> <6074707.jx9F3QFrWC@aspire.rjw.lan>
 <f89404f9-fd54-cc2b-4fbe-f1feba4e5364@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 9 Jul 2018 23:28:47 +0200
X-Google-Sender-Auth: qwmWPJal8K-YhZ7Dag-Xu-SsjEc
Message-ID: <CAJZ5v0gcr2JjgTe6VwtJxw3yY+ZiPOZpQyjR0FokPM+RzDXJpg@mail.gmail.com>
Subject: Re: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 10:45 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Hi,
>
> First thanks for the patch..
>
> On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
>>
>> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
>>>
>>> Hi,
>>>
>>> I'm experiencing two problems with commit 5088814a6e931 which is
>>> "ACPICA: AML parser: attempt to continue loading table after error"
>>>
>>> The first is this boot failure on a thunderX2:
>>>
>>> [   10.770098] ACPI Error: Ignore error and continue table load
>
>
> [trimming]
>
>>> ]---
>>>
>>> Which does appear to be the result of some bad data in the table, but it
>>> was working with 4.17, and reverting this commit solves the problem.
>>
>>
>> Does the patch below make any difference?
>>
>> ---
>>   drivers/acpi/acpica/psobject.c |    3 +++
>>   1 file changed, 3 insertions(+)
>>
>> Index: linux-pm/drivers/acpi/acpica/psobject.c
>> ===================================================================
>> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
>> +++ linux-pm/drivers/acpi/acpica/psobject.c
>> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
>>         ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
>>         walk_state->aml = walk_state->parser_state.aml;
>> +       if (!walk_state->aml)
>> +               return AE_CTRL_PARSE_CONTINUE;
>> +
>
>
> Well this seems to avoid the crash, but now it hangs right after on the
> "Ignore error and continue table load" message.

Well, maybe we should just abort in that case.

I'm wondering what happens if you replace the return statement in the
patch above with

return_ACPI_STATUS(AE_AML_BAD_OPCODE)


> I would post the DSDT but
> I'm borrowing this machine, and I understand the firmware to be an early
> release, so...

Please send the output of acpidump from it to Erik in private.  That
will help him and Bob to make the code more robust.

> Anyway, now that I have access again, i'm turning up the debug messaging,
> let me see if that points at whats causing the hang.

OK, thanks!
