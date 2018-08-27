Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA52C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F42420657
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 11:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="0ngIrfGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F42420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeH0PoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 11:44:22 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:33085 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeH0PoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 11:44:22 -0400
Received: by mail-it0-f67.google.com with SMTP id j198-v6so10972629ita.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kXswqQARiuc3Sex7Ydb6J1REG1L2kBNRzOFiHBPEOSI=;
        b=0ngIrfGUhQyPpw8g0KQyf0xf7ckOrc29nXRbcji8bvhMul1qGwHoxMIxmr0dOMnMJV
         TCvntrzLaqVClsA58HzjFJUa9LVR+08D+WIIGJOCrj6wWyMuP/+z2zvuPM6a304452Gs
         H2iGAJ+ILUphsX725OWdYcQh0EkvvSb8647dr48PTwKDQygfCBBk8okoDmcYmGGwiGwe
         YN5O6q6/nZyGWCU9fm63rP2Ovl07tIcn87cI4Y0pjSQ40P17i20akkssmzWJG2Sudl1u
         eNEiaY8nc5l5/nFh9oZXHQh4W5vLC6rg3LzfEw7/ySpRNrhsP8gPdepp9ajztWLP/IEM
         Jo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kXswqQARiuc3Sex7Ydb6J1REG1L2kBNRzOFiHBPEOSI=;
        b=qZMtDweFLa9TmOIr4EmUtKWaoaUs7uMRtdSCO7WapukhOqMDQiLXgA3J1FV6y0JRzH
         VC31uJQypmcRIJqRIHhlLHm0GUoeThTIEQnompQWM0jEtnCElYBK3T13Coa1ktXmDpaz
         ja7iMny7I89ZRAPaa9l4ElLFb0EfGAIidvXYeYkZQGu5GlgT4SM32CuLWuZdc5B2Ju3z
         oWqp4tcVB1avrnASt9VX8E411bBH0V7Wx3o85OmsErWLVJUCabfTtSHGt1fesW06GHjq
         iV5pD0Kij29Vd8A2viYmF4Ed5/+fCNXKhN3aoEMRIOdAOHPOl/N0q3BLuTNnBWZyWTw8
         ihcA==
X-Gm-Message-State: APzg51CQjTBKuDzb/jZZBgffOd1IRHuUjchWtYRjJRuEoN9X/mEQEKkV
        MEkR5e4vwbiCXhhNLpn9T2uq9w==
X-Google-Smtp-Source: ANB0VdbLKO2D9+Y9Q6E/i2KYZSvht2sG9Z/gSpGaG0sdIV37cuxHMaInnGZk5iUR38PkrodqiP5HKQ==
X-Received: by 2002:a24:57cb:: with SMTP id u194-v6mr6497166ita.148.1535371079939;
        Mon, 27 Aug 2018 04:57:59 -0700 (PDT)
Received: from [10.0.0.137] (198-84-205-232.cpe.teksavvy.com. [198.84.205.232])
        by smtp.googlemail.com with ESMTPSA id a14-v6sm5597755ioh.45.2018.08.27.04.57.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 04:57:59 -0700 (PDT)
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
References: <20180826055801.GA42063@beast>
 <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk>
 <20180826225749.GY6515@ZenIV.linux.org.uk>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
Date:   Mon, 27 Aug 2018 07:57:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180826225749.GY6515@ZenIV.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-26 6:57 p.m., Al Viro wrote:
> On Sun, Aug 26, 2018 at 06:32:37PM +0100, Al Viro wrote:
> 
>> As far as I can tell, the solution is
> [snip long and painful reasoning]
>> pointers, and not in provably opaque fashion.  Theoretically, the three tcf_...
>> inlines above need another look; fortunately, they don't use ->next at all, not to
>> mention not being used anywhere outside of net/sched/*.c
>>
>> 	The 80 lines above prove that we only need to grep net/sched/*.c for
>> tcf_proto_ops method calls.  And only because we don't have (thank $DEITY)
>> anything that could deconstruct types - as soon as some bastard grows means
>> to say "type of the second argument of the function pointed to by p", this
>> kind of analysis, painful as it is, goes out of window.  Even as it is,
>> do you really like the idea of newbies trying to get through the exercises
>> like the one above?
> 
> BTW, would there be any problem if we took the definitions of tcf_proto and
> tcf_proto_ops to e.g. net/sched/tcf_proto.h (along with the three inlines in
> in pkt_cls.h), left forwards in sch_generic.h and added includes of "tcf_proto.h"
> where needed in net/sched/*.c?
> 

I cant think of any challenges. Cong/Jiri? Would it require development
time classifiers/actions/qdiscs to sit in that directory (I suspect you
dont want them in include/net).
BTW, the idea of improving grep-ability of the code by prefixing the
ops appropriately makes sense. i.e we should have ops->cls_init,
ops->act_init etc.

cheers,
jamal

> That would make tcf_proto/tcf_proto_ops opaque outside of net/sched, reducing
> the exposure of internals.  Something like a diff below (against net/master,
> builds clean, ought to result in identical binary):
> 
