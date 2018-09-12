Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A23C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4534E2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="io9V298S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4534E2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeILWLy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:11:54 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:43714 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeILWLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:11:53 -0400
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id DCBC024E2442;
        Wed, 12 Sep 2018 10:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536771986; bh=qdkcKry7FoKTqKkw+p/R2udJLE6bAT63Nqb+T1FGIyE=;
        h=From:To:CC:Subject:Date:References:From;
        b=io9V298Ssin5WxHH3qu73FrN/UtaO0V7d0uhmrFZsfHUJtW1uv++4ISeUI7pFY/dN
         Y6TFOPgStGLnGbTq8Z2+Djr3TwfBiJCt16hTWPqJ5PT+gYtET/J5lUr2rawkn6gk6w
         tEiEXo/HiJoDu8WPKMGO9r68IB4I94o7OdLJFNywZk4H/Bi36/GQhPYrF/t0NEjQxE
         sGlk0jznWH7JcnUbslE4609P37zuU1cgRFQKbUoI49iPyUT2Q1xxeoVn+eCLdiORaC
         AWf7GLohXm9BCKH+LcwK+Srh3UlvDIMg2lrjKfvKkBnoL0Yz9kFrBOALIOyGBTEeoM
         n3RW2s7PPlkJg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        by mailhost.synopsys.com (Postfix) with ESMTP id BEA0F3CAC;
        Wed, 12 Sep 2018 10:06:26 -0700 (PDT)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.253]) by
 US01WEHTC3.internal.synopsys.com ([::1]) with mapi id 14.03.0361.001; Wed, 12
 Sep 2018 10:06:26 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Claudiu Zissulescu <Claudiu.Zissulescu@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Thread-Topic: [PATCH] ARCv2: build: use mcpu=hs38 iso generic mcpu=archs
Thread-Index: AQHUSrnSGrPxheeqgEeU4ZLjmI6SIQ==
Date:   Wed, 12 Sep 2018 17:06:25 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA23075012B0949BC@us01wembx1.internal.synopsys.com>
References: <20180912165817.GA5118@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.144.199.104]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/12/2018 09:58 AM, Guenter Roeck wrote:=0A=
> Hi,=0A=
>=0A=
> On Fri, Sep 07, 2018 at 03:13:10PM -0700, Vineet Gupta wrote:=0A=
>> helps gcc with better instruction selections such as 64-bit multiply MPY=
D=0A=
>>=0A=
>> before=0A=
>> ------=0A=
>> 82c34b58 <sched_clock>:=0A=
>> 82c34b58:	ld	r2,[0x83068d00]=0A=
>> 82c34b60:	add_s	r2,r2,0x7530=0A=
>> 82c34b66:	mov_s	r0,0x989680=0A=
>> 82c34b6c:	mpymu	r5,r2,r0=0A=
>> 82c34b70:	mpy	r4,r2,r0=0A=
>> 82c34b74:	mov_s	r0,r4=0A=
>> 82c34b76:	j_s.d	[blink]=0A=
>> 82c34b78:	mov_s	r1,r5=0A=
>> 82c34b7a:	nop_s=0A=
>>=0A=
>> after=0A=
>> ------=0A=
>> 82c34b7c <sched_clock>:=0A=
>> 82c34b7c:	ld	r0,[0x83064d00]=0A=
>> 82c34b84:	add_s	r0,r0,0x7530=0A=
>> 82c34b8a:	mpydu	r0,r0,0x989680=0A=
>> 82c34b92:	j_s	[blink]=0A=
>>=0A=
>> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>=0A=
> This patch causes my arc2 test builds to fail=0A=
>=0A=
> Building arc:axs103_defconfig ... failed=0A=
> --------------=0A=
> Error log:=0A=
>=0A=
> standard input}: Assembler messages:=0A=
> {standard input}:154: Error: inappropriate arguments for opcode 'st'=0A=
> {standard input}:157: Error: Insn j_s has a jump/branch instruction j_s i=
n its delay slot.=0A=
> {standard input}:186: Error: inappropriate arguments for opcode 'st'=0A=
> make[3]: *** [net/core/dev.o] Error 1=0A=
> make[2]: *** [net/core] Error 2=0A=
>=0A=
> Building arc:nsim_hs_smp_defconfig ... failed=0A=
> --------------=0A=
> Error log:=0A=
> {standard input}: Assembler messages:=0A=
> {standard input}:218: Error: inappropriate arguments for opcode 'st'=0A=
> {standard input}:9329: Error: inappropriate arguments for opcode 'st'=0A=
>=0A=
> Building arc:vdk_hs38_smp_defconfig ... failed=0A=
> --------------=0A=
> Error log:=0A=
>=0A=
> {standard input}: Assembler messages:=0A=
> {standard input}:9629: Error: inappropriate arguments for opcode 'st'=0A=
> {standard input}:9883: Error: inappropriate arguments for opcode 'st'=0A=
>=0A=
> I use a toolchain based on gcc 7.3.0 and binutils 2.30. What version=0A=
> of gcc and binutils do I need for the builds to complete ?=0A=
=0A=
Hmm I have a prebuilt 2017.03 release of tools (gcc 7.1.1 based) and I don'=
t see=0A=
the issue above when building net/core/dev.o=0A=
I presume your toolchain was built off of upstream gcc sources.=0A=
Can you please post the output of your arc-linux*gcc -v=0A=
=0A=
Thx,=0A=
-Vineet=0A=
