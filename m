Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5A4C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457320854
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="nguKD1JX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E457320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeILWhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 18:37:12 -0400
Received: from mail-sn1nam02on0108.outbound.protection.outlook.com ([104.47.36.108]:26546
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726862AbeILWhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 18:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db2lnDySMWCDAK8zc6aejmrkNX7mcK6nJBrLR6OyCKw=;
 b=nguKD1JXl0JwZM81fD28CREVCYK0DAQ7lmWfmy3/VQ+wMeiP/9X38gHaOEdjOZJpSmZPlgg8Lkst4r1HSd3nU9E4DMeEfd0bZmYIggJv2JnjkOioAXxDxhX+FIWGF9fw7hcfbxV3ZCL30g1kgvzfJXKdsQp+rwtTpuocl8unyaw=
Received: from DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) by
 DM5PR21MB0746.namprd21.prod.outlook.com (10.173.172.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Wed, 12 Sep 2018 17:31:37 +0000
Received: from DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd]) by DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd%9]) with mapi id 15.20.1143.010; Wed, 12 Sep 2018
 17:31:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Topic: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Index: AQHUQr3c+8f45WjXpUKg+K5Z8FLtkaTpT5WAgAOn2AA=
Date:   Wed, 12 Sep 2018 17:31:37 +0000
Message-ID: <20180912173136.GC3821@sasha-vm>
References: <20180902064918.183387-1-alexander.levin@microsoft.com>
 <20180902064918.183387-49-alexander.levin@microsoft.com>
 <0cee99b8-fd6d-43b5-e553-2df2939bf40e@arm.com>
