Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425A8C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F0C420827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 01:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HaGahGz4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfAHBxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 20:53:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41483 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727028AbfAHBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 20:53:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so2768578qtf.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 17:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BdxXWNWCwXyo34zuyi/62cZr4j0t4y4EbTTp2nD/nis=;
        b=HaGahGz44oE0fxzBNLN0yUZ9MDPjizLeil/LqGMZ89R5dr3TAC6TkukiBmznTcNvA2
         BaldlFiapj3RaF7a4iLB0+i3e+yRdLxWDzVkwhqfx2dn+UhfMC9U5uNBDzU75g8TAk5q
         oZBvxUUT+eo2K/57tWRmAY7oPWZSWBHgSR+iosAY3RQpP/hU/AaXqgCnxpkYO9G1xIwb
         EljSk7ZQMGNSWKNQpahSJO/UE3GnD3X1LaAjv+wNM3c9lmfIq0CGWB5DVVJ56BhICiqQ
         9DOGV9TlY/Qo8YGSXIwcV2hJHY4TjuYaP3Fhc80Q6Oz6nkffdldmu7/DJJo0OmmGNiKk
         IX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BdxXWNWCwXyo34zuyi/62cZr4j0t4y4EbTTp2nD/nis=;
        b=qcqKM4DluTQEkw7eXI3YicZivvvged8myj2yRsZC0wIeAPIuP9lk648xdJ4/f702oo
         UV6XYaFDKX6WzS/KD7aMKpCtS1qfSK96Jl9s5kUg5zI2saDrD/BPaUf/eNB30tYVhb9f
         63ZJCfYeNNWOQGqlSnT5/aGldaM92IMEGTlm7yv7aFCj/aL5JJzmPFxqCVrkDSEUA2UO
         Qr5aktvUqzWOpIm3RdCyN/P43czRWlhVd7+De5RzmPkx0cQpiIfIv/UGtbmwE/z5w4vo
         Qoq6O3KbzsmIxcI9fvi/ZvKokNZ7j+AvPD3RxkVWmfPvW3sCG/dncZxOzLucV6MVi7Mx
         qMwA==
X-Gm-Message-State: AA+aEWaSTQpw2QTz9IFWDDjZ4pSxnWfrBqCkhNrbqKBtG0kbgKrHtJ67
        tjdb/IMV53z7F06WeZh0kny6BD2x2B+LEQ==
X-Google-Smtp-Source: ALg8bN7rpdBhFKOMZ23/wGoipb5SueQlwiWPSmoYoEcpKTArfUZikR3MH7Ie5/H8KKgx7KtdZdpzXg==
X-Received: by 2002:ac8:2c79:: with SMTP id e54mr62957231qta.17.1546912390079;
        Mon, 07 Jan 2019 17:53:10 -0800 (PST)
Received: from ovpn-120-55.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z30sm41882174qtz.26.2019.01.07.17.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Jan 2019 17:53:09 -0800 (PST)
Subject: Re: [PATCH v3] mm/page_owner: fix for deferred struct page init
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, Pavel.Tatashin@microsoft.com,
        mingo@kernel.org, mgorman@techsingularity.net,
        iamjoonsoo.kim@lge.com, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103190715.GZ31793@dhcp22.suse.cz>
 <62e96e34-7ea9-491a-b5b6-4828da980d48@lca.pw>
 <20190103202235.GE31793@dhcp22.suse.cz>
 <a5666d82-b7ad-4b90-5f4e-fd22afc3e1dc@lca.pw>
 <20190104130906.GO31793@dhcp22.suse.cz>
 <e4ad9d12-387d-1cc6-f404-cae6d43ccf80@lca.pw>
 <20190104151737.GT31793@dhcp22.suse.cz>
 <c8faf7eb-d23f-4ef7-3432-0acc7165f883@lca.pw>
 <20190104153245.GV31793@dhcp22.suse.cz>
 <fa135cd8-32e5-86f7-14ee-30685bca91b5@lca.pw>
 <20190107184309.GM31793@dhcp22.suse.cz>
From:   Qian Cai <cai@lca.pw>
Message-ID: <bfcd017d-dcf4-b687-1aef-ab0810b12c73@lca.pw>
Date:   Mon, 7 Jan 2019 20:53:08 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190107184309.GM31793@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/7/19 1:43 PM, Michal Hocko wrote:
> On Fri 04-01-19 15:18:08, Qian Cai wrote:
> [...]
>> Though, I can't see any really benefit of this approach apart from "beautify"
> 
> This is not about beautifying! This is about making the code long term
> maintainable. As you can see it is just too easy to break it with the
> current scheme. And that is bad especially when the code is broken
> because of an optimization.
> 

Understood, but the code is now fixed. If there is something fundamentally
broken in the future, it may be a good time then to create a looks like
hundred-line cleanup patch for long-term maintenance at the same time to fix
real bugs.
