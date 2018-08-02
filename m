Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4EBC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D5A208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="alskDvbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D5A208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbeHBIBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:01:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41363 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBIBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:01:32 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so609426pgu.8;
        Wed, 01 Aug 2018 23:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mEGNsuTVA0iAVljYB6tgBqcEODMP9TVeo/NiEaNE184=;
        b=alskDvbjcMxqFRFjhHc+0s/Detky02Kf/rz8xoqPmL9xlk3UDYwWNH1hwkhja9caTJ
         a+rqsnWHZYbHb+MdIAZv6voMIpvseUE+Xk7Z7TWz9nFig63Bw2C3K3IDTczeI2ypumhb
         O08ExoJtWx0tnggCZLVARh1gycpKzYGY2WpFKeQGCsDk6SgqniOrNr6xdIM9Ven+YB1C
         P+oETFszJ8nomfpqsvrvrYCcjpn2XobtK3DmIemG4owNxbKMnVfHGLYOKbG7cqnWIbnN
         4D+yqQLMmYiTi0CHbuui5KZroBElZwTTE+cRHyTAn9sV4ep3GY0XZPPh3SumefTUubuM
         pOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mEGNsuTVA0iAVljYB6tgBqcEODMP9TVeo/NiEaNE184=;
        b=sxMaH73OJAmuvugbhEK9A1xwiK7s1ZYf9ZL5QLUoFXUqid9sgoamBD3k1uYPjxbyaQ
         VhRmMe+8oDE3caqVLkrfpwXkCZ4fBhwMqSWmoJk0x6RAFu9V8m3viY1wnjUTh6aZh1B3
         XQqmitng8FAl0fNB2e0DZ4TZ3eOhyKQtrihqwv++0UfmDAjzNuQp8lcd8HWjUjyw7vXr
         xgCAjeg6U6+tdkA4z6CtSPHJsXXUYu7bciMRpzznIWcBuoSgVS/biytilb+I2dzdT5Zh
         IiTIL+D8wSw3brftOd3GbDVhHY4JxEAmPKW3HT08epPrM9t1dQjYq0OCeRyijuIPmTW3
         +fjw==
X-Gm-Message-State: AOUpUlHxqG95bf939NJDobUYV4Te81zgGbkTDi+B6UWt4tVnWXuCzUCR
        Ui8D7xWbci67YBUwxM60ca0=
X-Google-Smtp-Source: AAOMgpf0wx05iTt8CEGmwd4kgbkqX8A3DO/8pDRnsfadtoSF5buzdEeJYB2oJ9YaeV03LlwKFyHGqw==
X-Received: by 2002:a65:64c8:: with SMTP id t8-v6mr1405239pgv.110.1533190322292;
        Wed, 01 Aug 2018 23:12:02 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:f9cc])
        by smtp.gmail.com with ESMTPSA id r16-v6sm1597134pfe.173.2018.08.01.23.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 23:12:01 -0700 (PDT)
Date:   Wed, 1 Aug 2018 23:11:48 -0700
From:   Dennis Zhou <dennisszhou@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <jbacik@fb.com>,
        kernel-team@fb.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] block: make iolatency avg_lat exponentially decay
Message-ID: <20180802061146.GA48671@dennisz-mbp.dhcp.thefacebook.com>
References: <20180801002559.36261-1-dennisszhou@gmail.com>
 <20180801154958.GP1206094@devbig004.ftw2.facebook.com>
 <20180801161011.GS1206094@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801161011.GS1206094@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tejun,

On Wed, Aug 01, 2018 at 09:10:11AM -0700, Tejun Heo wrote:
> On Wed, Aug 01, 2018 at 08:49:58AM -0700, Tejun Heo wrote:
> > Hello,
> > 
> > On Tue, Jul 31, 2018 at 05:25:59PM -0700, Dennis Zhou wrote:
> > ...
> > > +	/*
> > > +	 * CALC_LOAD takes in a number stored in fixed point representation.
> > > +	 * Because we are using this for IO time in ns, the values stored
> > > +	 * are significantly larger than the FIXED_1 denominator (2048).
> > > +	 * Therefore, rounding errors in the calculation are negligible and
> > > +	 * can be ignored.
> > > +	 */
> > > +	exp_idx = min_t(int, BLKIOLATENCY_NR_EXP_FACTORS - 1,
> > > +			iolat->cur_win_nsec / BLKIOLATENCY_EXP_BUCKET_SIZE);
> > 
> > Build bot is complaining about naked 64bit div.  Should use one of the
> > div64*() helpers.
> > 
> > Looks good to me.  Once Johannes's concerns are addressed, please feel
> > free to add
> 
> Ooh, one nitpick.  total_lat_avg is a bit of a misnomer now.  Maybe
> rename to lat_avg?
> 

Yeah, that makes sense. I've renamed it to lat_avg and updated the
Documentation file as well.

Thanks,
Dennis
