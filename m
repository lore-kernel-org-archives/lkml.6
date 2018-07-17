Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63E3ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D420657
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="padgQue/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0D420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbeGQPFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:05:21 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:7072
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729389AbeGQPFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:05:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKffjm1dp0BXPCl4mjWAM1rLy14pTo+f3ScvvhyZKY8=;
 b=padgQue/mM/dORCJ5gdjfdBY4R0sx0Jqj70QsHxiqWi5sGvFk0KahsHQPQu8Q1dvR+R/w273hkuM9gNqkhtfn92o0iVSIpiVSri8yK22gYuj5qWLN10FOoAz2B1s4D5MVaKLYwVS5rURtXRcXJUO+hoxL4mnuBXaq6BN1beS/MU=
Received: from HE1PR0701CA0080.eurprd07.prod.outlook.com (2603:10a6:3:64::24)
 by AM4PR0701MB1954.eurprd07.prod.outlook.com (2603:10a6:200:3b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.14; Tue, 17 Jul
 2018 14:32:20 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::201) by HE1PR0701CA0080.outlook.office365.com
 (2603:10a6:3:64::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.13 via Frontend
 Transport; Tue, 17 Jul 2018 14:32:19 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.240)
 smtp.mailfrom=nokia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.952.17 via Frontend Transport; Tue, 17 Jul 2018 14:32:19 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6HEVa6e026463
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jul 2018 17:31:36 +0300
Received: from [10.151.72.141] ([10.151.72.141])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6HEVZGK026430;
        Tue, 17 Jul 2018 17:31:35 +0300
X-HPESVCS-Source-Ip: 10.151.72.141
Subject: Re: [PATCH net-next] net: cavium: add missing PCI dependencies
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
CC:     Aleksey Makarov <aleksey.makarov@cavium.com>,
        Radoslaw Biernacki <rad@semihalf.com>,
        Felix Manlunas <felix.manlunas@cavium.com>,
        Sunil Goutham <sgoutham@cavium.com>,
        Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180717134756.3447762-1-arnd@arndb.de>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <f1cc2710-2bd5-4a55-1a40-67cb2f4e0798@nokia.com>
