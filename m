Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC1C070C3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F9120882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 02:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNU8DxCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F9120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbeIMHjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 03:39:48 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41595 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbeIMHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 03:39:47 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so1930997iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 19:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=al50tF7NPi9gaw6aJNwrZnftu/N04MbDd/1HZzxh/Yg=;
        b=oNU8DxCkMkyb4p/SCYeEKRCEXEIm008msv5mfp/DnejErld4f0s5dI2faOe+k4ZgvH
         1esnRhZr//UJLToUz7y+IYhV0xgEkIOw8+RdT5aePIQ+FrXPze0hrjQdwQEPj9VHPoPu
         IFZTH7xyHmP9kM3sU8CAMerMhqD/rBXjsC7QPXAbJBy0Ss8OYWmutj+/0kIWmu0Bz89h
         rBcvEsY4aKDX3E+8XHsRVVF4zdScFmYU32+cAIzwW3DgZpTIJg4uyN06k3pmc5yDvgbm
         p4nqV9hgqk1E5fk99W01c0s1lWzqVKsSd6njgwMZ0RVvi6VGcFeX6g45KPIEspbzBJBl
         Srkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=al50tF7NPi9gaw6aJNwrZnftu/N04MbDd/1HZzxh/Yg=;
        b=R2pspT9mJrcoyrT0Xn6rvxQFl0KcI2vo3HbiVXtac+dcU1WrrEj+I3PXGP4UQf7qg2
         x8G/6k7UhdGFIamgkLmV8xe+z33iChjaqmKvfyMttXc/NzrJJzym0j3JwinZfCb3z1+w
         gpE0krX2eN+HiLXiw282XH6ZNkEf1RcSJMMctY6haPwcS1K+Y23qXGOp1DZDua8SQLiH
         psj1En0vfONmoKeFmIclfcEyH9DBC5QrcXoNevBWNP61S/k5BzC1mYKKiYMe+HzETO/K
         s1ClWHoj/jNKQ7Q9rcqSH7hKIrSO7QOzFkHVBBnWW3GPJm9Bqvp6cXBOjOxoxwUAcohb
         drgQ==
X-Gm-Message-State: APzg51Aw7apDgFuqAS6mKOq80N8oeOsKhKeTCuUVmI8UNp6Z3TghvsUQ
        ROXv/2S+AuKC6ksucSeyF4CL54ci4YyqnLSvsYc=
X-Google-Smtp-Source: ANB0VdZ6PD4z7avkSNk1dqgUdD4VSLGN4/VZ4NprMsTf9+2Yyc+Et6kGND2G07YT6irTmUf0uCDlzpXIh95F1uXNWiw=
X-Received: by 2002:a6b:6c12:: with SMTP id a18-v6mr4401133ioh.72.1536805947346;
 Wed, 12 Sep 2018 19:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180912155530.GF2966370@devbig004.ftw2.facebook.com> <201809130951227309678@zte.com.cn>
In-Reply-To: <201809130951227309678@zte.com.cn>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Thu, 13 Sep 2018 10:32:15 +0800
Message-ID: <CAJhGHyB0DgnCMkxa5otMePD+toa2pLwN2Kp78maxVOu6bKohsg@mail.gmail.com>
Subject: Re: [PATCH] workqueue: combine judgments in the loop ofmaybe_create_worker
To:     liu.song11@zte.com.cn
Cc:     Tejun Heo <tj@kernel.org>, liusong@tom.com,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 9:51 AM <liu.song11@zte.com.cn> wrote:
>
> >> From: Liu Song <liu.song11@zte.com.cn>
> >>
> >> Although the 'need_to_create_worker' has been determined to be
> >> true before entering the function. However, adjusting the order
> >> of judgment can combine two judgments in the loop. Also improve
> >> the matching between logical operations and function naming.
> >>
> > >Signed-off-by: Liu Song <liu.song11@zte.com.cn>
> >
> >idk, this doesn't really improve anything.
> >
> >Thanks.
> >
> >--
> >tejun
>
> Hi, tejun
> Indeed, the logic of the code has not changed.

The logic of the code is changed in the patch when create_worker()
happened to be failed.

Failed create_worker() doesn't always result to COOLDOWN due to
the possible condition changes. if (!need_to_create_worker(pool)),
it dosn't need to COOLDOWN.



> The idea that I made this change is
> that when reading the workqueue code, from 'maybe_create_worker' naming, it is
> possible to create a worker, but the implementation will definitely create a worker,
> which makes me somewhat confused. After analysis, I found the determine whether
> to create a worker before the function call. So this patch seems to be able to reduce
> the confusion between the function naming and implementation.
>
> Thanks
> Best regards
