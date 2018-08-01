Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDC4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683E208A3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Fma8w0Ux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0683E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390002AbeHARp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:45:56 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:41934 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389643AbeHARp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:45:56 -0400
Received: by mail-qt0-f194.google.com with SMTP id e19-v6so20423517qtp.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 08:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GlRInNjBkUW+U4FuIA+QH8SrANhUCARDDcxz8bcr3Rg=;
        b=Fma8w0Uxqdu8wrbW/Vm9G3erSlDrEb0lgSgzp9WSgMTVKQzTtigTsN1F31KzOEPIcm
         DM+5shJxz0CNOlITcJSduE5mkZQTPuQWU9N2ikIliNh8r1ureq+sk3iia3tlWsPOFBAs
         K36pmEU35XtBPW99eXpCwIoP7cEBUborVPcYQCtl7ldJJSAUkjXPkOZ7ZUD+Ty7Vrd/6
         XiDYt0oDWB6vHaQd+tNVeRumNYERvkS+Ju9fu8T1BW7N08m45J2DX68e4XUuAldd1w2p
         oUTOqmGnV11kgOw5328Bg+7NIw6rib3NBoS0YNiGxZaS2/igPT+JaWtLQ3YT6ILcyz8l
         6afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GlRInNjBkUW+U4FuIA+QH8SrANhUCARDDcxz8bcr3Rg=;
        b=SMNPirtQ+YXYmZRthUEIa3GR/vmI61N7BGwec4iG4Jml1Mv99UBWNtngB92L85IxYl
         pHW9+hTw3DjUVResOYSSQBU20ak0ekt4U4dsquyRXYSbTSLTy99WUrHPcjloaRBIjy0G
         rRHhCbwc7ddGewbmeVoIpv6z/8BGWhUdt80LnRQaOo5ODbk0l3yK8eaVWYqem62FBHum
         XiYlHw9tFraB6qDvYaHgVJ1+gF7Co2YNcbOeNoUgA87jQ7hnkWuE9/Qz9yoCOIQ5/WwJ
         rIoWNuguzg8+7GESyg3dFN9wpoqXC9y0eG7cOTJmWDhrcnvLyy3xQHkXWa6G+T+JY3gX
         3/kA==
X-Gm-Message-State: AOUpUlFLhN6gcXM0IY8g8QAkRNNFicF3TjFyECptmiFYqQq1MHeoQNeB
        NI04rzozEMSzbr2hnIeG1nEzOA==
X-Google-Smtp-Source: AAOMgpdcVmcT6FQ8IvfktxcqKTMaFw2ktetPCrGmxLnx5SrrqfOpm4g5WOiV7jE84DqW3lA7tx8lrg==
X-Received: by 2002:ac8:3304:: with SMTP id t4-v6mr27086268qta.43.1533139173136;
        Wed, 01 Aug 2018 08:59:33 -0700 (PDT)
Received: from localhost (216.49.36.201.res-cmts.bus.ptd.net. [216.49.36.201])
        by smtp.gmail.com with ESMTPSA id h4-v6sm9625792qtp.53.2018.08.01.08.59.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 08:59:32 -0700 (PDT)
Date:   Wed, 1 Aug 2018 12:02:27 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: make iolatency avg_lat exponentially decay
Message-ID: <20180801160227.GA8891@cmpxchg.org>
References: <20180801002559.36261-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801002559.36261-1-dennisszhou@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:25:59PM -0700, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, avg_lat is calculated by accumulating the mean of every
> window in a long running cumulative average. As time goes on, the metric
> becomes less and less useful due to the accumulated history.
> 
> This patch reuses the same calculation done in load averages to make the
> avg_lat metric more lively. Unlike load averages, the avg only advances
> when a window elapses (due to an io). Idle periods extend the most
> recent window. Bucketing is used to limit the history of avg_lat by
> binding it to the window size. So, the window range for 1/exp (decay
> rate) is [1 min, 2.5 min) when windows elapse immediately.
> 
> The current sample window size is exposed in the debug info to enable
> calculation of the window range.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Looks great, thanks Dennis. Once the div build error is fixed, please
feel free to add:

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
