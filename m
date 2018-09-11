Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B40212086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JhQ8xTs4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B40212086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeIKVDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:03:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45096 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbeIKVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:03:12 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so12441861pfo.12
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ktrSTl24/I4X63E1c10v6SanbBkOFhZZY/XSGOa2QEQ=;
        b=JhQ8xTs4F8bPY3m3wdZZyGxLDqATQYh6uj1dO6vJIk9EQ6Zv2KCEkwMwnNaVMh88ww
         eH4Jvm0IbzvXlAe91I4P8BYQcmCwYEtCQ6SgwKD12cB+nm0/lhWL3Zfe3NbcFdedvdX6
         NVeHrZpeDB67nLEZXj1+tk2vQjsqesTsA8CWS+syg9XqWsagIc2dhCG6qErWLRRPWu2S
         W4LtYZOSMEbw3dI4XqmiF4nuJ2zQNtv64Rxnuu98cE1Qb9q5GbfMlpRrBh+u4XwtLi66
         HJTIuS5yO93aOfvJhC3KZISpnMWCq45Fn4Zh6O8fxyYIMa2WUIyUQmUUkuv/R/S/zIzM
         zuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ktrSTl24/I4X63E1c10v6SanbBkOFhZZY/XSGOa2QEQ=;
        b=iWEg73r91sd8jgejSgnjPwpti4uEZd8fVZQ5UEy42HsuMtzw44nx1PuELTWAalS+P4
         vo6/2yzNBaSGOT1g87icN3xK7KIppV7POxOvF+rFUpN8hzYD+wmwcjoWV8Zan1YWvL7o
         Ga1NQkJQGJav4a7QY6cYhZPMdfj1GyvSsu9e1gXG1sqng7cqNgWYys3QX2Y5p2PCphZi
         bYW8iTME98GEBku1uvtObY32XQYhGqlarP1+m3RQtd3tyTeeP6bq5MOO2XJ580QXb6+k
         8WDd7Ge4ttNK4gmzHrvEfUk7xW4C1zb1P7WvEAyODQYAOf8z+e5NuE1a/8eCCWRNhiLS
         /4Ig==
X-Gm-Message-State: APzg51DU8TjG/GQfwhBnjjpJiemK/78Ky3GJ/p1eb6kHm3Gt773pLTTU
        TTtvC1oN9bz5BPzSatbOw4qTpw==
X-Google-Smtp-Source: ANB0VdZvryLL9D4tdG8kXLkqmnkXpOCYEOE998HxpfLnJGlTQ+z85Is/HicUQECPEDJtCakZOWPuNw==
X-Received: by 2002:a62:b40c:: with SMTP id h12-v6mr30266513pfn.18.1536681795151;
        Tue, 11 Sep 2018 09:03:15 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id x23-v6sm41290003pff.9.2018.09.11.09.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Sep 2018 09:03:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fzl8C-0006Af-P2; Tue, 11 Sep 2018 10:03:12 -0600
Date:   Tue, 11 Sep 2018 10:03:12 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: Fix an error code in
 hns_roce_v2_init_eq_table()
Message-ID: <20180911160312.GA23697@ziepe.ca>
References: <20180910083511.egoljxb5rr3do6ue@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910083511.egoljxb5rr3do6ue@kili.mountain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 11:35:11AM +0300, Dan Carpenter wrote:
> The error code isn't set on this path.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to for-next, thanks

Jason