Date:   Tue, 17 Jul 2018 16:31:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717134756.3447762-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(346002)(2980300002)(438002)(199004)(189003)(106002)(53936002)(110136005)(23676004)(2486003)(106466001)(446003)(31686004)(6246003)(26005)(54906003)(58126008)(229853002)(336012)(77096007)(4326008)(53546011)(76176011)(186003)(316002)(64126003)(5660300001)(22756006)(356003)(11346002)(97736004)(81166006)(81156014)(50466002)(8676002)(86362001)(47776003)(305945005)(65806001)(65956001)(68736007)(2906002)(2616005)(476003)(31696002)(65826007)(26826003)(126002)(478600001)(8936002)(44832011)(36756003)(230700001)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0701MB1954;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT043;1:3sIuRFz5msscg0jPfPcD+G4eVW6ckO+X/a4Eh5cYub85EmkRmiU0yDMnD+YbcP1EubzKPBjalvZqve55ZF7wNxu6WSK9zMvfWotk9ebqITGRK301b6dEPftTvjL1YN+m
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb7a4203-b141-4b2f-b6a8-08d5ebf21a31
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328);SRVR:AM4PR0701MB1954;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB1954;3:QdJXlkNLdJnQi6VO4+iQVgEYrK3JeZx0UNrmbJkj9kpvL2A01Ew4zEWYIf3uRmkqrsmi/v5bfKe0pTMz7QD/i4/g0LMYrrxucZIumzNcB03ZAJR7c6MYtObeAYiUi//OT/qbT11CBBXCAZchoOL8Nhk/iby3sWyhJh8U6dwnHRAtnbgEdfUwCYRt0MZAbCCuUyW5qafzHQ5oWPeTeZCEj3gJtX1B3iaCKaUgN/j6ZzKPW7FzIeW4YB3Env/WazSJu+Dvxi8ccTnhswAYW9C2MISj/i6P810uFCOdUkjQ/ZMKC791Th1SNV938Gv62nNG41diru8Z/3N7yE1LRtU2GH9+nC7pYJ+eaaQamOiozaU=;25:8Xm2id+Uj0WE835ASuxwve7B5IusrnRqaDfOO4JkL0F1p/fiKdqgzcJseDLxoiimc1Ppy0sflJs17e+b/KeE3z4Kf46VDUm5yu9/t+DQJDSUdKmQoGy+2CmeH787eoEB2eKHneP8gz1oCRwvqKjCYFYoD5xXTbhu5v/mAwkM3NgsoLH7B84lt78ePBPhwBF+40MWMTp/efRhv997DG+hmJ9AjrV2VFVf5ghEWp8o33Y5MKsGLboaiBFXIDRyp7wUvTNeRL2RkrTUTWbJEf4dUolZPgQAMj9Uhn56wWCoiVP+Kl7zMCBBx4fxMOndb1fMx9BDFuq/5bsPXyzXUiYItA==
X-MS-TrafficTypeDiagnostic: AM4PR0701MB1954:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB1954;31:x3zEsOlZCu9QZe0bK8pbK7AU90PvxaUGuO3P06QAjdKyMzC2GSVOlfY4StggwdGn354S80bMD7ScckTlVyEXdpblwaGmeJdA36z6u+ggVjcKnvDTucdmtaAcQVm5qZJ5fNBqTZS1yljlIzfBNXwn5NSGmUDviVKo4+643vy8xX5Yx7DcvfSlasjwiX1Pkhpk6jsmH/MdP2koq74NbesIaPUnZpK7GxiY6cIpDCBjKRI=;20:ggo6QcuJrlO0oLggAuoC3ZqztSjSUkRRR988Htt/jzFjGdokuelK7m7z8z6MEnaUGLpQAc4tOvVc9YKENaBTLC9XC6wtzayNUpbqn9xOK4oHvpaMXc0NaChBPNyW4kYVuYm41na7hhSKaaLz0Ztd8gpDWJgQ0efCsKLXx0I75IIXyevBuhv4wEGdyLJw/+F1WCBSi3WMRfHUGSfLtiq10xepED55HSzENz5ITgqk1rKjq3V81UC1j4E3mgpdvYOBLoRkz/dL6ckz/BHw6zH/3XZ31wgwzb18qOWuVeqqgoSdaTpxWAJ3lAXWc3vDZn+SWXgRL0IcBt3DV5ngoTE4khKO89WNB5ZzHW6xcmv+r/zapKpzTuzft/eHIbr1ryPFmMJw36IZy5B4I76upIhsoSS5rJsg3OPrA9ttQsyzr4Zajv1Adytg2DX2FGyNPkTiBVkrv+uqsnBT6XknEO4bo/fr8wUx0NpHM2NcRtrs5biDuXRSL6FBHCZG+e+yIyIK+U6a/Gh97MEjgo4/tElebb8xiip5TV9oAuAqyCjAt5/keqnfStQTDIsxCVrhI4Mia8RVwq2JkXxPPxmYXDrdhqJzF5Ez25laPnbjWy/ZY6o=
X-Microsoft-Antispam-PRVS: <AM4PR0701MB195493DC915AE8E3F1656BC2885C0@AM4PR0701MB1954.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(10201501046)(3231311)(11241501184)(806099)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:AM4PR0701MB1954;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0701MB1954;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB1954;4:CeEQ1s0OE+zVJtxXs4lHvVO3W/29gNiy/WLBYZ2V18tM1adHXDhYGpxKkAR6mcRiosNiHM1ONRW0BQ33ge/GfusIH3EH+9JQjn2JKcgYq+c0gN8jXu/OUU1J/V5n/hq1vsJw3nqM992jxT4BqybdAJWMLEQkQ9MlBXjAZfLYwoK4l0iiyraZRR+S+HErF5JAs1kW/OXOkrA+PIb9fNFlCickwk4cRj3GOWIa8ZdnZmpJ+bPh5fFHJnBmrXb5f7AN27h0WHZ6yQfRoPPcXkHg5g==
X-Forefront-PRVS: 073631BD3D
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjA3MDFNQjE5NTQ7MjM6TkgxUjc4cmZqU0xQbnlWdEtoUm1kbnFv?=
 =?utf-8?B?OVgxbnJ3ZGFPZzZKWjVjSU5YL3pPOWttSFA1bXRiTVlrai9wNFhkSWZ2Y1li?=
 =?utf-8?B?bHE3TmNTbGFtMitNMlBxWGhQK3IvQjlNeXoxV2E5UXd6cEpTcUlIWGdTcDZs?=
 =?utf-8?B?WjVlbjlTTU5GYnBzc2NwQ0twS1BobkRKOEJDcmdXSjdLdjhWT2ZBMC84V0Ns?=
 =?utf-8?B?VWk4MWhDbTNacVNHbjhlVitJdDRieFRydDJpNVM3UlV6ZFVkUEtvNHp6Mzkx?=
 =?utf-8?B?VnVDMXRqYVRhWDFTRHJsYkEwQy9wWUdZalVhMUtUNGhRSTF6ODVhMFJSOFcy?=
 =?utf-8?B?TVBjdEdLZmNrc3pWMkVBOGRCUXRBYkJCNmlqZ09oSVBJZ3ZlSnl5NlpUL2Za?=
 =?utf-8?B?NG5JaXhlaktwLzllSHJFbkpvbkYvMDVLQUdvYzc1Z0I1aWRnUU9OSE9vUzQ3?=
 =?utf-8?B?MElub3M0UnRqNTMxczlFSTF4S1ZPVUthNlVCQVMrMGpMeUpHVUg1MUVPdXVr?=
 =?utf-8?B?MTRIV3RnZGdkTXEvTWFRdVd3Z1A1eXRodW83QVZlb2xqOTI2enE4VVBhWTk2?=
 =?utf-8?B?dTJVRFJDLzVjVHJLWkdiMnNFVUFjMk1hSVJ3ZkVGcEFESjRQQVlWY0RvdnNC?=
 =?utf-8?B?ZkovRmNWSys0QnhIMTR2ckJuVHNxSHZLcjFnakFKdjUzWUZwNWFQZERTdFk2?=
 =?utf-8?B?dFlya294eEhtWG5QdVdOSGtlVGNTOG1RSUNVOFg4SWNnVWlEMGYvL2t5dTRD?=
 =?utf-8?B?a3N5ZFZoeHpNTTErd2lOU1Rub1BjRjByR3I5Zlo4c2tyemxEc3V4THo5ZUtn?=
 =?utf-8?B?aExmQno4Z3NyT21kb2pxcXR6NkRiendtWkc4SWVWUWZQSVliVTY2cmw5YVRa?=
 =?utf-8?B?SXFBcVNiVURiS2VTY1A1aDFJYVlaZFFBeE9nS3IyclNHZXN6dElWajdBRG92?=
 =?utf-8?B?QmRMcWc0OGhzaWhyUnhJVEI3cjRVZmlyeUVQYXJLaGZ6NzBkZWh1M3dKRTRJ?=
 =?utf-8?B?U0lxQ0N5czZEbE1YM0xOc2J5QVVQcGdIRXJhSmxkY1B2czNzQ1VkT3ZmaGZU?=
 =?utf-8?B?US9RQ28xQlRSR1o2SDZMRVcxdEREcmdjc3pLTnVWY0YwS2hSNytENDFhU0hi?=
 =?utf-8?B?VnY3dnIxUU1DeXE3Wi8yQzZXQ0k1c0taMXlNYjRQU3k0QUlCbE9yZXhoRVRm?=
 =?utf-8?B?alV1ZEpmRDdxdlA3THcweUdUdnZobXB1aTRISklySkRjVkFGR3k4ZVIwRjUx?=
 =?utf-8?B?bC9sV0lPbnIzYnNXNlBrNUhLRXZkVm90bFMwNDErQTdzU2p6ZTAyRlEwckJt?=
 =?utf-8?B?Yy9nZnBreWxNeUJ5YnpvY2V5ZDFWWDZFaVNHbUVURk50L0JkSXkwL1JBQXp3?=
 =?utf-8?B?bDBiTTV6REgrek9nRnNhMDN3MlJuUnBNYVJJUDNhRVU3TGwxSG9vRWFZZm9s?=
 =?utf-8?B?alZyL3pSc3VhdytqdG1Qejl6bHBzZnRSaVBLQVNtZFRQNitaSWhqaXRtUVYx?=
 =?utf-8?B?VFU0UHFtQWI1K3VITndJcWVtdC8rUGpTTEhPTUY3QnU3M1RmakdQaEVFN240?=
 =?utf-8?B?TCtKRGFXTkVrVjBzaXNVUFVLMEJTM3NjZmVDVGszWDNwSngwRjZCZE9rd3lL?=
 =?utf-8?B?U04xMGRFNlkwb05oS0k4UTNYTzJrRWFDTmlLVXlOVmdvckxkUlRPV1drVjEz?=
 =?utf-8?B?QnJtNGxHeGlCeTI2TXJHOU5zQlVaQTd3WnUrZzdXTzVUTmhDckJjMmthdUs2?=
 =?utf-8?B?c3F5V2xGUUZPTHdoNElLMGxBPT0=?=
