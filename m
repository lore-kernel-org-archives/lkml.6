Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2406913-1527409195-2-13722602001363939931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527409195; b=ZwLnWIwUW01h0hibc1toTsMSlrHRHa286HJQZEdT+KsJh/9KJc
    lRdAQ/KZWcejsO+pFDJfaC40tNoVXz9nC25fBlTBSZojZdXziTK4O2oc5Fy0gezb
    xt6VyPkrR0Cc3QYOlhbg/x8AWXU3NI0ZLHnACaehjmXzjSSimsTbQYNCyjrNSVP7
    nRA7mTlnV0tBWqTGAM+oZgSf34WDqVUJGgTC5AKjQAu/U84ZD5vrL3si+RwKCOuq
    mQArTVKrPSojG5hG4EuTsEC8x6jSJFE3CN3Imv/2V1UsJrRDHXy+ojyuMcDDC4b5
    dVj1WwwNaFD8ETXA2UeB7F31LUzuLpIdpwjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527409195; bh=RUspDzi3WoP3oUfJLf6dh4fn+SF1nDdL9lTBmJA7oQ
    k=; b=ldonDdNZ1b8sWvsmnB9l5ZiKSJ32O2NXcTUKRPBE6/orIfekCaJfZqa9Ey
    +NX2KQR5kai8YNmzROoqY7H6O7fgi/VDsbKC3hZF69nvx1u6QjgbDAYRU3DOhK49
    qwuyWckp//eM1AYYiIJVj+2gFMPjBfmKCqZvao+PE2qP4o/wswfS4r6MWIXQARnM
    FJm204nrW6+OSk2xnMun4sA1wzXjsfDdxAfEVGfCKNHfb0FRXFN/RY2mdKL4T6xv
    sCXUdNdG0XyGgDYqiy7seBH8RIHnUOmJnlLmSfNZ0w7qzr1ZQX0iakzSfKrP135o
    m3lgMiC/qHFEijolyhD0HPDkOGHg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=JohRsq2c x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Hm7HNzrJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=JohRsq2c x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Hm7HNzrJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMnjumBOud+VIaLILjlbTlTByDCA73sznytMemavdZlt9CatEBEup2XGDx4Uz9FTD/XXTOnZr4md3ETm436Z+Y2vwx10nltKcr20uiAtRL+AkjGybJ76
    MUo7gkXtmqbdARMOf2RmbTIrgYbe13mufsdjP0ShoesIgi19Ini79+E0xy7okO11M9NVmHXnbebfOdC/ZEaBnxYEbUnte6SEHdRfStcGXNf5goUUEI+A2ouW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=y8EzkcjMSMjKKJxtZpIA:9
    a=e5czT3ijOMwm85-v:21 a=O16LznvAYVD4OjnU:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934047AbeE0ITu (ORCPT <rfc822;linux@kroah.com>);
        Sun, 27 May 2018 04:19:50 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:37979 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933856AbeE0ITr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 May 2018 04:19:47 -0400
X-Google-Smtp-Source: AB8JxZpRA2TygeWtnl0I/ROitf3/V/Lez2dpELzeWTS5rr8a++0VCxPuLNgY4HiNOG+CE0Ij0KThnLhiw9i8SIdaVMU=
MIME-Version: 1.0
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
References: <1527285903-31799-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu_oNUmOwTgM9sAsfMn4WgY+grC2f12vRC4HH9CgxxkfXQ@mail.gmail.com>
 <FFF73D592F13FD46B8700F0A279B802F39481456@ORSMSX114.amr.corp.intel.com>
 <CAKv+Gu_eShqmjkDSXnFs-_Hcay67+JTMdb6TatNZpV2v5_MoaQ@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F3952F0CF@ORSMSX114.amr.corp.intel.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sun, 27 May 2018 10:19:46 +0200
Message-ID: <CAKv+Gu96gURHioy7hRLW2reyUwYMQDSLHhGE=m_TOz9CYF_Tjw@mail.gmail.com>
Subject: Re: [PATCH V4 0/3] Use efi_rts_wq to invoke EFI Runtime Services
To: "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc: "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        Will Deacon <will.deacon@arm.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Naresh Bhat <naresh.bhat@linaro.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27 May 2018 at 07:32, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > Assume some user requested to execute some non-blocking variant of
>> > efi_rts and the kernel hasn't called efi_call_virt() yet, but was
>> > scheduled out. IOW, even though user requests for non-blocking efi call, we
>> might still block. Am I right?
>> >
>>
>> No, that is the whole point. These functions may be called from atomic context,
>> which is why they trylock() and give up rather than block on the semaphore if a rt
>> services call is already in progress. E.g.,
>>
>> /*
>>  * efivar_entry_set_nonblocking - call set_variable_nonblocking()
>>  *
>>  * This function is guaranteed to not block and is suitable for calling
>>  * from crash/panic handlers.
>>  *
>>  * Crucially, this function will not block if it cannot acquire
>>  * efivars_lock. Instead, it returns -EBUSY.
>>  */
>>
>
> One more question again, if we are sure that non-blocking variants will
> _always_ be called in atomic context, then, we got it covered. Because, in
> set_variable() and query_variable_info() (both blocking and non-blocking) we check
> for in_atomic() and if so, we don't use efi_rts_wq (please refer to patch 3).
>
> If you think, there might be a probability of calling non-blocking efi_rts out of atomic
> context, then, sure! Let's make them never use efi_rts_wq.
>

This is not about what happens to be the current situation. It is about the API.

The non-blocking functions should never block, period. They either
fail gracefully or perform their duties without sleeping.

In this particular case, I think it is useful to have a guaranteed
non-blocking version, not only to delete the dummy EFI variable, but
potentially in other future cases as well, given that they can be
called much earlier in the boot (when the perf/%cr3 issue is not a
concern to begin with)
