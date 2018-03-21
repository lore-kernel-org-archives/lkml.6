Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-454547-1521656336-2-11510886240820363821
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521656335; b=Qlc9bXE0sbKf1s41ar09vmIzNzi4xUM9lwFoVYnCTelKqsq
    Uw4pXbDbSN1t3CHVu1gkIiHMdjAJsxRS/ohP70hLOHhasb8bymPtHa7cCczXjC48
    E0QyCkYZs+jRV1pJNIk6riWXvF7PoTCX76Iwt9wmUQugolJzcZpOisZCClvwJM+2
    ouuAayTcPC/5V9l5iII+Gpn1EoCUjDzX26cZOKxaJbjKqYveDeuuDxLqfckXSeiU
    MP00Tt/EuPIhIqKCNI46Vjk0Z5+Eqkr9ua1jkv3XucQPj1fRWev271+oQQ3cr9eF
    vXBELkkgtW58BuFww+zFwjbe6aixtcNFn76vtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521656335; bh=JGLv1Yol7DXzwB5N5yyfq8+GIYxjokbg48ftt1
    RJkqk=; b=CAlZg493/Z9eQT9RX+/8FtIvUOGR/zHLupeWSRX0kW628JWHNWYhGM
    NqUqdqYNNCNOgDUAOjUBEbZLaWRlaG+ievQAdyBl5cWjIwKGN0ACwa5Q8uWFKurp
    2SK1O1XOvpzoi64yIeZzFTvVINSdBbRxAPv8MQaQKenO4uko9QN94TFj0873gmbT
    8b6+SvkGjdM/NtXXiMHwJAJ4QNckrlpslbZJWUfBynNZdPthSu+jTXTCJLaZFk2a
    XNZCjViYNR7PGZz8kErhPhMKO/aK6qkpIhz5MwFXK5e4JX9/x+KrZ78A1Oa6gXUK
    it4DSUWtN+W3JTIPiVcvMYQC9CTPVA5w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ca1ciVLP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ca1ciVLP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751656AbeCUSSx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 14:18:53 -0400
