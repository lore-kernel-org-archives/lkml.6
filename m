Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CFFC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF49F20846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JlJWlRuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF49F20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeGZOIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 10:08:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729385AbeGZOIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 10:08:16 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364AB2083F;
        Thu, 26 Jul 2018 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532609493;
        bh=OLRtIvgaZq21sjUhqZXGc0kWhcEiSwZHC6xfaNkl+qo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JlJWlRuTn8qG88+BffE4agPds5eLfqVeQDUEHh6Q2TN3mzadHtIDMPq3cBgM8+nGi
         CAdmz3Hqgh/MGxVrYiSufFK2VgZH2d1YPmqCja/SpaMB6aGaEccb42Ic0TnKC1jXUo
         5FoTaFfW0sycq31zwgofLngyomKnfiNco4KxDUtk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id D902A1403B8; Thu, 26 Jul 2018 09:51:30 -0300 (-03)
Date:   Thu, 26 Jul 2018 09:51:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, sunil.k.pandey@intel.com
Subject: Re: [PATCH] perf evlist: Fix error out while applying initial delay
 and LBR
Message-ID: <20180726125130.GB17940@kernel.org>
References: <1531145722-16404-1-git-send-email-kan.liang@linux.intel.com>
 <20180709152054.GA11886@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709152054.GA11886@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 09, 2018 at 05:20:54PM +0200, Jiri Olsa escreveu:
> On Mon, Jul 09, 2018 at 07:15:22AM -0700, kan.liang@linux.intel.com wrote:
> > After applying the patch:
> >   perf record -D 1000 -a -e cycles -j any -- sleep 2
> >   [ perf record: Woken up 1 times to write data ]
> >   [ perf record: Captured and wrote 1.054 MB perf.data (828 samples) ]
> > 
> > Reported-by: Pandey, Sunil K <sunil.k.pandey@intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied, tested.

- Arnaldo
