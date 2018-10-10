Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473E2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58F92087A
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:39:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Lpx2gPda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D58F92087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbeJJWCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 18:02:04 -0400
Received: from mail-eopbgr80053.outbound.protection.outlook.com ([40.107.8.53]:12483
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726515AbeJJWCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 18:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j6VnsLqNKhqty4AWf4qGQKjvAmaZTnwIW/zEHDXtITk=;
 b=Lpx2gPdaj08qmEupVmiDAALnrbdXwGdpuUstxpfrbKPCVvW4ezUfBQaplh2xX54oTWjkQop2nMXzyoXgOO8aVoQ/bwu1ZQE30HG2W+ssmNcZXVtL5fhpiikoDUe2zu+ziDwmDQKlgf3sxCc67JXxPUafCYfrkFRrdRebbz1AEHI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from [10.2.206.68] (217.140.106.49) by
 VI1PR08MB3294.eurprd08.prod.outlook.com (2603:10a6:803:3e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1207.26; Wed, 10 Oct 2018 14:39:10 +0000
Cc:     nd@arm.com, Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, Adam Borowski <kilobyte@angband.pl>,
        Alexander Graf <agraf@suse.de>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andreas Schwab <schwab@suse.de>,
        Andrew Pinski <pinskia@gmail.com>,
        Bamvor Zhangjian <bamv2005@gmail.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Christoph Muellner <christoph.muellner@theobroma-systems.com>,
        Dave Martin <Dave.Martin@arm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Florian Weimer <fweimer@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Hogan <james.hogan@imgtec.com>,
        James Morse <james.morse@arm.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Lin Yongting <linyongting@huawei.com>,
        Manuel Montezelo <manuel.montezelo@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Nathan_Lynch <Nathan_Lynch@mentor.com>,
        Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
        Prasun Kapoor <Prasun.Kapoor@caviumnetworks.com>,
        Ramana Radhakrishnan <ramana.gcc@googlemail.com>,
        Steve Ellcey <sellcey@caviumnetworks.com>,
        Pavel Machek <pavel@ucw.cz>,
        Palmer Dabbelt <palmer@sifive.com>,
        Wookey <wookey@wookware.org>
Subject: Re: [PATCH v9 00/24] ILP32 for ARM64
To:     Eugene Syromiatnikov <esyr@redhat.com>,
        Yury Norov <ynorov@caviumnetworks.com>
References: <20180516081910.10067-1-ynorov@caviumnetworks.com>
 <20180724173957.GA22106@yury-thinkpad>
 <20181010141017.GA2881@asgard.redhat.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=szabolcs.nagy@arm.com; keydata=
 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
Message-ID: <7aac1a08-8948-1a04-cbd3-fbc6a53f9ff0@arm.com>
Date:   Wed, 10 Oct 2018 15:39:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181010141017.GA2881@asgard.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: MRXP264CA0045.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:14::33) To VI1PR08MB3294.eurprd08.prod.outlook.com
 (2603:10a6:803:3e::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76a0f89f-9b61-4b57-fc5e-08d62ebe2595
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3294;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3294;3:9zBg+jT62hKCdlA2UAXFhZnhosVwJzQ9OP+AuLmH1S+uxoL/YqioHRkpHZTv8XtLKhcAOES/Sd9oDNwxFySFNTVqcqnZW0FSTVGMkC4GlxXOX/SkI/fJaPd8oZMjvovWW1M2j2Y24Mlu2am6gTKiWeuHYCVH1SgfV1XcdkLTA+AZp24d0ZSkpjWUZ547SfGeSTeaNwhkgDKC9aZxAvOvwgfNj23m99ATfel+NOQAC5+csxgyDitUH57jJwP4LBSK;25:9fkYwvZTv55hQ0Pss8OqjZaNpmqrz5Wjjp9lJGgluVy9XjGfoUzVy4KEpZx7fqhuTwsNAtDBWinlzoVIB/L+sbhlSdh6uus7oYyWrqIkmhVt+kWoH8J0SHl5WRHs6BacK05UNeZa5nX4T0ZsVIWf9U7BB7u2z6k4nntRj2PfaVqCahyPGqJE1fLTfoC2Va6LQ1+Jn7OSKn3pJWc4DuHJyWf7TzVTa3in/Ao9R0VrHGv35UQ5m8g1P/h++Z5P4BL6Xxalxo4ye3RUlmegBUQeWrjlSiONCE/W79QOhgTTJ+kr9uEn2Ds2+HSp2THlCIpMyOPSmfcYKiFNiyO6rudFhg==;31:+ZaGH+VYfpufmJqsGeudf0rANR9PR98tA3cZWpOYnCe/fD6T8BbRcO4UeZGLkv66BnHB4MTHfbS6VPD4QrRwhcz352ApbLn7iJYfkaDa0egSiOynlvkt2mQS9S3UqADndC6kgMWl9CWxJuc0NnMXby76OBveg4hCEPgaWvSuEUCYLd3zGcgQSjKwRRQaGotHub0yG+YN6xG/s7O39+W45MfXBhIfprWfZr52/bHO2WQ=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3294:
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
NoDisclaimer: True
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3294;20:riTH4ni0o08ng5mvPa9OpQUebFk0Rm3VNP8XDdFHTa5v7k8TmGieTO7cLZo7Y9Q8wc5giepx0tdVyJkXb7xOqcdHTw+zwnrPJ2ScOQU3CixpA/G7rV8r9D8BpdAnskxjYfDD9dZQvX3cY09gSMVQpyo+ydRl+D9y6qNcG/1Aa/K4RhgrKTvFh6UnPgDiRVs7kb5QAwTYwStxqGqh1sHVfFplbzj7acQ/XI3NxWRyCjybEUcZmIXGEPwirPoEezJkIG8lwQsX2t2xopuhmKTbq0PkodIKF+xp3+cKrNx416/hpNv4C8LIZ6fwhvpBNY89xrIEQ2iGJYHUAGoiNuZilIdsYKWgpMqwQ7bH+Mp7KqQPBJLZOWIXon3JKiziOinlmY7zeI7PBlyYTDWdIiSkxRC7ngrv8HWLHVIvNEVXopQ=;4:+i0Kic5YLK42bf/BQcNeuAHdYnsOozHb3Xe7of8tG7uUmU2i90krTOUZQZ5aaAsUpdSm/8RfPbwT3SeRi7WU4eFfFJOmQSkxbs29XMzn0ytDUmaLwAoszyGMR48UPt9VVAHK2zCRm9yXsRv2ChrN9uHSHFqbIUwIe12gU0g04SUjAlUIhV1px6zGCoonsCnU0BmeBZtYS5VSiUjpAifNS2sfoDEjNMK9Phzx2bIEWYkS+zDzs++bY6h4Yv7EkufI6vmE7bYV3dimDlW9T+h5Fw==
X-Microsoft-Antispam-PRVS: <VI1PR08MB329480CD20CBF086066FFA56EDE00@VI1PR08MB3294.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:VI1PR08MB3294;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3294;
X-Forefront-PRVS: 08213D42D3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(376002)(136003)(346002)(366004)(189003)(199004)(6486002)(25786009)(72206003)(478600001)(230700001)(97736004)(229853002)(53546011)(386003)(31686004)(16526019)(106356001)(3846002)(186003)(105586002)(6116002)(77096007)(7416002)(7406005)(68736007)(50466002)(26005)(2906002)(7736002)(52116002)(305945005)(23676004)(2486003)(52146003)(76176011)(36756003)(47776003)(64126003)(66066001)(65956001)(65806001)(81156014)(81166006)(8676002)(8936002)(6666003)(86362001)(44832011)(65826007)(5660300001)(4326008)(39060400002)(2616005)(956004)(476003)(11346002)(446003)(53936002)(31696002)(6246003)(58126008)(486006)(110136005)(16576012)(54906003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3294;H:[10.2.206.68];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMjk0OzIzOkdWZjBBVkUyU01Gczl1NHlZV0kyTUhwakZE?=
 =?utf-8?B?STMveUhDcWQ3Q0VFMHZCckxwNnZxcUpTYVdMUm1EWWszZndObCtlcXo3RU5C?=
 =?utf-8?B?WGdQcDBPRndBVXdSYXZOYjNjS01LQ1REVEdWdjF2clZVOTZ4RlJZcllUelpU?=
 =?utf-8?B?bUxBTUJmMC9oeVZRNmhJU05ibm8rVm9CQWVOQ0lFREF0UEQ1aDd4aG1Cb3I3?=
 =?utf-8?B?VlppUGNPL2xJa3pobG8vU3pqbSt5d2piWEZIZXdXRVltVzc2S3cvbmd2S005?=
 =?utf-8?B?K2plZnNwcWttMDBwemRrQWtLWElmSjgwaURIeDdqM2x0MXd0RW9uOUYya3NP?=
 =?utf-8?B?eXpyV1grUTZMbkpxYzhzcFl1MjJUckl4YUR5bzFTdWcxWGd4RXdDU0pRMjE3?=
 =?utf-8?B?QzdYekNGaE40Wm1OQUVsNlpDM25WYTMrdEJFTVFNMmwrUWRSdE1DRjRyMDhK?=
 =?utf-8?B?d1hIM1BURWxCYy8vZTlobGFlbG4wUzduNzkweENHbkw4RkE1SnFlcFZLRlNm?=
 =?utf-8?B?cS9CUHJzNjhFellETS9jSjB5REc4bmF0Rnhocnh3QSs5OE8vcHhwOXg3SlpZ?=
 =?utf-8?B?WllwV2FmQVd3NDRHM2pObUw2NG5aYUNBd3cvVWFGVlptazFWandJRCtWSXRN?=
 =?utf-8?B?eHNPakdQY1RCU0h5ZXFvek9ncVZMbkkycFU0cHk3cmhBd2c1MEJLbFBjV2dS?=
 =?utf-8?B?WTZtWkJvK2pIelRMRm95SnFlVy9nSmhkQkwxampVdlVET2pFbHJVMG9YQzRv?=
 =?utf-8?B?R2hBTjVCVkR1S05iV2tPTjdKL2NQa25lZnRvUXhuRjZGaFNiQU9iNHFIcktE?=
 =?utf-8?B?YXBreG01b1FwTHVoY3VxZ1M0OHlxZmNkQVhRUXRwMmhCM3BGR1JFZDh0VTdr?=
 =?utf-8?B?Y3loYys5R2dtWjNhaDJKYm9oWVRqbDRKRGNKS2gyUUdOSkxmV016c1MxVHhK?=
 =?utf-8?B?RnhYT2JKMVBXakJlK3NIS2JrNEJYdDN4WDhCRkxnQ3RoYjJZKzkzYjB6MlRH?=
 =?utf-8?B?RTdicEJYNnVXSWE5dXNCeE9qWmZHSDRaZk0rL0lmYmw3Vmg1Kyt0QVF6OGZC?=
 =?utf-8?B?cVBDR2xPV3VJOStqNm90MmJ2b085NlBrQngvSWtzMXVzV0xxa2xkckMyRFg5?=
 =?utf-8?B?Qko4eWludTI5VUVwOWlBY0dGcnRla2ZSdnhGdDZqQ1VPdlVlZjNsOXMxWWhK?=
 =?utf-8?B?N2JuUk1xYWgvU1dSTXRMMDFZWHNCSkpyUnE2eFlkZU1iQmgra3BGRWYxZXVN?=
 =?utf-8?B?WDN2eXFVRHNIWUJvdmxmb3U5MjJQSG9FdmxQbGJuQkxvV2lJYW95dTZER1dX?=
 =?utf-8?B?OHArVFVQY1BrUG5hejlWWnY0Y0dvSldaTStjZmd1b0RIR25GZXUzSTZqRGVF?=
 =?utf-8?B?Z3VXa1NXdnQxbXJiMUh1NFVSUXFRQW1nTUg5OEIwREFnM2VGYkdLME14bEQ2?=
 =?utf-8?B?MHZwdkFXNGpQTHFnZlR1MmsycVRaQ3g2R2NPc2gxUHBvNTRQdVR0Z3RQUGdy?=
 =?utf-8?B?c2V2Sm51cStEcXpySWFtQkJFNlVjQk5mOGpaNGJ4UU01NHZ1czRhakNNWkU1?=
 =?utf-8?B?NmZtR0VqSFJIbktsS3JUTC9DbXU3OVdOcm5KV2x3bEpFVU1vNEltSmh3VVE0?=
 =?utf-8?B?UGgwZ3hZUVZ4Nm1hcmNLYng5cDZNbzBIQ2RscXdqM3ZjcFc4ZUhMNnpUeEFu?=
 =?utf-8?B?ak5WcWZFcXR1ZEJBV05Td0t3NDI5VEFCVC95cW0rMFpjcnBudmZxbUxBVXov?=
 =?utf-8?B?aWc0MlRXL1pMTkxVYko4TjNPV0owd2RHNXAvOTMycW45ZTNBMktJYnRGN3ZI?=
 =?utf-8?B?ZU9kN3FiNko1TG5zbDF3MHp2cDg5VmNPaTRiYTR4TWJtT21LRzYzVjFFMVRC?=
 =?utf-8?B?OGJNZ3h4b3AzQSs3eDJZejNMZk9MZnFpN2JzaThEb21mS2xyYmQ1dmVSQ0R3?=
 =?utf-8?B?dnl4TkRlSCtaUnA2RFJnVWIrSXJsVFhXd0lSbzZKaExsenBOL004YkVVcUd5?=
 =?utf-8?B?a2d1K2piakRpcHF3TytCa09iUDFxSEpOQ1lib0pKc1A0OVNHb3B0aHdjV0ZR?=
 =?utf-8?Q?8X2UPOM4HsVaFvOF0YGphoS66?=
X-Microsoft-Antispam-Message-Info: bjZzyl8F/P9b4M4sem/Lry+WSxM+AmywD9WlX1YC9RYdt5ejRHLFNjnRradjeKnaFtaGCAS5rwiJbznoRLRvdg8HwzqWmPZUvCMiJo8sGjeRLV0M9E4RKnVGwdWZSsxVa5k62JCdMKa8l642LNhMlR55C5EMtsLPKzcGBhaA2LV4QuXvryLklMDy0IfaP11SrI5AY22YYDxUSOp3eGvvHWF35liwRTyaTUCjOtcUGJBJVIhJjgLAYmHn2sfFHe06mgb41VXol5GOJNSTKfvedFtbMJsFex6xAMNx8wtrT76iBNus2nQ91VpPDzUBoHTcfDElwRaOI1KfmyPK5T+JYjcZRhE5XIZHlu+fj4NhIc0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3294;6:b09xOwUFDveSEMgt7FUXuS3EZNpNBTJhIM3aicFndPFL3BVEw/n0Npc4/haP4ObljGlr1/FXKcxYSij1qh96y+M9zLhVh50mbUTrvxZ0aE5YvrPSGkhVouzcY07txRo6aGXsNN76uXM6sc+V5Dd/cMHSb5Kpyz2NAWDOB0E7fdWfrSxHUxg41vDIIsgB32K9+kQfwBj0js5Bc10bnAzi/sJA71jpW6/GFnXUbfeq5HbRyAurQjx2cW8SlUyWt12G3SlyZXbYnvaaOjq3c3tAG6/qqqikZCeF1VwwoQaWzFiBhVI1GLIE+/rE+emc06XwhZsRc8fi20snMuvepn/yCbT9rryi0Sxxai9yNS06zJdnoxwyasL5Lyrn/4Z/qSP6537HuqTn5n70tqGG+NRxcvDexN+uEmJRHbjFpYYaNv2y4Ztm/3+JfAPNjfN9K4DBrCzbI6nKAEWdOCTkD3307g==;5:OL4xdbXDoskxkoNBIlcXIs5kycmx6IuBqdfs1ZqYDt8ZDowg0x6hP+X2EX2x+VRgfqpGmvgJjWCZgRu7aTMcjCG1Pc5Q7eQZaHxnbkBhFLoWXsKBNAmwVlnWbgUCc+kaIarMcnxyXFt/+2H4KFrjR63Ut3b1ibkzZquMLvVPaAU=;7:HurWN06MHNj/rdu2LwAZXFtrXBSkj8xGvUrJovdguSUdheqV8axr4BxYe+O6bjLZKGea0nsjUXBhHg67gdqOm0Vd2dI0mP/FQKoCP12tEEqD/vVMn9+m/c8dIodNiqScwhjoGTuX5hMiZoCL2MODrjcKChJGoQ5wzEAQDygIivwaVz0/hBbx49EKYurSDaBXMFQaP9WL9kDKus/gJKVpIEUkPdhhbkmW3CaIRg7cMwrFoYpc1BXPnochKHWVokvq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2018 14:39:10.3936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a0f89f-9b61-4b57-fc5e-08d62ebe2595
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/18 15:10, Eugene Syromiatnikov wrote:
>  * What's the reasoning behind capping syscall arguments to 32 bit? x32
>    and MIPS N32 do not have such a restriction (and do not need special
>    wrappers for syscalls that pass 64-bit values as a result, except
>    when they do,  as it is the case for preadv2 on x32); moreover, that
>    would lead to insurmountable difficulties for AArch64 ILP32 tracers
>    that try to trace LP64 tracees, as it would be impossible to pass
>    64-bit addresses to process_vm_{read,write} or ptrace PEEK/POKE.

but that's necessarily the case for all ilp32 abis:
the userspace syscall function receives 32bit
arguments so even if the kernel abi takes 64bit
args you cannot use that from c code. (the libc
does not even know which args should be sign or
zero extended.)

process_vm_readv/writev is limited by the ilp32
iovec struct, not by the syscall arguments.

ptrace is specified to take void* addr argument,
and void* is 32bit on all ilp32 targets.
so again on the c language level there is no
way around the 32bit limitation.
