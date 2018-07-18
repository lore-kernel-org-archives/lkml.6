Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E67EECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E988C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="e4ME7xJ6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E988C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbeGRED1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:03:27 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36064 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725721AbeGRED0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:03:26 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so1369501plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 20:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z9rPg5loTYRmcudGyTlbBdX3Ff5Yu8jkM15opGehHRw=;
        b=e4ME7xJ6CcpAyAkSe7EItHvJjlIdhvgVfVosNwOwlrgwqCTEfnPyiU4LuPWr3K9aFQ
         Ipsepd1eSDnAQU9tRlRRPcV5AZzdgo+2Zk+bLuwI5CA83asr+GrZAL1zlDfVrjnr8Y22
         Hqije6ACnOu8ZqNoBXOnD5HbdaCizjAhn/Y0h5TRCWo2THCzmGy3x4wozFDpI2f/uEz6
         j2xT41poxYrtCIwjTGYhyErZy7yKQP7OfXIMjYHy2ANslubHCIBEoZDFjUqIasHjDQGx
         6CLutSn0o421RBU2vPzl9VUX4VIAFZh98P6j+yynGjdrO298srs2bQbjuoSk9CObaYzV
         LIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9rPg5loTYRmcudGyTlbBdX3Ff5Yu8jkM15opGehHRw=;
        b=QP8s5XJBW7bdTK8Wlx6e74s4JTh0QqLq1LpexADcXpCewhiFFQyhnIhUZev6TpShGT
         NdfDGxifXJkjWCEuDJsXijF1U/6zN6NOa87KohuAicNO0zSby4TJhzSlKzNTa/QnAT9m
         fBIsUDv2AkkOo9Skbkdl83X3Ib0tJAsuQ3aEtQcYSntgcJjTS7SQUMIItsSG69f0qPra
         zFXP6fErcbSUviqZhQzTh8OCnYHDnPXd86JxkLBFcaF9l8Geelspupt3PfYZMzUv9wYZ
         9brL1KMsaBkZvexrZSfm81zpJiPKbFPyNXAMFopj3Rknm+ktoqv5zsl6FOd4KsJ7+EC4
         2eAw==
X-Gm-Message-State: AOUpUlFtiQRkX/kgxjVnmjlWdpv/jcRQZ3DUoPriCZA8774sr5CsB+J/
        14AOzK51ukbItOmfAK4t9ZtlqA==
X-Google-Smtp-Source: AAOMgpcjn2unsRTTQ0k8lDXfar9p2MoezAJzPyBW4JxjCzE+172B6kARe5DyGEWEZVdxex4j1HyNIQ==
X-Received: by 2002:a17:902:8d98:: with SMTP id v24-v6mr4197589plo.250.1531884463761;
        Tue, 17 Jul 2018 20:27:43 -0700 (PDT)
Received: from vader ([2620:10d:c090:180::1:bc4f])
        by smtp.gmail.com with ESMTPSA id 86-v6sm4518508pfh.0.2018.07.17.20.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 20:27:43 -0700 (PDT)
Date:   Tue, 17 Jul 2018 20:27:42 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        James Morse <james.morse@arm.com>,
        Bhupesh Sharma <bhsharma@redhat.com>, kernel-team@fb.com
Subject: Re: [PATCH v2 7/7] proc/kcore: add vmcoreinfo note to /proc/kcore
Message-ID: <20180718032742.GC29351@vader>
References: <cover.1531440458.git.osandov@fb.com>
 <19c55add0fd15854798dde00d93350d76034896d.1531440458.git.osandov@fb.com>
 <20180717194421.a5430cf03aad12a9e40e65f4@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717194421.a5430cf03aad12a9e40e65f4@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 07:44:21PM -0700, Andrew Morton wrote:
> On Thu, 12 Jul 2018 17:09:39 -0700 Omar Sandoval <osandov@osandov.com> wrote:
> 
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > The vmcoreinfo information is useful for runtime debugging tools, not
> > just for crash dumps. A lot of this information can be determined by
> > other means, but this is much more convenient.
> > 
> 
> What effect does this have upon the overall size of the dump file?

About 2 kB on my machine, and no more than one page + the few bytes of
extra headers.
