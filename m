Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78CC5ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F838214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 18:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH5QtRHZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F838214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeIQXi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 19:38:29 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33449 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIQXi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 19:38:29 -0400
Received: by mail-yb1-f193.google.com with SMTP id y9-v6so4146967ybh.0;
        Mon, 17 Sep 2018 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eX5KDtEAj+eVU/2cXHu622QzEWm1V+H9eVTxqUyYC4E=;
        b=dH5QtRHZJTy8jb7ekPi85r1/LLNaPcT/kS4fMD4IIe4HfT1U8UX+S+KNMW6uIw4hBF
         cR9wwHiBYLqakkYMlWA+CpV0AWXJZGvRtvYz4QOsnTOHJpBaP7xDsL9kAQ3/WePUDd8M
         Gu71/ilr6dbdN9GVkda86xpRYx6keTxfbgcKtqZfZF2OAoHFkYVPu3ClJSWo+vb/skeu
         NvVmaTT9npVo7+PCFl0bBIGsa9Y9aCzOqS907qKuHz4/Vqkeyol8hzsgZ3+TLLaDYhi2
         n2+KrmGWcDSGFCnBpGAzSbNZvMpEC0knlKCxjXTO4dLOlXOZsQ7NPWkPSTk37LQ2hD90
         6C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eX5KDtEAj+eVU/2cXHu622QzEWm1V+H9eVTxqUyYC4E=;
        b=EWnHkqpl0jRaQXXSvWv6hrWzvt+ZJz4furZ1I40iw9s4dEhb2QsYeSgedi3d0GvgVC
         71Aadn2v87y8RSrPVV+5v7wsrC4awjvUJhH18INkdtx27YJXWJ8cT+RFJMudomwSGe/T
         5JGBFOY1A3PngYAf8dxCQIm7SwaaHV0IRpS/GRkiKbjut3ZtsoMtVY9LTXv2cTZAenfs
         YgJjWxM7bdWL2l+7bA58YZ2uAA+ouZooA+r6KENMTa4Ab5pc/eWZgid4hyjGmEgjXbBS
         hAW16aTTgNpEw+dPsyBaFMSShlzt9IOiI/F+k2mPnZJAeI5usPBLsbvLXiVNuxlaun2U
         DB3A==
X-Gm-Message-State: APzg51Dzibf3ZdOLbeB4XRDFN6QQnFM+SFXSqu635hEmoyagPuambmnz
        JKv71WzNgszLYzta2icdy2Q=
X-Google-Smtp-Source: ANB0VdYA004Q+QIU1q2ZeYFsJhobLd6hsv//DlGCjZb2sa8RM8brtNtZ9xMwbwMkziYHzMnM9G+hTg==
X-Received: by 2002:a25:2ce:: with SMTP id 197-v6mr10704705ybc.215.1537207799879;
        Mon, 17 Sep 2018 11:09:59 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id y144-v6sm8008914ywy.79.2018.09.17.11.09.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 11:09:58 -0700 (PDT)
Date:   Mon, 17 Sep 2018 11:09:56 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-input@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Subject: Re: [PATCH V2] input: egalax_ts: add system wakeup support
Message-ID: <20180917180956.GC104770@dtor-ws>
References: <1536204258-433-1-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5DzYBz3U=RT-HzzK5KMMnYipceCWh9eYuYRmBctkRZ_=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DzYBz3U=RT-HzzK5KMMnYipceCWh9eYuYRmBctkRZ_=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 06, 2018 at 01:46:32PM -0300, Fabio Estevam wrote:
> On Thu, Sep 6, 2018 at 12:24 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> > This patch adds wakeup function support for egalax touch
> > screen, if "wakeup-source" is added to device tree's egalax
> > touch screen node, the wakeup function will be enabled, and
> > egalax touch screen will be able to wakeup system from suspend.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thank you.

-- 
Dmitry
