Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E91DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D728620849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETMPSNBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D728620849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbeLKJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:37:15 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:42394 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbeLKJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:37:15 -0500
Received: by mail-ua1-f51.google.com with SMTP id d21so4890086uap.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bfu37XvicU8GOJunSNdquvYomfpuT3hN3SAggWjLB98=;
        b=ETMPSNBlvml7wFYO6tgjpExr0YIg9GL5/413ehIRg5zTej2kkpqA1na2u0J/dUQe7Y
         59tT99eFM7+fkYqlCA4iESfs4p+QpkfFZ8Cvkwgt/oZmR70uOEeKDK4wPar7L7IzmY4V
         asl7P05TB7XkwrbkNjVt+qGlO64b4M+ul90VC5iSZe+kG+GmHGLy/FdGCxTCB7GWhX7a
         yEnAZqM3S0OpSDXLflcsSQdkyjDiUayZnwJjiqiacqknrN3DOCMEplmCQ+F+M4QL8w07
         w+RGWCskK9DKp/aVZwUnFQpvjtY/xrJbBwLyN7I8tDsxraq1l8BDNc8DblSeeNW/89it
         fIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bfu37XvicU8GOJunSNdquvYomfpuT3hN3SAggWjLB98=;
        b=FpcIXz/Lpet7t4g1ZHi3AJL7cbAWz2VAD0JrsqxSCmTCacQnStb7eYtO0el0zQs80h
         tRmm6cqnkpPWGjUR/LFORDwRXKhhIkFRANuyGBMivhRFfy6lnU5CibEn9Q74iratAIiM
         70C3jWyOo114ChUFzWiCIKhiPPUH4C3tvefSkFBoT71ZyN4fhTene0U+VWA/IgFo8XPl
         Ky8Ll+RBS7j26uSss+zotcFaYPkyWIRkRU0i1hFr4AOyLMXAW53nPIZ1YDDFAdW216Fc
         kDJWS9eATLXl3Hyu+ioDoJmPnXKgsCarkd6fQLucOasCb3/v5y9Sf2HdPk82tfc0UMdQ
         oJCA==
X-Gm-Message-State: AA+aEWYKj4FnirYxa2CYa8lQSw0YqRj9ALA1h+KfqqtZEEMB5FLSwr+u
        aNNEPduQ5OXiG7Y3MD5seu2+H+MOBWH2R/UhTbURVJtO0g==
X-Google-Smtp-Source: AFSGD/VOHTabmVzki91hN+mm4gt6FH3uwSmE7/GjmS6dV5WAmjUrJUUNsjfRY4y5axGxKy5sDZQmhU0zoHBqROplhDc=
X-Received: by 2002:ab0:14f2:: with SMTP id f47mr6817465uae.27.1544521033581;
 Tue, 11 Dec 2018 01:37:13 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
 <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
 <20181208171746.GB15228@lst.de> <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
 <20181210193317.GA31514@lst.de> <8a2e104a6c5b745adca8e7f3310af564f3b8a75d.camel@kernel.crashing.org>
In-Reply-To: <8a2e104a6c5b745adca8e7f3310af564f3b8a75d.camel@kernel.crashing.org>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Tue, 11 Dec 2018 09:37:02 +0000
Message-ID: <CALjTZvZ1Ud4P_XqB23Yq=815VyF=UbbT8YCFjTaPN=5tORWrtQ@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To:     benh@kernel.crashing.org
Cc:     hch@lst.de, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Dec 2018 at 20:49, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>

[snip]

>
> AGP is a gigantic nightmare :-) It's not just cache coherency issues
> (some implementations are coherent, some aren't, Apple's is ... weird).
>
> Apple has all sort of bugs, and Darwin source code only sheds light on
> some of them. Some implementation can only read, not write I think, for
> example. There are issues with transfers crossing some boundaries I
> beleive, but it's all unclear.
>
> Apple makes this work with a combination of hacks in the AGP "driver"
> and the closed source GPU driver, which we don't see.
>
> I have given up trying to make that stuff work reliably a decade ago :)
>
> Cheers,
> Ben.

That's what I was afraid of=E2=80=A6 what a mess. At least now I have a
definitive answer from one of the original authors of the code, thanks
a lot, Ben. :)
I have an unresearched belief that AGP support was hacked in the Mac
series as an afterthought (weren't they supposed to be PCI/PCI-X
only?), and your explanation surely seems to corroborate. :/
