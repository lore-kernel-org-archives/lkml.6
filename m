Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA96C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B87020C0D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 18:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="IP846aEY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B87020C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbeHPVBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 17:01:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39414 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbeHPVBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 17:01:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id j8-v6so2357586pff.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 11:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=o6B1iukWEj8+R5qHvSHRhxLoIBnNoax4hFWQnMDL55Y=;
        b=IP846aEYnq0W5MFq1uV9cYkNIEQYFXjXxgkXNcunUzAkkc4xfV6kSz2uVpDZeJZqbY
         4imChSdhG7zKpwwh+HesnN90Cw9b6osowGh3apXXUOX7hfbZJw1cGIe/vnL9hcsq+v3Z
         Bv5zbo45r0mJuEHKis3pSZIoIC8rXPccJ0aiqsDTs4WC3/CXVtus2QN53qsMpcXp3q8q
         ZqKdsxoHJFx/Hjcso9gPwFlxPC4gVwhzyIG+ichWT43LTyxziXHVugA6egsL9He+w+sZ
         EMw7vdyp9WVtoHjXOS5yFTA57FTtEzBerK7C6VMdw+3qGW4kS87Q0O9ct3Hf3Y5axRMv
         4SoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o6B1iukWEj8+R5qHvSHRhxLoIBnNoax4hFWQnMDL55Y=;
        b=DxBmBX30uUY5KClhtgoVXFZbdZMr04/6NTKhKXujLIq9KdWdFEuVy/kWa/Ctud28eA
         9A3xBWyJBwFhpjyvlbMHJYqT0TWWfodpvSPqL0yHEsSy+vgStmsBqnx+ZVXz48z/lNHT
         xrnX8YlcqFmgvjJvhvxHacUirleBv3JaI8sC9ArBKb5pdMW1vhAHMbw6fUUvXk4eTRov
         EaQ1kMM855qBD63EnTjsjrxhW/R9EgpJTg25RXlKDgDApRB3VrxPb4+UJNZuB96PEhU+
         B9kkfybQELveoj32CAEAzAjst1sc7PWrWpfZnQ0EcIl1LCvg1KS/GECuzNFtTpng37Wm
         QW4Q==
X-Gm-Message-State: AOUpUlEfzcJ4LW3fgNrcnMDSn9LSEs9duq6lrDDuRE+FBuj3nNTXqsHE
        3Yy6oF1nYfyFF50FrakSHbm5IA==
X-Google-Smtp-Source: AA+uWPzBY2TYymx/vhbc+glaRzd4V8dY7xchMamQXdPfmoALV/2W3xciooBsvmVkrbQLYqeKiNRnPw==
X-Received: by 2002:a65:658d:: with SMTP id u13-v6mr30243707pgv.20.1534442487979;
        Thu, 16 Aug 2018 11:01:27 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id g6-v6sm3363203pgg.7.2018.08.16.11.01.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 11:01:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fqMaM-0003CT-Nz; Thu, 16 Aug 2018 12:01:26 -0600
Date:   Thu, 16 Aug 2018 12:01:26 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Howell, Seth" <seth.howell@intel.com>
Cc:     "Walker, Benjamin" <benjamin.walker@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH] rdma: move the ib_wr_opcode enum to include/uapi
Message-ID: <20180816180126.GB10507@ziepe.ca>
References: <20180814223303.83556-1-seth.howell@intel.com>
 <20180815225021.GB31799@ziepe.ca>
 <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EA913ED399BBA34AA4EAC2EDC24CDD008611724E@FMSMSX105.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 11:27:36PM +0000, Howell, Seth wrote:

> Thank you for taking the time to review this issue. The patch you
> submitted will definitely fix the problem I was facing.

Can you test it to be certain?

Thanks,
Jason
