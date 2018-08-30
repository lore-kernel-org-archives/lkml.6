Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1135BC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B6020835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsyNiahs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B6020835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbeH3RWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:22:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33224 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbeH3RWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:22:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id h9-v6so6518832edr.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 06:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8IL1XtzkQc+Re/sjUotz1rrmYtV9v2GVXiWFD7TFGhg=;
        b=qsyNiahsu6eYehgeBDij8jCkExS37adJyVjlEjvFbL/491WmVx/0SU3Tr5ucicyeul
         PiXOs1Idn1qWBOFj0eo0lHDFIt8LKWeZoi4V2/Us42hvp76ruinyOugy8paqKRlecVIX
         RpzKFv+1CgZWHgi9hTGh7tyiEPIMZO35wr1Fz94UGZZldYDbAzP8tIjxIdaEpPPZQixV
         V0uWGRMykBgU96JfJ/EK5CkxIVIMKGytQ+WCVzuXAsL5dbYGWto3STqTQaEtktvEFYUi
         6cB4nXX/z4MGoZnvjNGG2DJPkN9kZOfMkixs6chNp7GmiZm2GSK5EuaIVtupLQfJX3YD
         CjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8IL1XtzkQc+Re/sjUotz1rrmYtV9v2GVXiWFD7TFGhg=;
        b=BBoyL1qprln6hgOyz6Nu9rhbBrvrS0aU5vs+Hz68DbI8e/ygnvLiDT7fr+x1i1JBvV
         Yw9oaNb6Y5mxOsZGqi0RIR9fR9oQUF/xCwST7fPI2h/YgyNJhvHD8ViziDZ2/JdOkr2M
         Bo843D1nP7qzbq5l11Ys4kDRcgS4hTw4eR0O3JWwdC9zVkAqz3Scmc1SKip7V1llD0gl
         Y6i42e0k/0nFUgqUyR7FsokwbK7HxC2W79ztGZklHyIb/G+t2zs0FW68dZvGsdLc2YU0
         0blfHXoNgTRrkyqSflHPERWlcEVvxeAjreCIiIK5Cu2iXUFLfrh2v/ucOXeKcQgd6YbS
         jTDg==
X-Gm-Message-State: APzg51AZr6hJHG53kw/n/VYphCwxtv4opb99Vx8XstqZ4HSA1PUKvvvz
        9K0KG75MKkio2PAzrbeEuutkSqE=
X-Google-Smtp-Source: ANB0VdYt6FrLHM01zzk/k3SoM47Fs/ooxGrEFoILkBGYc7BFGXezaUAJTd9VlWC+YTkJmw0WRQM8bA==
X-Received: by 2002:a50:8921:: with SMTP id e30-v6mr13083560ede.121.1535635206899;
        Thu, 30 Aug 2018 06:20:06 -0700 (PDT)
Received: from avx2 (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id w3-v6sm3707482edb.16.2018.08.30.06.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 06:20:06 -0700 (PDT)
Date:   Thu, 30 Aug 2018 16:20:04 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] proc: readdir /proc/*/task
Message-ID: <20180830132004.GB31422@avx2>
References: <20180827231503.26899-1-adobriyan@gmail.com>
 <20180827231503.26899-11-adobriyan@gmail.com>
 <20180828123622.GA2087@darwi-kernel>
 <20180828130440.GA6464@darwi-kernel>
 <20180828193502.GB4847@avx2>
 <20180829164330.435fb1d1c78e9d066e5eb862@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829164330.435fb1d1c78e9d066e5eb862@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:43:30PM -0700, Andrew Morton wrote:
> On Tue, 28 Aug 2018 22:35:02 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > > Are we really in a super hot path to justify all that?
> > 
> > /proc is very slow, try profiling just about anything involving /proc.
> 
> So how much does this patchset help?  Some timing measurements would
> really help things along, if they show goodness.

Benchmarking results are in individual patches. They are ~1-7-20%
better overall. However those are microbenchmarks.
