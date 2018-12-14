Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA70C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50F90206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aLE+9v5u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbeLNRyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:54:52 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52147 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727168AbeLNRyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:54:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id s14so6515043wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fX4hhTcTk4w9SoH1Owu4Uv4f7zmzQhcot2j4JhR7+hY=;
        b=aLE+9v5u1GoOmicnjhUcWW5X8nRo8WXOG6RtPi6LWTECebaQ0aOIwCXB9ZFxwn4OSj
         Ss5DyNmRvsL7Ms+umuM3F5pP33gHPOdXY3E1AhBUK30/XbhzmI5fC0yjISwvbVxTVw5J
         7G/cgZE7UK14RIbMul+L6QiFqkVkArEwTOESY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fX4hhTcTk4w9SoH1Owu4Uv4f7zmzQhcot2j4JhR7+hY=;
        b=ICqRuHEZNFcwEQjt9mC7XzVoO+GnGiCESZWVvCtAxYgvGvRKn2MT8z6IoTixHcxALI
         N0jeoynmt7a3WmkR1E9BPwwvCfxNddcz0R7T/dMq8jF9CmLo5SV/GlLoZUNAC2OzxRQx
         JQCXSkRkdWcRH+VN3ZBnLEGMzOwCCjk9EDEsBu1wak67O6vn1Exj4kZGijlyCp/NxzRc
         gNH1O+Pd1wZ4B3duHQLg8OvS8W9f2EM6U+TZYv+nWBBbRG9vP8Sfp/qPcKRlwhiMEZMC
         3olPGhoBZbOPudaYWhCm8yp4ZnD3eYkFNqWPSiudB8ja2coWW+gw61hq08dojG5Im1Tq
         d9eA==
X-Gm-Message-State: AA+aEWaeFuIhrXmp2kdF5U36g18nGGJcsg5YyAHlIan6go07iBGfTt3i
        pk0e976XVTMpmu/VwRsJqVcofg==
X-Google-Smtp-Source: AFSGD/UXv6/YwA01KkHRAsyA5iFIbYtLEu60R+n0+yMAv2EsTT6Qv7DwLRkMO9SZxKqLs7XPuouwkg==
X-Received: by 2002:a1c:e513:: with SMTP id c19mr4254076wmh.101.1544810090156;
        Fri, 14 Dec 2018 09:54:50 -0800 (PST)
Received: from [192.168.1.2] (58.red-81-47-145.staticip.rima-tde.net. [81.47.145.58])
        by smtp.gmail.com with ESMTPSA id h12sm10309056wma.48.2018.12.14.09.54.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 09:54:49 -0800 (PST)
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
To:     Joe Perches <joe@perches.com>,
        Himanshu Jha <himanshujha199640@gmail.com>
Cc:     apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
 <20181214161604.GA17456@himanshu-Vostro-3559>
 <8ae5c67a5c4516a783579e449313d1d59fe3a47d.camel@perches.com>
 <20181214172843.GA18703@himanshu-Vostro-3559>
 <8242597611424ecd79d7863552b2281d89ccae76.camel@perches.com>
From:   Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>
Message-ID: <d77a378b-4a5b-daed-2fff-45c29aa12fa2@linaro.org>
Date:   Fri, 14 Dec 2018 18:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <8242597611424ecd79d7863552b2281d89ccae76.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/14/18 18:39, Joe Perches wrote:
> On Fri, 2018-12-14 at 22:58 +0530, Himanshu Jha wrote:
>> On Fri, Dec 14, 2018 at 08:27:33AM -0800, Joe Perches wrote:
>>> Is it really important to specify things like 75% / 25%
>>> authorship crediting?
>> IDK how that ratio came up into this discussion ?
> How does one tell when a co-developed-by: person
> should be notated or blamed for a defective commit?
>
> git blame shows only 1 author.
>
>
>
>
co-developed is simply about crediting a piece of work, something which 
is intrinsically connected to the philosophy of open source.
I could name a number of papers but one that comes to my mind is a work 
from Pekka Himanen, The Hacker Ethic...[1993].
anyway, so while sign-of is of a practical nature, co-developed is more 
of a social one. at least that is my understanding.




