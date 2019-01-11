Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA43C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1013F21841
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547218710;
	bh=xI0z/B6D8BzkSCxcCpul+OEe+Z9Kk6cyC64z74GkG5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V1coxFig4hEI+J2S8eU1nwqmcOFzIYQWWHao7bN6KUJpWmIqXCvf52Vzs9yHx6uJ2
	 OoKZmsirjH+h7bLGUY8IilWPyZq3gFd5aD1GzAAY6mRvWUfgm2KA1PtFniyD3F2fCp
	 p+tTUoPqNGVWTt8YHZAnuBo8PUgCFs9Vd+GEyX94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391725AbfAKO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 09:58:29 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43193 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389843AbfAKO6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:58:24 -0500
Received: by mail-oi1-f194.google.com with SMTP id u18so12390654oie.10;
        Fri, 11 Jan 2019 06:58:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ds23Kc4NbLJYAPLR+KmNeecEzQBYJ4yctQTt7YXJ13Q=;
        b=R9LleeBV36zm7FyP3k1hYshPyXPwc5R0I5pxygSSyXDtSOYbLSUUXDa1Zzo48g6WE3
         c4kQg9A6aANkOWdTNuZDmSMrGGU+aQpIOS864vdHIYP77kIbypQka/rsorm3GVmjkGw9
         uTBeJ4+Pz+lnSgM/eYyRns89zcFE9SMJOysMgJiutNxdhqw7ZI+4nfmLZqp/x4ogc+kj
         7eewb1tX6J4SVxlr/YolOQaGruKFGDlcp13/4RDcjVGRX+b1bu5kOlVTk/8ogg4TENnl
         m6D3Oz6fiJ6/DCRTVWHJlcg3LVjAufrpaGnE855EI12Br8U1teMt41b25OvVOb0Lc9nN
         WokQ==
X-Gm-Message-State: AJcUukdAq0lygLyctpHUbp6Honmo8TxYfgQxJYhS3EjXZAg71YU5oKsQ
        yh5dBZeGa28oDEAOigkwqw==
X-Google-Smtp-Source: ALg8bN7ds9LSvRfrJD7MU0qK2pPHyEmsatuDj3+W6hbmoC1qaq1dlOr/UVD+djOSk6uc0RMct8cHOw==
X-Received: by 2002:aca:c2c3:: with SMTP id s186mr9687526oif.173.1547218703091;
        Fri, 11 Jan 2019 06:58:23 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t8sm36295060otp.69.2019.01.11.06.58.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 06:58:22 -0800 (PST)
Date:   Fri, 11 Jan 2019 08:58:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, arnd@arndb.de,
        yingjoe.chen@mediatek.com, yong.wu@mediatek.com,
        youlin.pei@mediatek.com, Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH 01/13] dt-binding: mediatek: Get rid of mediatek,larb for
 multimedia HW
Message-ID: <20190111145821.GA32150@bogus>
References: <1546318276-18993-1-git-send-email-yong.wu@mediatek.com>
 <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546318276-18993-2-git-send-email-yong.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jan 2019 12:51:04 +0800, Yong Wu wrote:
> After adding device_link between the consumer with the smi-larbs,
> if the consumer call its owner pm_runtime_get(_sync), the
> pm_runtime_get(_sync) of smi-larb and smi-common will be called
> automatically. Thus, the consumer don't need the property.
> 
> And IOMMU also know which larb this consumer connects with from
> iommu id in the "iommus=" property.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> I guess it should go through Matthias's tree if the patch is ok,
> thus I don't separate to different patches. If it's really needed,
> please feel free to tell me.
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt       | 9 ---------
>  .../devicetree/bindings/media/mediatek-jpeg-decoder.txt          | 4 ----
>  Documentation/devicetree/bindings/media/mediatek-mdp.txt         | 8 --------
>  Documentation/devicetree/bindings/media/mediatek-vcodec.txt      | 4 ----
>  4 files changed, 25 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
