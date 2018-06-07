Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 5YkbHXx+GVv6awAAmS7hNA
	; Thu, 07 Jun 2018 18:50:51 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 350CF6074D; Thu,  7 Jun 2018 18:50:51 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="hfz2w1r6"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 8B268606DD;
	Thu,  7 Jun 2018 18:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8B268606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932573AbeFGSur (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:50:47 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51164 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932504AbeFGSup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:50:45 -0400
Received: by mail-wm0-f66.google.com with SMTP id e16-v6so19783026wmd.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KHtSFMK3pkdaXrphp2O5ytRdMqjcSWaTsAMiJ7/fYDc=;
        b=hfz2w1r6sM6Lr7H5nZlK8ng1PXBUliBUaHAhkh/PjwnhchXoUTScqFMcahJwQoZ12g
         LuvPn5Opdgq/5kdpo0EbsOYTGzpWC/4iwWx3LXE98yFVdKb9DCPnwSRdWfI7nS3yx1BZ
         m4tY3gNFsxdGytQziiUgAuJhEtsK8jyew+TyVgdMZNYRmRhlYQ7vfZ9+LVVMKCvNo+my
         7s6h9Crh46EEtWWwhQ1qENDK4M1PNT6wrnBaPb3AX2BIMxeKlci81Fp9btGIYTYoBFxZ
         uTYrb0QUDbqvMVHbIkPHWUDEVykv0r0tA0g71gmWobczQmo2UyTXzsFpgMjePHYU0Vvj
         aaTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KHtSFMK3pkdaXrphp2O5ytRdMqjcSWaTsAMiJ7/fYDc=;
        b=JlEk4ZBn2F5IdOtd/ai1rNApM6wuK95RMIDe4bZOaQVIKXmb5MFT42zhRZaKQ4Qyli
         RPWZFiSBxdu2NBmw7oVUZmdrGzP/8lomXJYTTs9OHX7RRfyK9F9VsO0L9Z6DQo3yp/TU
         CXPL2ydt5f6jHMkC1CJaEZAWA726wMq2tKhFtl48WiasB5OJP+zH1oQ0NkC6zY6Sr3I2
         9Axgtn9/a9t9KtZwCCwIZD/WYDIt4klV9d/Im4l8O+HpKuqqS9Pcj2iOu+u7NFivfT3e
         HKjbQtD4yRaAQPFZvLzV7nwsoDLl95rA7QlSnylVRhtftNaTL9JtqvUjJQGOavZT2I0+
         0tww==
X-Gm-Message-State: APt69E19WXBS40fylg96bwu7loq2BDzup4jO3aSUDhaMS+GfcTDd7DXL
        S2gqr4cay7ElxgnJEyQdag6FKw==
X-Google-Smtp-Source: ADUXVKKTQnSpgIOlGlpBvLmBytHdqFOOCtugIBTqOhhFUI40VkX0ys7T+5xABdzBsL4RslUoQv3fWw==
X-Received: by 2002:a1c:9d49:: with SMTP id g70-v6mr2545801wme.134.1528397444186;
        Thu, 07 Jun 2018 11:50:44 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u7-v6sm38858835wrp.44.2018.06.07.11.50.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:50:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fQzza-0002yM-7R; Thu, 07 Jun 2018 12:50:38 -0600
Date: Thu, 7 Jun 2018 12:50:38 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
Cc: Doug Ledford <dledford@redhat.com>,
        Hakon Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Wei Wang <wei.w.wang@intel.com>,
        Chris Mi <chrism@mellanox.com>,
        Eric Biggers <ebiggers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Mel Gorman <mgorman@techsingularity.net>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] idr: Add ida_simple_get_cyclic
Message-ID: <20180607185038.GF14583@ziepe.ca>
References: <20180529073808.27735-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-1-hans.westgaard.ry@oracle.com>
 <20180607111435.17538-2-hans.westgaard.ry@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607111435.17538-2-hans.westgaard.ry@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 07, 2018 at 01:14:34PM +0200, Hans Westgaard Ry wrote:
> Signed-off-by: Hans Westgaard Ry <hans.westgaard.ry@oracle.com>
> ---
>  include/linux/idr.h |  8 +++++--
>  lib/idr.c           | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 72 insertions(+), 2 deletions(-)

If you are going to do this you should convert the other places that
open coded this as well..

Jason
