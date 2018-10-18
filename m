Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9ECC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55B520645
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55B520645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeJRWbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:31:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34378 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbeJRWbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:31:39 -0400
Received: by mail-ot1-f66.google.com with SMTP id v2so22813064otk.1;
        Thu, 18 Oct 2018 07:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sr6bcrU66dfQdCbQFyxsOrHsqhm4KEOmP6ZCMsSWpwg=;
        b=HnilMd8XAgeBpaZ+gK5oQHJOWFkE0YvHZ0FjiYWg3AlKah4uHwhTLnX8gJTgjq/4Vd
         uT7FafPbDtIRxPkiJVB1763gOd7wjqdHKoIwe6TMFrNc58Nwcb+XN+Ir73BcIBA+KmaB
         zTokUKf9d/Srln0lz5oTqHNNg2yHOqVQHlddPp5Paa55e11aV70hPnCeX1Y4PKFdzi1o
         Pxkk35fDADpOI+49fGWhTVXw/GUrA8TZmORixa9Ftwxjnv8/Kfyy/FG3q1O2iJRUIL58
         ixT6lR5C4+TH3Z0j7FZUZbZKTwbuwj42B1C5oDv1XYVeg53OPkWZmzMVsk4LOymnA6tl
         UwVA==
X-Gm-Message-State: ABuFfojZwSA+dSl2lux4Vl5whwZQfQynfsiiDwVfQRKH5mK+LsydObUf
        BYFEtq1oBE9D00OXhXST5g==
X-Google-Smtp-Source: ACcGV63YQrBamzJuSZrgt+ffU5lJn1jI4LU4pIiTZGArQDtembwBkKVaqO41lOQDYk63BIymb8LQiw==
X-Received: by 2002:a9d:3ee4:: with SMTP id b91mr20305833otc.330.1539873022674;
        Thu, 18 Oct 2018 07:30:22 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v124-v6sm6525577oie.48.2018.10.18.07.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 07:30:22 -0700 (PDT)
Date:   Thu, 18 Oct 2018 09:30:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sayali Lokhande <sayalil@codeaurora.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        jlbec@evilplan.org, linux-scsi@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V15 1/2] scsi: ufs: set the device reference clock setting
Message-ID: <20181018143021.GA18795@bogus>
References: <1539680382-31136-1-git-send-email-sayalil@codeaurora.org>
 <1539680382-31136-2-git-send-email-sayalil@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539680382-31136-2-git-send-email-sayalil@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 02:29:41PM +0530, Sayali Lokhande wrote:
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
> Reviewed-by: Evan Green <evgreen@chromium.org>
> ---
>  .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |  6 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/scsi/ufs/ufs.h                             | 14 ++++
>  drivers/scsi/ufs/ufshcd.c                          | 83 ++++++++++++++++++++++
>  drivers/scsi/ufs/ufshcd.h                          |  2 +
>  4 files changed, 105 insertions(+)
