Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 179D22184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547242506;
	bh=FLCsYk3WYaclRFGiYiHaFsx2cWgEO3nn8VTzOVa2Gl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LZdGWOV1E+2PlcuS7ChV/9UI/NUht9bBQ8RboYzDXKayS0ELSATX9Sc6OefNmnfYi
	 r12aSxACktMmcgpnH5Y3zBWXvCHu5VqqQvpuo9E26o+WL8NxAgNoK5zjZeu33LLNlW
	 mUcrMoSZhXeMCe25NfX95xmTive1wCMQlvXP0u5Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfAKVfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:35:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38812 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfAKVfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:35:04 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so13390249oii.5;
        Fri, 11 Jan 2019 13:35:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5MWqOYhYwGRYsdVb7b1Gquk64PwL2N180mchzXe8hHU=;
        b=mlU4BfaoFfjnKDSrnoO+KOWooufil1MDjIVluUR2ISXbl+K1GX1m0E+cmOQHp6e/Rk
         QLjIxgcI2jIyzpgNFSuxwXZJBDKkgqKAaCiig4MQKrZ26b7tONrzUIAv0ectar0hJOK+
         POE+otQgU2UIwq4PeWS0gJOs3bZBZ64YEJSpvLPt5mRiCi/B3+/+wn0nfeMmu1vN3lO9
         opDRMp9MfocnfiPTDW/bKgpBpVS9+Px5e5Gpkh0VwUPUlZkMjvr/OnLLffY17Uox9tJ2
         nMArK8ZyftU0iSxU7qq2DSGbxFJ7q1udlwpPvwF6KcAwlMTzznpXplZ4kGeo4ZD8/a3M
         +BXw==
X-Gm-Message-State: AJcUukel9KqUh8y0w7uOjaFxm1suG6Op6MOvemOAPrBm+rGwO3bB7mfj
        EK14Yq4C9cPxAnzascj9XA==
X-Google-Smtp-Source: ALg8bN6mpGBPwYnBZ268kFRALbuEVluToB6AIiv0hNqYAQASMOhkeNRC9y6SKxT3nONjqvK/k7HMug==
X-Received: by 2002:aca:4506:: with SMTP id s6mr9678093oia.115.1547242503832;
        Fri, 11 Jan 2019 13:35:03 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a201sm45360684oii.27.2019.01.11.13.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 13:35:03 -0800 (PST)
Date:   Fri, 11 Jan 2019 15:35:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, liwei213@huawei.com,
        robh+dt@kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, john.stultz@linaro.org,
        amit.kucheria@linaro.org, guodong.xu@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: ufs: Add HI3670 UFS controller
 binding
Message-ID: <20190111213502.GA24538@bogus>
References: <20190105072859.9134-1-manivannan.sadhasivam@linaro.org>
 <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190105072859.9134-2-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  5 Jan 2019 12:58:57 +0530, Manivannan Sadhasivam wrote:
> Add devicetree binding for HI3670 UFS controller. HI3760 SoC is very
> similar to HI3660 SoC with almost same IPs. Only major difference in terms
> of UFS is the PHY. HI3670 has 10nm PHY. But since the original driver
> (HI3660 UFS) cannot make HI3670 UFS functional, a separate compatible
> is added for HI3670 without any fallback.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/ufs/ufs-hisi.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
