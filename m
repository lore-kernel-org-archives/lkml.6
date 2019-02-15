Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772B8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 446F7222BE
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="fZseEO4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387757AbfBOQpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:45:06 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37591 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:45:05 -0500
Received: by mail-pl1-f193.google.com with SMTP id b5so5215491plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GlcAYyM/2jGYpX6aQY2k6R5tVa9zpBHyUpBMpoyBMCY=;
        b=fZseEO4vcW+pOEP8hrMO0f6izVOXgcKlJuEFUm86GXCVRAGbvTMG8jhEvkH3M9qszI
         mnIr08a9Jq5vDYDon/r/fTGMHXvU6jPFBdfvC4g1ry3stIiuH/lg5Q67JteW0u8aVlOG
         zZoItI7O+idOIqx3jFcuBwUWRu4KF1FB6zLi83um079SKqTRCtmT6J0tzd1lXbFUAuF4
         xc81SdFovBCa7JZfQ3Z2XdDrnH1jrnshy8i2HD6+tyIBmpmMOstEEdTZquSJ3HQXUcys
         ttCaPczFfmrxki3Op8j6U5YAMkOUdlHaIEOZ2QqfN2kUpaMMuRVLqwatthJhzAsbIhO8
         Ialw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GlcAYyM/2jGYpX6aQY2k6R5tVa9zpBHyUpBMpoyBMCY=;
        b=cch0MGDGKP+pdD0+JyS8kZ8IdOpE8eloAI6vsZc59bTzn5O4SpcLHZlVryhOR0DJ5H
         HdkipEVQ2XY3vEZxbexKvAZ6FFVq1VKjp3jO9KFQ9c8tCcTWIG5NJVfHKzHQY0Wqjjac
         RVAVLIkDgMWzJ9rbCvTsJri/IP7U+j0uvZLp0Sz9I5KmKRDUa3rMBRU45PU1CLAdu6Sy
         cnH3jXS09j/upAAb0JoG5EAfVoerUgYpkQFDozP0d/KlgqMtNi3+P2/U3d1YvYOBIuOo
         Ple17lNqidnUVkwhOsPbP1m+h64j3nsdhUtJMafNJhg5Fm+aGRLcZ02ygFCE7rCfb5YM
         2ZyA==
X-Gm-Message-State: AHQUAuYwpf9ePtkVEWBmlDKjQEzMF83QP6GSjO4ZLpUeF/JF1NiC6919
        55nSDX+KQEOXU7V+C9vvG7IqUw==
X-Google-Smtp-Source: AHgI3IZM4m4xfkSMi1+CZh/X5ZyIF/rbSP56uJ0E9ueaAn/H41q1y/OJYPEZAKV1Ec05QXT4fUvLVQ==
X-Received: by 2002:a17:902:758f:: with SMTP id j15mr10925304pll.170.1550249104942;
        Fri, 15 Feb 2019 08:45:04 -0800 (PST)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id m7sm13263710pfj.162.2019.02.15.08.45.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 08:45:04 -0800 (PST)
Date:   Fri, 15 Feb 2019 08:45:02 -0800
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vhost: correctly check the return value of
 translate_desc() in log_used()
Message-ID: <20190215084502.23feed0e@shemminger-XPS-13-9360>
In-Reply-To: <20190215075324.18891-1-jasowang@redhat.com>
References: <20190215075324.18891-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Feb 2019 15:53:24 +0800
Jason Wang <jasowang@redhat.com> wrote:

> When fail, translate_desc() returns negative value, otherwise the
> number of iovs. So we should fail when the return value is negative
> instead of a blindly check against zero.
> 
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Fixes: cc5e71075947 ("vhost: log dirty page correctly")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Looks good. It is best to put the Addresses-Coverity-Id tag on these kind
of bug fixes so that the automated tools see it.
