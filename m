Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD40CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703BA2080F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 20:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eWvfmyeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 703BA2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389024AbeKVGvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:51:42 -0500
Received: from us01smtprelay-2.synopsys.com ([198.182.47.9]:34954 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbeKVGvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 01:51:42 -0500
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 60A4324E039E;
        Wed, 21 Nov 2018 12:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1542831355; bh=53N6lv59bHizH+C1e6qoRPcUG/qknSSogLi9WBLdaJ4=;
        h=From:To:CC:Subject:Date:References:From;
        b=eWvfmyeGzMa37KTWvvBXKM+tAoJESEm+9FFHhjyvetX9f8RAJXVw1yZKzq0Hu7yKZ
         VUMpFNK+fhXVtpeRoKwHdJoDVHhClZKrdoaR07PV8Bi8RtP3fnJJMv/ef05JXTrByH
         mu9+1vHSbIbnZvnAw+loKZT8FDYA/WcQ1V80ehtl0b/VSGOn3JF78wc4/CSTwdO0FI
         zYbHuBDhnipZHi/pgK8odSuXVeQ1PScA8ymMbIP+sWGaqYVd45UUD2xB927yl9QgsZ
         2vwNTr/IaMf6OICWUdy7x/CLW9dKjwyVhX3CWA6okc3QBZmchpSfHo5LzvjNFe1Sel
         WoHoJWRljc6uA==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4FFD458FE;
        Wed, 21 Nov 2018 12:15:55 -0800 (PST)
Received: from US01WEMBX2.internal.synopsys.com ([fe80::e4b6:5520:9c0d:250b])
 by us01wehtc1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Wed,
 21 Nov 2018 12:15:55 -0800
From:   Vineet Gupta <vineet.gupta1@synopsys.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Vitor Soares <vitor.soares@synopsys.com>,
        "alexey.brodkin@synopsys.com" <alexey.brodkin@synopsys.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        "jose.abreu@synopsys.com" <jose.abreu@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Misaligned Access
Thread-Topic: Misaligned Access
Thread-Index: AQHUa8BEl692JJiolkiUiQERHFjjDw==
Date:   Wed, 21 Nov 2018 20:15:54 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075014641664A@US01WEMBX2.internal.synopsys.com>
References: <13D59CF9CEBAF94592A12E8AE55501350113CD10@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075012B0B4CD5@US01WEMBX2.internal.synopsys.com>
 <9ffd1270-ad92-88b7-eb53-85c65fe971dd@synopsys.com>
 <f8c469e7-9e1d-18d6-4e56-ba4338462048@synopsys.com>
 <ebe7f165-2901-2885-0583-c7be53329372@synopsys.com>
 <4881796E12491D4BB15146FE0209CE6468198AC6@DE02WEMBXB.internal.synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA230750146415496@US01WEMBX2.internal.synopsys.com>
 <661a4323-5768-4977-5434-ab644c5418aa@synopsys.com>
 <C2D7FE5348E1B147BCA15975FBA23075014641580A@US01WEMBX2.internal.synopsys.com>
 <CAK8P3a1Gszsg7Wky+7Z8TuOtAtZR2ia-QjYm01-wWKRmYfdm7Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.106]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/18 12:12 PM, Arnd Bergmann wrote:=0A=
> On Wed, Nov 21, 2018 at 8:42 PM Vineet Gupta <vineet.gupta1@synopsys.com>=
 wrote:=0A=
>> +CC lkml, Arnd : subject matter expert=0A=
>>=0A=
>> On 11/21/18 10:06 AM, Vitor Soares wrote:=0A=
>>> I use the follow function to get data from a RX Fifo.=0A=
>>>=0A=
>>>=0A=
>>> static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,=0A=
>>>                         u8 *bytes, int nbytes)=0A=
>>> {=0A=
>>>      readsl(master->regs + RX_TX_DATA_PORT, bytes, nbytes / 4);=0A=
>> So the semantics are reading the same fifo register N times, to get the =
N words,=0A=
>> hence read*s*l is appropriate. That however expects the buffer to be 4 b=
ytes=0A=
>> aligned, hence your issue. You can't possibly use the reads*b* as we wan=
t the=0A=
>>=0A=
>> The obvious but crude hack is to use a temp array for readsl and then co=
py over=0A=
>> using memcpy, but I'm sure there are better ways, @Arnd ? To summarize i=
s issue is=0A=
>> a driver triggering unaligned access due to the misinteraction of API (d=
river get=0A=
>> an unaligned u8 *) which goes against expectations of io accessor readl =
 (needed=0A=
>> since the register contents are 4 bytes)=0A=
> Is this again on ARC or some other architecture that cannot do unaligned=
=0A=
> access to normal RAM? On ARMv7 or x86, you should never see a problem=0A=
> because the CPU handles misaligned writes. On ARMv4/v5, the readsl()=0A=
> implementation internally aligns the access to the output buffer so it=0A=
> will work correctly.=0A=
=0A=
This is indeed on ARC: on ARC700 unaligned access to RAM was never supporte=
d and=0A=
on HS38x cores, it is configurable, so the API probably needs to support bo=
th cases.=0A=
=0A=
Thx,=0A=
-Vineet=0A=
