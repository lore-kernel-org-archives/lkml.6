Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576F9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACFB2146D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 02:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZTydS2XA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACFB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbeLFCk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 21:40:56 -0500
Received: from mail-eopbgr700067.outbound.protection.outlook.com ([40.107.70.67]:46880
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727514AbeLFCkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 21:40:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+E+e5y4BOkwBDW572H+tyqySbqZVxuhsWuHZiEThvAY=;
 b=ZTydS2XAwBxgKkavcgJjiPPepv6tiHTw/9KsF1jfOmsTGiU95tG7FbdzUl3qoDFVb4VMxPzjMLHZqtkWhCU0CP+Sd3RE9Ui3RBxYK03xXwKw260rAGH8TMyilh+77PvvTrvBgvkz/64iV8ZX1/fAp63mFmpYgs6VXf21rp5TG7g=
Received: from DM5PR12CA0001.namprd12.prod.outlook.com (2603:10b6:4:1::11) by
 DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 02:40:51 +0000
Received: from BY2NAM03FT026.eop-NAM03.prod.protection.outlook.com
 (2a01:111:f400:7e4a::206) by DM5PR12CA0001.outlook.office365.com
 (2603:10b6:4:1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1404.17 via Frontend
 Transport; Thu, 6 Dec 2018 02:40:51 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=permerror action=none header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXCHOV01.amd.com (165.204.84.17) by
 BY2NAM03FT026.mail.protection.outlook.com (10.152.84.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1404.17 via Frontend Transport; Thu, 6 Dec 2018 02:40:50 +0000
Received: from [10.237.40.91] (10.34.1.3) by SATLEXCHOV01.amd.com
 (10.181.40.71) with Microsoft SMTP Server (TLS) id 14.3.389.1; Wed, 5 Dec
 2018 20:40:49 -0600
Subject: Re: [PATCH 1/2] drm: Only #define DEBUG if CONFIG_DYNAMIC_DEBUG is
 disabled
To:     =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20181205165621.5805-1-michel@daenzer.net>
From:   "Zhang, Jerry(Junwei)" <Jerry.Zhang@amd.com>
Message-ID: <10fca21a-5d7c-fe9e-07f0-6200e9de538e@amd.com>
Date:   Thu, 6 Dec 2018 10:40:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205165621.5805-1-michel@daenzer.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(2980300002)(428003)(199004)(189003)(16576012)(356004)(2616005)(6246003)(50466002)(6666004)(6116002)(65826007)(8936002)(305945005)(3846002)(7736002)(2906002)(2870700001)(446003)(11346002)(31686004)(14444005)(476003)(86362001)(2486003)(31696002)(53936002)(65956001)(65806001)(486006)(66574009)(126002)(68736007)(23676004)(47776003)(77096007)(76176011)(426003)(104016004)(186003)(26005)(53546011)(36756003)(336012)(316002)(16526019)(4326008)(478600001)(81156014)(67846002)(105586002)(81166006)(97736004)(8676002)(72206003)(229853002)(106466001)(64126003)(54906003)(110136005)(58126008)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2636;H:SATLEXCHOV01.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT026;1:DQZ7f0dumA4uMb8L1/bbGXR7mtI2VuT5CY5LFmPIOxxArV8/xCTn6XtCBgXofkiafIvsDk7NoYUBXuDjX6JDysoyEc9qJc9/oEc5eYXeWI0x2I2nJw2xbp5eXmswoeNv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34455a51-7baa-4d43-a6c8-08d65b243c67
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR12MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2636;3:MTl9vvJNfbhnSQ25E/ghOC8RZ107ZahR0QQBxIWuJjUhSFTibJ+B4+82DcgxUOh5e4Mxv+wAdnPVbwY92wcQS1srgdG8wWpUFRd5nYbBoN1D7dEkl/toX8aPOPHX6mMyMJi1/OBmotyVr6T4Bhawhld39sjFl5joEUW+K55bKuktsdRHwGprGQfTrJDl8/Lh/odOZM959y+NkAHVpw8nX9NdtKv8KFSy6rnWxCA/eBq44yMx3Mf0IhqJvToxUITlW++2BGqZIdaadcaz/sy4esA7T/FEA1tkmSjmRg1WEwuS/afYk+4U9tFApizRN9AgPLvzWut9w9knSe/JLTj23gocoG3IG2dApztAfaR8mgg=;25:vShnsmHm+V/UjyRx+5xeWwvh+NlB30wchH2MkTzIdhfdRF1FV1+IuWEDgh3TVdv5Z+cwIPtxvWPTJci5bigB4uQhU2VnJqC31YdoLjRXgVzH5DgTltcPCoxN6Iaq5B8g1v//Ttge5dJ47jqJAUCh9UgljM7Pco2fGUyLOx/tKXUpdNtuCfvZimlM9jRz0n+TLZdTQCmnI3BZ6qbKPjtLZHBYtfEyJTJYFcQNniRpoeKuCbinJuMLxO7hsDaAtj7O2SHkjK66HBlBoY3BPSSusSVRLQCRgvbZnylpctREtXYyy+BsjEg+qw53wwqG3qq3akyOk6fUlojK7E49/FMFhw==
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2636;31:NFbzJ/aSL8EPNtc/cyfX29OZJQI66FRWUmfN9ixiOJt2nho2XEr46ayNNoOTZsiASy33OGpXas1NyGLukBBVlf0HRAwSBCksjd5XMW0+/oMV8nV91LhVx3//jZixU340776NGCB+CDU5IWs5gTIv/XdC5/tIO91Po4qQ2pVF9pVvjlIOcqRBszwwLg+STE3C6IU8Muj9hAd0HXxeOaEHoL+erZzrlTs7QxxwNUPuSyw=;20:uPwWpPpFiJG0C98vQL4qz1ORjdzXso/8And+ZPZUWSi2NBMUDJJCLJcbU1/HbvIW/iLwxoZ5uCtzpNCknGpjooQxGFveqnstMA3Ur7oZhjeVwdbFjEJko6qfDP3K0vEFGxhD2KZM/fr1rvmBdfOCuc0jl86gdwUvAfXbbLbOCIElQ4jeS9AymO8lX7QEqFxHGp8bibB/GEk4LR6cgHrVTbyXsLphF4/HZShN/EdfBBk8M64ZEMqmInb7X6aM3o3nxjjEL6YyYcmvav/gDjHSGoT5WAdmsLFBYqlzt+d2784P7h6nvyz/NvKya/f9HkGE/bFAEqaHRM8ErWI4yPLABD7j+6Zj+5ofAdcFwdSfogD7LbZ1ZTOkvnsoIFgzgDflaD+r+oUsmSwOuPQDrdA//fRhOBl43yMsg4Kn8YnRjtA+Li2/S8i3YvcRgBevRV2P7NoHJVYELuLBWuKRmrzBU8n/I37jA0zCUw/zdQDzgabvoi0TDhyYjIqsv7vOGtne
X-Microsoft-Antispam-PRVS: <DM6PR12MB2636D230C7FD25D1753E9054FFA90@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93003095)(3002001)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:DM6PR12MB2636;BCL:0;PCL:0;RULEID:;SRVR:DM6PR12MB2636;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2636;4:0px4YnyP+ebuN9MPYeeKrPgPmFeCvOcb06VUXGNMuHvmrAIMcb5rvboM88gQ9+S5RNqxV+kTvvb+vgGs9dsOGPM/dHj+vMY4JJcnpWlubOg2jJl4b/mgtRjXqmDZCRwuf+VMMOoRcXLHuRNsGG1y6zpRk0ELehAWlOpAsdnjQnjMAB+sXVf1gq2HGh34lE4a4sRYPa3Xi77yiDl/dhtN2ig5I9iONIc9bC3cbICPEsh8Zfk8TQfQQ5m/gLzm/bZdhnN9zmKpnfZesjmB8yYaKw==
X-Forefront-PRVS: 087894CD3C
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjEyTUIyNjM2OzIzOnIwQ1piZlpsK2N5UGp5RkxrdDgrZlFQKzI1?=
 =?utf-8?B?NmttcXI5TEN6K0tYbURjOVVvREI0aXV6RFNybzZGTWNBU3E5d2VmSnZlSjdk?=
 =?utf-8?B?dUM2enRkTXd1VGdnOVZzdTdXUnJmdytWdG92aDFBSFZXUzdJbGd4NGFnRzJq?=
 =?utf-8?B?Q0FheEx1MVpTUFFMQklPZzhKWGhONmpEZW50R1FuMmRzUmFJZjhPVm1rT2RE?=
 =?utf-8?B?bWFDODQyRGUyMVR5UXBlWUFTcmRJdnFsMUVlYTV4VWZXVjRrR3p3bnN3QUYz?=
 =?utf-8?B?WVE0eFE1OWRMdGFVTkZqMXVRcWlNa0w5Ui9TRDJhWmdZSzQ2L093dkhZdDVG?=
 =?utf-8?B?WEY3VGE5Q2ljZFJPRFBRODY3ejZYbkczN0JlQjdwcFV4L3hmY0FvblNkcEdJ?=
 =?utf-8?B?NFlBcjJzNU9JS1g3MlZMUnUrYmpDUmFpUldFdkkwRmNHaTlEejNCWlZIMkRR?=
 =?utf-8?B?U3hEbkxsb0xPL3ozVDc3cTYwb1R5TWFuWGdUWXdzbmFXQmN0YkFlTFJKSnVU?=
 =?utf-8?B?dWV5MGs2S2hCN0hISm1HclhFc3NvM0ExdWNZT3dobm9GSHA5ZmRKSmNvYkhE?=
 =?utf-8?B?dGZFZXlvaGVRRVNsYWFlVTFXUWtTUVRDV3ZRV2tEaVo3czdISEJGQTZNdmZl?=
 =?utf-8?B?RmtEbzgxRVVvV052THZ0eE9FMFBOcDlia2FCZ1Vwdm9SdEtjbDdQWlA0MVk4?=
 =?utf-8?B?UE1KZ1FBTzJ0VVRlQkMzTVZyQnIyQmtpQ3NDZjFIZjVWMXNBNkdLUFdwNGYw?=
 =?utf-8?B?WkxFUVIxY2tyZ2NrVE5OU3B2Z2FjYnc0VUsvM2krNG1xdHVGbnVZdkpybDg1?=
 =?utf-8?B?bkZCb1gzOU1hMVdWOXdIRUVNYTh6Y3J5REVYTHhLYllhb2lrWVBSRXk4TnBl?=
 =?utf-8?B?cjVaT3VqN1BKRG0wT0c4b3NuczlTdnhPQWxNK2VYc1BjZ0QvMm5helg5UEdT?=
 =?utf-8?B?QktjVjk1Um9SV0h0RUo0cVFTeHJ5cVF6WHlTL0NTc1k1UFBqTElzaUQ0ZnZS?=
 =?utf-8?B?U01yUHAwZmUwbGlqbFRoaDJzc2RpNFpxRW1kTFNQcmdGRTZKWC9jb3Q2cGpX?=
 =?utf-8?B?Zm9FeXcrUE8vSVNkRWEybnZXOURPV29wNDY4TzYzUlF5YjMvVFRGQmdwUjE1?=
 =?utf-8?B?ck5hOWFEVGtIUzFXVkRRR0dGc0hrVVlka1V5dlA5czY3T3ZWS2UvV0hpZjU2?=
 =?utf-8?B?Nis4WTZORFZEV05TWGRLNWJIbmNUcG5rNE1ra045K2RRa2o3UmpubEtNTEwy?=
 =?utf-8?B?Z0lwYTE3a3dZaGxlZFpyV1U1djlad000dyt1N2ZwbTQ0TmZVbmVTUExLQ2JV?=
 =?utf-8?B?MDUxZ0h0ek04R0tMYXRBV0VlZEN5U0ZUd2FKaHZ5bUJ3SThpbS9VMkV5VWtz?=
 =?utf-8?B?aDNBNE1KYjJwb0xCQUI2YUdYZEgrZmdENm9ua0R6UW1KUitKSDl6ZkJ3ZHJR?=
 =?utf-8?B?R3RqMDZ0c0l3ZXMxRnFTeTZiK2phU01SazRDRDhkcmlQbVNSVDRMdEFpRDdB?=
 =?utf-8?B?SHJOZFFHdmswNW1rRzhYQm5Ndk8zTmM2SW5LaCsreTFWVGZaVXNhZStSMUl2?=
 =?utf-8?B?TW9zR0p3K1QzMGkwd2ZzaThIenNGNUdlTmNBZ2FGdVpWZ0RycHIya0tHdXNj?=
 =?utf-8?B?aWZIejJyYUd1dDNWUXE3aHBlMXdtZTZ4bmp1MTVTUkloRmJONnRrdm4xZHNv?=
 =?utf-8?B?UHpPK0hMOEYyVmwwTW9YNSsyY01qRXA5NjIvNG1YNkp0UDY5R1N4UjhNRW9u?=
 =?utf-8?B?aFFmZHM4UnNNMmovQm1Sd09mQmVxbTRPWUlueDZuMDJoK3RhOGRES3VGMVBP?=
 =?utf-8?B?Zk1rckQrZnp4UzROa0pic0hRN2M5Q2g5dCtkNzg2a0d3OS8yUUdhbGVzU3Fz?=
 =?utf-8?B?OU9TbS9sSWV2MUZ6aUN0dXpRc1lSTURhOFZmMHZ4NlJFYmdGc2wvQUtHYnQz?=
 =?utf-8?B?WWc3ZWZKdmhuNlFpVHZXNWNDRmhDek93SUIzR1ArTjNCVmVHMVVXblNJWCtG?=
 =?utf-8?Q?zveSQp?=
X-Microsoft-Antispam-Message-Info: kIYld5LTafEDkNSL3p/2ILCx9GhC9GKKQUdagmWGQcxcmwj82I1icoHLJyXa0UQ0nJVOUWOf9HUbg5o5Qk0IjzMaUOX+SDpL/KTqhme3lomBWB9aD1+5GOPgkcNzQiGLfnGkjVOlsAON8QhNBws0p39FSOaK8tAj20FiAoikmRTIfaDQ3WhGrjAvgVgTRrluGnzThX0l5va6RbBQIilSgVXkOmPjL3z692+iEhlZKydB5KaG59yTrjWQER3ChZD1YQae7c4AzZTAuTpNhFBH/vM4WT0P7IA5Y4olb/EXeZUtGisdQBtXte8e+2TimsqrmbIB+nRR1+EpkVu1H8ND8gXs5nlWKsaf8KqpTGr8ATc=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2636;6:iD4BbvIGOkXbQ9B1JbM7eSWehfQKq+VGC7qzbg6fyyKyxQvNOUSDDDWkUfEYe720Q+giDXKzoTiClezKEYPNmz/aWV2dCrd5xVvjyGCsjqeb9LQmhQ+KcCObCweBcyLX2uKtKr5krn6f+RoPDYyWtsQYMdn4AcWk2RQrlhSihPWQ/Fe7ZIgplcV4B60lvK6G0c/js9wDhE2xJFp+sgskMOXnPM1MdnGMqsPCyAmEHYK+Zz6zYdUR5YIHmSphvjrbTSbkKcEb4Fgw0gcrg2zYJPCGD21krpr8evGDbRDwAMHY0b/hMb/V6PV6JrfGfHJ0hCdA5DJch1LGpEj8SqLv4hOAp62qRccRNkmzfFA3DvOFFvPK0eq7/497x/taLZh6J9e2eXNqfabhZu7gcq1sMgyMnKhog4eWl2QTBkmfEm6bI34RjxWjVGP5LrewLMTsyM3g3iT8wFaMgJRBJttGRw==;5:0EvRwuL3P77ifAvL69LcqdVFhTpPcNqvAcjXs0uLPGQdISQMvQYCGKrRTrf1078p8hYswksW/BZno1WXLIMfKSEC6EmJmQj//fyPilHagnMGTVsxE+YC0gR5s29NmhHxpmxHzrsX3xW4Uah48PUPiTIdkxhhRWcLr2Ww55JoShA=;7:v2xky/bz3OAjMeak+j5hV5Oye00Azb8oarQW9n4htc+WLiEHloeHLruTquuNDa2naq/I3o6EowdhPKL7yiEdKAcUXkBkRvhjMSeRyxjMKWzb+tCO9ktCvdoKvlUiblubK6Rbq3c8cc6qGSXNorHCtA==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR12MB2636;20:Klywprw92aUHrlMbM1NSpdN7vGr4pAsgua5tDx+DOlC5KHsHKu5w3pk1AUvj2kH+XkHt+O8kTPSt22lABCoCknU0i2ZSPnWbCNs17s+R/Y16PqGzQb7yrmiEC/wABy0ITy4DOe788SnAlUcvJZfxUH6fFhJhQLjAHs+/NPL5VMGV+06BEkIwnbM2a00UCwjjgly0GfFx8qwI31PxT3ODnhbyc58igHKpq7gKXnj4m1znDAhtORnafXJNOdojyo9P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2018 02:40:50.8004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34455a51-7baa-4d43-a6c8-08d65b243c67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/18 12:56 AM, Michel Dänzer wrote:
> From: Michel Dänzer <michel.daenzer@amd.com>
>
> The following cases are possible for pr_debug():
>
> 1. CONFIG_DYNAMIC_DEBUG disabled
>     a) DEBUG not defined: pr_debug() translates to no_printk(...), i.e.
>        it never generates any output.
>     b) DEBUG defined: pr_debug() translates to printk(KERN_DEBUG ...),
>        i.e. it generates output which doesn't appear in dmesg by default,
>        can be enabled dynamically.
>
> 2. CONFIG_DYNAMIC_DEBUG enabled: pr_debug() translates to
>     dynamic_pr_debug()
>     a) DEBUG not defined: dynamic_pr_debug() generates no output by
>        default, can be enabled dynamically.
>     b) DEBUG defined: dynamic_pr_debug() generates output by default,
>        can be disabled dynamically.
>
> The intention for drm_debug_printer() is to generate output which
> doesn't appear in dmesg by default, but can be enabled dynamically, i.e.
> cases 1b) and 2a). However, defining DEBUG unconditionally gave us 2b)
> instead of 2a) with CONFIG_DYNAMIC_DEBUG enabled.
>
> Fixes: 79a5ad2fdb3c ("drm: Enable pr_debug() for drm_printer")
> Signed-off-by: Michel Dänzer <michel.daenzer@amd.com>
Reviewed-by: Junwei Zhang <Jerry.Zhang@amd.com>

> ---
>   drivers/gpu/drm/drm_print.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
> index 0e7fc3e7dfb4..ee56e4a1b343 100644
> --- a/drivers/gpu/drm/drm_print.c
> +++ b/drivers/gpu/drm/drm_print.c
> @@ -23,11 +23,13 @@
>    * Rob Clark <robdclark@gmail.com>
>    */
>   
> -#define DEBUG /* for pr_debug() */
> -
>   #include <stdarg.h>
>   #include <linux/seq_file.h>
>   #include <drm/drmP.h>
> +
> +#ifndef CONFIG_DYNAMIC_DEBUG
> +#define DEBUG /* for pr_debug() */
> +#endif
>   #include <drm/drm_print.h>
>   
>   void __drm_puts_coredump(struct drm_printer *p, const char *str)