X-Microsoft-Antispam-Message-Info: iweBpqnptJyydsMLkuw8VIE+W6L1i3vpsWh0BdVibaOSnN2a0QltggZAeTxkkNESl78Ic/tKmjWD8I2muZiHVdAylqYQ2MvmKjsF5Gxn+BulsWdTILytfbBJtvrTkGHUQfU8imXuEIzuriThKWvG19k2xxhagMtBNCVYCn//EtIZwOdtSS4OTXiU+63QAn9fv/uTWKEC1u87LnCGPTZGLpPafTP91fY62DPhTu71QpX6xfOQymeYDwaUBJ49pKMTomPTxlYpfa4MXi1yzeN1J4WWb5Pp7/6b7JAd0CFPJEwUq9CAKXv2LJvYwEDFhLlQ+1qeEMcK5ZasYD/EKK6Q6vq9slZ198PHIvJHy/z+NrlfRgla7V8TJQ3YlikC9dFvPOJYuA1AIyEhS6JjCOKDqW9iv8PYSURzZP0XVrbX87/OxR5ONv5svcPbFFyTZ+t8
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0701MB1954;6:/O8fORZsREF9mMpaOhwzJFxr3DhDh7mH9da3d/UKqOsNqmUjRt3exopTwz55clbWgJf74llA22/ARwlGm82t7yGKlHBeNEZ57B62FHYgFcM1NrhUCUE0JlmJiqCLhRu3QmgVKEo7mfksVhiHmK4NKiXjtj2dUwxKxzKbizvEGFzx1I2mff6v0rhZ0AC5pY4+wxyUHXHXFrr//4SuhMseEHHYICgKW+dku3ZOYzgrkSlSwNJfHTAe+erd8ZNdvZQ3SxXijuLGVUF9oFrNHpc97TlFxtmv4hijNLkapGJH0rUaegxAV0sY8B1+2gTZwZG/xVdwMMJixXGTY1X9G4DgVxwOWJSxaKoNRm6SVCOq8jeBD98EEg+0ggfyV31t1wqAg6D3YwgtmLa2NWLtAsbqvuVi36CBHRZTzTaRcskzFHO8TqdWvThOaekjcw3wbxjY4PCQpkytwsgpOO5nP9Ietg==;5:D/NOOIwZDncryV178pkaJ5OT228xnhcH/ZvdR6Md+H0aX20e7lWZU/SZS1IIKRyNV/2H/RxDAvsG0aB1prYy6IpG2Jw2JPHlbfuwXAzU7mGL0TiStEB7u7GAfAm4jn3HHcRFkS7SqjpGGirkT6XYI/lfUVoNvpzIFbI8twwpIGU=;7:NezCR4k/ZM+WElagUAPfvMYJ2nYUiDeh5fRlHYauMEtYEEJxP+ZvKRBr19N832MoaQocn3YjJQeB4O7l4nGm2TBsCr0I0icxJM61m2v9HlPTiy+pZ+Q2KHNjPi3BoKnujZBU1WKYXonL7xKtZb14oXv+d3/y7JusbgkkJMG/USlNDoM5CZa8Sts4yFoJkZevq2gIkAZ5WSHWAqBiSCDzJ4jSUDuZcJ1fV7xUJLsO2zbBB8pzJwRyXcNpGjeE57Bz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2018 14:32:19.4371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb7a4203-b141-4b2f-b6a8-08d5ebf21a31
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0701MB1954
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnd,

