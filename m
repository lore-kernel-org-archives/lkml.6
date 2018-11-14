Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2A3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713F0223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 19:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="n0+uLwfo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 713F0223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726348AbeKOFR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 00:17:27 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46390 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725757AbeKOFR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 00:17:27 -0500
Received: by mail-qk1-f194.google.com with SMTP id q1so27788107qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 11:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rKum7I1gn0a5UTdYuYZKys3E/k34JOcd+Hmhhlesiu0=;
        b=n0+uLwfotrDroncoP0/QducyFYPIthRT1zkroDhhEwCgqcyFuEMNctjUmORAxLKDyr
         tDYQtWCxl/ABNBEeSOg2reInYlSlndfu4WcABuq3sPWvPF+dmH5njQXjJjaoHpI+NOjG
         d2xnKFblxXh737aO7hV1waD2/S3yEJjLN9l6+C3RdRgcPpw9ZLZOu9BCAcUIvNRIMz/s
         EK85QolTDzkLDK7Jh7dDFBJOJeB7tES8pxEyrMkaUL5DqdgDrUQKCm08vUgsAJviJ9M1
         36bBhFI20ALm7w5Xal84h/1d0ZE0xrGJrsexffgZ5U7YBYnUqPZ67/VnD8BcHUbDZn/X
         KNZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rKum7I1gn0a5UTdYuYZKys3E/k34JOcd+Hmhhlesiu0=;
        b=c54el+DUGfHQdUeGxegbdDc6NFa51V+R5RnVUHgk27UDrB8DRMSwHC77T0Af6EQXY+
         tASYHs3wBHrR+9PGgFH/61wGNyFe9LEx1eU8KmZqvT7Fj2J6H+mNkMT7Mr+2XpC0JHeb
         YPyYsS+nu0Vs8t+GaYt06bl4yHbL1sSY9DjhgPS+Xat2kXOudxeQ4xHjwo3hnqTSDl3I
         kwBD/svson+OLF3YrE03mhZtwRPTL+c1W4sQuhQtmkUzaRRYrc7YGe20h9xcLggpzwx/
         58OGrWnbfwk/A48jgKtidgAFZ7B66RxQURVRb0zkpZh5LqByqzSYQu46UGcmXHqkxjlg
         67yg==
X-Gm-Message-State: AGRZ1gKIUkPalGk4u3CDdbsTsvYNl5ziEK2iplQbOFlkJxoJU/wl63W0
        F15DIT7VAS87vujHcMMO5WRxKw==
X-Google-Smtp-Source: AJdET5fW2We+6PxunCVpqzSgQzbh8Kt/jab2+GPxn9a02MFqgZVb4dfT9JsgDCbnYO0sZ906AQsq/w==
X-Received: by 2002:a0c:92c3:: with SMTP id c3mr3194159qvc.12.1542222779397;
        Wed, 14 Nov 2018 11:12:59 -0800 (PST)
Received: from soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net ([40.117.208.181])
        by smtp.gmail.com with ESMTPSA id y14sm10916907qkb.2.2018.11.14.11.12.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Nov 2018 11:12:57 -0800 (PST)
Date:   Wed, 14 Nov 2018 19:12:53 +0000
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, davem@davemloft.net,
        pavel.tatashin@microsoft.com, mingo@kernel.org,
        kirill.shutemov@linux.intel.com, dan.j.williams@intel.com,
        dave.jiang@intel.com, rppt@linux.vnet.ibm.com, willy@infradead.org,
        vbabka@suse.cz, khalid.aziz@oracle.com, ldufour@linux.vnet.ibm.com,
        mgorman@techsingularity.net, yi.z.zhang@linux.intel.com
Subject: Re: [mm PATCH v5 0/7] Deferred page init improvements
Message-ID: <20181114191253.rpwm4d23yeahnavw@soleen.tm1wkky2jk1uhgkn0ivaxijq1c.bx.internal.cloudapp.net>
References: <154145268025.30046.11742652345962594283.stgit@ahduyck-desk1.jf.intel.com>
 <20181114150742.GZ23419@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114150742.GZ23419@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-14 16:07:42, Michal Hocko wrote:
> On Mon 05-11-18 13:19:25, Alexander Duyck wrote:
> > This patchset is essentially a refactor of the page initialization logic
> > that is meant to provide for better code reuse while providing a
> > significant improvement in deferred page initialization performance.
> > 
> > In my testing on an x86_64 system with 384GB of RAM and 3TB of persistent
> > memory per node I have seen the following. In the case of regular memory
> > initialization the deferred init time was decreased from 3.75s to 1.06s on
> > average. For the persistent memory the initialization time dropped from
> > 24.17s to 19.12s on average. This amounts to a 253% improvement for the
> > deferred memory initialization performance, and a 26% improvement in the
> > persistent memory initialization performance.
> > 
> > I have called out the improvement observed with each patch.
> 
> I have only glanced through the code (there is a lot of the code to look
> at here). And I do not like the code duplication and the way how you
> make the hotplug special. There shouldn't be any real reason for that
> IMHO (e.g. why do we init pfn-at-a-time in early init while we do
> pageblock-at-a-time for hotplug). I might be wrong here and the code
> reuse might be really hard to achieve though.

I do not like having __init_single_page() to be done differently for
hotplug. I think, if that is fixed, there is almost no more code
duplication, the rest looks alright to me.

> 
> I am also not impressed by new iterators because this api is quite
> complex already. But this is mostly a detail.

I have reviewed all the patches in this series, and at first was also
worried about the new iterators. But, after diving deeper, they actually
make sense, and new memblock iterators look alright to me. The only
iterator, that I would like to see improved is
for_each_deferred_pfn_valid_range(), because it is very hard to
understand it.

This series is an impressive performance improvement, and I have
confirmed it on both arm, and x86. It is also should be compatible with
ktasks.

> 
> Thing I do not like is that you keep microptimizing PageReserved part
> while there shouldn't be anything fundamental about it. We should just

Agree.

> remove it rather than make the code more complex. I fell more and more
> guilty to add there actually.
