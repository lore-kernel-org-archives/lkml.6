Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbeDFEqp (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 00:46:45 -0400
Received: from mail-eopbgr30074.outbound.protection.outlook.com ([40.107.3.74]:18256
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751447AbeDFEqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 00:46:44 -0400
To: LKML <linux-kernel@vger.kernel.org>, nicoleotsuka@gmail.com,
        Fabio Estevam <fabio.estevam@nxp.com>, Xiubo.Lee@gmail.com
From: =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Subject: regression, imx6 and sgtl5000 sound problems
Message-ID: <f9a166cb-9584-5553-bb72-35b22a0652d7@nextfour.com>
Date: Fri, 6 Apr 2018 07:46:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [194.157.170.35]
X-ClientProxiedBy: HE1PR0501CA0001.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::11) To HE1PR07MB3340.eurprd07.prod.outlook.com
 (2603:10a6:7:2d::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5602fa95-c5ce-4234-b52e-08d59b79641e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR07MB3340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3340;3:kjIyW198+Ob5uMK8mnNtBVMcHjakQr1Ud2cOmH7lEr1GGbQspsHgJnOyF/8Y5doUroIbM+bt0S7do9zyJ2oE0a4uwNhw9ZyvMM2rWOwdQaK+zzv7olyvMNiybe9FwZzx6gbvf0QfeqEgcLzVKP1pIHexZglbmQYUPyaHgRbrqzGEAdUnU1UeO9MCGpBycnte/czFVjKM0NDycVwwged6D9k3bMq2LJt7yT2mYFJo/FC6TyR7yqZzsYNH7eH2ZEpG;25:Wk80R/K50UYBekCg9K0tarx4eG84fYEXq4IS7ifLcgoEItYdhLK9sOBC5Mo/41omInGTt4nlnm4yiJoDKCqlQo8Tpd5804yRMFT3sZLn8XtvaRfZH2oqBb12JGm1+1SEnhXCAZPXxWCtov82Sz7oq1wACtatDYXAxtxpWFG4IDgPSOyJhV2CgUI1DePS5BclDcVkZKaDTanMUiz7LZd5IOHM3tZeghY4yVN1wEebS4AUXOKq6+6icrM/SwQGjJc4MllfJRoY2mbCIaSh7XFQo75wUFoTrQyKfCMvGZ5Q5G6sRleanmdrVPoflehfOmU+EbblhS1Q0dybLt1wGk39JA==;31:DuDojYf52bq5YXyHEbSfPi+hmAlfm/bzJk3wv9MhtD4t5AbF53K65hNE7II5mFoCyidASj5KXxqi1p1Q4Ntg4xyoefTwfEAqucQCRCwiH8ZQzFcronK7z5KkavXNKqZEp35N/o3W0St6CO5FCUa0OkZUBLyZle23nq1oNFAW2UKmDB+4eAoaIS4DtrprTjj97roe7t6QFHHEq0GMaGolYTyC0444wNJCRyq4kmWhZvQ=
X-MS-TrafficTypeDiagnostic: HE1PR07MB3340:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=mika.penttila@nextfour.com;
X-Microsoft-Antispam-PRVS: <HE1PR07MB33402A61F4298E23EA3EA61683BA0@HE1PR07MB3340.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:HE1PR07MB3340;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB3340;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3340;4:/MUGm2InfXARV0T/ZI+knknLU+EG+xWveQ2YEv3qYkhOP7AZaxX911Pk66ng8Jrr32YXVFis7uY/ZnUV5cYmeHyKTWiVoX4Th1nmSCs5+qGp45UsPZmTGE92PTSWBbhcjm+pcw1oQbQzfwRmlT7XjJng045mslM9Ed5Hm33GqDy6O6ytlTv2/joj5Z1VuB7EcHqY11+oUr6zY1o++iEYlz8b+zJIECSY38GT95ReHQqrajJG5YH/4xMZJ9GFo7VcXA0Eii0hVGYpZHW6AuCB+A==
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(39380400002)(346002)(396003)(39830400003)(376002)(199004)(189003)(31696002)(486006)(558084003)(31686004)(86362001)(8656006)(5660300001)(16576012)(316002)(3846002)(6116002)(110136005)(25786009)(476003)(16526019)(2906002)(65806001)(6486002)(58126008)(65826007)(106356001)(36756003)(2616005)(956004)(478600001)(97736004)(186003)(64126003)(68736007)(81156014)(47776003)(53936002)(26005)(81166006)(50466002)(77096007)(386003)(8676002)(6666003)(230700001)(66066001)(65956001)(39060400002)(7736002)(105586002)(8936002)(52116002)(2486003)(305945005)(23676004)(52146003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR07MB3340;H:[10.10.10.110];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3TUIzMzQwOzIzOmdKSGtUb2dyVDZTV1Vra0lCUmd3WTFJTFVO?=
 =?utf-8?B?ajc0RXF2UkhaWFJuSEZEcGFaVEwwejkvNlFkdzVWM0l2TFhYbmsrZ2NvZzAv?=
 =?utf-8?B?dHNWNW82UlR4SzdGRFcwQjdTODdreXF2REUvZ245VTNaUEZTcGEwbGtZMU4z?=
 =?utf-8?B?WmhwTzlZcU0xK0NRK2JZS3Y0OUJJT3dzaVZHeVlGVGJOM3V6MUllaUNNOUM4?=
 =?utf-8?B?VFhmSEU4Q2hFRmJ3ZDFFUm1mQWVMd21SZ0VYUFpDSkRCTGFTemo1R3VvdmZu?=
 =?utf-8?B?VGlSVGxjNkwwemwvS1lZU3RtdExSb0s2ajcwamhOUG5oanJ0ajVLVS9iUWVS?=
 =?utf-8?B?TjBYSXF5OGpZOEsyekhGSmxWUTVmdVR6RC9lME1DR1R1OE0zblR5SENQSHBu?=
 =?utf-8?B?cENJL0RiaWNIaXdwVENrRGJ3cnRJOHV6eDZWdENOVjhGNGFzZzU2MHFTYU9y?=
 =?utf-8?B?OWcrbVFwYXVOMFdRWmhmcnNzQ3psRFZZczhjRzlLdkd3MUtRcThmQTBiRE1w?=
 =?utf-8?B?NkxCTWNvMWc3cUVtT3NLNG42K0ZhbEoyNmRJRjEzeG1vUHpranZyRE1OZkZV?=
 =?utf-8?B?MTh0SjdTelBseXN4Y0tZSnBNT0lYaGlubVc1TENsL1RNOGF0N1dzbms0N01q?=
 =?utf-8?B?S0VRSUVoMW5aNHBNSVRYcE5iZ2dYckVDWHVIcjZOdFFId3pBQ2J2M2pkTDQx?=
 =?utf-8?B?bHVHY0tRUy8vbmFncmxtY25xYjZxR0wyRFN0b2lQejNpNklqeVVmeGZKKzdR?=
 =?utf-8?B?SUp5QlpEdU04QnhCc01KaVhpSENtSU1FSUhWRnZmRkRweDdmMmowVzd4bU9v?=
 =?utf-8?B?WlBEMDRCY2R5eXhyZ1l3MUhka2NaaDVCOUNUd0JqeFcxU1M1VURmTWJtREJP?=
 =?utf-8?B?MEsxV0UxWEg2OHlHSXFlTzdzWVY5NUVTWi9HRndZeUJCdUtqalJ5Z3JXWExn?=
 =?utf-8?B?eERwS1pxdEJuTkpuZkdSSGwwLyt5VEwyK204WXU4clRFMWRNRTBSbUNmNlFv?=
 =?utf-8?B?VEIrZ0hZZ1UxNXpQUHEzcy83cDhoNm5pR0xZcjRaU1AyNER2Qkh2TG9yTDMy?=
 =?utf-8?B?UnJyZWM3RUhyeU5yT1VpZnNORCtJUzliOVlxUXoyV2gwc09rdExUZVJxeHo5?=
 =?utf-8?B?amlla2V6NENhVjYzaE1yOXFyV2V4d3pLVWp0SFhtbUIyVjErcmd2M29kVXpU?=
 =?utf-8?B?T1IvWVNabFNIeXAwSmtHNGY3ajZ6eUU0dVdsWW9lQlNqVENKOFZrNnIrckgv?=
 =?utf-8?B?TFVEU3JvUmZkRk9JZUxIdHhJNmVwYXJoRFAvU3hHSERkbVRMczcwTTlLWUI1?=
 =?utf-8?B?REJsUkh4NWJhRzd2SFZVRDIvRnBjQmsrbUhJVXB5bWVienVBK2dZMFVmTkRT?=
 =?utf-8?B?alZkRGZ5NVVRNVZqT1M5bnI1MGk2WU5OV2N2SmhXVWVqR2hJRkVnUlArZ1ZZ?=
 =?utf-8?B?NVFSY3ZONk41eGtwNzhMZkw5RGlVNEFYRWJQVk5Jd2p6TjRjSkkwS3pOZUpE?=
 =?utf-8?B?b0hpMmFxSmdudVZYdmwyUEp4T3QxQ2EzaElmTEJlWjJVZDUvaWJpbko2RW5X?=
 =?utf-8?B?dWk1ZkpMR2RseUZxQ3ZMTUVuMXFNVVc4eXNZMUx3NVBMYnhjQ3hMMEs1WENw?=
 =?utf-8?B?YUIrWVVrK2VyQmNsV09ZV2hiRHVhQVJnUlRtMUtPT0hKRzdOKzdlNkpJSXpv?=
 =?utf-8?B?WklVR2VmdFIzV0dsUjJXVjd3MTdIQWN1TTFZVlNNK1JzWWVhbkwvSHI1RFJ1?=
 =?utf-8?B?djFGcFMxNXdyd0E5SWJsWUVGWk01T1VhL0dEa1AvbFJJOHFwV09LQWZzQzcy?=
 =?utf-8?B?d0RDbmNlRkoxUGt0YXFGYkZGYW5wQ1VZSE1OTlZhbDBYM0E9PQ==?=
X-Microsoft-Antispam-Message-Info: +csyEnNiSjDZBmWZqLd9Zp1F3SzdhCtQKanonwm4j9bnejU3mKcctcYuubzGN1MmNdgUlAZYyqmTRkCMDiqophJopFwLsCAFNEX/GK+P5dsAQI5XrGfiCgSNPCo0RaSd5l3QpiSvav4/IVBNscFhUDMpLEKbn3mHI52Mp8dmtAKP6k33ovvhVvrV7EXYy4EI
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3340;6:4/r+GINlPt0P/JHs+o0TaOu92MZNPWE62cpZ2FB0JUgQeQ3GEK+24c7zx7vjRCXM6Q/h2wEOFqSI9WTeJPgBXr3GgjuW33ImoTxqSzcpeUQKyauio8KyM4c92/Imzm3qV/ECuNbHR0CgP8d1Z7p2GZ0vjEMZvhom9AUkHiKSRdzDO59oKTKL7aD8+fhqBplvYXF9qm8wSRdVpUxp08aBRfnFmeO4OPUcAWXHcvQqbvO9HEomFGo4eb3V8WIAzr8WfYKC5GbGnM7XEZuDx4sS/QQ0XN3FqewOJQ3kZ7m0w8HqwVHXyd9vhVLO5D7RKEyIC4b5X0dYIj0sfOeDsLCAn+X+RPeXtU+ewJeGG41RTym0aW3jhBgaOYCKWJPmxBFhMqUFq0uYciGd9NW0NkIEfTFx5snKEZgp4oPhGtRP2ZN3SJMaOsQnuchaxQ/Rtw85jeLUf+yoxo1+WVz4U+xjTw==;5:d9Pb7ZAe12HopfC1236LnhYj9+H4C6nzYJpBMRUGNUsGZzdu9me2NltUwP3Djv7KRe7Np91wDIPeqWx0tqn3TSl87aBxrI3Pzis7aXwoe2MvwJ+xX9s7WRHQ1ywZ4YbeEHtJjaPYVH1RpyNCa62H+CD3CzEhCj+HBmYImrVY3Po=;24:EBkIYcZpDWdChrm2zX5F/pyPHE8k/yJHXrNCEAdjxu94iFvfW3kLK0bB1g6W/YoO2MboDAV5lJmUJwoCk/fYXzF8Phf/lT0ED9RciZasH/E=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR07MB3340;7:beFKWWIXwVrs25M55amx0mI1GXmdmMNvngw/wy/AafKzMHF8Lno8qP9s4HWF8LLMYn7U77oFwL6TANbRzePOzejf6+sdcp6FdgFujNAWMrtzANWDg/dajlGbs6/jyJ95B+Uq/zK2SeCqL+SvLx06ZXxKmd6xMNgFQ1jRosuw/B+PUPrL4knOmukIJCsoME13YgB/g/rMpFFRgvfzBsw7WkTtq2rVII0De1eoMBR+CFRoIse86Dls+pNma1hGm9IQ
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 04:46:41.5465 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5602fa95-c5ce-4234-b52e-08d59b79641e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB3340
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With recent merge to pre 4.17-rc, audio stopped workin (or it's hearable but way too slow).
imx6q + sgtl5000 codec.

Maybe some of the soc/fsl changes is causing this.

--Mika
