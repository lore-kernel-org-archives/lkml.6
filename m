Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDF3C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E7D20989
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="KXYY0U2y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E7D20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbeLFUvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:51:51 -0500
Received: from one.firstfloor.org ([193.170.194.197]:41910 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbeLFUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:51:50 -0500
Received: by one.firstfloor.org (Postfix, from userid 503)
        id 776D1868D9; Thu,  6 Dec 2018 21:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1544129508;
        bh=QFmw1gurW4bI8zCF93EL1eld1hObV8GLNIf5qD6OanM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KXYY0U2y5lh1YSJOF/fCBd5RRTooR9a3xQnHnouhBRIgQ3hnxWh7T+Dra/ei8tb3W
         K9be8KCR+eUtVJSR0oQr9z0FkN6uowwF+HOJVFkulIUXYXKmpAY376OjFcd+klJXjq
         L/0+PMu5EuMObb9Hu6Wso5ID3oC/ysJOXpkCVys4=
Date:   Thu, 6 Dec 2018 12:51:48 -0800
From:   Andi Kleen <andi@firstfloor.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Milian Wolff <milian.wolff@kdab.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf script: Fix LBR skid dump problems in brstackinsn
Message-ID: <20181206205146.hsiehbf6fyee2uec@two.firstfloor.org>
References: <20181120050617.4119-1-andi@firstfloor.org>
 <20181206170140.GJ19069@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206170140.GJ19069@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2018 at 02:01:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Nov 19, 2018 at 09:06:17PM -0800, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > This is a fix for another instance of the skid problem Milian
> > recently found [1]
> 
> Milian, have you tested this?

It won't fix Milians problem, which were with call graphs.

For Milian's issue you would need Milian's patches,
which AFAIK haven't been reviewed by anyone.

-Andi
