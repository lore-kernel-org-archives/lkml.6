Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E56C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AAD2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 09:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547372064;
	bh=tTmbG0fKjhYeY/6+BJTkustCMvgaIqQSPc2wC6EvWCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TcM0FOct/crQhwVgxiEu40hu2zK3efV47nTlLHnIvrq3jUCSwWcWCL2XORNFhIheq
	 F4N19xzY5yuNvjy5z7mHQljYRywRyU6Qa2PB89L9ZImuhUDE+1N7iJMGrvzveMhnaN
	 a2iSHNNPKwBwzOvSewwF/F0xOMK2v/qztoWtR82M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfAMJeY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 04:34:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36398 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfAMJeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 04:34:23 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so16383201edb.3;
        Sun, 13 Jan 2019 01:34:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bqtD+IZ9XT8e+fGQkEeRwvV8GURM2V1wPqLQ2hCv1EU=;
        b=TTy3FA8WtesK6fo6GRECeuTCw+H+v/1EXn6Su+0yaxTKNbLVisqy35QnTm6pjBLKHx
         sP+8pY1f7zcA9mAeGgFb4nIwsgLUW+KoHDg5OdPuyDNsxY8N9gdb+H2WacHifAcawkng
         lX5uST1dgIz4XAHWsBIC+E429uRQz6MC2MW39zqSxFBNGds+Jwhgvt18/C11e5OxvfTs
         gutykv2EW8kPHO1u+99/yjQLQPsuUS6EMIGBoAIOXpoRDJLxDTbNrgs7x+PwhLgQRGEn
         u1/vbKWCwwQwwa1wzV8zczyOuUGCRlX+dPch8uIycT77RF3TUISGrinpmb3UKm6/FRKD
         zpTw==
X-Gm-Message-State: AJcUukeY0VyKSHfl03KJKrWmGFiMJuo6mtuR1SEKUhutih8Nr1wwm9pk
        8pFJCdKT972tjqzqSOyXzm8=
X-Google-Smtp-Source: ALg8bN5AE0So5HzFbet1Co/Lm594Nx/S201oca+dq0qIQG9W2aj62PRAxT06LnMYNrIrq1qd0zXwkw==
X-Received: by 2002:a17:906:948d:: with SMTP id t13-v6mr16591106ejx.119.1547372060972;
        Sun, 13 Jan 2019 01:34:20 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id c29sm3490630eda.75.2019.01.13.01.34.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 01:34:19 -0800 (PST)
Date:   Sun, 13 Jan 2019 10:34:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     kgene@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ARM: defconfig: s5pv210: Add cpufreq support
Message-ID: <20190113093416.GA27934@kozik-lap>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
 <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20190110205215.22030-5-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 09:52:15PM +0100, Paweł Chmiel wrote:
> This commit enables cpufreq support for all s5pv210 devices.
> 
> Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  arch/arm/configs/s5pv210_defconfig | 6 ++++++

Thanks, applied.

Best regards,
Krzysztof

