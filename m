Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D84C65C30
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ABE20882
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 08:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="k+a4vqGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93ABE20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeJGPi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 11:38:57 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46752 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbeJGPi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 11:38:57 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so1525039lji.13
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 01:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3a9ymhh2MnehDz22UnwDjqto72Z95nUBhKDlTDnID8g=;
        b=k+a4vqGDl6cynYjlMFuEfK3PjVSl5bzbDV/AEA7be+sI6v25mhtUBvoB/VzV3NmavD
         3B1+4E/izQzt5/B9cfy7vABa3+Ki3zpjq0e5HtIkOr2xNxG+3UYamFGupg5cbejpOKvW
         QroQGuP+D6UsXuOSEmzuC/9L/dKu26mnaxXq/8+zkj2X4LQgSJmH8XfpyB9HasIqtv8W
         MSGxEk76Nbl2SnDWpAux8BCQcjEcc50RbswOWdnSWKEf7FTe1V4nmUPf+exmqpwV9qPf
         p7YMu9XroHKk4EaUs66X3jbdqu0/5+5TGPsPejFhP/R4E1ac2ib3qjeuHuBcbLEjO1qf
         3p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3a9ymhh2MnehDz22UnwDjqto72Z95nUBhKDlTDnID8g=;
        b=qd+qw/fkevv2fcqpgfYhL0aRL5ljVI6NJee5RMfFvkSHtibBIDkAOFl/AtLOxEFfLB
         +0MZ/fmnB0SOQshZmzz54omakbfpmXhXEIi5VkWKvPz+4me2DBwiiHoim285kaVHlJLn
         45ns6yFLNgZ54G/w/peOn7wKSSRJgsSfOCOWpHJbI4Uy6kZecX/siPRj/ic+9edw3IT/
         zqYBSh9ftvlq1gtD6uVFWGPrpIYJrhowm72TDyTKQdyQpCIaSqL3YcHJ7NDv5UKH8rS0
         DaHWuFV9T/iUOJWhe5OIxlZvAEGYNPr1/McQ1uYgdtSbnh4b86hFTYyWdUerQoRZHHef
         zQQA==
X-Gm-Message-State: ABuFfoiJ7piFzjXxCOGepupOeE2CXHOxsozHQXV4cJN8lPCVgSoc6SLb
        wfVok7WQBZfKfqEQ9lRe09RS0g==
X-Google-Smtp-Source: ACcGV63Fdj5A9pbNxA4fhNXEf50JCMctJljujIVWvk236mMlrax8HX3JqmSteZ0VA1vTnCO5gBfI6Q==
X-Received: by 2002:a2e:47:: with SMTP id 68-v6mr12516071lja.123.1538901144408;
        Sun, 07 Oct 2018 01:32:24 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.84.205])
        by smtp.gmail.com with ESMTPSA id t15-v6sm3114284lji.75.2018.10.07.01.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 07 Oct 2018 01:32:23 -0700 (PDT)
Subject: Re: [PATCH net 1/2] net/smc: use __aigned_u64 for 64-bit smc_diag
 fields
To:     Eugene Syromiatnikov <esyr@redhat.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Ursula Braun <ubraun@linux.ibm.com>,
        Karsten Graul <kgraul@linux.ibm.com>,
        Hans Wippel <hwippel@linux.ibm.com>
References: <20181006203222.GA11338@asgard.redhat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <5e806c98-e313-6b47-92d1-65ab7f81589b@cogentembedded.com>
Date:   Sun, 7 Oct 2018 11:32:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181006203222.GA11338@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 10/6/2018 11:32 PM, Eugene Syromiatnikov wrote:

> Commit v4.19-rc1~140^2~507^2~1 ("net/smc: add SMC-D diag support")

    You have the SHA1 below in the "Fixes:" tag, need the same 12 digits here.

> introduced new UAPI-exposed structure, struct smcd_diag_dmbinfo.
> However, it's not usable by compat binaries, as it has different
> layout there.  Probably, the most straightforward fix that will avoid
> the similar issues in the future is to use __aligned_u64 for 64-bit
> fields.
> 
> Fixes: 4b1b7d3b30a6 ("net/smc: add SMC-D diag support")
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
[...]

MBR, Sergei
