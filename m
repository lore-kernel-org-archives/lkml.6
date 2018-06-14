Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0D1BAC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B519F208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfp90U9Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B519F208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755208AbeFNRZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 13:25:09 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:37846 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeFNRZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 13:25:05 -0400
Received: by mail-ua0-f195.google.com with SMTP id l14-v6so1229396uao.4;
        Thu, 14 Jun 2018 10:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EEzFuFrjC/qPr5tMiJ/Kj/mh8GlxzPsJcMQwQRMZSzs=;
        b=vfp90U9QjyVgoY0ty0gqtpxqWP2tp6L9Ws0AicACd5d2872zHj/QCQwMU8hKN+9q+g
         ulOeNpQtefJn89AYITiglTt5uYAQqrqyXHXWORxxo9o1zfbvplAOdXXrBZBRpglCzYDE
         3TUMfqO7khUR9EJOeXT+Qsd5jhHu6KcTRrG9ezthhqNUxWAFpr30q3+7/V8nuTWFlIC2
         amm91FYHXdUxb9U7ywLvA+2gTLFjayBojWxRYZlWT9xfrd2SXDUhaaAu/ajfHE7nSVAY
         R07TP5N1c8n4z0HjyhcH+sopIU52+32H5W2MKO1IeVbRoGIM+9G25PKxMtQLh6HARNHe
         mtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EEzFuFrjC/qPr5tMiJ/Kj/mh8GlxzPsJcMQwQRMZSzs=;
        b=M0bMV/0hxOvNXyQc7mkEpBvKOtV2qAx+WbeTh2/axluxH67uTlcwPGbSvAWiO47qGF
         wfSQweRN4ZQnGrF1RDY6RAuNEhYXUO+cHRfgoQo/aOBK488/rLFwJaeJjX5ZpHlLgb39
         bWgnwsaMTxP7aLuW2JjWaO/SuQKHJkzMitUYy8UBZuqiqGFPiq1M6p6fhpghMjVow5ry
         uWRqc4QHngNEoaSSYy+KN0YNBldDk8upXRQtdZkuLMCKQ0S5byAX3tnsq8+yRc1NF2lS
         1r3IZabBTslyLBoEQe8svAMAulCFwNYUI0XV/wX/jS7dGgZDvEArTJ3zN3+EDzBt7Nad
         xgcw==
X-Gm-Message-State: APt69E21F3kmheqKNxX3HjT3gX0TdWe6LsPNB8Fz0/wC4qwuEkGjclkI
        Ydq2Rcq80OmN/Yq74cIcgS0itiNCsTFclkKoUBE=
X-Google-Smtp-Source: ADUXVKLMQ2vFaLPir2/S8aa6ck3zv4O6RZWxSMQBBx13elH6RPxFyETv8Fo23/XSRmR0LcMMmw5UcfoTpCW1eHsO6u0=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr2299195uai.47.1528997104112;
 Thu, 14 Jun 2018 10:25:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 10:25:03
 -0700 (PDT)
In-Reply-To: <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
References: <45b8bde6-aaa8-3f3f-0528-81e5e931751c@gmail.com>
 <bc6846e1-2b6d-dcc2-355c-2699aa1607a2@gmail.com> <CAHp75Vdmqm+r=Orxs6_dCr18y+EwEQ=s-7UgaZKHuKbtjMcOig@mail.gmail.com>
 <20180609010420.GA112645@localhost.localdomain> <CAHp75VcA5ZWahraDP69_hBHuqxw6cng93zAa1op5EBYfuCSPwg@mail.gmail.com>
 <b59027b3-a48e-f168-5f12-c67758c0c2c7@gmail.com> <CAHp75VcK78jL_7sF+ZGaPpwDED-6Xd+SdH_5WCfSBsVJW2GnDg@mail.gmail.com>
 <8307f1e0-c480-3f78-9327-e248208e5349@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 14 Jun 2018 20:25:03 +0300
Message-ID: <CAHp75VdTGXqE__VHjRphEmpMVfxaVVik=u-_0NRhQAKeq=+ZKA@mail.gmail.com>
Subject: Re: [PATCH v3] dcdbas: Add support for WSMT ACPI table
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>, Douglas_Warzecha@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>,
        Jared.Dominguez@dell.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 5:22 PM, Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
> On 6/13/2018 3:54 AM, Andy Shevchenko wrote:

>>> +                * Provide physical address of command buffer field within
>>> +                * the struct smi_cmd... can't use virt_to_phys on smi_cmd
>>> +                * because address may be from memremap.
>>
>> Wait, memremap() might return a virtual address. How we be sure that
>> we got still physical address here?

> Before this patch, the address in smi_cmd always came from an alloc, so
> virt_to_phys() was used to get the physical address here.  With WSMT, we
> could be using a BIOS-provided buffer for SMI, in which case the address in
> smi_cmd will come from memremap(), so we can't use virt_to_phys() on it.
> So instead I changed this to use the physical address of smi_data_buf that
> is stored in smi_data_buf_phys_addr, which will be valid regardless of how
> the address of smi_data_buf was generated.

Yes, but what does guarantee that memremap() will return you still
physical address?

>>> +               return 0;
>>> +
>>> +       /* Scan for EPS (entry point structure) */
>>> +       for (addr = (u8 *)__va(0xf0000);
>>> +            addr < (u8 *)__va(0x100000 - sizeof(struct smm_eps_table));
>>
>>> +            addr += 1) {
>>
>> This wasn't commented IIRC and changed. So, why?

> I changed this is response to your earlier comment (7 june)... you had pointed
> out that it would be better if I put an "if (eps) break;" inside the for loop
> instead of having "&& !eps" in the condition of the for loop.  I put the note
> "Changed loop searching 0xf0000 to be more readable" in the list of changes for
> patch version v3 to cover this change.

Thanks, but here I meant += 1 vs += 16 step.

-- 
With Best Regards,
Andy Shevchenko
