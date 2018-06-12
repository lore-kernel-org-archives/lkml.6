Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E1E61C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D932089C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BLal9SON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D932089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934673AbeFLUgr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:36:47 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41618 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934236AbeFLUgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:36:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so444855lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AUg8/xwPIkMDxiYNYGykKAZfJA+HDKFtGocvEavjPb4=;
        b=BLal9SONTRyzxVr023TVmi/2q6rCUmVIik9CSWEPg2QZ6G3+E5Z/GWrbL5iRL84c1P
         4tV0VPmlbg/LvFJhSPJJnL3YbTRCct5CMh7DW0Kd99EcWI7pHZ4/K4vY+DZWe8JJskSI
         42Gtl1ZF9ZbIVy0sZI1DfxIB5NOf4IhsRoVcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=AUg8/xwPIkMDxiYNYGykKAZfJA+HDKFtGocvEavjPb4=;
        b=ImFbxaVMoAQuYp/+X2UsJx25qp4o1cTUAYX1ACaWAbAkLywUO3EoMDMOPUZzw0oUxQ
         lG82ZT/fdXAZ7nJLE/mBQ7ImOt9xcseUsDjkzm0D9MTaYpF+gvQPlyLZeNF5phLuAHyX
         srwto8nRQGRL35ebo3sJSm7U7sbqAT0RecWzKUBDIx995LIIcvN+gzN38x+Wa0Ol14jt
         mJTT+DP1/vV6OTNH3erL6fKWI7NtGB53+/OvgHmrqoyVvRc9/lfY9XRAFzXw/T+Cg0Jf
         TO6wT15+0bx2x2tpVQy+Zp8pRWWUzkfcEU3tbVSgDvZ8IqdIyWqmKrbuzRgD2tWCwwX8
         YmgA==
X-Gm-Message-State: APt69E0vLzKtFg3GCUPx7cgHvmgnYP5kRnafoeSePnm0udAczbKN8hfE
        dZyeRk9BM/8vV7D7vH3/BnPVTg==
X-Google-Smtp-Source: ADUXVKKNMq0GExFPFyYmwdNK5BZRgmyyZuqCvdU+MjKgONiLvYayIRPKMKu1XhZR6Y7j0xXtx7KmjQ==
X-Received: by 2002:a19:a68a:: with SMTP id p132-v6mr1050414lfe.89.1528835802838;
        Tue, 12 Jun 2018 13:36:42 -0700 (PDT)
Received: from khorivan (59-201-94-178.pool.ukrtel.net. [178.94.201.59])
        by smtp.gmail.com with ESMTPSA id q78-v6sm194028lfd.35.2018.06.12.13.36.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:36:42 -0700 (PDT)
Date:   Tue, 12 Jun 2018 23:36:39 +0300
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        vinicius.gomes@intel.com, henrik@austad.us,
        jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org,
        p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org,
        yogeshs@ti.com, nsekhar@ti.com
Subject: Re: [PATCH net-next 6/6] Documentation: networking: cpsw: add MQPRIO
 & CBS offload examples
Message-ID: <20180612203638.GC9473@khorivan>
Mail-Followup-To: Grygorii Strashko <grygorii.strashko@ti.com>,
        davem@davemloft.net, corbet@lwn.net, akpm@linux-foundation.org,
        netdev@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        vinicius.gomes@intel.com, henrik@austad.us,
        jesus.sanchez-palencia@intel.com, ilias.apalodimas@linaro.org,
        p-varis@ti.com, spatton@ti.com, francois.ozog@linaro.org,
        yogeshs@ti.com, nsekhar@ti.com
References: <20180611133047.4818-1-ivan.khoronzhuk@linaro.org>
 <20180611133047.4818-7-ivan.khoronzhuk@linaro.org>
 <16c97ea6-9f28-1dd6-136a-2473423bf94a@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <16c97ea6-9f28-1dd6-136a-2473423bf94a@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 02:55:18PM -0500, Grygorii Strashko wrote:
>
>
>On 06/11/2018 08:30 AM, Ivan Khoronzhuk wrote:
>>This document describes MQPRIO and CBS Qdisc offload configuration
>>for cpsw driver based on examples. It potentially can be used in
>>audio video bridging (AVB) and time sensitive networking (TSN).
>>
>>Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
>>---
>>  Documentation/networking/cpsw.txt | 540 ++++++++++++++++++++++++++++++
>>  1 file changed, 540 insertions(+)
>>  create mode 100644 Documentation/networking/cpsw.txt
>>
>>diff --git a/Documentation/networking/cpsw.txt b/Documentation/networking/cpsw.txt
>>new file mode 100644
>>index 000000000000..f5d58f502e52
>>--- /dev/null
>>+++ b/Documentation/networking/cpsw.txt
>
>Could you name it with "ti" prefix, pls?
>
>Like "ti-cpsw.txt" or "ti,cpsw.txt"
will name it ti-cpsw.txt in v2

>
>>@@ -0,0 +1,540 @@
>>+* Texas Instruments CPSW ethernet driver
>>+
>>+Multiqueue & CBS & MQPRIO
>>+=====================================================================
>>+=====================================================================
>[...]
>
>-- 
>regards,
>-grygorii

-- 
Regards,
Ivan Khoronzhuk
