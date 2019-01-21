Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FD1C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD69A2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfAURmx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:42:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50094 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725908AbfAURmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:42:52 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0LHcl8b023244
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:42:51 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2q5ffph4wa-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 12:42:50 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 21 Jan 2019 17:42:48 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 21 Jan 2019 17:42:41 -0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x0LHgepq22085682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 17:42:40 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 752F852051;
        Mon, 21 Jan 2019 17:42:40 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.206.247])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id BDE415204E;
        Mon, 21 Jan 2019 17:42:37 +0000 (GMT)
Date:   Mon, 21 Jan 2019 19:42:35 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: kmemleak panic
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr>
 <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr>
 <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr>
 <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com>
 <20190121143704.GE29504@arrakis.emea.arm.com>
 <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19012117-0016-0000-0000-000002486B64
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19012117-0017-0000-0000-000032A29EA4
Message-Id: <20190121174234.GC26461@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-21_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901210138
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 09:42:07AM -0600, Rob Herring wrote:
> +Mike Rapoport
> 
> On Mon, Jan 21, 2019 at 8:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
> > On Mon, Jan 21, 2019 at 07:35:11AM -0600, Rob Herring wrote:
> > > On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > >
> > > > On 21/01/2019 11:57, Marc Gonzalez wrote:
> > > > [...]
> > > > > # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> > > > > kmemleak: Object 0xffffffc021e00000 (size 2097152):
> > > > > kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
> > > > > kmemleak:   min_count = 0
> > > > > kmemleak:   count = 0
> > > > > kmemleak:   flags = 0x1
> > > > > kmemleak:   checksum = 0
> > > > > kmemleak:   backtrace:
> > > > >       kmemleak_alloc_phys+0x48/0x60
> > > > >       memblock_alloc_range_nid+0x8c/0xa4
> > > > >       memblock_alloc_base_nid+0x4c/0x60
> > > > >       __memblock_alloc_base+0x3c/0x4c
> > > > >       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
> > > > >       fdt_init_reserved_mem+0x308/0x3ec
> > > > >       early_init_fdt_scan_reserved_mem+0x88/0xb0
> > > > >       arm64_memblock_init+0x1dc/0x254
> > > > >       setup_arch+0x1c8/0x4ec
> > > > >       start_kernel+0x84/0x44c
> > > > >       0xffffffffffffffff
> > > >
> > > > OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with
> > > > the linear map address of a no-map reservation, which unsurprisingly
> > > > turns out not to be mapped. Is there a way to tell kmemleak that it
> > > > can't scan within a particular object?
> > >
> > > There was this patch posted[1]. I never got a reply, so it hasn't been applied.
> > >
> > > https://patchwork.ozlabs.org/patch/995367/
> >
> > Thanks Rob, I wasn't aware of this patch (or I just missed it at the
> > time).
> >
> > I wonder whether kmemleak should simply remove ranges passed to
> > memblock_remove(), or at least mark them as no-scan.

I'm not sure that would be possible. Normal use of memblock_remove() is as
a counterpart of memblock_add() which does not involve kmemleak.
As memblock_remove() essentially hides range of the physical memory from
the system, it's not clear how it can communicate to kmemleak what region
should not be scanned.

> Seems reasonable to me, but of course that impacts a lot of other
> cases. Maybe Mike R has some thoughts?

If I understood correctly, the trouble comes from no-map range allocated in 
early_init_dt_alloc_reserved_memory_arch().

There's indeed imbalance, because memblock_alloc() does kmemleak_alloc(), but
memblock_remove() does not do kmemleak_free().

I think the best way is to replace __memblock_alloc_base() with
memblock_find_in_range(), e.g something like:


diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 1977ee0adcb1..6807a1cffe55 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -37,21 +37,16 @@ int __init __weak early_init_dt_alloc_reserved_memory_arch(phys_addr_t size,
 	 */
 	end = !end ? MEMBLOCK_ALLOC_ANYWHERE : end;
 	align = !align ? SMP_CACHE_BYTES : align;
-	base = __memblock_alloc_base(size, align, end);
+	base = memblock_find_in_range(size, align, start, end);
 	if (!base)
 		return -ENOMEM;
 
-	/*
-	 * Check if the allocated region fits in to start..end window
-	 */
-	if (base < start) {
-		memblock_free(base, size);
-		return -ENOMEM;
-	}
-
 	*res_base = base;
 	if (nomap)
 		return memblock_remove(base, size);
+	else
+		return memblock_reserve(base, size);
+
 	return 0;
 }
 
 
> Rob
> 

-- 
Sincerely yours,
Mike.

