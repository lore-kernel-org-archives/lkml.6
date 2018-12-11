Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18183C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9042082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oj0E8yaY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9042082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLKJIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:08:34 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41213 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeLKJIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:08:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so6346977pgh.8;
        Tue, 11 Dec 2018 01:08:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2wgblOvfpCadgNHCdpiEcj8xcdCLsvmycdSsWcwXhyo=;
        b=oj0E8yaYKV2RX2P7FxN4bZbPaBbCVbw8S5Nd8YzkTyZKJZtnaehDoRwlrjUDzt62Xl
         yNSjtvPVrg8fo88ol4lS1fNX1O07X48ohoIAcvqvxf2iOA1caW8eVKkOn64N39ZZ29s0
         ciMNspVqEPgOUiDBQOQJ8KzQfZ2Bfk3WU34QVhVflWLqrNkIa1GWUDgnw6LttKgF9fSJ
         jPs69IDhear0WtLdR/NnAu3DTHbDr9LRhlEi0PEe88FPwoUP+3/kNjBvB85SUiFg+tuH
         E6dFWgPoQpr2a5VjRp5Qq8p5MP8CtOfU0wBxJ/IQZDBzHW3snJJr2TQQZ9nosWDSJ+nL
         LeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2wgblOvfpCadgNHCdpiEcj8xcdCLsvmycdSsWcwXhyo=;
        b=Ae22zQlnzaqNooPv7ah/kCvgf/sC7f1dgnr73zwBsTMPQ1kSy9AJ0pWn5CjGTH5oYd
         EcYkk6wP2o9tRbFQpw4VsBj0E/CJNUkL4EM7beesf3fkdUnFcQjykzC2Ok+7ZY4ifLRt
         WMN3j/Wx6i9hvL7VPbyqV+wkB4ShblyVhJvRU6KLo6XGsICAa6zHGfVTohNhrNE97ZTQ
         XV+0tINvErMGiiTJZCrvc8yzS+vhA8I9wpCH3S+BCzoE/x4VrD36Q6S7SolnTUdIb8cY
         LHl/TTaXdZDMGqqIzx5wYHfUvTBSHwt0I0AAApkvNYG7iNnX9Jv3ZmnKoglMr1Ubidnp
         no3Q==
X-Gm-Message-State: AA+aEWa5DQ3Odt65HJt7XyCELeBPhLtgT41uW9RONd/Kad2BpT4sZP3a
        komoN6KTCjXhw9KxvL6Qeqk=
X-Google-Smtp-Source: AFSGD/UTxorf/bdmgwPYJdW8ZmLkKrc9JHM+nJjbLGpdv+9gnf4tVDQdDnUlOrOpNCII7OHauBhIPQ==
X-Received: by 2002:a63:ac1a:: with SMTP id v26mr14084389pge.293.1544519313369;
        Tue, 11 Dec 2018 01:08:33 -0800 (PST)
Received: from localhost ([175.223.2.144])
        by smtp.gmail.com with ESMTPSA id u6sm15282940pgr.79.2018.12.11.01.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 01:08:32 -0800 (PST)
Date:   Tue, 11 Dec 2018 18:08:29 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Feng Tang <feng.tang@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        akpm@linux-foundation.org, bp@suse.de, keescook@chromium.org,
        mm-commits@vger.kernel.org, sergey.senozhatsky@gmail.com,
        stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: + panic-avoid-the-extra-noise-dmesg.patch added to -mm tree
Message-ID: <20181211090829.GA471@jagdpanzerIV>
References: <20181205025728.GC503@jagdpanzerIV>
 <20181205052912.GA423@jagdpanzerIV>
 <20181205080044.GA11190@jagdpanzerIV>
 <20181205154620.4dqtledc2duhrp2c@shbuild888>
 <20181206035825.jz2bfh3errj23rjq@shbuild888>
 <20181207095004.GB3729@jagdpanzerIV>
 <20181210094554.z5n7dmkrnlcpygg4@shbuild888>
 <20181210155705.qowbi7xvszzfonzk@pathway.suse.cz>
 <20181211080743.GB521@jagdpanzerIV>
 <20181211083207.b5mbbuohsiorqnoj@shbuild888>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181211083207.b5mbbuohsiorqnoj@shbuild888>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Frederic,

https://lkml.org/lkml/2018/10/11/304


On (12/11/18 16:32), Feng Tang wrote:
> Here is the v1 patch: https://lkml.org/lkml/2018/10/11/304
>
> And actually no one ruled out the v1 patch :), I don't have HW of other
> archs like arm/ppc, so I just read some of the arch code, and found
> most of them use the similar flow like x86, that's why I chosed to
> finding a soluton inside panic.c itself.

Interesting. So if the problem is that we need to clear cpu bit in
several cpumaks (e.g. nohz.idle_cpus_mask) when we stop_this_cpu(),
then I'd say let's clear cpumasks which are needed to be clear (doing
some of the things which sched_cpu_dying() does, except that we need
it on !CONFIG_HOTPLUG_CPU systems too). The idea of notifiers also looks
interesting.


x86 and sched gurus, can you please help?

	-ss
