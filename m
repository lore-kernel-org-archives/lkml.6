Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB144ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5513820647
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:26:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/pYlJcm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5513820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729840AbeGPVz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:55:56 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:41482 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbeGPVzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:55:55 -0400
Received: by mail-yb0-f193.google.com with SMTP id s8-v6so16002395ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 14:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wj/mO8wUlyAFY1CUfsvUrVoPk+6veb4B9lCBsRoh374=;
        b=a/pYlJcm3jY3WKFYtKqU+RNKP6SJVj7+NmrFY3cDgjzvzvIuTnRf8Liv+mY3DykamC
         VsS9+gjxX86O/k+SgIfF9o9jOCfW+Oz8dW3mqxgNnz94iskXLdkJF36VVfGiIUNc/vA2
         +L27w6NzQ1yGMkzknwhZhNOoVt3WOHnxeNOKUlZpH/OKRQ2dnnrxQ4iSCUlqj7afalzq
         j/+A6AGteMy9438kPHDOyX6evd+JGOC8s65hrLWDtyU1C93h/qF+M3P5SjeWeWFf8CLK
         gHaRayHs3Kgb6KtWEZeaZNohLr7uq7RA4WSxwWEl1AihHI+n+EevUiuB60ceJjzWajfa
         5FHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wj/mO8wUlyAFY1CUfsvUrVoPk+6veb4B9lCBsRoh374=;
        b=DkplbwkdWGFsIoeVseWyWFPIM6j8nUFE/jGtBpcB6AEc6Yhu3OvrvSZ8AAqaQSIPqP
         Ac905Go8QuRWoNJe/yuZAe4ZT1zFs5utnsOi9R0aycQ6toVrwMPBfZGXQQHpHpa5Byoa
         u9EEnVObnPzi6L6W5Ef6ZGZMKRN/OkU/no6W2R/B9fHJQuQcAOXD9y+waMHi/viY5bHn
         oelE83u1jgMhMKZn/H8Gl1+uRQgxom8tjNVcdIKSqo3q3G1N1sObDkZKmZcyGuE+wgw8
         lFSskvTS8h9vVVah5wXp6b+kVg/xIExSCi4ycT3IybR5G7WLkJxGDtA3m50MK4F2ucLr
         9Hfw==
X-Gm-Message-State: AOUpUlFiKSZL9YpxfT55tmZJrUfMx2/4NsBlmFadlb4nS+yhpntTHWHA
        7/a1LPKE5Bl2rI9qwIxILzW9E2MwNGh+sqmxAAU=
X-Google-Smtp-Source: AAOMgpdfRj9dgdj96KyoxXshm1ey43BCeaxet9nDZy4jEvAwIfrZSze2xVj4F3hUM5MHvgO4fRMA6KtXOeTQ9sT5EL0=
X-Received: by 2002:a25:844f:: with SMTP id r15-v6mr9524448ybm.345.1531776400355;
 Mon, 16 Jul 2018 14:26:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5e42:0:0:0:0:0 with HTTP; Mon, 16 Jul 2018 14:26:39
 -0700 (PDT)
In-Reply-To: <20180715194150.GC2288@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com> <20180714055816.223754-12-toddpoynor@gmail.com>
 <20180715090544.GC23333@kroah.com> <CAE_wzQ_YosCJro46uuF1v6TQhVaTaXLdiLVD7gb94BwQx00SuQ@mail.gmail.com>
 <20180715093216.GA16003@kroah.com> <CAE_wzQ9rsw14EbFpt4kdt8bRJYyjDVvMrf45u3-y4Dzs4NKwRg@mail.gmail.com>
 <20180715100345.GA17618@kroah.com> <CAO3upoZeTGDZsGaYGhmQE_7GaihLYPym6miD9vMWM5Fzi46GMA@mail.gmail.com>
 <20180715194150.GC2288@kroah.com>
From:   Todd Poynor <toddpoynor@gmail.com>
Date:   Mon, 16 Jul 2018 14:26:39 -0700
Message-ID: <CAO3upobdbObTVy_p4u5SnQEVZ_yt_P5_HgDt7DWFLbjkjgh3Eg@mail.gmail.com>
Subject: Re: [PATCH 11/18] staging: gasket: always allow root open for write
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, devel@driverdev.osuosl.org,
        Zhongze Hu <frankhu@chromium.org>,
        John Joseph <jnjoseph@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 12:41 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sun, Jul 15, 2018 at 11:15:26AM -0700, Todd Poynor wrote:
>> On Sun, Jul 15, 2018 at 3:03 AM, Greg Kroah-Hartman
>...
>> My own preference is to rewrite the apex driver entirely in-kernel and
>> pull in its userspace parts here.  If I don't receive significant
>> pushback on that I'll start doing that real soon.
>
> Why would we object to that?

I've seen folks that have a preference for UIO whenever possible, but
I'm of the "just do kernel-like stuff in the kernel" camp.  There are
folks cc'ed who may have strong opinions about the subject for various
reasons; absent any serious objections I'll put that on a longer-term
todo list.  Thanks,

-- 
Todd
