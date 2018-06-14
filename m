Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EC65FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADFB6208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 14:30:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFB6208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965998AbeFNOar (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 10:30:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36905 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965815AbeFNOLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 10:11:22 -0400
Received: by mail-wm0-f65.google.com with SMTP id r125-v6so12301651wmg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 07:11:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wUCha74m8lOVj/v4CbJo6HtdMzFUFPb2t4uwXhprWN8=;
        b=qojRt5PX8UiUsqhTnLmL5tmV1Yxnhd4roKT9V9H24daj9gGkDSXYNfurgwWldVPsBY
         rixWwVY3u3j6xpvTh0yWpiy+kpaT/Pc7yD+8dECONat0zCjY1AdVC80ec08KRb0EqVoh
         2u1IHBhipCPgxhIa5Ywn58duPSBtT8Lee6U7gQ4twANfgEklfuhFpAr6vHdNz6YeuxJH
         Mq57FdXQm3fbIONJW9IJGJRex7j598QGgBhWAcJDBcFkLoRnKN4FM4EpqPKr32MHnXHA
         SdLJs+aUPqEpXs6V6JvqfLgO8TQfmDbdQG+9hK9B2jJQlH4l9fbrBu9xq82egv+XHEa7
         xAcA==
X-Gm-Message-State: APt69E2gVWOadIE7Da4Zr0ByNuvwmbXcuETC5aEJ5pvg83tUopoO7mcW
        K4ZGOjSW50o1FIdqcRt3lNBuHg==
X-Google-Smtp-Source: ADUXVKKKqdIRnySbkvT6vHWDBsBiQsxAa8URZwjNiiYV3twgzw8TUXfV4XbOk6yL+6cCwOHB1BJiFg==
X-Received: by 2002:a1c:a54e:: with SMTP id o75-v6mr2111224wme.157.1528985481496;
        Thu, 14 Jun 2018 07:11:21 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id 127-v6sm8042426wmk.45.2018.06.14.07.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 07:11:20 -0700 (PDT)
Date:   Thu, 14 Jun 2018 16:11:18 +0200
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
Message-ID: <20180614141118.GG12032@localhost.localdomain>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
 <20180613121711.5018-2-juri.lelli@redhat.com>
 <20180614093324.7ea45448@gandalf.local.home>
 <20180614134234.GC12032@localhost.localdomain>
 <20180614094747.390357ec@gandalf.local.home>
 <20180614135040.GE12032@localhost.localdomain>
 <20180614135800.GM17720@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614135800.GM17720@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 14:58, Quentin Perret wrote:

[...]

> Hmm not sure if this can help but I think that rebuild_sched_domains()
> does _not_ take the hotplug lock before calling partition_sched_domains()
> when CONFIG_CPUSETS=n. But it does take it for CONFIG_CPUSETS=y.

Did you mean cpuset_mutex?

cpu_hotplug_lock seems to be the problem here..

Can't seem to follow otherwise. :-(
