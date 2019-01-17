Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18023C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9811205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="zV1WSOz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbfAQOcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:32:54 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54119 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbfAQOcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:32:53 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so1630654ita.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 06:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zBP68msOjrFahT5eyfFbMaC5hk5eijUODNhs/NVuCbA=;
        b=zV1WSOz0yzhjojGyT424OmgAiXjbmHC7A4SCyQfcvbWtrp/np1ImPAHfx3WxUBBfMV
         /UeI9ksPhur6qitBCnkq7CZZPXxMj2Tb2Y4ZeY/oOGL2YMjX3uRaCkUn9fR0fPuyCuVh
         5V4VLTbUUxO+Y+01RxQeBt/EV3MlyE768DWcJ4mwf2MD3hzq7T3AB9cGnG/vP14nAWc/
         dI5lpNNe2h5nsxq+QbTBIIM1nsWv71iIlB5B8e3M8cCXHfTQyjNlZZJae9/KWfE33OW+
         X1fl9731Zb9R6AF/dLZuWVXzQZyeaEpIYXACBOJAIm18Pr+9r8Rbeg+RCFmYHyLnHuhc
         J43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBP68msOjrFahT5eyfFbMaC5hk5eijUODNhs/NVuCbA=;
        b=U+n7WpRIgQSYqSibQaUEromdohGPpElf0MziJ6AM9gs4FV2837mfBHTCWbB1TSkzRT
         5WFqBhOacPLw18ewKfyUvhLlkgl4CciP2bEOH1BJ+erXiH8kGjdM0LU8f+M0HuehrqCI
         5jYZGu84b+23f0/oR7Irftf3In5s3NLNNaZMXxLG4d4BXsBSwoMtRKSteNUA2PGpkYZ1
         2IESekXWYTACjs/mx0iTJwwELhYw3mdWegbbSJMSvPaLNBinNI8vm6xM+42LasAD2jX2
         aAeK/kCmh3o7ynlK6YLhjatHu6E0nmtOVW8yLmydGkcUPPzTFZDwTPMIDaa1bdStMAuq
         fKwQ==
X-Gm-Message-State: AJcUukeHqVSyjqhh/vt7cvtE/1eQ4ipq3rSAcqqa7oPF+hBF0nlw4Ba1
        q9Uyq1afSYr6ieZESozciQsEuhM5MoDPmVlzCtiN6g==
X-Google-Smtp-Source: ALg8bN4Rn8FoYt9A4zaNjmm87FzmLmrDHHRH60STLHqGG1BPNxW2vG7xJT78w6ACvmsqYSAO9NGsV1pLDU/LH+GWpoA=
X-Received: by 2002:a02:650d:: with SMTP id u13mr8610481jab.136.1547735572921;
 Thu, 17 Jan 2019 06:32:52 -0800 (PST)
MIME-Version: 1.0
References: <20190111172134.30147-1-brgl@bgdev.pl> <20190111172134.30147-2-brgl@bgdev.pl>
 <250a521a-ba07-ba17-83d8-d9ad8f55a460@ti.com>
In-Reply-To: <250a521a-ba07-ba17-83d8-d9ad8f55a460@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 17 Jan 2019 15:32:42 +0100
Message-ID: <CAMRc=MeA_AMvEikj9s03ikiFJwOi+4eri7Ba8ZxTwMogEJvdrA@mail.gmail.com>
Subject: Re: [PATCH 01/17] ARM: dts: da850: fix interrupt numbers for clocksource
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 sty 2019 o 15:23 Sekhar Nori <nsekhar@ti.com> napisa=C5=82(a):
>
> On 11/01/19 10:51 PM, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The timer interrupts specified in commit 3652e2741f42 ("ARM: dts:
> > da850: Add clocks") are wrong but since the current timer code
> > hard-codes them, the bug was never spotted.
> >
> > This patch must go into stable since, once we introduce a proper
> > clocksource driver, devices with buggy device tree will stop booting.
>
> Is this the case where someone uses device-tree from a stable tree and
> kernel from latest mainline?
>

Well, if someone wants to use an old device tree and a newer kernel,
then it'll be broken anyway. If we get it to stable then at least the
fixed device tree will work in the future. That was my reasoning.

Bart
