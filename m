Return-Path: <Christian.Koenig@amd.com>
X-Google-Smtp-Source: AIpwx4/FGSBL9LWbzHNsN3r55B3WmQIlPoh+GKgZEEQ9GnhTeR9yo8Bdny3UaT0BtTF2SBFW5rZP
ARC-Seal: i=1; a=rsa-sha256; t=1523980369; cv=none;
        d=google.com; s=arc-20160816;
        b=x+TO6Kzxy5HBOfEgdFK7c42VAsx/RO3ttmB6AIBOXUN/AMx30zWtDBQcnqwFp0QbMq
         xdyTltpMZjkHjWG+HaWf32uOcmqbNWkUrSJdT0z4S4vKuuFjQe6HG3+ioEAttyMalOdU
         8+oputzR95kACf7TwUwPCGbBsaYQX2bVvyd/V3ZSo2yTxeztWGbW2ZobyUmpEJq1ua5x
         opmLTzkKHjWYzGi7UQ3ZxIVJKEtdZSDbVtb2rFXXr4hqxtYJLwPt1+SUnWyVgxkMxzMc
         i9VzexbTijD+LFxpECCUD1sbfdXcWX2RASYeyudGy+3HGR1pXSdg0wf/63bDjuWEQpwp
         yWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:dkim-signature
         :arc-authentication-results;
        bh=ocJKKT1zdxAVbhhK127J9dzSmn6S63asiSAg68zQNH0=;
        b=dGT2RAkKlT9kSdrjxNhalpNtN3kruJknCShoCa4kLXWN/uUWSifFjVhS2NEbBjp8Tw
         e/w1HJl2foQQ2R6tCn3T8dHyvmmkRbkyPpneSx88GGjf5XQWg5V5N5wmYBnTIRWqWbis
         ZrHfj47Kd0pA966xScEXxtUnZ1XdJNBJvIE0rVeIUzSsDTe3dTNXiphYWY/IZPAgkd+7
         ueHseg61WGwbpNhfPYmGQOG6tmIwgvQEy/8Vk6aCCbk7VL8Nvy/kRNo23ZQvcZX6Jtj+
         ow0y68rBr0jbGPyUQfNdbMUvMHWKfCqvabtQdvD3C7FpQiBPTUHy4rhuY3lqWybh9LtZ
         dEkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=zrhcqo6D;
       spf=neutral (google.com: 104.47.34.40 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=zrhcqo6D;
       spf=neutral (google.com: 104.47.34.40 is neither permitted nor denied by best guess record for domain of christian.koenig@amd.com) smtp.mailfrom=Christian.Koenig@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 6/8] drm/amdgpu: use firmware_request_nowarn to load
 firmware
To: Andres Rodriguez <andresx7@gmail.com>, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 kvalo@codeaurora.org, arend.vanspriel@broadcom.com
References: <20180416222427.29683-1-andresx7@gmail.com>
 <20180416222427.29683-7-andresx7@gmail.com>
 <2c27b97a-5cb7-92c3-d4d8-a9d274a2f1cf@amd.com>
 <c5980ac2-2b7c-2a4c-d0c2-5eab0ff01a5d@gmail.com>
 <459ec1e2-bb64-c5c5-75c0-47f443b35cc6@amd.com>
 <01911e9a-36f6-5fee-41d0-2eb5fc187ec1@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <afa5b25d-11c6-94ba-81ec-ecb33af8c79e@amd.com>
