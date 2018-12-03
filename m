Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3816BC07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0036A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0036A2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbeLCXGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:06:48 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41817 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeLCXGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:06:47 -0500
Received: by mail-oi1-f196.google.com with SMTP id j21so12564126oii.8;
        Mon, 03 Dec 2018 15:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fykzt9+oasdrpA731GUHJsxFDYJLbtBr6RBAlsGsPoY=;
        b=ksymMWWP314R2AynJEtJQbh7APJAQj3cQ0iMAklAOZmk9mTza+GTyYEMKyeB9bA8b0
         CIKYmiyGQn37xhIPNisZUyFafT6k5T+AnXDW45ES4vFvwcH9I+p4Tkly9qcV5mckVFH7
         MqaGBnGmU16NRWheCfiqk0iBuS56sbMv4D4CIAM8NNddkQnAtkvyUMQd6/bLzahfd6b3
         AgD9JYQsE+5osK9sbdz0BsUdVOklb6DujeZ23yZ0gZ9+FbsDIft05hP7xUAE0O7ElBxW
         muHfZ6H/ImNpqBZXIryZOviUnP7FFYwrjw/K67eTTlp2UgJeLR/wWIyWaFCphdose+PJ
         GEgQ==
X-Gm-Message-State: AA+aEWZfVYWbomuQKsyqju+DNUurD5Wky2yrb88BsbiJI+2wK7z+dIYT
        t2X7y7DqHtHSk4IbmecqtA==
X-Google-Smtp-Source: AFSGD/Wa8PXjS5kg5/8uFA3PzaV0srzzLgfPcv/Y9iSFoT7SOgtkrEbBZAr+IyyudAvT3L+T2hr7Lg==
X-Received: by 2002:aca:3644:: with SMTP id d65mr11462277oia.336.1543878406800;
        Mon, 03 Dec 2018 15:06:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u18sm5614304otk.1.2018.12.03.15.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 15:06:45 -0800 (PST)
Date:   Mon, 3 Dec 2018 17:06:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jian Hu <jian.hu@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Yixun Lan <yixun.lan@amlogic.com>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: clk: meson-g12a: Add G12A EE Clock
 Bindings
Message-ID: <20181203230645.GA14522@bogus>
References: <1543498917-98605-1-git-send-email-jian.hu@amlogic.com>
 <1543498917-98605-2-git-send-email-jian.hu@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1543498917-98605-2-git-send-email-jian.hu@amlogic.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 09:41:56PM +0800, Jian Hu wrote:
> Add new clock controller compatible and dt-bingdings headers
> for the Everything-Else domain of the g12a SoC
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> ---
>  .../bindings/clock/amlogic,gxbb-clkc.txt           |  1 +
>  include/dt-bindings/clock/g12a-clkc.h              | 93 ++++++++++++++++++++++
>  2 files changed, 94 insertions(+)
>  create mode 100644 include/dt-bindings/clock/g12a-clkc.h

Please add acks/reviewed-bys when posting new versions.

Rob
