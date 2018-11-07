Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977FDC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AA9E21019
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 21:34:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA9E21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dustymabe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeKHHGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 02:06:21 -0500
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net ([68.178.252.109]:35007
        "EHLO p3plsmtpa11-08.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727162AbeKHHGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 02:06:21 -0500
Received: from [10.13.137.180] ([66.187.233.202])
        by :SMTPAUTH: with ESMTPSA
        id KVSfgymtq2ievKVSfg6e60; Wed, 07 Nov 2018 14:34:06 -0700
Subject: Re: multiplexing /dev/console to all console= entries
To:     Jiri Slaby <jslaby@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <46b26403-395b-6a3c-ea6e-c3c811fdc400@dustymabe.com>
 <955a0492-bab0-59d3-d01d-bea096c6e40f@suse.cz>
From:   Dusty Mabe <dusty@dustymabe.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dusty@dustymabe.com; prefer-encrypt=mutual; keydata=
 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
 Kty3FMtMZAdKH0x1RSq0iXM=
Message-ID: <81094a73-c277-99cd-190b-37c25db5f7ab@dustymabe.com>
Date:   Wed, 7 Nov 2018 16:34:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <955a0492-bab0-59d3-d01d-bea096c6e40f@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL/UnXKPBTLaAm8RZWRstRpI/yfWb5XexbzTt8c53JSKY3+o6L7SMsWj74vlqdux3MNQJGWYNc1HnwSQbCdh09goZUYcICH759oDg6NK7Kp/jywYq4C/
 8UnlzFrPGwqdEdyg01uhLrQvg08q11B47+mD29Cet17Si7vSxmIDxFiSy1G0Ptbx8sR+k1ewvHLf8xJOZS8XCz9ZvVkkA62OxlIUr8zTR5bqyy2WwoD6bt6s
 9WTVARyzlp6onHeaIUo/yg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/7/18 4:03 AM, Jiri Slaby wrote:
> On 05. 11. 18, 2:45, Dusty Mabe wrote:
>> If a patch were submitted to enable this type of behavior would such a
>> patch be acceptable? Maybe it could be a compile time option and also
>> have a kernel arg option to enable/disable it.
> 
> Hi,
> 
> it might kill the system on some setups where people specify more serial
> (or similarly slow consoles). Output to some console is so slow that the
> system does nothing else than writing to the consoles. What might work
> as the first step to check it out is adding a flag to the console=
> option which would mark a console as a /dev/console device too and
> multiplex only those specified by the user. Then let's see how it goes
> with userspace logging out in the wild...
> 

Thanks Jiri!

I think that seems reasonable. Do you have a good idea of what you'd like it
to look like? Some options

- console=ttyS0,primary
- console=ttyS0,mux
- console=ttyS0+
- consolex=ttyS0

These are ideas. Bad ones, probably. But just throwing out ideas. 

Dusty
