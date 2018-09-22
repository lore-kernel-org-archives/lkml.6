Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIM_INVALID,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14259C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E4E2157C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 00:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmojfQD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E4E2157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392359AbeIVGNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 02:13:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41591 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392142AbeIVGNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 02:13:37 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so6653756pfk.8;
        Fri, 21 Sep 2018 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/Hmjqg3H1j0jCY0Bmgr7OuD0BWqDMH23GEbtI3zhfaI=;
        b=QmojfQD4UpODd0UgSiQ5yRpXVCl5RKQueVPHJSsdToDxVrJGcA+X5wd69C6cFK3V1g
         0Gaaw6TiBEm2j0TtS4DO2rc6huXeds+8niv2HYuJliT/AAC1xDj+4xO614EzThQQeZsW
         7+yfdS7VL4U3rlTZVe8rzkvKih9WQ7D5GVpfLAV9h35A/Rz3RQtZ+4La7U/6YU/BFbfq
         SEN+1TOHlnsYH6OojNnQp6WL4+tZkcDgPRHkjeQlePUTE4VpSOoBUSNNKL4TlKp5PxPT
         4EnS4JmWyvDyVP7koZPOFd80cVIn/soB4ABuvrpOzXC8eKRs2qMGj6SBaOLWWgZrjSAa
         V44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/Hmjqg3H1j0jCY0Bmgr7OuD0BWqDMH23GEbtI3zhfaI=;
        b=K07PFmP+9tWCDsVVucOJFS7jSEFHXu/YL4W4OEKZzGlxjbvMO9rb0C32tP0aTKxRAX
         8Ptg6PVWiizvvgsf2fP0p/LLJg89VheEz/BbJ2MgxtLxQr6uqAeatOo3uppbZU6o6EEC
         WuKS8HO4v8GrriBA72dnDqiKA1z+rqdqIWQVvc1aKcdqlFx6gIQU34owIg7FVksBs2HG
         y3flcWcIrOJm0mhnUnqLPB5PfBtHyxKXUDekv9ZkrwJylile7726lOTZZvr1Pn8xlg7O
         VVTxQfuT4Nphau+D1TMP/TA/3w/jc2ZSeC1Ijbe2HxZIszqF+PkpYid8Jo6LVjzER+2+
         GQSA==
X-Gm-Message-State: APzg51DrFw4Ytj5Yq19tXdYAcHHhtJ2sLuPhmOSdnOsjxDUHmgSJibV9
        KbB6fiPRzUqdAj0UrQ0mPajzQV8J
X-Google-Smtp-Source: ANB0VdYwrHHCLtSG9mBUHTBNCz5UyVbulA3luRdLhM6dG9IzjuiFme3wHzSKqw7hw8+wm2rypdLN0A==
X-Received: by 2002:a62:2285:: with SMTP id p5-v6mr134765pfj.53.1537575738755;
        Fri, 21 Sep 2018 17:22:18 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id q66-v6sm10597880pfc.46.2018.09.21.17.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 17:22:17 -0700 (PDT)
Subject: Re: [PATCH] watchdog/hpwdt: Disable PreTimeout when Timeout is
 smaller
To:     Jerry Hoemann <jerry.hoemann@hpe.com>, wim@linux-watchdog.org
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180921205039.11466-1-jerry.hoemann@hpe.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <32cd1d39-f8d2-8b40-e025-4e3cda27c2c5@roeck-us.net>
Date:   Fri, 21 Sep 2018 17:22:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180921205039.11466-1-jerry.hoemann@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21/2018 01:50 PM, Jerry Hoemann wrote:
> During module install, disable pretimeout if the requested timeout
> value is not greater than the minimal pretimeout value that is
> supported by hardware.
> 
> This makes the module load handling of pretimeout consistent
> with the ioctl handling of pretimeout.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
