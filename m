Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CEC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59202086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uy4IYSli"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C59202086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbeIKSnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:43:31 -0400
Received: from mail-yb1-f195.google.com ([209.85.219.195]:46431 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbeIKSnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:43:31 -0400
Received: by mail-yb1-f195.google.com with SMTP id y20-v6so9324653ybi.13;
        Tue, 11 Sep 2018 06:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+69iNQJyiSH6+W28YFAFHNAmLxq7IOAWb8WAqi7VZp8=;
        b=uy4IYSliiy0hNiZD5FEm0HRWA8PfB/I5i+EQAgntbpEuEAlsTpHM+VPQejiqDO1KoZ
         8A3rg2QSSaRRQ1YGNhg+UA2cNa1wLGN6m3DQMEQgeqzwIbhD65xAfWiKddADK9savIDA
         +SU0hokF8uDemm7sV6eovFfBet6Wx1O4q2Mxq4Y3awOokzMY1vSeyLFadhPgNQUJx7b1
         VZxERBgGrYxlNeXF1tc0jJ2rGmXciU3pNemRB9uFW19TiqYaUPftYwIjcPvgnIHDpsTo
         03Mk15L7ackqr97objBmGo4xZniVXsL9FIrz3LsIY5iCSa0PkChMLFWjhrNZWCu72IEm
         tdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=+69iNQJyiSH6+W28YFAFHNAmLxq7IOAWb8WAqi7VZp8=;
        b=EEpdrmNeX1sUhFJFysu7Oq9EEmu/pFcGtPrqWvlvOJ4cI4NXT2ARZmmdq8rm9FrMCt
         J794bQcH4Nt46h9EoPqfvxlU7isvyztWZhpXs8UibzYJnV9lBp6kwwIVIKgz01yq+ETT
         o39vKSiVGDlS9RvpJNHsyUz174pVgaSuOLwUYEZq9mduNrG7vChu0+7+h0DurYk4HBDf
         0YJkIAgEsPgtbjtfg+JtX0ytjNKLOyWCKWVgW4h+5PA6IwmUPWwBwKx4VInO1sXTRb9/
         pqppwps2qgDqlaU1eCpvrBFttv/z5q2VNsSXcweVFpJHxoIcJ3pmLxhmMh64i5t9cJkP
         G10w==
X-Gm-Message-State: APzg51DvAYILssMbpf3VY4HVWWB16Led5xLbTCFJuSj7WTvRHl+fhB5P
        rEGUv+hHc1NpNshzoVi7zN8=
X-Google-Smtp-Source: ANB0VdaAGW8yQnpsxd0fsxJtJ1yne/KN+m/1FREPMXkAgvLcDtJEOZ22He8SajhvNkUe7wZbVPtIgg==
X-Received: by 2002:a25:6e04:: with SMTP id j4-v6mr12606461ybc.31.1536673447580;
        Tue, 11 Sep 2018 06:44:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::1:6304])
        by smtp.gmail.com with ESMTPSA id i190-v6sm7198977ywc.60.2018.09.11.06.44.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 06:44:06 -0700 (PDT)
Date:   Tue, 11 Sep 2018 06:44:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Ming Lei <ming.lei@redhat.com>, linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] percpu-refcount: relax limit on percpu_ref_reinit()
Message-ID: <20180911134404.GF1100574@devbig004.ftw2.facebook.com>
References: <20180909125824.9150-1-ming.lei@redhat.com>
 <d4fb5fcc-305e-b3a7-0124-9c7b75042f01@oracle.com>
 <20180910161135.GA27430@ming.t460p>
 <e91ee38e-3ea2-a003-2aac-8a8cc5c8f04a@oracle.com>
 <20180911040323.GC30977@ming.t460p>
 <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771fa1eb-85d3-2ff2-6070-207874da85b6@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Sep 11, 2018 at 12:40:36PM +0800, jianchao.wang wrote:
> (long)(sum (every cpu's refcounter)) + atomic refcounter
> 
> and when switch to atomic mode, there could be value left in atomic refcounter.
> then the unsigned long percpu refcounter cound be decreased from 0.

It can always do that.  Imagine a task getting a ref on one cpu,
migrating and putting it on another.  The only thing which matters is
that the sum of everything adds upto what it should be.

Thanks.

-- 
tejun
