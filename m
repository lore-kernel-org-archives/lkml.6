Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0C8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C2152184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 22:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ti8Lqx7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfAWWFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 17:05:49 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35829 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbfAWWFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 17:05:48 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so1857097plo.2;
        Wed, 23 Jan 2019 14:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NCmx4vV/ytUyGNTRZPT+LxZftL1H6vZPzRGbR/0MdYk=;
        b=Ti8Lqx7vPFbKhBCReOFc3ikOvU+dwYFBuMp2eLZMYvTWuEFPc4GS2Yq1fhuxx4/uFS
         TgywqMAsJQF9ckZmBGz5kf2Hgvuzo8DddL77qqKPlhKS4nJMHziEQb2wRfr0jO2jfBVK
         R/2o6LLymcsF1KxF+WcQnLvoHUTVNVDUQ8sh4V3gWpg0nRJDJwEgI3Lr04BR9sj9FJ9j
         Xt1oeZMoZ2/NODwRFsDxXH8QBwFhQQFock/N9dgP+wMj/ZCO+uOrkJIF7NZsdzJpV4xH
         IlLBYIR5nZPw+lpQUGEcFd0/Bbj72yTS86/ALh+LdlvCGpmNzsuUVDWv40x6k195utIr
         PssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NCmx4vV/ytUyGNTRZPT+LxZftL1H6vZPzRGbR/0MdYk=;
        b=S17JtPRcD3WgG9FRr0AIWEm/Db+hI3/Z4eyF7YnDiSfdJWaFan7Jrsv77Wo2rkOLid
         dkPTPydSv11NuhpDIrppjbDLKENP7cbM92qeOt0bIV18PhFvX4/iXRActa6buIj6Apfc
         hwsHW5E37VVYmlMLpNs3LrRc2LZIRmY7Sb0MCrGSpWZWTWRpbP2ATBAd/m8JCq4OgePS
         rI6OJuweqmZXPya5WQNXE7ib12z9s8Q8vYxC1xwCDxSWI09v2reHRYNIXjUa5NKUm1LQ
         TJz9G9i0mEGMLW5B07NxhfZj34h9fd8wuctZnPe35aci3In6sI2CIClJF8n41/VUCLfR
         OAYw==
X-Gm-Message-State: AJcUukdJ2kox5D6G1S0l3qbSppY1WJrUMVSp4cF3CNb/vknVZBQXHoR6
        2pN88OylJbBVa30sUCChkj8=
X-Google-Smtp-Source: ALg8bN4pT8s4JK8xhl9CXgQ/yUfdyZcXJrGF2rZGAdFjNzitLsbuLOYUBzDDbQxHJYQ3aczIVrekvQ==
X-Received: by 2002:a17:902:4601:: with SMTP id o1mr3993285pld.243.1548281147842;
        Wed, 23 Jan 2019 14:05:47 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id e187sm26412607pfa.130.2019.01.23.14.05.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 14:05:47 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:05:45 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/3] Revert "Input: olpc_apsp - enable the SP clock"
Message-ID: <20190123220545.GD179701@dtor-ws>
References: <20190121062255.551587-1-lkundrak@v3.sk>
 <20190121062255.551587-2-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121062255.551587-2-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 07:22:54AM +0100, Lubomir Rintel wrote:
> Turns out this is not such a great idea. Once the SP clock is disabled,
> it's not sufficient to just enable in order to bring the SP core back up.
> 
> It seems that the kernel has no business managing this clock. Just let
> the firmware keep it enabled.
> 
> This reverts commit ed22cee91a88c47e564478b012fdbcb079653499.
> 
> Link: https://lore.kernel.org/lkml/154783267051.169631.3197836544646625747@swboyd.mtv.corp.google.com/
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

OK, as clock folks say it is a bad idea it must be so. Merge though clk
tree?

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
