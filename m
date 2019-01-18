Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FBBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF202087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 13:41:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="TLEc9M/d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727537AbfARNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 08:41:42 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35945 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfARNll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 08:41:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id u4so15118882wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LZqp/7AgmH73m5EL9rfJzVcjOT6ajbwFOtYRf1lXupE=;
        b=TLEc9M/diHF88vbfjdmgO+GUHKdU2Me4Y0zXs7HPcr4qBKcgYm5o0EKv6UzKZ9baqa
         8yqyhwNBzY28wGGLoLW3z+qurM7nCRUJTw9jedh6B02GG2/VJgwmw2LoGB7TAr595Qg/
         Upun5iKc1RTV2OE4GzKxaitQ3DwOzTW11g/9WxAgqZuN/LieAxv7mBUXwnucAbwOpZkd
         9wC5wz/E9o8CqyZlu3zOAr54oTaq/5k12jmNFDZFXX8NqJRmeqh5z5qvqNRkyqyq7K5u
         lAjdDuxPXKM/ssX36UPvLlswdDP+/S8Da6utgmhDT3PFX5imOXlLg7co1yKlV0X4ahL7
         s/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LZqp/7AgmH73m5EL9rfJzVcjOT6ajbwFOtYRf1lXupE=;
        b=ceZ1r3L9BDSINO6aortogweXZJDbda/DD3WV0rdbHXgQlzAmgEXKWPeMAT+ZsETTlX
         hbJvYd2+HLTdURUhB9lr4NJ7o5ilAtsvhgrxBbP0oWkCHjZmE+hW5GxOynwCXpEUakN3
         yw4pi7SZ9AkuCYv7qdbZYHnZ357POJKs4YcXE5/wD2W79MkVchyjsPhBVZYH5gxAI0BZ
         TP+nvgQbe1vpUpO/h+lVv4GlOc/GIA3GW15Ct/TNyA3jqxwI+d7PWFwAS68Y6cewLJGM
         eS9IVj2JpSdhst6w20QOBwGXr3DjU3X+qQyfRZwhn/VgRBVwxtAdz53bvON/N4FnKBio
         yyDg==
X-Gm-Message-State: AJcUukdpQWOFJpR7vdJNdYuZle6F9UP/jQ9ROlCFbMnGxK9LmFxM/hoC
        vwNKpoGXM7EtCirtdIrxjnvp5Q==
X-Google-Smtp-Source: ALg8bN4KRAiDvtErBTun5lxOMdTYnW7fTz0UDbh0scYQe/+YG4oA+eKJHnydeAjq3dQvVX7se9ZKXA==
X-Received: by 2002:a05:6000:1251:: with SMTP id j17mr16169399wrx.315.1547818899789;
        Fri, 18 Jan 2019 05:41:39 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id u204sm69552301wmu.30.2019.01.18.05.41.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 05:41:39 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:41:36 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: add dumping facility via debugfs
Message-ID: <20190118134136.GA1078@Red>
References: <1547646265-9414-1-git-send-email-clabbe@baylibre.com>
 <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f43688f-9c08-a9c4-6175-caa3d2e40261@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 06:10:13PM +0000, Robin Murphy wrote:
> On 16/01/2019 13:44, Corentin Labbe wrote:
> > While debugging a DMA mapping leak, I needed to access
> > debug_dma_dump_mappings() but easily from user space.
> > 
> > This patch adds a /sys/kernel/debug/dma-api/dump file which contain all
> > current DMA mapping.
> > 
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > ---
> >   kernel/dma/debug.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 47 insertions(+)
> > 
> > diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> > index 23cf5361bcf1..9253382f5729 100644
> > --- a/kernel/dma/debug.c
> > +++ b/kernel/dma/debug.c
> > @@ -144,6 +144,7 @@ static struct dentry *num_free_entries_dent __read_mostly;
> >   static struct dentry *min_free_entries_dent __read_mostly;
> >   static struct dentry *nr_total_entries_dent __read_mostly;
> >   static struct dentry *filter_dent           __read_mostly;
> > +static struct dentry *dump_dent             __read_mostly;
> >   
> >   /* per-driver filter related state */
> >   
> > @@ -840,6 +841,47 @@ static const struct file_operations filter_fops = {
> >   	.llseek = default_llseek,
> >   };
> >   
> > +static int dump_read(struct seq_file *seq, void *v)
> > +{
> > +	int idx;
> > +
> > +	for (idx = 0; idx < HASH_SIZE; idx++) {
> > +		struct hash_bucket *bucket = &dma_entry_hash[idx];
> > +		struct dma_debug_entry *entry;
> > +		unsigned long flags;
> > +
> > +		spin_lock_irqsave(&bucket->lock, flags);
> > +
> > +		list_for_each_entry(entry, &bucket->list, list) {
> > +			seq_printf(seq,
> > +				   "%s %s %s idx %d P=%llx N=%lx D=%llx L=%llx %s %s\n",
> > +				   dev_name(entry->dev),
> > +				   dev_driver_string(entry->dev),
> > +				   type2name[entry->type], idx,
> > +				   phys_addr(entry), entry->pfn,
> > +				   entry->dev_addr, entry->size,
> > +				   dir2name[entry->direction],
> > +				   maperr2str[entry->map_err_type]);
> > +		}
> > +
> > +		spin_unlock_irqrestore(&bucket->lock, flags);
> > +	}
> > +	return 0;
> > +}
> 
> It's a shame that this is pretty much a duplication of 
> debug_dma_dump_mappings(), but there seems no straightforward way to 
> define one in terms of the other :/
> 
> (although given that we'd rather not have that weird external interface 
> anyway, maybe "now you can use debugfs instead" might be justification 
> enough for cleaning it up...)
> 
> > +
> > +static int dump_open(struct inode *inode, struct file *file)
> > +{
> > +	return single_open(file, dump_read, inode->i_private);
> > +}
> > +
> > +static const struct file_operations dump_fops = {
> > +	.owner = THIS_MODULE,
> > +	.open = dump_open,
> > +	.read = seq_read,
> > +	.llseek = seq_lseek,
> > +	.release = single_release,
> > +};
> > +
> 
> DEFINE_SHOW_ATTRIBUTE()?
> 

I will use it

Thanks
