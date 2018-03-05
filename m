Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2498535-1520281573-2-4130806441814436129
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520281572; b=pAJa7aZHGmuGrZf6A3Ue7Ig7K9/4CXP8D6lgb9RNsLoHkdh
    hVg0qDlYBVpu26mABV2IPufXvhQ0pLXoCv3iYkyOglIOH7feT1spW7tjPjWmpYAN
    SKF+ayJG8rZKRtwD1JONPykCmlXn6bzNldoCw23x5iuAQ9Rrl3MlnbkYJM3c6Dse
    IPki4pCDEQDzacG+k5TTid2W7FTQiZMtP5LZxDQoF3Bfmh1eDCiV3gkJh0crqMEw
    it7XTYaivy9QnZQSzV7qoTRfw+cwCSUMv5poggUSIAOTqFMb/mGHDoZGIigOF0Am
    BGv3Wosg4afzJT7ICCcKHjJ+KXGsZVMhCTCqYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1520281572; bh=egO72JkrEasJxRKPzDUY8edeQD7dofWTmlOnJ5
    GITm4=; b=sMl/kmhsIpGpZI8mGarNh07fs4UjbvEAxYWLI0bsNoQfkNncaJFRV3
    EbygewOwb7IDzVG8jIDdR5jxcQm/Wy6vCtRdX74Vcv4Zr0NiYKcIcfNeH6XWqjvz
    ieIlVHv0eifdp1lVHWleaQRRTW8F5GIE0Qf3faG+zfVKQcz5wMCjnu+lGglOJJgS
    Mewc/78yMkgONsfZGD/3PlmK67xRe3aT61ANlzF0aWAwv4t5CbN8wLDlQHAKTEgK
    377fJrVZS5GsM66NOtFwYApuEz8npeLZAhCs6AjdGYoybvyRStBjlEvlMIw1EQHE
    3bvNSlSAac6rWKdnUzWU85CQdlK4Eu8Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TggQnnT2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=TggQnnT2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbeCEUZf (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 15:25:35 -0500
Received: from mail-by2nam03on0125.outbound.protection.outlook.com ([104.47.42.125]:15100
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752063AbeCEUZd (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 5 Mar 2018 15:25:33 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Mark Brown <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH AUTOSEL for 4.15 043/102] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Thread-Topic: [PATCH AUTOSEL for 4.15 043/102] ASoC: tlv320aic31xx: Handle
 inverted BCLK in non-DSP modes
Thread-Index: AQHTsz5oqHJB4n39A0Cnby2EjnEZKqPBcPAAgACox4A=
Date: Mon, 5 Mar 2018 20:25:31 +0000
Message-ID: <20180305202529.nji3vacmjqzf2us4@sasha-lappy>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
 <20180303222318.26006-43-alexander.levin@microsoft.com>
 <20180305102124.GB8588@sirena.org.uk>
In-Reply-To: <20180305102124.GB8588@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;20:hHRWkVtwq1C9k0JxZ4mdxJTpZCQ9oCNlRrKpBUM7/ISYaYCn8rFLbhbX38r3zODmvhUCbdVYfraj8VjrCmwa+k/DwPF6qa95RXkPdkYRf2MnxHAf4/FH5KDFWPS96CcYpT+ZDM0yNxmsByhX/M5yWMLobPqyzwroVA4lgSayq1Q=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50e8d5f8-91d8-42d6-e9b9-08d582d73e23
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603322)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920B30542E1F04BE67D98B6FBDA0@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06022AA85F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(7916004)(39860400002)(346002)(376002)(366004)(396003)(39380400002)(199004)(189003)(33716001)(68736007)(86362001)(105586002)(6512007)(4326008)(10090500001)(14454004)(53936002)(86612001)(9686003)(8936002)(97736004)(106356001)(2906002)(81166006)(3280700002)(3660700001)(22452003)(229853002)(6486002)(6436002)(316002)(6246003)(81156014)(66066001)(8676002)(99286004)(7736002)(5660300001)(72206003)(6916009)(10290500003)(2900100001)(54906003)(25786009)(2950100002)(305945005)(5250100002)(3846002)(6116002)(478600001)(1076002)(6506007)(26005)(102836004)(33896004)(76176011)(186003)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 7SeZn1uKCdwxkWPeMKh6GdeF4axBLJdKlPpiZpwOYLJUJP/zFDmgwLSc8HooyJHPPzJjgYHeMSs5pkfrlD6ebVye8ZQJ3QKgNJhWabSy/mF4Q1033zWzMVrWiZCfGznR9hwzMkXFiEufo1wb94W7T0O32+x1145AmjZEDqLjEvXH4OAgV1WOD/aH9WHxoCaPA2908s3kOcGFiVT6jtU32mlnWHlsnB2Fl4ZerbUgYXBaGldUWYkJ5wpuFra4zoKQ6urxEifZniNXPDFWzzzef4i6YeeFz429SXgbZhBjMUyxXMtu3EfGVUkwyycsz/LTOCiuxgLJ5FQDebnnB6g9Aw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2FD1BCED55398E4C9A0372D701956FFD@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50e8d5f8-91d8-42d6-e9b9-08d582d73e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2018 20:25:31.3682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 10:21:24AM +0000, Mark Brown wrote:
>On Sat, Mar 03, 2018 at 10:24:34PM +0000, Sasha Levin wrote:
>
>> Currently BCLK inverting is only handled when the DAI format is
>> DSP, but the BCLK may be inverted in any supported mode. Without
>> this using this CODEC in any other mode than DSP with the BCLK
>> inverted leads to bad sampling timing and very poor audio quality.
>
>This is a new feature, if this makes a difference to anyone in
>production it's most likely going to break their system and introduce
>the problems described in the commit log.

I'll drop it, thank you!

--=20

Thanks,
Sasha=
