Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6DAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47871208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 14:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PXZDt2zS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47871208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732455AbeHWSZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 14:25:02 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55851 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731953AbeHWSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 14:25:01 -0400
Received: by mail-it0-f68.google.com with SMTP id d10-v6so7895724itj.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Aug 2018 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgw5dIlS32S9/R0w0dRJVxlBtH0R6iAPxAsrK2N3uiU=;
        b=PXZDt2zSar94mYy2mpRDouifUuewoqGpDSjkRpIxue2f9hq3kOT7xmUTeJuCzOyZtH
         CeVoFy5N4k6WpugTKUDlpWkakm+XQEo6Ey4STitOhWrc/6ZZcuu6US5DhTwgN3dQ9cF9
         PKThZOSZVZ2xYXmpADXaRG7a9vZBqjI9KlBjQ2w/nu8I8YUeGLJPVBfQjLNZZ4+BTj/j
         XVuc/Jq7cCMRZDFmWmwlqiJJOVXbTQ5V8HoOWz4hM4twl4c2xauGLsUxv5LgezJVqFZ8
         1A+HAlBRflGmTCBq0CLWMoNO19EPfg7RJNmNu3jYgfF/WafJPievDfd2Jqupwuo9Z2Bc
         Qc+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgw5dIlS32S9/R0w0dRJVxlBtH0R6iAPxAsrK2N3uiU=;
        b=MdxEHMM21XlKqlpscKQ7SfPwuLGtv3n56UjyOWFZ9ywbEsN8ekcI+y3nMxQVJCo2w7
         epHU5D5uyeMw4CCz2vo9RqhswfAu0VIqlRiZ0kF0k1A199BMVPVLoOOSbGfO1R4zlt1e
         0+O6RQu8Tq3diYbC4liEJmEuiwsqD9tz7tyUL5l8eR5u1G9D14mr1llq8zb1j7iEiwJU
         RjMzq2nOClnf3Rglv7Kg1VoB48NNDaYnlJ1XMX9m1/PMSzYsg0pS7XcmWEtuLa8sZEQv
         5EdHFHBuYl7f6QFjkoqmtWixNZAAzmQAeKf0GynfS07y705e9sVbMKU6dwpmIhDQAxhN
         JkYQ==
X-Gm-Message-State: APzg51B/u2p0Z+5nlupujvKIFK9zswhHOFiRkry2wXoTHtOZHvWvXq0k
        29JNVCW+EVs8QrXuCg/e86Czig==
X-Google-Smtp-Source: ANB0VdZTs7U9gj8YWiCpbQ00i10Rn3DZT4Un6dpdOkbz9x7KNkOpbqD0zIdFq4h0+J2uiZT8EM2mcQ==
X-Received: by 2002:a24:a003:: with SMTP id o3-v6mr4471169ite.117.1535036100089;
        Thu, 23 Aug 2018 07:55:00 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id m5-v6sm1546635itb.6.2018.08.23.07.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 07:54:59 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fsr0k-0002bm-Lq; Thu, 23 Aug 2018 08:54:58 -0600
Date:   Thu, 23 Aug 2018 08:54:58 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        dasaratharaman.chandramouli@intel.com, leonro@mellanox.com,
        linux-kernel@vger.kernel.org, markb@mellanox.com,
        monis@mellanox.com, parav@mellanox.com,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+29ee8f76017ce6cf03da@syzkaller.appspotmail.com>
Subject: Re: [RDMA bug] KASAN: use-after-free Read in __list_del_entry_valid
 (4)
Message-ID: <20180823145458.GC9366@ziepe.ca>
References: <001a1141551246502d056845782e@google.com>
 <001a1140f6ac1677460568489287@google.com>
 <20180823061630.GB736@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180823061630.GB736@sol.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:16:31PM -0700, Eric Biggers wrote:
> Hello RDMA / InfiniBand maintainers,
> 
> This is an RDMA bug and it still occurs on Linus' tree as of today
> (commit 815f0ddb346c1960).
> 
> I've also simplified the reproducer for it; see below after the original report.
> Apparently it involves a race between RDMA_USER_CM_CMD_RESOLVE_IP and
> RDMA_USER_CM_CMD_LISTEN.

That is an amazing reproducer!

I have a feeling this is the same cause as all the other syzkaller
bugs in this code: lack of any sane locking at all :\

We've talked about chucking a big lock around this whole thing, but
nobody has done it yet.. It isn't so simple.

Jason