Date: Tue, 17 Apr 2018 17:52:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <01911e9a-36f6-5fee-41d0-2eb5fc187ec1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: VI1PR0501CA0012.eurprd05.prod.outlook.com
 (2603:10a6:800:92::22) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:iWRCpan5fXv0bN3h9xEGVEGbt72lvq2CAbG+q1vZ46Uz4OEI/s+AFH94QnatqmlWDzFLsfO4pYs4R5LJnaOE5o7S/VXiSPEeAcaZKQRYyOrgMpNWpBmtnbe6e6USpDPQtmTVKaCTBome29K8VZQ8D730SJPqeNQBhjw+lKdx+8UxiY/GQawqhyDxkNQHmjbh4GO3Lg9WV/3gn3FRA75D35WmWsbLuTB5TN4Qga2E+3s8DONLTw3T5nPNRWRwtLr/;25:Xa7UdRE6THJIuZ8WB4dzRDoDv5uK1AG8Ysy4N9HVy2TK+M2WKdVBtBmQcwb8qouYDeRl1eAqDxLrur7KRe6pgp7V2hk7flmoB4sFHGBBf/eboML0PVx2VUuuthp4o3v7V8r8L0FrqrIOg3OnqRNIibqc8RndEUPsmaqQ2gKCTvd7sx2pafeunFbGtOvAkzbMAIgH4jtN+44WBlNvoAjJjz9hIXHXpFLrO1mgZiJzkwa3ZhAdujK2XXws+C8+oDLr1t2hDfp1U+SRkTVqEf8HAPuydZLxVQyKcXfFYmBRcWzpPIKb6UebnvK4oLdZhAVCwVQ9XUY3drkrnwosfpOCcg==;31:gyif6r1sSrRCJLq3kZL6ET6UCv+wv8KalHbqHZNNMoOq/edZvXKFK3On/cQ3/zUrPHNRF2lpVysttmp9v3GdE/LZVf7rhVKloFJ17s/0Ztybm6rSviWybTdXg6s7grxmdm50XePoQ7UcWrlS87I7Cy4y99fQ+uJng3Cpcx+rNRUQUXy0t/xC07ivZZmVbkbNTcOa6CDzfIPUbiD53OkgTsmnHuXpU17x6W9WLsUnZCc=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:30MY7sG0ppk39JNwNvuSZZ2hDidYTAk/0AJkU/hieOzOafPqYZjknZIjWwdNeW2o2Pioc20w3d3W6vJIufiTSOpMD7DjLMWFP89AdYicptZDftkWwv7ebmcirnxym4fLKDL7Eq+NQDIWg8xi98j3LFzxlpidVZAVTukAhwlo2thIjU2z+HeSXVqHwesAb7gv8UNXs7sU1VECQq+mN97PXJbRURS4hnh9/KlKxrG+chR7FII2o+Pl3HanWnoIuksSH4cPlh/Kb+oYXRwRd+6MxzB8qrHS0HRIuHjDm9+uXJjhRxFQjSd6c+6yq7r+UuoErsqmSSUIIqYOX/w8SoWYJxvCEsbdGdu6tNME/uEVhc2yh5fDU1OVtexzd0GskaKsUDsEudtRE+E6vz4cFYL/X3Z+6/tFSEqEnKZKYwXJRImUw/dCZXGHRvBRQ1F0qhfH0lvqgVJ90NG921g6/T/9SgUSlY+wT/i8ONp5XkVs14ktAMaHfbUeHFEir+zUIGmd;4:KEnwQYYnt8dlJn4KDa2LTsP4Hy6vvxp6JwYGX6Vvy8woBS7hMcVC/6cBsm7+Sql3yxsBDM9Fe/Hq7+4hyRyKgZgIPvorr9DbN4OwfyfWUVKte5VND3XQsy+8phVSShnAHE5W3OTJnFPXDgAFNGoBxAfgixKZ2ZXPeZewhZSHOP3NrVIDPJZVIOnBi86yq7/yB0sgizOxnjlRf9dnzd3ujV8/GNKt3zwGLPYDz4Q6Tr+T/6X5aFZotRTxEJD56BL1KEYvSPKtO9YmXzAwfLiVd/2rMa1awefiST84I1LWZ3Y2AovzZDf4l8BA9GLEOl63
