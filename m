Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5384C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A67432171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 21:23:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="oqCrtSNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbfA1VXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:23:45 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:34271 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbfA1VXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 16:23:45 -0500
Received: by mail-yb1-f195.google.com with SMTP id k9so6810859ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 13:23:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=W3oY1xqZBvb5uVdN7aj7A+kp0VAxPGPd9sCt8NgdAbo=;
        b=oqCrtSNo/UoV97OKjZDNJhAd+dZJsc6m2M2jTE79zkINKeitFARxb4Btk8w5wssq7B
         h+qJkgT8Wh5LQornKlqF2y08DevoQTqEGNwy2CWiUjGkRrVvVJfmZ3SrSvhz4AAe9rjf
         xHaOrje31Y2ilUukiJ5d/tYwJbwtfrHeychlWKqsWF5VNa3L9VW5lrOIZJsq4uEhSfCf
         tn2PJXCMjbQDTaDl4HdcjgJG0wAEarpQG6+PSpy/edY/weTfjIP5hvaTy54lHvMxq8Xv
         VF45QjoZG8eyKX/PV5Tl70U01SXO5/FUtnaJFguMeHIHI4f/m63YIb3dKWV8O4AVFqwz
         02Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W3oY1xqZBvb5uVdN7aj7A+kp0VAxPGPd9sCt8NgdAbo=;
        b=cfHOK7HssUdAh64wQsXaMOnPKLkorwN7NpG4chtOd5L983fR4FCh4TQZ3OZWSjyHDC
         b38BDLAFmqcYTLs7BqQy5t63nuSAIh2nlRucoyM6qx3szFN8zt/DYGoRYGtTSVT5c+ps
         dQJ/obkPXP8MC8m8Ha1osSLYrcHn4STyqfqtPOq0yP2EmrwxTqLkXyjTFU4dtB/nQ2R1
         6xZXVMl01Pv9+ZCqsQ+sc8c5kB8A9uFJh8+dIc+CGTBhSE6vfrK/hoMHJ4cH7sd8GC35
         UnkI5zFsnkb4imhlu956ccUonqueVGlP+sAjTAIaDiZMVXjHvYOI1vhEMMtKDtxv/Car
         B23w==
X-Gm-Message-State: AHQUAuajmHBjILuN4Mp37JDWwE8Jtm2BRxjOxD1N8TSB+wa0dIuAVCZu
        K3AokPXOfTlU42lP1f6uY+EzSw==
X-Google-Smtp-Source: AHgI3IZB91CNTZqNmQFgMEMFhElan15kyh2hIe9x4vrRvLju7Mge2gp6Kdzg5HgJ6mvedeUDgo2Z/Q==
X-Received: by 2002:a25:7d05:: with SMTP id y5mr3034818ybc.439.1548710624260;
        Mon, 28 Jan 2019 13:23:44 -0800 (PST)
Received: from localhost ([199.201.65.134])
        by smtp.gmail.com with ESMTPSA id s185sm26041014yws.69.2019.01.28.13.23.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 13:23:43 -0800 (PST)
Date:   Mon, 28 Jan 2019 16:23:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     gregkh@linuxfoundation.org, tj@kernel.org, lizefan@huawei.com,
        axboe@kernel.dk, dennis@kernel.org, dennisszhou@gmail.com,
        mingo@redhat.com, peterz@infradead.org, akpm@linux-foundation.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 4/5] psi: rename psi fields in preparation for psi
 trigger addition
Message-ID: <20190128212342.GC1416@cmpxchg.org>
References: <20190124211518.244221-1-surenb@google.com>
 <20190124211518.244221-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124211518.244221-5-surenb@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:15:17PM -0800, Suren Baghdasaryan wrote:
> Renaming psi_group structure member fields used for calculating psi
> totals and averages for clear distinction between them and trigger-related
> fields that will be added next.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
