Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 042D3ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:32:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989CC2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 21:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEVC0xMZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989CC2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbeIOCtB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 22:49:01 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:45139 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbeIOCtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 22:49:01 -0400
Received: by mail-pl1-f194.google.com with SMTP id j8-v6so4732478pll.12;
        Fri, 14 Sep 2018 14:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i8yH7qjrpguSj17orwhEttY6z1qHIGEBO3/u1wKoBCo=;
        b=AEVC0xMZqBnSmpYVPt1fGgN479YpqsaGuV5qhHErjsXOHHIe/jPoX/YtVg2SuDk9Se
         IcrC7kkOqJmXerDISdUQhgf1gIHZpJjp6SV37bqC/+UdnbbaNSwtXJoEaIfM+Fw8Yw1p
         quw0G84CGUs3ZLEuACjoY0hWXs1jHfsnWKu9M8LuwGi3+hB2Hb1tRpiqmROpnwDuhZC+
         eaf5v7NsQdwTZEwGQ7rpKFVsFAv956GTjcfOtzLuqNBXLraeCQI3TBnurCi0UBPu0luE
         OSj6DYIPu9kIFCT0UIhDfzMLgnAovPKl+KUuyxpXTg07SbVMvvgvmrIb78l7pD2JznlN
         rIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i8yH7qjrpguSj17orwhEttY6z1qHIGEBO3/u1wKoBCo=;
        b=aoeJlm1St35nm7zN4i9qUSK+63EswZ5HA07mdRV/dYHpKKKQ7iuYt43lgXPz6mNCoo
         qrPAwiXXwuOKeFdcRf3c2qySXzGrVGBoKMEhxQd7bIZL/OvT8PYCg8+wR9ZQgw4NZm//
         KYUV+V4X0nK11f0MJe76dfNc1uUHBkVjZ1RAHzhIRSZWU6epKMwPDJjUVy5bbJF48+uf
         bTvaKNKnSIa439SVUAexkqmrBOHRUuM4aTASWNnUvnalADSG8LyEvCOlSMxvJD/nW0p3
         nGwBu6YJAVIR+5ImGRQn+AnZRe7Uiq3vT/d4WjZHZsuBjSTn0FhlFV1RHmx93G6wKnQb
         6tQw==
X-Gm-Message-State: APzg51DPSX/sVh4lKdHWnR+15Pr6X98Ci6iN7prki6ORDie7nuXaMF/V
        S79IMfmJfCcfsRybDHWBoQM=
X-Google-Smtp-Source: ANB0VdbBld6B7SDJZHb28HQqQCOLdeW0D+cXRlAmhSq0JqOt1N+k5ldLnmpGMSZV0ACtCCLIfdioxQ==
X-Received: by 2002:a17:902:b702:: with SMTP id d2-v6mr14126582pls.12.1536960765003;
        Fri, 14 Sep 2018 14:32:45 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id l9-v6sm10278185pgg.79.2018.09.14.14.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 14:32:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
Date:   Fri, 14 Sep 2018 14:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180913202828.15372-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/13/18 13:28, Rob Herring wrote:
> Major changes are I2C and SPI bus checks, YAML output format (for
> future validation), some new libfdt functions, and more libfdt
> validation of dtbs.
> 
> The YAML addition adds an optional dependency on libyaml. pkg-config is
> used to test for it and pkg-config became a kconfig dependency in 4.18.

For Ubuntu, the libyaml dependency is provided by the packages:

   libyaml-0-2
   libyaml-dev


-Frank

> 
> This adds the following commits from upstream:
> 
> c86da84d30e4 Add support for YAML encoded output
> 361b5e7d8067 Make type_marker_length helper public


< snip >
