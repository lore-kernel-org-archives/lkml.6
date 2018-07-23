Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3217ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF18F20685
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCKKape8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF18F20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388154AbeGWUpy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:45:54 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43069 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387981AbeGWUpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:45:54 -0400
Received: by mail-qk0-f193.google.com with SMTP id z74-v6so1184781qkb.10;
        Mon, 23 Jul 2018 12:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cU/JK1pky+WuQWjGb/Vigco0DfO7Z1CjrJsl/yKvTqQ=;
        b=nCKKape8gkSO61w1VBD11Ihmyjh3FhptW7hDcqxPauSgdk0MnEae8+lDgqqif/qDhv
         naXnvYecoNimOcn6eYHwpL6keDyva75mIbM35id+jgocCvURYDPQwkEiEnw0gleqciml
         0W9qruIujauXW2bXK+PurM4Wg1GoQhKSmM1dDakRvyG83BoMj/w8Ig98AJQO/dlvBPVo
         IJJ+oSjr0QEsLx3dYMDwT1BAUXZEO3E5mv6V4tyC3xkWysxOPMV5NiEjntfvHrO9Z/rI
         xNYYJK7EwuZQUwRVVH9TW+0KO3fod8KBILu7k/5OAozsAEAoD3V8TT5AmOPFEAwv4k/S
         AmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cU/JK1pky+WuQWjGb/Vigco0DfO7Z1CjrJsl/yKvTqQ=;
        b=toFhA1lPaxc+rYCelzkg23KkZswIQmzFy6bmZvdmWYGk3jdRdEdd5mqhqS9EMJkrhL
         pX1uJEhZ+gJD8fDH+47ntbh/+4mQkPRtPSIB4hj2aC8xaF6xVhPeTXRUEnBxfBRRGjyJ
         DdjuNaOlu8kK/ZKwA+22ZjWDVjfjJyTwX+JcBSmIoNyXfv1TerzpnfrUzX47Xyx34ZAR
         /NphpgENSmA3xQtbdeMS0tPtjoUUPl6Sa9j3BtXTGaMt7Pw2aK//8G4iUJlgrDB9JWf/
         MDTw75uaIe/s263tjaKMRKaTTyAOwA8NfUQZ4bIbapaWLFSII2+zKzhDLq/dMb0DgYVc
         a2Qg==
X-Gm-Message-State: AOUpUlE2mqAAAXm/UKvhSSn3AQ6L1WiBne7eS6i6PHDvYjyOoNbMCnKT
        L2Yb/ZS2+bbqFcS4fP0ba7yj2tJ0OgA=
X-Google-Smtp-Source: AAOMgpdTWuPwB4kzIIrv6w0GDl4Zb6Z60rrOfW+Kc17NDMt6Uar0Bqe8hVabI1bKxtFtc4PgHBk8hw==
X-Received: by 2002:a37:ef0f:: with SMTP id j15-v6mr9828477qkk.399.1532374990376;
        Mon, 23 Jul 2018 12:43:10 -0700 (PDT)
Received: from [192.168.44.96] (65.sub-174-226-2.myvzw.com. [174.226.2.65])
        by smtp.gmail.com with ESMTPSA id m40-v6sm1508705qtb.63.2018.07.23.12.43.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 12:43:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] Add sw2_sw4 voltage table to cpcap regulator.
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <e411faa3-7d42-710f-a18a-a4fdd764b60a@gmail.com>
 <20180723181318.GG13981@sirena.org.uk>
 <95929e34-eeb4-f3a4-daa1-0b89dd60f570@gmail.com> <3459086.gtf8SULmVS@dimapc>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <215117b3-ca46-ff0e-a494-0fdf674bec8c@gmail.com>
Date:   Mon, 23 Jul 2018 15:43:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3459086.gtf8SULmVS@dimapc>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 03:20 PM, Dmitry Osipenko wrote:
> On Monday, 23 July 2018 21:37:50 MSK Peter Geis wrote:
>> On 07/23/2018 02:13 PM, Mark Brown wrote:
>>> On Mon, Jul 23, 2018 at 01:58:26PM -0400, Peter Geis wrote:
>>>> SW2 and SW4 use a shared table to provide voltage to the cpu core and
>>>> devices on Tegra hardware.
>>>> Added this table to the cpcap regulator driver as the first step to
>>>> supporting this device on Tegra.
>>>
>>> This also doesn't apply against current code (though it does now parse
>>> OK), please check and resend - make sure you don't have other out of
>>> tree changes and are using an up to date kernel (ideally my regulator
>>> for-next branch) as a base.
>>
>> Good Afternoon,
>>
>> I thought it was my error in the patches being stripped, unfortunately
>> it seems to be a known Gmail behavior.
>> Any ideas on how to get around it?
> 
> Use the "git send-email" instead of email client.
> 
> You need to create and send out patches using git, that will be something like
> this:
> 
> 1) "git format-patch -v1 -2 ..." to make patches
> 2) "git send-email --smtp-server=smtp.gmail.com --smtp-
> user=pgwipeout@gmail.com --smtp-encryption=tls --smtp-server-port=587 --
> suppress-cc=all --confirm=always --to 'Mark Brown <broonie@kernel.org>' --cc
> 'linux-tegra@vger.kernel.org' --cc 'linux-kernel@vger.kernel.org' ...
> 00*.patch" to send out the patches
> 

As always, thanks Dmitry!
Resent through git this time.
