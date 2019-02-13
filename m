Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CAFC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA8B222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550046117;
	bh=ucpUIGLfvZudHfak4ac2wjOCoDPxELcKGWuGNLDkVV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2nAuJj+LowtAc7TehAyqLBxQUeGkI7aSF6he4LXG1dVj61HkOxsQn0bqJpsop0Jue
	 c9NcPMZ8icsOLAp2llygvJsiYzErRA1OtaT+UXbmR+aInsR8Cqts+5VG1ZPpH9jkBw
	 g4Pa/VyuuuRaFf7pWycYTmfsJ9GuW8TfFdECUUvE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390595AbfBMIVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:21:55 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37745 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387986AbfBMIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:21:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so1426350wrs.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OP1OccV571tuh3QSGB4f69ZRaeS/Vq+cIRqqhx3Knhw=;
        b=C+RTdKtVwJW4ufQjVmHZ5hACH3WjYlv8ZEJ3kGThVSgx+bQMCls+gLCCKQXGzW+GZH
         ZJF/FPkHLiwlNVx0MFxF/tpoZcHxcYxkJ+IsGEzZ1KSJlDvK37KIq28q4H0wlrTakH97
         /2gnj65LEO8975uU22MmlOlCKR9xgGsVtXIJKA0YxyjL9d8senBOPpvj671y0eZBVlOq
         1hsyE0CbDWhsnexGmiXGaqASJHph3Y+pdYSVEw9K3P9b+wKrsgkYQUW9IwU3UBeNqHFN
         AlCL1Zc2i9CZCG13tpaTv2K2+/jCNrwgk/6C0OBchboI5cOnUxVlAJTRMTANXhAYLEdP
         NGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OP1OccV571tuh3QSGB4f69ZRaeS/Vq+cIRqqhx3Knhw=;
        b=AAde9/KUBB45QDLx46PMfnAeD0tA+UuDmwT8JEUfgGwBltmbxbQDEPQL6ZJ6d1gnur
         EhOGAj4luuFNkm6QGrkGfBDv6sxTaSuSd2Df1VB3UvG/EU/8DnKkmrYQll230bFp32qU
         ejjnBN2JzVreRzKhYV2/baBE/Id0AKwOajHyW9n2UKEC2WB2q3Xc2t4tEng8Mw+t9Muw
         1DVKgUFOZAn1j+O7JGHA+8dZDQ2qQu7D1Dq+dPi+XRTehh787/9MxvAm5LbmjPeDgrNy
         z+C/isjJYpBDNmEE0qZSMJsG9GTi1ccDsWAIE2fKu6icLIIAlb8QSvWTSGaJJE4B2rj3
         1iYA==
X-Gm-Message-State: AHQUAuZl6L/ZrdRxffmzgKGob1bjovOdp4UjTsPxahz1lraulMoQNIBM
        etscgzg3xhfWzGF0LSFEKbA=
X-Google-Smtp-Source: AHgI3IYXEgkxWzm0pHd6UslqLXP0PacBc7qfraB4ipE7T2v2FPgavLd+ZmYzew/bsu1YYAVUVjXpPg==
X-Received: by 2002:adf:f4c8:: with SMTP id h8mr6458431wrp.6.1550046113810;
        Wed, 13 Feb 2019 00:21:53 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x18sm11372256wrw.61.2019.02.13.00.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 00:21:53 -0800 (PST)
Date:   Wed, 13 Feb 2019 09:21:50 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, catalin.marinas@arm.com, will.deacon@arm.com,
        james.morse@arm.com, hpa@zytor.com, valentin.schneider@arm.com
Subject: Re: [PATCH v3 3/4] uaccess: Check no rescheduling function is called
 in unsafe region
Message-ID: <20190213082150.GA57916@gmail.com>
References: <1547560709-56207-1-git-send-email-julien.thierry@arm.com>
 <1547560709-56207-4-git-send-email-julien.thierry@arm.com>
 <20190211134527.GA121589@gmail.com>
 <20190211135159.GC32511@hirez.programming.kicks-ass.net>
 <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23fdd84-8c4b-0c1f-d877-24d946cff6d0@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Julien Thierry <julien.thierry@arm.com> wrote:

> I guess I'll drop the might_resched() part of this patch if that sounds
> alright.

That sounds perfect - that bit was pretty much the only problem I had 
with the series.

Thanks,

	Ingo
