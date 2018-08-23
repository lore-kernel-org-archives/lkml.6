Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDCDC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39D4206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N3XMCEH5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B39D4206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbeHWSBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:01:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:53306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729381AbeHWSBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:01:39 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35BEE206B6;
        Thu, 23 Aug 2018 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535034703;
        bh=8Nyz2Faf87T4nUFmg43/3OeqEhhaiiND6DbBdxyk1S8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N3XMCEH5iJOqvExA29mhgbU8mczDYPhIj53HAPNydEgmvThrCBuY44cJ5I7Vezqr2
         R4tCBAurgP6u20eXmjzX/twwcdotD287dHg6Mdwj2gpXVSQ5H31ZPRtslhCRYVLG3P
         PrIZDOQlQrTY8tXiqTckrxgb0ZD2Dt8+aMt68PhI=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7BBE8141C3F; Thu, 23 Aug 2018 11:31:41 -0300 (-03)
Date:   Thu, 23 Aug 2018 11:31:41 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>,
        William Cohen <wcohen@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Martin Jambor <mjambor@suse.cz>, Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] AMD perf PMU events for AMD Family 17h.
Message-ID: <20180823143141.GA22309@kernel.org>
References: <3ee15066-429e-b0f2-1255-aab100fad472@suse.cz>
 <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fc049074-595e-92d7-5bab-bcd00f8493e2@suse.cz>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 23, 2018 at 01:21:45PM +0200, Martin Liška escreveu:
> May I please ping this.

I was waiting for someone to give some ack, perhaps Will Cohen can take
a brief look and provide that? Will?

Thanks,

- Arnaldo
 
> Thanks,
> Martin
> 
> On 08/06/2018 10:42 AM, Martin Liška wrote:
> > Hello.
> > 
> > Following patch adds PMC events for AMD Family 17 CPUs as defined in [1].
> > It covers events described in section: 2.1.13. Regex pattern in mapfile.csv
> > covers all CPUs of the family.
> > 
> > Thanks,
> > Martin
> > 
> > [1] https://support.amd.com/TechDocs/54945_PPR_Family_17h_Models_00h-0Fh.pdf
> > 
> > Signed-off-by: Martin Liška <mliska@suse.cz>
> > 
> > ---
> >  .../pmu-events/arch/x86/amdfam17h/cache.json  | 332 ++++++++++++++++++
> >  .../pmu-events/arch/x86/amdfam17h/core.json   | 124 +++++++
> >  .../arch/x86/amdfam17h/floating-point.json    | 196 +++++++++++
> >  .../pmu-events/arch/x86/amdfam17h/memory.json | 225 ++++++++++++
> >  .../pmu-events/arch/x86/amdfam17h/other.json  |  51 +++
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
> >  6 files changed, 929 insertions(+)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/core.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/floating-point.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/amdfam17h/other.json
> > 
> > 
