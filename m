Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA675C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7037C2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 14:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4HZOM8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7037C2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbeKHAZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 19:25:59 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39607 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727265AbeKHAZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 19:25:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5-v6so7968933pla.6;
        Wed, 07 Nov 2018 06:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=L51Xt0giWLtqlH6i1s69vwVGY1Yo0BoONXTZaii8naQ=;
        b=F4HZOM8S4btK3nvPf4Mq9sUCWpHzc5nNuyOVw6X5eOnW/1jK72o3w418tYX/NCxn1w
         9abOLsgHb7V7cHsN3qebOU+nlMGVab0oV46O/QV09SPsttvfGE4b5s8itzNHTtaBo+xP
         dzNK84voCXzs8gwzXy/Dz9hbtUsMj9j24SHwEf3D957HFRnYtTdyaXF7Z6EiSIN2/3IH
         zAKq6g9pEJ9+d4LmDa1sasljke+D0bdh6HD9y7Wwf5xRZV3rMrdrgMrmGceY82I7xV8h
         aYAN4Y2accIKEHLwkxwyP0EdoK8uvY/U2dAXD760U315jWKVMjkQgGxngoYtvcjHcQBZ
         ss1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L51Xt0giWLtqlH6i1s69vwVGY1Yo0BoONXTZaii8naQ=;
        b=tfpETF+HJMwc1jUFYcr1dDxS2I/Ishg7WOYniW0Rkgr5yQXrhlXSal8vYRgiYFAs4o
         CE9PChYDD8I68Z/orCkjYQneRC9nXmYwaS84RDeoF8bwk8UNwzVijzwqaHxiQ3pPT8ht
         rrxDdKNxY7eqOI1JFX81wXc6q9Okg7d9OSpA0YhsJexaB3TbhkmOTRMKA/S6F12TIvEH
         a9jQSXr6xOXBcXZKbAhfPAD0wbcuPfXgQtUn4mMpa33+zvksM9IFRMhw6b3RjJ7oMEZQ
         6srdyTQDE0hnIDuCwzzbsNreMqfsuwa3cviJltqVffwyKKpHldHGx/8Mgw67ZVGEl5D6
         /VBg==
X-Gm-Message-State: AGRZ1gJtUoRQRaHDObIR2AwC6SLbywbswW0dyfarYyQTxHLR+or6qKPN
        faF1o58ZYFC9MNN+5gfobeU=
X-Google-Smtp-Source: AJdET5cw2MXlOGAj/QArd3b+NFPzgYVUt7thhiYE/uXoL84Fv3m3eAnWmwm9LUvMefN6hP/rraRVtQ==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12-v6mr524258pls.281.1541602517389;
        Wed, 07 Nov 2018 06:55:17 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id f10-v6sm754782pgp.72.2018.11.07.06.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 06:55:16 -0800 (PST)
Subject: Re: [PATCH v6 07/18] of: dynamic: change type of
 of_{at,de}tach_node() to void
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alan Tull <atull@kernel.org>, Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-fpga@vger.kernel.org
References: <1541431515-25197-1-git-send-email-frowand.list@gmail.com>
 <1541431515-25197-8-git-send-email-frowand.list@gmail.com>
 <87tvktqedf.fsf@concordia.ellerman.id.au>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <6bc78502-7587-eb9c-237f-d3f031979d42@gmail.com>
Date:   Wed, 7 Nov 2018 06:55:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <87tvktqedf.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/18 4:08 AM, Michael Ellerman wrote:
> frowand.list@gmail.com writes:
> 
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> of_attach_node() and of_detach_node() always return zero, so
>> their return value is meaningless.
> 
> But should they always return zero?
> 
> At least __of_attach_node_sysfs() can fail in several ways.

Sigh.  And of_reconfig_notify() can fail.  And at one point in the
history the return value of of_reconfig_notify() was returned by
of_attach_node() if of_reconfig_notify() failed.


> And there's also this in __of_detach_node() which should probably be
> returning an error:
> 
> 	if (WARN_ON(of_node_check_flag(np, OF_DETACHED)))
>         	return;
> 
> 
> Seems to me we should instead be fixing these to propagate errors,
> rather than hiding them?

The history of how of_attach_node() stopped propagating errors is
a bit more complex than I want to dig into at the moment.  So I'll
drop this patch from the series and add investigating this onto
my todo list.  I suspect that the result of investigating will be
that error return values should not be ignored in of_attach_node()
and of_detach_node(), but should instead be propagated to the
callers, as you suggest.

-Frank

> 
> cheers
> 

