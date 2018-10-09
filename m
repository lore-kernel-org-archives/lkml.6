Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3239FC64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C5920644
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 21:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eyFKnLtr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C5920644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJJEYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 00:24:33 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33056 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeJJEYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 00:24:32 -0400
Received: by mail-pg1-f172.google.com with SMTP id y18-v6so1429483pge.0;
        Tue, 09 Oct 2018 14:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cPgV2JZw3Z6254tO9NDBdtMiuAm0ziwl/StwKkOggBw=;
        b=eyFKnLtr2baRYiAxKvD+utvcGt4p80wfVOLWyDFnazhSK4Zrdj3Ckb0xOWLfJcgUSG
         o70mHhof/rlZ8uoQUv+DlS1pWDW9CkX6TEcOakgyFoyL0RYQz1rJo5X95tdtped2QYbs
         D3kUCpafWvRDqQcp94q3ERxnohDESE2LeonLmOhJqbhPMHIsEt3zHP7IkzONPPEvN28F
         kZ3WDi0tqN+VrHKOaX1JYzRbvBLgvh7iesyk9FCo47wq3Id24myce3GGBo9dv28l+a7/
         FWKDoMPHhgeaHmzuIV8nYVsNxmmuxo8/xu3GRuLKIFCs3mi8RwO0/LRHFa1fdgxjQaEg
         CEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cPgV2JZw3Z6254tO9NDBdtMiuAm0ziwl/StwKkOggBw=;
        b=AhlqkKbP2Y9gHc2GYJB7fEa784Z1Uy0XxeuT46D774JsYHhKCTb+/3YDqYDyqIoVTs
         fdZv5MP9F/LMNziQbr/SbowEvS/YFAhUXOI/BkBw4zfAoRq74wD3SsMD6K5rGx9Pd3Ad
         PzxEjJA4lJi9VabX5eAjnFKvRdIP1roOZ19IHr2tyWy0JRujlsdlW4nIHgFEOJy1zI4D
         jDwKyrmMwzt5fXJfqkKqBanmUml2ykUxJ39KFQd6easaFGZI3qUAbWYmHHBIwpS8dtjK
         z25eKdeA2Wldhjm4SHZrRStFX5fUQeKfbYSSiSPcRp+K4dxUqEYMdz6XJ87iOoUbESvF
         C0pQ==
X-Gm-Message-State: ABuFfogC0Ou3m2MlevGqoa1y1b9CBebia5sd9dDIqflzaF1XPybHghDc
        pBcJpdXyVI82fTo/gcxpCzAuFlje
X-Google-Smtp-Source: ACcGV60D6zeCRPC0QS2ETeSwfX+3cCd88R1+Y9UfjN8ryDjvCfuwE0wEDbkLLtHP9O5yO1RKvKMD8A==
X-Received: by 2002:a63:b25e:: with SMTP id t30-v6mr27184860pgo.401.1539119143771;
        Tue, 09 Oct 2018 14:05:43 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id c28-v6sm71645967pfk.48.2018.10.09.14.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 14:05:43 -0700 (PDT)
Date:   Tue, 9 Oct 2018 14:05:42 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/59] 4.9.132-stable review
Message-ID: <20181009210542.GB12203@roeck-us.net>
References: <20181008175546.620836256@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 08, 2018 at 08:31:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.132 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Oct 10 17:55:28 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 150 pass: 150 fail: 0
Qemu test results:
	total: 308 pass: 308 fail: 0

Details are available at https://kerneltests.org/builders/.

Guenter
