Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1D5C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D140C2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 03:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="euzkdXok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D140C2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbeIKIbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 04:31:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbeIKIbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 04:31:24 -0400
Received: from [192.168.1.75] (cpe-24-28-70-126.austin.res.rr.com [24.28.70.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940D220839;
        Tue, 11 Sep 2018 03:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536636852;
        bh=cg6K6UNPv6Xcyz2NuGpoAomuSw8XvOX3aCFAlp3vSWs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=euzkdXok4/72t55H56lG4nw9WAjhX+qohwQtwp81cA45zb8ZO5LSuAprMOtKa3hmC
         wY38sPP/73kM39LvzfOk1byGeB99trXQW6ZvwB3YZa2dfUI5a0tL+KtiXqfmp4zQPd
         7rUd5TV+6bev+A9j4d+pImRPDxVrd928OBL9RnT8=
Subject: Re: [PATCH 21/21] fbdev: fsl-diu: get cpu node with of_get_cpu_node
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180905193738.19325-1-robh@kernel.org>
 <20180905193738.19325-22-robh@kernel.org>
From:   Timur Tabi <timur@kernel.org>
Message-ID: <bc758dcc-c881-ab7e-129f-8a1a1c628daa@kernel.org>
Date:   Mon, 10 Sep 2018 22:34:10 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180905193738.19325-22-robh@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/18 2:37 PM, Rob Herring wrote:
>   #ifdef CONFIG_NOT_COHERENT_CACHE
> -	np = of_find_node_by_type(NULL, "cpu");
> +	np = of_get_cpu_node(0, NULL);

This #ifdef means that it's only compiled on an MPC5121, which is a very 
dead platform.  of_get_cpu_node() looks okay to me, but I'm going to 
have to assume that you know what you're doing.

Acked-by: Timur Tabi <timur@kernel.org>
