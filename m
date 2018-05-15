Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZpO76s25CCLAEAh2Sp/9KUteKJ7tOVO8OHoUuGG3BeGo0FEgDrbv8jF/uh4KLRdH377IFPB
ARC-Seal: i=1; a=rsa-sha256; t=1526377797; cv=none;
        d=google.com; s=arc-20160816;
        b=GfMZv2Cg18V9YDYjnoSeZfyp49b0HNmUPNqpqiMEK1szn7iK3BHaKlMDXDl+jGY815
         mXHYsNrunagl/5KfwDitHEQB8jz8aUTqujxhafP7h+AG1oGhjc5+/+AspleLOMJMI2wj
         IZyQkn2nObSnzsBACH41K7O9HKZJSAGOGSXplMyYRLmWnQVdqozCGGZ7g8EXsSvausG9
         2Kmu+i/urqTkTOtSHFyy7ZQf+QX09UNTpmuEEWeO/aOr5y2OcFSNhCqrpctc/4HBEqef
         XBJ5BJ80oiJFtwptm0Am5f3/UgAoABcxmyO0hJLDHxBqjkUhS2gRThR2A0Q26deRyHYR
         nOpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:subject
         :dkim-signature:arc-authentication-results;
        bh=nTc9NSidRuSqyVVV0rOLfJuh1uQ3HEv/TFRe0UHfvlQ=;
        b=MO8iFNHYJ6O/VNqiAXKg/wq4yoL3ge5QDY0l1RvayDnfWTD/Kxf0VrdFrgVOQleZJg
         Bfu5aYrnw4DbFa0X/K+o5v5qb8ka2Abp0Os3UfP8RAF6x8EbR77nsUr71f8EjhJU6omf
         jy4MBeALCgTzAzcvDES4eBrxBQACLPwe1o4WprbYCrunIHg3qHK05dZleZZyPoajenqG
         9+2zSScNWsgAhsi8UdHC6HBQuwaopWPflrilnid4DWcNxhRt89EY1QPmrcQY8y/MBIQ9
         RHXJWEJb9b1RJbo1pO1GLr+07WHwb3xcwUT0l3PfMgVZYilZavS/PyomTcAlyScIXZWA
         JBpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=TC+rZlEv;
       spf=neutral (google.com: 104.47.36.59 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=TC+rZlEv;
       spf=neutral (google.com: 104.47.36.59 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH V2 04/10] ASoC: amd: pte offset related dma driver changes
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Alex Deucher <alexander.deucher@amd.com>, Daniel Kurtz
 <djkurtz@chromium.org>, Akshu Agrawal <akshu.agrawal@amd.com>,
 Guenter Roeck <linux@roeck-us.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
References: <1525754888-14124-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1525754888-14124-4-git-send-email-Vijendar.Mukunda@amd.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <c8d87b3b-6f8e-c125-4a8b-f47a6f920eb8@amd.com>
Date: Tue, 15 May 2018 15:22:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525754888-14124-4-git-send-email-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR01CA0088.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::28)
 To DM2PR12MB0315.namprd12.prod.outlook.com (2a01:111:e400:50d0::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0315;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;3:hPrssATW5fb4hOweVyQPoVcefP4QWrZIIi7d4UdZlNeogRqc0czRpiiDfOG6WyPSVWcf/CSU7s83TsWbDnCBoVF3HUslFGnYPJLcIga6kthas7EVNNtFVm+BTZhs03qFZmF+42NL1uT7G+/lb/nAOGAgbURtdoHdkzhdj+adOZbhoPPn5s+vuO5htQ07pc+XloiNTLUSstoWO1oW74c9JKB5odmbkrOU4VVj/pp1S3XclL4+OJjyNE0f4qI84DJ3;25:GSNuaHX7r2tZZ4NgKT39jdRFEg5cor71pxnW9KisfMzAZZVIjJ/pESJGly55qX38kZVInlrGo4deKnAQhxCL++K0helZhGajOFqgCIOY1AltaK+3A+iiCJurbboQYdggWxpOg2TSIyZOlL68Ml2sKfv6meFXbHU8T9IspnX6qa4FhHe7Y0+lNSay9CbkNXziOiShYX9DKkxc2flly8qyAxc75NmWumbgpcNX088fvOx8HRcySxBTbkrYWwK+Kzi94b2Aa4S5i42s2gOFFnRLa6pbJcj9dbK1XqUUzGvPzpvxefiPtUXggV/hZDum5CROya9lRSxhY4PnZ2+pOYPVRg==;31:KziUD651LmVr1qcxZlk+VWhOEG293SA/7raromxTcRPRpaKWgcep0uJYkU1MqHWmeVuVczWC6KALOO3/NcTOY1+h9bwgXZyG7fbArgEOSC1ArO0kfPWQ94PxAJXZfskdC2wUezSjQEef/7VlfizlxeHH8AN7AbsKAGBGqj+mwoVFFZstYGz1Snig+6fiZK0SAo0NWdyGaIP641r3bFwoh5kVMpCMeurM8ohxPIfcfYs=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0315:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;20:hhx+QsQ8EH/RIQcyeJOGL9549tspGwwlGzRugSCXalLmndNkAnkpwmUXrtbaAikRrp04Qn661j7TmJDORrqq4i+I5E8Z0dlnnTSWvzDdTmN4vcyLralUIsU2PA90IsCI2JO++gtJrXvxzjPJCLH9srOfE8qyP216F3OtheGAF74jmeeKwDc558EyHMKWcVsw+X4Id1yyZD0HqCemWvxNPQu98T+CwIxOR28j6RPoQA/VhiDWMzTyxTA+oSbA6JCSfor58UV/g07sYT1eJDDVbNpAPgeWQ7RWhBzQKDtEAdJ8si4HUN9F3oe7cH+BEdEob9pi3dMlCzvRmyHCs3U9ZYQGmEzErqGxWYhngCJIgbEvyqfxb1/2ikh39jP7Q8H7aU5AylrnaYDLuhnXjihl3AWUIuvloiga/61cDuEeiEylZnzcrm2vod64aPcuerwp4QGj8kd72vltAj3N3uQlQz7YHiIPALIm5prPkR0ra5URxL4VGLy1NL5319onEA3+;4:1l1iXkz7OL8F9/ibZoKHsMXchp4lGtW2s3iTo49swxes6+Gpg3RirD0baWWdUQgAmJdbFepadkYHaBEvP5blKgR8+ge0dZ3W7jOC79eZvCa8kMbAQWNXwcAKLzzN20QEtfyOTdi6dbe73aIS9Fm6pRH03WiEuRaOMTWhkK20U5mO6TcLyBgqaEeLFthQYQjOImpCzMJrpWGnHCV8lpH0KDvlFcCrNTGUgvPgdTeoDlWM6MvholoifMR/JMp7tfKZP1VkIR1yw+LxKRwwBUxOPYWTL4a41sldZXNMG994AQ6EFPWD0Tedaumvgk4h6OQL
X-Microsoft-Antispam-PRVS: <DM2PR12MB0315B50016F36888BA6F309997930@DM2PR12MB0315.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR12MB0315;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0315;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(68736007)(7736002)(476003)(31696002)(956004)(11346002)(446003)(2616005)(6666003)(16576012)(6486002)(72206003)(316002)(54906003)(230700001)(58126008)(486006)(5660300001)(31686004)(86362001)(59246006)(305945005)(478600001)(65826007)(6116002)(3846002)(229853002)(105586002)(106356001)(2906002)(39060400002)(64126003)(25786009)(76176011)(81156014)(81166006)(16526019)(1671002)(77096007)(386003)(186003)(97736004)(66066001)(52146003)(53936002)(67846002)(50466002)(6246003)(2486003)(36756003)(26005)(47776003)(8936002)(65806001)(109986005)(52116002)(65956001)(23676004)(4326008)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0315;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzE1OzIzOkN4SE5NUUJBbUdUN0NhSWNPUGhCbXpwREhQ?=
 =?utf-8?B?OU4wQVFsamNobXlqeWlyR1lRdVhpTUE4eGIxN0MxVzhqSzRHalhlRmoydlBE?=
 =?utf-8?B?QlJXbTBLa2JPYm9HVFdieEs4TDBpNlFaV3diLzZ1WnAvT01jNm94Y2ozNzVN?=
 =?utf-8?B?K010R2MvZ1FqaFY3LzRZZEY1dTZSais4UVlwTDZUME5ESVZOUjF0VzErTjMz?=
 =?utf-8?B?TDB4Q1RGYWhBMVZ0NC9tWUptVU55YU4xbk1MNlJkcG4xSlNWNlEyanpqSks3?=
 =?utf-8?B?S2VTSlJHUkFkYVJocDE2aW84cUtxY0ZrODNuNUZ6aWplMTJCTW85cUFCSkdR?=
 =?utf-8?B?UE5wZk9ISnRkYjFmVmFuSEpPS2QrVXVTM0xGMVoremRURTkyUG0yMTJJR1hX?=
 =?utf-8?B?YWZvTUcvYUFUMVV1dTZ4dFpGVW0zbmE0aTZkYU41WS9NRnFIRUVZZTEvUzhY?=
 =?utf-8?B?cWZ2ZjMwM3dpRmNJRytudU9HWTEyMVlaM2JFY0M5QVFuekRDQVVPRVlrOTU1?=
 =?utf-8?B?MlVYQmFkME1SclVBT3NUbVlqRU9MeXpCbDlnVWtQdTlpLzA1Z0s3UlorVXB6?=
 =?utf-8?B?MG5jc2xZbWJucyt1SzU5aVdVNEhxd2RWQWw5VEFyWVJ5WHVjODlPSUpGUVQ0?=
 =?utf-8?B?b3lIVlJCOGVUYnpxZ0dkcEZibmtmdnRpclJKczRkYi85WHBrbmNMWDhNUXRa?=
 =?utf-8?B?cDc0NTJnZnZ0MnoyRUN3d1NLUHIwNi9pQjM4ckNqQTlDNXdhMXF6aFJwd0wz?=
 =?utf-8?B?eGlTdTRvZTRXTU9JbktERTVxd0gwZllaQkRpdG94cDNneWMwWWVwUlFWYWNZ?=
 =?utf-8?B?Z0o1Qkdmc0lGZjlEbW9CZTdYUDZlbWJHUmg2MXFha1k2b1lDQ1BMODg1b3dq?=
 =?utf-8?B?VThudWZQK210WHJmRG5tZk4zbFc4NU9qVEJ4Rzg2QmNiYzJQNHVEdjdSODZ2?=
 =?utf-8?B?K0pDU1ZJZDlNN1ZPK25LMWsxaXVDWmRIMGpjNGpybGJwVHBiUEJWamNtcFYy?=
 =?utf-8?B?TkgzR3JyQjlBNnRBNmF1c3l4OVZCTmJGMm43d1k4bWhEQWVoaHFFWGJCYmRo?=
 =?utf-8?B?VktVeDZCUUF4b3R5Y1ZaWEkvOSsrdGpVQnVlSlIvTlZkTU1nTGZ6MTFOY3lT?=
 =?utf-8?B?UlJKS1JwU2ZTMEg2Z3ZkRHRReWZTZWRSTXNaZlFUdUp4c21lUEt0K3IrcDYv?=
 =?utf-8?B?TzJaUS91WGROdExRZjJNYSt2aW9jdlJpOWZlUjZydlR1NGJnWFF2MDhjZWps?=
 =?utf-8?B?UVJWWCtYOHNLTkdUcXd0WklhWFY1SlVZUEZwQnI4eGR5azJvN0FTYzlWZUwx?=
 =?utf-8?B?SFBxOFBuMkZRUG5SOHk3WXk1ME1DYzZkMkNUSThsSytaU1FPbHp5aEEwQ0R0?=
 =?utf-8?B?WFNUNTNYaUxLZTFSeTVaU09HRE85QzNpbDlpTlYzbWZDRzlTQWU0QVgxMGFR?=
 =?utf-8?B?SEl3YTJvVjhwb3gzWkJHY0F5RFlPN2xmMklKRUlhZVR4Q0Z2VUlJaGJLbVlC?=
 =?utf-8?B?VG1nK1VtTHBOT1dTOWZRanVXRFo0Y0FWSnF4bjJsUml6UmVLMytiVXIrZWx2?=
 =?utf-8?B?dTQ0TGpCVHc3eHl0OE5RZzdZYWM4bXlZRWxGS3B4bW5uNHFnOUJMellUcFpx?=
 =?utf-8?B?WXlwRGNnOGE2b1pEU2kydGwxNU9zdEdNdXpsaytIUWNPSDZxcGlXZ1NDR3ZH?=
 =?utf-8?B?endvWGlwYkhKeGs3a0tmZWwyNE9NcE9TUVFub2xlZ2pWTXk5ZGM0R2dTWUxB?=
 =?utf-8?B?UHZIZllDdkdpNU4yejVteTgzZ25GdnFUdFNEeExkMVJJcXdoay9SdDdyZHlo?=
 =?utf-8?B?Z1ZWNlR1YjFIQU83UHpCZWErTlJsaEtMRlFCLzhtQzJGSHhleWRxdXkzK1Qv?=
 =?utf-8?B?bU5Tb1BEQnJaMkhzNENmT0krV0ZNZDlldlNkR3prRmJSaWd0V1l4L2pmWHZ6?=
 =?utf-8?B?WkRsK2ZWNlpJZlY5NEt3b08zenNZczRRNTIweGtVWnJwQ0JrSEZCMDQzNVRq?=
 =?utf-8?B?Q0EwV21EeDVHaUxCa2JzVGYwU1IyL2pyZjAvUzVrOXpzYzg3N0QraEE3N21w?=
 =?utf-8?Q?S/OKa17cwHX0ANyf4BfoKQetX?=
X-Microsoft-Antispam-Message-Info: dEdyAiZ3BMAWpzXhLyUxmnDOqFJXkkjx1u0LLSqkOsA0L+ifIkMky2Bml72Yq2Rozxp21qwAr7jGzFi1MwfBUB0lLg+hG7V0Dc5G34OKYYe4x9HBsex+G3Wmthx61B138bVObKSGMspAuKoqz9NLbKguUCaLxIjQ71ISYNfZf+eCfqP3PvNLgmah5hHX29Sr
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;6:AAxnp/LquHkS/X7YVQSyZLF3dfyDfnqOTHzSMo5OMT8n8oyEh7q1+pnHpvQT69kYZQoxSBt9Jc5T2A4mJ9THqub2HQ0ayveCFVT3Lot/Dify/+flujMDDNpuXEiN/Uz5yV7Lq/tnMYqs3FHUIet0NgSkJ2+rqdyjYL/UoQ9pTXr3QCNAYXoDFv5D8BWSGsluxBXI3+5TqcBFbjXbMbXXg8LY9/zne1hmuWDMlIXts2JyjHWBFNBKy8R7sFL96VYa1r/RWhirtD9UVNzd/PKDV2XLG/9u5Hh5Crd9pssSh7XfEDwR+wCG+OSCx1rEFp7Gju+qgFqhhVp0g5aFdaz6ED1Oc7vFqcduaqGwtNFBZ06C5EXzXTxwO/5GyU9Iifa2gPeTmUcgsDgBKJ/tEEtlAvBhk1Etqoymk3MG8XoqdTC/hkEPA1JKhpjptMd0InpNcPaVL1pUhTBcnaAHUkb+xg==;5:hhTifwEZpOeydpvqZnmhlSkuE0lRe1ZOYgJ5EgxRdtCtJPevf3vDq3euPzyqioOLlWOZZBXf9wAMcBe71Vk1HzBcno3PzzrIJIUWAtXJamorm3iAW9WSTT1gEtuZtIBG547jOVF06Anfxp058q+vJMncXmkdzaxTTooiwEHnW+I=;24:ZOc6PpMiWafEk0eYTadP34q+pAw/mZlcYdIiqxTQlHSs9Lt2LFAUTL5MQERK1k5QeVLPX0J5DqpFFn8ngLS+XEqjGuVuP0rrX5wOi41qxxQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;7:jb2n4q47eihjTu4Ha21dK2rXLBjHgEr1ervXuE2vmrOp4reKtrOG+2GF/pa5E/9vDWVrVAg017ra0EzbIJie/ZYjF23wniidGYtUVPpQnTjyMOS9gmLyaqTki9B58DNMppltZMvKgAKpI3ysQXYFAGoHTS5jKQoFfWdifcmlYkER/bdYmrsiQboPUSlEd+up0TsBJJ5OAJ1USdmHFAls/8gRm6rfsLBB4HvRRQBXcwGoriLPGG8G1NZziS9r2sMo;20:1O/oHsRrsJGEzTlxWcj19dDWftXopJug/w3JpDBGY4tqq0e0aarTBCzD7NGMOBXPBkTi6S8s4e/RmSI/hqLwS8aSl4WEww7PVfosDAQ7Td77jUolcjPsZJkDJuT0gYP5CLMY5D2MvmOfVnHRJur9x0c+f8zMna77Ig85koIGd20Bvr/m2HNhhIPi49Sg7JCT0G1FxRGN94nSmx6Tultw3cvpq0KC4C8w/zEU3+UxOq5L1eHgGG8wDLr9vJPzwJH4
X-MS-Office365-Filtering-Correlation-Id: eda57ada-e700-40a0-f29e-08d5ba49353b
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:49:49.7855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eda57ada-e700-40a0-f29e-08d5ba49353b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0315
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599869826856023070?=
X-GMAIL-MSGID: =?utf-8?q?1600523125872291050?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


Hi Mark,

You have merged 1-3 patch series. Still patch no 4 to 10 remaining.
Could you please take them.

Thanks,
Vijendar
On Tuesday 08 May 2018 10:17 AM, Vijendar Mukunda wrote:
> Added pte offset variable in audio_substream_data structure.
> Added Stoney related PTE offset macros in acp header file.
> Modified hw_params callback to assign the pte offset value
> based on asic_type.
> PTE Offset macros used to calculate no of PTE entries
> need to be programmed when memory allocated for audio buffer.
> Depending upon allocated audio buffer size, PTE offset values
> will change.
> Compared to CZ, Stoney has SRAM memory limitation i.e 48k
> It is required to define separate PTE Offset macros for
> Stoney.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> ---
> v1->v2: Modified commit message
>   sound/soc/amd/acp-pcm-dma.c | 26 +++++++++++++++++++-------
>   sound/soc/amd/acp.h         |  5 +++++
>   2 files changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
> index 862c1cf..39597fb 100644
> --- a/sound/soc/amd/acp-pcm-dma.c
> +++ b/sound/soc/amd/acp-pcm-dma.c
> @@ -320,13 +320,11 @@ static void config_acp_dma(void __iomem *acp_mmio,
>   			   struct audio_substream_data *rtd,
>   			   u32 asic_type)
>   {
> -	u32 pte_offset, sram_bank;
> +	u32 sram_bank;
>   
> -	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK) {
> -		pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +	if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>   		sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
> -	} else {
> -		pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +	else {
>   		switch (asic_type) {
>   		case CHIP_STONEY:
>   			sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
> @@ -336,10 +334,10 @@ static void config_acp_dma(void __iomem *acp_mmio,
>   		}
>   	}
>   	acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
> -		       pte_offset);
> +		       rtd->pte_offset);
>   	/* Configure System memory <-> ACP SRAM DMA descriptors */
>   	set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
> -				       rtd->direction, pte_offset,
> +				       rtd->direction, rtd->pte_offset,
>   				       rtd->ch1, sram_bank,
>   				       rtd->dma_dscr_idx_1, asic_type);
>   	/* Configure ACP SRAM <-> I2S DMA descriptors */
> @@ -788,6 +786,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>   	}
>   
>   	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		switch (adata->asic_type) {
> +		case CHIP_STONEY:
> +			rtd->pte_offset = ACP_ST_PLAYBACK_PTE_OFFSET;
> +			break;
> +		default:
> +			rtd->pte_offset = ACP_PLAYBACK_PTE_OFFSET;
> +		}
>   		rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>   		rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>   		rtd->destination = TO_ACP_I2S_1;
> @@ -797,6 +802,13 @@ static int acp_dma_hw_params(struct snd_pcm_substream *substream,
>   				mmACP_I2S_TRANSMIT_BYTE_CNT_HIGH;
>   		rtd->byte_cnt_low_reg_offset = mmACP_I2S_TRANSMIT_BYTE_CNT_LOW;
>   	} else {
> +		switch (adata->asic_type) {
> +		case CHIP_STONEY:
> +			rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
> +			break;
> +		default:
> +			rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
> +		}
>   		rtd->ch1 = ACP_TO_SYSRAM_CH_NUM;
>   		rtd->ch2 = I2S_TO_ACP_DMA_CH_NUM;
>   		rtd->destination = FROM_ACP_I2S_1;
> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
> index 82470bc..2f48d1d 100644
> --- a/sound/soc/amd/acp.h
> +++ b/sound/soc/amd/acp.h
> @@ -10,6 +10,10 @@
>   #define ACP_PLAYBACK_PTE_OFFSET			10
>   #define ACP_CAPTURE_PTE_OFFSET			0
>   
> +/* Playback and Capture Offset for Stoney */
> +#define ACP_ST_PLAYBACK_PTE_OFFSET	0x04
> +#define ACP_ST_CAPTURE_PTE_OFFSET	0x00
> +
>   #define ACP_GARLIC_CNTL_DEFAULT			0x00000FB4
>   #define ACP_ONION_CNTL_DEFAULT			0x00000FB4
>   
> @@ -90,6 +94,7 @@ struct audio_substream_data {
>   	u16 destination;
>   	u16 dma_dscr_idx_1;
>   	u16 dma_dscr_idx_2;
> +	u32 pte_offset;
>   	u32 byte_cnt_high_reg_offset;
>   	u32 byte_cnt_low_reg_offset;
>   	uint64_t size;
> 
