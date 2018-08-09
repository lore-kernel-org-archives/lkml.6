Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469FBC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0090421C2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:14:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsBFpRFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0090421C2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732544AbeHIRjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:39:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731178AbeHIRjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:39:47 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDCE21C2B;
        Thu,  9 Aug 2018 15:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533827666;
        bh=KUAP5+bCTE5Jq4eXcwmfDTqscFN6gmWaq8tFOyRRSYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PsBFpRFihzLxlIq3dK3r6oBYhanKM+PScDIBd7ShS+RocyNKy0FEfR8A2XhNteG2E
         rTBu8qsby0wFqLhiOJCwFaVKZg0Zzbo3PiHA8CEBMie3pOlu5HGeY9yQeVqgZ/4RoD
         ozA1i56iE3aUsxxQsivjfeLWFUwbwFtGwEnrh/oI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 56CA3140A1C; Thu,  9 Aug 2018 12:14:22 -0300 (-03)
Date:   Thu, 9 Aug 2018 12:14:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Thomas-Mich Richter <tmricht@linux.ibm.com>
Cc:     mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com,
        schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
Subject: Re: [PATCH 2/3] perf report: Add raw report support for s390
 auxiliary trace
Message-ID: <20180809151422.GB5395@kernel.org>
References: <20180802074622.13641-1-tmricht@linux.ibm.com>
 <20180802074622.13641-3-tmricht@linux.ibm.com>
 <87r2j9bkax.fsf@concordia.ellerman.id.au>
 <eda2632e-7919-5ffd-5f68-821e77d216fa@linux.ibm.com>
 <20180808155328.GA9543@kernel.org>
 <20180808155921.GB9543@kernel.org>
 <20180808160843.GC9543@kernel.org>
 <20180808161451.GD9543@kernel.org>
 <20180808164214.GE9543@kernel.org>
 <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <252202b1-bc08-a035-8de1-91136016d021@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 09, 2018 at 06:35:58AM +0200, Thomas-Mich Richter escreveu:
> On 08/08/2018 06:42 PM, Arnaldo Carvalho de Melo wrote:
> > So for those I applied this, seems to pass the ones that were failing,
> > restarting tests...

> I just updated the perf/core branch, compiled it and all works fine.

Thanks for checking!
 
> Thanks for fixing these errors.

You're welcome,

- Arnaldo
