Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 40022C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6A33208DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 15:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9rKJEeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6A33208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936050AbeFNPBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 11:01:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35240 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755194AbeFNPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 11:01:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id j15-v6so12695611wme.0;
        Thu, 14 Jun 2018 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NQol1Gie/v8EU3+VU/rb1yTkjnRSY0Dnj6C9MPXATbc=;
        b=b9rKJEeAAaMA+xdZJitM9LP1YBIO/1ZwF2sGpdgJLJj062N3vRccCFfA7R28YZkmb5
         o930FnLZrcO7iYxA2azA3NtilwumKNUFmLEFxIUdcd3+nN+mxKnNbWhMmUK52VB6D+OI
         pJxW0Nrr63Eh4ie5DJ1xEKkZ1lvE4iH1AxxYU1e76Ez1k3eaXrJcy5+7iEof+p0xrdCX
         zq4Zt7kW/jpIotPFcKO67j2PVyRuDLT6j13trxA7Ig9Zd1kGAx8mH5m5YBLa2Dhu8xMn
         6WBZ8irpTwwY2EvTx012mcfZ8Vkg76IZMDkD2MgVXBy1rtU9JwYVtQKm7fiRRBLWnXN5
         dizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NQol1Gie/v8EU3+VU/rb1yTkjnRSY0Dnj6C9MPXATbc=;
        b=D+i3b/tqjJ3yK6vP3ZNRohbMzR3ZUTJe0xP4iFPAcSE001sQ1QDptTss64IgX6Yc9O
         uS1/O6vsg/lwpY/nbC/E4QQZrDOeRh4U0KlPctIIzcLvwL4pSgmWHOdMwoYnWfIqjaG8
         e8UKD+cZfPKsVNzXp9QtcrN9nWqt0h9GogVt381QGS3iC5M9V/jQCnHWAYnjOv9fn9AS
         1chD/oBBLszJvCL+U0VjVTzgmec8wDdtlPJO18P6FHa7rBeHCr09JE9SOUR5AQRInSOX
         mMCC9UWuF2OApVfARJv8wHem04WV188WJl6w+/NNe6rF62Eu7BHKPB+kkWdRluwIRSNP
         3ydQ==
X-Gm-Message-State: APt69E3eJoh3gaihhQT3FltgEcsLb5Dndtk87lZDYdd2/vQDRIBf0YSp
        8Bfz3YG9JVJrnltfgdJ7osSINA==
X-Google-Smtp-Source: ADUXVKLBKIrRDf45WaTPEI6cGwW68eH+3M093WQngp6PckZiAdYTsfyQA6jzqw3NMD2xl7jRUPHzpA==
X-Received: by 2002:a1c:7ce:: with SMTP id 197-v6mr2146545wmh.134.1528988473025;
        Thu, 14 Jun 2018 08:01:13 -0700 (PDT)
Received: from andrea (85.100.broadband17.iol.cz. [109.80.100.85])
        by smtp.gmail.com with ESMTPSA id b14-v6sm5854749wrn.57.2018.06.14.08.01.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 08:01:12 -0700 (PDT)
Date:   Thu, 14 Jun 2018 17:01:07 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 09/11] docs: Fix some broken references
Message-ID: <20180614150107.GA21191@andrea>
References: <20180509152045.722f0c51@vento.lan>
 <Pine.LNX.4.44L0.1805091509100.1391-100000@iolanthe.rowland.org>
 <20180614112343.61bb84d7@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614112343.61bb84d7@coco.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 11:23:43AM -0300, Mauro Carvalho Chehab wrote:
> Em Wed, 9 May 2018 15:11:07 -0400 (EDT)
> Alan Stern <stern@rowland.harvard.edu> escreveu:
> 
> > On Wed, 9 May 2018, Mauro Carvalho Chehab wrote:
> > 
> > > Em Wed, 9 May 2018 19:15:01 +0200
> > > Andrea Parri <parri.andrea@gmail.com> escreveu:  
> > 
> > > > >  tools/memory-model/README                     | 10 +++++-----    
> > > > 
> > > > As mentioned in the previous thread, I am for keeping the current
> > > > references: the REAMDE is listing the doc files, as well as other
> > > > files in tools/memory-model/, relatively to that directory.  
> > > 
> > > Yeah, at least this hunk deserves some rework, as now some
> > > references are Documentation/.../foo, while others are just
> > > bar.
> > > 
> > > As on (almost) all other places (except for tools/memory-model/README),
> > > the references are always from the main directory, I would make all
> > > patches there also relative to main dir. If you're afraid of
> > > not being too clearer, we could prefix all of them with something
> > > like:
> > > 
> > > 	${LINUX}/tools/memory-model/...
> > > 
> > > just like some DT binding files do:
> > > 
> > > 	Documentation/devicetree/bindings/sound/audio-graph-card.txt:see ${LINUX}/Documentation/devicetree/bindings/graph.txt
> > > 
> > > A bonus of doing that is that the broken reference detect script can
> > > keep parsing it without changes (well, it wouldn't be hard to make
> > > it also accept a relative file, but doing that just due to 
> > > tools/memory-model/README seems overkill).
> > > 
> > > Another advantage is that it would allow to easily add references
> > > there from the main kernel Documentation, if needed in the future,
> > > without messing with local x non-local relative namespace.  
> > 
> > How about changing the relative references so that something like
> > Documentation/recipes.txt becomes ./Documentation/recipes.txt?
> 
> Thanks,
> Mauro
> 
> After thinking a little bit about that, it should be easy to fix the
> tool to consider references relative to tools/.*/Documentation.
> 
> I intend to send a new patch series with the changes to 
> tools/memory-model/README removed from this patch and with the enclosed
> patch on it.

LGTM,  thanks!

  Andrea


> 
> Regards,
> Mauro
> 
> [PATCH] scripts/documentation-file-ref-check: check
>  tools/*/Documentation
> 
> Some files, like tools/memory-model/README has references to
> a Documentation file that is locale to it. Handle references
> that are relative to them too.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> 
> diff --git a/scripts/documentation-file-ref-check b/scripts/documentation-file-ref-check
> index 047f463cdf4b..078999a3fdff 100755
> --- a/scripts/documentation-file-ref-check
> +++ b/scripts/documentation-file-ref-check
> @@ -78,6 +78,13 @@ while (<IN>) {
>  		# Check if exists, evaluating wildcards
>  		next if (grep -e, glob("$ref $fulref"));
>  
> +		# Accept relative Documentation patches for tools/
> +		if ($f =~ m/tools/) {
> +			my $path = $f;
> +			$path =~ s,(.*)/.*,$1,;
> +			next if (grep -e, glob("$path/$ref $path/$fulref"));
> +		}
> +
>  		if ($fix) {
>  			if (!($ref =~ m/(scripts|Kconfig|Kbuild)/)) {
>  				$broken_ref{$ref}++;
