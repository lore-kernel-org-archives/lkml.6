Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CDAC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ABE22098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjRPH1OC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ABE22098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbeJSGE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:04:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44456 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725738AbeJSGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:04:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so15489402pff.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fJMxiMhuSmSU6CULjVs2+RF0FIVyp0Z5EaJ6LHHaCxw=;
        b=LjRPH1OCh7RK6hBpnTiVGdRPzm5fUBEW7OJvx3U5Kir/VRp1M8CvG+WyxekHDRB4YU
         8rvfYPQmiBEEHPP7cK0ssnBg4L14JkOgajSbyrafSotl2otifbYtI4yni9whWD0e4USl
         8Btp7Kv4O4I+rf52M/AEGJPr99j4seIPtVU5AwdkFdcCs1Rz4o3Gc5PIqGJPStwCcJoX
         jY2RKoyC/yeQxLSJ0G/pdpYivgOCkLPXVSS3/sJauNRH1xemdUvS2y0idzCcnthH9uyQ
         qY97vw1UwdiQB1u9bGQu4WP+kmMeqi2nI6YFnzS+DPHoXOT22VLoUqYfo3AD4dH4FjNm
         4K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fJMxiMhuSmSU6CULjVs2+RF0FIVyp0Z5EaJ6LHHaCxw=;
        b=BD3M54xHCDNNUf9UjCWi1v3ApU2B5lJnP+SCmMvN/VGKgbsVnelWSsvzzbHoEhZ+Hm
         YfXolvxUKGThgu2zjeZFPDmuqjETyT7S1fePWy4qLVu2fqt1sdeDVzbMHNjGwrxANmJW
         O7uyh/mZBegPuLFqQSQjWeAyKCvSeCMHfnKn2IwN/xsVSIQN0sxssTCSEeaHgipPXwV2
         cR92OI5VqDTtI5spQPHoHQbpKgPhbaLyCeivFn6I/VssIHk1/x7LHASgLBI9uIVlBdUO
         rFcBrIBpjcAUcu3vuLVwiQWpsp7hY3pLKmJmUnfbeeHSM6bWZsYkX3Zy7xVKIFCcb8Wq
         +LeQ==
X-Gm-Message-State: ABuFfogH63I3CoO0tpDCpYCkxn5+bvGfd+mZdkCh+U1q6X2Ag9p6mc1e
        3lsN2yDQca71vWyk7sOb8l4mapNj
X-Google-Smtp-Source: ACcGV62yfpp8tMnvBGAWa+D1uuKPmdEMnf5MKHFcoNmsdmwEcgqiTPetmP6wI+cr72L9eszgbUG0Bw==
X-Received: by 2002:a63:4384:: with SMTP id q126-v6mr30156688pga.142.1539900086923;
        Thu, 18 Oct 2018 15:01:26 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id k24-v6sm26283863pfi.11.2018.10.18.15.01.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 15:01:25 -0700 (PDT)
Date:   Thu, 18 Oct 2018 15:01:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH pstore-next v2 0/4] Refactor compression initialization
Message-ID: <20181018220124.GA14768@roeck-us.net>
References: <20181018185616.14768-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181018185616.14768-1-keescook@chromium.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:56:12AM -0700, Kees Cook wrote:
> Sai noticed pstore wasn't catching early crashes, so Joel fixed it
> by moving init earlier again (with compression init done later). I
> refactored things a bit to avoid modular build problems noticed by
> Guenter. And while doing this work, I also improved /proc/iomem labels
> after Dan helped me get NVDIMM working so I could meaningfully test the
> very early crash handling.
> 
> Thanks everyone!
> 

This version fixes the compile failure. pstore also still works with the
series applied on top of v4.19-rc8; tested on a Chromebook.

Tested-by: Guenter Roeck <groeck@chromium.org>

Guenter

> -Kees
> 
> v2:
> - add init refactoring to avoid modular build failures.
> 
> 
> Joel Fernandes (Google) (1):
>   pstore: Allocate compression during late_initcall()
> 
> Kees Cook (3):
>   pstore: Centralize init/exit routines
>   pstore: Refactor compression initialization
>   pstore/ram: Clarify resource reservation labels
> 
>  fs/pstore/inode.c          | 11 +-----
>  fs/pstore/internal.h       |  5 ++-
>  fs/pstore/platform.c       | 75 +++++++++++++++++++++++++++++++-------
>  fs/pstore/ram.c            | 18 +++++++--
>  fs/pstore/ram_core.c       | 11 ++++--
>  include/linux/pstore_ram.h |  3 +-
>  6 files changed, 90 insertions(+), 33 deletions(-)
> 
> -- 
> 2.17.1
> 
