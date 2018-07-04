Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644E4C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0A32064D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 09:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyZmRJcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0A32064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933316AbeGDJcY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 05:32:24 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:41941 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932439AbeGDJcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 05:32:22 -0400
Received: by mail-vk0-f66.google.com with SMTP id j11-v6so2733096vke.8;
        Wed, 04 Jul 2018 02:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=JzIpZBExHc7xhw8lDA2ODGCg2Un3zA1EwFdebVQivQ0=;
        b=IyZmRJcKH2yMyz/dQsz21kZts0QnZnVn2iPb+sXInqU52lfmGLb1b1OieZnSfPAFk6
         D8QWTgUESt1r8xjLGKdA+91vwygs5d6rO1Jwr742o20HZ6iZkcdkEiM8UWaI3cDGOf3N
         aoenOs/XaOtAau05Ig6mcHNqVX/aaH0zlu/zFRxmubjpciT+J+QISnC0CnWbyF1sH5Jv
         N+24QEPrO2ElzwVHN9bAR0jEbSKOH3cTvOIPapQlB2puZqL5C68VSweL7W/hSLyQP81C
         cPWFM2eeeEzOPEDZeYtWzjLo2k7+najqv0liK/O/7KFlVoTne9/Uw+nRZ2F74v4jlKzD
         MnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=JzIpZBExHc7xhw8lDA2ODGCg2Un3zA1EwFdebVQivQ0=;
        b=rQ6j4pDug7nDtEGZetsGqIVP6BMdPRoSSWZ1ks17+E6vRcql+2qLmugNHDPpU5vY0D
         OQhx5hSrIUPMshGJFil7oQ31LPqI4xgMtHcKdkjxOf1wxEXTZVj/MrM/9TfCYI0CSBm5
         nreTwKME021CGVov4RoaZCCJnHdwyIEjyGddWh8dIa2JhjhjywDuHV4CcJF3gcLjW2Ib
         STzbGtp/1s4eWJmzbyIe6/e4YXRO0dxNlRRk36jwU9KsFQ7mLGfAKAjvli4AoefgL1Jd
         EVOIMx/5WTmjqM1A0JWuAVdNWQIXKlBE0hbMrCnlsLiKL61DfZOZsBngxfLfHKCm51r7
         yHhw==
X-Gm-Message-State: APt69E3Q1TDSubJDRhyLIoe6qNjGK8805ynEPQRCpk8IeWE1RSKp2Whw
        /JOJc4NU29d6NomDyuNA/H6zd50u0X/FO8094FGX2M2a7bo=
X-Google-Smtp-Source: AAOMgpcMaLkXiOt+CxYy9Mc8lO6Sob8hj8DDtSOHsJ7huHHbadp4GXpE3yyfkAYo/MFz/IEi93KylvGB2Vlte3DiWgQ=
X-Received: by 2002:a1f:8e0f:: with SMTP id q15-v6mr660781vkd.161.1530696741936;
 Wed, 04 Jul 2018 02:32:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 02:32:21 -0700 (PDT)
In-Reply-To: <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
References: <1530609760-8919-1-git-send-email-srinath.mannam@broadcom.com>
 <CAHp75VfPvCD7xpp73jbya4ONN=wxpVGNpOfNeqZYjfyirms0PA@mail.gmail.com> <CABe79T7EeyzKS97zeQ5akoSaZX0=hMgHxw4XkLCQW15eRR=14Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 12:32:21 +0300
Message-ID: <CAHp75Vef97XB-M=+xUxsGqzgPrADcUmLTLRdWE+PcVxtTQLN4g@mail.gmail.com>
Subject: Re: [RFC PATCH] ACPI: bus: match of_device_id using acpi device
To:     Srinath Mannam <srinath.mannam@broadcom.com>,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, Ray Jui <ray.jui@broadcom.com>,
        Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>,
        Vikram Prakash <vikram.prakash@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 4, 2018 at 6:37 AM, Srinath Mannam
<srinath.mannam@broadcom.com> wrote:
> Hi Sudeep, Andy,
>
> Yes, This patch is to get of_device_id and then fetch data pointer.
>
> To add ACPI support in multiple drivers which are device-tree based
> and has list of of_device_ids, by using this function
> very minimal changes and can avoid acpi_device_id list in the driver.
> I will send driver changes where this function used to add ACPI
> support in following patches.
>
> Below are the changes added to add ACPI support in sdhci iproc driver
> using this function.

So, did you get an ACPI ID for it?
That's how proper ACPI support should be done.

P.S. What you are trying to do is being discussed with Nikolaus in [1].
I have to NAK your approach in any case. Sorry.

[1]:
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1724366.html
(Unfortunately I don't see the original patch there by unknown reason)

-- 
With Best Regards,
Andy Shevchenko
