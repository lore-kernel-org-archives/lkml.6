Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C083C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F2220700
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 21:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="D9380jHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6F2220700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbeLHVZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 16:25:54 -0500
Received: from mail-it1-f174.google.com ([209.85.166.174]:32819 "EHLO
        mail-it1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLHVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 16:25:53 -0500
Received: by mail-it1-f174.google.com with SMTP id m8so4497770itk.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Dec 2018 13:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rbiTe4h7U7Nc5NSaVYiFL9PxC/17RdYPm7MyBNEP2LE=;
        b=D9380jHaWcNVn8Dp2uqmy0bFWYjNQiSxr4k1yez/cR+h4K0NFXgpRX3CCc4fB2yW/b
         MGp0zV6OldM+KcH6wOWLefNcJqiZalULwYeN0qgOZVi6YDPk/ffY8Vju97p/GY5MdVGQ
         wIYPPwfIBWNga8psRT5agqG2081RyuAHmWxxCnqF/dV/nd2IbB34T66qfm8gvxtobeRm
         x4WFF95tZJk4Hr0PNzK46h+VSP4pcj+VemT2SHWPkrRNvNR6ha3zr4+EN+QfDY577Dgr
         UNWml98ixWhpoobUTIx1w6MceSknIyecvY7mItMKqLWzilGZLuEE18GZeaefcPHXhvL+
         iIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rbiTe4h7U7Nc5NSaVYiFL9PxC/17RdYPm7MyBNEP2LE=;
        b=c6Q5GXau7B5pVxSUkn63jE/3rAKrVJNEGZ0uMlDNbRZahssslVsfjXafjUeNGyz/FU
         nRHyN+w080R90vt42sWqciw0cgBKyfBrrI9DugrIXBPW0v7BzHnuH0rHzAKfPuauJIPR
         9/Z74jjuIPRv9d40E6moCe1hokdSfPCgRwCzp1ij+awqOzPEbZD3H23Zo3Asg/nmJAKf
         AHBBqKgwlSMS8p7zuyaSiAIWsw4IrzpgdI/f/m6FZHXhpkJZ3LcT96+xpAT+4tuTEDtD
         Poml03DMHpqjz5Y2e5K2jH9jwxxP5IuJwiynB7x4Nx0X7T0mytiNOaVehCJ6HG352bRF
         TWTw==
X-Gm-Message-State: AA+aEWa4pZ4UNtGL5My/IvR4rxzZf3cKWfhXlfvV0Ys3R7hjXAHt+eqB
        qGYDxYprjD+JvF4n7bKnyIZR2Q==
X-Google-Smtp-Source: AFSGD/Xcpwx9+9X65WcnjcY6JySmATA58+riFe4encWLv4U4SkGm7eWFHUrcOo0X23lox6V6nHI6ow==
X-Received: by 2002:a05:660c:281:: with SMTP id s1mr1039511itl.36.1544304352864;
        Sat, 08 Dec 2018 13:25:52 -0800 (PST)
Received: from [192.168.43.100] ([172.58.142.236])
        by smtp.googlemail.com with ESMTPSA id e16sm3196079iob.43.2018.12.08.13.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 13:25:52 -0800 (PST)
Subject: Re: dma_declare_coherent_memory on main memory
To:     Christoph Hellwig <hch@lst.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org
References: <20181207153432.GA24917@lst.de>
From:   Rob Landley <rob@landley.net>
Message-ID: <994d5106-8f7b-bfb3-4cd5-e190c0035722@landley.net>
Date:   Sat, 8 Dec 2018 15:25:50 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181207153432.GA24917@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/18 9:34 AM, Christoph Hellwig wrote:
> Hi all,
> 
> the ARM imx27/31 ports and various sh boards use
> dma_declare_coherent_memory on main memory taken from the memblock
> allocator.
> 
> Is there any good reason these couldn't be switched to CMA areas?
> Getting rid of these magic dma_declare_coherent_memory area would
> help making the dma allocator a lot simpler.

Not that I know of?

Rob

