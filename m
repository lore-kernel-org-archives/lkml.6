Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF81FC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF5BB2190A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5DUpj/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbfBGOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 09:34:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41645 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbfBGOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 09:34:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id e27so21700lfj.8;
        Thu, 07 Feb 2019 06:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bi14hRYWHC7upKJfIV9T588ZuWq3hnId+F+5PsFU1Sk=;
        b=e5DUpj/I5jpz6S1Co6SUTj+fhbhgZTXu6bH/P//wlQ3CS9ye/UEUD1jgKLPK26ca6V
         1dq/h1WN3T0he2T4wHejtKBBXvefQLJLWxnxsCqUH5uS3Dqg/OuRYVecFTrIifai2n8s
         8PE2ELPsw6kzRneMGQNhumQE9I+Bt4uQA8QL6tkhaBAm7t+hSo+xdoObmjF4CQHk8c7y
         EecLom4Sx6T3klOcBVOcRswzZMGV15sGHwsdEKHjOd2rnaZDoAHXT9iIGagCjso+HoCV
         U/O50uGEynlzIN9Q+xkF++8WzSbLElrmZh6JPTjpWMq1+7ZAJv5MHErF/zKqyzaHvzgR
         6HEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bi14hRYWHC7upKJfIV9T588ZuWq3hnId+F+5PsFU1Sk=;
        b=lL3iKjtixx3zuLf2P/UzMheUb8jDqMdmO0SGNS/NYXJYneIcQEzx28iKurgK15HA8c
         ksUnGw2+DwXNu2TEtfJRAhlUhwWbpZZ4asz8xOFaO261PGH5IuWAW+h3iou4OAyulPAz
         aWVeWjpYH/DJRM5hpiNAzhPbuIhCaBwGyQxjUeLBqKvRZ8nJWtWB16bMvXwGZUTbE4e7
         TzlA9icYnCBjObzVUmqaZc7VROlyeU7u2MKHJwpFNSvyqGmTIJsz/60WOu99hV4F27ek
         n1hUPORw41s2NgX2/byXZESoo7eJtFpR4a11K5gYErg0v+9bPFSpzYNq8S3sLLZnlFYQ
         A9kg==
X-Gm-Message-State: AHQUAuZi0PH4aAefinJ/c/+j9MX9/l8hZhKY88br+/2easG6y2YADCDP
        z6WZgBq/kuQ3GmDyOHD2Lewpvo55
X-Google-Smtp-Source: AHgI3IZM5T4WHxJ1crjmU23oFSw8hWYaRMBcSb9LyBBLdUYBfWwq05ZvPp02cIQruQt74ovDJ+TPTQ==
X-Received: by 2002:a19:9a8c:: with SMTP id c134mr10108230lfe.152.1549550066086;
        Thu, 07 Feb 2019 06:34:26 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id j25-v6sm4257256lji.77.2019.02.07.06.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 06:34:25 -0800 (PST)
Subject: Re: [PATCH V14 5/5] i2c: tegra: add i2c interface timing support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549480569-24860-1-git-send-email-skomatineni@nvidia.com>
 <1549480569-24860-5-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f4c5cfac-6063-b5e3-e2bf-817a5b6b505a@gmail.com>
Date:   Thu, 7 Feb 2019 17:34:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549480569-24860-5-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

06.02.2019 22:16, Sowjanya Komatineni пишет:
> This patch adds I2C interface timing registers support for
> proper bus rate configuration along with meeting the i2c spec

Capitals for "I2C spec", please.

[snip]
