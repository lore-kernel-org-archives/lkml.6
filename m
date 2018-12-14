Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A621C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:05:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7509A20675
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 23:05:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxLaQEnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbeLNXFD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 18:05:03 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45978 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730728AbeLNXFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 18:05:02 -0500
Received: by mail-pf1-f193.google.com with SMTP id g62so3483528pfd.12;
        Fri, 14 Dec 2018 15:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QnEvhIpM2cY7QkojVKyU9AUKOYtRzc3GEi68oBJEI2k=;
        b=LxLaQEnJbZBH+sv4XRqb+aeMArzk/AGAR2JHxx2GPFGSFw87RcsPHl+bwTkdeBQzYf
         DQSUNhjeHEDRVNGx4BogWKfR4dRQuH1hXvB7INt8gZ0IQWx5KVOOCv6DbQ2ZJV7i87gM
         P8BtERVOAZ/lOnzggo9S5FYsSTNB/F1v70H4mXOI3/gODMl54dZHUTWZHj3tT09ROHd0
         Fe/BFjuka9g2Vu10+9cwcD9GhelqB4JvznwFRmeo2XCweE9HYg89QhsAbuwyXZI4/qtc
         g2Vuj35IyBVjB9paPsJWO5wvDxrhjAqSmZVNuHdNegHSC3uT/x4tx+h2kZctNJK0XuYh
         owgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QnEvhIpM2cY7QkojVKyU9AUKOYtRzc3GEi68oBJEI2k=;
        b=rSkgHaL99bOBhnu7O2/YEMqXwOzeKXzusbW3NiH1xLNWsGknylU5Bf9G7y/Notbqhy
         ZCGuT6IsTsrZzBjJ0S1m+jxIXs1FFW3mtryXpIR8wLgr1dXkP3Xt1+ZAoKCigdzFcfU5
         Qs8680jyTtGI0VeQ7Ms/Xy8AMe7wRzPbqLx8deZDHJp3MTqT5FJwyqrG7r5bsyOzxiAe
         Uu7NrKR7n+Ya+1I/uCt4BeAPfoKIzb3/er9/NdW83OsaOsKjCEA73V5dxqVcgjzZ/G97
         3y7+3NaiYgpS7Ag1/SaIwR5E1f/bMrmcQzn78ZqL4rOXOD3kVtgPGehszOkWRKLaEcSW
         sGLw==
X-Gm-Message-State: AA+aEWZ49nAiD87goYeRFntb6ZDNkC1JOiaiH5a7KTiNf2glc+CzASH/
        yR/M4VNNy2oA+ptcGSVJaO4=
X-Google-Smtp-Source: AFSGD/WG4rs6zJSBwJlPBimz0lwFeXv43Q/9Aab4LunAhles+ApDdu+f99WSZ8erQTXNBmKzEXBxHw==
X-Received: by 2002:a63:b24a:: with SMTP id t10mr3447978pgo.223.1544828700809;
        Fri, 14 Dec 2018 15:05:00 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id e23sm8568313pfh.68.2018.12.14.15.04.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 15:05:00 -0800 (PST)
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
To:     Rob Herring <robh+dt@kernel.org>
Cc:     mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
 <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <cb7caa9a-abcb-93c2-a3e9-185133f1241a@gmail.com>
Date:   Fri, 14 Dec 2018 15:04:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 2:47 PM, Frank Rowand wrote:
> On 12/14/18 9:15 AM, Rob Herring wrote:
>> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>>
>>> From: Frank Rowand <frank.rowand@sony.com>
>>>
>>> The phandle cache contains struct device_node pointers.  The refcount
>>> of the pointers was not incremented while in the cache, allowing use
>>> after free error after kfree() of the node.  Add the proper increment
>>> and decrement of the use count.
>>
>> Since we pre-populate the cache at boot, all the nodes will have a ref
>> count and will never be freed unless we happen to repopulate the whole

>> cache. That doesn't seem ideal. The node pointer is not "in use" just
>> because it is in the cache.

I forgot to reply to this sentence.

The node pointers are "in use" because of_find_node_by_phandle() will
use the pointers to access the phandle field.  This is a use after
free bug if the node has been kfree()'ed.


>>
>> Rob
>>
> 
> This patch also adds of_node_put() so that the refcount will go to zero
> when the node is removed as part of an overlay remove, if the node was
> added by an overlay.
> 
> Patch 2/2 adds the free cache entry call to __of_detach_node(), so the
> refcount will go to zero when the node is removed for dynamic use cases
> other than overlays.  (For overlays, all nodes are instead removed from
> the cache before __of_detach_node() is called.)
> 
> -Frank
> 

