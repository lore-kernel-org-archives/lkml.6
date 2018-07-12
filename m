Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA13C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F70D2086B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 03:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xy8gd1S3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F70D2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732433AbeGLDQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 23:16:19 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43915 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbeGLDQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 23:16:19 -0400
Received: by mail-lf0-f68.google.com with SMTP id m12-v6so22940680lfc.10;
        Wed, 11 Jul 2018 20:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Lc+CRz37aIH1qb4D7Cnk+dsGVj3FmfEkpPWIkrX+v8=;
        b=Xy8gd1S3VVJCQeNYw6bdof/9X6WJOxa0r9VDV4WypFOWt4Pxag+6LUgC+Ej7RlDdGy
         nATonNQ+sqT2fZgB/ck/Z4T5Vxjipt73tCZ7vBdh0S14+K7baPX/2G3YuwHfF+dWFZUB
         DDD3LieenXsnhVSe3VZIScDU6PaWJEZS6wH3PWIXd76i8M9h4Xxwn1ZGXu+knibM4OKd
         agXUj0qRkCYLP7aYA8daiWrCIivl/L2bsVX17IJHZ8S9aS3/pb332ddY4Fd80t6eiTxe
         DSM96EKmBqccZy5vgvMhgon7oNiODYas8/Mtn75M6U2OLOdBgpwL+0ytzCHdiGiuJXr9
         2XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Lc+CRz37aIH1qb4D7Cnk+dsGVj3FmfEkpPWIkrX+v8=;
        b=U+TB1ts92Rvo+NQJvgcvInw6U0kqTr9MI6dBA0J5U/98XsnzA3arJOrdytlLk3NfXp
         tdP/QJoftxiArPTM7Kd+hno0vF/R2gAYuZ3xUizJMBPwNmpSWxvKOqoAEDBEREnncEmJ
         HAovwI/SXGAj3yiNV5WKXLL2KvUej12GuCwIaZsp4CTwepyvF/2vc7Ubp1bnyroJb442
         SzZr7HuWhJfdRVTlYwsEni/b2knGqIVVd7u3+ewC4pVGGz+38UZgGqTzbKIqH+mrXtnU
         08RAa+74pmpOmS36myvSwl/KeY1t+lSssXXeOOW8hAkQwBcYIb/yQiY2deVtjn7iTdyz
         xP4A==
X-Gm-Message-State: AOUpUlE/Q1R9LcK3j1lsE1hu2WSWVb1O2TOgJUEi1T2BGn/GhMtxsebQ
        3y1t7/8WnPaMlIyz6st8r82w9HR89N4agO4IrnY=
X-Google-Smtp-Source: AAOMgpcSRWtbbvytkIzgRhc2sbRH1OW6e5JpLTwwTQHohLhgFLGowZEnu4TH6IcVRiu7mnLBvd3gLX5f393DspY6X+4=
X-Received: by 2002:a19:5d54:: with SMTP id p20-v6mr235368lfj.143.1531364930411;
 Wed, 11 Jul 2018 20:08:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:53d7:0:0:0:0:0 with HTTP; Wed, 11 Jul 2018 20:08:19
 -0700 (PDT)
In-Reply-To: <20180711133137.GM99251@atomide.com>
References: <1531294352-27385-1-git-send-email-koen@dominion.thruhere.net>
 <1531294352-27385-3-git-send-email-koen@dominion.thruhere.net> <20180711133137.GM99251@atomide.com>
From:   Robert Nelson <robertcnelson@gmail.com>
Date:   Wed, 11 Jul 2018 22:08:19 -0500
Message-ID: <CAOCHtYhENAEiUPPzTVLDUt-eZgexEo7UqpxJg_5-Q=xTtxqtCQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: dts: am335x: add am335x-sancloud-bbe board support
To:     Tony Lindgren <tony@atomide.com>
Cc:     Koen Kooi <koen@dominion.thruhere.net>,
        linux-omap <linux-omap@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 8:31 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Koen Kooi <koen@dominion.thruhere.net> [180711 07:36]:
>> +&cpu0_opp_table {
>> +     /*
>> +      * All PG 2.0 silicon may not support 1GHz but some of the early
>> +      * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
>> +      * to support 1GHz OPP so enable it for PG 2.0 on this board.
>> +      */
>> +     oppnitro-1000000000 {
>> +             opp-supported-hw = <0x06 0x0100>;
>> +     };
>> +};
>
> Is the above valid for new boards or should it be just
> dropped? Or is the comment just out of date?

For SanCloud, this can be dropped, they got normal 1Ghz parts from TI.

and they aren't using the Octavo SIP which didn't have the 1Ghz efuse set..

So just the normal am335x errata, nothing special required in it's dts...

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
