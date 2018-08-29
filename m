Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D0BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A652064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 17:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="VYTcatW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A652064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vmware.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbeH2VNZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 17:13:25 -0400
Received: from mail-sn1nam02on0080.outbound.protection.outlook.com ([104.47.36.80]:42868
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727704AbeH2VNZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 17:13:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdGoVDBo6m8J+zWuMspEuybL4lMfHBkeAFWeI9ds+9E=;
 b=VYTcatW/1xT0hVkm5wcfRwN+XN+v1WF8CMeyhy3jVexXub9RhjgNsSYajYtOmPrDBa542p2FjUh0kVg3wrgonLRwkNieIWeiUfGzt9E1CQema3pYmFTNauU0TOla4JjzWx1oPIuHda0GuTiYa82liT580oBBFmJseeOflWY/Ebg=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4552.namprd05.prod.outlook.com (52.135.203.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.7; Wed, 29 Aug 2018 17:15:28 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::911b:395c:ce8a:38c3%3]) with mapi id 15.20.1101.007; Wed, 29 Aug 2018
 17:15:28 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 6/6] x86/alternatives: remove text_poke() return value
Thread-Topic: [RFC PATCH 6/6] x86/alternatives: remove text_poke() return
 value
Thread-Index: AQHUP3Aw84pFc4/aQEq6pXO9r3vtaqTWfRYAgAB7ygA=
Date:   Wed, 29 Aug 2018 17:15:28 +0000
Message-ID: <F9672E89-C01C-443C-A1FB-6EA2B66CBB4D@vmware.com>
References: <20180829081147.184610-1-namit@vmware.com>
 <20180829081147.184610-7-namit@vmware.com>
 <20180829185222.e85026ff22638002a1df70e0@kernel.org>
In-Reply-To: <20180829185222.e85026ff22638002a1df70e0@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR05MB4552;20:OU2exeQgUsmE8ZsaQUAugPtXz6f8sZeuKYoCtI10PvAXYTJZnQMi17yKM/jZVZNPCFu/1ruDZQIv/eG1nVBxu2x0utsSjWoS0IMhnH+wVAXbr22a8Vtdm9YJdI7tQPDLkfBV9ScBwU6Ir/7c+digHBKbmcRRM5ujMOv/+Hh2/14=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7e2439e1-899b-49f9-a065-08d60dd3046c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:BYAPR05MB4552;
x-ms-traffictypediagnostic: BYAPR05MB4552:
bcl:    0
x-microsoft-antispam-prvs: <BYAPR05MB4552E00FBD48F7599E8B279ED0090@BYAPR05MB4552.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699016);SRVR:BYAPR05MB4552;BCL:0;PCL:0;RULEID:;SRVR:BYAPR05MB4552;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(54906003)(8676002)(6116002)(14454004)(3846002)(33656002)(6246003)(316002)(68736007)(7416002)(81166006)(8936002)(82746002)(6916009)(7736002)(81156014)(5660300001)(305945005)(97736004)(2906002)(76176011)(6436002)(6506007)(86362001)(486006)(105586002)(83716003)(2900100001)(26005)(186003)(11346002)(102836004)(446003)(2616005)(476003)(36756003)(66066001)(106356001)(229853002)(6486002)(217873002)(6512007)(478600001)(256004)(5250100002)(99286004)(4326008)(53936002)(25786009);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4552;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +mEiZx7mODO+q8lNJnifop/Q1j9Pu9yDu6sBOSJPPV/J8D8GDxf9RLNA9IKWbR8+7Y5K9enUjgjOcQDA7/Y7+7BFBL+s2ge/sJwl5wwreWExOwcAstFR5dPaMWG6PDUmsrv57YaHGCIfz18US6lvCG4oYFehN8jChM6b7HlsSZom8cIsMdgpIEWEZoaEWn584k5ZiuKVT+aPhL4Dy9dPhAtkkIgHSnt/UUcNe/TS2bRilVPdfpQvAkdRbucLaWa4tgt9LCCNgZiRBau8e510LrOBkG9P4JvF8E3+wXZK08w/L1zSFgUyaOxoL0fkK+sukbSl0ZISRLbWH/isZ4zgr0g6jPWdSTWxTCpNppartEY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62C9C6614C839649A17A51265DEFD93E@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e2439e1-899b-49f9-a065-08d60dd3046c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 17:15:28.0023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

at 2:52 AM, Masami Hiramatsu <mhiramat@kernel.org> wrote:

>> --- a/arch/x86/kernel/alternative.c
>> +++ b/arch/x86/kernel/alternative.c
>> @@ -795,7 +795,7 @@ static void text_poke_safe(void *addr, const void *o=
pcode, size_t len,
>>  *
>>  * Note: Must be called under text_mutex.
>>  */
>> -void *text_poke(void *addr, const void *opcode, size_t len)
>> +void text_poke(void *addr, const void *opcode, size_t len)
>> {
>> 	bool cross_page_boundary =3D offset_in_page(addr) + len > PAGE_SIZE;
>> 	struct page *pages[2] =3D {0};
>=20
> Could you also remove "return addr;" in this patch ?

Oops. Thanks!

