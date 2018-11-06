Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0EFC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E821520862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rsZvZC7d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E821520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbeKGAio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:38:44 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35588 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729574AbeKGAio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:38:44 -0500
Received: by mail-qt1-f193.google.com with SMTP id v11so2939082qtc.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 07:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I8QaQfaVRc6jFfZnnn+6lgjFF336Oeto4DpPOMWWZcY=;
        b=rsZvZC7daApWrrU6BSyo5z7Kp2TBe11K1Cgc+UpZXQUQwVitRGtERAJJb9GbDJpeb0
         Ah7JlHOnYJFWTQUDMmZRABocDWh2+3CdwJGod8hSil313C2byLO8MOoq6MZ9YtVCRNCT
         diHCe1WhU1eCWMHl17iQUqW5/pT2nvOA+X0l0AlvnyTDYZt5DimKJQwBmmp7jhhsuTYN
         nQBO/+SX4pPhFQrKAuN6CdaCg96b4/Cbm3u6EATSUkj1jgwj69x0fzEfeh1CJvoiJwQC
         s3guCy8AucH9ww6VaQWOx3iEvAKbAUevj5vc3UNZdJ1U3s+PbdGLiXfIoeuGJi6NNXR5
         rx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I8QaQfaVRc6jFfZnnn+6lgjFF336Oeto4DpPOMWWZcY=;
        b=FndJFCtuMTsAVihpazOWwdZdQ3NAoIq9GkLMRtvHJqVLq9gSI9WTjCdVTtq0RfVj0I
         uxJs7uFWAPJ7eRl7fhcHHT6J++PM3lc2TMozv7Rii4rL9RaQuDkpvBZhgcu1RHiJTscM
         zUmyLRVPiRmPDTDVMDR+W32lUV1Jayg3QR089sLW0w7PTmb6Md/1nGh4WHufZegSFyN1
         SM7/L5jNx137zozvFog8ckLjNN0o7ZhjWQHVkUFBPMc17kTCo9Iu6n1hU0bpcvDQK6Il
         3M4SGRJ4ncznAKLlKBPyAHn7On9rjMrH1+DOc/Ke/Pw/Pk3+VhhqoDwc09HboYLhWYX8
         mDuA==
X-Gm-Message-State: AGRZ1gIQ0ZDdx3uyUGO/IJ8sYmkZxbi5GagjiXkYkpidHnBEQDLpwi6M
        FlB7zE24x4rJgzfIJ+eEsSBSou+d9r78TT4WPX76OF1Q
X-Google-Smtp-Source: AJdET5d5W+hkDsMhCA9pqSDqpCk1XsMR4OhQbuz7OhFkMJfoHcd3XUZJx3YcqNr4kAqKrIkye+Fo9zKBXFnF1rYQ9+Y=
X-Received: by 2002:ac8:240a:: with SMTP id c10mr14640681qtc.93.1541517183329;
 Tue, 06 Nov 2018 07:13:03 -0800 (PST)
MIME-Version: 1.0
References: <20181106134630.29591-1-smuchun@gmail.com> <CAJZ5v0ifsQqkoFw2tossFKJAUkqDLdR9NpN3eZTn3t0xUz6K-g@mail.gmail.com>
 <CAPSr9jE8EbWue31LP18eF9+KysZHNRqHNrzif8H4NkCzHHtueQ@mail.gmail.com> <CAJZ5v0iZo95ssiu3JcGJMgP+QrKLy0wu9vshk212FE3aY_kwoQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iZo95ssiu3JcGJMgP+QrKLy0wu9vshk212FE3aY_kwoQ@mail.gmail.com>
From:   Muchun Song <smuchun@gmail.com>
Date:   Tue, 6 Nov 2018 23:12:51 +0800
Message-ID: <CAPSr9jG0X9x7=krPf1OS_N2LndWcfHkREgiaQwAgY=sBQgXijg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Add branch prediction hints in really_probe()
To:     rafael@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

>
> On Tue, Nov 6, 2018 at 3:43 PM Muchun Song <smuchun@gmail.com> wrote:
> >
> > Hi Rafael,
> >
> > If we want the driver core to test driver remove functions, we can
> > enable CONFIG_DEBUG_TEST_DRIVER_REMOVE. This option is
> > just for testing it. So, in most cases, the option is disabled and the if
> > condition is false. So I think we can add an unlikely() to it.
>
> Yes, it can be added there, but does it really need to be added?
>
> If the conditions are false all the time, the branch predictor in the
> processor should be able to deal with it just fine.
>
> And if they are false already at build time, the compiler should just
> optimize them away.

Thank you for your explanation. I really didn't take into account the
situation you said. Yeah, the compiler can optimize them away or
the processor can deal with it.

So,  we don't need to add unlikely() to it. The patch does't make sense.
Thanks.
