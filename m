Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B03C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E97B621776
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 17:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dr2lkLKb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97B621776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754177AbeFURNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 13:13:42 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37941 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeFURNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 13:13:40 -0400
Received: by mail-pg0-f68.google.com with SMTP id c9-v6so1712934pgf.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yvbzFjvyhW7UymIIhxM+up7Jajg25lhz0OB5OQ4piBY=;
        b=Dr2lkLKbSBS/YBPtDUXYz0Ie8RAD7qIMrpJ8SpFTAYytU1sd0Yt8+Jhfj+RR2hGuwr
         /8znC293dm9aj4pOQaJj+V/wa3nYnDYlDwBNbfEKJ/b6EtUFCmAzb+8I96WQpCUlf88N
         y+5RsLR4s+quxovvbJQSyBYau/+H3ZEosxx8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yvbzFjvyhW7UymIIhxM+up7Jajg25lhz0OB5OQ4piBY=;
        b=oeykz6yBObDWcH3ocMiyGql575WMMvLbbZApN2I1ARdu+l3VPuxFemNtcALbXdxZZ1
         N8os7F9YeLjX1p/dB0+VKL94/ab6t5wlpPnXykuUk5E+vx61q4kjF+slB6mHVajYLuiD
         euhe1mijCbgfAbhgGeyL4yJimoLL/kcSQ4swP3nZMMpJU4DilPKbNzO8Irgci+gk2IP7
         wQyFWOamRe8ox8+5xm6O2Wi7xQkafZWcmSAP/Vjo5kTh6HlMjX5Ad0e5GFglKQI/0CXT
         DqTBwef3ZQu9tj2jT7DvUctc9h/EvB0EKyVY1HAZ57LzLeUWj00rj31Chz3+S1pLA3eP
         HmkQ==
X-Gm-Message-State: APt69E1nnzxjVqUv9ppPcEZr3uNfW2EvPar+sTi5uhyr3qMLEOZ7PNu4
        +sv5ptG9hhVp9ZROqD9efSGKMQ==
X-Google-Smtp-Source: ADUXVKKHrO0325ZuKCVP0tkbWQhxia/ma3DAJvkYv/GO/WvLPC93l/Bof8ZQmNKIHlI+8xBJDtTyTg==
X-Received: by 2002:a62:4e07:: with SMTP id c7-v6mr28460699pfb.149.1529601220118;
        Thu, 21 Jun 2018 10:13:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id s19-v6sm11656595pfe.97.2018.06.21.10.13.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 10:13:39 -0700 (PDT)
Date:   Thu, 21 Jun 2018 11:13:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] coresight: catu: Add support for scatter gather
 tables
Message-ID: <20180621171337.GA10307@xps15>
References: <1529319379-17895-1-git-send-email-suzuki.poulose@arm.com>
 <1529319379-17895-6-git-send-email-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529319379-17895-6-git-send-email-suzuki.poulose@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suzuki,

