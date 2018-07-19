Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BC7ECDE5F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DDE20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 09:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="VJzIc+DO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1DDE20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730505AbeGSKOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 06:14:16 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:40676 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeGSKOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 06:14:16 -0400
Received: by mail-lf0-f67.google.com with SMTP id y200-v6so5535532lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 02:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=44Le2voIl4GAmtAKB8mNnUISxwN1gLdA3zJqVNb7phM=;
        b=VJzIc+DO427lDcjD2UoEIULysGzlKvhxMztzS+/GohtZxoR9vnxxV5zeu8m1muiDKH
         r5xIIfdgNqQTH6dSGgC4EECx1BFm3hCEGzhf4UUa0R6UDYK4fXMhosPA6XQwqAtbXWZY
         ZB7se5+gLyG4qTxnFi5NKbS3PiqpcdVzenhS1bwX5fcEEkdNS5yHwZiA2/PgA41fj5FD
         vKwxp3JMkGE6i7RggcBU0Kil9Y3HsFJ5YjX12F6Kuew1857Uvl1NCRu3ZFaAlkmngeFE
         Kw/eyS2wDr0RdOQ2LK9BlfsHIqq3laVRdlDRK0oKtW3r1+bJvgQciWN5HOe3nzKDJ7SZ
         6avA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=44Le2voIl4GAmtAKB8mNnUISxwN1gLdA3zJqVNb7phM=;
        b=iU3T0MjatyCGc/8gODYY4wAtrKleg41eEWCIOv6v532/YTErQNFttx4YMdLDvNdMfE
         ObOfT8TyZNgvBRKAUg4Cx1u/LSkNHaVTefZ9g/ks9TkhXeXn3cGPELHXrUabO77t5Rso
         I7XYsR1pyLrx5yBgTlfgmZiPIMi0pHrhJ+yp88GOH2LdfBsfYTYiX3NIJsw2FUV9Woz9
         jaFV2HIV6awmg4Mopsm/a+yQv045Po76CRgDt4EutW2oicjR/pVX0CsRjZ9AS88efBpl
         0QBwAVQxH62toVUTblbmMO6RCgml2hwveG3ul6AbqA43n2+gXwIQSSASSZxgWWJG1ao+
         30pQ==
X-Gm-Message-State: AOUpUlHJJuxD5j22JBgw9Yc/bRjRPojWjalPSYxBtuZzdC1t8Q4RUA3n
        gLk1joXhWlYZI+W3fY8FFX5P9w==
X-Google-Smtp-Source: AAOMgpck3rv1rylM0kOiK3zMh86NEBF1dCUkww6geYNx4ECPLsC4xYGf7uo+GdUf9yhMfnKdtUsAtg==
X-Received: by 2002:a19:e307:: with SMTP id a7-v6mr5979004lfh.125.1531992718114;
        Thu, 19 Jul 2018 02:31:58 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.87.106])
        by smtp.gmail.com with ESMTPSA id g3-v6sm887889lfk.72.2018.07.19.02.31.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 02:31:57 -0700 (PDT)
Subject: Re: [PATCH V4 net-next 2/3] tcp: Add tcp_retransmit_stamp() helper
 routine
To:     Jon Maxwell <jmaxwell37@gmail.com>, davem@davemloft.net
Cc:     edumazet@google.com, ncardwell@google.com, David.Laight@aculab.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
References: <20180719011444.4694-3-jmaxwell37@gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <f09fda0d-4827-10e7-c365-2e92a488d623@cogentembedded.com>
Date:   Thu, 19 Jul 2018 12:31:54 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180719011444.4694-3-jmaxwell37@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 7/19/2018 4:14 AM, Jon Maxwell wrote:

> Create a seperate helper routine as per Neal Cardwells suggestion. To

    Cardwell's. Perhaps copuld be fixed while applying...

> be used by the final commit in this series and retransmits_timed_out().
> 
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
[...]

MBR, Sergei
