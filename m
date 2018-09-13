Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DE6FC6182
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C5620839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 22:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx/WmapQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C5620839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeIND3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 23:29:03 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:45593 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeIND3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 23:29:03 -0400
Received: by mail-pg1-f172.google.com with SMTP id x26-v6so3370604pge.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 15:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4g8qJ1QqNta82BSmUoz6Yixi5rJRz9gA4waFPh8DOI4=;
        b=lx/WmapQJZLxbZKUdaN3gGiW3mMtaMw4idhOfPsEjY/M5uKPEKT1IJPo5/seVSETN0
         jzF5uXmpiIDe9wTIkBrFTMq26Ectz3ZNjyl/dao4FhnPQZXmHcVcZUVhObX7LttFtD6v
         y9/rGqTjVZ0r4IOKiHgZl29u+S3lX+ko6aR5O0b3VXePO42QJ9pEdDs0kMqZOdz8F+7o
         yTAq+w/CgemklkX7/E+sao5Xj9AZ3n7FhhQ3Li+BQAG6KdtG6aoAHN2ncibeRlMmrdN4
         12PlhsAcfBaCLlle7ib4KZG8QrN94/eZIaU/siCw+b1U8XX+TPsOokS52/FjuQhCP2qs
         lx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4g8qJ1QqNta82BSmUoz6Yixi5rJRz9gA4waFPh8DOI4=;
        b=uDBplmlMYtf5QcuQgJQfOr3RNEohUNnff8fDf1LLaunb0jMCkgD5y1o4YA3dRNGYTV
         xRkwfOIQstLScMMtrlCGt27KXgqwuL32tbxpT5Yx2sUWGjrtZY1Nnq+l+bGBYq0uvBtV
         PUgcCI2cdjVFHTu0tezISjPeEZCZb2NT3upkqTIR1lxes9gxn0Wst1EEGQKXQMt7c/ym
         0NnXs7RwYjN+Bc2vp8jsqYADlG7We5xOaRuMaoJEXvnWo+lSGoNp70/+1/OinKluzGDZ
         K93bDbIAQABOM5s5ShnxRfymFw8fcXUNt6dfGpHfTNVPfR6VHarkFWAnk/ogT7zEI84o
         eV2w==
X-Gm-Message-State: APzg51ACh8qeO7hxnen4KvPSmDvhvptSVmp6dUkp6IgyiYa+OnqDMAHg
        CQkgbIqUTvXcCYbiIErQpLU=
X-Google-Smtp-Source: ANB0Vdag2rBJJ4TNFvDAy34phGHDWd0szbReupNi7CVjoctbCuu3gdemWBlX6qTbgC2ZsXa/CL5LKQ==
X-Received: by 2002:a63:7511:: with SMTP id q17-v6mr9007226pgc.144.1536877057303;
        Thu, 13 Sep 2018 15:17:37 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id g6-v6sm6589964pgg.7.2018.09.13.15.17.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Sep 2018 15:17:35 -0700 (PDT)
Subject: Re: [GIT PULL 1/3] bcm2835-dt-next-2018-09-09
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <824f8cea-d80c-e2ec-11f1-154f97479fd2@gmail.com>
Date:   Thu, 13 Sep 2018 15:17:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536817833-3900-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/12/18 22:50, Stefan Wahren wrote:
> Hi Florian,
> 
> The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:
> 
>   Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)
> 
> are available in the git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2018-09-09
> 
> for you to fetch changes up to 6ef5bd6cfd5da9fe67aea031fd0a66ff77d64ad6:
> 
>   ARM: dts: bcm283x-rpi-lan7515: Enable Ethernet LEDs (2018-09-05 21:31:25 +0200)
> 
> ----------------------------------------------------------------
> This pull request brings in a board DT for the Raspberry Pi Compute
> Module 3, its I/O board and enables the Ethernet LEDs for the RPi 3B+.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Stefan!
-- 
Florian
