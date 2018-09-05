Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727B1C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133262073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 21:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Nhk49a01"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133262073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbeIFCZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 22:25:09 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36896 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbeIFCZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 22:25:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id h69-v6so4156601pfd.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 14:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ezltiUevTcWAmCudjI3HEsT0UbUUXDNIEqFkM+sJjr4=;
        b=Nhk49a01hLFRBqGTHwagLTjEkSNG57OTVOn12TetIGPIz6666hFzbCNtDxkmjOJMfr
         bHfeYjCxKi9tg4J2jH2JOrPweLrghDMNS8hM+42Ugz/fRQ3/1eIAQva209KDFm95y1Mu
         K9bEI9Oy3Yf1zsUpXdHfgvQpwhRTmaOaRiiSwwMF9Yjs+l87L3w6CfI0hcKd0d6CagwJ
         9QfXNB9cu4U+P7WKM+/nE25TvmXQzvmCM4JxHXxH7UE7lW0HJ1d7G4g353pk36xqsRjX
         s5EnDAO25cjlvoEAhEjFZvWFh9An4g2HblDH1IAIz209q3sc7Qee/J4Al+jgNNmmnl2f
         Q2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ezltiUevTcWAmCudjI3HEsT0UbUUXDNIEqFkM+sJjr4=;
        b=OXLJ3qcVnLVhtRF0FJ3TkTMTpPUnh8fTTrbUy4zfox4m+R6GmVyIMBtZkaUgTiP3MI
         E7sojZxHYZgO7Lq918eOMMjBgKrenmW0DuNPyVdwMYNJKOMNEnumyxqoFs6STTVtcatX
         RlVCZnqAgrxHXEo7+FsbMf9+GKiSzIg9F9XRFIYEzAMJFFlIBQv/Kh1vUghvBVYDd3+y
         2XUDy4OfueLjSD+qfOp+z7WA1ltuw4lXwZevbEFE4G/0PxwyHSeCBVV99GDSBtgfpqUY
         a+VVFIYIo7L96SNDSZWp8zaMT2r3IZ1fCYrNcjDyAQT7EAeSUUXELFRcmgIQBJN6EKuC
         DXmQ==
X-Gm-Message-State: APzg51COFZQjDKiojk5OkKCaGs9oc8yWMlaccYWvaCy3G+CAKKYjQ8SC
        of72ZfoF0E5HoK8xP8MgaJREBg==
X-Google-Smtp-Source: ANB0VdZ0lTQ0YGVLcGsXXb7+BeK2xlCqqWmlkESyvHbpiTIXbm/Gqwn+UIyq0J6XK2aX24YQUjZLsA==
X-Received: by 2002:a63:586:: with SMTP id 128-v6mr38831639pgf.169.1536184381180;
        Wed, 05 Sep 2018 14:53:01 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id q85-v6sm4516743pfa.151.2018.09.05.14.53.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Sep 2018 14:53:00 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fxfjP-0007AF-Ik; Wed, 05 Sep 2018 15:52:59 -0600
Date:   Wed, 5 Sep 2018 15:52:59 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Igor Stoppa <igor.stoppa@gmail.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] infiniband: scsi: remove unnecessary unlikely()
Message-ID: <20180905215259.GA27512@ziepe.ca>
References: <20180831201645.15611-1-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831201645.15611-1-igor.stoppa@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 11:16:45PM +0300, Igor Stoppa wrote:
> WARN_ON() already contains an unlikely(), so it's not necessary to
> wrap it into another.
> 
> Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Cc: linux-rdma@vger.kernel.org (open list:SCSI RDMA PROTOCOL (SRP) TARGET)
> Cc: linux-kernel@vger.kernel.org (open list)
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
