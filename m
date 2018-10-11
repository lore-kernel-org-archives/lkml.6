Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44F6C28CF8
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E6C020644
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 23:38:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZHJJbm3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E6C020644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJLHIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 03:08:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46252 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeJLHIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 03:08:06 -0400
Received: by mail-pl1-f196.google.com with SMTP id v5-v6so4953038plz.13;
        Thu, 11 Oct 2018 16:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t6GwcdCmvHVmWHnU8eJW6l7ZDMJAfp7RCaTcJxdx/zA=;
        b=rZHJJbm3PvBVSdCMZP8qXB3sKbmgQ/EjNxIJDWKai5O84gWTGJinMy2urG5VEE3DSQ
         z8gRL634ALxT0lZB+MmIz2xts27L0BEC5eJMRIIgMpjqtib3kHJTtNHPFfJnERieRM3I
         EIxUCsOKqKuhrss+UaTOAnS5DBHCvW3ibJOHYoFqHXyP0IiQyK44E7n9/LOleqncGg2d
         x+T1KEz9n64ThnqPR3GUU86pLwqSgSpeW/qZormkcizBNqDXonx4ZFn1VxdBn7GLs1JN
         MUYYztbtWMIDgAmqqCFRPwcXJ4wPxcQjj1jdZRcfHrCIP7egGqvRvdQJ7XFMKAJlv6Vd
         rn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t6GwcdCmvHVmWHnU8eJW6l7ZDMJAfp7RCaTcJxdx/zA=;
        b=LCcHzoDqrpdcGFO2v+OaGPzBPMjLkvQGejhd4fMVo/cfJ/BZfURvyD4b9Z3d4poyOF
         5k2CREmPG6L40qhMRZ6M/s5qof8Wa3kIBa6QZSSBs9bnoAFbtBjswsUEC0Ln5O1KD/B2
         HRCJ0CVJHN/uAe/2D976yxfqWbnL/LtC4BZGDiqLfzZyGazE5/p8hiUzKao0KQM1AWI0
         4sEhKLspdio9U32GtigjfsSGSqln5l5OcOspU5Tzi8HrmXSYkSX+JQpxaWlCtJDQ5Ph3
         lj1HqsH2/aKSYtvSyoiUbfFV25faOoiJeKJErm16Q/5ts35G3gc4UJWBuGj9HrvXVvGd
         UHeg==
X-Gm-Message-State: ABuFfoi9PsyFxwFrpcDvIW0PMjKsPy/ZnaVmcmG4vW0pwfwDRWzdFjSt
        QNvSM32frWjI0hhX5zSB8J32m7tB
X-Google-Smtp-Source: ACcGV61ftv77dVVnQZzKYqpNBpEg+lWfsMpFPOy7DsX3qEnOtIO6FppfQ+CLsdxXXJgYUwKhKLFJgg==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12-v6mr3400664pld.289.1539301112384;
        Thu, 11 Oct 2018 16:38:32 -0700 (PDT)
Received: from [192.168.1.70] (c-24-6-192-50.hsd1.ca.comcast.net. [24.6.192.50])
        by smtp.gmail.com with ESMTPSA id d2-v6sm40069238pfd.100.2018.10.11.16.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 16:38:31 -0700 (PDT)
Subject: Re: [PATCH 05.1/16] of:overlay: missing name, phandle, linux,phandle
 in new nodes
To:     Alan Tull <atull@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Moritz Fischer <mdf@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-fpga@vger.kernel.org
References: <CANk1AXQScT_b1_UOiVuWNcB=LiA3gvvZrw53H1XVSCNqsGPqtA@mail.gmail.com>
 <1539151495-8110-1-git-send-email-frowand.list@gmail.com>
 <f20d06c3-5db7-3547-7b8b-d43d474683f1@gmail.com>
 <CANk1AXQ+-X51unT_ZHw+wxHG3tyGUKUihVsdzOZZ2NJ2zfS3Rg@mail.gmail.com>
 <e32a99a2-1db5-80e6-5022-83cd8fd07180@gmail.com>
 <bcbba4ca-0656-aa27-c058-064fb7175d38@gmail.com>
 <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <3f36468b-676a-558d-4180-7129d2bf2c6c@gmail.com>
Date:   Thu, 11 Oct 2018 16:38:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CANk1AXSRifmwu1FQRY_hsuqDESEzcMET_hpLNZOeW4QLrUwsdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/18 12:33, Alan Tull wrote:
> On Thu, Oct 11, 2018 at 12:39 AM Frank Rowand <frowand.list@gmail.com> wrote:
> 
> [resend of my messed up rejected email of a minute ago, sorry]
> 
>>
>> On 10/10/18 14:03, Frank Rowand wrote:

< snip >

> I understand you're quite busy with all this, but I'm wondering
> whether it might be worth it go ahead and make the properties be
> kernel objects also at this point.  That would be an improvement for
> the case of overlay properties added to non-overlay nodes, so the
> lifespan of the overlay property memory can be coupled with the
> properties kobj's instead of the node kobj's.
> 
> Alan
> 

That is one of the approaches that I am thinking about to handle
the potential memory leaks from those properties.

I'd like to make these changes in a step wise fashion, to let each
major change get some exposure and use before moving on to the
next step.  Making properties into kernel objects would impact
a lot of code.

So not in this series.  But thanks for thinking about it.

-Frank