On Mon, Jun 18, 2018 at 11:56:18AM +0100, Suzuki K Poulose wrote:
> This patch adds the support for setting up a SG table for use
> by the CATU. We reuse the tmc_sg_table to represent the table/data
> pages, even though the table format is different.
> 
> Similar to ETR SG table, CATU uses a 4KB page size for data buffers
> as well as page tables. All table entries are 64bit wide and have
> the following format:
> 
>         63                      12      1  0
>         x-----------------------------------x
>         |        Address [63-12] | SBZ  | V |
>         x-----------------------------------x
> 
> 	Where [V] ->	 0 - Pointer is invalid
> 			 1 - Pointer is Valid
> 
> CATU uses only first half of the page for data page pointers.
> i.e, single table page will only have 256 page pointers, addressing
> upto 1MB of data. The second half of a table page contains only two
> pointers at the end of the page (i.e, pointers at index 510 and 511),
> which are used as links to the "Previous" and "Next" page tables
> respectively.
> 
> The first table page has an "Invalid" previous pointer and the
> next pointer entry points to the second page table if there is one.
> Similarly the last table page has an "Invalid" next pointer to
> indicate the end of the table chain.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c | 249 +++++++++++++++++++++++++++
>  1 file changed, 249 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index 11c84cb..95064c3 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -16,10 +16,259 @@
>  
>  #include "coresight-catu.h"
>  #include "coresight-priv.h"
> +#include "coresight-tmc.h"
>  
>  #define csdev_to_catu_drvdata(csdev)	\
>  	dev_get_drvdata(csdev->dev.parent)
>  
> +/* Verbose output for CATU table contents */
> +#ifdef CATU_DEBUG
> +#define catu_dbg(x, ...) dev_dbg(x, __VA_ARGS__)
> +#else
> +#define catu_dbg(x, ...) do {} while (0)
> +#endif
> +
> +/*
> + * CATU uses a page size of 4KB for page tables as well as data pages.
> + * Each 64bit entry in the table has the following format.
> + *
> + *	63			12	1  0
> + *	------------------------------------
> + *	|	 Address [63-12] | SBZ	| V|
> + *	------------------------------------
> + *
> + * Where bit[0] V indicates if the address is valid or not.
> + * Each 4K table pages have upto 256 data page pointers, taking upto 2K
> + * size. There are two Link pointers, pointing to the previous and next
> + * table pages respectively at the end of the 4K page. (i.e, entry 510
> + * and 511).
> + *  E.g, a table of two pages could look like :
> + *
> + *                 Table Page 0               Table Page 1
> + * SLADDR ===> x------------------x  x--> x-----------------x
> + * INADDR    ->|  Page 0      | V |  |    | Page 256    | V | <- INADDR+1M
> + *             |------------------|  |    |-----------------|
> + * INADDR+4K ->|  Page 1      | V |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |  Page 2      | V |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |   ...        | V |  |    |    ...          |
> + *             |------------------|  |    |-----------------|
> + * INADDR+1020K|  Page 255    | V |  |    |   Page 511  | V |
> + * SLADDR+2K==>|------------------|  |    |-----------------|
> + *             |  UNUSED      |   |  |    |                 |
> + *             |------------------|  |    |                 |
> + *             |  UNUSED      |   |  |    |                 |
> + *             |------------------|  |    |                 |
> + *             |    ...       |   |  |    |                 |
> + *             |------------------|  |    |-----------------|
> + *             |   IGNORED    | 0 |  |    | Table Page 0| 1 |
> + *             |------------------|  |    |-----------------|
> + *             |  Table Page 1| 1 |--x    | IGNORED     | 0 |
> + *             x------------------x       x-----------------x
> + * SLADDR+4K==>
> + *
> + * The base input address (used by the ETR, programmed in INADDR_{LO,HI})
> + * must be aligned to 1MB (the size addressable by a single page table).
> + * The CATU maps INADDR{LO:HI} to the first page in the table pointed
> + * to by SLADDR{LO:HI} and so on.
> + *
> + */
> +typedef u64 cate_t;
> +
> +#define CATU_PAGE_SHIFT		12
> +#define CATU_PAGE_SIZE		(1UL << CATU_PAGE_SHIFT)
> +#define CATU_PAGES_PER_SYSPAGE	(PAGE_SIZE / CATU_PAGE_SIZE)
> +
> +/* Page pointers are only allocated in the first 2K half */
> +#define CATU_PTRS_PER_PAGE	((CATU_PAGE_SIZE >> 1) / sizeof(cate_t))
> +#define CATU_PTRS_PER_SYSPAGE	(CATU_PAGES_PER_SYSPAGE * CATU_PTRS_PER_PAGE)
> +#define CATU_LINK_PREV		((CATU_PAGE_SIZE / sizeof(cate_t)) - 2)
> +#define CATU_LINK_NEXT		((CATU_PAGE_SIZE / sizeof(cate_t)) - 1)
> +
> +#define CATU_ADDR_SHIFT		12
> +#define CATU_ADDR_MASK		~(((cate_t)1 << CATU_ADDR_SHIFT) - 1)
> +#define CATU_ENTRY_VALID	((cate_t)0x1)
> +#define CATU_VALID_ENTRY(addr) \
> +	(((cate_t)(addr) & CATU_ADDR_MASK) | CATU_ENTRY_VALID)
> +#define CATU_ENTRY_ADDR(entry)	((cate_t)(entry) & ~((cate_t)CATU_ENTRY_VALID))
> +
> +/*
> + * catu_get_table : Retrieve the table pointers for the given @offset
> + * within the buffer. The buffer is wrapped around to a valid offset.
> + *
> + * Returns : The CPU virtual address for the beginning of the table
> + * containing the data page pointer for @offset. If @daddrp is not NULL,
> + * @daddrp points the DMA address of the beginning of the table.
> + */
> +static inline cate_t *catu_get_table(struct tmc_sg_table *catu_table,
> +				     unsigned long offset,
> +				     dma_addr_t *daddrp)
> +{
> +	unsigned long buf_size = tmc_sg_table_buf_size(catu_table);
> +	unsigned int table_nr, pg_idx, pg_offset;
> +	struct tmc_pages *table_pages = &catu_table->table_pages;
> +	void *ptr;
> +
> +	/* Make sure offset is within the range */
> +	offset %= buf_size;
> +
> +	/*
> +	 * Each table can address 1MB and a single kernel page can
> +	 * contain "CATU_PAGES_PER_SYSPAGE" CATU tables.
> +	 */
> +	table_nr = offset >> 20;
> +	/* Find the table page where the table_nr lies in */
> +	pg_idx = table_nr / CATU_PAGES_PER_SYSPAGE;
> +	pg_offset = (table_nr % CATU_PAGES_PER_SYSPAGE) * CATU_PAGE_SIZE;
> +	if (daddrp)
> +		*daddrp = table_pages->daddrs[pg_idx] + pg_offset;
> +	ptr = page_address(table_pages->pages[pg_idx]);
> +	return (cate_t *)((unsigned long)ptr + pg_offset);
> +}
> +
> +#ifdef CATU_DEBUG
> +static void catu_dump_table(struct tmc_sg_table *catu_table)
> +{
> +	int i;
> +	cate_t *table;
> +	unsigned long table_end, buf_size, offset = 0;
> +
> +	buf_size = tmc_sg_table_buf_size(catu_table);
> +	dev_dbg(catu_table->dev,
> +		"Dump table %p, tdaddr: %llx\n",
> +		catu_table, catu_table->table_daddr);
> +
> +	while (offset < buf_size) {
> +		table_end = offset + SZ_1M < buf_size ?
> +			    offset + SZ_1M : buf_size;
> +		table = catu_get_table(catu_table, offset, NULL);
> +		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
> +			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);
> +		dev_dbg(catu_table->dev, "Prev : %llx, Next: %llx\n",
> +			table[CATU_LINK_PREV], table[CATU_LINK_NEXT]);
> +		dev_dbg(catu_table->dev, "== End of sub-table ===");
> +	}
> +	dev_dbg(catu_table->dev, "== End of Table ===");
> +}
> +
> +#else
> +static inline void catu_dump_table(struct tmc_sg_table *catu_table)
> +{
> +}
> +#endif
> +
> +static inline cate_t catu_make_entry(dma_addr_t addr)
> +{
> +	return addr ? CATU_VALID_ENTRY(addr) : 0;
> +}
> +
> +/*
> + * catu_populate_table : Populate the given CATU table.
> + * The table is always populated as a circular table.
> + * i.e, the "prev" link of the "first" table points to the "last"
> + * table and the "next" link of the "last" table points to the
> + * "first" table. The buffer should be made linear by calling
> + * catu_set_table().
> + */
> +static void
> +catu_populate_table(struct tmc_sg_table *catu_table)
> +{
> +	int i, dpidx, s_dpidx;
> +	unsigned long offset, buf_size, last_offset;
> +	dma_addr_t data_daddr;
> +	dma_addr_t prev_taddr, next_taddr, cur_taddr;
> +	cate_t *table_ptr, *next_table;
> +
> +	buf_size = tmc_sg_table_buf_size(catu_table);
> +	dpidx = s_dpidx = 0;

From the reading the code below variable s_dpidx stands for "small" data page
index, which isn't obvious from the get go and could easily be mistaken for
"system" data page index.  Please add a comment to make your intentions clear.

> +	offset = 0;
> +
> +	table_ptr = catu_get_table(catu_table, 0, &cur_taddr);
> +	prev_taddr = 0;	/* Prev link for the first table */
> +
> +	while (offset < buf_size) {
> +		/*
> +		 * The @offset is always 1M aligned here and we have an
> +		 * empty table @table_ptr to fill. Each table can address
> +		 * upto 1MB data buffer. The last table may have fewer
> +		 * entries if the buffer size is not aligned.
> +		 */
> +		last_offset = (offset + SZ_1M) < buf_size ?
> +			      (offset + SZ_1M) : buf_size;
> +		for (i = 0; offset < last_offset;
> +		     i++, offset += CATU_PAGE_SIZE) {

I really like the choice of "table_end" in function catu_dump_table().  I think
using the same denomination here would make it easier to understand the code.

I wouldn't bother with such details if you weren't respinning this set.  But now
that you are and these are extremely simple I think it's worth it, and it will
help slowing the prolifiration of gray hair around my head when I look back at
this a year or two down the road.

Thanks,
Mathieu

> +
> +			data_daddr = catu_table->data_pages.daddrs[dpidx] +
> +				     s_dpidx * CATU_PAGE_SIZE;
> +			catu_dbg(catu_table->dev,
> +				"[table %5ld:%03d] 0x%llx\n",
> +				(offset >> 20), i, data_daddr);
> +			table_ptr[i] = catu_make_entry(data_daddr);
> +			/* Move the pointers for data pages */
> +			s_dpidx = (s_dpidx + 1) % CATU_PAGES_PER_SYSPAGE;
> +			if (s_dpidx == 0)
> +				dpidx++;
> +		}
> +
> +		/*
> +		 * If we have finished all the valid entries, fill the rest of
> +		 * the table (i.e, last table page) with invalid entries,
> +		 * to fail the lookups.
> +		 */
> +		if (offset == buf_size) {
> +			memset(&table_ptr[i], 0,
> +			       sizeof(cate_t) * (CATU_PTRS_PER_PAGE - i));
> +			next_taddr = 0;
> +		} else {
> +			next_table = catu_get_table(catu_table,
> +						    offset, &next_taddr);
> +		}
> +
> +		table_ptr[CATU_LINK_PREV] = catu_make_entry(prev_taddr);
> +		table_ptr[CATU_LINK_NEXT] = catu_make_entry(next_taddr);
> +
> +		catu_dbg(catu_table->dev,
> +			"[table%5ld]: Cur: 0x%llx Prev: 0x%llx, Next: 0x%llx\n",
> +			(offset >> 20) - 1,  cur_taddr, prev_taddr, next_taddr);
> +
> +		/* Update the prev/next addresses */
> +		if (next_taddr) {
> +			prev_taddr = cur_taddr;
> +			cur_taddr = next_taddr;
> +			table_ptr = next_table;
> +		}
> +	}
> +
> +	/* Sync the table for device */
> +	tmc_sg_table_sync_table(catu_table);
> +}
> +
> +static struct tmc_sg_table __maybe_unused *
> +catu_init_sg_table(struct device *catu_dev, int node,
> +		   ssize_t size, void **pages)
> +{
> +	int nr_tpages;
> +	struct tmc_sg_table *catu_table;
> +
> +	/*
> +	 * Each table can address upto 1MB and we can have
> +	 * CATU_PAGES_PER_SYSPAGE tables in a system page.
> +	 */
> +	nr_tpages = DIV_ROUND_UP(size, SZ_1M) / CATU_PAGES_PER_SYSPAGE;
> +	catu_table = tmc_alloc_sg_table(catu_dev, node, nr_tpages,
> +					size >> PAGE_SHIFT, pages);
> +	if (IS_ERR(catu_table))
> +		return catu_table;
> +
> +	catu_populate_table(catu_table);
> +	dev_dbg(catu_dev,
> +		"Setup table %p, size %ldKB, %d table pages\n",
> +		catu_table, (unsigned long)size >> 10,  nr_tpages);
> +	catu_dump_table(catu_table);
> +	return catu_table;
> +}
> +
>  coresight_simple_reg32(struct catu_drvdata, devid, CORESIGHT_DEVID);
>  coresight_simple_reg32(struct catu_drvdata, control, CATU_CONTROL);
>  coresight_simple_reg32(struct catu_drvdata, status, CATU_STATUS);
> -- 
> 2.7.4
> 
