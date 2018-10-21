Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7E1ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03F220779
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 19:49:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nxYjBzCz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A03F220779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeJVEFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 00:05:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34493 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725723AbeJVEFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 00:05:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id w19-v6so35937609eds.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 12:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TEpEOdKSIQ4STPDdbqIjNzvK++iZ0lYx4eH/1o/MKWE=;
        b=nxYjBzCz/rjZvYguNgtnx35e5Zn6xa49gvYC3uINC+2DKjrJLZm5Sl+Wi7xNIHvdFL
         jG+tXaFmKheoshn0zbbV0XeEX6XeCWzIkkI5wXc2iRCSGXXgIA1PqVP834tEzMUA/jDy
         DLT0Y5DL2dodgYcgIZvpFeUaCljBa2A/vDUK4RUzYPNBP/2nMYLoX2hwRjS1TfTvgydN
         MK084RmBJ2+LK2zFkosw00lZEw9w7Hi6YjytDL2GWLKH0R6fF0supfEoPP2WkSP22Hsg
         EUzx6a070Hx3SVzyrx+72PMGAs+ockRcIDzCZ0oSPQz3L0W4bBz62p7DjbYWi7xWAzsg
         6f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TEpEOdKSIQ4STPDdbqIjNzvK++iZ0lYx4eH/1o/MKWE=;
        b=nZWkBv4QTETP0xZJmnmaA8I7WmAuIoTZN1DF8KIt8qJdFkytr6UFJQDZN82Kwl0Nrg
         TIkjBFlfhpzE5odEIkMk5LjvQmlcBO6Nh9i2g/wXqSSj3BWqVB/UZsBUF+rbv9hYeksN
         k3Y5QVW9XLLUZrdV/qNev3YpN9qvCf1j53u33iXbkAHzD31lnGaPBBZuMkBAC1dL/ZBN
         pyoOz3bIP+KuIet060daawKtcI+DBbhiPEZL2p7XJDI3rge9O+NoeKfHwAgzQwwHsnih
         D5NkKaq6oWb6Hhwd1g6Yprd2pQzssTH3sRG2ExLIKXIp9GJVC8z+Sr2+ERSs64mehTC9
         P1iw==
X-Gm-Message-State: ABuFfog9ig+bShB8gsYq8qk7v72DN14HKsksje/wAtKq0oEV96HlHVHO
        eKaqMQWKWoeqHd0V7ET3Rjeg6TGe
X-Google-Smtp-Source: ACcGV61GvWzCIxXxqM0vsiSgJwWrIhnPrqA6Vm204Nsva8oFknp0Snr+g7KkjJbQtBTQFSAvWgcUJQ==
X-Received: by 2002:a17:906:548:: with SMTP id k8-v6mr34802302eja.11.1540151388169;
        Sun, 21 Oct 2018 12:49:48 -0700 (PDT)
Received: from ?IPv6:2a02:8108:85c0:57c8:bc68:3d44:305d:951f? ([2a02:8108:85c0:57c8:bc68:3d44:305d:951f])
        by smtp.gmail.com with ESMTPSA id n3-v6sm734662eje.26.2018.10.21.12.49.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 12:49:47 -0700 (PDT)
Subject: Re: [PATCH 3/3] staging: rtl8188eu: rename variable isCCKrate - style
To:     Joe Perches <joe@perches.com>, gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20181020110819.1576-1-straube.linux@gmail.com>
 <20181020110819.1576-3-straube.linux@gmail.com>
 <5f8063e4163361d64069d0fbecc7f723b503a4b8.camel@perches.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <10d25629-f125-1e8d-9fd1-d4492b042a15@gmail.com>
Date:   Sun, 21 Oct 2018 21:49:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5f8063e4163361d64069d0fbecc7f723b503a4b8.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/18 2:26 PM, Joe Perches wrote:
> It would be sensible to convert is_cck_rate from u8 to bool at the
> same
> time and remove the ternary ? true : false too.
> 
> As well, perhaps remove its apparently unnecessary initialization.
> 
> 

I've added a patch and resent the series. Thank you.

Michael
