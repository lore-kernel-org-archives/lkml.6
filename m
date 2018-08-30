Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A294C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E877620658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 12:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzkbtvPe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E877620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbeH3QWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 12:22:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37413 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeH3QWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 12:22:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so3289077pgo.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 05:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=h6eY6FjhIFaIwb/lsDYjz4Qar5nyf8S1g1nmAjb6huQ=;
        b=UzkbtvPe4HlqZe1VE/sfz/HtXMjT9OO7loxbPZ64B1Z/0u80QX0rkCUHPxQMrcYde6
         5ptmkASmcnIYZPc85M0k3L66dJ4J5bUB4Vgp09f+kv5zwEI+JHy89BwyQyMubIauG1JJ
         fytj/5a0wvdIpP4cmbyN985paWljiFMdeKgXuX++4YycqPpuhbLeCWQLNqrVnmKBfcT4
         wVLU4ARJUGfCHdHzSSJn7Oxp4QaZ+YvNRJ4aFaV0eY2SQa/osD65QHivPQFLFgo5MpAj
         F3L7YTEuZDnkGBlnYdp07uterOVm19P6/PA6NC1H+DMxoMxWHIkpXu2WuWC+fl/V8Pbx
         mPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=h6eY6FjhIFaIwb/lsDYjz4Qar5nyf8S1g1nmAjb6huQ=;
        b=IomCzS3R3ir926ltB53SPlnXLgxdhUFrwln1vBJD/OW4SWV8Wxqf+AEEsIdndJwLlS
         6u+U4x5i9IPsd+JEmJSQ1bEFRWTQf4TtSSzDWlJL4RPTxMPhSnB6J5zQSnIWo5ZITfUv
         v7M/EZYpW/zmIqjaqW3EDzAZJ/hXBTrgvNhQ4MIXRrZfUCH53sDT3IBq9pHTCnsa7OZB
         Id+MSLuUK/fS9VijQDuhio9HQ410FmX+8PBlNMxFlvrFbAQ6f/8ToWs7tHiCl7LRWVI6
         VcKw3ZYrPa0S2sRTXst/EbjlTYqOzGXsr9B5ugGP+un7qYnaMI/IeCo/u16L4EU8Ux+B
         k0KA==
X-Gm-Message-State: APzg51DHSLqjkA7xngR0JDeIoVFz7kvppLhJ/WFQE9FEeoLOiIQsG95G
        MEiLxgDN2ADYly3NuHVM5eE=
X-Google-Smtp-Source: ANB0Vdb7f8ZInfjpwaPvaJrBkP/2Kej1urjliRea6MrovwxT8yRxL+Kz02FBYxRgeDarxFHTDLaTkg==
X-Received: by 2002:a63:10c:: with SMTP id 12-v6mr9484223pgb.62.1535631625229;
        Thu, 30 Aug 2018 05:20:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id y85-v6sm10879597pfa.170.2018.08.30.05.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 05:20:24 -0700 (PDT)
Subject: Re: efi boot failures due to PTI with 32 bit builds and Intel CPUs
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>
References: <20180829201659.GA29801@roeck-us.net>
 <20180830071951.dv6wgnn6ikfhh7yt@suse.de>
 <f6d9bdcd-98a6-fcf2-5308-936ffd714ea7@roeck-us.net>
 <20180830113059.qj6yvw4ggktc7yex@suse.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <915dca84-c98a-fc63-3210-b21dd926b3d4@roeck-us.net>
Date:   Thu, 30 Aug 2018 05:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180830113059.qj6yvw4ggktc7yex@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/30/2018 04:30 AM, Joerg Roedel wrote:
> On Thu, Aug 30, 2018 at 03:11:26AM -0700, Guenter Roeck wrote:
>> OVMF image:
>>
>> https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
> 
> Thanks, with this image I can reproduce the issue. Investigating now...
> 

Excellent.

In case it matters: I can use the same 32-bit efi image to boot a 64-bit kernel
without problems.

Guenter
