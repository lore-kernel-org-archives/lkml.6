Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0440C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6938A222A1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3SI0Y5R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394414AbfBPEJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:09:07 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40599 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfBPEJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:09:06 -0500
Received: by mail-pf1-f193.google.com with SMTP id h1so5807315pfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 20:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AdHjxWAIvBJGzx3w8YbtISELcPMTa1Y2ur/yRLG++Lg=;
        b=m3SI0Y5RxClBEOs40cKVJ9vNIUEyGn6zDG+2uEwabFpluInTGBq6Sl4pjqY8w/rczC
         oE8lICQwwl2E1svJBbD67+Uin1f1Ba0ZbRXuqA9fzVNAN5zdx12MpMo1h8OJZYPHvP1g
         tgPA6BaQHAPrKdSdk48n6C1fKNi6ljyIZRzYjuhfzqjc3quxDetqXYr4FPTHvs3+QKsU
         okZIvDvNh/XLxxrpTGP/6taTiP66tpkmtEIEfyzx47sqqwrTT28St5M3791TwvBXtcGF
         48kV3NoNbCxwtpDMm6/7OjUIfBrmfo3H7JFnCe5wy2INlXsn7hwt6d8dr6KVJEA+bJUo
         h+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AdHjxWAIvBJGzx3w8YbtISELcPMTa1Y2ur/yRLG++Lg=;
        b=ZB/ptC6qB6j4pmspcsVhYLhe3HHMWrcrsLEaFlvbZ5Sk5LY2RN5gPH2f6U8LgeJmYB
         etgDIYjszj9AxT/sVrOHAKd/R8XMt1mD4jrdxPcwxZmRUZ/oBZ3NURaNM34KrNvzaBF6
         VWBrWlTPctXsE5GoGAYKyqrZHYaYLxWY0cnu8rrT6uBgWzKqsit8eW4aLv7F6v2hPN+0
         0qvm5ISGfIeDIjz+QMa6xNewcv0Q2SCWi08vmj3mSRbd2kcPhv+yFTw7FhGMXjKL7P3T
         u8trMG+Hul29WFGF7uSqnDNKqOrhsHMRRXDhWuV8QR1a2dKGqfEukDdFKSWeIG4HEBHp
         5jgA==
X-Gm-Message-State: AHQUAuYQP0hMrXtvWeT/w+O5BoFvW7IjhgkwMw0y4RnhJDjtwo4pPumF
        a4pCBKTe3x9Cov3wIkXtkBKS
X-Google-Smtp-Source: AHgI3IY6j7fafeVMU+oG5c0qnthUPoAc22s9CwZ8/bl6+ix07fyh2LvwJTrbxsxZxP3u3/HoEp09ng==
X-Received: by 2002:a62:5789:: with SMTP id i9mr12865539pfj.75.1550290145492;
        Fri, 15 Feb 2019 20:09:05 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:6190:e85b:d8eb:c013:fd6d:7b1d])
        by smtp.gmail.com with ESMTPSA id e9sm27441763pfh.42.2019.02.15.20.08.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 20:09:04 -0800 (PST)
Date:   Sat, 16 Feb 2019 09:38:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com
Cc:     Rob Herring <robh@kernel.org>, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        liwei213@huawei.com, robh+dt@kernel.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        john.stultz@linaro.org, amit.kucheria@linaro.org,
        guodong.xu@linaro.org
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller
 binding
Message-ID: <20190216040855.GA3054@Mani-XPS-13-9360>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
 <20190111213502.GA24538@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111213502.GA24538@bogus>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 03:35:02PM -0600, Rob Herring wrote:
> On Sat,  5 Jan 2019 12:58:57 +0530, Manivannan Sadhasivam wrote:
> > Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> > similar to HI3660 SoC with almost same IPs. Only major difference in terms
> > of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
> > (HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
> > is added for HI3670 without any fallback.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Martin,

Can you please take the bindings patch also? DT patch will go through
HiSi tree.

Thanks,
Mani
