Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E173FC07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1A0520020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:31:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1A0520020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965933AbeFNOao (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:30:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54595 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965832AbeFNOal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:30:41 -0400
Received: by mail-wm0-f66.google.com with SMTP id o13-v6so10896235wmf.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:30:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wp3n7+7cMHWutuP/kthpG4Y5vwAM5L4xT4StFODTPIY=;
        b=t+8HWNhZEGw0XX/HA6Ba27026/tmXCf6uxssj8+pLFFgLeBdaaybwD0OmrMPGBuRF7
         /1zEb76Z+hob15Xtj/mWEkWs9Nnc4SVfCFGpfP1RD40kUoNuNZSMQCjpVaTnqjL6aGMt
         6ELWae5BFneygN4Rbu/xyl2cTiUc117Otig9cHtAh1Eu6ZmvBPAFmtLM0Y3Nxn38dG3A
         T11dprYtPPaADV0z0SB0tY3biX2YJnWKQUaAGJqlEYOoSYa1/yHHDVoatbzKDLHhRUV1
         d6k1t+d2BBnUzwfDkCrWwaiQAnIlHtMTbwmBNMM/G8zSFfadVU+fa1lWzX4HdCwLO+d3
         vfiA==
X-Gm-Message-State: APt69E01xWQw+ifbwdP97lXMStdsqKrK5JeIeuzkywpHoLaXfsET6PE/
        6IpID4dC5kIkRN5dV/m8m9hBqQ==
X-Google-Smtp-Source: ADUXVKJO9XaDFOSWg/we7fFDpChI7Cq7Ywn75bO11Re3bb3+b7iHwmoeY8NNRrY0v9HEQ4IUOl4q6w==
X-Received: by 2002:a1c:3693:: with SMTP id y19-v6mr1996966wmh.71.1528986640379;
        Thu, 14 Jun 2018 07:30:40 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id e63-v6sm8174131wma.46.2018.06.14.07.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 07:30:39 -0700 (PDT)
Date:   Thu, 14 Jun 2018 16:30:37 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 1/5] sched/topology: Add check to backup comment about
 hotplug lock
Message-ID: <20180614143037.GH12032@localhost.localdomain>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
 <20180613121711.5018-2-juri.lelli@redhat.com>
 <20180614093324.7ea45448@gandalf.local.home>
 <20180614134234.GC12032@localhost.localdomain>
 <20180614094747.390357ec@gandalf.local.home>
 <20180614135040.GE12032@localhost.localdomain>
 <20180614135800.GM17720@e108498-lin.cambridge.arm.com>
 <20180614141118.GG12032@localhost.localdomain>
 <20180614141818.GN17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614141818.GN17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 15:18, Quentin Perret wrote:
> On Thursday 14 Jun 2018 at 16:11:18 (+0200), Juri Lelli wrote:
> > On 14/06/18 14:58, Quentin Perret wrote:
> > 
> > [...]
> > 
> > > Hmm not sure if this can help but I think that rebuild_sched_domains()
> > > does _not_ take the hotplug lock before calling partition_sched_domains()
> > > when CONFIG_CPUSETS=n. But it does take it for CONFIG_CPUSETS=y.
> > 
> > Did you mean cpuset_mutex?
> 
> Nope, I really meant the cpu_hotplug_lock !
> 
> With CONFIG_CPUSETS=n, rebuild_sched_domains() calls
> partition_sched_domains() directly:
> 
> https://elixir.bootlin.com/linux/latest/source/include/linux/cpuset.h#L255
> 
> But with CONFIG_CPUSETS=y, rebuild_sched_domains() calls,
> rebuild_sched_domains_locked(), which calls get_online_cpus() which
> calls cpus_read_lock(), which does percpu_down_read(&cpu_hotplug_lock).
> And all that happens before calling partition_sched_domains().

Ah, right!
 
> So yeah, the point I was trying to make is that there is an inconsistency
> here, maybe for a good reason ? Maybe related to the issue you're seeing ?

The config that came with the 0day splat was indeed CONFIG_CPUSETS=n.

So, in this case IIUC we hit the !doms_new branch of partition_sched_
domains, which uses cpu_active_mask (and cpu_possible_mask indirectly).
Should this be still protected by the hotplug lock then?
