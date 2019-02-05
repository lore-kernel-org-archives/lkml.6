Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC04DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0CAE20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 01:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfBEBtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 20:49:11 -0500
Received: from p3plsmtpa12-06.prod.phx3.secureserver.net ([68.178.252.235]:57567
        "EHLO p3plsmtpa12-06.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725874AbfBEBtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 20:49:11 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 Feb 2019 20:49:11 EST
Received: from [192.168.0.55] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id qpkFgyHefs48lqpkFghzeQ; Mon, 04 Feb 2019 18:41:53 -0700
Subject: Re: [PATCH 0/6] RFC v2: mm: gup/dma tracking
To:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <dbca5400-b0c0-0958-c3ba-ff672f301799@talpey.com>
Date:   Mon, 4 Feb 2019 20:41:50 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190204052135.25784-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNUg+qMlTkf0uFRGudLlEZusZQUmU+jiO/UVEFdSjTu/T3lErFEFCWDThr6SzjAte4nUHQWYgQCvRtuxtmInO/ubP3oVFwfxFS84y4AOiYWScjutG1WO
 0XPn7TMPBcPLC6895u7rSttk7XkIKaZp9V+YvraWwjns7fqZ8BXOFhYC7Z/CtKX8HLZI/XylwSbn6rIqHYvXq5HlcUieBX9vT8qqD6drFP5/nSkIjuWDdIUf
 hYR0z1PSw5bHLEKrToMCDP4UX8fXgLOStbpsr4dHzCTMlSj24R8gUWrPgGjuAVwclp/oDha68rEqNL68tHY3KdELSSJvfAJ8/ew44ut5IxfUUidiLWQgwNAX
 Ty0fuHznLoH8GxEjwSWPe4Y9Y45ZHBNGOjjKqpw6+IfYIs2Nz0flwVdoFf3YlZ1rjZtwjx7uaz/SkiOreqQpj965AqF0J4vKk8FbbzvF6xOYcrk+foMgGEBz
 CEdvgw29NmgfN24yEV0DgfQ8lJwfsRtIff6J9H/fYdp3PZpBph/UT1hf6XNi/FO9hbVln90u8p5TGMHo2rDIzM6KBUDD2bHAszwMGPOwEZln8q7Jkj7a0FCH
 ZmT6ocEVqc/JhtWYOMT+38oWyZjYqwlRybdAVL96ejnuaybNiP8mJpyycwsxMz+XlDNr3OqVBtbo+OoLgYoC1BgozVTmUuhHnTKioJp2ZO4I2EgTvDMwRUgF
 tnxuNyyGyU0Zj2vwF6HqymGIDCYJUWvogr2XyV3HsC/vyAqXdHGlEBRoaTmTLG+FIiXXbCt3CXBT2AZCzoFdm02jSmjSfv5G6revOPlHLuy1+0Q2AgFDBeYL
 bX2bMpszPGOfscXcI2c=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/2019 12:21 AM, john.hubbard@gmail.com wrote:
> From: John Hubbard <jhubbard@nvidia.com>
> 
> 
> Performance: here is an fio run on an NVMe drive, using this for the fio
> configuration file:
> 
>      [reader]
>      direct=1
>      ioengine=libaio
>      blocksize=4096
>      size=1g
>      numjobs=1
>      rw=read
>      iodepth=64
> 
> reader: (g=0): rw=read, bs=(R) 4096B-4096B, (W) 4096B-4096B, (T) 4096B-4096B, ioengine=libaio, iodepth=64
> fio-3.3
> Starting 1 process
> Jobs: 1 (f=1)
> reader: (groupid=0, jobs=1): err= 0: pid=7011: Sun Feb  3 20:36:51 2019
>     read: IOPS=190k, BW=741MiB/s (778MB/s)(1024MiB/1381msec)
>      slat (nsec): min=2716, max=57255, avg=4048.14, stdev=1084.10
>      clat (usec): min=20, max=12485, avg=332.63, stdev=191.77
>       lat (usec): min=22, max=12498, avg=336.72, stdev=192.07
>      clat percentiles (usec):
>       |  1.00th=[  322],  5.00th=[  322], 10.00th=[  322], 20.00th=[  326],
>       | 30.00th=[  326], 40.00th=[  326], 50.00th=[  326], 60.00th=[  326],
>       | 70.00th=[  326], 80.00th=[  330], 90.00th=[  330], 95.00th=[  330],
>       | 99.00th=[  478], 99.50th=[  717], 99.90th=[ 1074], 99.95th=[ 1090],
>       | 99.99th=[12256]

These latencies are concerning. The best results we saw at the end of
November (previous approach) were MUCH flatter. These really start
spiking at three 9's, and are sky-high at four 9's. The "stdev" values
for clat and lat are about 10 times the previous. There's some kind
of serious queuing contention here, that wasn't there in November.

>     bw (  KiB/s): min=730152, max=776512, per=99.22%, avg=753332.00, stdev=32781.47, samples=2
>     iops        : min=182538, max=194128, avg=188333.00, stdev=8195.37, samples=2
>    lat (usec)   : 50=0.01%, 100=0.01%, 250=0.07%, 500=99.26%, 750=0.38%
>    lat (usec)   : 1000=0.02%
>    lat (msec)   : 2=0.24%, 20=0.02%
>    cpu          : usr=15.07%, sys=84.13%, ctx=10, majf=0, minf=74

System CPU 84% is roughly double the November results of 45%. Ouch.

Did you re-run the baseline on the new unpatched base kernel and can
we see the before/after?

Tom.

>    IO depths    : 1=0.1%, 2=0.1%, 4=0.1%, 8=0.1%, 16=0.1%, 32=0.1%, >=64=100.0%
>       submit    : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.0%, >=64=0.0%
>       complete  : 0=0.0%, 4=100.0%, 8=0.0%, 16=0.0%, 32=0.0%, 64=0.1%, >=64=0.0%
>       issued rwts: total=262144,0,0,0 short=0,0,0,0 dropped=0,0,0,0
>       latency   : target=0, window=0, percentile=100.00%, depth=64
> 
> Run status group 0 (all jobs):
>     READ: bw=741MiB/s (778MB/s), 741MiB/s-741MiB/s (778MB/s-778MB/s), io=1024MiB (1074MB), run=1381-1381msec
> 
> Disk stats (read/write):
>    nvme0n1: ios=216966/0, merge=0/0, ticks=6112/0, in_queue=704, util=91.34%
