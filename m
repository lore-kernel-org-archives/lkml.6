Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD454C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6444B20894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 19:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jfUWn1dX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6444B20894
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732091AbeG3V1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 17:27:05 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38081 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728769AbeG3V1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 17:27:05 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so4611492edr.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 12:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQHccsI/dNFLOvVRG26eJBfs92saA1z4R8KeTSZ66xY=;
        b=jfUWn1dX+GFVonF4LOi6WvvtTu08hJz/Jw0GueHPLloWOf0N3iLXjrWsuE0mS0Q4xf
         SClHLi5z2C/y8tzJqQPv32e190aXd5nU6zbk6wsCmYmUkljhJMte+dMHRQW2f4EsyK0H
         EnjkTVeGvkFY0L8GUQKxAQunYB2X6YESb17RpFE9kSa7us4bJJZdEFzo8bmWxG6cAghQ
         NihqSRK0JrHdEJXnOTuRHiImtPxMjqfOVGaroSAxV6dyMJzAo8K69/VcNdB2BRQ/Imd6
         +4tdrrBt8yyb8gP5ab3bKLwZoKbHG6yt8prn9forqfP037lZMQiVt25ijOe9UUs7FMPs
         xrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQHccsI/dNFLOvVRG26eJBfs92saA1z4R8KeTSZ66xY=;
        b=ReqNYNgXP6eK0YkU+RnvzHjF/EB2X1clVGrn09tCHPB4WROE7E56GKiB2CG1O8ccfV
         uovmDqchVaRqBKzAjarrwPnFVehcyFteDHV5+iiUdgwiCXuXxT6iZ5076XnuLzSID7Xm
         umXTSBjbrH71RGDhMcovnOk7j7bhhycFwqmtthiDZYdT79ekUGvYqbOGtSzCP3GK0RL6
         ywvgt5b/I3jCT9hbo5JN8mDvFqOa0NbORiqppzE9VB6DbZUMv5L6XVSdD8Q4a0fUnVqM
         Gl1K7lVQor4ZoF0i89lln5fYjrvWiVEi90m5kCDilUpfNhYhrBU1bXKwrG+63zBu6unA
         VEkw==
X-Gm-Message-State: AOUpUlG2k/1euEHcF0/1dZt276tVfiRdGfOxDalMjbcizbVjj9Ii1Mfo
        KBKayOrwOWsWG3kwMIx3Ce45rQ==
X-Google-Smtp-Source: AAOMgpeIV3rCMwgjf83QM4pDK3mLWPmXcuRWhnnmfAy3MRZUaSbjRnhPG+Z+YI+NdvWx0QN1lWZLLw==
X-Received: by 2002:a50:a5d8:: with SMTP id b24-v6mr9486396edc.235.1532980231249;
        Mon, 30 Jul 2018 12:50:31 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id j10-v6sm2565569eds.8.2018.07.30.12.50.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 12:50:30 -0700 (PDT)
Message-ID: <1532980229.2679.34.camel@arista.com>
Subject: Re: [PATCH] netlink: Don't shift with UB on nlk->ngroups
From:   Dmitry Safonov <dima@arista.com>
To:     David Miller <davem@davemloft.net>
Cc:     linux-kernel@vger.kernel.org, rong.a.chen@intel.com,
        0x7f454c46@gmail.com, herbert@gondor.apana.org.au,
        steffen.klassert@secunet.com, netdev@vger.kernel.org
Date:   Mon, 30 Jul 2018 20:50:29 +0100
In-Reply-To: <20180730.124330.538236571439983894.davem@davemloft.net>
References: <20180730173236.20968-1-dima@arista.com>
         <20180730.124330.538236571439983894.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-07-30 at 12:43 -0700, David Miller wrote:
> From: Dmitry Safonov <dima@arista.com>
> Date: Mon, 30 Jul 2018 18:32:36 +0100
> 
> > On i386 nlk->ngroups might be 32 or 0. Which leads to UB, resulting
> in
> > hang during boot.
> > Check for 0 ngroups and use (unsigned long long) as a type to
> shift.
> > 
> > Fixes: commit 7acf9d4237c46894e0fa0492dd96314a41742e84 ("netlink:
> Do not
> > subscribe to non-existent groups").
> 
> Please, in the future, format your Fixes: tag correctly.  No need
> to say the work "commit", please do not chop up the line no matter
> how long it is, and please provide 12 digits of SHA1_ID value, rather
> than the whole thing.

Oh, yeah, I have this in .gitconfig:
[core]
        abbrev = 12

But I was formatting this not on my laptop and have managed to mislook.
Sorry about "commit" and the breakage.

> > Reported-by: kernel test robot <rong.a.chen@intel.com>
> > Signed-off-by: Dmitry Safonov <dima@arista.com>
> 
> Applied, thank you.

Thank you.
