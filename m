Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B89C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C80D2080F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 22:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLVuo4IU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbeLNWrx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 17:47:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35862 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNWrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 17:47:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so3327405pgm.3;
        Fri, 14 Dec 2018 14:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+sVeExr61Mq3L3NYAB+pagTiCuo2PfKJ9Dk8LO8Wc1Y=;
        b=TLVuo4IUnJfZh1r5l5l866Ynkcmx6i1y6MtYGhdhM4ouTi9WQHurmlMRQL6goJ8gwx
         v+woPrpWn0rySugQDvtO/IUtm3iVhR7AHKvmxNMH+SEI5K/j6YvBXw/xxK44xnQ30dUi
         sH5ASBxGboDVPKuJ87nqDzfBmw1s8DGcSMVX/aaumXKnar2GiJN8CkrU5Wq8b0qfVfuc
         Cl3fp+n+eM9wNAeI72jCcKYqNPYpgPyk5K4c/nj3HUWV2WzKAHyyccRpoW8RNeDfkJ8t
         IJD0u2BblxmBKT21m+2tKu0DmzW97eWVtQskd/0bSBYDvc9WdKaeZNqkzLgRY839Q12E
         pRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+sVeExr61Mq3L3NYAB+pagTiCuo2PfKJ9Dk8LO8Wc1Y=;
        b=QzGfo87pmEIhlzexC9ZogifshlXnFJrH2pJEHFeDIpt+seYI/ttu9eV75H/t8A3FXr
         tt4cbLldqS/NGFPkSZHrcDT+CvaWsfiaj7n/AKnnB+6RPyrc8jxaVnBTH3/kZhOygyYo
         Bto8E61heJh0KVEVywOJwaf8xbtvqtk3dmqEwWOat6HDzXBTXJjFgQfFW54dENYiMC8C
         a0IfokbsUED9g6pcXC7CrKMHkuPuAyUp0mTXTvCYp8bDG8spYQCJ1hepRGjypvhlcZOB
         4BU9Ag+l9cbfXcQUR0bh/d2FpDAfjA1b07YwuAIycOqB4mktkXsMr3NwPcp8RzV922Zu
         pxrA==
X-Gm-Message-State: AA+aEWbD52TTv59P2kOBwb7gLDViLSiJv/8IbQcU9r1jTi49uwbyzXTu
        Mruq4cDXzk1iW580OuFpRGw=
X-Google-Smtp-Source: AFSGD/VuhBwckkyEdicrc/CxhZ5Y+gSFHmYsZOVo8nTpsBdeWdGM4WhzXvdOWIgvSSw0UnK9MTAcug==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr4574593pfc.113.1544827672290;
        Fri, 14 Dec 2018 14:47:52 -0800 (PST)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id u69sm13416584pfj.116.2018.12.14.14.47.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 14:47:51 -0800 (PST)
Subject: Re: [PATCH 1/2] of: of_node_get()/of_node_put() nodes held in phandle
 cache
To:     Rob Herring <robh+dt@kernel.org>
Cc:     mwb@linux.vnet.ibm.com,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tyrel Datwyler <tyreld@linux.vnet.ibm.com>,
        tlfalcon@linux.vnet.ibm.com, minkim@us.ibm.com,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <1544769771-5468-1-git-send-email-frowand.list@gmail.com>
 <1544769771-5468-2-git-send-email-frowand.list@gmail.com>
 <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <35cab334-0856-44e1-b18e-22668011b429@gmail.com>
Date:   Fri, 14 Dec 2018 14:47:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKn8RpRmk7OQB9nEM6nZMfdyjgomqMqLU=u+q2qUzQQCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 9:15 AM, Rob Herring wrote:
> On Fri, Dec 14, 2018 at 12:43 AM <frowand.list@gmail.com> wrote:
>>
>> From: Frank Rowand <frank.rowand@sony.com>
>>
>> The phandle cache contains struct device_node pointers.  The refcount
>> of the pointers was not incremented while in the cache, allowing use
>> after free error after kfree() of the node.  Add the proper increment
>> and decrement of the use count.
> 
> Since we pre-populate the cache at boot, all the nodes will have a ref
> count and will never be freed unless we happen to repopulate the whole
> cache. That doesn't seem ideal. The node pointer is not "in use" just
> because it is in the cache.
> 
> Rob
> 

This patch also adds of_node_put() so that the refcount will go to zero
when the node is removed as part of an overlay remove, if the node was
added by an overlay.

Patch 2/2 adds the free cache entry call to __of_detach_node(), so the
refcount will go to zero when the node is removed for dynamic use cases
other than overlays.  (For overlays, all nodes are instead removed from
the cache before __of_detach_node() is called.)

-Frank
