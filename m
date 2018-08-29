Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C5C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D2120850
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 13:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="TMSTM0st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42D2120850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeH2RLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 13:11:32 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39518 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeH2RLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 13:11:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id g20-v6so2313812pgv.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BSbG1nerDnntos3ns6rZmwGyFHyfLd9aSptL0wreB9A=;
        b=TMSTM0stEef3V/n72x997qDmdR9Xt8JGwnzHuh+320dMedJ0oV9yVS3Hq1nwVvIbq5
         E3GWmp9Kh6lEaIkyLCzhEKAQk6JnHS1j5RRmvbI4Qv/NK7WJjigdYntbXMOsSVFLffk0
         9gWdA9D19CCsyVZUtnSRnyzmSMqmQLdAcBon60vMcaP1jkNjckCBMQlG2/91l5CbC6QJ
         jV8wyL7ePFU6tCbSzsKXMUb1FHhhgOwm5K5FXupEDkDRDF9Xkf2hDXG2p3TcXvyxl2nh
         Z4NGFQyiBhaWwic6P17nW0kED5h6NA9s+p9a1KM7W22viPKe4F9nq2Gt6qa7DJmkkpbF
         H4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BSbG1nerDnntos3ns6rZmwGyFHyfLd9aSptL0wreB9A=;
        b=pn8tk3oUawVIOBQ56duey397eymQpBZyDa0TVuHBmmVUsmu8tZCe8MzrsDASMjsiSQ
         IkT4jWXcti65ekBbV3zc76t9553CWmybikI7oExLPN7/Icn1cCEfy+Y73QrsrLzSzcgO
         XVDGXFFaePDWRqjOsNrg7wufrY5M7uP86BbVNeFl/f0A7p5KyPWpO7vFNG/Fv9kVTOt+
         bK04XMJVmM7vwJhyAqTuvGnQqDwbSemTcsGVv/GA49rXXAub6YudVsy7fpbe3HER9xec
         /czJudy/PHaLvyEut9++8f7uVKtP+PDgF6PK22f9apmBM33Q+kab2rWGZKUIujcfPA25
         caeA==
X-Gm-Message-State: APzg51CdmpEONvbIIe7T8jwyuJS5giidYzje3dp8+tIrhpeMbWTVyS54
        fpMByg30/1XHwUooBrY3pmsMhBI7yfgtAw==
X-Google-Smtp-Source: ANB0Vda0SMlsi0UPHQwJyMxS/X/DrdKtRYePxVQG/OZpjGl0JPF6JLU81WhpUa5buKbpWb0Y38bmwg==
X-Received: by 2002:a63:4207:: with SMTP id p7-v6mr5647500pga.201.1535548477756;
        Wed, 29 Aug 2018 06:14:37 -0700 (PDT)
Received: from [10.86.62.45] (rap-us.hgst.com. [199.255.44.250])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm6611757pfk.69.2018.08.29.06.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 06:14:36 -0700 (PDT)
Subject: Re: [PATCH 0/4] lightnvm: pblk: collection of small fixes
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        javier@cnexlabs.com
References: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <5b8881cd-019a-a1d8-86ed-0131ef3b71af@lightnvm.io>
Date:   Wed, 29 Aug 2018 15:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1535533313-29944-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/2018 11:01 AM, Javier González wrote:
> Collection of small helper function fixes, removal of unused variables
> and comment typos.
> 
> Javier González (4):
>    lightnvm: pblk: calculate line pad distance in helper
>    lightnvm: pblk: fix comment typo
>    lightnvm: pblk: remove unused variable.
>    lightnvm: pblk: guarantee emeta on line close
> 
>   drivers/lightnvm/pblk-core.c     | 13 +++++++++++--
>   drivers/lightnvm/pblk-recovery.c |  2 --
>   drivers/lightnvm/pblk-write.c    |  2 +-
>   drivers/lightnvm/pblk.h          |  6 +++---
>   4 files changed, 15 insertions(+), 8 deletions(-)
> 

Thanks. Applied 2-4. The pad distance does not compile due to missing 
update to pblk_pad_distance call from pblk-recovery.c.

Also, it looks like pblk-recovery.c is the only user. Please consider 
moving it the function from pblk.h to pblk-recovery.c
