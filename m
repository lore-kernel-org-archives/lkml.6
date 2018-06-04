Return-Path: <linux-next-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti33d1t02-1407096-1528092759-2-11687643544469105661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-next-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1528092759; b=ljh7qgeobRpTRQSvQhjgxIJJXoVmU1vL4Lwe5HbqRrb+agl/3J
    v49Bsnj0+51wQEAMvIngqpok59r85fxosCRrnWvGIiZ/ze05rK5ACUYWFDmmjNbD
    WX6qv2O7vvhHLKx3uh0KWJ0sbk/6B//oeTfje8nM9LfiVh+Ad0kHAXJaPLkRHo4P
    NxF3wZygmb/DZltDGJ9Aep0aNT4A1hj6C/cz1rejhIkmwZir9cSl9+9fnsf4dL56
    vq1H180E6fP/9MZ+Auy1DVLYInNhI9ofaRRa+CLI+UhGa57uIcUgT9eNTqDofVms
    BSmhq0qugIhOU1nd8gpYHEEZPyl6Kr2Epllw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1528092759; bh=wGpw9JJWTZW
    +ctM/euftiJBNHD1EGbATxsI72GEAs1c=; b=Z9ROTuuXI8rjBezREMk1sGFE+/T
    yzQiAPbcNwpsR6mzcJs4hF3gefIXqUaA1L+DhHzrEvk4W98tq9aL5EmCl0mWgvPG
    0Q8SaTAKSoeMnOkb8Llu/szrQByadTAG6jVBR/fVO7LXbdkLwAXXBBpgoIP1k2rF
    4fII6eeHhxBcw8tz2N1Vcd27I4q7Engu7w7XFsA6p/0sA3i108zSUOP9r1ZQuHHU
    65ZcH4gLc9Ea9jE+Q2C5ch6RfCf+5aDaaO+Hi7PA5qkKG1qGxPe7Xt4m2JpSBL7U
    6tzrTQSZq0J7pXhisJQmB38wgyh0HwqvfxcX0e3CetZ27yBw77pv7aJykUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=OSRFS8tz
    header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=KLdGqGt4;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=OSRFS8tz
      header.a=rsa-sha256 header.s=google x-bits=1024;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-next-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=KLdGqGt4;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIvesGRh2w90drNeVusuQozZT8E2XauE7Wh6rrK7ySo7EhxjIfUc7UeFGNSkfR0OLPj08Y9O4kIsnYpRYQe23Qy+74k2AYvUF38auJS1Qet2shuZwRh7
    NjvGao6AU/lkHrVHTfKRjbfqo1yZQgoehuVuVtadS/1I9DByhBZHu1wETfFK8M6n+SbA2/Ma7XkgqzrxOqz5bwrfmLDAD1KeP4dVFO65tOlA09QkffvLmx0o
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=7mUfYlMuFuIA:10
    a=8b9GpE9nAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=tpklbuFrzDe4DuDInv0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=T3LWEMljR5ZiDmsYVIUa:22
    a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeFDGMi (ORCPT <rfc822;linux@kroah.com>);
        Mon, 4 Jun 2018 02:12:38 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53541 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750731AbeFDGMh (ORCPT
        <rfc822;linux-next@vger.kernel.org>); Mon, 4 Jun 2018 02:12:37 -0400
X-Google-Smtp-Source: ADUXVKJlTTKqHz20/7JK9egLmEMD9+KWnOp1Hh0ny620MNvcpyuXzKNhoKZjVpfDa3zLiIaU1Tcevw==
Date: Mon, 4 Jun 2018 07:12:33 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: thierry.reding@gmail.com, rdunlap@infradead.org,
        sfr@canb.auug.org.au, gerald.baeza@st.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-next@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] pwm: stm32: initialize raw local variables
Message-ID: <20180604061233.GC25455@dell>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
 <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-next-owner@vger.kernel.org
X-Mailing-List: linux-next@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 18 May 2018, Fabrice Gasnier wrote:

> This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
> in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
> 'raw_dty' may be used uninitialized in this function
> [-Wmaybe-uninitialized]
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
>  drivers/pwm/pwm-stm32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
