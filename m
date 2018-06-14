Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id B49D8C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69468208D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 11:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="giUQxEua";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AGG/aYy4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69468208D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755184AbeFNLHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 07:07:50 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41196 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755042AbeFNLHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 07:07:48 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 0441E6022C; Thu, 14 Jun 2018 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528974468;
        bh=JW1al7hP6DV/HQu9ExrXvPF87pcaKXg1GpmWgg0lbAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=giUQxEuaJ31GcdaDAePGM6ddcPDF/r2HA5pCZ0JPgj21bqQwRhk6mxGPvGkdrG3ji
         v4l/lEAfuCwCylW8e25q1bmLT2A2fSZV8KPmCeGin/iHvaHHAApvT2rpmXItPWW3k1
         sKRemIE7pBPJXisJXqjpGRMojwSroRoSam3/T/gQ=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 72F5D601D2;
        Thu, 14 Jun 2018 11:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528974467;
        bh=JW1al7hP6DV/HQu9ExrXvPF87pcaKXg1GpmWgg0lbAo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AGG/aYy4PXiUKD1LAo2yc/KbKfqc9bVcFe0kt2nLqKCKm111k06MqLm+3mdq/XU3m
         imFLDUM5h6tqk0X+k6jpe/LZKW46WRrAFAiLuLnetiEZMs8+rd5LiZ4zhM5/ZDjlcT
         3D0JaMjbk6XJ0VrP8141C2hnZHqkX/VncYPRO20U=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 14 Jun 2018 07:07:47 -0400
From:   okaya@codeaurora.org
To:     Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi-owner@vger.kernel.org
Subject: Re: ACPI support in common clock framework
In-Reply-To: <CABe79T5i8zUcBJnFmM-pAvzXf2CZXesh4NqxSGFj8f0Z-c8m1g@mail.gmail.com>
References: <CABe79T6zQ_7Ycws5b=xaQ3edpVn1QPQyWd9p24eqLGpYbdtt0A@mail.gmail.com>
 <CAHp75VdSW1po7fVv+A6ATTU7CkN-4nQ1haQSCq7b_+ZR9tNXCQ@mail.gmail.com>
 <CABe79T5i8zUcBJnFmM-pAvzXf2CZXesh4NqxSGFj8f0Z-c8m1g@mail.gmail.com>
Message-ID: <977a6d1c83b4084b949162258bb1007a@codeaurora.org>
X-Sender: okaya@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-06-14 06:58, Srinath Mannam wrote:
> Thank you Andy,
> 
> Regards,
> Srinath.
> 
> On Wed, Jun 13, 2018 at 1:43 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> +Cc: Rafael, ACPI ML
>> 
>> On Wed, Jun 13, 2018 at 7:14 AM, Srinath Mannam
>> <srinath.mannam@broadcom.com> wrote:
>>> Hi Michael, Stephen,
>>> 
>>> We are adding ACPI support in our Linux based platform.
>>> At present our clock hierarchy using common clock framework through 
>>> DTS.
>>> Now we required ACPI support in common clock framework to upgrade our 
>>> platform.
>>> 
>>> For example, clk_get API called in many drivers to get clock device 
>>> is
>>> tightly coupled with DT framework.
>>> 
>>> Please let us know, if anybody in Open Source community have plans to
>>> add ACPI support for common clock framework.
>>> If not please suggest us alternative method to use common clock
>>> framework in ACPI use case.

Are you hooking up clk apis to PS0/PS3 calls?

Clk api didn't play nice with acpi until now.

>>> 
>>> Thanks in advance.
>>> 
>>> Regards,
>>> Srinath.
>> 
>> 
>> 
>> --
>> With Best Regards,
>> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" 
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
