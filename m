Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2548C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:36:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E6721533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:36:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lIpztoqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31E6721533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbeIUFWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:22:16 -0400
Received: from mail-eopbgr720060.outbound.protection.outlook.com ([40.107.72.60]:2560
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbeIUFWQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:22:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SuU/MxhZ44XLrBn6cJGeGR0ug26fGkfBmcWgjLDmxk=;
 b=lIpztoqf+pYBi2n3widGmz95kW7eKUOKIcWa5hlAIafEce1h42jdXZpaEETkB5zNpBMtmvsTFOy+wWMjWHJ6BLISL8otHcMOYOevS8P4u+oI6UDtI6rwpJC6+mZT1oS42n+NuYSE8uMrc7uFiL/Inisb67adzFfR5yXyLxyqAZg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com; 
Received: from [10.224.54.236] (165.204.55.251) by
 BY2PR12MB0178.namprd12.prod.outlook.com (2a01:111:e400:585a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.19; Thu, 20 Sep
 2018 23:36:11 +0000
Subject: Re: [PATCH 6/6] drm/amdgpu/dm/mst: Use
 drm_dp_mst_connector_atomic_check()
To:     Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org
Cc:     Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>,
        Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
        Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org
References: <20180918230637.20700-1-lyude@redhat.com>
 <20180918230637.20700-7-lyude@redhat.com>
From:   Harry Wentland <harry.wentland@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=harry.wentland@amd.com; prefer-encrypt=mutual; keydata=
 xsBNBFhb4C8BCADhHHUNoBQ7K7LupCP0FsUb443Vuqq+dH0uo4A3lnPkMF6FJmGcJ9Sbx1C6
 cd4PbVAaTFZUEmjqfpm+wCRBe11eF55hW3GJ273wvfH69Q/zmAxwO8yk+i5ZWWl8Hns5h69K
 D9QURHLpXxrcwnfHFah0DwV23TrD1KGB7vowCZyJOw93U/GzAlXKESy0FM7ZOYIJH83X7qhh
 Q9KX94iTEYTeH86Wy8hwHtqM6ySviwEz0g+UegpG8ebbz0w3b5QmdKCAg+eZTmBekP5o77YE
 BKqR+Miiwo9+tzm2N5GiF9HDeI2pVe/egOLa5UcmsgdF4Y5FKoMnBbAHNaA6Fev8PHlNABEB
 AAHNJ0hhcnJ5IFdlbnRsYW5kIDxoYXJyeS53ZW50bGFuZEBhbWQuY29tPsLAdwQTAQgAIQUC
 WFvgLwIbAwULCQgHAgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAtWBXJjBS24xUlCAC9MqAlIbZO
 /a37s41h+MQ+D20C6/hVErWO+RA06nA+jFDPUWrDJKYdn6EDQWdLY3ATeAq3X8GIeOTXGrPD
 b2OXD6kOViW/RNvlXdrIsnIDacdr39aoAlY1b+bhTzZVz4pto4l+K1PZb5jlMgTk/ks9HesL
 RfYVq5wOy3qIpocdjdlXnSUKn0WOkGBBd8Nv3o0OI18tiJ1S/QwLBBfZoVvfGinoB2p4j/wO
 kJxpi3F9TaOtLGcdrgfghg31Fb48DP+6kodZ4ircerp4hyAp0U2iKtsrQ/sVWR4mbe3eTfcn
 YjBxGd2JOVdNQZa2VTNf9GshIDMD8IIQK6jN0LfY8Py2zsBNBFhb4C8BCAC/0KWY3pIbU2cy
 i7GMj3gqB6h0jGqRuMpMRoSNDoAUIuSh17w+bawuOF6XZPdK3D4lC9cOXMwP3aP9tTJOori2
 8vMH8KW9jp9lAYnGWYhSqLdjzIACquMqi96EBtawJDct1e9pVgp+d4JXHlgIrl11ITJo8rCP
 dEqjro2bCBWxijsIncdCzMjf57+nR7u86SBtGSFcXKapS7YJeWcvM6MzFYgIkxHxxBDvBBvm
 U2/mAXiL72kwmlV1BNrabQxX2UnIb3xt3UovYJehrnDUMdYjxJgSPRBx27wQ/D05xAlhkmmL
 FJ01ZYc412CRCC6gjgFPfUi2y7YJTrQHS79WSyANABEBAAHCwF8EGAEIAAkFAlhb4C8CGwwA
 CgkQLVgVyYwUtuM72Qf+J6JOQ/27pWf5Ulde9GS0BigA1kV9CNfIq396TgvQzeyixHMvgPdq
 Z36x89zZi0otjMZv6ypIdEg5co1Bvz0wFaKbCiNbTjpnA1VAbQVLSFjCZLQiu0vc+BZ1yKDV
 T5ASJ97G4XvQNO+XXGY55MrmhoNqMaeIa/3Jas54fPVd5olcnUAyDty29/VWXNllUq38iBCX
 /0tTF7oav1lzPGfeW2c6B700FFZMTR4YBVSGE8jPIzu2Fj0E8EkDmsgS+nibqSvWXfo1v231
 410h35CjbYDlYQO7Z1YD7asqbaOnF0As+rckyRMweQ9CxZn5+YBijtPJA3x5ldbCfQ9rWiTu XQ==
Message-ID: <98b1d4d5-023b-b630-d5d2-94cfeade2404@amd.com>
Date:   Thu, 20 Sep 2018 19:36:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180918230637.20700-7-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::31) To BY2PR12MB0178.namprd12.prod.outlook.com
 (2a01:111:e400:585a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41a2b869-e786-448f-7f76-08d61f51da60
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0178;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;3:0gNJTsTPPcQUqLb0Fammj8VkwgFOaPtWGJ6aud05/ukYewGgwxANBrqfL4XltuaNrV6l3C4zVgMGSGLcktTj868hkbzSIiEnzgABMFJlC/Ue3QP26wCUCpkeA3W+ck2IYIo+bWsmaD44pmEAkLfZ285XE5lF9YUcAE4TXOpW277NSFHXz+Y2fTyU6hlDMCFgcFx7baeiH41VbznY20oeMno4u5XzcrVscg/ltU7Lss05NiwCEPcz5LZMchMhxfOc;25:XUKRjmeyXesGD7uhFCVTS4gKeZxH7uKT9+pBxuCI0eXVrQdmzDDBgCN2akV5CGIQrS3ah6Wgmz1syHe44UUjMjC+ch76TUfcV/7GNFuZ0JX2icsbstnSSlRfFANmfeFsJcp/ZcRmERnqQnz+sQ1a4bgDa31PTEsnB4g2uyIQ0in43w7iNeGgJfUaGJ2D1uFRywa/9h61CoXmuYN/knfZ3A9fxe4WUgHvjRyZXW3ih2lKJ7udYNQPSpTdIpqzvpbkUlmIxm6nBwNKQghLWoYhIBZeuAV6IGfJzXJESVcqxkddjUi0lw08OTS7qFPIVW6cQcZLO9UyvP8FxaLXUZ8dQtBAd5MuO1pu5gi/6ZcdCzE=;31:D2OxE1op9N2MKRjoQXntPJk7Eay12qs2j4QiPZ9Sh+KuH0l9dAZLbGwHlU2KINJEw9EtQYzQjg7YoHSJ7VR3g/Q8mkGb//X09j/G2Jvxe3+6svSXSL0M5vwPGLFRmOhf4AlAGG1Dwr2sKNYz1uqZnbU3kWa9dYx3McGSV6kJYZLjX4OQ40er/aJOa5p2QQLW2ZomEMt3tdQ9XqHdi4+eOf/lI7T4731lqG1i3lml8NI=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0178:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;20:TAaA47A6onHjGNsuycttacoVQdyEDA7Cx4RptwtNWzZ4qjPf5gV9r2OPPWoWRnDJGFu+AWtShG4L8QhZTS3Gw8yFQ/4eIzrg8v5j2aaNH+cSAYw7ianWh0LOG/MgRgkrwb6hkQWbeITmg6PkvbLV32qt14pjwuBwemoErUN9kd8+AaaCJY/qTevGfCo2D89TveYPLeDQ+DJNW7A87MsLqzTHh0HX5OLfO/oEpXBm8LLhcbTYw9ylLgeTf84ub5nihRzmB5l3onFAJN/KuStuFofraBXPN9Ls++ugy3lzI2jP+oCwYEsJIBdf0yTG67YFISG6p+2/GoHOPUw16R3UGexxXMa+NRGhZPoLAwebEGJw9qDg83m20EZ9gklqCNlldZlYdqH5bUAJ+yBZTofgoHtfdDwBaaWRBofx7hSycuCWwtJ0tyHoj8Y9gOm1CqgKiASrj4bEt3AZnMspBPUlKH2O/slwOSmsBJ+SLGtWO33KE4/pHHWl9bEToZw76GyS;4:rrEmGbBIj7Z0Zxb2VoKZuQf2okpXNXltMa953T3DfbWkeasKYTWywWNKVVjrSB67gypZhx5ikAT8BSKhDkYKUVhAE44aBbsewqlN1qG3MjvPDhK2hew5kWKQdt4Fgwp+FscYNl+bZI7Yc0i2OA66hCQsgNllRoThr1t3WD2zDvbijAInL7gp32axgC3x53rMdwlxkfUxQBMRfGYy2prFlRuwmauQbd+jPHpea5haEaIEDp97bvF4iogXTm50YCuIv3ukTz6kCFOzkGvk+7xT2vtRAkfSFjpWnbbT5UNPbNBbITWVLqG0hGOQXDZZY7o2
X-Microsoft-Antispam-PRVS: <BY2PR12MB01782EF33762CECCFF98C8068C130@BY2PR12MB0178.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231355)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:BY2PR12MB0178;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0178;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39860400002)(136003)(396003)(366004)(346002)(199004)(189003)(25786009)(65806001)(486006)(2906002)(6116002)(305945005)(53936002)(3846002)(14444005)(44832011)(4326008)(53546011)(386003)(36756003)(8936002)(47776003)(54906003)(16526019)(230700001)(26005)(7736002)(229853002)(6486002)(186003)(68736007)(2486003)(52146003)(52116002)(23676004)(86362001)(446003)(31696002)(77096007)(476003)(2616005)(11346002)(956004)(81166006)(6666003)(8676002)(5660300001)(97736004)(81156014)(16576012)(316002)(6246003)(58126008)(65826007)(5880100001)(478600001)(31686004)(64126003)(50466002)(76176011)(66066001)(65956001)(106356001)(105586002)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0178;H:[10.224.54.236];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjEyTUIwMTc4OzIzOlpVbEpibiszazZQeGVWS2JlTEl3djU2Ymg2?=
 =?utf-8?B?OUN5MmJJM1g0Nm5SNDM5TjJMOUdKSCtRMmdtMUhaa20xUlZEaW50U2VBd25B?=
 =?utf-8?B?VmdVQk45NGloZ253Nm0vT1JiemdzTW1LU1czN0p2Rk54SmFRdVJDakZ2VVpa?=
 =?utf-8?B?bkQ1cmVIYWY2UUJMc3pXRGh6OC9GWFdhRXFlR0wrVVlvU2YxdDdBaUNhSHlT?=
 =?utf-8?B?aEVYRGgxVTczVlZzL2lGQksycm9RTTBPWmJjV3N6SGFqTlJrc200a2pPWEZq?=
 =?utf-8?B?SnRQT3FmQnpLcTlnb3l2bWNMQmpJQnRxR2IrZzFndlNmc1dxSFkvM1lUNldn?=
 =?utf-8?B?dGxJNktiVnNacFcxeTVqNC9XWlUwejUrbGJBbUlVRkRSOXRnWkw4YTFTVnFi?=
 =?utf-8?B?dXovckg1bHRLMU5rSWNaNXVHcjh2R2JSZ1dRU1VZNjhzSlVIa0xhUzVjQmw0?=
 =?utf-8?B?VXZHOGJzNlBqTlRFTlExNmIxMUlmbkovN2didFVBK2NJeFlzUCtpelpTeEs2?=
 =?utf-8?B?T0RZZGZxN1cvRTlWSExTSUMrUXp0QmQ5Z09UU0tjeFR6clY2RUtnUTVIcTlw?=
 =?utf-8?B?UHhGb3pwWDR1RGNaSGhKcWRNRGc4aEM1UGhRaVFManJJaHNWK2xtMFBWczZS?=
 =?utf-8?B?WDhxYkVIUis1Z3JvSndTZmx3TXdPcm56NEp2TTBTZzVua3BMUTRSQ3U5M0FK?=
 =?utf-8?B?SUZ5K2o1ZnhlMEk2dVI0b1J4K1pTbVltaHBVb3JmSkRkaDI5TUgzRW5DOGY3?=
 =?utf-8?B?VGZUTit4amJDdXI0b3ZITENWdzdUNmEzQllaVDNNbFh3Y0Y0QWhOVXdnclZv?=
 =?utf-8?B?cU9lOUNwcFlqR29GMFowb1Z2eERUd09vN0NaVjNWL1gvbVlLUEMwWHZFV1Ro?=
 =?utf-8?B?K2xPN1Bub0c2cnhpZXlRUGZEMG1XczU2RDZaZkZYblMraEpUQlhHQm9rVkRS?=
 =?utf-8?B?R2xmSG1uN29sdDA4enZGS3F5WUhBaG5OcWszZUNoN2sySDY1ZWh5L0dod2Fu?=
 =?utf-8?B?bkM0cjBRSmFPTjVPOE5uZWZrYnVyK0o0a0ZUaHgxVUJWeWowUXJCbzRZekhq?=
 =?utf-8?B?RTZaVWswMkdXNWVab0Yrc1hnUWV4QjJnTXl1WHAxRmprcUYrUXJvNXVoZkdW?=
 =?utf-8?B?SVcvTjJOZS8wUE04MTdqNHh2bVBqaDg5UnN2V0g1U3VkY0VyV2s2Q29BYXM1?=
 =?utf-8?B?YXVZbVYxRnE3b0gwajlYbEUyZ2haZTZYOXhPdk5mcjhzQmIvZnVwclB2enBl?=
 =?utf-8?B?SzJFQ25iWHQzNTc5VkpEY2lMak12YmZ0RS82UnNxSGdXZzhoY004TlM5Ry8x?=
 =?utf-8?B?UmFqZGFvRFNMMGo2NDdLWWEyZWlXSnRTNWEvenhPL1RPVldRcmxROWdyUU9q?=
 =?utf-8?B?Uk1aUE41TTBwbUFaSVI3dnRvTWpYWlB1ZWJWbHhBSlNrYWNTRkJRQXNqVlJU?=
 =?utf-8?B?dXIrQWc2UEh0N3NBUnZ3aVRsTUdxYjhvYlRlTlFyWjVIaW1ERGVublZtR1B1?=
 =?utf-8?B?NW4yMEdZbmM5SHJsT3kyUXFtM2pvMHl1T1B3U21Odmk5eXBrMk11SGJBYWFh?=
 =?utf-8?B?VXRWYjZWRXd0TzhQZ0ZvSFBJWTNQakJ5VlJjREV3U08xWEsyN3FseVA0SU9O?=
 =?utf-8?B?TWVnaXpZZEpvalJBZTVwaFBZV2lQQXZicXVKcERFbFJpVVd6UzRCL21xb3Rw?=
 =?utf-8?B?UnkyOVdYSkxrdWNLNnNUd0FwZnNXRUtFUHBLQmREaVBPY1hFTTR1SVh1Tm1L?=
 =?utf-8?B?WWhQVU1BWkdVT3hQcmZ1UC9NRnFwRlY3VEFaLzZYMEhWNmRMOG91MGxWVVR1?=
 =?utf-8?B?WGFVNWRDWWlTd3h2Q3NUNG0vNWpldjV1OU4vWFlkaFRUN1dLK2dXZDR0TTEy?=
 =?utf-8?B?TVlvZC8xcGozMHB2OGNyR1JXSmlPMFRZdlZLaWt0ZmJWMVgyZUZBT0I1ZUNF?=
 =?utf-8?B?TGo0b3FuTHNLQWpaZHlXbEE1aE41VXZJa0VDaEJQVDF2THZ1dE5mS3VYRVhH?=
 =?utf-8?B?Zit2UURqNUpYemU4VVFKRnhXVXZ0U1RlbmlCQT09?=
