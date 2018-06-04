Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1407096-1528092788-2-16867386891640728310
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528092788; b=BMzg4WjZLQDJKQysKGDbBwTcR1Pitzrlb0SAKkHf3oBjfk6/j3
    XkmEeYJawY4qUsUyhxhQR6dkcF3TKFC52D4qrVEZvOreaKYbs+osVaUoL53AGQvq
    ZHkHL1xjEes/oysjmM57kGtsTsyST+m5FkGSG9NGDCXraQTocfUZbm/bV8TVX7HU
    zDk4Bro7og79XS+9ZXlvUn7aFc82mtWDxGD/GMvDn5dVj/nsOBPeRbynBvhJ/6EB
    c+Y7KCJIvqq1iGfROVNqP3MC2h9K0CeIqWAb8NTxQxA1HLQguUHGYcbzyFj+PkTf
    msyRK1TUHgXub9005HB85740QBfShjbQgL3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1528092788; bh=BTpV2J8vWsu
    z19ecO6mjt6wVAMWR7+vDYmpKUcFMTj4=; b=m2b3pZOEe3d05GERInxTVf7UC34
    CcgF3pvznKT2QgEXXQ7EsFbLM6GLn+DWwcflP+NDK3ULVABvzmI7W0eIEMrexWul
    GlNlNgB9mLyVO0+yBdIW50nx/nfv7o25r6SNnxA5xJHC7J21s7iHvXuFqehkN1uu
    w1HKKFdK25cv3H7vlr33AeG57DssCiLX13pvFY//bN/F+JT1kDiBaaWVGe8ilN7o
    kgfgcUfdTjQIKD/gzdRV0jpSXEjjvMXR30pbT8sSDdG/h4paa+do4bXhq4qNAwmp
    10H7uLP4ZtcpE5u5OO3xXGmUPucMz5+GsFniJtD5/zJx7/6NF7mq5eP3BGA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=aNDfkISR
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=adyhZgeq;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=aNDfkISR
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=adyhZgeq;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMPoqXN9ngZ4/SvdW3ldvqx2AR3202gzlKrbl1rn5727cJcFei/zBvoBWJ0wDy06glVRQfMuMCtvlWtgfVtoFvNVf5hKRFr3pGz264AF7DC/I0RLZqUv
    v4CH1h/1wW8z2BOGUGVD0CF2AqD2euPLw20T04EJ0qRUHYvev8bMI44Q+VRregD2z+yRDRkOi8QIOCNdaQG0xzEihwoBQBdAnHRf1RT9LX7r4IMBBcwtjPx2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=8b9GpE9nAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=tpklbuFrzDe4DuDInv0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=T3LWEMljR5ZiDmsYVIUa:22
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751782AbeFDGNG (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 02:13:06 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40336 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbeFDGNF (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 02:13:05 -0400
X-Google-Smtp-Source: ADUXVKLdZWSxaRJOww8/GrnUBd8IATE+pl3j7uZ8YbcpCQVDcZfanM/gz511CcPcEyaJGyCECZ/1gg==
Date: Mon, 4 Jun 2018 07:13:02 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, rdunlap@infradead.org,
        sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] mfd: stm32-timers: fix pwm-stm32 linker issue with
 COMPILE_TEST
Message-ID: <20180604061302.GD25455@dell>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526657044-14879-2-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018, Fabrice Gasnier wrote:

> This is seen when COMPILE_TEST=y and MFD_STM32_TIMERS=n.
> drivers/pwm/pwm-stm32.o: In function 'stm32_pwm_raw_capture':
> pwm-stm32.c:... undefined reference to 'stm32_timers_dma_burst_read'
> Fixes: 0c6609805b63 ("mfd: stm32-timers: Add support for DMAs")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  include/linux/mfd/stm32-timers.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
