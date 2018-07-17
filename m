Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5A7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D682084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gs/Fwvoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3D682084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbeGRHQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:16:00 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33718 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeGRHQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:16:00 -0400
Received: by mail-pl0-f66.google.com with SMTP id 6-v6so1602319plb.0;
        Tue, 17 Jul 2018 23:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L2s1zUWUUZ+NSpYrpWd5Nj7DdjKphButnHP+f74S17Y=;
        b=Gs/FwvoyLqM4L8drGER1VcW+W79jeEtxY+E5YBxJBcMtymlLumV7Pyr9BHG9TdW9vl
         mULJS0VaEDp5rnLyEczuC89877b3jdOgLn2lxIXafHWTx2vjP5pqmRQ4ZjAZ4ASkGJAx
         6UdaszdVaorqq3UxIyxiY3FQkRbD1ag2OGQ4OJRhB7IK8RJeqZjcZcDx9WlvBFHaiq98
         jXYtiLvoy00DpnjHX3p57C3BiMtdx0+FSN32CpM2ZplmRVPCvfHHjK8BZRVJZwhsIen7
         0r1kDN4wNo8RRM1qi63qsAKcxxmpCx8xCaTdlUvD5v9LRhxqYZv+9CVuzxdWSGzKeIUE
         EP4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L2s1zUWUUZ+NSpYrpWd5Nj7DdjKphButnHP+f74S17Y=;
        b=pGfwrWPZx8aK43BD+DWqxT0oD5S/GLgVTPHyJr+as8nnNpPgTlEALmgLz8tWUxQ3DI
         JvQjm488s3pRtvNxupy4CYW4avwJbsiYBd4Vx1z94dKdwhauIweYmyc1HtTP7QgIrfUY
         tw10qG5pmVOpIPbPpOCZ+R9H/is69mUxjaOoyQRu1VqtJssZoCUVnsDSic43BaxTD+ic
         9tEg4zmLxplXb+BuOe7jDUM+hL+y88lmWqtIJ3YZ1u04eN61jUEcXvlgeBRhHI+wW8IW
         tYA6d9NO8zYb8vbG5barpd8m7hywDG/B1qvn52IUvOpTcLgJdvIiyCJwUzLit4AdGLib
         2Z8A==
X-Gm-Message-State: AOUpUlF4t9lCYQBss9R7bI33DQZlFDglMqcRg9GhJCwEPseUNiE5oxsv
        G8RzIbCGTq8xNDVcZyU0XgDXQhH9
X-Google-Smtp-Source: AAOMgpcGbLQD9Dy/6VYCK4wrZt4Jp7dWtVxagLMcBlEmfNP8f25wXILlxylmj8UNoszGRO1nC4jG8w==
X-Received: by 2002:a17:902:2f84:: with SMTP id t4-v6mr4720221plb.24.1531895983301;
        Tue, 17 Jul 2018 23:39:43 -0700 (PDT)
Received: from raghu-VirtualBox ([116.197.184.10])
        by smtp.gmail.com with ESMTPSA id a11-v6sm7758014pfl.66.2018.07.17.23.39.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 23:39:42 -0700 (PDT)
Date:   Wed, 18 Jul 2018 02:42:57 +0530
From:   RAGHU H <raghuhack78@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] pktcdvd:checkpatch:Remove assignment if condition
Message-ID: <20180717211257.GA3339@raghu-VirtualBox>
References: <20180717170212.17197-1-raghuhack78@gmail.com>
 <96cc7712-bbc3-25fa-06ce-876bd8068f61@kernel.dk>
 <6c46fb77-93d4-a24a-a99e-07242a597b67@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c46fb77-93d4-a24a-a99e-07242a597b67@kernel.dk>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok Jens.

Raghu.

On Tue, Jul 17, 2018 at 04:17:00PM -0600, Jens Axboe wrote:
> On 7/17/18 4:14 PM, Jens Axboe wrote:
> > On 7/17/18 11:02 AM, RAGHU Halharvi wrote:
> >> * Remove checkpatch errors caused due to assignment operation in if
> >> condition
> > 
> > Applied all three patches, thanks.
> 
> I take that back, only patch #1 actually applies. Please resend the
> other two in a series, which apply to my for-4.19/block branch.
> 
> -- 
> Jens Axboe
> 
