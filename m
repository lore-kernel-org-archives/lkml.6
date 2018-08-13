Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E673FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EFD82174D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 14:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Balio23K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EFD82174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbeHMRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 13:23:08 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38792 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbeHMRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 13:23:08 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so6975069plq.5;
        Mon, 13 Aug 2018 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S8ydu7FuOyuDNW4p84AkL7izSNiy2omBhsZ/7ojOpwA=;
        b=Balio23K82rKCHgE78woMuxF4VhSkBjeVipL8T3gYrJ9M730D2zbxD4JebeFvbP6fx
         sfwVUpbopu/fuk9+1jwvwAuw4oBy6fgBQXGFlLx/8sW0vmh9B+2z+QowaGkLIuh3NaK2
         nSvbfj8pzLuoCWZXJIfIox2Z3W4OICen7aCdjKPHthvLDIz/uKvIWRsR2D2wo+k9OTbM
         ijTHN1raXEYTF0nacNwmnLdtPXjvZLK9sV2fr3X53fj8FSnziHZlR45WxQtLEQS6Ayc5
         aCwgXXh8FVGiJYXTSgCkgJcqU2eczJRZf+ZmvD4cj1EDJQ/AnfRCxXHovSHzZ4anuuhw
         hwNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S8ydu7FuOyuDNW4p84AkL7izSNiy2omBhsZ/7ojOpwA=;
        b=PV/NJ1qYn9cGZX//4bJbK0B+RiUxeXhZhYJWV7pyZ3BHppZp+s2Nl1vLv5pisPFHmj
         WMC/8uLuZ33RK1kMeIbiL08dAehoSbwoaTn+w53BRyMjWDAwUvoqpLEp6co4kSo+24sF
         a876HtWzy6HqbqEu8Ry41+nG1MfG2D7Xvxv/YiuA7s8VfWvvtD3TFzvmgP0WZv+Nlczg
         iH4AY2YveZjY1q3oiCSx6XWXpPfUdPGhTT4KwDTFgl/VaOSqxhMSwuypxbUVqWfHyHUd
         lyGwnkiLLMG5XVqBBSfWs375cZUzHCSwrGc/i7BFa6PsqWwHwIZ1mxVRjd6fhdozaOap
         GgLw==
X-Gm-Message-State: AOUpUlFVvfLvmGzbS0Gnmo/sZFR3MdS/zA3cAIhahGcf57hHZDKBzlZG
        blgVwgs8i1NoqDeFY9EEW/8D6ZgP
X-Google-Smtp-Source: AA+uWPxSBzjkcEdePdJkYrrqA129V6REPWcE5xiJ5keyqeGSfYwrgZGsRbm2jPXAvN2s7iBFE7OJkw==
X-Received: by 2002:a17:902:1081:: with SMTP id c1-v6mr4066081pla.277.1534171235200;
        Mon, 13 Aug 2018 07:40:35 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:fc20:f6ce:b02d:5bac])
        by smtp.googlemail.com with ESMTPSA id l70-v6sm26968835pge.64.2018.08.13.07.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 07:40:34 -0700 (PDT)
Subject: Re: [PATCH] net: Change the layout of structure
 trace_event_raw_fib_table_lookup
To:     Zong Li <zong@andestech.com>, rostedt@goodmis.org,
        mingo@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zongbox@gmail.com, greentime@andestech.com
References: <1534127212-13186-1-git-send-email-zong@andestech.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <e9697bf5-11eb-68ec-238f-aedb724c8c17@gmail.com>
Date:   Mon, 13 Aug 2018 08:40:32 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534127212-13186-1-git-send-email-zong@andestech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/18 8:26 PM, Zong Li wrote:
> There is an unalignment access about the structure
> 'trace_event_raw_fib_table_lookup'.
> 
> In include/trace/events/fib.h, there is a memory operation which casting
> the 'src' data member to a pointer, and then store a value to this
> pointer point to.
> 
> p32 = (__be32 *) __entry->src;
> *p32 = flp->saddr;
> 
> The offset of 'src' in structure trace_event_raw_fib_table_lookup is not
> four bytes alignment. On some architectures, they don't permit the
> unalignment access, it need to pay the price to handle this situation in
> exception handler.
> 
> Adjust the layout of structure to avoid this case.
> 
> Signed-off-by: Zong Li <zong@andestech.com>
> ---
>  include/trace/events/fib.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Fixes: 9f323973c915 ("net/ipv4: Udate fib_table_lookup tracepoint")
Acked-by: David Ahern <dsahern@gmail.com>

Do you also need a similar change to fib6_table_lookup in
include/trace/events/fib6.h?
