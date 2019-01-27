Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60095C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DDF2147A
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:52:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoho.com header.i=zhouyanjie@zoho.com header.b="rPAPKkxG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfA0Owb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:52:31 -0500
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25470 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0Owb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:52:31 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1548600727; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=W3NBLxGAlZzat8D5mQqgp3WK3JVREzn5Hz92LPiJLN0mribFgfr3DzgS0Vw9seQqMbn6YvjUGgY7qELGkOYjElZn/uOdlLk7HKaFtLstO3O2pl9efsGB3QMuziF/Z97I0g8ARhFpRibWw846xOsv4EvlHVpXOKuolMgjaquWCI4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1548600727; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To:ARC-Authentication-Results; 
        bh=dVtfr7RTuXu68JYaX9EAWZ5pGhqJ5f2+5/3PKONng2M=; 
        b=QkXc1FIdsLjXPnM3oaiSpO7H5bc3mQmyW2Zkxv7T0tirIZcEoFe1z1RMV1T0Hd0/081JKJQjaW/w/eCHRJyc5XEp0Pu7MTgXPq61/0IUnyDOq+31NDOdlIDe6pG6gNygJ+shkL8M5YVwVDnYSW8G4R4gDEsSDwszf9BTPe2iq24=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=zoho.com;
        spf=pass  smtp.mailfrom=zhouyanjie@zoho.com;
        dmarc=pass header.from=<zhouyanjie@zoho.com> header.from=<zhouyanjie@zoho.com>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=subject:to:references:cc:from:message-id:date:user-agent:mime-version:in-reply-to:content-type; 
  b=IDHbiVngSbLVFeCUMw//r20CdN2n3gfEG5Kg5tFH/TTClk63A25li4p5va+mPtAT6DqYmdCqoQ6T
    NR0bp+opWKPguBfm4s0wBZ0oIN9qmL3PciOZWxiZbXlTcm7tqYDC  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1548600727;
        s=default; d=zoho.com; i=zhouyanjie@zoho.com;
        h=Subject:To:References:Cc:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        l=1519; bh=dVtfr7RTuXu68JYaX9EAWZ5pGhqJ5f2+5/3PKONng2M=;
        b=rPAPKkxGS3HDMk6URuZGmnjX0LyHrfD1jcPZCXJ5MpBrOrT0x0uTNM0kaI6E+XwD
        Qt0IArHUHBf4jnqJsjPfpLSoRQ3flqng35D+rmKz6KxI7Vok54GOWxMRJURS+CNXUKs
        j87aHzgcgAW/BAW1kjok/TmvszU5YGqqmc9b+GHY=
Received: from [192.168.88.133] (171.221.112.7 [171.221.112.7]) by mx.zohomail.com
        with SMTPS id 1548600725609654.1594131864704; Sun, 27 Jan 2019 06:52:05 -0800 (PST)
Subject: Re: [PATCH 3/4] Irqchip: Ingenic: Add support for the X1000.
To:     Marc Zyngier <marc.zyngier@arm.com>
References: <1548517123-60058-1-git-send-email-zhouyanjie@zoho.com>
 <1548517123-60058-4-git-send-email-zhouyanjie@zoho.com>
 <86pnsiwgnx.wl-marc.zyngier@arm.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        paul.burton@mips.com, mark.rutland@arm.com, jason@lakedaemon.net,
        tglx@linutronix.de, syq@debian.org, jiaxun.yang@flygoat.com,
        772753199@qq.com
From:   Zhou Yanjie <zhouyanjie@zoho.com>
Message-ID: <5C4DC588.6040702@zoho.com>
Date:   Sun, 27 Jan 2019 22:51:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <86pnsiwgnx.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your suggestions, It will be deleted in the v2.

On 2019=E5=B9=B401=E6=9C=8827=E6=97=A5 18:14, Marc Zyngier wrote:
> On Sat, 26 Jan 2019 15:38:42 +0000,
> Zhou Yanjie <zhouyanjie@zoho.com> wrote:
>> Add support for probing the irq-ingenic driver on the X1000 Soc.
>> X1000 is a 1.0GHz processor for IoT. It has MIPS32 XBurst RISC core
>> with double precision hardware float point unit.
> I don't think we need the marketing spiel, as none of the advertised
> target market, ISA or feature set of this SoC is relevant for this
> patch. Put it in the cover letter if you must.
>
> Instead, explaining that it behaves just like any of the other "2chip"
> Ingenic SoCs makes is much more relevant.
>
>> Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
>> ---
>>   drivers/irqchip/irq-ingenic.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic=
.c
>> index 69be219..0b643c7 100644
>> --- a/drivers/irqchip/irq-ingenic.c
>> +++ b/drivers/irqchip/irq-ingenic.c
>> @@ -177,3 +177,4 @@ static int __init intc_2chip_of_init(struct device_n=
ode *node,
>>   IRQCHIP_DECLARE(jz4770_intc, "ingenic,jz4770-intc", intc_2chip_of_init=
);
>>   IRQCHIP_DECLARE(jz4775_intc, "ingenic,jz4775-intc", intc_2chip_of_init=
);
>>   IRQCHIP_DECLARE(jz4780_intc, "ingenic,jz4780-intc", intc_2chip_of_init=
);
>> +IRQCHIP_DECLARE(x1000_intc, "ingenic,x1000-intc", intc_2chip_of_init);
>> --=20
>> 2.7.4
>>
>>
> Thanks,
>
> =09M.
>



