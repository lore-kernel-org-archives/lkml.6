Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0F3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E0B9205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 20:06:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E0B9205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbeK0HBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 02:01:35 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41121 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeK0HBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 02:01:35 -0500
Received: by mail-oi1-f193.google.com with SMTP id j21so17068959oii.8;
        Mon, 26 Nov 2018 12:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ky4Bbf0jEivHCSN6gBnvnaix1XGilPXfFAhBlpfsIdA=;
        b=uYuxTm1r6o+te9q2/jxyJal9AedFUjHcykVgYKX+82gez9DIiCnSqoghSPlQ2wR8Nl
         /2lPs4OTvUZ5SLFAsgZmkwPsTlt7D76zn3Tz8xp7psxOu1XRgzeJ1M0CqYqEQt+iazC0
         oDBa1ReKGScm2shzUr7stjAVaKSyq5p0t+lbVisH4wHXezUo8OkQScE1p8s72FT2qjJe
         z/krzNgvcnztgUipWxaB9+ywBHcnDm3vKICiP4sG5mrjFn1AzTxTPOWDpT8TrhxZ5qh1
         EU28MRasqhrm2w4Ex+lhx3Z1/vRTvJp+0r3xyq2AxPU7J3eBV5LhTOwMOzINXchWxIYO
         wv6A==
X-Gm-Message-State: AA+aEWb5EM2diIHs8EMwwXnLIpY74IZIIvztHHi4KYTVB775urhljmLy
        RjTQvUfCPtqiySxY1KF0rw==
X-Google-Smtp-Source: AFSGD/XWXKd0+oQu4CkY0/8HkvT9NcMrEVstIFCpHi4XQ+XY8A26gi0jGHP7xZ5FgKERrZhozltypA==
X-Received: by 2002:aca:2d3:: with SMTP id 202mr3721978oic.214.1543262781278;
        Mon, 26 Nov 2018 12:06:21 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 18sm389814otf.59.2018.11.26.12.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 12:06:20 -0800 (PST)
Date:   Mon, 26 Nov 2018 14:06:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "wg@grandegger.com" <wg@grandegger.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng DONG <aisheng.dong@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>
Subject: Re: [PATCH V6 1/2] Documentation: can: flexcan: add stop mode
 property to  device tree
Message-ID: <20181126200619.GA1595@bogus>
References: <20181123083304.3232-1-qiangqing.zhang@nxp.com>
 <20181123083304.3232-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181123083304.3232-2-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Nov 2018 08:35:29 +0000, Joakim Zhang wrote:
> From: Aisheng Dong <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse the stop mode property to enable CAN
> self wakeup feature.
> 
> Signed-off-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
> ChangeLog:
> V1->V2:
> 	*add a vendor prefix in property (stop-mode -> fsl,stop-mode).
> V2->V6:
> 	*no change.
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
