Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 06759C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFD4D20660
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 19:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V3kKimGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFD4D20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933476AbeFLTz0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 15:55:26 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:42666 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932533AbeFLTzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 15:55:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5CJtJar006622;
        Tue, 12 Jun 2018 14:55:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528833319;
        bh=RR5TU+DjZ31MgsdqVBQiIGOpXQs9KKJ77HxVQxWwgrQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=V3kKimGRxAkw/yOs32vcidjox4ISPO6MiJc8lEsuUmMitmm1sOroQ5OQOvEdLWqqc
         X5X+jOH43+KD/ImKAtzODZQO7Cw7N9OehXxWmmtRUx+TWv+HuS4wVPKaJoqhIpUr0D
         A+FKkUTifK50Dc3KhIRNmFih/grBlmm0hWUa4BGY=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CJtJeA027813;
        Tue, 12 Jun 2018 14:55:19 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 14:55:18 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 14:55:18 -0500
Received: from [128.247.59.147] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5CJtI2U027844;
        Tue, 12 Jun 2018 14:55:18 -0500
Subject: Re: [PATCH net-next 6/6] Documentation: networking: cpsw: add MQPRIO
 & CBS offload examples
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, <davem@davemloft.net>
CC:     <corbet@lwn.net>, <akpm@linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <vinicius.gomes@intel.com>, <henrik@austad.us>,
        <jesus.sanchez-palencia@intel.com>, <ilias.apalodimas@linaro.org>,
        <p-varis@ti.com>, <spatton@ti.com>, <francois.ozog@linaro.org>,
        <yogeshs@ti.com>, <nsekhar@ti.com>
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-7-ivan.khoronzhuk@linaro.org>
From:   Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <16c97ea6-9f28-1dd6-136a-2473423bf94a@ti.com>
Date:   Tue, 12 Jun 2018 14:55:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180611133047.4818-7-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 08:30 AM, Ivan Khoronzhuk wrote:
> This document describes MQPRIO and CBS Qdisc offload configuration
> for cpsw driver based on examples. It potentially can be used in
> audio video bridging (AVB) and time sensitive networking (TSN).
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
> ---
>   Documentation/networking/cpsw.txt | 540 ++++++++++++++++++++++++++++++
>   1 file changed, 540 insertions(+)
>   create mode 100644 Documentation/networking/cpsw.txt
> 
> diff --git a/Documentation/networking/cpsw.txt b/Documentation/networking/cpsw.txt
> new file mode 100644
> index 000000000000..f5d58f502e52
> --- /dev/null
> +++ b/Documentation/networking/cpsw.txt

Could you name it with "ti" prefix, pls?

Like "ti-cpsw.txt" or "ti,cpsw.txt"

> @@ -0,0 +1,540 @@
> +* Texas Instruments CPSW ethernet driver
> +
> +Multiqueue & CBS & MQPRIO
> +=====================================================================
> +=====================================================================
[...]

-- 
regards,
-grygorii
