Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7449EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3535B21470
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 15:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRZ1Fpda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3535B21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJJXLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 19:11:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45459 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbeJJXLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 19:11:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id q5-v6so6291009wrw.12;
        Wed, 10 Oct 2018 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lPAe6aZQphCO6Nx5b7ONqBmv6yXZTe38ZrWgjowcS/M=;
        b=HRZ1Fpda8gVBng9/I9h1JFK7R/IZxwU5NlIeIYeJxJZ5g+0tRA/i9iydYlPemKeGzK
         RryQUy5zLf4KtMa/+mv1lMQUuxZyZZcfFhEsMgw3/MunrJoTGaN4QQwfCfzE0/Irp34m
         NBVmPzw2kgA4hO3PwpiXoC3WmKFxu+9O4Gjqb7PzbGz7aVKkZ8MCTlitgHEx/trqL9MG
         anVqNtrZeFnXlctF/1ByiGQBivVk0jpmXamJxzaZhGy3rX1JRj3gUZ1ENR+Ai5XuRdVE
         5VhLGyPNYoUo16+/EGBPoV0GwWqVbjEwfLrW+re/MSHRfMW/XnEhhtB6uTycKZk26sdU
         zZ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lPAe6aZQphCO6Nx5b7ONqBmv6yXZTe38ZrWgjowcS/M=;
        b=E3NrIEKv5ElMXlJZRDcuY/YMIhYI4oUIBNyteWeWoWifKcVu86qcffknb7HE9Gn6/L
         xQzdWn5Srngm6ujSb+mnGhVcSZSStPyGvCfg/M1d1KmYpL3po0QJfiU/DCduj6E4z7uP
         dXXXbX3qEpI7FBNZaMSLf8+yluhxfJPB5kaA6wso1wRfWzGm4/7FTdG6OL9YFuo8feOS
         7x3qNvtOnGSlOM01g2/4k8A/NhsxofYPdTlRcOAXxqniufGrWuTu4fT9LH9sZ2vRG2lf
         gi/z8Eu9GgCRwSpkagORx7bAiXLnWmPjXY881Hrlu3XcFuMaevPccuocr9a+FOygNKSU
         I0tQ==
X-Gm-Message-State: ABuFfogimhelKi4i+e7syfKIDgnZfDrRKRQnzJgzBrmuYCsddilymAQX
        lVZiA/hx1IQyxPUpD8LOnvM=
X-Google-Smtp-Source: ACcGV60y7fkwaBpE6BXcOaJo29y+/k2fTioeasAsnmNVViFsD6Cu5aieTHykaSQpdaTD/qzXv7oNyQ==
X-Received: by 2002:a5d:6b92:: with SMTP id n18-v6mr7355884wrx.295.1539186502449;
        Wed, 10 Oct 2018 08:48:22 -0700 (PDT)
Received: from [192.168.101.125] (45.11.168.109.cust.ip.kpnqwest.it. [109.168.11.45])
        by smtp.gmail.com with ESMTPSA id g15-v6sm18053111wrp.56.2018.10.10.08.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Oct 2018 08:48:21 -0700 (PDT)
Subject: Re: [PATCH v3] i2c: mux: remove duplicated i2c_algorithm
To:     Peter Rosin <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20181003151928.17713-1-lucaceresoli77@gmail.com>
 <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
From:   Luca Ceresoli <lucaceresoli77@gmail.com>
Message-ID: <70c48ade-b2ac-dde8-4b3e-aa4b2f19940a@gmail.com>
Date:   Wed, 10 Oct 2018 17:48:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <99cfa6a2-9a60-6bdd-2542-9dd78af75758@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 08/10/2018 23:43, Peter Rosin wrote:
> On 2018-10-03 17:19, Luca Ceresoli wrote:
>> From: Luca Ceresoli <luca@lucaceresoli.net>
>>
>> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
>> However these algorithms are all identical, depending only on the
>> parent adapter.
>>
>> Avoid duplication by hoisting the i2c_algorithm from the adapters to
>> the i2c_mux_core object, and reuse it in all the adapters.
> 
> Ouch, while I like the concept of having one i2c_algorithm per mux,
> this patch is not working. Various i2c-mux drivers set the
> muxc->mux_locked variable *after* the i2c_mux_alloc call, and this
> patch breaks such use.
> 
> So, the patch needs some reworking. Sorry for not noticing this
> earlier.

Thanks for the heads up.

3 drivers have the issue you mentioned, and two of them are not trivial
to fix. Ok, as soon as I can spend a little time on this I'll have a
look and hopefully send a fixed patch.

Regards,
-- 
Luca