On 17/07/18 15:46, Arnd Bergmann wrote:
> While some of the cavium drivers don't require PCI support, most
> others do, as shown by these build failures:

[...]

> This adds back the minimum set of dependencies to get everything to
> build cleanly again, but leaving the ones that build cleanly.
> 
> Fixes: 7e2bc7fb65d5 ("net: cavium: Drop dependency of NET_VENDOR_CAVIUM on PCI")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/cavium/Kconfig | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/cavium/Kconfig b/drivers/net/ethernet/cavium/Kconfig
> index 4c3a5c354497..80e2e93e4aad 100644
> --- a/drivers/net/ethernet/cavium/Kconfig
> +++ b/drivers/net/ethernet/cavium/Kconfig
> @@ -14,7 +14,7 @@ if NET_VENDOR_CAVIUM
>  
>  config THUNDER_NIC_PF
>  	tristate "Thunder Physical function driver"
> -	depends on 64BIT
> +	depends on 64BIT && PCI
>  	select THUNDER_NIC_BGX
>  	---help---
>  	  This driver supports Thunder's NIC physical function.
> @@ -27,7 +27,7 @@ config THUNDER_NIC_PF
>  config THUNDER_NIC_VF
>  	tristate "Thunder Virtual function driver"
>  	imply CAVIUM_PTP
> -	depends on 64BIT
> +	depends on 64BIT && PCI
>  	---help---
>  	  This driver supports Thunder's NIC virtual function
>  
> @@ -35,7 +35,7 @@ config	THUNDER_NIC_BGX
>  	tristate "Thunder MAC interface driver (BGX)"
>  	depends on 64BIT
>  	select PHYLIB
> -	select MDIO_THUNDER
> +	select MDIO_THUNDER if PCI
>  	select THUNDER_NIC_RGX
>  	---help---
>  	  This driver supports programming and controlling of MAC

I believe this hunk should look exactly as the previous one, i.e. 64BIT && PCI,
BGX itself depends on PCI as well. I've actually sent v2 to fix the above, but
got no reply on it up to now...

-- 
Best regards,
Alexander Sverdlin.
