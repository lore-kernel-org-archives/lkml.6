Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA854C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A1720875
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 15:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WU0GpXWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70A1720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbeI1WFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 18:05:35 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39841 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729138AbeI1WFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 18:05:34 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so4591279pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 08:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RUq0l2SYHD0AG6njdK8y747K5Y3V9hOROgJ/1m1Z7ns=;
        b=WU0GpXWlfnh4Y3XeaCoUEzo03NRxZSXiqNsXGQXgrz0znuJxr0s5L1QeHZjzpj1KeX
         GEqwFG3WtTto75/MrYVhCnZ4ZZTYhztxAmLsbGSYWAUz6pPX9gz0dYfgMRN9DMPUqhje
         P+fD5TyAAs7+Or+SifI3RPbsxrSjboHGBIE+0JCWRTiSoyVVkMS4Y7CjmDsnuPJMKzZE
         TQOj4nXFVnyfTkAW4tfrWrClfhq+6LvicvOic9u4bT94fNT0XAg2/YVfcMnFhXIcXmUz
         9O9diQzLA015njWeRwBc5blfsu2fV4gGMceJ9t1q8JZWoHJ30twFV+zKUV+jfLyquTgj
         VJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RUq0l2SYHD0AG6njdK8y747K5Y3V9hOROgJ/1m1Z7ns=;
        b=Pmi7BR1WEoW3T6IMS3+AxEAAVxhkORSB2pncQwjfNoVrmkc99z/Bj4OkWKl3vmQvsI
         c/tnGvffG0uG87/3m1hVo3b7Bv0xj8Xuy6QMRqGHUVJr5SxlsKtjbfgTcGp6ZchpOq4D
         CwN4WTitDeuC5hVwIvl4pQ/U0wYzpFzoFHX9PEFywa2lwef4N8AwBmwPdOmbE3nFnUIc
         DfvAXQz0W8v5Ndx8AeJ/7FN9S/H9mJvycDM1MBt+fW7mS3+319mf+SReOQ+8e3rC+tFU
         UlfI7uVBVHWKU8hoSG0LLwegyazgiJMEOXqi/456olRlEqUF+l1upLcLpVD/DKr/V/bJ
         9YSw==
X-Gm-Message-State: ABuFfohiUkbPSFsK9zn5XvS7cW1v7u5rExe+kgx+26mSJSdhic871I/f
        +Ii7ZMjaSiOZzEHZTJi5qJ0dFQ==
X-Google-Smtp-Source: ACcGV63DC8GQKKm/DeCj0LHjQpwcwkG8ojFK70Qa5FVqVJ0rVcnB8O+8+wHWXG+zDi2zXgDZM2pVPA==
X-Received: by 2002:a62:a0e:: with SMTP id s14-v6mr15218019pfi.153.1538149275728;
        Fri, 28 Sep 2018 08:41:15 -0700 (PDT)
Received: from [172.20.10.3] (mobile-166-170-51-171.mycingular.net. [166.170.51.171])
        by smtp.gmail.com with ESMTPSA id b3-v6sm5876374pfc.178.2018.09.28.08.41.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 08:41:14 -0700 (PDT)
Subject: Re: [PATCH] xen/blkfront: correct purging of persistent grants
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org
Cc:     boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        konrad.wilk@oracle.com
References: <20180928072827.14229-1-jgross@suse.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ccbfcbab-85d5-8ca2-8019-dd24b994f791@kernel.dk>
Date:   Fri, 28 Sep 2018 09:41:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180928072827.14229-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/18 1:28 AM, Juergen Gross wrote:
> Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
> stale persistent grants") introduced a regression as purged persistent
> grants were not pu into the list of free grants again. Correct that.

I'll apply this for 4.19, and if things unexpectedly don't work out,
we can always revert the series next week.

-- 
Jens Axboe

