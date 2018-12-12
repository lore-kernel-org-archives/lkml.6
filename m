Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344DC04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E316E20870
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 14:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbJTseNB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeLLORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 09:17:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43345 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeLLORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 09:17:06 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so8660445plb.10;
        Wed, 12 Dec 2018 06:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zlJM3Dd9YWbtYLu4bbbt30UpPSlE+53bGUhlwu49DwE=;
        b=IbJTseNB/MEjn++xy830ljNzMQP9OeuM+pLHf3Fb4d3AmHQyElSAKg4oB/jcuNMsjJ
         440ESO39SHs+Jo8hNqjGKrF91oBASn9rLN+8GZe+vgElJsrgqDHRHVdwF9nrLM4RwQeb
         k8d4nkgmd6hBaQWudCoitlWyzLgSljwPKZgbqCSdCiPuZCtJ7gx9TaCIYFXhmALTFuYa
         S/mHdud8WBnj8bjG0caRWw1S9EcvcHbdQcpQc+tM6/kfjQ91njO1gtLNsljvH0ZMausa
         IPC43yHT8ZP+vb25QH/eov8UNuvWUV6ngtIdeOa6b7hymDh3Sr/8G0hyeUOFBRYOkHRo
         6uIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlJM3Dd9YWbtYLu4bbbt30UpPSlE+53bGUhlwu49DwE=;
        b=JBqRDXYSh+I/tlQ+Kh0dDrA0aJqQpVmTlYVF5PIEoa9TcKanNA1VCRnZHfN5wIvAf0
         G5cmQOxb37g3jaXF0yTDgFWR9uC1rbCK5rvqRHc4/WSphpK6ZlFI6mG1cPEG+sYhWQi7
         P62y5KUmXpDMj39/h/qb3JQqwJ1BT5qT2wGqnxWWusnVq9sVLSZkSoLurAk+qdP6nxHp
         wP7ExkoldnO6iy3VRPxnSyfWj9HjjJkD8io+SBUEx56qnalaP44Zwqcw93WN0NsGujQK
         PifH9laWh9Cg+vDRZljnMqR4oVdoHB5nq9+Qmp3agNwMTpf60AeFLydfOBYxGYx5O8vH
         fvUA==
X-Gm-Message-State: AA+aEWYiYfaE2dCKiHm3220YPDyYqkiOj2WCB/MbQvOlFmzBaEjRoTad
        I3uxxrI/1mOLPA8sFX7KAZU=
X-Google-Smtp-Source: AFSGD/WsgUu1xukSCkGcKn0XABzfoZbP6Pq3Ql0PGMPI1xgKRRS5ADKfpBAbIvHD+T3aEWl5IelOsQ==
X-Received: by 2002:a17:902:bb98:: with SMTP id m24mr19426077pls.71.1544624225660;
        Wed, 12 Dec 2018 06:17:05 -0800 (PST)
Received: from localhost (c-24-4-239-105.hsd1.ca.comcast.net. [24.4.239.105])
        by smtp.gmail.com with ESMTPSA id o13sm21535262pfk.57.2018.12.12.06.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Dec 2018 06:17:04 -0800 (PST)
Date:   Wed, 12 Dec 2018 06:17:02 -0800
From:   Richard Cochran <richardcochran@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        YueHaibing <yuehaibing@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] ptp: fix an IS_ERR() vs NULL check
Message-ID: <20181212141702.a23sehqcytipsmp5@localhost>
References: <20181206135719.GA18607@kroah.com>
 <20181207060046.GA3943@unbuntlaptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207060046.GA3943@unbuntlaptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 09:00:46AM +0300, Dan Carpenter wrote:
> We recently modified pps_register_source() to return error pointers
> instead of NULL but it seems like there was a merge issue and part of
> the commit was lost.  Anyway, the ptp_clock_register() function needs to
> be updated to check for IS_ERR() as well.
> 
> Fixes: 3b1ad360acad ("pps: using ERR_PTR instead of NULL while pps_register_source fails")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Greg,

This patch provides the missing hunk.  Please apply it.

Thanks,
Richard
