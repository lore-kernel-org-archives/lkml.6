Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932364AbeBUL1t (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 06:27:49 -0500
Received: from mail-he1eur01on0047.outbound.protection.outlook.com ([104.47.0.47]:13088
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753175AbeBUL1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 06:27:47 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=tariqt@mellanox.com;
Subject: Re: WARNING and PANIC in irq_matrix_free
To: Thomas Gleixner <tglx@linutronix.de>,
        Tariq Toukan <tariqt@mellanox.com>
Cc: linux-kernel@vger.kernel.org, Maor Gottlieb <maorg@mellanox.com>
References: <e2ec1a14-326a-57c2-56a6-7c2235e5b8b3@mellanox.com>
 <alpine.DEB.2.21.1802201829180.24268@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1802201917200.24268@nanos.tec.linutronix.de>
From: Tariq Toukan <tariqt@mellanox.com>
Message-ID: <1e79eaa9-202d-b48c-4463-ae195a4fc891@mellanox.com>
Date: Wed, 21 Feb 2018 13:27:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1802201917200.24268@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1PR08CA0216.eurprd08.prod.outlook.com
 (2603:10a6:802:15::25) To VI1PR05MB1150.eurprd05.prod.outlook.com
 (2a01:111:e400:582f::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 21caf1fa-cccb-486b-3d27-08d5791e2072
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:VI1PR05MB1150;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1150;3:nchf4qpYySFfpwqY/EwRHOxRM8x/Auan/ERJT8xyNSQfHrVUglgveZZjoF8mV45K9GjzS03mmoTWcoEpprT996xNAnfI7l807AKCBxd16KYyGufm7CcPcYZ/bRQPMhvA9UXECzptJsc//psFpNJVE27oOUH5e8GjL9dw8RlWKBZnx6mU2KwEXQ8FkFCVl1YZjtDbq9zQNRZVkuT2rtsw7FNd86IqcR5FekVgPpZnGcZDpZUmtzp6X2W2Qiv9SGK9;25:O05CWL2hPCabtePRgN2pfx+D0WICWaSbjKodokEyYGMHZrlTdRE6I/+5d/qBRZaFXdksv1P4J42mNzoKhJ4apHXiFvmPrONUh5ksDjOSXo1wrU82YULKxfqsM9EXJKtYuvPJOBcbdhW4YhDsEgmBsMDX0fe/ii6zwhDf2pAM3x1DvG2SqAj3ohZ1/4i1PvCZeLM90707hvalliO3Jm8ZlTyfbB5zneMtd7Rh5g+maC9E6hTSpGdHtY+zx+m5aY50P4Bl4kaDTm4ql7crMbF/kQpLii/ri5TG3uCdQS8nCCWt6AloSN0YyvYKLdlD8GdQSA0V28bgpXhHhblc1CwUJ2hgAGlnm8QHQe4V93EYDmg=;31:x6cFzWZPunxJOTgHTLeGelw6n/L685w31eMwefp/Lyw6ed1lBGmuC3T4Hc3A8e2gUWru5mAiBZjBcbn6P8pwaNtEgqjTJGIuC2krLY4+ovzQEToxhYUcFiNK4IoWYO33QFj2JDV1S3MUaRPKQL8GFJbq3iYweRHVuQZgHkiCYP5S9Se5Q6nYI6qHU03epDKg1pQiu5YPkkylxkX6lKgIZJM+VdMe5DuI2lUN3lNSrro=
X-MS-TrafficTypeDiagnostic: VI1PR05MB1150:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1150;20:yKL4g18VGIDbpTZhDt5ZNnGeEYZfqnmorSzDvHnUt/r99O1GZ87SRke1r18SS+rRzeCIT3lZ3dq58yvYuM8l6uiFjQ4637OFouqaEQqR5Qglg3gjf8PuMbMVteeR8m7g2mTM2A2g/G2XE3CIuAocpyU2QseRmmBHRqFYVF/Dj23TO6vAXdPy2CtU1j88m4aHIWwi4aD2qkvlL92uTOS8UaBw/ZoHsp6ALx6Ba8Yj1tETGSZQbFQC+3AyQvWaC2AMngtrzT6j9+FqwdKHcouE3qt3Po8wVLArQpE/X85qiA0rq/WaoHiYxNKIIRhLPtZ7/9R9ikZyvvtYhRgzCiYBEnpLATDMBW4zk7s20AQL+4elEv5UBnN3n+LleY7+Qc4NN7OkfByYG+5a0IiFgPwzEi5ch/yM2eeEDSK6mm4BSwjUxhCVedeLxXKdUXexRPyxUT6+P4omejDnS/BIWSaWZtRvnK4Lb4hhZalr8I+gOebEDBbw1tBKsJnTD4RArCCh;4:HQveAuDJCsImO1m/3JaSuKutgv2HkXjNdBA1AiQoX7XpKZZP4NGGKh88b2yQWjGNY5m/Z8PY3XHnylIV5at/U4Nw8vNI7kWNnnNA+A0qkiQR/SGr7R6PR5JbKUQwJLzOFes9PZOt2ChgpdyihjeF06PzTi000Q+iS0htRnl/nQg7hb1p5g7sOHBVCbQbl+P1Zk7UoFR1fa0BDIhPKcbk5dYhUzyTPsRiGXCm2wp1MetFy1xJ5OPyX9xRLGVPz6bkdyi4KnlFB8MPZGtNbS08vw==
X-Microsoft-Antispam-PRVS: <VI1PR05MB1150E699FA2798F52A96A1A7AECE0@VI1PR05MB1150.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001066)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231101)(2400082)(944501161)(10201501046)(6055026)(6041288)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR05MB1150;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB1150;
X-Forefront-PRVS: 0590BBCCBC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(346002)(366004)(39380400002)(39860400002)(376002)(189003)(199004)(8676002)(25786009)(478600001)(107886003)(2906002)(386003)(53546011)(65806001)(31686004)(66066001)(26005)(316002)(8936002)(229853002)(81166006)(81156014)(65956001)(6486002)(305945005)(52116002)(97736004)(6246003)(230700001)(36756003)(53936002)(4326008)(7736002)(105586002)(86362001)(50466002)(68736007)(6666003)(2950100002)(64126003)(67846002)(16526019)(65826007)(52146003)(2486003)(5660300001)(110136005)(23676004)(47776003)(6116002)(58126008)(3846002)(77096007)(31696002)(76176011)(106356001)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB1150;H:[10.8.0.245];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA1TUIxMTUwOzIzOnZUajd5ZUFnVmxCTU9rY2QyTGZlNnppYThT?=
 =?utf-8?B?bTVHZzc0WFh2d29RUkJIaTNuTHhkSUtmWlJwVDdWZEsydXQrKzROMnYxN3Rx?=
 =?utf-8?B?QnMvWjUzY2ZlNnJaUGxKaGF0Z0JmLzNTazlUSnJrK3AxR0NPZ0doYjQ1OTRj?=
 =?utf-8?B?WXhFbHplMU1abkNQcFFTMTQ1MXV6RnlBUlJ2aU1uZDJVVVRaSTVYSVVCWFJp?=
 =?utf-8?B?ZnArMVR6ck56UnRBRDliMXA3R2gyMWpPVXlOaThOanQ1LzQxL2cyMDcza2xo?=
 =?utf-8?B?eVNnTVNRTEJsdXhid1U0cU9EZ2grUmI2SE1wV1VuTWlicjJUWE5NQ3dDQzkv?=
 =?utf-8?B?NVBGaTBWUFptcldXMjNjNTA4d0hWZEg5MWpXZG5oajdEeVZ3UllFVXZMSGZo?=
 =?utf-8?B?L3hQYTFmRlpkV1VkcUQ0RGU2N0IrTmQ0aENIbllEZGw4MHo4ZDlHZytkVVps?=
 =?utf-8?B?ZUFKWW9UQVNMY2Nvb3pWTGlvUU1WYSt0bzkzNElwTFhjWTQ0ejFuRDAyS1J0?=
 =?utf-8?B?LzBSdG1hdXJEZURKWFEwRXB2Z0NaaGd0ZFlZaVRCb0hqRHlwbC9wN1pzOFVj?=
 =?utf-8?B?cXZKWnBRaGFkS2wzdzBPYXpQRXh0NjMvSHZwaWxzSVlnL2ZXSWlMTllZTkJn?=
 =?utf-8?B?d2Y5ZGxmQ3pqZWlFVTVZbXpsY3FUeVkxZnQ5TDRpc3E0QU85amJ5WGtNNk5C?=
 =?utf-8?B?eXR5R2dsamE5NlNZdUZwZDJWdGtFdGZXR1BPT01ZaEJSa0xyc3owRi9NdHBM?=
 =?utf-8?B?YXpYNmY0QVhpdFU1cjV3WW9tZ2grYjFlOHovVmpma1RZNGQza1FaODI3M3Zn?=
 =?utf-8?B?SGFtTlF2Z1k5T1hLeTZFU0FUWlhCY0ZWK1dJT2czRVZWWEQxamZpRVhSQVpT?=
 =?utf-8?B?RDBZYjJUeEdPS2U1V0tXL3lCdStmVmUwcmEvSUMySkpaZjlBN2J4WjRWaTVD?=
 =?utf-8?B?OVM0TDJxUjRhc1ViQTZualdpNFV1VzRzZU84YXJqQjFXNjNCZmw1eTdHNjB6?=
 =?utf-8?B?TFpZbXpvakd3OHZFQVZMUyt0WVZHY2MzbTY2b21DWVZXbU5OS3FNdmRMb3pq?=
 =?utf-8?B?NTMrcWttNFlPcElHRXZETDhpaE84aVAyTm96M3dwOVlFbTVUUisxdTFsWU5Z?=
 =?utf-8?B?YXc4MTVRa0Iya0MrU083L2tQUW1YSVlHdXl6aDhyZEQ2alBYK2NPN3dzVi9E?=
 =?utf-8?B?MXlIYUhROU9UUkNVbE4zTm1tQ3hpbzJmWnljZ2loOVp6aDNMY1lKNVlrcUNQ?=
 =?utf-8?B?dWdGS3hMcFRIajRtckdnVGJvZktIQ3d2VVpZdmpxQ0xvR2hxTUVkM0QwcHpZ?=
 =?utf-8?B?dkttUitLUlRRN1pmSmJXMEsvVjhSSitiUnhtdEFhSVYzemoydTBFbzVIV0JQ?=
 =?utf-8?B?UFFMR084ZkJveHBDU3FjaUJOcTRrME4vczNzT2E5Skg1QzR4Q3NNU2pEcFVC?=
 =?utf-8?B?dFF2MlcyTGdWQ3NRNWNkNHY0YlFjZ29ib2tjRVhUekRBQ200N0w2T0Z5SkVs?=
 =?utf-8?B?aTZQaGthKzh1Z3Ixa2kzTi8yRFhsMXlSUEhLaXVEQVRtT2NhYm81MFdjdGgx?=
 =?utf-8?B?WFNLdm9wdFdHcDFNV1RzSlMrNzhzU3ZiM2dubFoydkh2VzZEM1k4bzFQNUtv?=
 =?utf-8?B?OTk5MFA0eVdPSHgxMVFoc2Zid0hVbmg4VHk2NE1ySnBuM2FndmcrbTFVWnBL?=
 =?utf-8?B?TVhhQ3VTaTlDSTIwbTJ6Q0NIb0xIRmZ4ek9vS3k0aDI0N2FtQ25Pd3FkVDdU?=
 =?utf-8?B?WHFRcElVeDNiOE1IUHhod1lCWGgvV0NlbGRFNGUrUURwc0dyaGpMbWpITVpC?=
 =?utf-8?B?OE5kT3ZINUs3VlhQS0Y4a1FpcisvSG5wSUZmNzJzZ092anc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB1150;6:M1uMTfjxMKH+8m5IMOBFzMUnrYjXck69cMhjL0aiNnaTA3IZsaVihCAiU4Slo+DaHlurutgsorfChww9qxMcut3ZU9b6RdCRW/7YBaYkuwtodTybvjx/v22BJbVQI3/mF4VpbIj0CuLHKS+WfjRCIJPromqVj+xRjOtdt7TkatElELH8FRjlb505BLl5YdLnrzI+9uvT0901APnAO0KsKM45cNa5hGmJxnInr6mXqS+U+oJSX1KWXOxnTSwDBnBXPSNrrFT9thk/hc15xYkY1IMujWQYY1bSUKc616VqvgNFvrP4zbquyS2glW9ykbQxtVr9g8yvvUJE+HlXIw+/4fKTSr6zKs+yPV5lR4YOIR4=;5:34PGJHqZTWTExONeh2d0jNoDroou+D9+1YKJr8ANAefbgn/ezV+L2OgxhgncW+OOs8Ggpsa9S7VzjkkxYtF9L5pxJz7DxuYsxhIqYSOSleUFessRzLdkp6PrDxbwxTEX5Bqnu9eyvdI1GAZqbhKNkMEjmqzvY7OvAAid16eiFpk=;24:7rC/c9OJ1WAhGPc5uYxsmJCflxIqdy37th5QjsZDGRRUvjs685rre9pYkJG0npvk0LbAv4GKclOdcNe0VH+3fdfxE0ugwWwNJ6UQ9hsuQ+0=;7:NCfnXPG7amb1U+bCYpvV3snx1gnjfr6a1ExEf2tmMdk0rUBjIYE93a3FFv7YhkEgMWkiCnYFNv6ZjZrX+zVy758K+JUDanzT2T9Ap1K4gaNR6b3Igd2oJoOg0zfOYOhXAVwjKoV5fr6JE+GfuBarMpOanWHjDc53pxzL5s4wNG3qc8Evo8o1SgWn3t/a1jLg4QneGQI7BlafjeigD74EI+f3mk/Ue/E9A1ROQKR2dSAzVI3v/Mq4eI53bFQqODhv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 11:27:43.8755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21caf1fa-cccb-486b-3d27-08d5791e2072
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB1150
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2018 8:18 PM, Thomas Gleixner wrote:
> On Tue, 20 Feb 2018, Thomas Gleixner wrote:
>> On Tue, 20 Feb 2018, Tariq Toukan wrote:
>>
>> Is there CPU hotplugging in play?

No.

>>
>> I'll come back to you tomorrow with a plan how to debug that after staring
>> into the code some more.
> 
> Do you have a rough idea what the test case is doing?
> 

It arbitrary appears in different flows, like sending traffic or 
interface configuration changes.

Thanks,
Tariq
