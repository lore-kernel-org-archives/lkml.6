Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8AC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AEC820868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544115552;
	bh=ZgQZQ/O8+LHKKz2wuv6X/x3SqZLaxbhrXr+FrvSX/8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T0jRab5HJBuRk+3EaoIANo4X2iC99Us7VoZhXvO1HcNX9erE5J5eZc4MNLy7io77+
	 RWGU1qm28pdDvZC6DLu9hizhSrU7XAd0E6F1Tdchn5eTVNgV/cHAIBqlu9lTAqrJmp
	 QWZexvwRn7LW7hgWWpxNdJcbD6KJm/TSss3sXm9M=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AEC820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbeLFQ7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:56296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726051AbeLFQ7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:59:10 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8869E20838;
        Thu,  6 Dec 2018 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544115549;
        bh=ZgQZQ/O8+LHKKz2wuv6X/x3SqZLaxbhrXr+FrvSX/8E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HufhMuiwtBnqswbkZq14vEOz6MPtVT3uzDmi9YSfY3EaKf6mKHq+txyxTqCcn8S24
         oSHfHLKF6jAV71opUj67cH7gaRZnfH9MMPOPPOO/ADxenoWg94uD/Iw3g/7UzjxPWx
         KKldrJLd5FCEwvrpU7uRzyCiuN0vrs4U+UhXSiZs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C7FBF4042C; Thu,  6 Dec 2018 13:59:05 -0300 (-03)
Date:   Thu, 6 Dec 2018 13:59:05 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] perf vendor events intel: Fix Load_Miss_Real_Latency on
 SKL/SKX
Message-ID: <20181206165905.GI19069@kernel.org>
References: <20181120050635.4215-1-andi@firstfloor.org>
 <20181205102140.GC2950@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205102140.GC2950@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 05, 2018 at 11:21:40AM +0100, Jiri Olsa escreveu:
> On Mon, Nov 19, 2018 at 09:06:35PM -0800, Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Fix incorrect event names for the Load_Miss_Real_Latency metric for
> > Skylake and Skylake Server.
> > 
> > Fixes https://github.com/andikleen/pmu-tools/issues/158
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
