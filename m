Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23448C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0AAA20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVJrmci7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0AAA20862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbeHASM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:12:28 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43277 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389980AbeHASM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:12:28 -0400
Received: by mail-pl0-f65.google.com with SMTP id x6-v6so9037151plv.10;
        Wed, 01 Aug 2018 09:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MU4LbWjdPjbSgvRdbbnhsVQq36Zk5Rj2ivak+iUq270=;
        b=dVJrmci7jetPhMzzkBslrat1w3/2hy30a5COxJleu7+GqZRDIb22UcTCqMYilK6Iat
         uNd52r+FqiTy2dW1GfL9Z63tUNYXJN/3H3neUmrl7Q04yq4PL6lkPHAt18q+NgorbcrE
         cIXwEc1SwowZx6uyqSPaE6cdoRxI0MvljSqF6k3ChdCEzCDfA1kdb1c/W44xLwVLKkuQ
         sQRfk8cQU2ZGBq+SZg7U+5HneZK3XDgtaFTI43YkERLZxRNBnroZqgQDcLBFRmMt/qms
         /Mjq6EIMBw7hl5NFCxdfBLTsqxq/v3OH8fnUDXHu82eFjQvsSbkIHtPms00Hyk6ooD0P
         FZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MU4LbWjdPjbSgvRdbbnhsVQq36Zk5Rj2ivak+iUq270=;
        b=r/fPV2hxpmiYWdW8WK0V0QlrTRVjmbfIA0b+fs/8BXIObuXCNVWy1CeOhCo4SDDE6U
         IisFbVDDnvGL5W/71VbQI4ATdU3iQZHw8WNbIPSVprtKfUk2ZjxeQLvzKO8xPbPX6hrX
         /RFDwuyN7Gc3mieJiUk6KoAJk8NFfMo0JVaTjfxX4666+9cI1B/FZw9ti8mT9P85C1op
         RpKasjCeFc1tunXm3j3r6QmTmI6B7elWpVCNiQ2qtrIK10HzW7BpuxQr/XFd3gTk00TH
         EaIoZF1QoPKKZsdeg+Dm3NLwD/zkoQesIOtZ8XaEI1s4bWn9VJHBn55ImlofHiU5uRzL
         u3Iw==
X-Gm-Message-State: AOUpUlGA0xQ5a78v+EhO9w6k+R26gSQ40kWaNCjua72ripvTrE24/IOE
        n7LDrjobBSdGvyY66LK6wzQ=
X-Google-Smtp-Source: AAOMgpd8GAfRcB7wWU17+or9K06/l/Wl4vOGUM1+ymUGKQ9RSOqYCt271/kUZCU3HCfnElCxqFMAUw==
X-Received: by 2002:a17:902:a5:: with SMTP id a34-v6mr25709421pla.60.1533140757623;
        Wed, 01 Aug 2018 09:25:57 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id r19-v6sm42365883pgg.39.2018.08.01.09.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Aug 2018 09:25:56 -0700 (PDT)
Subject: Re: SLAB_TYPESAFE_BY_RCU without constructors (was Re: [PATCH v4
 13/17] khwasan: add hooks implementation)
To:     Christopher Lameter <cl@linux.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>, jack@suse.com,
        linux-ext4@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        David Miller <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev <netdev@vger.kernel.org>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>, dccp@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@google.com>
References: <e3b48104-3efb-1896-0d46-792419f49a75@virtuozzo.com>
 <01000164f169bc6b-c73a8353-d7d9-47ec-a782-90aadcb86bfb-000000@email.amazonses.com>
 <CA+55aFzHR1+YbDee6Cduo6YXHO9LKmLN1wP=MVzbP41nxUb5=g@mail.gmail.com>
 <CA+55aFzYLgyNp1jsqsvUOjwZdO_1Piqj=iB=rzDShjScdNtkbg@mail.gmail.com>
 <30ee6c72-dc90-275a-8e23-54221f393cb0@virtuozzo.com>
 <c03fd1ca-0169-4492-7d6f-2df7a91bff5e@gmail.com>
 <CACT4Y+bLbDunoz+0qB=atbQXJ9Gu3N6+UXPwNnqMbq5RyZu1mQ@mail.gmail.com>
 <cf751136-c459-853a-0210-abf16f54ad17@gmail.com>
 <CACT4Y+b6aCHMTQD21fSf2AMZoH5g8p-FuCVHviMLF00uFV+zGg@mail.gmail.com>
 <01000164f60f3f12-b1253c6e-ee57-49fc-aed8-0944ab4fd7a2-000000@email.amazonses.com>
 <CANn89i+KtwtLvSw1c=Ux8okKP+XyMxzYbuKhYb2qhYeMw=NTzg@mail.gmail.com>
 <01000164f64bd525-be13e04f-18a9-4f7f-a44b-0c0fcec33b71-000000@email.amazonses.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <bf435a04-b689-ec5a-f5df-f47807b43316@gmail.com>
Date:   Wed, 1 Aug 2018 09:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <01000164f64bd525-be13e04f-18a9-4f7f-a44b-0c0fcec33b71-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2018 09:22 AM, Christopher Lameter wrote:
> On Wed, 1 Aug 2018, Eric Dumazet wrote:
> 
>> The idea of having a ctor() would only be a win if all the fields that
>> can be initialized in the ctor are contiguous and fill an integral
>> number of cache lines.
> 
> Ok. Its reducing code size and makes the object status more consistent.
> Isn't that enough?
> 

Prove it ;)

I yet have to seen actual numbers.