Received: from mail-by2nam01on0120.outbound.protection.outlook.com ([104.47.34.120]:59985
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeCUSSw (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 14:18:52 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Topic: [PATCH AUTOSEL for 4.15 118/124] signal/parisc: Document a
 conflict with SI_USER with SIGFPE
Thread-Index: AQHTv5nU1jM4TEEmbE2qukzwpEcuiqPZPv1OgAHD5AA=
Date: Wed, 21 Mar 2018 18:18:44 +0000
Message-ID: <20180321181842.rhniantbvz25bu2f@sasha-lappy>
References: <20180319154645.11350-1-alexander.levin@microsoft.com>
 <20180319154645.11350-118-alexander.levin@microsoft.com>
 <87zi327ozu.fsf@xmission.com>
In-Reply-To: <87zi327ozu.fsf@xmission.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1045;7:XIQSk12pDr2YqTIYfCx6jK8x1vBaF/i5/LSv9bEZmqp1kpNIAKGKN1W1LKPwksuzyhRhRvcxlMjb19MLQrTDaRy4O7LAov90PVhGMusWSwgt47JYKuHxKClBCIfNrfMgjNLxmCpxU7NuUI1oN4IsF03g5yvOe+7YcPQyEG+dWzR3pcRfe7RZd2QOqSRZWG3VayIWidgV5iFlPQvLv/8R5Ome+lxz7+YhgrLFfs10fQS/OS8qfhz8n0W4UhiYM61d;20:AA5stM1H5dJ2wUSsYdF4g4PEVfbEn9RjYCgmiywmzTlu4KIRGzVzhCH98sELJM4ea2INklchYtqA5/3fpxwho4//9NZp1RS+6qpbueIVX8I51vp3T6n3aDiSG0d7xDUNK9PpFUmU47zGSm+NgIn4CqbJ+BAfdXsc1fRQ86Trvj4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a5a7cbd8-2ed9-480f-a27f-08d58f582efb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1045;
x-ms-traffictypediagnostic: DM5PR2101MB1045:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1045C109B0F11BDBC008E6B8FBAA0@DM5PR2101MB1045.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(26323138287068)(89211679590171)(9452136761055)(189930954265078)(219752817060721);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501316)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1045;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1045;
x-forefront-prvs: 0618E4E7E1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(199004)(189003)(186003)(966005)(3280700002)(33896004)(1076002)(22452003)(3846002)(105586002)(68736007)(478600001)(6116002)(5250100002)(8936002)(54906003)(72206003)(76176011)(2906002)(26005)(53936002)(106356001)(2950100002)(446003)(14454004)(6246003)(229853002)(6306002)(6512007)(9686003)(6486002)(8666007)(6916009)(316002)(6436002)(5660300001)(86612001)(102836004)(25786009)(3660700001)(305945005)(4326008)(7736002)(59450400001)(10090500001)(86362001)(575784001)(2900100001)(66066001)(10290500003)(81166006)(97736004)(33716001)(6506007)(81156014)(99286004)(8676002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1045;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Tr5rKqbW6RF4NqhBKHcsJPA2z8xREZ1Z5BrIeORcQga2stoEKGPPn3CS58TfDpiwCaypnYwdLXPZK8RmdsaG/pkq7/eoiZJNvl0QQKFXSCbatJ3oLbUO80c+EdvmhRdzA7X7sXluUZ+c8JXz2IiWjWlp85WTukdUO0aaf+ASgcko9sloE4muOa3g3JdzglTDpVh6DkjwKVdR+T6r3G/K/qoLVhWPpBeMkmzNPEyperaeWrvD7QuqHuVcS9hbgRb7RlvarvPwrHOG2nyJDvaHCAPMjcIPhvkhTi62t/EXEGsN11vgxj7g2M4MDr2dT+hxl8AgW6qIEYRXgtRqu6ai3Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2B86442F7E408B4AA4501FE7BD9C8E56@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a7cbd8-2ed9-480f-a27f-08d58f582efb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2018 18:18:44.9099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1045
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey Eric,

On Tue, Mar 20, 2018 at 10:20:21AM -0500, Eric W. Biederman wrote:
>Sasha Levin <Alexander.Levin@microsoft.com> writes:
>
>What is the justification for backporting this and the other similar
>Documentation commits?

It was flagged as a bug fixing patch by a new process we're testing, and
when I looked at it I thought that the commit message suggests it fixes
an ABI issue.

>These commits just introduce a define _FIXME with value of 0, to
>document that the userspace ABI was handled incorrectly long ago.
>
>These commits do not fix anything.  Thes commits do not change anything
>except a little how they are handled in siginfo_layout.  And I don't see
>the changes that introduce siginfo_layout in kernel/signal.c being
>backported.
>
>Further these commits don't even have a fixes tag so I am curious
>what is triggering them for backport.

We're testing out a new mechanism where we train a neural network to
detect bug fixing patches and flag them for manual review. We're working
on a FAQ + more detailed information right now.

>Eric
>
>> From: "Eric W. Biederman" <ebiederm@xmission.com>
>>
>> [ Upstream commit b5daf2b9d1c9a2b4f03ca93f75913ba2da3b3eaa ]
>>
>> Setting si_code to 0 results in a userspace seeing an si_code of 0.
>> This is the same si_code as SI_USER.  Posix and common sense requires
>> that SI_USER not be a signal specific si_code.  As such this use of 0
>> for the si_code is a pretty horribly broken ABI.
>>
>> Further use of si_code =3D=3D 0 guaranteed that copy_siginfo_to_user saw=
 a
>> value of __SI_KILL and now sees a value of SIL_KILL with the result
>> that uid and pid fields are copied and which might copying the si_addr
>> field by accident but certainly not by design.  Making this a very
>> flakey implementation.
>>
>> Utilizing FPE_FIXME siginfo_layout will now return SIL_FAULT and the
>> appropriate fields will reliably be copied.
>>
>> This bug is 13 years old and parsic machines are no longer being built
>> so I don't know if it possible or worth fixing it.  But it is at least
>> worth documenting this so other architectures don't make the same
>> mistake.
>>
>> Possible ABI fixes includee:
>>   - Send the signal without siginfo
>>   - Don't generate a signal
>>   - Possibly assign and use an appropriate si_code
>>   - Don't handle cases which can't happen
>>
>> Cc: "James E.J. Bottomley" <jejb@parisc-linux.org>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: linux-parisc@vger.kernel.org
>> Ref: 313c01d3e3fd ("[PATCH] PA-RISC update for 2.6.0")
>> Histroy Tree: https://na01.safelinks.protection.outlook.com/?url=3Dhttps=
%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftglx%2Fhistory=
.git&data=3D04%7C01%7CAlexander.Levin%40microsoft.com%7C3dfe7dd42625456fdb0=
f08d58e7639e6%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C1%7C6365715607897505=
33%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1h=
aWwifQ%3D%3D%7C-1&sdata=3DlXlraRxI0IHdS736PA%2BLO8A4JQJveGitz1pPfpo7QKM%3D&=
reserved=3D0
>> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  arch/parisc/include/uapi/asm/siginfo.h | 7 +++++++
>>  arch/parisc/kernel/traps.c             | 2 +-
>>  2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/parisc/include/uapi/asm/siginfo.h b/arch/parisc/includ=
e/uapi/asm/siginfo.h
>> index 4a1062e05aaf..be40331f757d 100644
>> --- a/arch/parisc/include/uapi/asm/siginfo.h
>> +++ b/arch/parisc/include/uapi/asm/siginfo.h
>> @@ -8,4 +8,11 @@
>>
>>  #include <asm-generic/siginfo.h>
>>
>> +/*
>> + * SIGFPE si_codes
>> + */
>> +#ifdef __KERNEL__
>> +#define FPE_FIXME	0	/* Broken dup of SI_USER */
>> +#endif /* __KERNEL__ */
>> +
>>  #endif
>> diff --git a/arch/parisc/kernel/traps.c b/arch/parisc/kernel/traps.c
>> index 8453724b8009..c919e6c0a687 100644
>> --- a/arch/parisc/kernel/traps.c
>> +++ b/arch/parisc/kernel/traps.c
>> @@ -629,7 +629,7 @@ void notrace handle_interruption(int code, struct pt=
_regs *regs)
>>  			si.si_signo =3D SIGFPE;
>>  			/* Set to zero, and let the userspace app figure it out from
>>  			   the insn pointed to by si_addr */
>> -			si.si_code =3D 0;
>> +			si.si_code =3D FPE_FIXME;
>>  			si.si_addr =3D (void __user *) regs->iaoq[0];
>>  			force_sig_info(SIGFPE, &si, current);
>>  			return;

--=20

Thanks,
Sasha=
