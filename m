Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 941F9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F65E208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sssD5hjw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F65E208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730944AbeIXWAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 18:00:15 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41661 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728280AbeIXWAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 18:00:15 -0400
Received: by mail-pl1-f195.google.com with SMTP id a7-v6so158629pla.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DX6rTJ0P0f3icnTttKpQ6SjAx2eqre7JFlPIUgZayKc=;
        b=sssD5hjwnq1zvW/a/ogAYpWbvPZeLNOZcosCEiuTEZskzN99+TH+FrkpLNbqMciihL
         lQXZm5UlmB8izlMdoZwafLsBJj+fHEiwbpFmWnvwp6wgtxETYt0uhWQRjkAGtbCovrU4
         RPnGbDwr2KwIjJlkhEpkUVtAwCKcHAXMFgf1B4lK5Nurq5VVli941K8z1IgHd/jGN6Wz
         OqmCcltHOzjvL1Ie+IgF7mhngA2Z1kCbfWEwbxENqnCB0YbEDpIEE5siHtWCNnyfjkiQ
         gnEW/mICKx2+T7Mqm9jVlbnyU2Kcq22YDzMxNfYNjsL5PpBqGMpqxz93P3ya0fD5h7t1
         2I1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DX6rTJ0P0f3icnTttKpQ6SjAx2eqre7JFlPIUgZayKc=;
        b=ck6pvz4Auxh1KEn8VHPS+PXJGNBAC4N8YSmg4moKL87Dl1CpwPE4v8bMujm+hoRAPB
         2XHSt5FF/1S2mNLEN6prSs6R+eXaTTpG/FO+y5CK5v3sg628AFUI/6iMfODYbsP7aey2
         3fOGLKvPc+BLo+nhGfKqY4uj/TXyWizTeOMxFekLBUQgavs2objywV50EKIzUAUMUzob
         +hI1lcBRJm//Y+5ByCzAg0dXGQHh6PRN7A3FBbAGUmI25+oGzIwUEjEv9h2JnKeBC1iu
         tQbxds0J1N4I4hWoSC3+f0VMRwycfC2ityhvu2OHLd00NW61OjXZGBr6Dd1a+YSqTEWf
         IdRg==
X-Gm-Message-State: ABuFfoj+vBSE14FTIR+YqqT9HoosAH+WBo/qECJJjOibym1aaoqbcHmX
        5Hw70hmZj2AEsPaoeFdV7HzPPv9uV9A=
X-Google-Smtp-Source: ACcGV61e1YqGUH1BUjpiLjlamTwG9qsILjeIHN76xXNTDA77AAsB14XBq81ZQ0eRDLmjR8ke3bdLkw==
X-Received: by 2002:a17:902:b7c3:: with SMTP id v3-v6mr10169526plz.182.1537804645322;
        Mon, 24 Sep 2018 08:57:25 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id p4-v6sm52332755pfd.65.2018.09.24.08.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 08:57:25 -0700 (PDT)
Date:   Mon, 24 Sep 2018 11:57:21 -0400
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        ross.zwisler@linux.intel.com
Subject: Re: [PATCH v5 07/11] filesystem-dax: Introduce
 dax_lock_mapping_entry()
Message-ID: <20180924115721.75893931@gnomeregan.cam.corp.google.com>
In-Reply-To: <153074046078.27838.5465590228767136915.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153074042316.27838.17319837331947007626.stgit@dwillia2-desk3.amr.corp.intel.com>
        <153074046078.27838.5465590228767136915.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan -

On 2018-07-04 at 14:41 Dan Williams <dan.j.williams@intel.com> wrote:
[snip]
> diff --git a/fs/dax.c b/fs/dax.c
> index 4de11ed463ce..57ec272038da 100644
> --- a/fs/dax.c
> +++ b/fs/dax.c
[snip]
> +bool dax_lock_mapping_entry(struct page *page)
> +{
> +	pgoff_t index;
> +	struct inode *inode;
> +	bool did_lock = false;
> +	void *entry = NULL, **slot;
> +	struct address_space *mapping;
> +
> +	rcu_read_lock();
> +	for (;;) {
> +		mapping = READ_ONCE(page->mapping);
> +
> +		if (!dax_mapping(mapping))
> +			break;
> +
> +		/*
> +		 * In the device-dax case there's no need to lock, a
> +		 * struct dev_pagemap pin is sufficient to keep the
> +		 * inode alive, and we assume we have dev_pagemap pin
> +		 * otherwise we would not have a valid pfn_to_page()
> +		 * translation.
> +		 */
> +		inode = mapping->host;
> +		if (S_ISCHR(inode->i_mode)) {
> +			did_lock = true;
> +			break;
> +		}
> +
> +		xa_lock_irq(&mapping->i_pages);
> +		if (mapping != page->mapping) {
> +			xa_unlock_irq(&mapping->i_pages);
> +			continue;
> +		}
> +		index = page->index;
> +
> +		entry = __get_unlocked_mapping_entry(mapping, index, &slot,
> +				entry_wait_revalidate);
> +		if (!entry) {
> +			xa_unlock_irq(&mapping->i_pages);
> +			break;
> +		} else if (IS_ERR(entry)) {
> +			WARN_ON_ONCE(PTR_ERR(entry) != -EAGAIN);
> +			continue;

In the IS_ERR case, do you need to xa_unlock the mapping?  It looks
like you'll deadlock the next time around the loop.

> +		}
> +		lock_slot(mapping, slot);
> +		did_lock = true;
> +		xa_unlock_irq(&mapping->i_pages);
> +		break;
> +	}
> +	rcu_read_unlock();
> +
> +	return did_lock;
> +}

