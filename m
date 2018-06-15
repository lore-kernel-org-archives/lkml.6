Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2D146C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59A5208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I6267hHT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D59A5208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756229AbeFOOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 10:16:40 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45849 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756209AbeFOOQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 10:16:38 -0400
Received: by mail-io0-f194.google.com with SMTP id l25-v6so10801355ioh.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nXOrzapn5WG3GDHtSsZjnOKx92CxVBjGyuQ6jaMF2ac=;
        b=I6267hHTJfZ0+QiQ11EOQKb2wnd0hOFByal2U9UbvarftIvoGAHMLtleCPW2TxFeUG
         bCoF7Ggku7vA7Q0sfkpPMq/noPpVUi/SXO+nd14Nn69Wt6N5v9yvQ8AjxoOdKqnWMeIZ
         rZsWMsiAiyu8dfnI3q62TLfYck7znPqh4cR3bd/LMU20QCCr3duWg8BpX4tux3m3Y/q+
         W+tS0DN9ITPcG07wounzSdoRzAJY2mlwslLbbSxTH+O1pnkgNpfoRRsccZJuskO5sdPt
         PovzUr6ijWXEtbufVuEBFadu+X9S2X6g1eUYpLyn3FxP9k5GT+19SwCBcfGKZX4a7qor
         M76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nXOrzapn5WG3GDHtSsZjnOKx92CxVBjGyuQ6jaMF2ac=;
        b=Tw2PWSCs7J7eHMjoNdwc30L0E8qSBkcpCTKHvhd07xyFYsByyu7CGg1WcO1cRve9oP
         xbYkDYyhu6LLKOZhYjDJDcMhlyRJHG+7oO1fQk+g/ay3v8aVP0j1/cvtn8owvLHMCqUM
         jgVX8uqAzg6mER79WNi4FbsOTd9K6awOH58tx4qdjQxglwTbiWAALSiFxsvK1zqNxp3Y
         HIGJNdhImOYDvuN46EbDt6QL/wYJmg7X1od62Z8vKI64JpcU7peoDqkpNvJ3mIZ3G+m7
         9AswYj0N0pnMNr4amzzlp+ZR/JKKmQ1PTOcO4XFHXWAT8GzN6hbSbFq85R/HkJH+PoKP
         EtyA==
X-Gm-Message-State: APt69E3P2kMnf0aaXF/esdrz5Vjcm53tS7CyBg3c1o5oYjziAH9JA594
        lYm9XtBWVWyFaBABr+Fmw4rysySHZ0w=
X-Google-Smtp-Source: ADUXVKL8fOkZDbrxr3DYRwZ69tJObsNjvoLglAvHJv3IpPwuiI20C6rHdaPlI2MQj8y/VmZp+se46Q==
X-Received: by 2002:a6b:3bcb:: with SMTP id i194-v6mr1621928ioa.86.1529072197412;
        Fri, 15 Jun 2018 07:16:37 -0700 (PDT)
Received: from [192.168.1.167] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u8-v6sm2918084iol.6.2018.06.15.07.16.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 07:16:36 -0700 (PDT)
Subject: Re: [PATCHv2] block: fix bsg_unregister and bsg_open race
To:     Christoph Hellwig <hch@lst.de>,
        Anatoliy Glagolev <glagolig@gmail.com>
Cc:     linux-block@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180613221417.GA22778@xldev-tmpl.dev.purestorage.com>
 <20180614083806.GA18966@lst.de>
 <20180614234733.GA38460@xldev-tmpl.dev.purestorage.com>
 <20180615092741.GA21138@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <da65970e-cda6-6170-eaa2-1fe2a1b59322@kernel.dk>
Date:   Fri, 15 Jun 2018 08:16:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180615092741.GA21138@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/18 3:27 AM, Christoph Hellwig wrote:
> On Thu, Jun 14, 2018 at 05:47:34PM -0600, Anatoliy Glagolev wrote:
>> Thanks, Christoph. Good catch releasing the mutex on failure path.
>> V2 patch with your suggestions applied.
> 
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Now just re-add the changelog and resend it in a new thread.

The original one was mixed up, too. Anatoliy, I fixed it up for
you. But for future patches, please follow the usual patch
format where the commit message is actually in the patch.

-- 
Jens Axboe

