Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFC4C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF9A120896
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF9A120896
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbeKNF2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:28:38 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:36336 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNF2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:28:37 -0500
Received: by mail-ed1-f66.google.com with SMTP id f23so2291553edb.3;
        Tue, 13 Nov 2018 11:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x4bv99RcUAgyl5AO6ZXBhcK9DIQPCRgKRXe1kEV+lX4=;
        b=mS0wPwqir/n1DwaKhb2srct4akkOyFl2Q9iGkH/6uRoGd2jhCtTWOYo5iZK1Fn8Hcg
         w5Usr1lb6ONa7YSIi2GDUWRiMiUsxXzvy1ObZLsmHn2bk//O92aV+cpbgtdUrKQMV1yO
         2CQns9H5NLt6qGsKdmmPdtB/JJd2WHRh7R0HLN2pGlransWEninOZPhBvWjvUW1H93hY
         hy+pLK7e3d1D8/krR5R2TGnv8N7hxqvsRYVXht2FUKrk/6HC74r7voLCXa7nwiQB8C6l
         J8TkkzdJq1NorDxB5w/BFwrV3PGA8EAaB9DINmWtoZDAuMUgKVW7ZGZ2j+bTTBgKZiNb
         phwA==
X-Gm-Message-State: AGRZ1gKz/eDef6EjrEo2xt2MGIXMVyxvbHKG9LwzfNh+feB5i7kh9LXR
        gK16Sf8jPWU8OZpZNmDBPGg=
X-Google-Smtp-Source: AJdET5cvGFlJoN3r4yNuCSLZrs1doTk5xfHZKsnbsTc3O3ExI2JxHm9nkc2qM3i5aV33C8YpLbNXnw==
X-Received: by 2002:aa7:c483:: with SMTP id m3-v6mr16789766edq.205.1542137344158;
        Tue, 13 Nov 2018 11:29:04 -0800 (PST)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id a13-v6sm1095217ejt.69.2018.11.13.11.29.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Nov 2018 11:29:03 -0800 (PST)
Date:   Tue, 13 Nov 2018 20:29:01 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCHv5 1/6] ARM: dts: exynos: Added UHS-I bus speed support
Message-ID: <20181113192901.GB2418@kozik-lap>
References: <20180927140738.1006-1-linux.amoon@gmail.com>
 <20180927140738.1006-2-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180927140738.1006-2-linux.amoon@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:07:33PM +0000, Anand Moon wrote:
> Added support for UHS-I bus speed tuning for SDR50, DDR50 SDR104.
> 

Thanks, applied.

Best regards,
Krzysztof

