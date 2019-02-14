Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D85DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B50222C9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 05:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cZy9SDpJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfBNFAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 00:00:10 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:29743 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbfBNFAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 00:00:09 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190214050007epoutp0120c14545219185ad24b92524839decb7~DIkws8dt72862728627epoutp013
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 05:00:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190214050007epoutp0120c14545219185ad24b92524839decb7~DIkws8dt72862728627epoutp013
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1550120407;
        bh=F8YM528KelIj1eFihOY1iV7CQ1dPgc9DCXWq79BTBvw=;
        h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
        b=cZy9SDpJEAollU4RALDtcRbKUoXU5GTFVjJd+1h0uxO7VuFpJtz6spiIsXMxMOtNZ
         xmbdGREz+vCRbisnp0YrPVFvB2pcnJI/PBVNzH4v5MsXs2CjfrxQW0olUaQDkrl5Eo
         6MWEmfRc2fQ0dBykpZOjaFAMTRY/8ERPxQwkx4f0=
Received: from epsmges5p2new.samsung.com (unknown [182.195.40.195]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20190214050004epcas5p3398b5697205c90ce8654d2012a41ef49~DIkuPGqvl2349323493epcas5p39;
        Thu, 14 Feb 2019 05:00:04 +0000 (GMT)
X-AuditID: b6c32a4a-aefff70000001029-59-5c64f5d4754f
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3D.1A.04137.4D5F46C5; Thu, 14 Feb 2019 14:00:04 +0900 (KST)
Mime-Version: 1.0
Subject: RE: Re: [PATCH v4 6/6] RISC-V: Free-up initrd in free_initrd_mem()
Reply-To: chandan.vn@samsung.com
From:   CHANDAN VN <chandan.vn@samsung.com>
To:     Mike Rapoport <rppt@linux.ibm.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20190213180557.GA15270@rapoport-lnx>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20190214050004epcms5p4d2157380c40e9b218fb0eeb376b3cb7c@epcms5p4>
Date:   Thu, 14 Feb 2019 10:30:04 +0530
X-CMS-MailID: 20190214050004epcms5p4d2157380c40e9b218fb0eeb376b3cb7c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRmVeSWpSXmKPExsWy7bCmlu6VrykxBpv2KVo8+TCRzWLr71ns
        FotWfGexOD1hEZPFyj0/mCwu75rDZrHtcwubxeYJC1gt2mbxW9yY0sBm8fLjCRYHbo8189Yw
        ehzu+MLusXmFlseERQcYPTYvqfd4v+8qm8el5uvsHp83yXm0H+hmCuCMyrHJSE1MSS1SSM1L
        zk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAbpVSaEsMacUKBSQWFyspG9n
        U5RfWpKqkJFfXGKrlFqQklNgaFSgV5yYW1yal66XnJ9rZWhgYGQKVJmQk7Hsz1v2gt2iFftn
        rWZpYHwn0sXIySEhYCJx/8dDpi5GLg4hgd2MEqunz2LtYuTg4BUQlPi7QxikRljAW2JFz0F2
        EFtIQEHiyJu1LBBxbYmuw2/AbDYBTYkT86aB1YgI+EusvfqXHWQms0A3s8SOfzeZIZbxSsxo
        f8oCYUtLbF++lRHE5hQwktix+DwTRFxU4ubqt+ww9vtj8xkhbBGJ1ntnoeYISjz4uZsRZs6K
        tVtYQJZJCLQzSqy4s5AJwpnAKNG3aAtUh7nE45ubwTbwCvhKzL77lQ3EZhFQlZgxcwPURS4S
        Z/5/AoszA722bOFrZlBIMAO9tn6XPkSYT6L39xMmmGd2zIOxVST+vV4KZUtJXLzyDcr2kJh5
        aBULJHTPMklc2beJZQKj/CxEAM9Csm0WwrYFjMyrGCVTC4pz01OLTQuM8lLLkaN1EyM4xWp5
        7WBcds7nEKMAB6MSD2+FUEqMEGtiWXFl7iFGCQ5mJRFexY9AId6UxMqq1KL8+KLSnNTiQ4ym
        QH9PZJYSTc4Hpv+8knhDUyMzMwNLA1NjCzNDJXHeubJzo4UE0hNLUrNTUwtSi2D6mDg4pRoY
        E5InTVVrmyR6VY01oW/ifufAh5XXZq10cxNkvLNOSyf1VVtD4aIn3rw+mywMpefPipPZdaii
        KZM17XG4QIyV/sWgtpPBOzIypi18lP8o5v2C4/sOVU/dcSwv4c+mCZevGH/dtFyp84l9jaNm
        UPBk9ai3hxWcYjYH3jP79335qrXdUedq4vR8lFiKMxINtZiLihMB0At0H8cDAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190213180621epcas4p44685b5689a3fcfbe63453e808f502548
References: <20190213180557.GA15270@rapoport-lnx>
        <20190213063127.28703-1-anup.patel@wdc.com>
        <20190213063127.28703-7-anup.patel@wdc.com>
        <20190213064419.GA27012@infradead.org> <20190213073835.GA18267@rapoport-lnx>
        <20190213175415.GA11635@infradead.org>
        <CGME20190213180621epcas4p44685b5689a3fcfbe63453e808f502548@epcms5p4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On=C2=A0Wed,=C2=A0Feb=C2=A013,=C2=A02019=C2=A0at=C2=A009:54:15AM=C2=A0-08=
00,=C2=A0Christoph=C2=A0Hellwig=C2=A0wrote:=0D=0A>=20>=C2=A0On=C2=A0Wed,=C2=
=A0Feb=C2=A013,=C2=A02019=C2=A0at=C2=A009:38:36AM=C2=A0+0200,=C2=A0Mike=C2=
=A0Rapoport=C2=A0wrote:=0D=0A>=20>=C2=A0>=C2=A0memblock_free()=C2=A0is=C2=
=A0has=C2=A0no=C2=A0real=C2=A0effect=C2=A0at=C2=A0this=C2=A0point,=C2=A0no=
=C2=A0idea=C2=A0why=C2=A0arm64=0D=0A>=20>=C2=A0>=C2=A0calls=C2=A0it.=0D=0A>=
=20>=C2=A0=0D=0A>=20>=C2=A0Looks=C2=A0like=C2=A0the=C2=A0call=C2=A0was=C2=
=A0added=C2=A0fairly=C2=A0recently=C2=A0by:=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=
=A0commit=C2=A005c58752f9dce11e396676eb731a620541590ed0=0D=0A>=20>=C2=A0Aut=
hor:=C2=A0CHANDAN=C2=A0VN=C2=A0<chandan.vn=40samsung.com>=0D=0A>=20>=C2=A0D=
ate:=C2=A0=C2=A0=C2=A0Mon=C2=A0Apr=C2=A030=C2=A009:50:18=C2=A02018=C2=A0+05=
30=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0arm64:=C2=A0To=
=C2=A0remove=C2=A0initrd=C2=A0reserved=C2=A0area=C2=A0entry=C2=A0from=C2=A0=
memblock=0D=0A>=20>=C2=A0=0D=0A>=20>=C2=A0which=C2=A0claims=C2=A0it=C2=A0is=
=C2=A0to=C2=A0work=C2=A0around=C2=A0the=C2=A0initrd=C2=A0being=C2=A0display=
ed=C2=A0in=0D=0A>=20>=C2=A0/sys/kernel/debug/memblock/reserved.=0D=0A>=20>=
=C2=A0=0D=0A>=20>=C2=A0I=C2=A0really=C2=A0think=C2=A0we=C2=A0need=C2=A0to=
=C2=A0have=C2=A0common=C2=A0behavior=C2=A0there=C2=A0-=C2=A0either=C2=A0do=
=C2=A0this=0D=0A>=20>=C2=A0for=C2=A0all=C2=A0architectures=C2=A0or=C2=A0non=
e.=C2=A0=C2=A0I've=C2=A0just=C2=A0sent=C2=A0a=C2=A0series=C2=A0that=0D=0A>=
=20>=C2=A0consolidates=C2=A0all=C2=A0but=C2=A0a=C2=A0handful=C2=A0of=C2=A0t=
he=C2=A0free_initrd_mem,=C2=A0so=C2=A0implementing=0D=0A>=20>=C2=A0any=C2=
=A0common=C2=A0behavior=C2=A0on=C2=A0top=C2=A0of=C2=A0that=C2=A0would=C2=A0=
be=C2=A0good.=0D=0A>=C2=A0=0D=0A>=20I've=C2=A0just=C2=A0started=C2=A0to=C2=
=A0look=C2=A0into=C2=A0it=C2=A0today=C2=A0:)=0D=0A>=20I'll=C2=A0reply=C2=A0=
on=C2=A0that=C2=A0thread.=0D=0A=0D=0AINITRD=20reserved=20area=20entry=20is=
=20not=20removed=20from=20memblock=0D=0Aeven=20though=20initrd=20reserved=
=20area=20is=20freed.=20The=20same=20can=20be=0D=0Achecked=20from=20/sys/ke=
rnel/debug/memblock/reserved.=0D=0AWe=20did=20not=20face=20this=20issue=20o=
n=20arm32=20architecture.=0D=0AThough=20the=20changes=20which=20i=20had=20s=
ubmitted=20does=20not=20fix=20any=20memory=20leak,=0D=0Ait=20does=20make=20=
sure=20that=20the=20entries=20freed=20from=20memblock=20are=20actually=20re=
moved=0D=0Afrom=20the=20sys=20entry=20as=20well.=20=0D=0AAlso=20the=20imple=
mentation=20of=20arm64=20is=20quite=20different=20from=20arm32.=20I=20feel=
=20a=20generic=20=0D=0Aimplementation=20can=20be=20taken=20up=20only=20if=
=20its=20a=20real=20necessity.
