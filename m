Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 075A7C0044C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB84020827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 00:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB84020827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbeKFJzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 04:55:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36385 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbeKFJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 04:55:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id j22-v6so5256160pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 16:32:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=biljzU61Ceh7QjOjGSZnVU9x0gpA9weTl6OrYDuZk9s=;
        b=ohwf+FCc7YRXUvBsSHstnTiDD67NhbT9YUypYy2tOix6TDtPBa5O6xQ5CO/kGbIEJa
         i44fCmsT/wJkVYj5Gc9tOvEP0TKU68qC3vUSwPnVT0/hSFfiSQXG/qcFOe/7sMqtDe8q
         JnIIoYkH0HPs0ntlC54WGUKwRCTFkxhlfHWBg2IYxBTIIAC/gWtgPGWrSTEsC01G1JjC
         TTuIqBW8goqL/Y49fv5jh80udrJLwVDU56rJOU45lGyeMNRi5Dujt539iBv2tj2GPEy5
         SJD4g+SgRoAnlqOLjQOssL2l73ca6ioyrARyj2dFDyyJEQ69oiTXPDuI2z9G8FVBFuq/
         KFow==
X-Gm-Message-State: AGRZ1gK4MKrHAt/Uo/aD42igUM7apLm69kYf9QeoxQp29H/ygaqG5In+
        VqO06Eow12KboIEIF047YfE=
X-Google-Smtp-Source: AJdET5fxdSm+lHqSlsTSX4Mmj2EODQCT7yIQ9vda7MLif6+TKdfzgqLpa4K1zoYY2HruMH82OAGPTA==
X-Received: by 2002:a63:1412:: with SMTP id u18mr21460242pgl.247.1541464372634;
        Mon, 05 Nov 2018 16:32:52 -0800 (PST)
Received: from ?IPv6:2620:15c:2cd:203:5cdc:422c:7b28:ebb5? ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id b29-v6sm78606642pfj.183.2018.11.05.16.32.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 16:32:52 -0800 (PST)
Message-ID: <1541464370.196084.166.camel@acm.org>
Subject: Re: [PATCH] slab.h: Avoid using & for logical and of booleans
From:   Bart Van Assche <bvanassche@acm.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     linux@rasmusvillemoes.dk,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Christoph Lameter <cl@linux.com>, guro@fb.com,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-mm <linux-mm@kvack.org>
Date:   Mon, 05 Nov 2018 16:32:50 -0800
In-Reply-To: <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
References: <20181105204000.129023-1-bvanassche@acm.org>
         <20181105131305.574d85469f08a4b76592feb6@linux-foundation.org>
         <1541454489.196084.157.camel@acm.org>
         <ce6faf63-1661-abe5-16a6-8c19cc9f6689@rasmusvillemoes.dk>
         <1541457654.196084.159.camel@acm.org>
         <CAKgT0Udci4Ai4OD20NSRuDckE_G4RHma3Bg6H1Um6N9Se_zPew@mail.gmail.com>
         <1541462466.196084.163.camel@acm.org>
         <CAKgT0Ue59US_f-cZtoA=yVbFJ03ca5OMce2opUdQcsvgd8LWMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-11-05 at 16:11 -0800, Alexander Duyck wrote:
+AD4 If we really don't care then why even bother with the switch statement
+AD4 anyway? It seems like you could just do one ternary operator and be
+AD4 done with it. Basically all you need is:
+AD4 return (defined(CONFIG+AF8-ZONE+AF8-DMA) +ACYAJg (flags +ACY +AF8AXw-GFP+AF8-DMA)) ? KMALLOC+AF8-DMA :
+AD4         (flags +ACY +AF8AXw-GFP+AF8-RECLAIMABLE) ? KMALLOC+AF8-RECLAIM : 0+ADs
+AD4 
+AD4 Why bother with all the extra complexity of the switch statement?

I don't think that defined() can be used in a C expression. Hence the
IS+AF8-ENABLED() macro. If you fix that, leave out four superfluous parentheses,
test your patch, post that patch and cc me then I will add my Reviewed-by.

Bart.


