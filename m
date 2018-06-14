Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 95166C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 562A520020
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 562A520020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbeFNNrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:47:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:32872 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754990AbeFNNrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:47:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id k16-v6so6528505wro.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 06:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ar2RMqw31uY6lyyAZk3x/8IfH55xsA7op4sGcJVmiUM=;
        b=P1WFehNhh5M1CRNa+riPA/r7RgH4dVUknKXSEBpttp1eajAkHmT8M6ijOFrP8+mjvw
         4yV1zhcrO1pkggKdsEPeBudgcDDqSLB/9uA4L+nOa1ImY9FEFHOV9Uhst62kh665Z54s
         JbcC6LoRElxEqxXEkAxEhBYEA2IfCl3MfSK8R965zNe0M98ebk28waFBEus+iE2hMQhc
         I9HTTDird1R8OPoPKWCtQ9A/Yn2kNQpVwK3XYtOIEWeUeJwbv+d3MZdxBD+eeNXYeoZw
         rjZGjJKWNVL50IjX9KMSKD2FUykZQb3c3NyJEJ4CWql6b4+bCfMriRVFN90+bsxdBtYd
         xO6g==
X-Gm-Message-State: APt69E3HUJace7TDobbI3w6voLFIMAepHTSaHvZPHzPgPXoU+Nz4gwZs
        x2KknAIB2J9Jcn5JWwWdCz7kkQ==
X-Google-Smtp-Source: ADUXVKLl6H58VnC+J7p2uVDuIZvflSvZofl6gVNaZV9wL4TaLwpnHtNXdiYzFnOFnzd5LU8m6dyTGQ==
X-Received: by 2002:adf:9a31:: with SMTP id z46-v6mr2297144wrb.47.1528984054819;
        Thu, 14 Jun 2018 06:47:34 -0700 (PDT)
Received: from localhost.localdomain ([151.15.207.242])
        by smtp.gmail.com with ESMTPSA id u108-v6sm11181267wrc.40.2018.06.14.06.47.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jun 2018 06:47:34 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:47:31 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org, lizefan@huawei.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v4 2/5] sched/topology: Adding function
 partition_sched_domains_locked()
Message-ID: <20180614134731.GD12032@localhost.localdomain>
References: <20180613121711.5018-1-juri.lelli@redhat.com>
 <20180613121711.5018-3-juri.lelli@redhat.com>
 <20180614093536.612712f6@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614093536.612712f6@gandalf.local.home>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/06/18 09:35, Steven Rostedt wrote:
> On Wed, 13 Jun 2018 14:17:08 +0200
> Juri Lelli <juri.lelli@redhat.com> wrote:

[...]

> > +/*
> > + * Call with hotplug lock held
> > + */
> > +void partition_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
> > +			     struct sched_domain_attr *dattr_new)
> > +{
> > +	lockdep_assert_cpus_held();
> 
> Is the above assert really necessary? The assert will happen in
> partition_sched_domains_locked() anyway.

Indeed, it seems of little use.

Thanks,

- Juri
