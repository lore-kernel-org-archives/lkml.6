Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407B1C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E062B21486
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 16:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVOl4XDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E062B21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbeHVTk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 15:40:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45885 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeHVTk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 15:40:27 -0400
Received: by mail-oi0-f67.google.com with SMTP id q11-v6so4059000oic.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 09:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VS1A7bLCIWNvTzvuZ91/aHyl1f06W9G+5OLr/SYTWGY=;
        b=hVOl4XDaa0gNa7Gh76LbDTmy8OFYNFt1mAMUogJvCgNFRJsEPRVxJBwyy/pIKIgjwQ
         +BsLjivnSTvUkEkw5sFS160ZtftuVzBBhTEvlM8dtanqrYlaQTdl30wgTpV0Xzp7kkAl
         aHYx1C6tTsfHTbsQWvC+2EuSrROyyLO2iyZ6OqoV3AsXcBz7VK9lwHETKcMgoCGHqRqe
         DAKyCDpIpen0KMnP7JVuI2mce28y+hAlpBCxi9qhBMD2SoKvPpBOj8BYNvba+MXqhXwR
         2Fn5fI2KWTB4I+Kw7FMYcZ/cGA7rLC4LaOJO2+gKiSkeOw8hFWHqtbPGzTzGR5xmAWF1
         to5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=VS1A7bLCIWNvTzvuZ91/aHyl1f06W9G+5OLr/SYTWGY=;
        b=E/iUNI9tGXnGqlNKHKv0hqu3FY0ZgjEVYOkqyOtwLQ9tP+pwG4tgpKp0LpnhIQFz98
         QX4551HyXhg0dSNeiErWGC8mRVENPHZziP3ScItoNxGnFlmVSmLvdeQDo4buShUksiN3
         QpRvtA6iLjuYb+VROaqYe5XGVvpQyP14knfPWTsg4INK4WSg6lRWb7KB/Rc4RK4dmWOk
         7eYez0oM/tjh5f9aiIbkyURqWhUz1s+J1/ovDv5al22HpsN/dT+bqTYY1J1kiD5Rqwv6
         PHtrrMzsMpBMeTMoBCt1Y6zY5EWJSEIjffbxQ+03sW6CF+CoFaQZIF7+xDN/0UzpIaym
         ubtw==
X-Gm-Message-State: APzg51DTl37AyGUKhVvfe4cwSIwtFGWp4aZzvml4UZlys/tGOCgnRhkL
        YB26p2KndNYTXd7z+BT0hg==
X-Google-Smtp-Source: ANB0VdbFqdiSThq1vQ+KhsfonpE7XDiwcg/NUmMDrWzRRZKsR4QrjHwnDsE/C+esRGYXAdnegCEHKg==
X-Received: by 2002:aca:b702:: with SMTP id h2-v6mr4722034oif.66.1534954495369;
        Wed, 22 Aug 2018 09:14:55 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.128])
        by smtp.gmail.com with ESMTPSA id 22-v6sm1188222oix.58.2018.08.22.09.14.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 09:14:54 -0700 (PDT)
Received: from [IPv6:2001:470:b8f6:1b:92c:30c0:5286:7e9] (unknown [IPv6:2001:470:b8f6:1b:92c:30c0:5286:7e9])
        by serve.minyard.net (Postfix) with ESMTPSA id 7813A79A;
        Wed, 22 Aug 2018 11:14:53 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [RFC] IPMI state machine regression
To:     Andrew Banman <abanman@hpe.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     justin.ernst@hpe.com, rja@hpe.com, frank.ramsay@hpe.com,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <a72a169e-ce1b-500c-7910-b400c7842033@acm.org>
Date:   Wed, 22 Aug 2018 11:14:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180821221443.hhgcnzw6xttaih3i@linux-tqvx.americas.hpqcorp.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/21/2018 05:14 PM, Andrew Banman wrote:
> Dear IPMI supporters,
>
> We observe a window in IPMI BT's opportunistic get capabilities request,
> wherein GET_DEVICE_GUID and GET_DEVICE_ID requests may start while the BT state
> machine is in WR_CONSUME. Following this, the 0xD5 error code is forced in
> bt_start_transaction, IPMI fails to initialize, and the interface is torn down.
> There is no mechanism to retry bringing up the interface in open() /dev/ipmi.
> This leaves IPMI hosed until you reload modules. Looks to happen after we call
> schedule().

When was the latest kernel where this worked properly?  Also, what 
hardware is this?

BTW, you can use the "hotmod" capability of the IPMI driver to add the 
device
dynamically.

-corey
