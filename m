Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754482AbeCGOii (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 09:38:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:39208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeCGOig (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 09:38:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FB02172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 11:38:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        peterz@infradead.org, mingo@redhat.com, john.garry@huawei.com,
        Will.Deacon@arm.com, mark.rutland@arm.com, jnair@caviumnetworks.com,
        Robert.Richter@cavium.com
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
Message-ID: <20180307143832.GJ3701@kernel.org>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 09:32:05AM -0500, William Cohen escreveu:
> On 03/07/2018 06:08 AM, Ganapatrao Kulkarni wrote:
> > There is MIDR change on ThunderX2 B0, adding an entry to mapfile
> > to enable JSON events for B0.
> > 
> > Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

Ganapatrao, can you please take this in consideration and if agreeing
send a v2 patch?

With that I can add an Acked-by: wcohen, Right?

- Arnaldo
> > ---
> >  tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > index e61c9ca..93c5d14 100644
> > --- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > +++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
> > @@ -13,4 +13,5 @@
> >  #
> >  #Family-model,Version,Filename,EventType
> >  0x00000000420f5160,v1,cavium,core
> > +0x00000000430f0af0,v1,cavium,core
> >  0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
> > 
> 
> Hi,
> Like the cortex-a53 the last digit '0' of the match for the MIDR should be replaced with [[:xdigit:]] to allow for possible future revisions of chip:
> 
> 0x00000000430f0af[[:xdigit:]],v1,cavium,core
> 
> 
> -Will Cohen
