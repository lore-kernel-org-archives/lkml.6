Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4019BC282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EC38222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 02:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="o522v5SS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733288AbfBMCPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:15:31 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38654 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733202AbfBMCPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:15:31 -0500
Received: by mail-qt1-f194.google.com with SMTP id 2so924747qtb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 18:15:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SC33iLOSs9PqXp2KbtE2YvTh5FiHaUeY1DXX8o+1gSw=;
        b=o522v5SSRw7eM1Hu/o03lkjHZPVpMpjFeQCfoQPNu1iPoia2Ybq9JnK5a0P9jSSOUm
         WJmdGqDCi2PtF5Mi5Xm2aTq4uGXEOggOpl4jFkPT7XMivx84yDYHKI8ugABOIC8uHiI7
         lxHF2x3xA/A48g0UxU60f0SPBqpd/MFeei+H9YLBvx2G28vZWN1HyairJyzh435nIYiL
         ZLvWp7JlCg7ZFalSQGMp6AWyYiRNl38MQe/Bzm25UBfAuQX3gzI07pbY15Dw8voN62G3
         FLUsgaHtLiUGooQW+zrNRfpBxi/mG1PXFUizhgrlHtkyKATZUD9y/SReApFFtDpimAXk
         oBzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SC33iLOSs9PqXp2KbtE2YvTh5FiHaUeY1DXX8o+1gSw=;
        b=SjRmaq0wUzSeMS1ot8XWj0kyx/gJjAb9lSpIuO3BmFb917IUAF7eDYD2Lp9u5HuHtV
         D9CLL6HFLNMSop7OUnNb3KjHRQWhGQaf/HbXolJYQYXOtQjij9FlAH8iMxaf2Vs23qmJ
         xryLfP3fBTblw4MtksSdQGlDY5RVZEEkBT5DjP+0/cwj3yYCnxMLpTCKNvdW1/X2KeQK
         waZWHijwZS5RUhuOmyzHqV6sv2oa9i1uj/mCxFxd4mxFP0lblIwlUtDWPrj0CoBMWbEc
         +3sERXRubFrmg+lQX2I6MlWmYHsLzuduYP9q/UTsKUQe+oRceaKMHqna8EBOxvwXd2RO
         fg2A==
X-Gm-Message-State: AHQUAuZohYd1SKm4XFEGDh/kYP4y1v6KG79IgsQJ49+w4/b8tZGRrB48
        luN0msRicpQveI/eEmT4x/uqFg==
X-Google-Smtp-Source: AHgI3IZ54oqz1LKhCjGSXiloYfAOeDShGCL7wagWggVrRp6mWyIKK/3KWQ/NEaWrs5vCdBRkasE+uQ==
X-Received: by 2002:ac8:2c82:: with SMTP id 2mr2808437qtw.347.1550024130166;
        Tue, 12 Feb 2019 18:15:30 -0800 (PST)
Received: from ovpn-120-150.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z207sm15686303qka.57.2019.02.12.18.15.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 18:15:29 -0800 (PST)
Subject: Re: [PATCH 5/5] kasan, slub: fix conflicts with
 CONFIG_SLAB_FREELIST_HARDENED
From:   Qian Cai <cai@lca.pw>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
 <3df171559c52201376f246bf7ce3184fe21c1dc7.1549921721.git.andreyknvl@google.com>
 <4bc08cee-cb49-885d-ef8a-84b188d3b5b3@lca.pw>
 <CAAeHK+zv5=oHJQg-bx7-tiD9197J7wdMeeRSgaxAfJjXEs3EyA@mail.gmail.com>
 <c92d6890-a718-a968-9937-13bdfeda773c@lca.pw>
 <CAAeHK+xDYvjMxrkczTQaDbMSu5u3GsxW_mFi1=9OAjCi2Q-6iQ@mail.gmail.com>
 <a9d73c21-744c-84f2-78db-a32773b83ddc@lca.pw>
Message-ID: <493db265-01f6-3901-3416-1ac5bbdd1194@lca.pw>
Date:   Tue, 12 Feb 2019 21:15:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <a9d73c21-744c-84f2-78db-a32773b83ddc@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/12/19 11:07 AM, Qian Cai wrote:
> https://git.sr.ht/~cai/linux-debug/tree/master/dmesg
> 

FYI, I just send a patch to take care of this.
https://marc.info/?l=linux-mm&m=155002356527913&w=2
