Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE9BC7112A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FE7B2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 20:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g7B8gieX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FE7B2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbeJOEPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 00:15:38 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40025 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbeJOEPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 00:15:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id n31-v6so8143064pgm.7;
        Sun, 14 Oct 2018 13:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qq7E9tZIOUP66Jct/ZaNP10oZaz1YOnIRdk4bc4qiiA=;
        b=g7B8gieX2Vf6VToQWbpPRDPPwLAU4/AMfLYXkbMVZERJ0uXgeTq5oEFryApgg/vbx5
         hADhxiph/6ZK1ZAMERIDMWpMt6HnUDXDTp0FADhjg0m+JnR3I0JH1Sor0b8s5qWKrvN5
         /dH+FFkQq5FwaAz92ijswKw24M9UFbUOcXG91zswc4RS0vIi6lNV97RFUtm1cKqZp7UF
         BvhLr+qbQ80fse+AhamGu5RDvxtPjcn4EiUt7vd7g2aeR7vDhwlJMLvFYXp2nvB12tW+
         xWIMxZFqfHo80umkSOLDRG6TNEfGVOUD2fO9DK19XAbf1AUZc4pU2cqffjpW/Ljas9i1
         n/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qq7E9tZIOUP66Jct/ZaNP10oZaz1YOnIRdk4bc4qiiA=;
        b=NUADuFHCwmRfeyU+sWVD3L3ZWVS5+sj/n7Xq7ODQhlFZMfZp/n+2MU4/qrJwHUY0jG
         +iQ6lUWAmM6Z7QRy2rjJR5D3f8cGPTJCWq9z6aWb1UgdPxFhBxfBnSu0dET+h92vjh/V
         d1rUvT4CDVbFL/poRYzyA5i2TWe+L72qLOLEfVSyrcdxiiMStolKD1hhjxvndiUT8U7K
         6QWmtu/VdVVSL32RaBESvsOhLOkDpnqgdw7VrYWGEDfC8i1sioAYOvcRMsVphmftcTdV
         skzckCfXZIvaf+pA3bEztaHpF/vbZkANQi5/SCUqyiN+liWxOla0WlfZtOOKKQ8iiZmV
         7xZA==
X-Gm-Message-State: ABuFfojaT9sAESiJ2A0RJTX9I2UhXm12dHbCmynwvFwoInS8pgLEeOJs
        7zWrk5ia/Ux8gXBWyHhknRwMNvfUPts=
X-Google-Smtp-Source: ACcGV63+fEypMnDnCIgA1u2374PoIz6rJKtP4MQvlR6448OvGJkPMsQMGDp6TfIDFB/ZJfu9IINhvA==
X-Received: by 2002:a62:6c48:: with SMTP id h69-v6mr14671697pfc.61.1539549205557;
        Sun, 14 Oct 2018 13:33:25 -0700 (PDT)
Received: from ?IPv6:2001:df0:0:200c:9c82:66af:8a08:b31e? ([2001:df0:0:200c:9c82:66af:8a08:b31e])
        by smtp.gmail.com with ESMTPSA id s80-v6sm12049583pfa.114.2018.10.14.13.33.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Oct 2018 13:33:24 -0700 (PDT)
Subject: Re: [PATCH v2 3/6] esp_scsi: Grant disconnect privilege for untagged
 commands
To:     Christoph Hellwig <hch@infradead.org>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.de>, linux-scsi@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
References: <cover.1539497520.git.fthain@telegraphics.com.au>
 <91b9ff9fc19ba40e3a2562171c8cd78a2ce7dc79.1539497520.git.fthain@telegraphics.com.au>
 <20181014154753.GA19252@infradead.org>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <4719e984-2c7e-33e1-6e7c-16dea5d4f610@gmail.com>
Date:   Mon, 15 Oct 2018 09:33:19 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181014154753.GA19252@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/18 04:47, Christoph Hellwig wrote:

>> +	*p++ = IDENTIFY(lp && (tp->flags & ESP_TGT_DISCONNECT), lun);
> I think lp should always be non-NULL here.

That indeed appears to be the case these days.

So we can't rely on !lp to detect when probing the bus any longer. What 
else would be available? Do commands used for device probing also have a 
tag these days by default?

Do we really need to make that distinction?

Cheers,

     Michael



