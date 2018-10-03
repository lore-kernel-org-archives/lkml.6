Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8F6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F43E2082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F43E2082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727283AbeJCWVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:21:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39488 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCWVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:21:06 -0400
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so1738447pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bf4Isbe0S9sn/7/INd2S2M90upmaer01n6Jsa9bLQZQ=;
        b=RMRLawBSxwxfFhbQ77/iZXr+8O5dnZaVPJDqMe24W4t1aJNB8n5BlflmqLQO3nPHNr
         rd6T/LlQ/7Dp1L9icXq+1r3XFSm1I7l9NUjdxQVHXKx8YmtjrOjY9y70pE84CP+Hszec
         CTZ9mASqISDh0dsnBBG01NLPRrvWACnVB38IuDrgoFu743ARUc4HDMfcoOXmpMp8+/a6
         P3sh87yZc/mrM7IWoJCdbhWFREDMwoqFEPH7slVaTd4F4dHmQONYyfATe2LZjGQWBG4I
         eul60wN53X0/lDv/hE4UrXJehFhCPRJp2HImsgDOUcN5yF4uUtHK5xqGaOmlGKO7t+tc
         r3rQ==
X-Gm-Message-State: ABuFfoi7UZmXtzFIfG+LuZL1/uTj7UYN7NM0y8YkVmfS4DKbNIMqRuk7
        0COOre7M01nhf2wEtPurTrM=
X-Google-Smtp-Source: ACcGV60geIK4MxhWQvkscuuODGcuWiY9r/9aO5VYK46eyGUUXciswLFQrvtQomyzQnnqxdw24iiNCw==
X-Received: by 2002:a63:f711:: with SMTP id x17-v6mr1864428pgh.322.1538580733579;
        Wed, 03 Oct 2018 08:32:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id w2-v6sm2899407pfk.140.2018.10.03.08.32.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:32:12 -0700 (PDT)
Message-ID: <1538580731.205649.11.camel@acm.org>
Subject: Re: [PATCH 5/6] lib/scatterlist: Use appropriate type for elem_len
 in sgl_alloc_order
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:32:11 -0700
In-Reply-To: <20180926141625.17727-6-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-6-tvrtko.ursulin@linux.intel.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 15:16 +-0100, Tvrtko Ursulin wrote:
+AD4 From: Tvrtko Ursulin +ADw-tvrtko.ursulin+AEA-intel.com+AD4
+AD4 
+AD4 We should not use an explicit width u32 for elem+AF8-len but unsinged int to
+AD4 match the underlying type in struct scatterlist.

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

