Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=3.0 tests=DKIM_SIGNED,FSL_HELO_FAKE,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D945C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B034205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 07:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGIUAZ3d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B034205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbeGXIpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 04:45:12 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33251 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388366AbeGXIpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 04:45:11 -0400
Received: by mail-wm0-f68.google.com with SMTP id r24-v6so4973101wmh.0;
        Tue, 24 Jul 2018 00:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pQjB4D5fGej8w0FoC9W/MSfWKWmsdN/WyeLY51Ep+rI=;
        b=RGIUAZ3d8Cz6a2bGTZvJlq89ct9oZsHYfUPAcDNtqR7b3ETfZK5LYu9LN0vilTsEnc
         5IxcQri4yPFt4UY5bD6v3e66iYtDngoO25rga2pikYr5xtDPBPxgp3g36QvdodS7OlvW
         g3aQBgVTqGSn5SQS2UaOaZJzAZjzza4rZLe2QmkDUJHFlHC43bUitDbpnAwD/wOA9XKV
         QJub3l4MUmU6oO8bPbR3VhFbaq+VVbWoX854D4GW5oABIcVFYoASF87afF65YQWxhb1M
         nVgjU5AFtzuFrHFzjY4fI4KaIU3y2bYCgIBKrdYYQRE43fJJNdnjVsQzDqlqVFFOcOw7
         OyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=pQjB4D5fGej8w0FoC9W/MSfWKWmsdN/WyeLY51Ep+rI=;
        b=lN1T6H44hc/25Mli0fG9+nYPloP73QXv+yhV72LGG2OdME2Mm5YAdh62uvtOOp/YNg
         L9WiaR+FW1HcuWgsYk4RTB2/Hm2QxfQkIl9Rmsrce/8uEepzQ17J1S8REQA3CNv6dKRz
         Jv5TS+nhvOumu4JXZpdP6Q+hKqvLvQxfmxA125ClyhSR9qvlmjkGZPtdOZiddhDvevLE
         GZciGbkj+PdTpVx+L+7OXXot+4H9mffIf/d+Q3fEZkPpgDv2YWM4ICNN5X0Xi87VrYZb
         tawBtTLVUzyaEKgpsSAwMwIypBhB5aejV4ntVkzfwJ25DFAPLbzJ7XPqKmkGPFBrwO8e
         S/Og==
X-Gm-Message-State: AOUpUlEDmOALx2q4KAKFUVnrGAMBJ39GRW8rJoPqCwncafIUUHynxr7j
        jgd+Mn5UMGgSMF3sARFX0oM=
X-Google-Smtp-Source: AAOMgpe69GSyrOhoVPNFcS/27XYiJxwgvCiArWVIaaO+i6Sec1tVk67xhj6HtAnuILL1axLhnB/tZg==
X-Received: by 2002:a7b:c086:: with SMTP id r6-v6mr1151497wmh.119.1532418002133;
        Tue, 24 Jul 2018 00:40:02 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id e141-v6sm1717517wmd.32.2018.07.24.00.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 00:40:01 -0700 (PDT)
Date:   Tue, 24 Jul 2018 09:39:58 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm@lists.01.org, Tony Luck <tony.luck@intel.com>,
        Jan Kara <jack@suse.cz>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable@vger.kernel.org, Souptick Joarder <jrdr.linux@gmail.com>,
        linux-mm@kvack.org,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Matthew Wilcox <willy@infradead.org>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-fsdevel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, linux-edac@vger.kernel.org
Subject: Re: [PATCH v6 00/13] mm: Teach memory_failure() about ZONE_DEVICE
 pages
Message-ID: <20180724073958.GB15984@gmail.com>
References: <153154376846.34503.15480221419473501643.stgit@dwillia2-desk3.amr.corp.intel.com>
 <b9602b1b-97d3-b9c1-cc85-5b73b67e2e03@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9602b1b-97d3-b9c1-cc85-5b73b67e2e03@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Dave Jiang <dave.jiang@intel.com> wrote:

> Ingo,
> Is it possible to ack the x86 bits in this patch series? I'm hoping to
> get this pulled through the libnvdimm tree for 4.19. Thanks!

With the minor typo fixed in the first patch, both patches are looking good to me:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Assuming that it gets properly tested, etc.

Thanks,

	Ingo
