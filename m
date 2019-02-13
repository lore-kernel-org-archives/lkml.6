Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADCC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550084957;
	bh=jRkPGVhi/slxxcO3Jpu6IJxQDsDS297zPeuEvELuwb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LES88sDw6cE80Kh4iZ2d2SFWcgKkodbZAVqOtCeDl+GfShxkMC6bLKBDBc1uQqrnW
	 lgAk3dnLm4VxQ3RENexo9yjrc6S/J3+ybZt5FV0mBkg5b+GJVFEfZCRNhAqyvbXYW1
	 xZ9S2To8huW3JgZlh/ddb796TIIx/s5AorlHbYXQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391782AbfBMTJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:09:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35421 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391600AbfBMTJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:09:15 -0500
Received: by mail-ot1-f65.google.com with SMTP id z19so6231204otm.2;
        Wed, 13 Feb 2019 11:09:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hZYjhNPaR/1+wyumpbQrE35LcxqK3TnJyQfLm/bN/D8=;
        b=CvHSvbYekm6m9cOriRHXkoqJQDnJRCt21fIa7gEM1PJZU1MQ34DmtXq2YUULpfLPyU
         7EVZDlAyUHLNvgP5I+B1Kbk5s+3jfLGC5Vq8uf+rqtsSvlrrLVnM0z0K146x4e9VDqz/
         IwpqKjOvSCedG10kaoeHwl+SttiL4bbeDp+JVVbRRojKI1/0rSiPhLM/uSG/AdKcULYx
         vJabuHAlj3DY/0Q8Yaq8Wpf+ZvEflU9HMOSLu4mkqeZS/QMRlSal8EucIXimVpcDSWg1
         knwUn4pOn0fnJYz/s3+DDt5ouX2dBiqRAfJBr+eLimySH1VB9U+T5l1OLkOP9E+Gz1MH
         IgMg==
X-Gm-Message-State: AHQUAuY1dqZz7Zt+/OqYLn5geHo0MI/Zh0TAnilAOTPRjN2Zk2T5/coG
        7UFrPvdw16o1vIZN5O2dug==
X-Google-Smtp-Source: AHgI3IYwm20EOywb8crfIa4StqRYrpJEL6P/rmsGBAj7IdzMnIpBOi8nMzsdiT3VSnyi+lZlb/K8sg==
X-Received: by 2002:a9d:403:: with SMTP id 3mr1274607otc.110.1550084954843;
        Wed, 13 Feb 2019 11:09:14 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a17sm39118oie.20.2019.02.13.11.09.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 11:09:14 -0800 (PST)
Date:   Wed, 13 Feb 2019 13:09:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] of: unittest: minor cleanups
Message-ID: <20190213190913.GA28264@bogus>
References: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548372134-15729-1-git-send-email-frowand.list@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 03:22:12PM -0800, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 
> 1) Suppress expected error message when adding unittest data to livetree.
> 
> 2) While writing patch 1, noted a misleading function name.  Add comment
>    to the function header warning about possible unexpected results.
> 
> 
> Frank Rowand (2):
>   of: unittest: remove report of expected error
>   of: unittest: add caution to function header comment

Applied.

Rob
