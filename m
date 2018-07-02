Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFA88C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8DC25615
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 13:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bj/e31br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A8DC25615
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752367AbeGBNMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 09:12:52 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37014 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeGBNMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 09:12:47 -0400
Received: by mail-lf0-f68.google.com with SMTP id j8-v6so2396104lfb.4;
        Mon, 02 Jul 2018 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=wGlNGRnHPJK7uXfkYvk3OVaclKl1mVLlyCpryQEOX08=;
        b=bj/e31br6PAhA3myUt4wMlxvMgOU0AGqKFk/CzdPGM2ZWszdDIRS0CRDZBy7pGIKl/
         a9/jChOCcI8P/EDtkKRviLwyfQUBk9gz8IUm+JDpUISbYDorGXwYdDoLpKhlJIQGj1op
         pmZn0agDf49sxggeB9LEyWBQ8ffIqkXua+nlDWr6/4xSthO31sEmusXllJrzYm1D8B0w
         WjHsudz6VXDaE74Xa6CXu8paXxlFh24xoLNefoifFVEn1Xzc13RU7QlEUKWRW2g9GLFE
         h/mY3Pxq2XL+BjVErl4uPBjenHzUrU2AsM1WTARpWzkKCo6Rf9Wzohn+wgTbGyY8ygdD
         B6gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=wGlNGRnHPJK7uXfkYvk3OVaclKl1mVLlyCpryQEOX08=;
        b=RN6zIXqsEroLZsVw/NB4Xfrq4Dtdclz9DISOVBgW9m8U6aJWNn8807E0yZE5qmnZlM
         fW4BjaI8atVa3bmsrblCYF++mMf70CLu27oipJ5vJM1o8LqraAQKXKP/jbfzqyXgNsxu
         wZ140mr59r2cfDOy9YFeyQ2YwYakBHlydq6ovjSQrwUNIOwIAzj++BiyWrzFtKlGb67Y
         YjtIXdJB+NhElfki2QNNhghP4v0XXsmtugcxKDP6DZYGqrGdYL5b4yd43L+nifgyS48r
         R4JGzyVFvc+4OS+jIG/Cxt9OAH19seliBvf7Xpqj0BjlvmUEyiJtd0mTSHSolMRdIhCs
         eb+g==
X-Gm-Message-State: APt69E3LmsmEDRfZxPEwW7sNLc/yMtHYk/zuOqDv89pz0iuu03Srk2Yf
        R38CEt6LAxyu9FFfzVpAPXY=
X-Google-Smtp-Source: AAOMgpd9LgB8dODJjvAPDK9Uz2Id14rnilV4vhgJnPdgKr8mvWslzg2PzMSg6KNYQstR1CLUjCPnNA==
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr16006370lff.9.1530537165826;
        Mon, 02 Jul 2018 06:12:45 -0700 (PDT)
Received: from [10.17.182.9] (ll-53.209.223.85.sovam.net.ua. [85.223.209.53])
        by smtp.gmail.com with ESMTPSA id l25-v6sm2600970ljj.30.2018.07.02.06.12.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Jul 2018 06:12:44 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] xen: dma-buf support for grant device
To:     Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        konrad.wilk@oracle.com, daniel.vetter@intel.com,
        dongwon.kim@intel.com, matthew.d.roper@intel.com,
        Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
References: <20180615062753.9229-1-andr2000@gmail.com>
 <0d314f2f-e0c1-1017-5ba9-83489038b544@gmail.com>
 <ae597938-6d2a-9b4c-de7f-ec66429847bd@suse.com>
From:   Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <1b714e02-8225-b091-bd14-079a35d02a12@gmail.com>
Date:   Mon, 2 Jul 2018 16:12:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <ae597938-6d2a-9b4c-de7f-ec66429847bd@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 11:20 AM, Juergen Gross wrote:
> On 02/07/18 09:10, Oleksandr Andrushchenko wrote:
>> Hello, Boris, Juergen!
>>
>> Do you think I can re-base the series (which already has
>> all required R-b's from Xen community) onto the latest kernel
>> with API changes to patches 5 (of_dma_configure) and 8
>> (dma-buf atomic ops) and we can merge it to the Xen's kernel tree?
> Rebase: yes.
>
> Merging to the Xen kernel tree: only after setting up the
> for-linus-4.19 branch, which will be done by Boris later this
> month.
Then I'll probably have to wait until for-linus-4.19 branch
Boris, do you have any dates in mind for that?
>
> Juergen
Thank you,
Oleksandr
