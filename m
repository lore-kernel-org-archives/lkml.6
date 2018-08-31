Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A09C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDB6F205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 23:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2dC7LmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDB6F205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbeIAEBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 00:01:39 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33725 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbeIAEBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 00:01:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id b92-v6so1091886plb.0;
        Fri, 31 Aug 2018 16:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lnRBRRhycMFY8cJyZapnS05C0/ZJVRJ/0e7Bnf2tjp8=;
        b=m2dC7LmEzgI8gY9cgppYrhGYBQWjp/Zo5kbU4/hvZ1Ow2veBz3dSkI6xzxpDB9MnQD
         UaaMPPC++dxTxDVkrHrVjvzzU95xufX5xmK21iOrAJXKUQftOghSX+3y5HcuyUrE1byK
         83Unx9h1UVTJRXt0RFJwm/Le4kYke7YCYzI5+uuUC5NXv67APDG3k9E5ey9Xz846uDv8
         3JfL54qusJKeZoQ3QT2jlw3l+Uye/GjUWSRsIvOfe+Z7qPoPaL9hEFeHW9FbSpmbvgd5
         3I+FOtfFWjWUoOqg7V7VdD2fbFcz6wSa5JjXVxHkCklU1ct1ICxm/cW3Ufw1if3N/x9O
         Jghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lnRBRRhycMFY8cJyZapnS05C0/ZJVRJ/0e7Bnf2tjp8=;
        b=leHwTE1LRGVqZT45lI74X5UarS7IsrNFcC4FHO7gbJIr/Q46hsdFX2DFw8Y6eAv8yn
         6Y20l22laaxkoWdyd+CAVASM50Tm/TDwCrm3c2Le4kJ3WkUbYHxET2SxDP1u/K8H8Z0f
         QgVAa7zZOeIsSn9VVFZFadq39eMNA1fZ3QXkcjG+YERgM3WDEHFtbAYXo1FS6dv4H8WK
         cK+Ib2eyYL5+CZdSvKzD/06qJjRdEYeEV/yapoRsbRi+vobGUoQxj4RUfKgjAs9rXyNy
         1tnizPHmHL3xKOTxTs5Kn8WUISmyqiLDcQ1aYl2zUq3Ygg/7xFGVuDVhHnKRJ5w/QOdR
         lWBg==
X-Gm-Message-State: APzg51BzQCtZ0nUK36k6pnihQSxd7v3YjANh0WiI7fqkAkOKApwzFOd8
        SOBq4lp1+RGdjjfuHxMONSs=
X-Google-Smtp-Source: ANB0VdaTnFv1yAhhSFd9mcW6ydSdexk6JTCR1jq6DARrckBqbKcSjtUDvYTTmbicLp+hXTS/YzxRqQ==
X-Received: by 2002:a17:902:7d83:: with SMTP id a3-v6mr17796514plm.0.1535759508443;
        Fri, 31 Aug 2018 16:51:48 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id s73-v6sm16816162pfi.154.2018.08.31.16.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 16:51:47 -0700 (PDT)
Subject: Re: [PATCH 0/4] of: Convert to using %pOFn for node name printf
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20180828155254.10709-1-robh@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <a9d5bee5-2066-85dd-9b93-272781120894@gmail.com>
Date:   Fri, 31 Aug 2018 16:51:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828155254.10709-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/28/18 08:52, Rob Herring wrote:
> This is the DT portion of converting node name printf's to use the 
> %pOFn format specifier rather than device_node.name. Patches for other 
> subsystems are independent and have been sent separately.
> 
> Rob
> 
> Rob Herring (4):
>   of/unittest: remove use of node name pointer in overlay high level
>     test
>   of/unittest: add printf tests for node name
>   of: Convert to using %pOFn instead of device_node.name
>   vsprintf: print OF node name using full_name
> 
>  drivers/of/device.c   |  4 ++--
>  drivers/of/of_mdio.c  | 12 ++++++------
>  drivers/of/of_numa.c  |  4 ++--
>  drivers/of/overlay.c  |  4 ++--
>  drivers/of/platform.c |  8 ++++----
>  drivers/of/unittest.c | 26 ++++++++++++++++----------
>  lib/vsprintf.c        |  9 +++++++--
>  7 files changed, 39 insertions(+), 28 deletions(-)
> 


Reviewed-by: Frank Rowand <frank.rowand@sony.com>
