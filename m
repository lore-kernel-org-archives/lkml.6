Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1857C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16CB20879
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 13:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547385776;
	bh=DtPtSF09ygowHiUg2EqJ5/w1vvdRguuS65otrTu3SFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WDgMop08s3AodIFNL3aqK1Zy90dU6+rZTucAdg6+66Cv8YjrZsn75ZkLb7iznF6yq
	 iSNn5AVaDDlGEd1jLsqlM2m2TN854YXzFqTFh9/L7g4UnW2yOlknMt7/Nckjg6AxgH
	 a9Fp1mYOyuliJHSeMNcr2JjoOaw45Hna7Y1YWKu4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfAMNWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 08:22:55 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41970 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfAMNWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 08:22:55 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so16587274edc.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 05:22:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VHmB96XoXSwREI2y9h3Q+mZE3skqKkWOZJ+sbX0/fQU=;
        b=I5sX7uUoUHE70AT20eVtP4BStYwK3tKB+S7VnkKMcKfwhj0MSoVQorbB16dcgn7X6G
         UQJh4TnRJENs8MkEtR2fvKn9XgAghHNhj35guM5khg8ve22xOD8cn8MW9Nhw7+eZk+lE
         nmt13/fmJGTRYIWo70TNW8qBqw5BiDq+YhYLPmGSP8GW8KXQ2CwH17qWizubmHsub2C6
         iRTJFO3QBj84BQcWT3IBMjFN3uF+HPtoLqAmQQ8kjswxdVxwOd+jHz/a+r+rIvF8QjoD
         FCIOA6TYg+qFH2sW3+t404etLDJ3VzHPFRheEt6E14/Tjbqa+8o07ajMhjZ5VF9h4ajS
         VK2w==
X-Gm-Message-State: AJcUukfwSjR57WsnMyGZq9KdxZB/4mQGV+Yyf6ahmMtjZJS9TTc1aPOR
        1YXvhUE8OcuFKt6H9FMxrG+Fgt5GkTc=
X-Google-Smtp-Source: ALg8bN4eGz94sJRL5ZzHa/iO2FIXX91HU6zUBXwPDU6tz88v7kTWJE1u8wrsxyG2rkyNUdv1PXRsQg==
X-Received: by 2002:a50:d643:: with SMTP id c3mr18952890edj.178.1547385773904;
        Sun, 13 Jan 2019 05:22:53 -0800 (PST)
Received: from kozik-lap ([194.230.155.148])
        by smtp.googlemail.com with ESMTPSA id z16-v6sm2087234eju.61.2019.01.13.05.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 Jan 2019 05:22:53 -0800 (PST)
Date:   Sun, 13 Jan 2019 14:22:51 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: max14577: Remove redundant MODULE_ALIAS
Message-ID: <20190113132251.GA7439@kozik-lap>
References: <20190111025822.17196-1-axel.lin@ingics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190111025822.17196-1-axel.lin@ingics.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 10:58:22AM +0800, Axel Lin wrote:
> The modalias is set by the MODULE_DEVICE_TABLE, thus remove redundant
> MODULE_ALIAS.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/regulator/max14577-regulator.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

