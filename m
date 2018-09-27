Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BBBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413A0216FA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 14:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QwekoyYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413A0216FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbeI0Ukn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 16:40:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34721 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbeI0Ukm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 16:40:42 -0400
Received: by mail-wm1-f66.google.com with SMTP id y3-v6so3482969wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 07:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RIMOhP99oZEWXAS56EVOJYazh1Tu320j2y4RTrcz5WE=;
        b=QwekoyYZ1RFQ9QYId5CotAP2zMV6z/XEBS4zawGgziZ+Xew2Unr0/8WoEyI6lkftaK
         LkUsWripL79+9hnpZuqyqOiw72P3HUv9+5vjB1F1AO1KuwB58G4kvM4lVj0ylA6DuTTa
         8OOG3rVhlSMa9fTv32yXJoTG4kuovWlJtfsnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RIMOhP99oZEWXAS56EVOJYazh1Tu320j2y4RTrcz5WE=;
        b=athOFEPiMYb/Kr7VA++fHi2Uk9dUn3smHT5B3CmoO/PY6ai6GT2+WLtmYm6nrZ/8fg
         ucenR3bwNDihGx7M1qOI9fNJKLjX8/e/RdvNGdDt68wzC1PLtKVE2ngzJ2jUYc7YDfnp
         WE38TwQgW8O4mCd5+k5EyqqlSdFoLeq/VCWKzeSJogk3881lMyl70LBMLVDLAoXCDK+F
         LmAT2mDuyjh3jv4CMDYRWy94t6RDVS7L+GUVJvWIXmXB5suKoHMgD/QBEdV1EFDiN2bV
         u/+MNUjAe4ih7EJXfQ5qfDzgsgM5CByKliG4PWW1iKa0Nl8Y0yNMhdAhkSTn8FgpczQx
         gYFA==
X-Gm-Message-State: ABuFfohmAbPyFTWVN64TB8qDFI4vJ97JYduSm1NzmMb+kugqfNWFk1Lk
        otY4698DUR2Pd8CPITJShMIUeg==
X-Google-Smtp-Source: ACcGV63irCcrEWiTEae5jsZZBUV5oAoNJ61uJ9W63fuRt0pPetkDeN6KHskWxG7nIBMjhrQkLrgH2g==
X-Received: by 2002:a1c:3b89:: with SMTP id i131-v6mr4905095wma.27.1538058131085;
        Thu, 27 Sep 2018 07:22:11 -0700 (PDT)
Received: from [192.168.0.41] (30.216.136.77.rev.sfr.net. [77.136.216.30])
        by smtp.googlemail.com with ESMTPSA id k63-v6sm3604787wmd.46.2018.09.27.07.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Sep 2018 07:22:10 -0700 (PDT)
Subject: Re: [PATCH] clocksource: dw_apb: add reset control
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Marek Vasut <marex@denx.de>
References: <1537195934-26035-1-git-send-email-dinguyen@kernel.org>
 <b99e898f-176f-b587-0d8e-eea18550f3da@linaro.org>
 <f21a4616-9ba5-f5c4-e294-976b8e88a27d@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0873e89e-ea01-e8b6-ade8-01a24bf93cc8@linaro.org>
Date:   Thu, 27 Sep 2018 16:22:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <f21a4616-9ba5-f5c4-e294-976b8e88a27d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/2018 15:52, Dinh Nguyen wrote:
> Add code to retrieve the reset property from the dw-apb timers and if
> the property is available, the safe operation is to assert the timer
> into reset, and followed by a deassert of the timer reset(brings the
> timer out of reset).
> 
> This patch is needed for systems where the bootloader has left the timer
> not used in reset.

Ok, I have updated the commit log.

I had to fix a trivial conflict. Let me know if you are all right with
the change.

  -- Daniel

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

