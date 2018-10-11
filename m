Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40968C677FF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07EA12085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lH5cm1FN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07EA12085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbeJLAcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 20:32:51 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:36784 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727795AbeJLAcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 20:32:51 -0400
Received: by mail-it1-f180.google.com with SMTP id c85-v6so14281678itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8WC1kl81HMMjBJ2Gj8886U8L8J/hTn9TiZUmkEgvECQ=;
        b=lH5cm1FNnkGOFWGWYhBlkXhAkKbJ/xlXozpxDsVRRyAxKhcVRjuPFk35pnnf7COyq1
         UXAxfiqktTpUL2VR3m4ptIHECRURG8sIC6eAGtDDV9T1IX70oR3FGUbUoob/rrBsXcVC
         OH2mtw4MpS8BddFxvuT0M0XnBjJBjfFDq0htj9C03YCP2G7cQbinXVcgp4vWuNMB63B7
         oyTFzMJH2vnfOIDLKwlUZ/UccP38ITW1JAfmtTp0Um43XLQx0WKowOYX+CzAQoJ7VYE8
         tsqlj+kobRKfBOjlFzw1GUk8L7p11/XqJWL9aFqVELtSJopu1iArlpyg9QEB4OTNvfMs
         M4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WC1kl81HMMjBJ2Gj8886U8L8J/hTn9TiZUmkEgvECQ=;
        b=nDAPcvMD7yyvu/LKsEv78KHoXlv6uiS2kFH52wlq7L97uW8jZLt9tp7zaljIDuff83
         YVGWv+A/BrjROJLN+ifp/+RctTyE3XVmqU0d/F1k80kmN7X48gCgBf/kPuSx67mMKmwW
         wvnNlJ+TRBrYKlkuP8BAT3XC9gRINtiWRe7R9wVNn78p+YaRPHCf7kIi58aGN3f7asu1
         FJGaaRAWdr4uHmR845g904fw8qVgeIzCqhj78GxyndzeHE24ItoA5wrMBSds9TUg4yui
         KYe3Qjokg3GBXr/MFSH2ePP+cwJGBtk1Bqflkz6S9fwIC5+RCjKHizsXMQtHVvGLblxT
         krDA==
X-Gm-Message-State: ABuFfoiNpnxKLgRyGSsDPC8UHiR9Q+eKUe2X7Q6V68/xwy7TskKlKMZ/
        xuUaKZgwMJo1zgKrexauuI/J840MCLU=
X-Google-Smtp-Source: ACcGV63OwRvvwVAEBg4Veb4ywx9sjtToI1fPrwQFS4mQCADYngU5h5QGvMXExwKnFqsNBvCECVMWgw==
X-Received: by 2002:a24:9d90:: with SMTP id f138-v6mr2134839itd.57.1539277483812;
        Thu, 11 Oct 2018 10:04:43 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m70-v6sm9971608itm.27.2018.10.11.10.04.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 10:04:42 -0700 (PDT)
Subject: Re: [PATCH] block: describe difference between flags IO_STAT and
 STATS
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-kernel@vger.kernel.org
References: <153924162613.241965.12232363505207460166.stgit@buzz>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ebc55ae9-0c41-f9d2-3819-ed93a26d69f6@kernel.dk>
Date:   Thu, 11 Oct 2018 11:04:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <153924162613.241965.12232363505207460166.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 1:07 AM, Konstantin Khlebnikov wrote:
> This adds reasonable comments, but they definitely needs better names.

Thanks, applied.

-- 
Jens Axboe

