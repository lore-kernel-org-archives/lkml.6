Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEADBC46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19822150B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:38:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="deYyDn2q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19822150B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbeHNU06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:26:58 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36378 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731128AbeHNU04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:26:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id b22-v6so14377999lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 10:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LdkJsXxork4zbdPXeokRTdP8Q3kmFtHpkeuzsbdneZM=;
        b=deYyDn2qgulT5IFJxTAfBe7vH0isw53KaaRhvfTBJrS0emcg7R9h/QXlUh8sqn6ARM
         m/eHf7lONcpYWkOdbgf5ZaAfqhyBC2kpYbBVc+cpBngukXg8QSXb3lqc6Is7wzIjU5ff
         iMnWjGqZzlUIxvJ76N0Z0o3ntjibyjqqojD7RtlYdS4wEYiXZhXFgyTdvhBqhmmRmvbh
         3Cft3oiDRu9f6qTTQfxLcH0KT0e1/u0pFeE8lDv/E3/M9hVVc9ELg06L4WtR3xwSXOLl
         36sjVfihwOcTOOSl4SC0N/F3cWFb7sGmfQeKr+2NzUQWo7F3pIOtu0Z3qPqeIpG+30U7
         FfNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LdkJsXxork4zbdPXeokRTdP8Q3kmFtHpkeuzsbdneZM=;
        b=M2JMhra4w2YvoyinyaLX4UQOf7xHWVvCrpmiAoYEgV2YkjqwJZkf0ShiTIp+k5yc0i
         7ZyGFYOB7khAW3Gh1LF02Ii4gluJF2I0ViRoeLxsUWzvyScgKKB69gKhrGizxvnnEOc4
         1himr40x1+hIXfPwON60mHeWomkV5Po2qGlbTZUdhWf6f4Miw0aGPXIuMFzXW0/mG9jt
         SoXIkCUgur777QxFp733dtqIFk74APAmjrV2XG5hTAM0SYM6ShPCswSm1nf58f7j3ZBd
         j/sXfGFL8y51+TbO+ue5CQtkSsKDtEqFB2pOa75uCop+CQGL5FatxG7M1KZL45HC2Nyn
         wPAQ==
X-Gm-Message-State: AOUpUlGilorQFcj2vslmzK3cRCMpHC8cGqM+PckQj4KxOZqKeVUG7DGp
        DSv9PNAM94aOI7Nx/Mr8JqPMTQ==
X-Google-Smtp-Source: AA+uWPw6NfpehRv4ZainYNqjNwN89Ize6bnyEmkDHhxrMg7fkoTJIiv8ykkRAox+bHTpWjXsihc2Rg==
X-Received: by 2002:a19:db44:: with SMTP id s65-v6mr14777051lfg.109.1534268326125;
        Tue, 14 Aug 2018 10:38:46 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.12])
        by smtp.gmail.com with ESMTPSA id x65-v6sm3966806lfa.77.2018.08.14.10.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 10:38:45 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: net: ravb: Add support for r8a774a1 SoC
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Biju Das <biju.das@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>
References: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <e618c6ea-377d-b45e-5788-b29254a97c70@cogentembedded.com>
Date:   Tue, 14 Aug 2018 20:38:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1534250017-15725-1-git-send-email-fabrizio.castro@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08/14/2018 03:33 PM, Fabrizio Castro wrote:

> Document RZ/G2M (R8A774A1) SoC bindings.
> 
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Biju Das <biju.das@bp.renesas.com>
[...]

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
