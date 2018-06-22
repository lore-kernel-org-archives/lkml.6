Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17C7C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E8842414C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 13:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tC95QYUT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E8842414C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbeFVNEZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 09:04:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:37334 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751256AbeFVNEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 09:04:22 -0400
Received: by mail-oi0-f66.google.com with SMTP id l22-v6so6059642oib.4;
        Fri, 22 Jun 2018 06:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:reply-to:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dbVBxsuuo6bbGeHwIZBf7U0ckFYVfBwq1TlGd9zrPhA=;
        b=tC95QYUTY0EtcxTGy5SkUi3SRPVyoQVrlUhWiqxlzz3RqCwk/hCMohJ4vgQiW5Dell
         rXtw9ET9TEp22vXqL64Zn/CChHSQs/MsGc9j9SqtFz/w1uArQt4biNS373ASeiTv62n2
         /U8wbS6qfxHxatj52e1VxRNGdVVlQwov3yP8l1VFdxy1dw9WGnuALgW2C8fIN8JOQHIB
         6TmeEh1NLSMmg7nMUSVPo7tSZyrd8Lf2yaTM2iKwAu6cPYRod0M9RUIXy3BjjqNco6ij
         boE+bMehMsDMoSPOrQ6JJNdeAqXc4ewZd5lUypTdG4RMcjKARo8wGhJ35S0lDsi83Vvo
         IKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=dbVBxsuuo6bbGeHwIZBf7U0ckFYVfBwq1TlGd9zrPhA=;
        b=dSCeS718pq94ELEh/PpaN9GprqhAylSqVmPdGNoPOf/pp0+9KE3Jqi9TkLuRk0pxLk
         zNvjshwsT8CE4YN9FYOukyk+8+T2wj0zS+3Mf33upb03SVSkwBH9NJip+ltxOLVaDIQ5
         cy3QAx8SHJcVCDPvAiZ2f0vOKeCoBsBwidncmxXEHR38KyQVYTss13YYwwHl2AAFDwJB
         D5j42MomiKD6IhcQS3cVExAYVTL+tHNtdjoxzW3WkXyhzWXGe9ynmnTFORzWSt9QcH/Z
         PpKHTh3ImyTJpwOZMFmUz9bcISlur6MehvJ2MPijFnR9ciNq8/wzt08Vf/XRHw45a1YZ
         Wy1g==
X-Gm-Message-State: APt69E2BIZ3IfQLhlFpX+LHpt1+3LEjjKXDFr6QqVKYVgTponLN429tc
        hKHSG71ZztxqxG0rWnR4Ow==
X-Google-Smtp-Source: AAOMgpdg3Eb43ewTuweRQItJVEZpW3YS4yJBQXOxVd4xXQNrUpzPEoTpKJvQ/N/PvL4T3SrKDIbFRw==
X-Received: by 2002:aca:750d:: with SMTP id q13-v6mr867510oic.40.1529672661883;
        Fri, 22 Jun 2018 06:04:21 -0700 (PDT)
Received: from serve.minyard.net ([47.184.170.59])
        by smtp.gmail.com with ESMTPSA id e43-v6sm5019566otc.60.2018.06.22.06.04.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 06:04:20 -0700 (PDT)
Received: from [192.168.27.3] (t430m.minyard.net [192.168.27.3])
        by serve.minyard.net (Postfix) with ESMTPSA id DCC09675;
        Fri, 22 Jun 2018 08:04:19 -0500 (CDT)
Reply-To: minyard@acm.org
Subject: Re: [PATCH v4] MAINTAINERS: Add file patterns for ipmi device tree
 bindings
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        openipmi-developer@lists.sourceforge.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180622100815.29221-1-geert@linux-m68k.org>
From:   Corey Minyard <minyard@acm.org>
Message-ID: <307ab976-6e1c-275d-8fb7-cd9b99255115@acm.org>
Date:   Fri, 22 Jun 2018 08:04:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180622100815.29221-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/2018 05:08 AM, Geert Uytterhoeven wrote:
> Submitters of device tree binding documentation may forget to CC
> the subsystem maintainer if this is missing.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> v3:
>    - Update for next-20180622,
>
> v2:
>    - New.

Thanks, I have this queue.

-corey

> Impact on "scripts/get_maintainer.pl -f Documentation/devicetree/bindings/ipmi/":
>
> +Corey Minyard <minyard@acm.org> (supporter:IPMI SUBSYSTEM)
>   Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>   Mark Rutland <mark.rutland@arm.com> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
> -Corey Minyard <cminyard@mvista.com> (commit_signer:2/2=100%)
> -Haiyue Wang <haiyue.wang@linux.intel.com> (commit_signer:2/2=100%,authored:2/2=100%)
> -Avi Fishman <avifishman70@gmail.com> (commit_signer:1/2=50%)
> +openipmi-developer@lists.sourceforge.net (moderated list:IPMI SUBSYSTEM)
>   devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
>   linux-kernel@vger.kernel.org (open list)
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 76b5dd65291f9650..321fbaa7e7d273a2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7463,6 +7463,7 @@ M:	Corey Minyard <minyard@acm.org>
>   L:	openipmi-developer@lists.sourceforge.net (moderated for non-subscribers)
>   W:	http://openipmi.sourceforge.net/
>   S:	Supported
> +F:	Documentation/devicetree/bindings/ipmi/
>   F:	Documentation/IPMI.txt
>   F:	drivers/char/ipmi/
>   F:	include/linux/ipmi*


