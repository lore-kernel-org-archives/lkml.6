Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D400C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F24E12081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AniNjnmA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F24E12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbeK2Iwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:52:31 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbeK2Iwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:52:30 -0500
Received: by mail-pg1-f196.google.com with SMTP id 70so10080600pgh.8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pSIQhNP5jxm7G7lGWUyVEv2jghSt0Y+1TqsQXMfVYJM=;
        b=AniNjnmA9zRxQw7IstHZRTNHueGNdxYaFvitSD5Res5NLp/U6TBqbafrSbtEoVNLn1
         UAKmDFpu6qLfe37caXPRnd64vTTXLTnplwgyXFWEVBKkUIDR3kXViS0ZHIWvDQcKzi2p
         KeX6Q/97D+dIEsSIBK4OgbCoQtZC+AO6rSIpYtImEFD5Sg7laLfD3cwu3OyTYEAHLxaL
         ogTJuFK2YeQjiGnJU4q9jux4Spd6M4DaBUghBkh728xQb/1lgcJr3juk2bjk/2R3w80V
         1ZLt4Lw6J7iihJFkteMo/PZxXdvmU8B1L7A73mBS1soLW3TFHXi6KF5kPM7bUYK5Tl9f
         Fh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pSIQhNP5jxm7G7lGWUyVEv2jghSt0Y+1TqsQXMfVYJM=;
        b=o62gjdkXhW2DCZ48e0TL5WyuM7Q63IrC/lOLSOb6nFzg5IKPMBLQYsR0emvlLAiXQE
         LL5RAH8CpEBmHN2EfEF49IHq2HvzURm2jwLO9o3594tK5ln+O8D2puErEZJZ0py4Hn1H
         +8PChcyOjsUl+y5oatvr3yn1C7KUUNwE9i7+GzOr/2vstae14M3PEhr/SV2mehyDnEJy
         n4SVHYQntx9L5NehsGw6GBAEoydLaSw9cd4SNeS965xVEpeD0TmICRvv1YHHz/JVAZq+
         vD8jI8nUtllP9ff6hCnOld4p9gGGZ/JnlHrL0PBukNxW6NVWfdd+zpF23sTlmlE6PpI7
         j0tw==
X-Gm-Message-State: AA+aEWZJnEuyy2JrWrY41xH8xftz/HL3lNmQcfFA6UQGna9mZCmiFixJ
        w5tFGRWRKnrn6s8ijIC+g/2zuzS8
X-Google-Smtp-Source: AFSGD/WeSGe21RPXvd2X33ObCPayrmTFXz/5qQM1h9Vcc9UkGUX11oaOPJyVEpmOQ5cec2QKdGJvog==
X-Received: by 2002:a63:d949:: with SMTP id e9mr34933896pgj.24.1543441767578;
        Wed, 28 Nov 2018 13:49:27 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id t2sm13030736pfm.32.2018.11.28.13.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:49:26 -0800 (PST)
Subject: Re: [GIT PULL 4/4] bcm2835-dt-next-2018-11-27
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20181127211301.30296-1-eric@anholt.net>
 <20181127211301.30296-4-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c117f72c-b72e-06c9-9c17-fb9bb4daf064@gmail.com>
Date:   Wed, 28 Nov 2018 13:49:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127211301.30296-4-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/18 1:13 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-dt-next-2018-11-27
> 
> for you to fetch changes up to 703c605fac82d580822dc39f5eff9e2fe66ed63d:
> 
>   ARM: dts: bcm2835-rpi-zero: Switch to SPDX identifier (2018-11-13 19:32:28 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds a compatible string to the DT necessary for the
> firmware and VCHI driver to coordinate on using the correct cache line
> size for the platform.
> 
> ----------------------------------------------------------------

Merged into devicetree/next, thanks Eric!
-- 
Florian
