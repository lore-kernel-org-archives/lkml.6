Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA76AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBFD206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 21:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiKmmD2a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CBFD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389808AbeKVHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 02:51:29 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60580 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731503AbeKVHv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 02:51:28 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wALL4Bid174985;
        Wed, 21 Nov 2018 21:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2018-07-02;
 bh=7/umXGXBV3C2e+3VNDbja6cAXnD2lMfY4lBkbez89IA=;
 b=kiKmmD2aa0O4zM8bCmL4nygC17oR3hx4e0a+gEwVlt82XnFJk5QW79+TMVSKmVrYvjgY
 zVbindcfLPr/jmLDYYjQcwt/MLvyRCR3fACNfXUhl9kZ8krl4ixTdn5KQGJPnVw/Zh+W
 XC9y7cJ1JqHjEcC8XvL95irH6gGlUWqtWSNiubsrsHmDzPJxQv1hskE9kluPokWsdTYD
 Sr75y7zJgbz8mmAwsKamJNZMN1oYHIBRfBz2F6HsdX1wA9A3VeuEuFVqKOFvZyEXoDG2
 DPSc+zfdR6+hzTbx5D3vHimZQTnVElrhtx3JuHRGW8Ucz6ktLr6JTVxjtXiYnUk5jVFm Gg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2120.oracle.com with ESMTP id 2ntaxqbqcy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 21:14:56 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wALLEtIG008043
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 21:14:56 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wALLEsKo010846;
        Wed, 21 Nov 2018 21:14:54 GMT
Received: from oracle.com (/23.233.26.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 13:14:54 -0800
Date:   Wed, 21 Nov 2018 16:14:47 -0500
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Out of tree module build errors since v4.20-rc1
Message-ID: <20181121211447.weqjjk2fwbc27er6@oracle.com>
Mail-Followup-To: Nadav Amit <namit@vmware.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181121205633.oxksehwjg5a2q6rt@oracle.com>
 <5A24CA1A-3059-44BE-A0D5-4E29FC6E5BE9@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5A24CA1A-3059-44BE-A0D5-4E29FC6E5BE9@vmware.com>
User-Agent: NeoMutt/20180716
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9084 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nadav Amit <namit@vmware.com> [181121 16:12]:
> > On Nov 21, 2018, at 12:56 PM, Liam R. Howlett <Liam.Howlett@Oracle.com>=
 wrote:
> >=20
> >=20
> > My out of tree driver build is now reporting issues with the jump table:
> >=20
> > ./include/linux/jump_label.h: In function =E2=80=98jump_entry_code=E2=
=80=99:
> > ./include/linux/jump_label.h:153:14: error: dereferencing pointer to in=
complete type =E2=80=98const struct jump_entry=E2=80=99
> >  return entry->code;
> >              ^~
> > ./include/linux/jump_label.h: In function =E2=80=98jump_entry_set_init=
=E2=80=99:
> > ./include/linux/jump_label.h:180:7: error: dereferencing pointer to inc=
omplete type =E2=80=98struct jump_entry=E2=80=99
> >  entry->key |=3D 2;
> >       ^~
> > ./include/linux/jump_label.h: At top level:
> > ./include/linux/jump_label.h:212:26: error: array type has incomplete e=
lement type =E2=80=98struct jump_entry=E2=80=99
> > extern struct jump_entry __start___jump_table[];
> >                          ^~~~~~~~~~~~~~~~~~~~
> > ./include/linux/jump_label.h:213:26: error: array type has incomplete e=
lement type =E2=80=98struct jump_entry=E2=80=99
> > extern struct jump_entry __stop___jump_table[];
> >                          ^~~~~~~~~~~~~~~~~~~
> >=20
> >=20
> > This happens in v4.20-rc3 as well, so I bisected between v4.19 to
> > v4.20-rc1 which resulted in the following commit:
> >=20
> > b34006c4258c9c86597b6b7123d6a9a3513d6cd7 is the first bad commit
> > commit b34006c4258c9c86597b6b7123d6a9a3513d6cd7
> > Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Date:   Tue Sep 18 23:51:41 2018 -0700
> >=20
> >    x86/jump_table: Use relative references
> >=20
> >=20
> >=20
> >=20
> > Initially I assumed this was my own fault, but my module does not have
> > these issues when using v4.19.  Is there anything I should try/change in
> > my module makefile, includes, etc to support this relative reference
> > code?
>=20
> Do you see HAVE_ARCH_JUMP_LABEL_RELATIVE set in your kernel config?
>=20

Yes:
 $ grep HAVE_ARCH_JUMP_LABEL_RELATIVE .config
 CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy


I should have mentioned I ran 'make defoldconfig' between each bisect.
