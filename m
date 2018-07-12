Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E38BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D34213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="OZuX+OmK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D34213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbeGLOUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:20:48 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42651 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732302AbeGLOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:20:48 -0400
Received: by mail-lf0-f67.google.com with SMTP id u202-v6so24360431lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jFIjIR9zAMemSpAVMXJwPMoz9wcT2eXmL9isfi8GwhY=;
        b=OZuX+OmKvTzpZ3ZH6M1a62OmT3RloyYStj39ggbPVnGjKCZk5UyjlriZs9op49Q0nf
         m3iv86gsnisob39eVPkj+VGFuC7/GpfmfO4fGR513jVzRmuOyt285JXdIfRuSg6o1Lvx
         gcKypgd5cbcU+qJy7LS8J1+y2WzAusw0Csq8PtLm0qGVFJu6VJiE/szYS5t+S6Mlr0dl
         grfkCyg92PkAFuHD/hsH/gZGpqonvX+ZYNwWyvJFYCcRxhUJIDqW/F3e1IyWZPlBMFh9
         whuNiWJlu2arV6TaMCWAS40P4vRe6Le3CFK0KmSs0yZrM+ILFIwBhV0zids1phqnUsEr
         SYhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jFIjIR9zAMemSpAVMXJwPMoz9wcT2eXmL9isfi8GwhY=;
        b=OKD6jXMSNUEy2zcGpZDWhD9SUzTcs9fHCzKgVBuvtidcD4l7gInlR9lazzaKakPShY
         m9Q0+guxz5x4iniKoEvuRV1LcIUtypmCh+ENbF4Qs4N0W0McsdYywZ6oyI2izVnWicpR
         am5CwgpTePkbOM9JYq54zJITrEepjGFtf+x6Og72Qu7NfbmWC79TQ/1+Yu8F8bjs+sGj
         aAO9l9EpHoFbjNky8Spuiz6Ex1bC8klHnqE9fHfePRfc5rMnYr2Wje8j+lEAjGSXEFuN
         a0zwPIBXzDCRrTHAmufvAHqr/pKtWRsO98xErVyJqfloIpa13BFrp/HPpV1zzoTVuq+M
         aA9w==
X-Gm-Message-State: AOUpUlGJZhJ98fMq37BnJjlRg+b7PRkvz8Pd7RXYtGhmag74bj6e0qdY
        IHSgjekMBqj01GBdocxYu3lP2g==
X-Google-Smtp-Source: AAOMgpd6NMD4WBfzaqkJc4gcYIkG+JVxC88zOigtWL18UqpKZlX7o0JGobw1kHjX/krM3IvMXLCgZw==
X-Received: by 2002:a19:1190:: with SMTP id 16-v6mr2163416lfr.122.1531404661810;
        Thu, 12 Jul 2018 07:11:01 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.86.198])
        by smtp.gmail.com with ESMTPSA id q21-v6sm3392855ljj.68.2018.07.12.07.10.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 07:11:00 -0700 (PDT)
Subject: Re: [PATCH net-next 03/18] net: mvpp2: make sure we use single queue
 mode on PPv2.1
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        thomas.petazzoni@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
References: <20180712115427.27375-1-maxime.chevallier@bootlin.com>
 <20180712115427.27375-4-maxime.chevallier@bootlin.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <9fdd233e-5f22-aeb3-c179-f14c6bb960e7@cogentembedded.com>
Date:   Thu, 12 Jul 2018 17:10:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180712115427.27375-4-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 07/12/2018 02:54 PM, Maxime Chevallier wrote:

> The PPv2 driver defines 2 "queue_modes" :
>  - QDIST_SINGLE_MODE, where we each port share one rx queue vector

   Doesn't look like "we" is needed here.

>    between all CPUs
>  - QDIST_MULTI_MODE, where each port has one rx queue vector per CPU.
> 
> Multi queue mode isn't available on PPv2.1, make sure we fallback to
> single mode when running on this revision.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
[...]

MBR, Sergei

