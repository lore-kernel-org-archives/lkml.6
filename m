Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3130C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A277B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 14:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="TFUI6yqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A277B20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeIJTGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 15:06:20 -0400
Received: from mail-cys01nam02on0136.outbound.protection.outlook.com ([104.47.37.136]:8352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728164AbeIJTGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 15:06:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJNPosILFvgz2rR3mfQhUphHayBOaT90howu+6fFb1I=;
 b=TFUI6yqQ1dhGv3R6VumcCehzTcSQwyPhlRo7G9Ask1p3w6J6vmQAmDnsg2Z2+CWaQtQ01zKmQ1ZMswf4vNwRIz4O7wYvn8V0icATfyUFzPuVRLats+WdEBgkfJX9qjqE6Z8wZMoKnbjIHDOjJeo6N3Gt0njJRaN8ipagJKIu6os=
Received: from DM5PR21MB0778.namprd21.prod.outlook.com (10.173.172.148) by
 DM5PR21MB0779.namprd21.prod.outlook.com (10.173.172.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Mon, 10 Sep 2018 14:12:00 +0000
Received: from DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd]) by DM5PR21MB0778.namprd21.prod.outlook.com
 ([fe80::d05f:7c53:cb46:9ecd%9]) with mapi id 15.20.1143.010; Mon, 10 Sep 2018
 14:12:00 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Vladimir Murzin <vladimir.murzin@arm.com>
CC:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Topic: [PATCH AUTOSEL 4.14 49/89] ARM: 8783/1: NOMMU: Extend check for
 VBAR support
Thread-Index: AQHUQr3c+8f45WjXpUKg+K5Z8FLtkaTpT5WAgABLaYA=
Date:   Mon, 10 Sep 2018 14:12:00 +0000
Message-ID: <20180910141159.GP16300@sasha-vm>
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
x-microsoft-exchange-diagnostics: 1;DM5PR21MB0779;6:9mRSyQnfaDUeCK55QsVphsYesB/Ui07mpHMlSbwwyblCa317+isXbbY/8NpxaZLYLEkhmaTkZfBz/UtqabN4t83/nPFPQFkH9k2R6Yu44xMYZFESosSbS7Wg4Y9iFWZmrd4GwsgPSPKbXPxH/8CCoZa0iPODh00No0PFyoSrjTl8lMImoRaMAXJ3Pg5wfxqbv97thLM5ZntusKj8F7PxSMUSdDuMkxT5WttgQ/SWQUHXDoLFihu2cczegGBu/xbQv1x9j+wx89wft+ljB6yINPPVreba66UYei6zx7SvoAbzII5zLApoN5j8hPMtA4MIaFWzcgKeIOUL7x/hUCrAfJVdIOJq8C4GfD8nVjgG6vt5WrxIFEt3dIsU4GzN/aipkmo3vef2WXYBvZU6PbfKBoBFlzCB5QGiLxMnrG4wY5nEboABgbsfYJ+Vds/4yOGILfUu9FM5SvsUxLyxUukSvA==;5:VxtsgKGTX3Vnxj1N1eyKOEn5dK0i6TxIYZqPyisAI4uXkm/lUFrJm/Y5KSVbOcHDJY6PTlzxdlgKlG96Gh1qTFiAeoYWBcJwk3/EooEKqzStIm3yJMuLjsc/RHM36jb5BOgW8LeAVsXOtSfswKWTSmfxaWAiDzsyMahVmKCJSss=;7:6v9/2RiQtw/cFLDorN3I0LAQ0b2sRfqd6m8mzNcj+4x3ACgzzOXFPctLFwgR7yJLwHII63FhTLqIkZoJeE0OhFHF2EYl8a2ILeil6HVw3xvr5OQFV+I4Q3nh9ox5bctUtZBVGMIZG5RureaAki/tOhJOMnjqmO6/qHLVDKU4vkE4GIiFul15zgYqDhixToZu21OU+cw07JpHv8ZH8zZaJKLAcY9UMk29aKbZL1zt7aUML67TGTtjpSl4aE48NFo6
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ea1941e4-7f23-49cb-1c27-08d61727607c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0779;
x-ms-traffictypediagnostic: DM5PR21MB0779:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB0779303747BB386765C78029FB050@DM5PR21MB0779.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(192374486261705);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991033);SRVR:DM5PR21MB0779;BCL:0;PCL:0;RULEID:;SRVR:DM5PR21MB0779;
x-forefront-prvs: 07915F544A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(396003)(376002)(136003)(39860400002)(366004)(199004)(189003)(186003)(6246003)(4326008)(81156014)(81166006)(10290500003)(14454004)(102836004)(72206003)(33656002)(9686003)(105586002)(106356001)(6512007)(10090500001)(478600001)(22452003)(76176011)(6916009)(99286004)(26005)(8936002)(33896004)(316002)(54906003)(53936002)(68736007)(446003)(97736004)(575784001)(86362001)(3846002)(14444005)(5250100002)(8676002)(305945005)(476003)(6116002)(217873002)(256004)(486006)(7736002)(11346002)(1076002)(5660300001)(6436002)(2906002)(66066001)(25786009)(2900100001)(33716001)(6506007)(229853002)(86612001)(6486002)(309714004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0779;H:DM5PR21MB0778.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: WVWpwRXKnuEl6d02yPN5K75fP5tbIWUWq2cRZw6Yd2BzsL8bZyzpK/MNZQAwF51Tpf3urMIU0OQnQGx6jCpjirTeVc6OgMq8omWsAxXH32+9LGoDIiiOXAZJhhqRJJOP+qvvAqljNddJFNgT4fR40bNrmtOMo2IsAZM13P8tmhs4rbSKRjq8ZKchqFSSzr73sQ6Wx72oCz4dStq7fmb3XIK8JMg2JhRAGytNnvYoCu11AlL304d+BOxHOoZQUwFjoel5qcKDxnBs5Y/xPVZsyvLxbmarC4Btflfu7I9uZNu8wHOEIvNCuvSXTqmR9ZEjC1XFvHiGJusxfjN6RJhIGApveAgvJHGRCyOZe0PRWDc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6BC5B038F9733C47A82B29E3F2DCD51C@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea1941e4-7f23-49cb-1c27-08d61727607c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2018 14:12:00.9003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0779
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

Dropped from all trees. Thank you.=
