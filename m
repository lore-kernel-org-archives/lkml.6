Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE0C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1064208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BC6JNqeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1064208A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755418AbeFRUdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:33:36 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:39298 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755323AbeFRUde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:33:34 -0400
Received: by mail-qk0-f178.google.com with SMTP id g14-v6so10170291qkm.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 13:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=46K9Ws7dchJn7xPMdJzBHtw76MjrBQOU1ErMdwT03Ws=;
        b=BC6JNqeMq/EVWFju0EoLuGwK55IF7eSjiMK6X5NB2jm9cu7eUxr+F7ZNl/JDPpqirW
         2CU9xkSZRK67EREAP0hJ8u8jxDBQcdfsHJsyJ3oeXffY1sHvL6kFYY8uGebtwNUHFJM0
         YQroQVsE6QQgdvbnYRiHurhATgMaFr6VwcLP9cntCAnvfe7rd3OqATgWAivRuBv2M9yP
         6rqf6NE1vIkvB3rddiuSru22UwGHe34kpOFh+cNDtE99PT7PJDRYHyReDxQC+1FY4t6u
         uJZIBxG6X5o5FR85/6OuJUfP1rISVHk35f027xon4iMhH4o3NnzCacjULfR08ZITD0Q3
         Y6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=46K9Ws7dchJn7xPMdJzBHtw76MjrBQOU1ErMdwT03Ws=;
        b=kUtuPHS1RauseZknookxbYz9fC/Q1iZpJdexs45OrR0QtN7kwzDwJvnxY3QqIGQICD
         2evmuUEhggNR1QKCDiHfioDbghX6aHiluzbLOCaLqzo7cHTrk1m0ySeOtRqYekBKwiD3
         x4JQVj22xrC81M46vMMk39msdqcFwMjypD8CXgAl+YQzvXCvqJFYRi+0PGfwyULOnAFX
         msmwEF5rFHT1wmo7rL6INwVxd7UTaP1rH+wcUmk6RAkMqhwNm57Jz4pmTQiTcKT5yJyy
         3PXlFZJFGX1hykN8Dcc7nkzxMkUwyx0BoWSpVma2iCOczEADrxBefdTjpnVJk3irOVCo
         xHXw==
X-Gm-Message-State: APt69E3X611FwCMIbdlT1ma2eYShsNbX9nMX5eif08HyUu/zTwyv5mcT
        h+bu3gIxHon3F0B1UDGtGrDDRg==
X-Google-Smtp-Source: ADUXVKJaq5tzNej9TEsBGJ4nIAak/cxVxZXzc8IsM9ThMqLvk3WGbJzRsr+GMp8ERhbpEIpDl9jVKA==
X-Received: by 2002:ae9:dcc3:: with SMTP id q186-v6mr11146047qkf.160.1529354013790;
        Mon, 18 Jun 2018 13:33:33 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id w46-v6sm13326310qtw.55.2018.06.18.13.33.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Jun 2018 13:33:33 -0700 (PDT)
Date:   Mon, 18 Jun 2018 13:33:30 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v3] bitfield: fix *_encode_bits()
Message-ID: <20180618133330.707f3efd@cakuba.netronome.com>
In-Reply-To: <1529353683.3092.32.camel@sipsolutions.net>
References: <20180618195618.17536-1-johannes@sipsolutions.net>
        <CAHp75VdY+PF0Edm_py+UiD3nz77HTQps_8uaRh+Sa3C+UKECKA@mail.gmail.com>
        <1529353683.3092.32.camel@sipsolutions.net>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Jun 2018 22:28:03 +0200, Johannes Berg wrote:
> > For me looks like for consistency we may add fake conversion macros
> > for this, such as
> > 
> > #define cpu_to_le8(x) x
> > #define le8_to_cpu(x) x
> > ...
> > #undef le8_to_cpu
> > #undef cpu_to_le8
> > 
> > And do in the same way like below
> > 
> > __MAKE_OP(8)  
> 
> I disagree with this. I don't see why we should have le8_encode_bits()
> and be8_encode_bits() and friends, that makes no sense.

+1
