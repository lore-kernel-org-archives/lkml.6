Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA383C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4342082A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:21:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HN2j8JlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4342082A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbeJCXKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:10:14 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:35416 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbeJCXKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:10:14 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so9768776itp.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f497VyKfyZ5j3l5ymzKsUTHyDq6SP6z9XIYLlcAxxCw=;
        b=HN2j8JlViM+Yt/LvTwfgbF0htnrczlSutdM/eMu+AaVujR/qCrSVYmNPHjFl8fyDbB
         ePHgWfcp/N40ZrumVxL8Dthl3BpmtiFkTg2VXC5AU9ppu6D4sn3lb8lXJQpH8f1Ee7/0
         /uP7274rBP9TKLO5qX4TXYDEV9L4H/PiULHxSYNqPToF8Mn/banhepyXMKQMzlf/t9nR
         6Fkgd6wKGgFuBl93s7h3kaGySd9W5EBFNEkQBz1XX0PweU84pfoxm6yO3fNm8oeHeh2w
         3rbssePTjMNiXgKppju44JmoMKEyAQR0yioJnQ/4mxfeOgy9v/0cQ3kQwgxxnfquNuWG
         4jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f497VyKfyZ5j3l5ymzKsUTHyDq6SP6z9XIYLlcAxxCw=;
        b=BJHXn/B5fPQqxKsnSCkLrR9BIv8yqUfSokCkEZCtE3rIpS3Rc4Ej8S2h6TnWLTaIot
         368Zti7ZFPrK4Pm/98EAVdUra+3shD8O/BGETy4ZP6ZtY69hTyiAqIwA5ToRBAAxlqb+
         mSs+l50FvsVhSpjW6urKElJNvd3BbTwoXpjTsrAX8SQeB2YKMLIzLX1+DF/ycYLZ9QED
         +Ocon0Bmi89eRJ4m/CxDE9VmeKyrbXQrby9rp3xXQyRc6kmhaDn2IaarVvZ8udkymkoU
         o4NKkD6PkVgH6MOxATq6dBXkMz9yyTlXcR1v+qBBeSFOvMXKOjoWCeyPKMIxlc77VXYc
         FSWA==
X-Gm-Message-State: ABuFfoiWBA2uZG12a0PJWdlClKVXOAnKdHb22bgz4PpyWHr3a8+AsOWJ
        l1e1D0C1GXbI/+lWINu5Zdvjdl3uU44=
X-Google-Smtp-Source: ACcGV60zTc4tsU0rgv/Gk7p4ttTpw5H+rw/km9i/zoEZ7ALkTqaSF3cSafJBytduUqv2eoMVja/UQQ==
X-Received: by 2002:a24:90c6:: with SMTP id x189-v6mr1896393itd.108.1538583668896;
        Wed, 03 Oct 2018 09:21:08 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m9-v6sm492476ioc.15.2018.10.03.09.21.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 09:21:07 -0700 (PDT)
Subject: Re: [PATCH] cdrom: fix improper type cast, which can leat to
 information leak.
To:     Yang Xiao <YangX92@hotmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HK0PR01MB2163BC120E665DA622CEFCA6ADE90@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <649893e3-c610-dd8d-3370-26a3408702f8@kernel.dk>
Date:   Wed, 3 Oct 2018 10:21:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <HK0PR01MB2163BC120E665DA622CEFCA6ADE90@HK0PR01MB2163.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/18 6:54 AM, Yang Xiao wrote:
> From: Young_X <YangX92@hotmail.com>
> 
> There is another cast from unsigned long to int which causes
> a bounds check to fail with specially crafted input. The value is
> then used as an index in the slot array in cdrom_slot_status().
> 
> This issue is similar to CVE-2018-16658 and CVE-2018-10940.

Applied, thanks.

-- 
Jens Axboe

