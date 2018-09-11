Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15C6C4646A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78DB120866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbpgTSeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78DB120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbeILC0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 22:26:07 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:42874 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbeILC0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 22:26:06 -0400
Received: by mail-pl1-f175.google.com with SMTP id g23-v6so11901389plq.9;
        Tue, 11 Sep 2018 14:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zm8b+z7Tzvx5KXCA16Wyh3pW7bFCfOnjzZ3jHX41jgg=;
        b=bbpgTSeBlrM0P/ryDaYU/90HbKMIEx8laPOLezLcrPB1S9egh3n26gWDuSoZ2jkg5b
         u7itIGNoPWIr2FTxRfnkHS41ChFzEDgzfWaEYf61LboXGImjvHkd4xbYlQwgNOgPhEDY
         njgEiWq05MuyndNdkmV+2lp+97Va45IyMNG+hCuwyszKeqRdogrUzSX8BAmSuwoXmyXR
         TGdkvEeyQL+J9JjOZQW/yFsof0qsDtiK0i5EkWSiKGigUwuURVDz4NtnpR1TeB36AthJ
         tiUI5B1bvROY3ZJ/mBuk/LHUr3bPcgL70njIh5lGWJ1MIoVFvngp5Mmduw58tz1A9zNE
         P6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zm8b+z7Tzvx5KXCA16Wyh3pW7bFCfOnjzZ3jHX41jgg=;
        b=cNbYQxurRBmFfof9CIFcN5k6Vp4ZDx8BIyeBCagZZKBy3aBQ1KspnaLI+NU5XR/riV
         0bS5oPtJwIiKuofmLkMfduostKB7tad5x23szAfhDQpeZK/0XB3wN0s3hjaZ70Dif5dJ
         05I/t4k/LHlCCjjhsjDoIgAbZP4JUPC2aOoGrPv5ZlWTlptcnGvnVgl6P2hUpldKBRvk
         cy7P95MNhSfzO/zWLlvLZNaRdllda8NqZI0qKpr7/SJCF1JkDsY8XmarKu3M/bpyj41k
         +AQ+ncqW+B1FHyDxM6M2egV9LHid2bQp+H/9XpYWhpenBRP7xjheUH6YYD/bPrINmUfD
         KoGw==
X-Gm-Message-State: APzg51CwyqQyLBeromSFpd1Ln5DKM2wFO6CcakSDJILthOQi0K4OuPQJ
        l1u4YnMpVmjMC3NQkPDAhys=
X-Google-Smtp-Source: ANB0VdZPt6zZboUUXgVkvuhGaflkO3nnAFgafTS0FuhLTaWf/LAOvX+rHuszW52dZw15EoHRbPNRcQ==
X-Received: by 2002:a17:902:bb08:: with SMTP id l8-v6mr23164394pls.71.1536701094924;
        Tue, 11 Sep 2018 14:24:54 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:200::4:2d48])
        by smtp.gmail.com with ESMTPSA id p64-v6sm31376077pfa.47.2018.09.11.14.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 14:24:54 -0700 (PDT)
Date:   Tue, 11 Sep 2018 14:24:53 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Networking Development Mailing List 
        <netdev@vger.kernel.org>
Subject: Re: libbpf build broken on musl libc (Alpine Linux)
Message-ID: <20180911212451.hvnyfwyvcs4yojqy@ast-mbp>
References: <20180910172903.GB15516@kernel.org>
 <20180911122218.0d2eb3f9@cakuba>
 <20180911121543.GB22689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180911121543.GB22689@kernel.org>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:15:43AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Sep 11, 2018 at 12:22:18PM +0200, Jakub Kicinski escreveu:
> > On Mon, 10 Sep 2018 14:29:03 -0300, Arnaldo Carvalho de Melo wrote:
> > > After lunch I'll work on a patch to fix this, 
>  
> > Hi Arnaldo!
>  
> > Any luck?
> 
> Well, we need to apply the patch below and make tools/lib/str_error_r.c
> live in a library that libbpf and perf is linked to.

do you want us to take the patch or you're applying it yourself?

