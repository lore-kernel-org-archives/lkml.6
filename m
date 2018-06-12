Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id C7415C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE0E20891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DE0E20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754382AbeFLT0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:26:41 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:46234 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754025AbeFLT0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:26:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id d2-v6so34879pga.13;
        Tue, 12 Jun 2018 12:26:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zwbhwOkJzDqm8OTpkOL/lF/9LkiDUNPGg5CyDUqA2uo=;
        b=MY5bZDGMfkvvpdpY3PZrpTKZsdkSp/qoeaq6rEpJ15aZZs/eqKolZDyeAhdiNrXDCp
         blfqMX07gu5gMo7K0e5xQavqfClUBPn+u0pzzewFKIimUFPbfbD3o/MkMWG8hqMmFUap
         r8NlAkJj+FxDowyLm8GsOggVb7Mj1RSAQJ5sgGUNGor0z4ftiIu+SgQ/IyBNK/gQZsNQ
         vAtaM7leiv7lvaCW4oajK6br3WqfYOJimxFlH75xjI7w23HQo+zJO1D2YH6TsidTHUTp
         Qv9GByU+moPNv7FHvbrTkBxUtswfl5XUZVp2WXgAlDriQV0DaOkudQ90aJvdKnz7IrAR
         AfEQ==
X-Gm-Message-State: APt69E1MSuZ4WmgilitV7wo9UEHzndavr7Zl9ZZ+6RyUS5fr+In9B6lR
        OXozHa6BUN5YoPvx6PzCPg==
X-Google-Smtp-Source: ADUXVKLnhEjsZQg3v+ZlyGTsUbhNSE83beOJCEVJSyHN9XR81+rVbrzzwoYTeUtw7Wx/N5FkocNgpg==
X-Received: by 2002:a62:4e07:: with SMTP id c7-v6mr1729696pfb.149.1528831598790;
        Tue, 12 Jun 2018 12:26:38 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id k84-v6sm1517478pfh.110.2018.06.12.12.26.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 12:26:38 -0700 (PDT)
Date:   Tue, 12 Jun 2018 13:26:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, linux-scsi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 1/3] scsi: ufs: set the device reference clock setting
Message-ID: <20180612192636.GA31725@rob-hp-laptop>
References: <1528455990-24572-1-git-send-email-sayalil@codeaurora.org>
 <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528455990-24572-2-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 04:36:28PM +0530, Sayali Lokhande wrote:
> From: Subhash Jadavani <subhashj@codeaurora.org>
> 
> UFS host supplies the reference clock to UFS device and UFS device
> specification allows host to provide one of the 4 frequencies (19.2 MHz,
> 26 MHz, 38.4 MHz, 52 MHz) for reference clock. Host should set the
> device reference clock frequency setting in the device based on what
> frequency it is supplying to UFS device.
> 
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Can Guo <cang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  7 +++
>  drivers/scsi/ufs/ufs.h                             |  9 ++++
>  drivers/scsi/ufs/ufshcd-pltfrm.c                   | 24 ++++++++++
>  drivers/scsi/ufs/ufshcd.c                          | 52 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  1 +
>  5 files changed, 93 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> index c39dfef..4522434 100644
> --- a/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> +++ b/Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt
> @@ -41,6 +41,12 @@ Optional properties:
>  -lanes-per-direction	: number of lanes available per direction - either 1 or 2.
>  			  Note that it is assume same number of lanes is used both
>  			  directions at once. If not specified, default is 2 lanes per direction.
> +- dev-ref-clk-freq	: Specify the device reference clock frequency, must be one of the following:
> +			  0: 19.2 MHz
> +			  1: 26 MHz
> +			  2: 38.4 MHz
> +			  3: 52 MHz
> +			  Defaults to 26 MHz if not specified.

I must have misunderstood your last response. I thought you could handle 
things without DT. If not, my question remains.

Rob
