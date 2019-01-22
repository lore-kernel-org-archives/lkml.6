Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C287C37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1E521721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 00:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TK2Z44bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbfAVAk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 19:40:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41087 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbfAVAk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 19:40:28 -0500
Received: by mail-pl1-f196.google.com with SMTP id u6so10541248plm.8;
        Mon, 21 Jan 2019 16:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=00x1OymPHa6+A5QZPSh3TDeBawt+6AhY/n8Mx5MDCbc=;
        b=TK2Z44bKH4lswQkJATov4HGWD095F/SSOEvi3NfBdUIQwbHI9ANs5r5ePFzDr1fI4a
         zJYI2I1H6TvQVZi4tjU0JBOO3QUmlaqVc6wpWXnIYHFzslta4iDKLz8tbOXiRODqkGTD
         Y3AcqucGSPe6X5S2t6T1qgroWlBfF0zL0uuTPsUgMClTOMrLVBL6trqs/za8sdVjO2EW
         AImr2lAvqmSiGJPVIilNSp5BQCyzAdt4Ek5f6+Qe/xVOSY/IQRdMXTllaVmAFkoDYhFE
         Vz3Ru9tL+TVR2WOlfW5nCJk1odvLd6ZwR8zyk6LZR8iCzT8aYpQipt1mhZOutWd98OQO
         A6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=00x1OymPHa6+A5QZPSh3TDeBawt+6AhY/n8Mx5MDCbc=;
        b=Jwo+jKMvSQNIjCBPnPgCMs64sYRSE+13+RRFvEozY2TfA6HV8aVFxIgOgSkf7uXfxa
         EQUbjQQdKcAM1BSBhvqSSStee7HoYpqJzJI7XDV4f0WDPeqXqNVY92HBngGekf1A4uc/
         JRz+d/sefS90fufZobKTF4j0GgWKt5nTplFqRMqTJMvpeJ5otb+8jKZ3mn0447aMsw4c
         7OQhpk+hrH3/gbmwr6hoVEWEa/KjoAIyNDOZTHCEoif2htg8cFvQL0IAhgr+XmeDt7Cr
         eHjr9xmeCoNCtlJdgELLtkKhjkO4Syz1MdLyY0LcmJr1WOc6ADgoEC8NlBrh1G4Lg9u+
         brUw==
X-Gm-Message-State: AJcUukczZBiF+MObm1TOIRJPJbrJi9YPgM92BXDdXyW+iBPgVPoI19rJ
        UiCbeUGkUKVNmLDsZjYE8ilW5R2t
X-Google-Smtp-Source: ALg8bN6BGeTO4lBWuXcO+STQrZeDBAJ+OFl0KL8+zePW+IZFJ6IRPqDIazNubVRPH4zMwBUOwqi3UA==
X-Received: by 2002:a17:902:7614:: with SMTP id k20mr32484824pll.285.1548117626832;
        Mon, 21 Jan 2019 16:40:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x11sm36383422pfe.72.2019.01.21.16.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:40:25 -0800 (PST)
Subject: Re: [PATCH 1/2] hwmon (occ): Fix license headers
To:     Eddie James <eajames@linux.ibm.com>, Joel Stanley <joel@jms.id.au>
Cc:     linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <1548100592-50383-1-git-send-email-eajames@linux.ibm.com>
 <1548100592-50383-2-git-send-email-eajames@linux.ibm.com>
 <CACPK8XeRgCRmyFFxrwCGKnBm=+o=m_L6G=ZWftOV_QB7ATjxow@mail.gmail.com>
 <0566a8cf-b9f3-617a-712e-95c92cf8af70@linux.ibm.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <cd4bf9a2-d07a-cf1a-a9ab-87a1f92a8c52@roeck-us.net>
Date:   Mon, 21 Jan 2019 16:40:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0566a8cf-b9f3-617a-712e-95c92cf8af70@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/19 1:15 PM, Eddie James wrote:
> 
> 
> On 01/21/2019 02:19 PM, Joel Stanley wrote:
>> On Tue, 22 Jan 2019 at 06:56, Eddie James <eajames@linux.ibm.com> wrote:
>>
>>> --- a/drivers/hwmon/occ/common.h
>>> +++ b/drivers/hwmon/occ/common.h
>>> @@ -1,4 +1,5 @@
>>> -/* SPDX-License-Identifier: GPL-2.0 */
>>> +// SPDX-License-Identifier: GPL-2.0+
>>> +// Copyright IBM Corp 2019
>> We want to use the /* */ syntax for headers. Take a closer look at
>> Documentation/process/license-rules.rst:
> 
> Oops. Do I put the copyright in the copyright in the same comment block then? Or use // for that?

Separate comment block. The SPDX comment block is expected to be on its own.
But please don't make it even more messy than it already is by using //
subsequently for the IBM copyright.

Guenter

> 
>>
>> 2. Style:
>>
>>     The SPDX license identifier is added in form of a comment.  The comment
>>     style depends on the file type::
>>
>>        C source: // SPDX-License-Identifier: <SPDX License Expression>
>>        C header: /* SPDX-License-Identifier: <SPDX License Expression> */
>>
> 
> 

