Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECBC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBDCB2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="iqz0kqK3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390714AbfBMIeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:34:14 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38857 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388558AbfBMIeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:34:13 -0500
Received: by mail-lj1-f193.google.com with SMTP id j19so456101ljg.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=teet6uMCYi/whroYHOOAdDx2GYqeMBTlZmN9wdbKNnw=;
        b=iqz0kqK3vOUrd3fJbspLIXKbGQelWI+lL9N4IUhxT6yRt7uePeqWQ++QhToZPG/zGj
         uSOY/uH4kj3NEfUSg8pM5xe5fqWSZYt9xCPZv/Ukt9YKkbVOF5xwgHjmigcJa6HwaIPu
         obO9OPC5RUvan7EOODOkMT35fNCwV5YnsvAbRU4a7J8EWA9BJCRxbQvHyw/khI2sbiM+
         IeGVhTa4hTkiJcSlsyN9CQimbMg4kLF6l2Jmy/4FixStxCVzFQ5Q2TY8qvcNYwT+sgsH
         RK06MyGuN1gdKotF4EoZYwBhVvkDLiWIgBZEphqBnCYGrE/ypydLCiRtZXmqulONzCg5
         PKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=teet6uMCYi/whroYHOOAdDx2GYqeMBTlZmN9wdbKNnw=;
        b=qPEWn/WY8VVO3yJHFjNlmvqDBbtPURkGJKJAOCak2cBXehkCuwYbmcTISkV+9yKSRt
         X8D+24hKKz/cpfOub6o3y3mVYl62D6cbeVja4p+Te7TF1E7dSE5PP/nTNMjWMmQ1oqpd
         zTkK5vDap7jv3z0grl2QkqTT/8U1hNYN6WBhmKzecLcBda5MZTigZXNHG9R1wQUe78QL
         Wb/UMzKWZVcZQ6Dk87RCJ7yJ0nIVQaDozKQxL/NPDV2lXzNyvosIF4wB9CAUti28XW2M
         vxJPCpvDdlNgPg0w1nc54dQSdagxMQ6rDFlKn52zucQFHF1VmDgKcFYdQxFTNiIVtBDw
         Hh2w==
X-Gm-Message-State: AHQUAuawpzUxT65PEUxr/XWrcptvVKpTb2UMaK0yss30hfwTaROHWbUc
        1YSEy7u/vQjv2vaxqwL+lX8pORJZPv8=
X-Google-Smtp-Source: AHgI3IYIHBlRilX2w3h8ClWfWIKNuIqDBU0nP4zsSO7y4OLEK19LWqYsZFz7EUSQApyh4PedxQyWcg==
X-Received: by 2002:a2e:9f56:: with SMTP id v22-v6mr5190413ljk.114.1550046851512;
        Wed, 13 Feb 2019 00:34:11 -0800 (PST)
Received: from [192.168.0.199] ([31.173.84.178])
        by smtp.gmail.com with ESMTPSA id z8sm2033753lfg.77.2019.02.13.00.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 00:34:10 -0800 (PST)
Subject: Re: [PATCH v3 1/9] platform/x86: intel_cht_int33fe: Prepare for
 better mux naming scheme
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chen Yu <chenyu56@huawei.com>, Jun Li <jun.li@nxp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190213074557.66028-1-heikki.krogerus@linux.intel.com>
 <20190213074557.66028-2-heikki.krogerus@linux.intel.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <95dc6948-8fba-97cc-77f9-7c105a946dbf@cogentembedded.com>
Date:   Wed, 13 Feb 2019 11:34:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190213074557.66028-2-heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 13.02.2019 10:45, Heikki Krogerus wrote:

> Adding new connections with for the muxes with new
                          ^^^^^^^^
    I can't parse this. :-)

> identifiers. The old connection are left in for now.
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jun Li <jun.li@nxp.com>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
[...]

MBR, Sergei
