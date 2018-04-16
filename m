Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752978AbeDPRLq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:11:46 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:62446 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751227AbeDPRLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:11:42 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517846400";
   d="scan'208";a="76105521"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
To: "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
References: <b46de00ee67e4ec9955bb3f09faa36c4@SIWEX5A.sing.micron.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <9a095abe-c016-0c2e-11e2-7253dbad3a6c@wdc.com>
Date: Mon, 16 Apr 2018 10:11:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b46de00ee67e4ec9955bb3f09faa36c4@SIWEX5A.sing.micron.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [199.255.44.172]
X-ClientProxiedBy: MWHPR2001CA0008.namprd20.prod.outlook.com
 (2603:10b6:301:15::18) To BN6PR04MB1186.namprd04.prod.outlook.com
 (2603:10b6:404:92::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR04MB1186;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB1186;3:zrKS8NPcURDFV1Mw0cVGVFVWPcGuSKToGpXMXlukYVlsvp9IGVG6WYmIvakKEk5kbHHUF416AZpxPQhrzfwWgc/xGaso1MN7FdiCkRmESPwWuiyzRwza7bVw3NTtEYKnfslYH1I5lNpDjlYr4YY1BJoCrOEM1fOF9piGqsK766rrOZ8czp7RQYf6FkGs9U/fZSlKzSL6tWaAWiGAqi8NEnPn3kVGYX/ejE44o7PzEfDr2rl9wyhaPzJeTCqYKRFB;25:W/7OM2UvUmDeee6nKJzPlFf8bR3mOmLctpAMr4QlGk7YMeeDuTBPPN/rS10L+zKa/L9kxkH88vwREgBi9jWsab/bpjcxCJu9lxddYzmPngs1nzclAjwFAH/BeiaZhEPAmUM7+JUgc91hOXFaJZHTChGv6eHJ3NycYsMGBvQT7HGTDkIzWibkwAViipy/Bf80c5nDUJdd7+BErJERIEd7uGfGrJORAjE67z/S8tmRlSkaqlIJ5GrbsRrxPbX96K8FJhPF6eN554FaFXMnbkV6JlwwGjf5EvL5Z9LhqNUcPoTQ+jXW1MO00cKFT61t87sm2tsD3L5TaZciD8VMflfF4g==;31:vDU/KkVBd85VLtLFfc2a0R0NvHR4QsRArb+f3s6W5ob/qlVXoukJykZM529T0gimIdJ5CRpLuSCegATIr9O4mZCUxq6lOvxXU7813DAtdQ0kA+rTQpHLcyHa3JQIk8pTCorxW22XQ70i/mzgL4ErHk7uBNt6Pnh0VYfzQzBxAOMp2jSXybbG3QvsBERNAbZ1n02OzQLFqVoSyvUaUfWNbASUrBWwTzXyZze2oLAcHeI=
X-MS-TrafficTypeDiagnostic: BN6PR04MB1186:
WDCIPOUTBOUND: EOP-TRUE
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB1186;20:tRFcq4h5nyKMEK3po0Yjt74cxj/Q2S5gNmdrBa4FHJ1Hzs0s51F41AM8OST2fOXJeMAdWhq5iA7xPJnJyL5Feg6XntMcYt0BUWqhdly+2lFAV36ISv2gPDf/MRvdqaKYCYC9Ws6S+zbZp8QnK6GoI/tn0uJR1LWkcIGMMpFO+wDHVpIZ1Mynss+WRmQWH3mHqMoCeerUVfsRGwUj9oBP9ocLaZK+8AIMqc3jOmE7e3vlcBQXJiv8uiAtTuXbkdEqUEqpP2rsJ6pM8v3TJU3Vq38q0TAxu2+kJ1qCz1XD49FXu2ZWZc6eeyhDiIeUM3osHuAPZhGTS1sgE25akoWmGAI8h4dXvyOsnLwMdJJ6Z9fBGIMV0L4EMFoUDVCRgOThLLetiq9eNMKZazvwnCVX6011aEXyiU15hq1mxPBy9VMH8yd8FaclMc+khBuH3lUCJSHVPggeb307vhXV966kzwQ7dwmE4+y3jk113R2Zm5HlaZFm3wIv9P0AxEjoqlp4;4:gkJe3JaXTEmvXS2ssHxOexvIQ7QnQ4kO0SZmoTbaOLsacu88dBSxO1wYOLKZsK/aq72iMjWQOZ4n8mfy73f9mqDuiaikgb2w6wXCBPWH55iPJbteT4ULGdqApw5XziE6LcfwPxOB2nBxSlrbxCWgMrf2ogcfcXh3TTvBsqAE0f81QR7KKtIlWM1hbatm+EeFUjsvdVVOiRc/bBjECfv4pH2Wr7E2F5g6eX+Vrk1Dk0ubJR4Ie+LVumouJveE3yWgdLrawLblIJJ1v47e/DXIwamUP4bKvKHxgM+Ek++emeOVoZIjaOqIpie+DvnVjy84a2jFZnDq4SyeLL1742ViCBVx0hI31tG6JDkbc0YQt2g=
X-Microsoft-Antispam-PRVS: <BN6PR04MB1186DEF3DB21B753C43139D398B00@BN6PR04MB1186.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR04MB1186;BCL:0;PCL:0;RULEID:;SRVR:BN6PR04MB1186;
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(189003)(377424004)(305945005)(81156014)(31696002)(81166006)(50466002)(65826007)(8676002)(2501003)(64126003)(7736002)(106356001)(229853002)(6486002)(2201001)(230700001)(8936002)(65806001)(7416002)(26005)(86362001)(66066001)(97736004)(47776003)(36756003)(65956001)(25786009)(386003)(53936002)(486006)(16576012)(52146003)(446003)(6246003)(316002)(11346002)(59450400001)(476003)(956004)(2616005)(31686004)(105586002)(52116002)(58126008)(2906002)(68736007)(186003)(110136005)(54906003)(16526019)(53546011)(23676004)(67846002)(3846002)(76176011)(6116002)(2486003)(478600001)(77096007)(6666003)(5660300001)(4326008)(72206003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR04MB1186;H:[10.11.175.142];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA0TUIxMTg2OzIzOmVWeFdrd0hLU3dzeEpDa1NhdG5saEJaVENP?=
 =?utf-8?B?Y3ZrYitnVW9ZMlNlM0YvQ2tWcFozVE1YNVZkTXcvM0xyMWpNa0VyR0QxbG5a?=
 =?utf-8?B?aWtXTEhhY3poTExERWpnNGdxT0JYT1JIOUNjcWdha0NJL01nbkRPZUg2MnZN?=
 =?utf-8?B?OHBWb01sSTFPYkpZY0FFL2x0M2dMR2dGa2o3TmR1SnAzVE91UHpnb2NjR2JQ?=
 =?utf-8?B?MkNUeHBMamw3OVdJN0RPL21IN2ZRaUZFMnpqMS8zMkRMMEp3MFZYdDBKVE5W?=
 =?utf-8?B?Nyt3RVA1UDkzSDVCdnhNZXkrV3dFb3d2RTlNaHJVVC85Uk5GUHhxdWh1emxE?=
 =?utf-8?B?b3JqWlRFV0xoZEg5YXl1L3BPMEllNXNLL09tZFFPU2R0cmQ0YkpxbklOMWFO?=
 =?utf-8?B?VDJFY3BHcmpBMm5ESGErSDVlbXpRaTBkeisyM3I4YS9Zb1NFL2NKTzM2YXdq?=
 =?utf-8?B?S0Ixbk95MWFRQ2tXZUFKNVVwbTJkSUdkMW9waldUdlFCc3lVeHhHc1puVGND?=
 =?utf-8?B?emd1NU5OekVCc3VPQWlLakphUHVCTzZuZytjSExGY3VneG5VTXB2cDd0MEZU?=
 =?utf-8?B?WTFvbTFmOExlNVlYTDBJc0xMU1REaGNXL09nWWtmRS9mU0dqTjNlZmo3T1lN?=
 =?utf-8?B?TGVhcVJsZWtMRXZiNGJiUmJkNndYTE5ZcVM4VjNqbUhYYUN4YnFMVmt1aEx4?=
 =?utf-8?B?bnd1T1BqQ0VSNDhVWngwWi8xN2NPRE5ZbVl3aTRUeDJReEhTMkR5QnlsTkRp?=
 =?utf-8?B?bWVJQVp2eEdRaWt2dkZXVHVaMVc3dmc3aVZFNHhXS1JHS2lpWXBuVTdWUFVP?=
 =?utf-8?B?Tyt1cU1TeThrbTcrZ2lWdms1L3hZU254MUUvTFM4UEdiZ2xINCt1MXdtQnZV?=
 =?utf-8?B?dFRDN2R0aDd5WW1EQ0gxK1dYVzFXdCtUT0VZbmp2ZDlnVng4aGVFY09xYytP?=
 =?utf-8?B?WnpXMlR4eERmVGdJOGVZcVdEaWJKZmFVSWFCYzRxUm10cFVYUEhaVVZhbm9p?=
 =?utf-8?B?Ukp1cSt3d3FKckxPUG0wdFd6U2E3Z0Q3WVdpaFBYbXNvZGJlcHhlVWJwOGp5?=
 =?utf-8?B?MGI0UndTTHVPSmovMmtDVldvZldRWkY0aytIWXEwenhldlFMeTU1NHdKWXdF?=
 =?utf-8?B?eDM5RVcrNzBIVStTSG9UZmdXMjZlVnJBUTk5cnRqTGFsbCtBMkhLWGkzTmpq?=
 =?utf-8?B?TGdHRU8yZEtvdkticDVvdUJ1TTEzbzZLeVBsa2FGcFRhTVZWNjV5VUxwNGtI?=
 =?utf-8?B?Q3FDblE5STlmS2U1TUg3dElSN1pmODZ5U0t3V011NmFESWc3WmJERXBJdk1L?=
 =?utf-8?B?N1phcm5VekdNWVN2SmZCZXRnRldPdXpqd2FyR1c5bVcvc0dTdStTUzlIT0NH?=
 =?utf-8?B?SVB0bmJ4UkNMeWR2TC8wWDBpVEo0aUtXZFRtcEpDNGQ3UzNCK3Z4QWV0OThs?=
 =?utf-8?B?NUVoQWl3a1B2VlpwOXA4bTBlcXd6SE0wZTg1YTJ3c2JWdmtyb0ErcU4yb1Vs?=
 =?utf-8?B?ZnlOVGFNaVZkQXgxVE1OeUlSdDhoaWsyTlJXdzByNEFPNEhBWWFkazdtd3Vo?=
 =?utf-8?B?amNWcU5XbnNYMTVDNkZHaWdLdVpCYk1SL2RXR2xBazA4U0RBSnhVc295SmVa?=
 =?utf-8?B?R0tOKzVlTTVwMHc0WFlDdHJPUmNLN2UwRWhYYkNjZmdtLzFCZkFBWUVlOU1R?=
 =?utf-8?B?UjBRYzc4ZldJUmt0MkkxWEZKL3VmM3dsc3pVTG9ENEJFeWpuRHQ3ZzJWdyt4?=
 =?utf-8?B?b0d6cnpMVHFCVGFaY1M5eitMZmk1cW5MeVhMaWlKaUIzeXlvakNnWWtrK3Vr?=
 =?utf-8?B?V090SzRZTFNDVWMvRnMreUNLSzNRUXUxMmpWNUxPeUc1T2ZLbHd6S0x5Lzhy?=
 =?utf-8?B?Rmt0ZW5yazRKUDcwZmY5Unk1NTExb2g3bXFraDhRZDRoVVlHcVlNbUY2Mkhn?=
 =?utf-8?B?NWhLbWc3MkRkTzBpaWQ4NEY4b28wWDMzMWNkbTNWbnFGd3hOMURXNktWSkRU?=
 =?utf-8?B?NEtOOHVENFBTdmIzZ01KaTkxV0RqUVpud0I3YWlSSTJJbWViMlJQT3l5MEg1?=
 =?utf-8?B?YXZYbFFuNXZzekJ6MlJSR0toMDlvaWd5U1lRMDMrdkpVWFRoVFRRVWd3QTU2?=
 =?utf-8?B?cEFZaFJoTFMzb0hzeTAwQ1NxZ2pxTlpSV050M29BQmhvTThTbTNMRWk0alM1?=
 =?utf-8?B?UzI3WUJtTHZueXNxcHN2bnJZQWZnPT0=?=
X-Microsoft-Antispam-Message-Info: zoT++6oTbP+rIayXphO2eGzc33/RHrHjcmoqQlKwAaNXwmuLovXIO65Wb1HETzhzPETNv476p8lu/iustREBr/mO06cNEF4ZJ39lqNnNVmMY0PldACUabJFfmxJZkKYLC4E/z656Z2aBpRzV1DC9zyOlHjNp6egV6kQbO3Tvwbf7mB2l1dd53EKQYghURUfu
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB1186;6:s1F0nVJu0VAbrfVfByr2Ygddr6rZtr3GpeGshBXsnZ/Nn8lxjJoMuVHgkxBa6EWpl5ZVHAmdY+V1eX/TvcTA/GfhFoKo/S0/l9E8w7Vz9KPslfkTGTazVSKrTKt3DCmNdIasRfUEDt0rvCCU10GkRf7sSjz59bh8rvCLfAztfyoa5OCROzM3ehYl6jJVEjyi914chq0vumj/+0E2ZO/VoqSUFhs07pl63ko6azmMoYFPmKRneTH0qmKV1BIE29/+0xqLES7PdOE5dTVB+NM/+8SiukZ2sn0oytuya1oJXiV0ZTzmU+MiwayxHoQJYsCsA3wfXp1gu6qFueXQc+JZ9UW0pruXBV8d0grU50UJh+XKjkOGmsX60rSYHvmQNyqgbqUd0/Lfv6QgM/HoiWD9Qw/04szf22UnWf0Z8gsl3x2Mp/LxmQPS8pYObUeEej3COjz0wdTrEA86AF9bwF4paQ==;5:gs1Nz1Wt6K9Ove/I5mWpkSni7Jj9HbG4Qp05hbyy9WDh87AvSaVbiwdJfg+GiljOUemKJwF3QMeBAL+t7J8AfTJ+lRsRGAMcSlJwCp179QZr4EULlWUrtYwbtSIGVZdDWG+4JgwLZUQH/Fyae7cplIMG/zyKByJLygEniFUOPZ4=;24:fJ2elOOy21vEV9n1zwOmI/V1mBK1HAibdt7wzhYXXMKp7BeGb7iava3vpYn1PtwGUu8n+i/eIWoGHHYnPFrB0EaH+1sZETQ7txd43jkKyoY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR04MB1186;7:dKaZ29mBUt/BpAFSfbgZ3UXj46aeBQWht0NxysFFe2qGBgFrVd/o3Zfdzjhpu8fXJ8E28CfuVNjzS0EzspZjQJBWyEfuzax+QeTR5xNyX+qwW+l7XdkuO3GUXlo1xJvA6keCwR922+fmktkAal8aEouscj2qiuFVKWjYWqR6kYDupQIHjvIGpfNJXlHkJCkfTmbTwVuk9TeZ1Nva3uum3nGriQ75vaHMizMsBgTt3aK2vWE+8ZShlf1CV2yXZr+r;20:dq6lS11QDa8d/CBkQmFvT727IPD4Q/jRQMv5vyoxwysTh+IKt4Cbq+nMt+wils6Zt/1N/Kteaom24p4g47kk5MGo8gr5LQzciOg7Mc1X4SknIJUG7wKt98YntTEmGN7+q6wCes7v5vACRiDACOgl3iVzUAAjxSnIi8DDztX9kDU=
X-MS-Office365-Filtering-Correlation-Id: c91bb0fd-7864-402f-1f4b-08d5a3bd1e21
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 17:11:38.0551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c91bb0fd-7864-402f-1f4b-08d5a3bd1e21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR04MB1186
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/16/18 10:05, Bean Huo (beanhuo) wrote:
>> On Mon, 2018-04-16 at 09:41 -0700, Rajat Jain wrote:
>>> On Mon, Apr 16, 2018 at 8:28 AM, Steven Rostedt <rostedt@goodmis.org>
>> wrote:
>>>> On Mon, 16 Apr 2018 14:31:49 +0000
>>>> "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
>>>>
>>>>> Print the request tag along with other information while tracing a
>>>>> command.
>>>>>
>>>>> Signed-off-by: Bean Huo <beanhuo@micron.com>
>>>
>>> Acked-by: Rajat Jain <rajatja@google.com>
>>
>> This patch is not acceptable because it adds support for tag tracing to the
>> legacy block layer only. Any patch that adds a new feature to the legacy block
>> layer must also add it to blk-mq.
>>
> To be honest, I don't understand your point, can you give me more explanation?

The legacy block layer will be removed as soon as blk-mq provides all 
the functionality of the legacy block layer and as soon as it performs 
at least as well as the legacy block layer for all use cases. If new 
features are added to the legacy block layer but not to blk-mq that 
prevents removal of the legacy block layer. Hence the requirement I 
explained in my previous e-mail.

Bart.
