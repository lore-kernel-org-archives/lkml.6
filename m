Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932453AbeCIRdd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:33:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:57316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932195AbeCIRdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:33:19 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54287205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Fri, 9 Mar 2018 14:33:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Will Deacon <will.deacon@arm.com>
Cc: Ganapatrao Kulkarni <gklkml16@gmail.com>,
        William Cohen <wcohen@redhat.com>, mark.rutland@arm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Robert Richter <Robert.Richter@cavium.com>,
        Ingo Molnar <mingo@redhat.com>, jnair@caviumnetworks.com,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] perf vendor events arm64: Enable JSON events for
 ThunderX2 B0
Message-ID: <20180309173316.GF8347@kernel.org>
References: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
 <3384d33f-c927-740a-97f1-b20775ef2c7b@redhat.com>
 <20180307143832.GJ3701@kernel.org>
 <CAKTKpr4zMcRLykw8xwWJKf2eiuCrf2RuJ7kexGRQNN7_OdJ=uQ@mail.gmail.com>
 <52328144-3a2a-af03-273b-3a2f3bdadda6@redhat.com>
 <CAKTKpr7HgsdZ90k0_evSq_aZW-uGSKwLndHOQ2Jahajj3Gkc0Q@mail.gmail.com>
 <CAKTKpr5=Doy2bQz8yYcoRNUGQ1HEgLcqk7U+4m-=1T_TZWa4HA@mail.gmail.com>
 <20180309143415.GB4194@kernel.org>
 <20180309155808.GP15537@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180309155808.GP15537@arm.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 09, 2018 at 03:58:09PM +0000, Will Deacon escreveu:
> On Fri, Mar 09, 2018 at 11:34:15AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 09, 2018 at 07:57:04PM +0530, Ganapatrao Kulkarni escreveu:
> > > Hi Arnaldo,
> > > 
> > > can you please pull-in this patch?
> > 
> > So everybody is Ok with this? Can I have some Acked-by: from subject
> > matter experts?
> 
> The original patch looks fine to me:
> 
> Acked-by: Will Deacon <will.deacon@arm.com>

Ok, so, as John mentioned in another message in his thread, this
conflicts with a series he sent and that Ganapatrao acked and I already
applied, I looked at it and think this patch should turn into the patch
at the end of this message, which I'm applying with the commit log
message in the original patch in this thread, Ack?

- Arnaldo

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index 8f11aeb003a9..624e8cae6e86 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,5 +13,5 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000410fd03[[:xdigit:]],v1,arm/cortex-a53,core
-0x00000000420f5160,v1,cavium/thunderx2,core
+0x00000000430f0af0,v1,cavium/thunderx2,core
 0x00000000480fd010,v1,hisilicon/hip08,core
