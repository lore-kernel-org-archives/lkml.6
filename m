Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC96C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DD1F20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 08:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CoXKcTai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD1F20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393101AbeKVTPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 14:15:44 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42866 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731827AbeKVTPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 14:15:43 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so7224818lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 00:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=awBduW+I+k1eHWtyBEHp985gPcRm7mSShv7UqrXW244=;
        b=CoXKcTainBwLhuGc+sLt9KYZ4ZPlgirF5Ttw3n0j+A3AHYLBYWnmnIhZsF2+G4H4es
         TR73J3oO/SxYRsXMZ1lyA/DbhykPEm9dSGFqqQ6SZK+ST8GJU+tFAx3iLnfDdNvV7z1T
         C2dqtCj198slG1uZove0jlB5FtXbWt686g2/KNr3Ne3WFjSpsb9iFJT+y35t5OB3I+cw
         /VsHwCpUVaDWiHv0MPB+u/kukazygjHK2jxKtdEXJuHCUjR78Aiw6Bb5dgUIRANXFqS+
         pl9/fvGmIhHPtS2FhctzUQ05PLR0qodifueHfskVFCFlFFwSlYAneJvpPaucPSA4NWmj
         BjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=awBduW+I+k1eHWtyBEHp985gPcRm7mSShv7UqrXW244=;
        b=oBfzw1cZ6/4gIOglzYQSZidZaEhacQpZVBZrjLiCiICRyC4Gu9nmYab7boTLxBhwg9
         Ir4PDHVsAu0/zRaBKKR+bdod3ysfDB5oK1pgMjrF2etBzVz+oKLFUsKARJg1IuR8Ul1e
         cXIhVmgyq0HKotjMvDhLaFGWDebFVxdnOBIkTZCv1YPxd3ZPg6I26lGeLSu7aZok2uSt
         SlRp4zAg2qun5NQZpgNTqjMKrml+BtFrtT6SH6x5o5wh1WGMiRFa5hbmYFwLuts4XOa/
         vpI5r2fW8DCTGVRjx8uIj9lNJqp35TfDU0wwX2woxcAhQSxA/E1g8rNTN8ZgZNsDAnSj
         WbUg==
X-Gm-Message-State: AA+aEWadwH5FeQt7ap8um/M9xTI6EDVQGRAas6B3r9rMYEbGAIXBXGhj
        lEV9wKmNQMbuwLOHF7NR9D/L0AOE914=
X-Google-Smtp-Source: AFSGD/VyrAECM2PjWuL9q2ZSQHSHRVmYIU2vCJIpuSncy9IYxmPdCJ9pNATjc6Les2LHYPPAEIZsFg==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr6254505ljb.176.1542875834955;
        Thu, 22 Nov 2018 00:37:14 -0800 (PST)
Received: from [192.168.0.200] ([31.173.80.84])
        by smtp.gmail.com with ESMTPSA id f11sm7186796lfi.12.2018.11.22.00.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 00:37:14 -0800 (PST)
Subject: Re: [PATCH] ata: pata_macio: add of_node_put()
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     b.zolnierkie@samsung.com, axboe@kernel.dk,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181121130439.22255-1-tiny.windzz@gmail.com>
 <e45f832b-ef98-e419-6082-27dd7ced71d2@cogentembedded.com>
 <CAEExFWvw1tw-AWbp1beajZNCRLYQXdiC6ifMvGc5_po64i_GtQ@mail.gmail.com>
 <CAEExFWsLP0oJVDV1KBENwsFKZ52ygZ18DQp1g1ah4a1ZmxeJLw@mail.gmail.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <dabed310-3b2a-49b9-9297-625bf34a7f48@cogentembedded.com>
Date:   Thu, 22 Nov 2018 11:36:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEExFWsLP0oJVDV1KBENwsFKZ52ygZ18DQp1g1ah4a1ZmxeJLw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.11.2018 18:33, Frank Lee wrote:

>>>> of_find_node_by_path() acquires a reference to the node
>>>> returned by it and that reference needs to be dropped by its caller.
>>>> bl_idle_init() doesn't do that, so fix it.
>>>
>>>     I thought we're inside pata_macio_cable_detect()?
> Hi Sergei：
> 
> Yeah,this is a typo.
> Need me to resend a patch?

    This is more of a question for the libata maintainers (but I would resend).

> Thanks，
> Yangtao

MBR, Sergei
