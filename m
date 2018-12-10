Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AF32C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 554C520870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dVZ36y/g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 554C520870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbeLJNaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:30:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40335 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726677AbeLJNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:30:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id i12so5402262pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 05:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UEzgNUwLeUmIEpaQ9HgbdAQy0SRYJoY/YF6p/eudB9c=;
        b=dVZ36y/gbLeNYmfUxZpkiVRxyGqZYimf3/xvz2CDDiVP4arst9L4o2ZjQvx9QOPpHV
         IKfvgRYZHPPVxkVHX5B2D3ictWLgvMhu4TFNWYY+SyuZ34rIDMslxbnuSEQoXFkydiFh
         cQ9nDthCnbHcfn+upFQjVu6wrPCTXdCDmNFjZN3ANhWaodA+/fvI14+qN7rH3Q1VJxiX
         GJpK4/tz7aQhiTX9qUenrgs53rONwClt9RaeCEpyR1CnwaXHj0dPEtnteVSfn2JiQWAq
         yWnsugXEx1Khrne0rZRMP9zvstgp3zsJJ/6FPfmj51c6eO7QVMiGhkLyONwjrJcjrGRA
         g3kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UEzgNUwLeUmIEpaQ9HgbdAQy0SRYJoY/YF6p/eudB9c=;
        b=G+SuPatgiBGEzzBYvFjyCzJb96/ozoisUMfkQL/fH7FVMxXJyPoBajDYS5e/kWu/Dc
         atQmXqNjOCshz8kRnznGRgenVNsnADITGYw45KnowUCUrA/NdsMLVkLuXXUops7AAZRS
         +A1bVMHnj7ivjIA4Sr4A0RA8rYAe/rhifeDbn5xtHAkczecNFbpQyQexBVBL8/B24cli
         WrDAbYtWh5p0P8GA2zLpgjQAn7YyP0YOwGHaTArNYVoZc/G4lFmwmtupFQm9nkvy00Qb
         0VOmxXHdcd9TCEdGa9ExcL+KxaGMMd5LPlS7QIM8b3c5yZbYiCLwszewEPtaR9bMP1tF
         Sibw==
X-Gm-Message-State: AA+aEWZfQIil594j7bfSBnxpn+1pYEN/9myR+Q9SzDxHrbklMJRUgYpl
        5gacgLGevGbkTMqTxMcbTtLpkw==
X-Google-Smtp-Source: AFSGD/XO5Ky6sdTqltyWvkL6OQCanGZWtZYt13xWOnm2QHEw51OQdWH1GxJQCZ3e7HWU0HzMQgI6Kw==
X-Received: by 2002:a63:2507:: with SMTP id l7mr10469666pgl.22.1544448623767;
        Mon, 10 Dec 2018 05:30:23 -0800 (PST)
Received: from kshutemo-mobl1.localdomain ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id g70sm22549194pfg.98.2018.12.10.05.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 05:30:22 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
        id 77CCA30155D; Mon, 10 Dec 2018 16:30:18 +0300 (+03)
Date:   Mon, 10 Dec 2018 16:30:18 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     shuah@kernel.org, linux-kselftest@vger.kernel.org,
        keith.busch@intel.com, Kirill Shutemov <kirill.shutemov@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/vm/gup_benchmark.c: match gup struct to kernel
Message-ID: <20181210133018.hfvjodnsagkdsiwj@kshutemo-mobl1>
References: <20181208020645.GA28467@alison-desk.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181208020645.GA28467@alison-desk.jf.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 06:06:45PM -0800, Alison Schofield wrote:
> An expansion field was added to the kernel copy of this structure for
> future use. See mm/gup_benchmark.c.
> 
> Add the same expansion field here, so that the IOCTL command decodes
> correctly. Otherwise, it fails with EINVAL.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
