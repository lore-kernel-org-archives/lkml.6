Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19532C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5C92089F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 15:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5C92089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJCWRF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 18:17:05 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38755 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbeJCWRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 18:17:05 -0400
Received: by mail-pl1-f194.google.com with SMTP id b5-v6so3654068plr.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 08:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aQsNyq2/JoBL5hZc8TOXDgVsinwzDXWFszbxOnMbgMM=;
        b=Egj/Ec7pRPFuNAWnw4dJZbNGGSH0NsMSKv4sN3L4TuGVKi8MQZAPZP3voJGBnaW7hC
         VLTzxVpkr7XWnKxv2ODaUO9U4yX4FYpsDldf09oKejPbbRIl6qgZ1AbiWSj7JU6QUqvT
         kZCSyxmZN1sQOQmKA/qIDGnqZaKZ6VwSkb6iIcd8upyib4SMYmi1cr/9HIC6ZslOBdae
         FXbQAEDbCNbYWU+gVnejVvzcYIbbwW36LezKJa05+D9+bt2/hRgJmT2+ptt+LD01n2/e
         zcK4D6FmpdpAxl/z/C73M5RD5Scv7A7Sv1Z9YrKk/KJ3WzzEhbkySiMVXBJQ6Ho1noKJ
         Okog==
X-Gm-Message-State: ABuFfohhScVnFqeh5WXHmBVnNmO16IjHthd3p0QqRikg5+wFxPv+wiD3
        iDGCmLd/KjLZkbF6zSDFtlQ=
X-Google-Smtp-Source: ACcGV63HJOL+giybFrryKzl0PJsloHf925vG+lMfJR8RwmcD6yD7crwTHGA3XUXzGWbSsN87WEp7rA==
X-Received: by 2002:a17:902:40d:: with SMTP id 13-v6mr2165949ple.257.1538580493402;
        Wed, 03 Oct 2018 08:28:13 -0700 (PDT)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id a79-v6sm3079057pfa.124.2018.10.03.08.28.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Oct 2018 08:28:12 -0700 (PDT)
Message-ID: <1538580491.205649.6.camel@acm.org>
Subject: Re: [PATCH 2/6] lib/scatterlist: Use consistent types in sgl API
From:   Bart Van Assche <bvanassche@acm.org>
To:     Tvrtko Ursulin <tursulin@ursulin.net>, linux-kernel@vger.kernel.org
Cc:     tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Jens Axboe <axboe@kernel.dk>
Date:   Wed, 03 Oct 2018 08:28:11 -0700
In-Reply-To: <20180926141625.17727-3-tvrtko.ursulin@linux.intel.com>
References: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
         <20180926141625.17727-3-tvrtko.ursulin@linux.intel.com>
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
+AD4 There is an incosistency between data types used for order and number of
              +AF4AXgBeAF4AXgBeAF4AXgBeAF4AXgBe
              inconsistency?
+AD4 sg elements in the API.
+AD4 
+AD4 Fix it so both are always unsigned int which, in the case of number of
+AD4 elements, matches the underlying struct scatterlist.

Anyway,

Reviewed-by: Bart Van Assche +ADw-bvanassche+AEA-acm.org+AD4

