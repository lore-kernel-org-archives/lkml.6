Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234D5C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CC92081B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 23:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="liMuj0x5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CC92081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbeJ3Ibu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 04:31:50 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:41528 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbeJ3Ibu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 04:31:50 -0400
Received: by mail-vs1-f65.google.com with SMTP id t17so3360719vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 16:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DBo3R1uGRylZH2MKNzXF5f5jJIa6z0Mq6/HFIYMps5Q=;
        b=liMuj0x5hW3K6SpyzThckIPblcdVZPW0qfIfxzaAt4FxPdNfGQgbvGYdERDl5GMtgk
         pZdjGclaRC6tBj7gxPHfw91yAofx1EnWSRUtesDIcAURita0J9j6oRiG5+XwruJXw1Ku
         gCjZoqFrmNDu3hkxA2fB6mUMZyT8iXjBgEroNmCqNTKbRDnDkoA2Hi8MXt6yj+LJmYu/
         Kbx0eGpyvs+DmvGkBC65B5Y8Cic0Vd5h6Sag98ZbEQSNcAId+OHO4hp9Mj+V4Z6RRa+c
         1IR96QelUUPSQQNP3sHB8uAb53/WPXzcCTvh/zZDhZlFbrk+MY+eMXyw1KMIjw+NpSXI
         FUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DBo3R1uGRylZH2MKNzXF5f5jJIa6z0Mq6/HFIYMps5Q=;
        b=oeak+Di3Xg4nL9hFy4Az6Y3h90QvGN7qLbvSopyWGaq5NydjLOf49ow6euJ8jEMrCH
         TKnBDBAibOHRy5KiDzp5r724oWNjBAgCr6SlM8fmYCUh0frO5aAwR/A08cnkgWVzTMQq
         dr+ldaI70BxRzmwLfsMQdXb201IPAwDOU2yXUgLGT0hCps6Snk9Zkw+LwPKKZoCz9FXq
         5YDdgKOICTBnaZCOe1bWgowbaBUaDe20Hw6fVLnvp1+DvCnHl0kLqCSkVjXWO5ULJSAq
         5E9BpRcg6mM0N67coIcuu8l9N7dj8xk5nkHUWV7GUjdJnsSH/LLDb92mtnQs6aYFVash
         a0lw==
X-Gm-Message-State: AGRZ1gLSsny0UjL71rLJFfA3Y8JXGbZoToUAtL12OlK39vzhUJvLrAUX
        r9Si2l7pwRB960dJFhHgUY9ARVd6mqLg3r+ZsAC2NQ==
X-Google-Smtp-Source: AJdET5fo8h9B3PmxHYXkqHUkoiO59wdfMxZjF8ZZDZHPyuiJjxmFk+ruusgNTMwrG7qig+ZfgsuB0MXzLdetyNOPlK4=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr2201108vsc.149.1540856448113;
 Mon, 29 Oct 2018 16:40:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f492:0:0:0:0:0 with HTTP; Mon, 29 Oct 2018 16:40:47
 -0700 (PDT)
In-Reply-To: <20181029233414.GA29750@avx2>
References: <20181029233414.GA29750@avx2>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 29 Oct 2018 23:40:47 +0000
Message-ID: <CAKOZuetMT0uC7MaYF6_meq+jX=4A1Lz5gpUsBZZUQd8WyHYosQ@mail.gmail.com>
Subject: Re: Re: [PATCH] fs/proc: introduce /proc/stat2 file
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 11:34 PM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>> I'd much rather move to a model in which userspace *explicitly* tells
>> the kernel which fields it wants, with the kernel replying with just
>> those particular fields, maybe in their raw binary representations.
>> The ASCII-text bag-of-everything files would remain available for
>> ad-hoc and non-performance critical use, but programs that cared about
>> performance would have an efficient bypass. One concrete approach is
>> to let users open up today's proc files and, instead of read(2)ing a
>> text blob, use an ioctl to retrieve specified and targeted information
>> of the sort that would normally be encoded in the text blob. Because
>> callers would open the same file when using either the text or binary
>> interfaces, little would have to change, and it'd be easy to implement
>> fallbacks when a particular system doesn't support a particular
>> fast-path ioctl.
>
> You've just reinvented systems calls.

I don't know why you say so. There are important benefits that come
from using an ioctl on a proc file FD instead of a plain system call.
Procfs files have file permissions, auditing, SCM_RIGHTS-ability, PID
race immunity, and other things that you wouldn't get from a plain
"get this information about this PID" system call.
