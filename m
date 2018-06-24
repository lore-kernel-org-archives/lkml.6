Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801A3C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B9D524DF9
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 07:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IKPqZhYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B9D524DF9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFXHNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 03:13:06 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34970 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeFXHND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 03:13:03 -0400
Received: by mail-wm0-f47.google.com with SMTP id z137-v6so923420wmc.0;
        Sun, 24 Jun 2018 00:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nUBbbDtQedpBYt1e5sBuZprsP1knv734b8Yp8wkHuy4=;
        b=IKPqZhYy7nUZmfxAGx7LR6mlvu14Mtay2/irAulCUxzxEbxwEnNzVvyDwRavL3/gqt
         9DnT7Bgb1BTB5Tsp/DriGeLnhEhyP/4Nzs8eSZzUdxW19q/Q3PIZRaBmsGZmcCTgpU4d
         eeh7+EdQuCr+BcbSeSoPF59p3juEu84IlOcmNJEvsl5tPtqg5IF/pUvH0yQkqrYw/VH5
         xV470MNR24MIwiP1/gyvRi6qvHUSZuBB4sebpxDuTFsqQkj0sYF/VUmltEZ/tu2LII5X
         rjkPmQDO+0ICZZeeWZGqUFC85lSHMulSOea03Q74FJ7lVLAm3c9/0mla2IpiW/o5nh4Z
         KFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nUBbbDtQedpBYt1e5sBuZprsP1knv734b8Yp8wkHuy4=;
        b=MWunH6gA5YhHX/gwfQqgUfWxRVe75GDlx+qDiJW39f9pZyhlqR9DZ0rMEhsE/+Bair
         AVD09UgrtogxW3OGKd4NpRq9yt4LfZwpKtLS/vxDyb+dl36/KxxqDXoreSejgnOthwl8
         ES17BR7gnhYgCDV3XZRVJ8MYRVVhid8euKJeQjfEg1szaKVh3yv6Cg2OQttma7c3a/V1
         AazYG40+VAD+xsdHrRRbN+oDJvXJBUk2Zja34aypinLIbAo+oFFfmGMiJr4z+OLxW/3L
         I4LlkkrvFGpEtnmom3SLHwHQ5qtCy2ZOGifpkh5fyDinBBGKL5xcT0QPgpWq38rmgmXC
         bfDQ==
X-Gm-Message-State: APt69E0ZFKqHA/Yz3X9wJbRXHCk0A7MQAARQjxz649KvNbYSdPV/fQK7
        CptDKECt4O7WLtEHeOkItTA=
X-Google-Smtp-Source: AAOMgpdDsgkX0nDOO/7nd9Y+cxggUSXt9sW0+ohxXN8UFRLq0kj4kZpU6LP2IvIoIrwWClrBwDtDeQ==
X-Received: by 2002:a1c:d602:: with SMTP id n2-v6mr3729889wmg.150.1529824381573;
        Sun, 24 Jun 2018 00:13:01 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id l15-v6sm14574805wrs.95.2018.06.24.00.13.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Jun 2018 00:13:00 -0700 (PDT)
Date:   Sun, 24 Jun 2018 09:12:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul Eggert <eggert@cs.ucla.edu>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-alpha@vger.kernel.org,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH v2 2/2] rusage: allow 64-bit times ru_utime/ru_stime
Message-ID: <20180624071258.GB29407@gmail.com>
References: <20180420120605.1612248-1-arnd@arndb.de>
 <20180420120605.1612248-2-arnd@arndb.de>
 <20180621154915.GA31947@gmail.com>
 <CAK8P3a1QYTfRNQt2+a29BpvgYM_pnSFrO=NBvVo=BdUa2q9ngQ@mail.gmail.com>
 <20180621161121.GB7222@gmail.com>
 <CAK8P3a1mx16S+DhEMQA6WBJ7efdhN5YaKKVHU6n+E6kfifM-Qg@mail.gmail.com>
 <20180622021636.GA11266@gmail.com>
 <87a7rm3eb5.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7rm3eb5.fsf@xmission.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Eric W. Biederman <ebiederm@xmission.com> wrote:

> The trouble with attributes is that means you can't filter your system
> call arguments with seccomp. [...]

There's nothing keeping seccomp from securely fetching those arguments and 
extending filtering to them as well ...

Allowing that would make sense for a lot of other system calls as well.

Thanks,

	Ingo
