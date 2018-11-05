Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DDAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9920819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 20:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="Rz2S5dnL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB9920819
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=live.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbeKFF1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 00:27:15 -0500
Received: from mail-oln040092009105.outbound.protection.outlook.com ([40.92.9.105]:61814
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbeKFF1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 00:27:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kljs7LYbxnizbkcz7NvALDc4aUm/vqKivx0IQFv17WU=;
 b=Rz2S5dnL164fzdd3cpq0HVRSo6nLm01H6pON1cziy0LIHqF/t69bhGslKSRTAVmSwqtItpFxwmlamLbPbyVjB43QlNJDkBrwORZnpr0yex7y0cCyUX/Tn03/blahoUlLBiYue01+LMY8xKXMO1eUvbWECBbQV0PsvLs70h/e3FxbwSu3QTMJY9/zdWxBJ+tNB2Y0e1yvStDNSg8dVOFOh1FaMl5dACUnjGLhmnLdbfylhzJZLxhv0fHo8jooftsj2kxoKa8ZBkhVNg89rORaQyBigcxG4NeOHGoRfDzqHJiioUkZOWTo7I+dG6IiFhXNzLRa6/aHna3+D5O+uXSZaw==
Received: from SN1NAM04FT061.eop-NAM04.prod.protection.outlook.com
 (10.152.88.54) by SN1NAM04HT229.eop-NAM04.prod.protection.outlook.com
 (10.152.89.17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.14; Mon, 5 Nov
 2018 20:05:54 +0000
Received: from SN6PR02MB4864.namprd02.prod.outlook.com (10.152.88.51) by
 SN1NAM04FT061.mail.protection.outlook.com (10.152.89.201) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1294.14 via Frontend Transport; Mon, 5 Nov 2018 20:05:54 +0000
Received: from SN6PR02MB4864.namprd02.prod.outlook.com
 ([fe80::b55b:eb70:782c:8fc5]) by SN6PR02MB4864.namprd02.prod.outlook.com
 ([fe80::b55b:eb70:782c:8fc5%3]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 20:05:54 +0000
From:   abhja kaanlani <unidef_rogue@live.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Suggestion for intergrated DOC type (like SQLite but a variable) 
Thread-Topic: Suggestion for intergrated DOC type (like SQLite but a variable) 
Thread-Index: AQHUdUL1rAMKGByqDUWrjTXCNWkHQA==
Date:   Mon, 5 Nov 2018 20:05:54 +0000
Message-ID: <SN6PR02MB486437B271AD933CE5CE065583CA0@SN6PR02MB4864.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:5F8325033E1ACBAE365193D0ECCF6867BA19FF0377AE278821A124073567FE62;UpperCasedChecksum:664844B7B7D0EF3D98F77748566C6AF0B058D7665F48262C1BBD4E255ACC5EF5;SizeAsReceived:6923;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [vGenF1otJMEjFlMHGTmIZPhZWIT3aO/c]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN1NAM04HT229;6:HcBNwkAWRGObgFN6L+E9mpuEZJDETl1vRxA3dlLub5jSlQ0sCTMM10gSbN+9Ue5jaqgJVMg0Pq+WEUCRanA8ILGngYdSkMPaszhhVtrHE0yuRupO1PCwoCvXDO3ak+jd76zK9/DcnxB3wuLdewiRPskqHfPP0lMzBOpG884dOcg5UbeVB2ubDWGQV58XSHXyFixDT3LYRpCG7G/hPtKh5UO2uNgufkQfl9CQL/1gXMEtA67KWdzKU+XOJp3hupXseB2N5Xz91jLJ4ueoR324eQ41bRsa03w7Dc9U2tZSAjM4pQtG67qFZUCPacqptzNVPFKiXVD1PgiGexdxgcgo/Y1rwluxNpqh75Zckc4kKUKENuUGp2Mo9W91VDRTAMric8WR012FzCc2u33dGCujtlEU2Ss1JQKOOJyyEtBqfM/4p3m/C1M/HwX0dy5mGK0rITpmcF2iXPUFJTXXD3gb4g==;5:9+4rsHfm7yXW9gk8H7P9zjEL9wNwKWQ6ne0pqMWO7tHFzmJ3TXFeLhmAXmvOGOnfRnSTGDyQ/bDUZJYokAwD6s3uE95bKRNP3xbSR9LNkH+gIj5sKrNy/CUqgkbsDdK3bgbvYuPNG+njnK99R1Yldtdjl7ml50FFqG/xkcHhLD8=;7:uq1YqAjaqOzGh2nZyx+A61d2zCVF6Nr9aSVFdsCMId4qQOkrjlJ69WitnC5JKb4CBezXVMtQqX4+Mn7jgKjoqotSr83EAyIbf2nUMlEWIHtCyi2SQyQEce9du28AZOMFYlaIgaAiFPxteIjpMNPHdQ==
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SN1NAM04HT229;
x-ms-traffictypediagnostic: SN1NAM04HT229:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:SN1NAM04HT229;BCL:0;PCL:0;RULEID:;SRVR:SN1NAM04HT229;
x-microsoft-antispam-message-info: aFGPKq2dBbgiqZVUHYRBKav3GYnJI6kNx3WNwpSTl10uRXrlK6whcXYQO42sCHAC
Content-Type: text/plain; charset="utf-8"
Content-ID: <4F80817850A7AE4B97A1AAB664F03843@sct-15-20-755-16-msonline-outlook-470a9.templateTenant>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: live.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-Network-Message-Id: e84cd2ba-b5b4-49e2-b788-08d6435a17b4
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 7181d4b0-87d6-4f4e-ba33-0d3746212cec
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 20:05:54.2590
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1NAM04HT229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBjYW4gYmUgYWNjb21wbGlzaGVkIHdpdGggbXVsdGlkaW1lbnNpb25hbCBiaW5hcnkgdHJl
ZXMgYW5kIGJhc2ljIGZ1bmN0aW9ucyB0aGF0IHNlYXJjaCB0aGUgc2hhcGUgb2YgdGhlIGJpbmFy
eSB0cmVlDQoNCknigJl2ZSBmaWd1cmVkIGEgcmV2b2x2aW5nIGRtYSB0byBrZWVwIG1lbW9yeSB1
c3VhZ2UgbGVhbiwgYnV0IHRoYXQgcmVhbGx5IHRheGVzIHRoZSBjcHUgSSB0aGluaw0KDQpJ4oCZ
bSBzb3JyeSBJIGhhdmUgdG8gcmVhZCBsaWtlIDMgbml4IGtlcm5lbHMgYW5kIG5vIG9uZSB3YW50
cyB0byB0YWxrIHRvIG1lIDooDQoNCkJ1dCBJ4oCZZCBiZSBnbGFkIHRvIGFuc3dlciBxdWVzdGlv
bnMgYW5kIGdpdmUgbXkgMiBjZW50cyBvbiB0aGUgaXNzdWUgDQoNClNlbnQgZnJvbSBteSBpUGhv
bmU=