X-Microsoft-Antispam-PRVS: <BN6PR12MB171499C3C8C7F0E5CA261DDF83B70@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(366004)(376002)(39380400002)(199004)(189003)(377424004)(76176011)(65806001)(31686004)(36756003)(6666003)(105586002)(52116002)(5660300001)(93886005)(386003)(68736007)(6116002)(478600001)(53546011)(25786009)(59450400001)(65826007)(2870700001)(47776003)(106356001)(1706002)(7736002)(305945005)(4326008)(2906002)(6486002)(65956001)(229853002)(72206003)(52146003)(52396003)(2486003)(23676004)(67846002)(31696002)(6246003)(575784001)(186003)(50466002)(16526019)(486006)(316002)(8936002)(86362001)(58126008)(39060400002)(8676002)(53946003)(2616005)(46003)(81166006)(53936002)(81156014)(476003)(97736004)(446003)(11346002)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOnhnRVZmVFE0aGJPS1dxeEhQK1FsS2hjbnFL?=
 =?utf-8?B?SHJ0dEJvVktITEo1bDNRSHRkUXhmWHBWUy8xQ2pwZlFCVmpTU2NTMFo4aUxJ?=
 =?utf-8?B?UzBQNGxJbG9PbjVWSHJBMk03M1I5cFZKSGxKNGl2OWNSd2wvbm5iK1RGc3J3?=
 =?utf-8?B?cERYa29mYW05VlVqNXA4U2hzYnNtaUJsekFuM1JFVWdiaTdVT0ZFeTRKRkxk?=
 =?utf-8?B?K1RmUURJU2lSZkVJNTl0NlRRc05rUE1QNW0xYlZCWld5bFA0ek1SWlNEeVBD?=
 =?utf-8?B?NFF3eXdFdXNuVEpEcmNhZHFrRm8yOGRMYmxGcEcxUzZxbFBVb1ZTa0MzcGRp?=
 =?utf-8?B?bHQ1VzlFSXpSUDk3djhhV3JlWElmSDJQUVlGQ2xtVHFiQjNUaXVhT2prNUdt?=
 =?utf-8?B?ZWozekMyUVZwNUJLOEVmdmVGMFVDc3NHa2FOL2Y4RjI5QWhHKzBqdTFNN3VU?=
 =?utf-8?B?ZWc5QTdTZzgyZDdHS1NqNms3TWZac1B4dDdPWG9lWlZ5dWFFWkxpeWhZWTB5?=
 =?utf-8?B?K01QOUthdFlHcG5pS0IzVkZoRTFtSmN1cjNkd3VFSm9ZNk03dXF1SEhiMndG?=
 =?utf-8?B?bCtwZHFrc1FFUDdNaXVsWTA2Y09sTkJLdUFiaUUvQ1BFYUM4cFAyWE93NTlo?=
 =?utf-8?B?clRZVHZaY1l5b1BZeGNUNTViU1N0RGFDcEI3bVBOdkQwcC93cUpaTWxqdWdS?=
 =?utf-8?B?WXBUNXNIVDZGa3U0VFBsWXVRYnlJNHRTdnhhaDF3aVhXVWJYcUtmZ3h0OG1J?=
 =?utf-8?B?K1g2KzByYUNjOXp3R0JqMDJQUDNmU0lSWHFOL3NFVXZmRENrYVVtblpMdm1R?=
 =?utf-8?B?K3kvNktHNGxMLzBHM0htdnY4SGlLQTlJRmtaaXpIZDJmQUVlS0RqRFJDbDlO?=
 =?utf-8?B?UE9BQnpHSkVwekQxT0d0dWl6aDluTXJ6dEQ0eUxQckg3K1pnQTUydCtkbUg0?=
 =?utf-8?B?enRHVXlzb0MvNmlseUt5c3F0bGNVdmJySkpxSGNSUmM1RTU5c25nbDh5VXpK?=
 =?utf-8?B?VFl5MDhCSWJ2OWZ5SGRFUHV0Z0VzWmd1bXZ6MjZDdXIvNnZuMVhJRUl2emw2?=
 =?utf-8?B?SUZISXQxeVBuYmpvVzJmNm1Vd2Z1MFBSWFExY3h5U3RzUjVxRVVYYmNPUWZp?=
 =?utf-8?B?RXFNbmwvclo0bGVPd1hsWVpHa3lVenU1VnMzMkJUc21UZjh2ajVoUkc1YVhW?=
 =?utf-8?B?RzlXREozYTViNkFmK2VUc2ZkNG5nLzdCb1dXNjdpSElRUUMxV1hiWDl2RnBW?=
 =?utf-8?B?QWR2MmVFRmFLYWdlRUNMR3F0WGo3VG9mV1IxRE5QZ0xGOWU1b2ozdVZDblkz?=
 =?utf-8?B?WWJIL01HWDg2QkhyQ1R2MUVUMlMxS3FjVitBbUZLQjU0VWV4OEpsdEJMcWtO?=
 =?utf-8?B?MFVXbzFKalBCdXhjNDB4a1QzTGRRL1ZjQ21vdEtGNUs4K1FrY05WbHZHazFy?=
 =?utf-8?B?NVJ3M2xmUXd1bjZkbXdPbkNKQiswcFFnNHZZVGR3NmhVRUdhb25FSzBwbDhr?=
 =?utf-8?B?cytrUGsxQmtKanJNbkNXZjAyRGVpSnArVDVlS2dLMHBENHE0UnJudURjNnFh?=
 =?utf-8?B?Nng1TkhzZTMwZGlUa2QyMXpWZ2VMY1hPUDlmekhlNVZyQlFrVkpFaU1HcytY?=
 =?utf-8?B?b2Fndjk4UlMwMGpVV2VKZWFrSXhKSDQ4NFRlcEFzTjJnN3lyUStrQlJLTU5s?=
 =?utf-8?B?VWFkbXdwdDY4QlZXUGh3bEhZQmNyblNJV1hzY0p0Q3VUd0tiQ29jcXIxLy9h?=
 =?utf-8?B?Y2xsYU0yajNvTk41UVhNNVlOaXJwNDB3R0ZleVBWU2kvSXhTeVgwb2JBbFRQ?=
 =?utf-8?B?VlRhZTIvM1c1MUdmeEZpckVkemFRNVJjTjI2QW42VUM5WHZkQjFMcEF0Y0NG?=
 =?utf-8?B?ODRkN0dYZ29WVEVDOGVta1ZCSG9xL2JUUCttTEJXVUpvbUR5QVFLcXJ0MWNu?=
 =?utf-8?B?R3l3MFFaRDhYUXBUaU9kMTI5cDYra2lnY2lGckhMbUNuc0lUMGNoZzNHU09C?=
 =?utf-8?B?UjNTNXlJUW5SQUlFcGRudFpoYXEwRUs1V0VETlZHMGlZT1VzOXRvU1RYSXN3?=
 =?utf-8?Q?wQ5Y=3D?=
