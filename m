Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAFBC43145
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69130244E9
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE0FSaD+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69130244E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966948AbeF1PDp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:03:45 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41519 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932522AbeF1PDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:03:43 -0400
Received: by mail-pg0-f65.google.com with SMTP id l65-v6so2590620pgl.8;
        Thu, 28 Jun 2018 08:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HltSYvjY7zxy0qiMOGHI7ftNAwrShkefz6rFC3OAKi4=;
        b=JE0FSaD+2lQr/QTMHIRwwh67Vem2lsiU4yZEYmziZrhn5swz9EVPxKFRPcB/dY2tnY
         dXKYjzEKVbLANDlhtaBBM4UOFhBqPFyyLJacA8n2Nsxf4oBQ0KDQ8xvuAb9C+5F/yG1e
         l+lhulJVgiPsL91smobC6sZpfkOurTZ+ofufBACodO6WGalxQfl8JHNBTsQwH1fup20d
         GoAF/6uC+7ytTW150/NcXIS/b1z7NpA+w9U0rugSy/s7un6Ac8ba97p9dQ7UkhXN7HNO
         l27xDRKlTrANNbdTUE7E7FarT7uIIg/APU251yFn8lV3Inj05+K5GV2qUWpPo1bJXiIB
         QnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HltSYvjY7zxy0qiMOGHI7ftNAwrShkefz6rFC3OAKi4=;
        b=FWxd5NDtM8MySrCFlwD/thBmmg06Ot8yHJmI6tpKJBFilbHTg/hd0/ecQua9Nd+WT4
         uVYTnbmIXbimgFMJuQL0s8+9j0Ju7FB4O/kYKF3rhj/2owLP7gwQJgvxUjPfAdtRZ5K7
         WrU+T+tE4/rP/lfA4Od73qFmoLJJFwIvPAwcaeABAKjzgkHw3R6Vp+bqoJDj00/ym8Kg
         Z1x3J+0TPNqbvw1T9bMzBYvAde6oviL+khSvQBfOxHQhP2URWsgEg90Ow50e7Wm1BeEO
         j5U4vl8kGyPEYUjhF/LMChZpCtDvyfLTpCBNo6fhfd3LpbC/icZ/RdCYaowH80LeoeJK
         vBWQ==
X-Gm-Message-State: APt69E1QQGBfSgCPSMzssbo9IJR+6OMiBzReNaTYsrDg1yuKEF367cll
        jBsL+VZG+Pp5qikOZ0XOCWM=
X-Google-Smtp-Source: AAOMgpc2dgWL633mJxQUhHJnqoUgqa7nB5FMgz3Gj6M6f8sc3zl968c94dW2Sg1Sz50oSv/6Qd0New==
X-Received: by 2002:a62:99db:: with SMTP id t88-v6mr10573842pfk.118.1530198222534;
        Thu, 28 Jun 2018 08:03:42 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id g83-v6sm27353039pfk.94.2018.06.28.08.03.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jun 2018 08:03:41 -0700 (PDT)
Subject: Re: [PATCH v2] net, mm: account sock objects to kmemcg
To:     Shakeel Butt <shakeelb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Roman Gushchin <guro@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-mm@kvack.org
References: <20180627221642.247448-1-shakeelb@google.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <b2bf72da-4980-1aae-0187-cc9353801586@gmail.com>
Date:   Thu, 28 Jun 2018 08:03:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180627221642.247448-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/27/2018 03:16 PM, Shakeel Butt wrote:
> Currently the kernel accounts the memory for network traffic through
> mem_cgroup_[un]charge_skmem() interface. However the memory accounted
> only includes the truesize of sk_buff which does not include the size of
> sock objects. In our production environment, with opt-out kmem
> accounting, the sock kmem caches (TCP[v6], UDP[v6], RAW[v6], UNIX) are
> among the top most charged kmem caches and consume a significant amount
> of memory which can not be left as system overhead. So, this patch
> converts the kmem caches of all sock objects to SLAB_ACCOUNT.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !
