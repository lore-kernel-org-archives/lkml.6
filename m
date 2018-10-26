Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9E9C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9B642082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 08:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7T3hZCZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B642082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbeJZRZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 13:25:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44745 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeJZRZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 13:25:36 -0400
Received: by mail-lj1-f194.google.com with SMTP id v6-v6so372133ljc.11;
        Fri, 26 Oct 2018 01:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Oos/QDDzB3DHvuIok2DumIAW+2LqZJtC5YQ5ETc1f7s=;
        b=S7T3hZCZ38uBSbRmeHo2tcuIkwfJoBBHxjsY0jsFYg04ZbzI2A6ZxAxryjcZuxG5Ny
         6XpO6zpG8p8Ao8VHBkTg2nB8rUSah2Kc0e2qYc5NyD1hrxMZum4f4szw6p8gEMNg/zS2
         6RfZflZU3cV7fY5BJAhaM48yK4/Rw3cTRc7+ycW7/ec1507j4c4o8KrMifJOcd3/APbM
         5DYlBDHC05nPjiomDuAM3dAK/Q9E/u1IsJNCLtRZYYGLpyLjQUQHM9BcVO/4TIxaHynt
         DIZLKUCsiNUwIy8ba6DKDJ2GMSyd6vRQCi1c1mWCs8RmreiNtJyx2SCIQs+KVhlYNIvo
         WOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Oos/QDDzB3DHvuIok2DumIAW+2LqZJtC5YQ5ETc1f7s=;
        b=ml2rloILCYTP00uCiIpoDIt4VzxvLL7Et2eTy8v9xTfT5SuWJMgZkRn7PrzCv/BCa5
         FvIyVkkMmYdlEPXJ/34Kk2P5pVIKW9HoI8Diliyu/pjriPvH8hoGPnlhdgbrCL7rs51f
         oUAentskXUgnk2BmtH9LCmr7YYn+QpGo61fldW09dZIpVAR7j8w+fp7rqHeXDsGYY/O3
         josIgKA7FllGL8jM4Cn9nSMCBoRH5LeVgGGEt/4zr8CP+NNHsH1nih36CMeWuzBNEA4L
         VHLf7+GEBTaR0ItpB5yRWAicDGk0UPp4SaN/sitDGNT/v/l1qgjd2R0VYdpbW/8rtDEw
         ORPQ==
X-Gm-Message-State: AGRZ1gKt0oYJb05YasbvYV9MdxBuakygkFS0Oqepm1jiKEwshgK0NbSK
        dv8LmlPNKn+d4W4/KgCbczI=
X-Google-Smtp-Source: AJdET5cwcWtzQoIs80RvHLH62LbX+X+PcvsEkKxpAjyOR8veZLIndlDaqMCz8uzqqI2Xr5rj259sKA==
X-Received: by 2002:a2e:21d2:: with SMTP id h79-v6mr1772122lji.46.1540543763585;
        Fri, 26 Oct 2018 01:49:23 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i185-v6sm1662843lfg.89.2018.10.26.01.49.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 01:49:22 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gFxo0-0003Vk-3G; Fri, 26 Oct 2018 10:49:20 +0200
Date:   Fri, 26 Oct 2018 10:49:20 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH AUTOSEL 3.18 04/98] USB: qcserial: Fix support for HP
 lt4112 LTE/HSPA+ Gobi 4G Modem
Message-ID: <20181026084920.GB27852@localhost>
References: <20181025141853.214051-1-sashal@kernel.org>
 <20181025141853.214051-4-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181025141853.214051-4-sashal@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:17:19AM -0400, Sasha Levin wrote:
> From: Bjørn Mork <bjorn@mork.no>
> 
> [ Upstream commit 59536da34513c594af2a6fd35ba65ea45b6960a1 ]
> 
> The DEVICE_HWI type was added under the faulty assumption that Huawei
> devices based on Qualcomm chipsets and firmware use the static USB
> interface numbering known from Gobi devices.  But this model does
> not apply to Huawei devices like the HP branded lt4112 (Huawei me906e).
> Huawei firmwares will dynamically assign interface numbers. Functions
> are renumbered when the firmware is reconfigured.
> 
> Fix by changing the DEVICE_HWI type to use a simplified version
> of Huawei's subclass + protocol scheme: Blacklisting known network
> interface combinations and assuming the rest are serial.
> 
> Reported-and-tested-by: Muri Nicanor <muri+libqmi@immerda.ch>
> Tested-by: Martin Hauke <mardnh@gmx.de>
> Cc: <stable@vger.kernel.org>
> Fixes: e7181d005e84 ("USB: qcserial: Add support for HP lt4112 LTE/HSPA+ Gobi 4G Modem")
> Signed-off-by: Bjørn Mork <bjorn@mork.no>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This one is interesting though; it was marked for stable and has a
proper fixes tag for a commit that went into 4.19. That patch in turn
had a stable tag (new device id type patch) and was backported also to
other active stable trees at the time.

Guess the stable maintainers need to check if the offending patch has
already been backported when determining how far back to apply a follow
up fix.

Note that the stable tag above lacks a version comment (e.g. "# 4.19"),
but I can see how that may be too subtle to convey this (and not all
maintainers use those). Perhaps an explicit comment should just be added
in such cases.

Thanks,
Johan
