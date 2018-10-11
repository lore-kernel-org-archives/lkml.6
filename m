Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D01C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7C2147C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:09:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfJFgn4N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CC7C2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJKWgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:36:55 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36048 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJKWgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:36:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id u34-v6so10210575qth.3;
        Thu, 11 Oct 2018 08:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=6fyBKo3p+nmWO0X4EkQ+MqBE6xdG+nrJ04XKECL0ip0=;
        b=XfJFgn4NCOSSyEyVR/1W6KPYkzujjm6HitbTuFhD3MRrs02N3J6xzypGufmcWN9gWh
         phz5B9l1+QP0H0GWaBXUQ0Htk/SnAtZgNMWzg0sMMuVmjLBgTB+VThsaYRcfGXUjTzX+
         HeZxLGZf6vMhxC3luPViPNw5M3glC1H5fr5YwaDCQ+VDi+lFcMcbx+whdnmTI2Jtp0Xi
         s5xXsfA/ynj3wMjuchC3sOGAsRu93Ho+YIz501exI99lAPv6H0obZGfbNeUY1h+OLwli
         ic9HwnNIGRrVxjXUbhYRDRQbhdIw4UI10eGUHxavCK9ozSC5WaSzR66YgGdx/peowNLe
         U9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=6fyBKo3p+nmWO0X4EkQ+MqBE6xdG+nrJ04XKECL0ip0=;
        b=faGG1doZwDNVPWMqXzMWBe9GN0QilBHUPixSsBMbufzGNI2hSlInuJ3+8zPkDw6hAg
         8zVaAfkMJf6uETRpIqHl3SKRROJEgKsyqfj7ooTuftJeNOqFfuXsqdHRQ2SUnS5XV8PR
         5nbvEtV7TZsJZ6hb3cnhgnXlHCFcSTrVCRYzRmwcKhJrKyVXpYn/XjODf8kiMBxyP1M7
         WGYBzMn7jw3SJhP/6ysC3MfIZzouYSIhMC+Lz7+7k6kS9Ccm7ZoOW+6FhBgwexGdUyAa
         1T61LCZNMxpvAuMkNW1vrgqwrJztMpl1FbE2ucB7p7GeA0mckxnzEu/AZRDanj28xu2G
         znPw==
X-Gm-Message-State: ABuFfohSZIbps/3orihahqRwS60J1wn01+Xx7L8fF51ZE5quNc6PJSQ0
        zD4Vk+VNjWDBrbh+/tN/4NeJrPrSF40hYCBiS/M=
X-Google-Smtp-Source: ACcGV607GvLpBV6YggC7OOcWzdGWdRBTqlG0xcUZhZRX5gIFci6nmBCSwWeqUQmEW9JdiO/f21JWkLOVgncdKUbiJ+Y=
X-Received: by 2002:ac8:2bf0:: with SMTP id n45-v6mr1987074qtn.152.1539270559111;
 Thu, 11 Oct 2018 08:09:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:fd8b:0:0:0:0:0 with HTTP; Thu, 11 Oct 2018 08:09:02
 -0700 (PDT)
In-Reply-To: <20181011150654.GB22118@asgard.redhat.com>
References: <1539231895-4118-1-git-send-email-firoz.khan@linaro.org>
 <1539231895-4118-8-git-send-email-firoz.khan@linaro.org> <CAK8P3a3OS-aKFrb5g1i00-+G1+uZqEkH0C1FX08tTx=-89-hfQ@mail.gmail.com>
 <20181011150654.GB22118@asgard.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 11 Oct 2018 17:09:02 +0200
X-Google-Sender-Auth: 5kuTwPkgwp0W2zHQ5Xu2R1LmDg0
Message-ID: <CAK8P3a2EOb+_aOSUqPuFpMoZYSuZv0v89XB-pWf5C7X3rnfOrg@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] ia64: wire up system calls
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18, Eugene Syromiatnikov <esyr@redhat.com> wrote:
> On Thu, Oct 11, 2018 at 09:24:43AM +0200, Arnd Bergmann wrote:
>> On Thu, Oct 11, 2018 at 6:26 AM Firoz Khan <firoz.khan@linaro.org> wrote:
>
>> > +# pkey_mprotect requires an architecture specific implementation
>> > +328    common  pkey_mprotect                   sys_pkey_mprotect
>> > +# pkey_alloc requires an architecture specific implementation
>> > +329    common  pkey_alloc                      sys_pkey_alloc
>> > +# pkey_free requires an architecture specific implementation
>> > +330    common  pkey_free                       sys_pkey_free
>>
>> One comment for all pkey calls would be sufficient. More importantly
>> it requires hardware support that ia64 does not have AFAICT.
>
> Except it has[1].
>

Ok, then we should definitely assign the system call numbers.

      Arnd
