Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C2BC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8548120700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544112935;
	bh=PpZJscDoCukG5QansKaFjhF8UTIK+6+yMDU0D/pA4vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Cczk2XKk685NhS3GvktWLGlasqSS50BefeIB6fXr7SBu6lLvZ/U1xV38qYQQW7/8w
	 Xgngz5PacnpxuIMR3nHYBW8DVpkue+9rNoFZMpRcGwStqfWYHAcZsyHjmN31xyBls8
	 0KaeGaUncr5eqAPXRFALnyIIcOf/4dJ67FAx4xAY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8548120700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbeLFQPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:15:34 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44909 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbeLFQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:15:33 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so1020109wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0KMgvRWNyZs5n/y6OGb7UIgcxltyRuDhKHxxfZCyp0A=;
        b=n0omP5arANXJtLgA4F3qh/p+QgCcD+i82lAX8AfyLhmk8sBT1YUczBazWU0CYu+FhO
         Que7k8n5fgJuJidYJKs/ZSQWlxpHOZMaJ+XwalCLItURzpfrXr0cr2if1yC3B3EOhFjS
         CXrnIolGKbVm9BOqlV2w/DhYA8/9QRe0k/johyBLmGYVHV/q6VqjcZMiu/+68hZsk206
         9xEPCK/iIVGAWA2FtLe1PT4VuNoLQ7/YeCTMGSBkYJ/M0LLBYaKXQ2fwmETac4no+W9i
         0X/Ug332yChAd07HcjQoz5mHvaf4IBqz4CdEi60mipJ3SdvndmSoChB6K42OXT/mAyNG
         bALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0KMgvRWNyZs5n/y6OGb7UIgcxltyRuDhKHxxfZCyp0A=;
        b=kk2/9AITBjnreyxJiYMUe2LxXeth/4sfUMe2t5qbqgme2gLds6QZ5nz7hQhhAySOIJ
         KphOtqN5NznNMUlUtppyUWCwgTyu6ERGfnNHkRRekXSBSJpLdG4AZfmM9/jm97289Vu7
         ZhW5AP3vFsUzPWkOEgQLIN2r4OwugfnlaugviStPmqN0QdFHDgo9OP7LN/rsMNMtEjTj
         vnMCtJWAP72Bu2iLPDNqVMXipTqyiHyPri5w7aPi5IPjfOvvWLZFCHSusa+MDXzBJQnx
         /028tGkzk12MnRqDvInb3lpuhF7GGFl+j59xjc+P4JzvZ1CGTIQ+9/sVJMnQi/lDqF8/
         bg3A==
X-Gm-Message-State: AA+aEWbfZZstYSMMuvaZXlcFX1N64QU84WS1wbqCKZE+dlNiMGaLUBez
        Qv5pZBBks2K+12qGftFTnYo=
X-Google-Smtp-Source: AFSGD/WD9yMXW2k1dO9w4g3Ysyhntm3V2T5S3g8Fjc7cJD/EDixDQjli6yJA5q7wjl+Ms8lRNJhT7Q==
X-Received: by 2002:adf:e983:: with SMTP id h3mr24970266wrm.232.1544112931594;
        Thu, 06 Dec 2018 08:15:31 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e17sm596092wrs.79.2018.12.06.08.15.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:15:31 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:15:28 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Will Deacon <will.deacon@arm.com>
Cc:     Anders Roxell <anders.roxell@linaro.org>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH] scripts/atomic: change 'fold' to 'grep'
Message-ID: <20181206161528.GA118885@gmail.com>
References: <20181204214713.5812-1-anders.roxell@linaro.org>
 <20181206155244.GA4389@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206155244.GA4389@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Will Deacon <will.deacon@arm.com> wrote:

> [+ Ingo and Mark]
> 
> On Tue, Dec 04, 2018 at 10:47:13PM +0100, Anders Roxell wrote:
> > Some distibutions and build systems doesn't include 'fold' from
> > coreutils default.
> > 
> > .../scripts/atomic/atomic-tbl.sh: line 183: fold: command not found
> > 
> > Rework to use 'grep' instead of 'fold' to use a dependency that is
> > already used a lot in the kernel.
> > 
> > Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Suggested-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > ---
> >  scripts/atomic/atomic-tbl.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/scripts/atomic/atomic-tbl.sh b/scripts/atomic/atomic-tbl.sh
> > index 9d6be538a987..81d5c32039dd 100755
> > --- a/scripts/atomic/atomic-tbl.sh
> > +++ b/scripts/atomic/atomic-tbl.sh
> > @@ -180,7 +180,7 @@ gen_proto_variants()
> >  #gen_proto(meta, ...)
> >  gen_proto() {
> >  	local meta="$1"; shift
> > -	for m in $(echo "${meta}" | fold -w1); do
> > +	for m in $(echo "${meta}" | grep -o .); do
> >  		gen_proto_variants "${m}" "$@"
> >  	done
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Ingo -- please can you take this one via -tip?

I'm still waiting for a reply to my previous concerns expressed in:

   Re: [tip:locking/core] locking/atomics: Check generated headers are up-to-date
   <20181128083057.GA7879@gmail.com>

Will remove it from linux-next if there's no good resolution for this 
cycle.

Thanks,

	Ingo
