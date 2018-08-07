Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D25C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB090205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xUf/RW9P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB090205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403861AbeHGUEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:04:01 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39619 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389098AbeHGUEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:04:00 -0400
Received: by mail-yw1-f68.google.com with SMTP id r184-v6so5255528ywg.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 10:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UpJ6FyGDkvX9DB3o64kenGl56IYvhdWQ2odl8ODKXXc=;
        b=xUf/RW9PAuGdg/aPmdXZd061y1b6q1zGr+kLQpDEaAEzJooB6827zXKVhjRHGN5n7e
         HIjUtKUyaJOXzgZuXxznZcNUilT1xBZhA5aehh8lQruhFsIUm8GVYWMTmkLoG2UTPfFs
         vXqQAH1vMLhucdZdSZ4omgtizpiFeVV32ipqPL4lUmkAsZCnWsRzwoCDnvuNz8bWCYbl
         uCU6edKUuslSG6p9dY6Byjne8s33D9qm4zN4uqiFICsUB7jHC5eo+Wh79SWpC+5PHWUD
         RNbqEMybZilTZhuktqRbxx2meHfWOn6J2tgPU9iNxja8HbkPqNkIuvqHrNMH4w4IZupg
         IS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UpJ6FyGDkvX9DB3o64kenGl56IYvhdWQ2odl8ODKXXc=;
        b=fGQXOnIZAYNJqR2K4MXXiBI1a6pVUNt8udMIBSJMSXOB/Sb0hHB9bLbfiyFhVCMd1+
         YAg0YROrwIqiM0HwaMyCcKh8GAQuGbG47+urgiOTVoP7pyGJN1m5w2UIFd1HgKnmXYpx
         Zf+H+a3Dn5jETfTJTMAr/fPzBOILCumUSSoyC4w/2bZEAs22QaXiZUHujg2W6cuoQkOu
         XrF4L+GQovTgrYIu9URlcuQAdgX0F48Lbp5qF9INLje0oisr2vPTs3YaXtBlwwq9I7BY
         0nc2Z8gkYFHpfzuqSxHa8kjNFE+PiWKhoXD0o1+44mNqkbtfeF829oxgFy4Yqai4pvhK
         M+5A==
X-Gm-Message-State: AOUpUlF8xK1CHYsIgucms8SH5kLUWUkVaaJWXsrdFgtu8X/AqeYmZ3xY
        8Wm34/65uVPfdh3afXzaGXFoZA==
X-Google-Smtp-Source: AAOMgpfyGRDHr22y+5Nd13+1Rpwl+ewoJzO0ff09ocAZogHy94T/qzN7rFFL6n9747hyF5drVzDpdg==
X-Received: by 2002:a81:430f:: with SMTP id q15-v6mr10431320ywa.39.1533664114079;
        Tue, 07 Aug 2018 10:48:34 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:2058])
        by smtp.gmail.com with ESMTPSA id 139-v6sm801985ywr.61.2018.08.07.10.48.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:48:32 -0700 (PDT)
Date:   Tue, 7 Aug 2018 13:51:32 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     peter enderborg <peter.enderborg@sony.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Drake <drake@endlessm.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Christopher Lameter <cl@linux.com>,
        Mike Galbraith <efault@gmx.de>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 0/9] psi: pressure stall information for CPU, memory, and
 IO v3
Message-ID: <20180807175132.GA27979@cmpxchg.org>
References: <20180801151958.32590-1-hannes@cmpxchg.org>
 <5576a988-fca9-15a5-5fa8-16f704ea20fb@sony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5576a988-fca9-15a5-5fa8-16f704ea20fb@sony.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2018 at 01:50:09PM +0200, peter enderborg wrote:
> On 08/01/2018 05:19 PM, Johannes Weiner wrote:
> >
> > A kernel with CONFIG_PSI=y will create a /proc/pressure directory with
> > 3 files: cpu, memory, and io. If using cgroup2, cgroups will also have
> > cpu.pressure, memory.pressure and io.pressure files, which simply
> > aggregate task stalls at the cgroup level instead of system-wide.
> >
> Usually there are objections to add more stuff to /proc. Is this an exception?

It seems like a good fit given that all other system stats of this
type and format are there: loadavg, schedstat, diskstats, uptime etc.

sysfs, and its concept of kernel objects and their attributes, doesn't
really match the type of info exported here. And its breakdown of
complex information into many directories and files can be kind of
tedious to be honest; some information is just more human readable in
a simple table, and still trivial to parse mechanically.

It would also be nice to keep the same file format for both the system
level and cgroups, to avoid having two separate presentations (and two
parsers) for the same type of information at different scopes, but the
sysfs design goals clash with the cgroupfs ones. If we exported the
system stats at the root cgroup level, we'd still need an interface
for !CGROUP systems, and having two ways of reading actually identical
data would again be fairly ugly.
