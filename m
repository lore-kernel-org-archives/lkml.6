Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A56CC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5EA208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 15:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ia4R0Qai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B5EA208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeFUPBR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 11:01:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53742 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932747AbeFUPBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 11:01:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so5704697wmc.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W32Tac8kBunmACediBOBpW3R4QxLDp50Nkl5lmHyyqY=;
        b=ia4R0QailuZf42xUTj+m6lJRqC8jMOfWYqTTs1BjAkz9K5Q4Pu6cYsZeNqSH8Ckxfk
         k/2pl6Lnw5wv46Vq/7Y5zpwD9Wl8CIxFCF+tca8bUmOKMgfem1buuHVNadUNxUuxTjFO
         1DVRXF8PniK4NkpujZPP5XBImqzOpRTeNqmNZAitxN1fUg06EA/Jj2UFk5uuNIfi+17m
         t7u24vOLpVHCHKADtOxJAtR5fP1f7oUP75APZlKLVnDf7w4FhF2NlaPOZdcDsuEHgn9k
         MF8j2vv5NEanzPkg1GoeUf8oFampEg2eT22h/Rx0L+sg2HcZrFUd+VUeJEYLHUqiyUHB
         o+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=W32Tac8kBunmACediBOBpW3R4QxLDp50Nkl5lmHyyqY=;
        b=bLuQEdPwSHAViWlLXLQUZ4KWo6Hpk2OwWwbs9kS32SHoYP0H2Wee0dut8eqYxX1BZs
         VZ46k/vu6qcBH0FtREFwos19yjGXRDcssT5BEm4fdOIAFqt6Y020dI6tAvI/dCcMuq2t
         XXqsfqs9F246F4CV3VnHeBYZ8sojmu49eduV8yy0wXuPs1qt6V+eNVteNweSudzfIHjM
         X74Ut+DaZzaGsjmlJpeBvuq50yFBL890Pi2ghhK8dcoZn43KRIla8KQJ/nX9nWyFpMdy
         dFMjAfRPHahGHI0I3aXWXhams2nCNMeObVunjVyUGQFuRaZgSM8bhZjJvK/1IAnqHsu3
         aEkg==
X-Gm-Message-State: APt69E2wT9ThyYgsUaF2+h6Y1bT/mWvcDXt7PsYJEmeC1gEDUAmmJ7vb
        mMJcRl9QjQ+cx5xqvJNaWLKhyw==
X-Google-Smtp-Source: ADUXVKIdpCoPNFg6XqYqviffbTVkSh1FYClXqn5s5zjpWZGbZkRMg/ASXLPoIeHTQJwpXqMUr8bYFw==
X-Received: by 2002:a1c:ed0d:: with SMTP id l13-v6mr5685976wmh.73.1529593274826;
        Thu, 21 Jun 2018 08:01:14 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e13-v6sm7593380wrm.45.2018.06.21.08.01.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 08:01:13 -0700 (PDT)
Date:   Thu, 21 Jun 2018 17:01:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, lcapitulino@redhat.com,
        keescook@chromium.org, tglx@linutronix.de, x86@kernel.org,
        hpa@zytor.com, fanc.fnst@cn.fujitsu.com, yasu.isimatu@gmail.com,
        indou.takao@jp.fujitsu.com, douly.fnst@cn.fujitsu.com
Subject: Re: [PATCH 1/2] x86/boot/KASLR: Add two functions for 1GB huge pages
 handling
Message-ID: <20180621150111.GA23607@gmail.com>
References: <20180516100532.14083-1-bhe@redhat.com>
 <20180516100532.14083-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180516100532.14083-2-bhe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Baoquan He <bhe@redhat.com> wrote:

> +/* Store the number of 1GB huge pages which user specified.*/
> +static unsigned long max_gb_huge_pages;
> +
> +static int parse_gb_huge_pages(char *param, char* val)
> +{
> +	char *p;
> +	u64 mem_size;
> +	static bool gbpage_sz = false;
> +
> +	if (!strcmp(param, "hugepagesz")) {
> +		p = val;
> +		mem_size = memparse(p, &p);
> +		if (mem_size == PUD_SIZE) {
> +			if (gbpage_sz)
> +				warn("Repeadly set hugeTLB page size of 1G!\n");
> +			gbpage_sz = true;
> +		} else
> +			gbpage_sz = false;
> +	} else if (!strcmp(param, "hugepages") && gbpage_sz) {
> +		p = val;
> +		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> +		debug_putaddr(max_gb_huge_pages);
> +	}
> +}

This function has at least one style problem and one typo.

Also, we don't put statics in the middle of function variable blocks.

> +/* Skip as many 1GB huge pages as possible in the passed region. */
> +static void process_gb_huge_page(struct mem_vector *region, unsigned long image_size)
> +{
> +	int i = 0;
> +	unsigned long addr, size;
> +	struct mem_vector tmp;
> +
> +	if (!max_gb_huge_pages) {
> +		store_slot_info(region, image_size);
> +		return;
> +	}
> +
> +	addr = ALIGN(region->start, PUD_SIZE);
> +	/* If Did we raise the address above the passed in memory entry? */
> +	if (addr < region->start + region->size)
> +		size = region->size - (addr - region->start);
> +
> +	/* Check how many 1GB huge pages can be filtered out*/
> +	while (size > PUD_SIZE && max_gb_huge_pages) {
> +		size -= PUD_SIZE;
> +		max_gb_huge_pages--;
> +		i++;
> +	}
> +
> +	if (!i) {
> +		store_slot_info(region, image_size);
> +		return;
> +	}
> +
> +	/* Process the remaining regions after filtering out. */
> +
> +	if (addr >= region->start + image_size) {
> +		tmp.start = region->start;
> +		tmp.size = addr - region->start;
> +		store_slot_info(&tmp, image_size);
> +	}
> +
> +	size  = region->size - (addr - region->start) - i * PUD_SIZE;
> +        if (size >= image_size) {
> +		tmp.start = addr + i*PUD_SIZE;
> +		tmp.size = size;
> +		store_slot_info(&tmp, image_size);
> +        }
> +}

I counted about 5 style problems and at least one typo in this function ...

Please review the code you are submitting more carefully for small details as 
well.

Thanks,

	Ingo
