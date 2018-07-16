Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A346ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A37C20846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnGMeWZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A37C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbeGPVML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:12:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbeGPVML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:12:11 -0400
Received: from jouet.infradead.org (unknown [189.40.103.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6974020846;
        Mon, 16 Jul 2018 20:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531773785;
        bh=Txk2qN7ksDKw/DEFZLnqu/Rx2m2CVC7PjgY9P764KlI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnGMeWZj3VlUi/WgIDrDVgKuwORVcFsjyrkiCHhwUdDQyo/k+ky52HNsxASAZQc0g
         ja4GThGP4OPqtHmCErSKqT2+aB24L1nUdMckT3FCqPO6PfgDyJmoDR6oAHX6HDJo25
         +gdzC6LGe8CxvZsTH94eQ1+C4Ev6J/t2brd0PMY4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 9045A144881; Mon, 16 Jul 2018 16:43:01 -0400 (EDT)
Date:   Mon, 16 Jul 2018 16:43:01 -0400
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stefan Raspl <raspl@linux.ibm.com>
Cc:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] perf kvm: Fix subcommands on s390
Message-ID: <20180716204301.GB13669@kernel.org>
References: <20180712070936.67547-1-tmricht@linux.ibm.com>
 <de10696f-0fc3-4e34-d6dc-f9e669adc568@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de10696f-0fc3-4e34-d6dc-f9e669adc568@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 12, 2018 at 04:17:14PM +0200, Stefan Raspl escreveu:
> On 12.07.2018 09:09, Thomas Richter wrote:
> > With commit eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> > s390 platform provides detailed type/model/capacitiy information
> > in the CPU indentifier string instead of just "IBM/S390".

> > This breaks perf kvm support which uses hard coded string IBM/S390 to
> > compare with the CPU identifier string. Fix this by changing the comparison.

> > Fixes: eca0fa28cd0d ("perf record: Provide detailed information on s390 CPU")
> > Cc: Stefan Raspl <raspl@linux.ibm.com>
> > Cc: <stable@vger.kernel.org> # 4.17

> > Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> > Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
 
> Reported-and-tested-by: Stefan Raspl <raspl@linux.ibm.com>

Thanks, applied together with Christian's Acked-by,

- Arnaldo