X-Microsoft-Antispam-Message-Info: XFrX2w/2tfDsawjh5wz36FupLCrNmpxPkPGxh3IgSvzZzQskmKQNmP2DC8PDxZpDhRML2RnDnthP5FiPPtGRm+guAnG66h0HEr4oQF1fLRksCGk7nW90Zr9eQDXli3dV/agVx6+Yze5p08QsjC52gH+yPOP1vt23/irmKmqNst6b96O2BSEmnfBfpx37/WId
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:oTTWioTxF7mGRh+qOOkkOLfO4hxuABzxNNCBzpB3e9Yc3I8sxSsq9YoK0/2QJqoRkEJg5KcFUPgg2dVL7M7jiGeXCoF1eSk0F9N9vIyvKyNAQpuHPK61OhU6YQMX83OmnE3g+ZcrKh20FS7qDP3/E+JgzQQKNhltcfbUNRk3sZACz0+eHSAx1C/YBi3352Mh3TsShe98nCHN8y4d71VzhlB9V/EUEo6Z3Ii+SxyHVfPDvEsOLf3btaB/iRFGvFBl4BRNikb3v0hmcEAZoFuzN9d4AovNc0y3AfH6K/dsBmx/UKgQLsPk2wR+aqoQIC1Zs2fMWXn2gFAGSnhNY2iNsF2f86AlSg4WzKDG500/VDnvBkUzhiHD4aPJBdNHt6DKaARHkdDQuvsPTGLl37b98A8tsQRvZ6Bl8gS84p/PVzq+VcgLfVEPmvpzHpmx3Qug+9nKa73sxlIkFH9NuQfNAA==;5:bigNl11WWjpAY7TDAVpi5ho9iXIRjLwdnxCIHjwYAG6kvJ+o5l1z69vd4YQxm1eAMPJvYX85YabvbXK2R1gfhHqXf0MMcTQ4oPcnzuP13rJVFUnoTLSU3/Y3vrA4BzsjWGFaSrBiYE1B7IMf48rovebypptzOO8xSkST4nkATQE=;24:w9PChA98fzqZbqCfgL1JqZHPE3U6aJZNxF56y9Hy76BJ3Zy0KXzl/wZ1FSwTekgnWIWqNO0lUt+7+5CNwayDl6rtxP9VVjxhFnE0IVX/FFs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:YnC49du9+g44zohiaVBDptb4Jq5RCEEBsupb7Wm3D/PW8zDsZQHy4lJ8uqLRFQxg3zv88nB/iC3rwSH6CClnNobo5XmGwQCgJmgapJ6HW0bSRrF2KoYwzu6sGjtcwSvlHe1LlemBwc6IZohhCx4ONA2Ufod7vtgQKE32SI8mVh9zf5Bgt8Y3pwPkHyT/wnD52urtiw8NwUCTNbOgRgsc8zW+xrm/OSS5EnChf5N+N07/2/EuCmZPpdj1Lp9kFkGR;20:8h/1cYDF6G/sbTlkuzkTUfVvl2YFwjttv9rFeKn+ueN3nJFf0ejiKf+yhqxKOx/N+tKpnNRAxPR5YQoSvzcKogDVjeFJa7eE4a9iRT/DSzqIA0YcLExi6HBWyvnGIXDZs3Wxa3zfesDolZbwMZ2FAD2sZz4dvJT+8ntOQkYYfqdFolsWf6egvhShDIv9VEGkFqd/ag9lbuljBpSmjT9A+oJMhM9VYJ6qvTvrZ75olRvkdRWXf+OJy6GojV6ZgiIn
X-MS-Office365-Filtering-Correlation-Id: 9aefbd97-23b9-404d-bcf6-08d5a47b43f2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 15:52:45.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aefbd97-23b9-404d-bcf6-08d5a47b43f2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597943307609478014?=
X-GMAIL-MSGID: =?utf-8?q?1598009240023358250?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am 17.04.2018 um 17:41 schrieb Andres Rodriguez:
>
>
> On 2018-04-17 11:33 AM, Christian König wrote:
>> Am 17.04.2018 um 17:07 schrieb Andres Rodriguez:
>>>
>>>
>>> On 2018-04-17 04:48 AM, Christian König wrote:
>>>> Well this is a rather big NAK for this patch.
>>>>
>>>> Only a small fraction of the firmware files amdgpu uses are 
>>>> actually optional (the ones with the *_2.bin name). All other files 
>>>> are mandatory for correct driver operation.
>>>>
>>>> There is a fallback when actually no firmware files at all are 
>>>> found, in this case we at least try to get a picture on the screen 
>>>> so that the user gets a hint on what is wrong. But this path isn't 
>>>> tested well and breaks from time to time.
>>>>
>>>> So when you get a message like "Direct firmware load for * failed 
>>>> with error -2" even if it's one of the "*_2.bin" files that is a 
>>>> clear hint that you should update your firmware package.
>>>
>>> The amdgpu driver already provides clear messages when a required 
>>> firmware file is not found. After request_firmware() returns an 
>>> error, we will print:
>>> "{ip_name}: Failed to load firmware {fw_name}"
>>>
>>> When the firmware is optional, we won't print that message, and 
>>> handle the firmware load in an appropriate way (re-use _1 firmware 
>>> for_2 etc.)
>>>
>>> Note that we care about informing the user *only* if the firmware 
>>> was not found. If the firmware ends up coming from the fallback 
>>> loader, but we do receive it, then we don't really care.
>>
>> And that is exactly what I disagree on. Even when we used the 
>> fallback there should definitely be an error message that the real 
>> firmware wasn't found
>
> The request_firmware() fallback does fetch the real firmware. Why 
> should a user configuration knob produce an error message if the 
> behaviour is valid?

