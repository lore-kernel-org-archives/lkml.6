Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CE6ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 528492086E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dominion-thruhere-net.20150623.gappssmtp.com header.i=@dominion-thruhere-net.20150623.gappssmtp.com header.b="Ae6BZuFa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528492086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dominion.thruhere.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbeGQICb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:02:31 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46535 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728172AbeGQICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:02:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id o8-v6so344761edt.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dominion-thruhere-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nF/nmFtzYhJkVF0pQoXeg6hfUo3xmopyzFY75Y31pdg=;
        b=Ae6BZuFa3TSUuUQFWJPrvzRInn0bHELRICSR9BvnGLpCEy+FcWeAteZLJRUq+94M8N
         OzaaIgSfCUiCp63jUg/m7561lrvh55MjjSw0/aygoVdhJIjmqpXVeBQHq/gs6xvDMziC
         gdTzmtLccd7hvBRpol3TwAkDUza4kHh2rMgM5nZLh/fd/BAg1MbVQmbS2v1i/5kSogUV
         TNdig2t1cK9xndlkPQtOVrCIK5lXzNQUi5UNhISggAbESlT49XQj1pPIvnOlyfT5Vuhh
         4sekkUqs2V5b+xEMR6pRPmNYGzplzvrNBCJG2R1rySp2LjtvmCwECKe6oz9F0zd426lq
         A+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nF/nmFtzYhJkVF0pQoXeg6hfUo3xmopyzFY75Y31pdg=;
        b=pVcbhEk4R6nTYxu5HodkMhgF7mNl8KAeY/3IUwcM35O4G66R4sNn1Pbf+tpNjDwAej
         +T+z//78l+BpRRC7MXH9m4Qb7gXSfMBI0GFagB9tRf1MBRV0YJz/wTiTeC0a/VRJ/mJz
         oBQDhIF9KHFqTBtKXRuVmrOJROXQJ4v9Y01F2jAnnZGOQ6n1pF2kmyePqXmPKrzJjhep
         l/11yqXL28i+pctARBPQ97eF+4K0VwTzYkqBPmrnaaPyGdsw42UEb6zrTqJ7oDhWEYvE
         qYL5kPtgowfEp1z890BuhfCayeBQom6EmITtJ3RczbYR4yUXqgKubJ6jZOYOFanyY1D4
         8Kng==
X-Gm-Message-State: AOUpUlHhC7m49zgCW2Ld0dLDLe3lu5PFJIgGXoMnJHiSojM0RM9p3ZDq
        nOvEdRAQGa20Rqep94V1ipIQ8Q==
X-Google-Smtp-Source: AAOMgpeWsiVdbs3/wmfUKbhWC+CNtKBcIgBknIr5llDK5xl/N1YR8OWLgiF7GDnvmxgOC7O6QntDdQ==
X-Received: by 2002:a50:a402:: with SMTP id u2-v6mr1071037edb.237.1531812676919;
        Tue, 17 Jul 2018 00:31:16 -0700 (PDT)
Received: from [172.20.0.13] ([82.163.40.65])
        by smtp.gmail.com with ESMTPSA id d89-v6sm216403edc.93.2018.07.17.00.31.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Jul 2018 00:31:16 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.15\))
Subject: Re: [PATCH v5 1/2] dt-bindings: Add vendor prefix for Sancloud
From:   Koen Kooi <koen@dominion.thruhere.net>
In-Reply-To: <20180717072028.GA3100@piout.net>
Date:   Tue, 17 Jul 2018 09:31:15 +0200
Cc:     linux-omap@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?utf-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>,
        Shawn Guo <shawnguo@kernel.org>, SZ Lin <sz.lin@moxa.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3049450-5391-40CB-ADD1-E1330BFE0525@dominion.thruhere.net>
References: <1531808688-9716-1-git-send-email-koen@dominion.thruhere.net>
 <1531808688-9716-2-git-send-email-koen@dominion.thruhere.net>
 <20180717072028.GA3100@piout.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
X-Mailer: Apple Mail (2.3445.100.15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Op 17 jul. 2018, om 09:20 heeft Alexandre Belloni =
<alexandre.belloni@bootlin.com> het volgende geschreven:
>=20
> Hi Koen,
>=20
> I'm not sure how you expect that to be merged but you should probably
> send this patch to the TI maintainers along 2/2 because probably no =
one
> in copy of this patch will apply it.

Is that the linux-omap list and Tony? scripts/get_maintainer.pl didn=E2=80=
=99t pick them up, which is why they are missing.

regards,

Koen

>=20
> On 17/07/2018 08:24:45+0200, Koen Kooi wrote:
>> Add vendor prefix for Sancloud Ltd.
>>=20
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
>>=20
>> v5: No changes
>> v4: Add Acked-by
>> v3: No changes
>> v2: No changes
>> v1: Initial submission
>>=20
>> Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>> 1 file changed, 1 insertion(+)
>>=20
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt =
b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 7cad066..c7aaa1f 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -314,6 +314,7 @@ rohm	ROHM Semiconductor Co., Ltd
>> roofull	Shenzhen Roofull Technology Co, Ltd
>> samsung	Samsung Semiconductor
>> samtec	Samtec/Softing company
>> +sancloud	Sancloud Ltd
>> sandisk	Sandisk Corporation
>> sbs	Smart Battery System
>> schindler	Schindler
>> --=20
>> 2.0.1
>>=20
>=20
> --=20
> Alexandre Belloni, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com

