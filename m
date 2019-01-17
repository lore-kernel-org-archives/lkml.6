Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A97C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 620CB20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547741202;
	bh=v1NVkd/gQxIWCluwca9vHBCtVJz3MH6IwI6Ma+QL3JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XQmpgZlEHKti/bpUqoC+M0O7tSkDKjwiTRiKGqmVnj5i3MlDJ8trQ+s6VE+jQ1Fk1
	 njVAgwAZ4HktuMyegDDWW8IbSJgW81oAJtsqs31tx5nS0Y0G0piE6fZMgTGccVNmMy
	 RfUHFIjTfoqgVS92Vsru9V8WmuiIgUSVYyW06U/s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbfAQQGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:06:40 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35163 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728449AbfAQQGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:06:39 -0500
Received: by mail-oi1-f194.google.com with SMTP id v6so6578656oif.2;
        Thu, 17 Jan 2019 08:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=REg/llw+PHlGGbPLZMzBjttCc27g6sfqJ7z//VJAMlg=;
        b=hY5gpAZsODJHlMUMi7/K3daOCLuUIrT3Xzp06ELLfsj6c8HRhvZaMcUD3l37MEacep
         nVa6MA4jxu/Q6O1ltaK6OAKatkvK/A/SjeTFwgeIyJ7AgQTaYpSQE09Xp4osiie7ponM
         UNHuWqXy+U4/I9CtX/ovoHJkiVv2lBeL8s0zwiiR7s9uyzrqKkViyNB3+F8nIfL73em+
         cDujf1u/2YT71Lp0HZIOj9bKYtwuaxoOzH+5bha+nzm/cD+wJ+5R77OEtWoNUK3SVF6u
         UV/ejnDorpXnTUnvaf6Fg+iNo2G+ms+50Z8cal6ElUNs1OFxnI7uhYloa1Ids0U/FUU/
         w6Nw==
X-Gm-Message-State: AJcUukd4pilE21wY+4skQ0upauqcXgm4VQvtzylq3ytcCg4wBdpyrv0L
        8d6hrAlsaLjjoCUfWO45iA==
X-Google-Smtp-Source: ALg8bN5O01O0vT64TtMF+fa8wOaqfdxH+oMvi0Z5zrBsMUmvytQO8YHSNW3eJEYEllNSNyTOmEu9Ew==
X-Received: by 2002:aca:3d4:: with SMTP id 203mr1096029oid.315.1547741198733;
        Thu, 17 Jan 2019 08:06:38 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t201sm810095oie.37.2019.01.17.08.06.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 08:06:37 -0800 (PST)
Date:   Thu, 17 Jan 2019 10:06:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Tanglei Han <hantanglei@huawei.com>,
        Ryan Grachek <ryan@edited.us>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/8 v3] Documentation: bindings: k3dma: Extend the k3dma
 driver binding to support hisi-asp
Message-ID: <20190117160637.GA3498@bogus>
References: <1547141652-8660-1-git-send-email-john.stultz@linaro.org>
 <1547141652-8660-2-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547141652-8660-2-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jan 2019 09:34:05 -0800, John Stultz wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> Extend the k3dma driver binding to support hisi-asp hardware
> variants.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Tanglei Han <hantanglei@huawei.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2: Simplify patch, removing extranious examples
> ---
>  Documentation/devicetree/bindings/dma/k3dma.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

