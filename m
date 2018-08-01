Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A16C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877220840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 19:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qqx37g9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E877220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732270AbeHAVKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 17:10:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:37087 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeHAVKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 17:10:33 -0400
Received: by mail-lf1-f67.google.com with SMTP id j8-v6so14112985lfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 12:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tkh6lwZA8JMHQqH5OvWbTjGHbZ4sBHRIh4AUzQZ0g3U=;
        b=Qqx37g9rJ+uOAsVs7WdIDbeRnUNhMAi7StoIUBSINmHzMc/Bau4ZcVuwXz4uX5fST2
         ue2F0ov8BwPdXagcwBi/rX+6Uu3V762YRBjEOQeviqKlNWJY+4/h/0zDQYh13saDb15f
         HYh6A6rFp5ZiTxc9XhukHhBaBarc3HrEMVXbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tkh6lwZA8JMHQqH5OvWbTjGHbZ4sBHRIh4AUzQZ0g3U=;
        b=iMhDt0vNBDi/tJ8i3rv7oPR63WvWomUfBBnYYTHASnYOcdo0xF43S/b16PlcRJnMoK
         5v/Kyx6Bou2byrWaS7XnnCFJL3J4Q3nUdqCQ9F94eGY776k4MBUTB5ZvL6sDOU1WMpJu
         0oVAUIcPU32DDVrpy+aUOwFs2+9SHCcLZhjSUkN9n6q6eTcIynRTm1twDRf6DbZOyG0t
         Y9IJNXdD0CRf86tv1cOmkPmtFvW4E6qia3Dd4ABzhXXCxWtfZsKYlBbklypIMaIml4AI
         wlUlBHxhGQqLJ1xNXsOyBctiKwPu4pZoINAUf6Tu3grAgZKzK4D43K3hqsHL63P5c0bM
         kEQA==
X-Gm-Message-State: AOUpUlHlp8IpskH9bPFGeBMEmcDWt9+r+nUL/QkgEnTaqUpRXMFwqpxE
        71mx5Kg4uw0F+6e6xMJ9cTcu3rZCPR2oTqF0bfewsw==
X-Google-Smtp-Source: AAOMgpe8opEWIakyu0p9u1RfVBNpJgU1pvS6RTSs1cZpVKBKZAa1Za6WFInpcRA2kSz/Q1ckKSHs3hWj7hbVTxCDAlU=
X-Received: by 2002:a19:548e:: with SMTP id b14-v6mr15869390lfl.10.1533151396326;
 Wed, 01 Aug 2018 12:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
 <1532609691-16863-3-git-send-email-suzuki.poulose@arm.com>
 <20180731170731.GA11692@xps15> <7b311596-025a-f4f4-1859-6f3531258b75@arm.com>
In-Reply-To: <7b311596-025a-f4f4-1859-6f3531258b75@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 1 Aug 2018 13:23:04 -0600
Message-ID: <CANLsYkzyb0Lmb3DNomVuK-Bon2gfS7jGYRnX4F7LQghR-aMZCw@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] coresight: etb10: Fix handling of perf mode
To:     "Suzuki K. Poulose" <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        coresight@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jul 2018 at 15:32, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 07/31/2018 06:07 PM, Mathieu Poirier wrote:
> > Hello,
> >
> > On Thu, Jul 26, 2018 at 01:54:40PM +0100, Suzuki K Poulose wrote:
> >> If the ETB is already enabled in sysfs mode, the ETB reports
> >> success even if a perf mode is requested. Fix this by checking
> >> the requested mode.
> >>
> >> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   drivers/hwtracing/coresight/coresight-etb10.c | 8 ++++++--
> >>   1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
> >> index 306119e..e5808fd 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etb10.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etb10.c
> >> @@ -148,8 +148,12 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
> >>              return -EBUSY;
> >>
> >>      /* Nothing to do, the tracer is already enabled. */
> >> -    if (val == CS_MODE_SYSFS)
> >> -            goto out;
> >> +    if (val == CS_MODE_SYSFS) {
> >> +            if (mode == CS_MODE_SYSFS)
> >> +                    goto out;
> >> +            else
> >> +                    return -EBUSY;
> >> +    }
> >
> > How about:
> >
> >          if (val == CS_MODE_PERF)
> >                  return -EBUSY;
> >
> > +       /* Don't let perf disturb sysFS sessions */
> > +       if (val == CS_MODE_SYSFS && mode = CS_MODE_PERF)
> > +               return -EBUSY;
> > +
> >          /* Nothing to do, the tracer is already enabled. */
> >          if (val == CS_MODE_SYSFS)
> >                  goto out;
> >
> >
> > I just find it more readable that way.
>
> Sure, thats fine by me.

Ok good.  Doing another round just to address this is cumbersome so I
just fixed it in my tree.  Also, I still think the WARN_ON() in patch
5/13 is superfluous but once again not important enough to make a big
deal out of it.  I have applied this set.

Thanks,
Mathieu

>
> Cheers
> Suzuki
>