In-Reply-To: <0cee99b8-fd6d-43b5-e553-2df2939bf40e@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0746;6:bBUsORj/+Zg2kPnFoGQHmrOieB0YSzx5UQaP1uvM/VwutlBtW0NngJ5/3VzRRCj4pASiZKxvjJKcA4dp4GcOSyN5uR28cU3YyjClt5rRlTcsxwQDK+5b5n/0vpBM9ZJYM3y5n28E1mM4MSDfhAUqYFC6vRxlpfAhR78vAhLZLrRLiEOSQx0OMT56zs6/zURpG2uaTJI1lknduUUOGcgc1eonDqIhQEJ+pnemYtJc70NhnR8dKi9mJsuIe8k5UHn8hBL9GGKyYs8biZmz3yz3koj0PILvJ2RHTPU2tjGV4iFZFgyw/VqKfvwRixiz1qS6+2KNULMVFaIaMqQA0E7XDnM2YZUkzBzFmxFPIM0rTMuIMSrLD7fjxlKVHUTwzLiDsovEHNdng2OYHFGvw7QondteIfF1cn/QiuTfYet784f04yBZrsucVAK4SON7ERW4uEy8VjVQU/eturH2Ptt0RA==;5:dtv5MdY9Mv86UxxV9S1tfvXGtmgNF0fuK87ssi6+C9vPy+qPBvpftq3EFEYRuu646wplNdIVfcLBwn5c6etBZ3aUnhqTkLWcg9z++1zZA8D+KJwyvHhhOZw6wL0d60ohymlqf4WmArBLeM9sFr8cpFqqTe/zVwEjvMdNDIAHr1c=;7:hpN0+cMbE+gGjcCGhlJGZD8a5gBQQDNvAz031acd7bWY/DaeYMuMTV+JCcWzK4JkQwOj5WS1av6a2YDvJOuekIFkDG9SW8bD8h31v8h2Ml62mACr02ZNjn8qwn1LVgO6slFOn8Hrl2l2+mbY5skdUdgaioagvKZNSdMr7lspVTtXd9jG9NY7xvotRUbS3FSpzTwrkPZJCkin4KBRsgc1+5dTn7lZog/Wx+cIf8XzPhn/pQyGZ1/rJNnTLXYT7Q2H
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 620aa6cd-fd0a-4352-0c9b-08d618d59807
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0746;
x-ms-traffictypediagnostic: DM5PR21MB0746:
x-microsoft-antispam-prvs: <DM5PR21MB07466CA3BAD5025901878E00FB1B0@DM5PR21MB0746.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231344)(944501410)(52105095)(2018427008)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:DM5PR21MB0746;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0746;
x-forefront-prvs: 07935ACF08
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(39860400002)(136003)(376002)(366004)(189003)(199004)(1076002)(186003)(102836004)(6346003)(86612001)(26005)(575784001)(86362001)(106356001)(105586002)(446003)(25786009)(11346002)(6506007)(33656002)(6246003)(6116002)(3846002)(33716001)(8936002)(5250100002)(66066001)(14444005)(256004)(486006)(476003)(4326008)(217873002)(68736007)(7736002)(14454004)(53936002)(2900100001)(305945005)(9686003)(6512007)(10090500001)(10290500003)(99286004)(76176011)(33896004)(229853002)(478600001)(81166006)(81156014)(8676002)(6486002)(72206003)(5660300001)(6436002)(6916009)(22452003)(2906002)(97736004)(316002)(54906003)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0746;H:DM5PR21MB0778.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: QIAG/TuvP5W5/NrVsOjY/PGdDbEgG/rMqmzXLVLaGryzeTIIv5hgExZbNerAddVJB87pCqxSUoVtbmWjjiotPcJX+MKkCL1M+q359ihfcI1HAHbv/wKTdHnk/v4te6vscuEc2tZoYEDgjyEjA5kU7Z5jQtql+kHonK9Gx/lfEvA5tfMAumSuME7MmhxOoGFIp03CP5xpKFYghb+TH5qp9edb8vtVi3z6oSTZAsJGkjkHldPHeDfHE6+3+1k2a7bV2sBwEAU5l4XGbYggj8fVt5w/vZgDh2eFKExBMiOetKR8bUrvQ9dz5bSrvh6DyRgH3MGtgyxeYlIDsfRaYLQjApVaNodULC7fOn0Zwgi/sZ0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B5CF0C6BD3F1F64CACD7B6B4F527E2CB@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620aa6cd-fd0a-4352-0c9b-08d618d59807
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2018 17:31:37.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0746
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 10:42:05AM +0100, Vladimir Murzin wrote:
>On 02/09/18 14:07, Sasha Levin wrote:
>> From: Vladimir Murzin <vladimir.murzin@arm.com>
>>
>> [ Upstream commit c803ce3f18bd93b3b4a15d1da0c5b5ebc60e0b85 ]
>>
>> ARMv8R adds support for VBAR and updates ID_PFR1 with the new filed
>> Sec_frac (bits [23:20]):
>>
>> Security fractional field. When the Security field is 0000, determines
>> the support for features from the ARMv7 Security Extensions. Permitted
>> values are:
>>
>> 0000 No features from the ARMv7 Security Extensions are implemented.
>>      This value is not supported in ARMv8 if ID_PFR1 bits [7:4] are zero=
.
>>
>> 0001 The implementation includes the VBAR, and the TCR.PD0 and TCR.PD1
>>      bits.
>>
>> 0010 As for 0001, plus the ability to access Secure or Non-secure
>>      physical memory is supported.
>>
>> All other values are reserved.
>>
>> This field is only valid when ID_PFR1[7:4] =3D=3D 0, otherwise it holds
>> the value 0000.
>>
>> Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
>> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
>> ---
>>  arch/arm/mm/nommu.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
>> index 91537d90f5f5..08794bb0cada 100644
>> --- a/arch/arm/mm/nommu.c
>> +++ b/arch/arm/mm/nommu.c
>> @@ -305,7 +305,8 @@ static inline bool security_extensions_enabled(void)
>>  {
>>  	/* Check CPUID Identification Scheme before ID_PFR1 read */
>>  	if ((read_cpuid_id() & 0x000f0000) =3D=3D 0x000f0000)
>> -		return !!cpuid_feature_extract(CPUID_EXT_PFR1, 4);
>> +		return cpuid_feature_extract(CPUID_EXT_PFR1, 4) ||
>> +			cpuid_feature_extract(CPUID_EXT_PFR1, 20);
>>  	return 0;
>>  }
>>
>>
>
>NAK - it is not stable material.

Removed. Thank you!=
