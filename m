Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DABC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABB420869
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 13:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VchbfS3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbfBHNqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 08:46:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43875 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfBHNqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 08:46:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so1597607pgk.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 05:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=svccdGBU4GInpKslsxGYDe6G5CFTOm70WAMXg8Ntgxk=;
        b=VchbfS3K5z9Zu8uTz0iSGBRDatdz4eT8uZpQtv+X5yarT0mc9Gi46AJCcuGm6KH51o
         rWaczIkQD96WPsw9AZJAjQDdHgN8CWw87eiCwKVnMqVN/NV/UiQkM+bFK1Mu1nue0RpH
         xJoAREe1+by2dgNOU9P7yZB/Zd1BunJZiPkk6AUUj2ap7kp+pZSbDp92eAZxEDj/12Im
         K1koLDilpZoKlYLTaudy/RW4Xsi0la0qoX8o8UgFNulAWzOisSB/EmPO3VJVlw90SkR0
         6G24T2NQAS9iS1+rFS9r+mONRpCtXfx7kcYnzkchnced/wivlmdb9L6ehIgnuuwgrbLQ
         X+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=svccdGBU4GInpKslsxGYDe6G5CFTOm70WAMXg8Ntgxk=;
        b=dzh45puJ+VbM8Z9Q/XFo/N6iyii/Z/pXMFJn65ts2rjuk9SmuivWnseJoZ/Yp4cUrt
         ZewW0Hj6JIc/tvEcnQERxkgA5hvrc19GtM/464iJ3VeItffw2GXTgpUK9DyQKKJUA/RU
         atNjMPjCd8ou3P/yK0SnatK1bacdS6iL1GWaF/krZESbvW2LIo7ipU/EwcUtAUGkUsjI
         UPyfM9Tk8OkkULGDmxKR1vTtSbXCwt2fnLD/yvEZrD8fhHEqCPOnABFFn0ZJyNgiMU5w
         bChcoJdKvXZguE4iiPgcTWY1td4C0OKS/7VVNC8rdXEC55ou0zx+cNx50Yw+wD4pznLe
         3YAA==
X-Gm-Message-State: AHQUAuZxWd0CVhLeL2lOoBGM/y/PF+GA7afewTaQbf8C3YAWuKvxJeVJ
        +iZhnZbDhV69EMeG7EeYp5x9kg==
X-Google-Smtp-Source: AHgI3IYAyWAzW2v37IGBLG8V/B2ChJPeuUKgnUdufTnSzup0YkCLABzQyo+IPIoPILDmSZG3k8nidg==
X-Received: by 2002:a63:fc4d:: with SMTP id r13mr20693075pgk.242.1549633560046;
        Fri, 08 Feb 2019 05:46:00 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f67sm3052409pfc.141.2019.02.08.05.45.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 05:45:59 -0800 (PST)
Subject: Re: [PATCH] ata: macio: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-ide@vger.kernel.org
References: <20181205195050.4759-4-robh@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4bca6415-36d1-f7f6-7208-2e4b1c3ea778@kernel.dk>
Date:   Fri, 8 Feb 2019 06:45:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181205195050.4759-4-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 12:50 PM, Rob Herring wrote:
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.

Applied, thanks.

-- 
Jens Axboe

