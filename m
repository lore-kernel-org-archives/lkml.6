Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F99C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0527720652
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9X40OfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0527720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbeIHAGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 20:06:35 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38596 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbeIHAGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 20:06:34 -0400
Received: by mail-lj1-f174.google.com with SMTP id p6-v6so13154774ljc.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jay/XCpzJvNU2GC1nOcaISJI9iuRATGcJ96B3bmGKgs=;
        b=j9X40OfVvPRMvB4bVYmRFNiO+gbS9lTxCVvqE3YyBglDAtzxreeEbJAquY5NxF9n+J
         u2pHtSdSDNRLmu/UfpRYjM/qzxjDOS9NqquF4s6GvglpLCNwv1JA7bdaocX732R0+Vfa
         Yaf/WsudW2l5L9bX+bSggRDXtvSLk1JJJF9taIqOv1/G3VvNHhj/19liDx9Cpdq+WgT1
         zlYoZtoSFv2lNhj6oFCBuIvUELRalROGQXIY0uVS00MJ1fHCeCiIGg7DFcWqSdab89Ew
         ll7Mn+f8gRqybq0//QiML2o/ohDbO65HbM1mUPPstVfKMZO7/yrD4vGqyagiKJGEgg5V
         PvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jay/XCpzJvNU2GC1nOcaISJI9iuRATGcJ96B3bmGKgs=;
        b=JxJV2J+udb0qj4jr4Tm7ExxXE3xl7/wNjqFo9S4iR6W5aDTYc/cixKhkkC4DbwPsnh
         I0myOTKJWDEbQJFabwHx1ipr6ePA8+efR2hOguQ5s882oa85g3wmhwDbLDkQYOHK85NM
         m9+TkbgGgpAlUktFGrdna9YJAfm0SnL/UDs0LtdkZVTAfURU/2AX+8lUpU76pTXloPro
         ++cmpwHv4U7nsn2xLzQhRaiJ+4WmTO8Sy+qRdGTQSaYABF8bK53QXg18nlhloA235AE8
         D7AFxIksB+e58xa2jjDffIHh2pQEpcBN8TXvbc5CRPFfV91Lr8ic37ZyW0ohY1jFmrCK
         T3NQ==
X-Gm-Message-State: APzg51Du64f+c8dm2tKnUKqd+IdawrcxYOh/HGsEjrEkzniHEcUgf0m1
        4B1zf8RbFkc6dhsiHcyKbM7zol4wepo=
X-Google-Smtp-Source: ANB0VdYhuKVBhXRVx+v5IonmOzwbpFx4bWRUwsl2dh1DQONY0Do+L/It1JUWuBfcffc0WkUDcXVPQg==
X-Received: by 2002:a2e:21d5:: with SMTP id h82-v6mr5815853lji.46.1536348251741;
        Fri, 07 Sep 2018 12:24:11 -0700 (PDT)
Received: from [192.168.10.160] (91-156-179-220.elisa-laajakaista.fi. [91.156.179.220])
        by smtp.gmail.com with ESMTPSA id d10-v6sm1382504lfk.63.2018.09.07.12.24.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Sep 2018 12:24:11 -0700 (PDT)
Subject: Re: [RESEND PATCH] mm: percpu: remove unnecessary unlikely()
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Igor Stoppa <igor.stoppa@huawei.com>,
        zijun_hu <zijun_hu@htc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180907181035.1662-1-igor.stoppa@huawei.com>
 <20180907183909.GA84248@dennisz-mbp.dhcp.thefacebook.com>
From:   Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <8df1c498-5e85-b058-c9a9-0b29d51b8df3@gmail.com>
Date:   Fri, 7 Sep 2018 22:24:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180907183909.GA84248@dennisz-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/18 21:39, Dennis Zhou wrote:

> Sorry for the delay. I'll be taking over the percpu tree and am in the
> process of getting a tree. I'm still keeping track of this and will take
> it for the next release.

ok, np!

--
thank you, igor
