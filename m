Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E533AC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC172087E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6UH504Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC172087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbeIJSmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728110AbeIJSmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:42:07 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409E620855;
        Mon, 10 Sep 2018 13:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536587276;
        bh=Gi0pFQgypqbllyGmarZ3jMF5DG2N1vKbts801agR/YI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d6UH504ZA0C/1Iaw91ly7/V2syXl4y3EWUsFutITAUGjts/WgTqUsx29Ig7CDHK90
         +EreVmfqICTfQuurRV1zhXLycmjNXGW2Ga3LjU3qWWWZsSceeFiNmzT4Aw1jElAKlX
         ErR8KEIyN4l48tAQMkVWB6wLRRYnLJ7Pt6Tf6yb0=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 14ACB141FFC; Mon, 10 Sep 2018 10:47:54 -0300 (-03)
Date:   Mon, 10 Sep 2018 10:47:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: Add watchpoint test
Message-ID: <20180910134754.GC5147@kernel.org>
References: <20180910095811.22892-1-ravi.bangoria@linux.ibm.com>
 <20180910103154.GD15548@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910103154.GD15548@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Sep 10, 2018 at 12:31:54PM +0200, Jiri Olsa escreveu:
> On Mon, Sep 10, 2018 at 03:28:11PM +0530, Ravi Bangoria wrote:
> > We don't have perf test available to test watchpoint functionality.
> > Add simple set of tests: 
> >  - Read only watchpoint
> >  - Write only watchpoint
> >  - Read / Write watchpoint
> >  - Runtime watchpoint modification
> > 
> > Ex on powerpc:
> >   $ sudo ./perf test 22
> >   22: Watchpoint                                            :
> >   22.1: Read Only Watchpoint                                : Ok
> >   22.2: Write Only Watchpoint                               : Ok
> >   22.3: Read / Write Watchpoint                             : Ok
> >   22.4: Modify Watchpoint                                   : Ok
> 
> cool, thanks!
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