X-Microsoft-Antispam-Message-Info: cKTvT8Ap7TMkNRTtMqLeMo+vjMcks4LcrX+I6BZ6eiMC4afGuu0nkvdBle9us6WozWXZhF8FZ2OMUnY/nAtcb/oI49MWHqhAEFOT90+k/wR2E1GzaQ+9YoWv/pn/25MHueyIDe8JK/eDEBJqA6G2fdA2m+Th2phZygT6ovkcZJxkucqUOqk/Dj4RXewI0U0h0Bj7+exzZSdhQa0kQS6izWWOTornaiUKMymMoBPDtPbweuSgTpqoUjxczGwt2EcWDYLNuaZ11D7hg9z4HZ7eY+CPUAj11cx5wiUq92xuXAJComRkTQDIj6uC/wf2K6Z0V3k8plQQusL5xCaeb7DinMSq7qgapGGr+vdv9mj19Bg=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;6:yuP2pgstIw1NkK3Q5goLiTb/Dtr+Gcq7bncgKaUfILZISwHHlS6BGWWRG/JRqzyatJzX2Z+R3NneBHuqrKauE3XnN0Mv0JVzI9rFsZQ/JF+1NA6C9wLrD93iXY4smzHYntBnSydimE8qJd3un7dBPnmOKhtbtYwjWAgmS6ZcUMnyrhp3ePwWOGbVn4XdNLLr2rkQgNhFn2jLhzHQITi1y8qonzYQ7qOR/aodYB4XdWoK1mMDimfnMiOQQ8Gstkx1Jwlv9bGLZJIn35lrPieq0TvtyTzLOyH/ky/ygWpNwEXAuTRw6DTW4bbWl9SAHl5L8JeukGLoxaIG4/fzarHb966m47kwC3pmKYLxveWziMTfHbvJlq63uuZ6OP4Z/rZ+DQU3W4HsrG2wboG9f57ZXFd9DobCbHfLNy3l6siJjQVLwdmbEVt84Qd5oWvRPTfQ/+zOp9IC02p58y74MS2uWg==;5:UBj/RQpZYjOqszsjZbk1vD9q1eqGlcob3nZnla/kiGyLnPVHsvKSqJ8/RUtItkmLgRdQG6CB2P8vIi5635fA4x8Oi+WB+HoPuF4GqVWfPYZQBdVfrKjh/c1YbfuiimRX10w/rLuk8Szl0rhD9o8uYiMf6eU0gwmRw5oT1bjKqPM=;7:rwJCQlPlKCjMwt0eNngMqMyHDpIauGSaw8JAFCipXC7c6kC4c/XJc4vnlZR1Ust9icbVusF2MjGnpzrYMsJlSkKlRtJHS7RXECdQxFZIoYYVlVFporQv1GbCd9RxPO39s2HNZCqEcwOwd8RA/vmK1/v7PoPFrDCFR95Pap5DByXVFoRuIrVdJZQFvx8JC4GD4vocoO0FPyyjFhcmMCmmjDHvmb06f6hla519YWp0UW2YMK5e2zzUrwf3J0roMtso
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0178;20:U8+NguKn5w8y7WBeMnFH2uwXRAgDaYR2i18mWh4++6haqHEnym9Lb5JuWVmMJHoD7jJ1QXNfY0pE+enzIc3nXthfRJoaz68PUtkYsD+vvwj+Z0+RYiZbx8U89r086gB0rZCkOUMkTuylsPZLmOwDjneLkrHXxvgyaCUF6OsoDxKAn6QxvWyPlSrbEta72FFbl7hDJMQ6eYNQIidewYIDIVwu5O+gf8TmvzjA4gLMcQJ3thS2Gmhe6XZ9jSchZ5Lr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 23:36:11.5447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a2b869-e786-448f-7f76-08d61f51da60
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0178
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-18 07:06 PM, Lyude Paul wrote:
> Hook this into amdgpu's atomic check for their connectors so they never
> get modesets on no-longer-present MST connectors. We'll also expand on
> this later once we add DP MST fallback retraining support.
> 
> As well, turns out that the only atomic DRM driver without the
> ->best_encoder() bug is amdgpu. Congrats AMD!
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 9a300732ba37..d011a39f17b2 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -294,10 +294,22 @@ static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
>  	return &amdgpu_dm_connector->mst_encoder->base;
>  }
>  
> +static int
> +amdgpu_dm_mst_connector_atomic_check(struct drm_connector *connector,
> +				     struct drm_connector_state *new_cstate)
> +{
> +	struct amdgpu_dm_connector *aconnector =
> +		to_amdgpu_dm_connector(connector);
> +
> +	return drm_dp_mst_connector_atomic_check(connector, new_cstate,
> +						 &aconnector->mst_mgr);
> +}
> +
>  static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
>  	.get_modes = dm_dp_mst_get_modes,
>  	.mode_valid = amdgpu_dm_connector_mode_valid,
>  	.best_encoder = dm_mst_best_encoder,
> +	.atomic_check = amdgpu_dm_mst_connector_atomic_check,
>  };
>  
>  static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
> 
