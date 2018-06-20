Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F48C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FF8720874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 23:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="kn4iMvzh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AhbI22Ym"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF8720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeFTXnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 19:43:19 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:36265 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933135AbeFTXnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 19:43:16 -0400
Received: by mail-yw0-f193.google.com with SMTP id t198-v6so488894ywc.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hrH6HRK3PEaSJxveilPPh7n4ZPk8zcx3D0T5g4UMz6U=;
        b=kn4iMvzhOxKfEborGpb0OueByq2HL6ykOBzqg/BjtkRXYKwDFHqKrnS7cfhhMy6rC6
         6mYwrKMi0Wxf3igIZt61Q+nnRxN4gcmAR+jQOnSdH+iPFKMEfrv22LbOq4m2M3AfUFSx
         NOPOom4aBp5P9xmygzU0RuXl5wRZqe27+SORfzmftK09fHcLSGj+lzNlnFpKBrLA8Axn
         z9qSlFPTrd/kaPxu5H81cyT484T3U9wL+xp7GKROYUr7UN0M7+qcyE5BjUEhmA8k3wJ8
         pDHrjdM3UyNAQY1VCSl1VXz+uUitZEkLJiJOkj0rvZafcieYTGWHRscBbTcdCMXHgyPk
         FE5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=hrH6HRK3PEaSJxveilPPh7n4ZPk8zcx3D0T5g4UMz6U=;
        b=AhbI22YmwqR/Eb7UUxMNxTmUCV932bYKVQILv9ga8Mdz3So1h/UsEAS5RPDvLV7QyW
         5jXYpx7OOaBaVkUqMGthMF08bbO73KNqTtgL92CaoHP4mKaxdUiJPuN0VIyGC5PrM9ua
         lK32nfdrEdHrpBlqBiDHATgbImXia3f+EL1CI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=hrH6HRK3PEaSJxveilPPh7n4ZPk8zcx3D0T5g4UMz6U=;
        b=gcpJVYWX01YjR3nnCaIN09K8mWUABW0m3OjkTqgORbCnGAK/LNgiJR+TzdXfr/Adr7
         p979x3K3wKALvOqNQpY9yasQRFdv0IUPR24DkHech8GVmOP4Kg0cySv1TZWqygLqNZPX
         nOsctRAECySzR+nWjYf3AA/Jfn++hr2rMy2X6bx4LOkUNXT/YtG4U9nADv0LnvvuIAG2
         6srVUXn4/JtD9IEsWbiNg8qvns2juwsPVttq9XZWlGw4XO4h64/DUqdNkguJH1+6o+43
         eLUp176xbN/c4JFehgRMuGV0KtWUKfmZxlRF5VzSDio+k6K5MVHH+K+54ngWEXEL+gDb
         fhAw==
X-Gm-Message-State: APt69E0aj5wLc/cva4Yaz5IMl7YlRpzBEpUzZkD2pkfvoQoHCyB+jIJJ
        9bnOELLiPeuCDvN1qsulgCqvjzvvMWHzuFM1aBnd4Q==
X-Google-Smtp-Source: ADUXVKKDutRUEswl4FNIBI1cSA3sd5RcuEp3vHR+lmbZpplplK7+R4OpIiZ9KUucQWK2W/YrgeGfvD2m4Ak1DMTHSJU=
X-Received: by 2002:a0d:d105:: with SMTP id t5-v6mr11437805ywd.53.1529538195526;
 Wed, 20 Jun 2018 16:43:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 16:43:14
 -0700 (PDT)
In-Reply-To: <20180620233736.GA3250@fury>
References: <20180620213141.GA8957@beast> <20180620233736.GA3250@fury>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Jun 2018 16:43:14 -0700
X-Google-Sender-Auth: xHdNE1nvdewyHBhCtGcZJoQCRlk
Message-ID: <CAGXu5jL4V9sL7Ai1SVTNkg8OE70c6kLJBdqNtj9Z06MOb4zG0g@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: wmi: Do not mix pages and kmalloc
To:     Darren Hart <dvhart@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        =?UTF-8?B?TWloYWkgRG9uyJt1?= <mihai.dontu@gmail.com>,
        Mario.Limonciello@dell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 4:37 PM, Darren Hart <dvhart@infradead.org> wrote:
> On Wed, Jun 20, 2018 at 02:31:41PM -0700, Kees Cook wrote:
>> The probe handler_data was being allocated with __get_free_pages()
>> for no reason I could find. The error path was using kfree(). Since
>
> v4 of Mario's series used kmalloc:
> https://patchwork.kernel.org/patch/9985827/
>
> This was changed in v10 to use __get_free_pages:
> https://patchwork.kernel.org/patch/10018023/
>
> But... I'm not finding the discussion that led to this change.... Mario,
> do you recall? Something about contiguous memory? We had a similar
> discussion on an earlier series:
>
> https://patchwork.kernel.org/patch/9975277/

FWIW, kmalloc gets you contiguous memory...

But if the reason is found and needs to stay, the probe error path's
kfree() needs to be fixed, and __GFP_COMP needs to be added to the
free page flags.

-Kees

-- 
Kees Cook
Pixel Security
