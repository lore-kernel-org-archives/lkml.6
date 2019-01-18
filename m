Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E565C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D011D20850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547828264;
	bh=5cImaw8sRDttPU09tqtvYoG6ACsIJ+zp9AlOZCGmqCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C69uxAxj1VfJNO8W5mfJO5kz8fnrfndzws6vCQ4gcvmVLK5+LHieby37mR8iAeOGj
	 o4VhjFAVmKqbyAzRBrLEuCDpxWgc3zFlHxbo81dozWI3bxf+gOyI7pcOnB5K/beq2s
	 FgCLHJzJVVAAzVZsL7QC69/1IEInllHC9Y0pMGdc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728221AbfARQRn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:17:43 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:34837 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbfARQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:17:42 -0500
Received: by mail-yw1-f66.google.com with SMTP id h32so5433097ywk.2;
        Fri, 18 Jan 2019 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jxu0a1nkN3ZpzOxZbKmUrpD1yZ9zO9HuQcvnymZzhI0=;
        b=jz72BFxjt22s+qMlTfP1yKEqVRPB4cfDgk/N/nj7blKvYgkPWP3VEgyg0DStL144Ci
         Y6XYdYW0kyK4R2xkoyfThcbL7ufeBvSTiRZtmq1k1wowHcaQUqkt9efm3izvgfx3Si75
         MrhJwiQqrbLUZUer7Xu0a9lhkKS6OSz69ApO+zA+N8cuI8TrPIm5KHyeCKszHPq72J7x
         BGkkdmpSnHuyulZPo0PvEFMac2Ju7bvPqY15ueTozLBt/XvKiRifhygeGNv/7po6/oPL
         OX9ddJAvoxnxl96g9+XnRAu5+ttXnU7SHF+Y08Pl8CxTHupiwi+F2vQdi+g6p0WsWSEK
         h2lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jxu0a1nkN3ZpzOxZbKmUrpD1yZ9zO9HuQcvnymZzhI0=;
        b=sHic7p4nB3Vs8iYutUt1r5xgJzpa1S03O2hHi5kSXOW5o6EdsSerYxqNs1d74dMfbH
         sdChBAiJ9yRH1uoJ6Zf1myGXXk3OiexMBE8XLq0AQ0mW3wA+IlByeSMr1/103MQ9yPSa
         AvQ9hp0CDUdsEe3FnKXBfT2GdeKVJpO5B/8ar7EgoqG2ugs+MOBga+hfqWTiSTRH5g6Q
         bgiWK1UQe/4ZGD5Jx2uJf2HPn2rnP7jHzDEZfEV7J1eYgNvNzDnDlfFzjfR8cg3ZqbfP
         1sr/TQdk3N6521c4pRNJzdDn79SAsCfCOLdY3zK3S51Y9VHqHPXhSAzMwJMov9sfzrRJ
         fC/g==
X-Gm-Message-State: AJcUukfEOWHsRLTDcWScUsCrFGGz3MM35kpUXYAAfwmmLKs8pa8mcN17
        g/2yXqQUj4pkVEXSjvNfWuc=
X-Google-Smtp-Source: ALg8bN5gjPBoTBrZDaCIGJ0U6pKNzT/2eYAjRT+vt8hYTU0Z/VaZe3PAeBSO31QpQjRqXllLV8G2Eg==
X-Received: by 2002:a81:b101:: with SMTP id p1mr18804777ywh.454.1547828261525;
        Fri, 18 Jan 2019 08:17:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::6:586f])
        by smtp.gmail.com with ESMTPSA id w63sm1954895ywc.46.2019.01.18.08.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:17:40 -0800 (PST)
Date:   Fri, 18 Jan 2019 08:17:39 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v6 0/5] sched/deadline: fix cpusets bandwidth accounting
Message-ID: <20190118161739.GE50184@devbig004.ftw2.facebook.com>
References: <20190117084739.17078-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117084739.17078-1-juri.lelli@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:47:34AM +0100, Juri Lelli wrote:
> Hi,
> 
> v6 of a series of patches, originally authored by Mathieu, with the intent
> of fixing a long standing issue of SCHED_DEADLINE bandwidth accounting.
> As originally reported by Steve [1], when hotplug and/or (certain)
> cpuset reconfiguration operations take place, DEADLINE bandwidth
> accounting information is lost since root domains are destroyed and
> recreated.
> 
> Mathieu's approach is based on restoring bandwidth accounting info on
> the newly created root domains by iterating through the (DEADLINE) tasks
> belonging to the configured cpuset(s).
> 
> Apart from some minor refactoring needed to rebase the set on top of
> Waiman Long's cpuset for cgroup series (now mainline), two changes worth
> of notice:

Generally looks good to me but can you please ask Waiman to take a
look?

Thanks.

-- 
tejun