Because the behavior isn't valid.

We ran the fallback path which is not optimal and the user should 
consider installing the missing firmware. There definitely should be a 
message about that.

I agree that it's also a good idea to note that we hit the fallback and 
not only that the firmware was missing, but that is a different issue.

Additional to that it isn't the job of the driver to print messages 
about missing firmware, so the extra message about that should be removed.

Regards,
Christian.

>
> Regards,
> Andres
>
>
>>
>> We should probably add a message that the fallback is used and remove 
>> the error message that the firmware couldn't be loaded.
>>
>> Regards,
>> Christian.
>>
>>>
>>> This is specially important since we don't print a success message 
>>> on firmware load. So if we hit the fallback loader, the user will 
>>> see a warning followed by silence, so it could cause confusion on 
>>> whether the firmware load succeed or not.
>>>
>>> These are my 2c in the matter.
>>>
>>> Regards,
>>> Andres
>>>
>>>
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>> Am 17.04.2018 um 00:24 schrieb Andres Rodriguez:
>>>>> Currently, during the normal boot process the amdgpu driver will 
>>>>> produce
>>>>> spew like the following in dmesg:
>>>>> Direct firmware load for amdgpu/polaris10_mec_2.bin failed with 
>>>>> error -2
>>>>>
>>>>> This happens when amdgpu tries to load optional firmware files. So 
>>>>> the
>>>>> error does not affect the startup sequence.
>>>>>
>>>>> This patch switches the amdgpu to use firmware_request_nowarn(), 
>>>>> which
>>>>> will not produce the warnings mentioned above. Hopefully resulting 
>>>>> in a
>>>>> cleaner bootup log.
>>>>>
>>>>> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h  |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c    |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/ci_dpm.c        |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/cik_sdma.c      |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c      |  8 ++++----
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      | 12 +++++------
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      | 32 
>>>>> +++++++++++++++---------------
>>>>>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      | 12 +++++------
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/psp_v10_0.c     |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/psp_v3_1.c      |  4 ++--
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c     |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c     |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c     |  2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/si_dpm.c        |  2 +-
>>>>>   21 files changed, 51 insertions(+), 51 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>>>> index 4466f3535e2d..6c950811c0a5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
>>>>> @@ -811,7 +811,7 @@ static int amdgpu_cgs_get_firmware_info(struct 
>>>>> cgs_device *cgs_device,
>>>>>                   return -EINVAL;
>>>>>               }
>>>>> -            err = request_firmware(&adev->pm.fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->pm.fw, fw_name, 
>>>>> adev->dev);
>>>>>               if (err) {
>>>>>                   DRM_ERROR("Failed to request firmware\n");
>>>>>                   return err;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> index af1b879a9ee9..d6225619e69f 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>> @@ -696,7 +696,7 @@ bool amdgpu_device_need_post(struct 
>>>>> amdgpu_device *adev)
>>>>>           if (adev->asic_type == CHIP_FIJI) {
>>>>>               int err;
>>>>>               uint32_t fw_ver;
>>>>> -            err = request_firmware(&adev->pm.fw, 
>>>>> "amdgpu/fiji_smc.bin", adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->pm.fw, 
>>>>> "amdgpu/fiji_smc.bin", adev->dev);
>>>>>               /* force vPost if error occured */
>>>>>               if (err)
>>>>>                   return true;
>>>>> @@ -1133,7 +1133,7 @@ static int 
>>>>> amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_gpu_info.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->firmware.gpu_info_fw, fw_name, 
>>>>> adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->firmware.gpu_info_fw, 
>>>>> fw_name, adev->dev);
>>>>>       if (err) {
>>>>>           dev_err(adev->dev,
>>>>>               "Failed to load gpu_info firmware \"%s\"\n",
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>>>> index 30b5500dc152..0acd1f3d14c8 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
>>>>> @@ -196,7 +196,7 @@ enum AMDGPU_UCODE_STATUS {
>>>>>   struct amdgpu_firmware_info {
>>>>>       /* ucode ID */
>>>>>       enum AMDGPU_UCODE_ID ucode_id;
>>>>> -    /* request_firmware */
>>>>> +    /* firmware_request */
>>>>>       const struct firmware *fw;
>>>>>       /* starting mc address */
>>>>>       uint64_t mc_addr;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> index b2eae86bf906..4de018d45081 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
>>>>> @@ -171,7 +171,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device 
>>>>> *adev)
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    r = request_firmware(&adev->uvd.fw, fw_name, adev->dev);
>>>>> +    r = firmware_request_nowarn(&adev->uvd.fw, fw_name, adev->dev);
>>>>>       if (r) {
>>>>>           dev_err(adev->dev, "amdgpu_uvd: Can't load firmware 
>>>>> \"%s\"\n",
>>>>>               fw_name);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> index d274ae535530..b6af824a2f44 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
>>>>> @@ -138,7 +138,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device 
>>>>> *adev, unsigned long size)
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    r = request_firmware(&adev->vce.fw, fw_name, adev->dev);
>>>>> +    r = firmware_request_nowarn(&adev->vce.fw, fw_name, adev->dev);
>>>>>       if (r) {
>>>>>           dev_err(adev->dev, "amdgpu_vce: Can't load firmware 
>>>>> \"%s\"\n",
>>>>>               fw_name);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> index 837962118dbc..bd650b87e281 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>> @@ -67,7 +67,7 @@ int amdgpu_vcn_sw_init(struct amdgpu_device *adev)
>>>>>           return -EINVAL;
>>>>>       }
>>>>> -    r = request_firmware(&adev->vcn.fw, fw_name, adev->dev);
>>>>> +    r = firmware_request_nowarn(&adev->vcn.fw, fw_name, adev->dev);
>>>>>       if (r) {
>>>>>           dev_err(adev->dev, "amdgpu_vcn: Can't load firmware 
>>>>> \"%s\"\n",
>>>>>               fw_name);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> index a0943aa8d1d3..95e1edc1311d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/ci_dpm.c
>>>>> @@ -5849,7 +5849,7 @@ static int ci_dpm_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->pm.fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>> index 6e8278e689b1..93c8acca0360 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
>>>>> @@ -135,7 +135,7 @@ static int cik_sdma_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "radeon/%s_sdma.bin", chip_name);
>>>>>           else
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "radeon/%s_sdma1.bin", chip_name);
>>>>> -        err = request_firmware(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>>           if (err)
>>>>>               goto out;
>>>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> index 9870d83b68c1..8aebab5edf15 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>>>>> @@ -335,7 +335,7 @@ static int gfx_v6_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>>>> @@ -346,7 +346,7 @@ static int gfx_v6_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.pfp_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>>>> @@ -357,7 +357,7 @@ static int gfx_v6_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.me_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>>>> @@ -368,7 +368,7 @@ static int gfx_v6_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.ce_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>>> index a066c5eda135..35a0e46464a5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>>>>> @@ -926,7 +926,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_pfp.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>>>> @@ -934,7 +934,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           goto out;
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_me.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>>>> @@ -942,7 +942,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           goto out;
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_ce.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>>>> @@ -950,7 +950,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           goto out;
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.mec_fw);
>>>>> @@ -959,7 +959,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type == CHIP_KAVERI) {
>>>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mec2.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>>>> fw_name, adev->dev);
>>>>>           if (err)
>>>>>               goto out;
>>>>>           err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>>>> @@ -968,7 +968,7 @@ static int gfx_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_rlc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> index 4e694ae9f308..c16cd96a1557 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
>>>>> @@ -936,14 +936,14 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>>>> CHIP_POLARIS12) {
>>>>>           snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_pfp_2.bin", chip_name);
>>>>> -        err = request_firmware(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>>           if (err == -ENOENT) {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_pfp.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.pfp_fw, 
>>>>> fw_name, adev->dev);
>>>>>           }
>>>>>       } else {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>>       }
>>>>>       if (err)
>>>>>           goto out;
>>>>> @@ -956,14 +956,14 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>>>> CHIP_POLARIS12) {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me_2.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>>           if (err == -ENOENT) {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_me.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.me_fw, 
>>>>> fw_name, adev->dev);
>>>>>           }
>>>>>       } else {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>>       }
>>>>>       if (err)
>>>>>           goto out;
>>>>> @@ -977,14 +977,14 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>>>> CHIP_POLARIS12) {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce_2.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>>           if (err == -ENOENT) {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_ce.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.ce_fw, 
>>>>> fw_name, adev->dev);
>>>>>           }
>>>>>       } else {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>>       }
>>>>>       if (err)
>>>>>           goto out;
>>>>> @@ -1007,7 +1007,7 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           adev->virt.chained_ib_support = false;
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>>>> @@ -1057,14 +1057,14 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= 
>>>>> CHIP_POLARIS12) {
>>>>>           snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_mec_2.bin", chip_name);
>>>>> -        err = request_firmware(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>>           if (err == -ENOENT) {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_mec.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.mec_fw, 
>>>>> fw_name, adev->dev);
>>>>>           }
>>>>>       } else {
>>>>>           snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", 
>>>>> chip_name);
>>>>> -        err = request_firmware(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>>       }
>>>>>       if (err)
>>>>>           goto out;
>>>>> @@ -1079,14 +1079,14 @@ static int gfx_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           (adev->asic_type != CHIP_TOPAZ)) {
>>>>>           if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type 
>>>>> <= CHIP_POLARIS12) {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_mec2_2.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>>>> fw_name, adev->dev);
>>>>>               if (err == -ENOENT) {
>>>>>                   snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_mec2.bin", chip_name);
>>>>> -                err = request_firmware(&adev->gfx.mec2_fw, 
>>>>> fw_name, adev->dev);
>>>>> +                err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>>>> fw_name, adev->dev);
>>>>>               }
>>>>>           } else {
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_mec2.bin", chip_name);
>>>>> -            err = request_firmware(&adev->gfx.mec2_fw, fw_name, 
>>>>> adev->dev);
>>>>> +            err = firmware_request_nowarn(&adev->gfx.mec2_fw, 
>>>>> fw_name, adev->dev);
>>>>>           }
>>>>>           if (!err) {
>>>>>               err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> index c06479615e8a..9f70012c81ad 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
>>>>> @@ -370,7 +370,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_pfp.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.pfp_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.pfp_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.pfp_fw);
>>>>> @@ -381,7 +381,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.pfp_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_me.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.me_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.me_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.me_fw);
>>>>> @@ -392,7 +392,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.me_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_ce.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.ce_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.ce_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.ce_fw);
>>>>> @@ -403,7 +403,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       adev->gfx.ce_feature_version = 
>>>>> le32_to_cpu(cp_hdr->ucode_feature_version);
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_rlc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.rlc_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.rlc_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
>>>>> @@ -449,7 +449,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           adev->gfx.rlc.register_restore[i] = le32_to_cpu(tmp[i]);
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.mec_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->gfx.mec_fw);
>>>>> @@ -461,7 +461,7 @@ static int gfx_v9_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mec2.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->gfx.mec2_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->gfx.mec2_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (!err) {
>>>>>           err = amdgpu_ucode_validate(adev->gfx.mec2_fw);
>>>>>           if (err)
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> index 8e28270d1ea9..4192a5a0c444 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
>>>>> @@ -136,7 +136,7 @@ static int gmc_v6_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>           snprintf(fw_name, sizeof(fw_name), "radeon/si58_mc.bin");
>>>>>       else
>>>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> index 86e9d682c59e..06deba7f707d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
>>>>> @@ -151,7 +151,7 @@ static int gmc_v7_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       else
>>>>>           snprintf(fw_name, sizeof(fw_name), "radeon/%s_mc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->mc.fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> index 9a813d834f1a..cbce96198dbc 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>>>> @@ -235,7 +235,7 @@ static int gmc_v8_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->mc.fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->mc.fw, fw_name, adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->mc.fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>>>> index 5a9fe24697f9..718722ef1835 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
>>>>> @@ -105,7 +105,7 @@ int psp_v10_0_init_microcode(struct 
>>>>> psp_context *psp)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>>>> index 19bd1934e63d..dd5261577d9b 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/psp_v3_1.c
>>>>> @@ -111,7 +111,7 @@ int psp_v3_1_init_microcode(struct psp_context 
>>>>> *psp)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_sos.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->psp.sos_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->psp.sos_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>> @@ -131,7 +131,7 @@ int psp_v3_1_init_microcode(struct psp_context 
>>>>> *psp)
>>>>>                   le32_to_cpu(hdr->sos_offset_bytes);
>>>>>       snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_asd.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->psp.asd_fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->psp.asd_fw, fw_name, 
>>>>> adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>> index d4787ad4d346..a2afbaacc7e5 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
>>>>> @@ -146,7 +146,7 @@ static int sdma_v2_4_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma.bin", chip_name);
>>>>>           else
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma1.bin", chip_name);
>>>>> -        err = request_firmware(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>>           if (err)
>>>>>               goto out;
>>>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>> index 521978c40537..75d2a9cc9268 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
>>>>> @@ -298,7 +298,7 @@ static int sdma_v3_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma.bin", chip_name);
>>>>>           else
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma1.bin", chip_name);
>>>>> -        err = request_firmware(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>>           if (err)
>>>>>               goto out;
>>>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> index 91cf95a8c39c..e1ebfb9e2650 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>>>>> @@ -176,7 +176,7 @@ static int sdma_v4_0_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma.bin", chip_name);
>>>>>           else
>>>>>               snprintf(fw_name, sizeof(fw_name), 
>>>>> "amdgpu/%s_sdma1.bin", chip_name);
>>>>> -        err = request_firmware(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>> +        err = firmware_request_nowarn(&adev->sdma.instance[i].fw, 
>>>>> fw_name, adev->dev);
>>>>>           if (err)
>>>>>               goto out;
>>>>>           err = amdgpu_ucode_validate(adev->sdma.instance[i].fw);
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>>>> index ce675a7f179a..5538a5269417 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
>>>>> @@ -7687,7 +7687,7 @@ static int si_dpm_init_microcode(struct 
>>>>> amdgpu_device *adev)
>>>>>       }
>>>>>       snprintf(fw_name, sizeof(fw_name), "radeon/%s_smc.bin", 
>>>>> chip_name);
>>>>> -    err = request_firmware(&adev->pm.fw, fw_name, adev->dev);
>>>>> +    err = firmware_request_nowarn(&adev->pm.fw, fw_name, adev->dev);
>>>>>       if (err)
>>>>>           goto out;
>>>>>       err = amdgpu_ucode_validate(adev->pm.fw);
>>>>
>>
