Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94A9ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F6221508
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Baaq+rhC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F6221508
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeISAkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728657AbeISAkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:40:08 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E007F214DD;
        Tue, 18 Sep 2018 19:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537297570;
        bh=Iz46breXf7cDmAYxWy6MWmnQqYfkQAYIkX9ypVMGUPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Baaq+rhCebGFXs/KTNwpPbY6W2FwxzDI0Wmezh89QjjVOziyBGuu0BKOn8iKxfx0d
         6MRfupxZjUjMJzkE4/Mf+vQkTmjOv4XPQBw2kcRyXqlHXYzqE9/MMo6oAZ3npJVbMl
         583cLQKQSNOXY3eqtJazRkCnuDrYyxJi685avL4g=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9E9EC140260; Tue, 18 Sep 2018 16:06:06 -0300 (-03)
Date:   Tue, 18 Sep 2018 16:06:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     jolsa@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, tmricht@linux.ibm.com, sandipan@linux.ibm.com,
        brueckner@linux.ibm.com, kim.phillips@arm.com,
        kstewart@linuxfoundation.org, tglx@linutronix.de,
        naveen.n.rao@linux.vnet.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf test: Add watchpoint test
Message-ID: <20180918190606.GB32227@kernel.org>
References: <20180912061229.22832-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912061229.22832-1-ravi.bangoria@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 12, 2018 at 11:42:29AM +0530, Ravi Bangoria escreveu:
> We don't have perf test available to test watchpoint functionality.
> Add simple set of tests:
>  - Read only watchpoint
>  - Write only watchpoint
>  - Read / Write watchpoint
>  - Runtime watchpoint modification

Thanks, applied.

- Arnaldo
