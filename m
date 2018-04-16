Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3398102-1523887672-2-10600714813765315743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523887672; b=Hb8k1f602CkscbAFJQEIs9WZlTGLdq2pqtktrVwcp6C33058a4
    +tjdWH/EoGrkm6fo3n7LTVfP1j7wfTT2szaIQ2ZydQ//ibsObHtwWG5WOwYYmUcu
    Hq822aaH4qyWmlVFN4HQ/iXnLkbdU9lDCCfEDucnMFwR7/qlDcv/qyel1wxVdzXe
    MVM3EgeF7frJthVSCVNNA9PW3F3xyEOWx+nLrEBPUvjNv7UD9DRJwlXrNmeT4nIr
    cxI3BAvB+8jUsvhggSLowJ6QQc3leaav+Vi7QJDGbY8EQSqCTCC3jTtmZoyGrY5K
    XXUaFOg4+wfP/+x/aBlszpUpwkCQr0jQ3izw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523887672; bh=jxveb8jCoBU
    1WbiKBbGQussSlLpN0wv8km03toJZnkw=; b=J9Z3T9nLvEnBTwmHvOZsWjjsYv8
    XJ//+Pkj39QfW19jZmGrJbjUJsBl9lqy5uyVL9Hps/FWoJm9V1WsM79aDlEP0V8p
    348+Mv5fNwVUNonsxPgNwZSqyjBD8kihb1n4IGu1dJ3D5QFzgo3IXGCNoXVMqUid
    uaPe8b7BChQeq4t+I9/9JeOIbXa9Hpu4z5xSBTPnfa/F9/9tQnCV0DxF0ePR70Rs
    Y7WskVZTd6e8E0+e43keHnvGcGB5MQFGNsGVAI5dLhEFk0k0TSsH1H6812s1hN+b
    x2b7XWFeVSwpaWOi6VVk2USu0UDG9KhHGD4ZsTx8/B8Y72CBk8MsxpTAkNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NCLA/zkt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BxnA/0W5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=NCLA/zkt x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BxnA/0W5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfENDEryCLewDT+Nfi9dVky4xP36MlrmndLPl+HnnuKDx3Qs+5VthPAxO4xHakwECj8cGszgbhstFL68PLDLEHePkBiZFOxnVyVTJDCTG7Bl4zU7fBZzy
    ZsfB9NktcDP3b04w/8+4lI54jEJ+5xpc4oiH9lHmE8ns9P//zEdSdn7XicM2l2NvYzCJ3icxc9SkcBTQhyjqqvFKsBIW5IBvJOoYKWNaNLA+pAiqWyPiBHBN
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=4zGRZ9gJ3Tx9_e93Am8A:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755163AbeDPOHt (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 10:07:49 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:38253 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeDPOHs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Apr 2018 10:07:48 -0400
X-Google-Smtp-Source: AIpwx48hIrV7i8N1yrku1Btcw9+kixtp/NCb7gzEHb000o6eTBf0pYgGFdd6ye67qwrjAWZtINGLwQ==
Date: Mon, 16 Apr 2018 15:07:43 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, hns@goldelico.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] mfd: twl-core: Fix clock initialization
Message-ID: <20180416140743.fv5njvszyw6umz3b@dell>
References: <20180409084539.14365-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180409084539.14365-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 09 Apr 2018, Peter Ujfalusi wrote:

> When looking up the clock we must use the client->dev as device since that
> is the one which is probed via DT.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: stable@vger.kernel.org # 4.16+
> ---
> Hi,
> 
> Changes since v1:
> - Removed the Fixes line and add tag only for v4.16 to avoid possible breakage
>   in pre v4.16.
>  
> Regards,
> Peter
> 
>  drivers/mfd/twl-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
