Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686D6C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B7DD20881
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn/0NDoQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B7DD20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbeLCGLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:11:55 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42817 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbeLCGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:11:55 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so5804811pfr.9
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nnqkeFmyEgPPB74hL2bJozRRr7Cq2ljeUYebz0iEsHc=;
        b=Kn/0NDoQeIA3LRyMuoAIsuz6BeCCiGVPt9PIFvs36+qfeelUQg4NFh1GwSQKoaqmkD
         xZFhG9hHJCObQEeYf56D/UGWwnuba4HdyL14rU3kU4zrrp6LraM2Mf3qkePs3CkuEpH/
         mwOUfMalO/mySxY2PGkmhIwJNKo7gDUHgatcJbNHcy/IFvMLFodi32vSvcyBvpYHgChe
         opIE3eV0NQAthou0Pycy98obMKFGlcpaoBhDd+bhz2MMrM136vmVDQGfqeb37i1Ao6ck
         NDtPjKsM4ShzoEUJ4JDbYv8d/Pk0o/2gisMXNKJIlXxlAan2guaeJn/Vbgibda06oZyV
         OpkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nnqkeFmyEgPPB74hL2bJozRRr7Cq2ljeUYebz0iEsHc=;
        b=PkZh3IrrE3d9XVtaDrL5wbRZxqv0bzeUZdIknhh2qIMHVZTkyBz2jsgxPLYiNp2twJ
         ZEmVRCm4frR184T2VEZWpLT0KMrn+9gple3C/Rref278bBmyuRalKb0DG94LHw/yW5lO
         jGMo1bcYsdZ8LG5wVbUS23ZjuqciveU+posc28mx4vjef5eggrD2FIkcJ6/lVa9dInws
         qOsg126A8NVlagX+wJuwdF/mjSdEBqpZYGB/Y0iObCQwSEJwqz8AKkzxgzlhS0uR4ouU
         mm1J0BE9nUS+L15dbk23LpQudug+dqIKZx7W79rlEbs2g4e3HTjIf9VThBdKPeHGA6fW
         Ca6w==
X-Gm-Message-State: AA+aEWZLw2fXtwYTjWKXAlqnV4A02S+F4S7nQBGhWiIlEk7JYWU8UFOJ
        LYMW40pYKZI2K5dFxD3d7J0=
X-Google-Smtp-Source: AFSGD/W8i7WD/vH7NC7Om15mIugkW8yFu5mjsv4FOdN9knm95LHCdkptD6kbfsnuBvvhXAc2IDKUHw==
X-Received: by 2002:aa7:85d7:: with SMTP id z23mr15230116pfn.205.1543817512446;
        Sun, 02 Dec 2018 22:11:52 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id u78sm27362769pfi.2.2018.12.02.22.11.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 22:11:51 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:11:48 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v4 7/7] zram: writeback throttle
Message-ID: <20181203061148.GF427@jagdpanzerIV>
References: <20181203024045.153534-1-minchan@kernel.org>
 <20181203024045.153534-8-minchan@kernel.org>
 <20181203055026.GD427@jagdpanzerIV>
 <20181203060208.GE427@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203060208.GE427@jagdpanzerIV>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 15:02), Sergey Senozhatsky wrote:
> Seems like I misread writeback_limit_store() a bit.
> 
> So, if I want to, say, let only 10M of writteback pages, I need to
> do
> 
> 	echo 0 > writeback_limit
> 	echo 10M > writeback_limit_store	// memparse format is for
> 						// simplicity only; I know
> 						// it should be in 4K units.
> 
> every day. How about dropping the "echo 0" and ->stop_writeback?

Ah, this breaks the unlimited writeback.
So, nevermind my comment.

	-ss
