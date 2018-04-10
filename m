Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752002AbeDJE4I (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 00:56:08 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57318 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751589AbeDJE4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 00:56:05 -0400
Subject: Re: [PATCH v5 0/6] enable creating [k,u]probe with perf_event_open
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
        Song Liu <songliubraving@fb.com>
References: <20171206224518.3598254-1-songliubraving@fb.com>
 <97e2c641-9dfe-bf7c-9043-c79fa0c568f9@linux.vnet.ibm.com>
CC: <peterz@infradead.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <daniel@iogearbox.net>,
        <kernel-team@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <33ee2501-14b8-5e89-d84f-e903b4cdd9e7@fb.com>
Date: Mon, 9 Apr 2018 21:54:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <97e2c641-9dfe-bf7c-9043-c79fa0c568f9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::7:bddf]
X-ClientProxiedBy: MWHPR18CA0041.namprd18.prod.outlook.com
 (2603:10b6:320:31::27) To BYAPR15MB2502.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::10)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2502;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2502;3:JXHGcwmVHZfF4UkZ5RXsrrGR68CGN439ggl6offec/5hooPLjRhWekAsdC6bwqWLsLqEcB0bVbUkIIXBtUrLaZcyRrXCLZ4xSM5uMg6OH6HwMewBTt2pJCUMm9zFPQvVPCa4trVAJWwZ8OHD8TETYpeAG1+QGb9j4Uw81i/GkqK6pHgNw0XCgBKSHXmpLljsT7FCjcH7F1ooYJAkKoGyFWeKeH7jW39IgRhRvyVCVJl6s79Ba3N0PY9UMjdCg23J;25:O5L+2WBaxgV6wCWTZHrLJPXNi1GKeBAXgyFxachr//XkZpOBArjj63T3CLW3wuJ4qBoA+fd8C61wTusB2QyKOu2otTRgiBsN3nm76tkyY6xRr3MGTrhLiyZB0R6h6EEI7rErQWBx1oBlz+dTXRrj2ucAckkCXjg+Rz1T17o+/JJOpQLtOI3bRDjPkB0bed7EBYx8wmxVGsi+cMK5af1uJNO79duCblBXgh1EzxdjBIH4bU9j8yg4hnMvgZhJ7FR+aHkAXEc0bwtYMnvD1kgydRG/jWoDRs5R+xzXqGgrVpd0+jkW257de8Lm2nN5fd/ATXi/YKfIcDwYQ/8OpyahXA==;31:pwyZNCxicvqCod36w0xzch4KZeE/Mktj7xlqByTBVdYM4RbH/U6kBQFm6tLFnshZFjPrmFUowUgS+LXTXD6h4VdMk8rctyRJa+6alKxkgIe2XLFSfjL5K89clIO3qhaASnuzi9ROKRwVeE2JX/hDcB2VsWJkqGgCfyt8vk39kxycEuSM9EBI0l32YinPoJq7MxDDr3b3fh0foGjnkTqh41v2ISzRvcnX0tOhULaa5ZQ=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2502:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2502;20:e6KINvMYScRYDtOw26JnuWEoUYlVThVn0utHN1s98S+b1c6p02xQ8VDCqzP+hWdcZgIxfy6lHaWweNMNCXeOFT4OgsiM1YXrhqcghjRwvZrRkccy3D53/Qk+VKDbOClrB6jnBINNZxxmHsaUi+TdolZSblBN/P2kQKBs0ugKYoJe8MBYkNHCie48HWgDSsC2hTQWuDRU0zD25NTrsb7FYEso3vb8CTimzWKSOQ3F25BwbfGWRdrAeOXfN5Wo696PmSRbZpj4KvWKZePEfj9iOc9Ny/klne8myFTfSvQmrJZ34QPIku52C+oy5H/Eo0lrB/RWs1gaWis+71wWaGwfQ+JB9q7WvYkx6d+mL2/tI7CPRSfFfqCfDwOPy9EF4shC1WIVLqByGglFUNG8bAWJGenO4QxoyxDoaE2SFVh36BRsDtObewnXzNYC8LEoRKf8sVbE2b1UkWECIIZnEasYfP90LDVGAO4LFdGChaiZaDpRJQ4vZXChEhczCX29on7C;4:hNlcnyCyYzSpx9mPWCHhao+PpO+VfVV2LRE1BO/02GusIhNFoJiK0BRcdhRDOpw2lkSkdxY+Dq2zeTj/cyb4h/XRxEGjCPwNDoja6dbn3zSelOnYAPxX1ruf6bacSShekFeGf1VwvVIFsm9eJmieId86bnJ14pgEnOLgYFuqTTvn1ul0QT4nSEpyTf5eqdMl2Exb6d3FLaGJf3niSmJgfrrJpu+oSI8SFjsXVP+e2H+/4nzF3lfy4yUztX7beEWACw8/wt8WSuiM4x1sZT0VKQ==
X-Microsoft-Antispam-PRVS: <BYAPR15MB250269340F36EF7F015D173FD7BE0@BYAPR15MB2502.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(10201501046)(3002001)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:BYAPR15MB2502;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2502;
X-Forefront-PRVS: 0638FD5066
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(39860400002)(366004)(346002)(189003)(199004)(6666003)(2616005)(476003)(478600001)(25786009)(68736007)(53936002)(229853002)(6246003)(486006)(6636002)(11346002)(446003)(305945005)(6116002)(86362001)(1706002)(6486002)(7736002)(97736004)(105586002)(65806001)(65956001)(5660300001)(65826007)(7416002)(47776003)(4326008)(58126008)(2906002)(81166006)(81156014)(67846002)(53546011)(8676002)(16526019)(31696002)(64126003)(186003)(50466002)(230700001)(8936002)(46003)(316002)(52396003)(5890100001)(106356001)(52116002)(2486003)(76176011)(23676004)(52146003)(110136005)(54906003)(31686004)(36756003)(386003)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2502;H:[IPv6:2620:10d:c083:1309:2d74:74f7:8f68:259c];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTAyOzIzOmVSZUE0TTZRVVp4RTJ1V0lGNllacmNuS2dH?=
 =?utf-8?B?UzNGMCtiZ29IZmFlMHZnQU5wVVFXNXFLaDFrbTQ0Vng1cURudkRSYjVRV1Mx?=
 =?utf-8?B?eFhjNHdwUjRkejlJY2xHTkhldXpKYlAya291V2U1eTdKTC9iUUMvWWJjdFZ3?=
 =?utf-8?B?ZENqVE9TT3ZrdVZPWndabHZ1UGp5QzlFMGtXZjRVaFRvTEtFejFOZWZHcmsv?=
 =?utf-8?B?QTFhb0dIMTFJUVp3aTZMNHpyWTBRNjNNVER2OU9yVVBSV1IwTzBwRndsNVFx?=
 =?utf-8?B?NzRESmFXbHYwM2hzWHFMUzA2aDkxcjVDSi9BTkJwMzMyV1RWZ2pQQWJrRjVZ?=
 =?utf-8?B?S1pTT3FwTnZleDdjZDd2TXJXR25CLzAyT0EwZjdDdU1udEZGRUwrMExyODNT?=
 =?utf-8?B?SjN4K0NCZFhYZElJWk5VVEJqbW5DY3I3MzRjZmNSV2twNXFvMjlMaUR0YWNB?=
 =?utf-8?B?K28vSVpGNkNyUG5EYUFaeXpjeStXQk1JNDlYMGNMZVFpWkt1ekpWYjFheVJ5?=
 =?utf-8?B?WXU1eVBZQlJmU2UrZTlJc3dYVmxISzV4OUFCTjg3K0pHRnBmc0dYZE9JdStn?=
 =?utf-8?B?QkxvejcvT05vTC90cGdxcXFIeVU5TmxpNUlXa0s4QlR6ZFVMVmE1ckVVME8z?=
 =?utf-8?B?K1orKzlwcVRtSUtJSEJCR3ZVLytnTWw1cUloZS9XK1ZPWlNRaVFFbDhGTVVV?=
 =?utf-8?B?TmhybHlOMysrZTF3YnEvQVdMSTNYQ0Ezc0xsbUR5VDdYYU1KdkQ3NkltTnZh?=
 =?utf-8?B?dU1qYlBhKzVKTFlGZ3ZYcVFvQ1BaZHVKNGNDNjVlRXhEdjB3eG9SUERzVUl4?=
 =?utf-8?B?OThLMWRJdjlyVXhWcWZudzJKdGJUbSs1Smkza2FWVVdlNkYrSVJDdkZhTEc0?=
 =?utf-8?B?SFQ0MFBxMG4wQnJYVFArVjFMa1JJS2dMZ3RzK3FFaWptaXVjS0hqSFREUDZV?=
 =?utf-8?B?N2VqZHVsZFM1RGRqcC90MGFWWE1mS09GOXE0cVZiWU1xd0FveHFKdU9SNlNv?=
 =?utf-8?B?RjY3citXVTgwOHlPVExrN3FmQ3d6cDJGLzB4aWJIRWVWKzZ2dUp4b3NYdmJG?=
 =?utf-8?B?OG1yWEpZMW1Rekg2ZnV5NEdmZWQyV0lnYnlsR3RzRjl6cWFEUU14WXJMNlEx?=
 =?utf-8?B?Z2RubG1vQkx6VWhBN3BHd2RzUWFQOWdhWXhEaVlpWTdiZ1ZGeXF1L0FiNUM0?=
 =?utf-8?B?eHYvY0U0b0hXZ1ZteGVBUGJDWFJ3aTNTMVljUWtWL09rUzl0bHVTai9SanFu?=
 =?utf-8?B?Ym9iWjJrN0Q2aElEbDJSVnkxcWRjK3libUdya0k2V0kzRUlGaXUzWTJzdzRB?=
 =?utf-8?B?L3E5V3RodkllbmRra1A1T1RzSktQNlBHSDJ4cjIrU25Rcjk2eXYvQWkyc3Vj?=
 =?utf-8?B?VHZhSm96Y2ZJd2pleTdHRk83NzdJcXI5ZE8xZ0FNbDRobDg5UCtkUXFVQ01Y?=
 =?utf-8?B?VHFWeVJUSXY3RUtSTEo5V0lyYTJocHFzREI3TFhFME1PMVlvV1d4V2FuclRw?=
 =?utf-8?B?ZG83dkZOZWJ4dHZsK0FDTWVER210NW1lUnhtMUlIWlc4NTVJbmRaQkx6Y1pF?=
 =?utf-8?B?N3NzUHJFdjZNVmJjOUFMTlhCK1BvQ1QyVGlmaVJEaW1sOXkxMmJqMzlYbGJJ?=
 =?utf-8?B?azhqaVg4MEYxV3ZUVFRtMnZnWVZsR294MjhmREtqczFtUFozQkRFV1dLUDc0?=
 =?utf-8?B?dEpCaFNvOVhmSHpuRDZGd2poR3Y5SXE0MExYWXBzaDJkc3dRNkxFVmlYbFo1?=
 =?utf-8?B?MjhxOVJrR3JGdXRLekptb21OdDBvWFBIU3FmOVRvNkgwNXVFR3d6dW9zbHlL?=
 =?utf-8?B?SkZEeWc5SndVV1NpQzhZbmV3SGVJWnZ3YlZDV2wvdlplbHBtY0tTa3FJWDZk?=
 =?utf-8?B?MXZoVW1FWk9tV1ZGM0ZBcGZxbFpJRzJvWmJ4bmRISkJYVFNFdjFtTGllYlpt?=
 =?utf-8?B?Vkg4NjhPWHhaZENldm5peURyT0R3WG8rdnZXR2VCcHFkT2lldE5MeU1iM01G?=
 =?utf-8?B?QVJvNUFaOUtCRFMrdHBtbmwwMGpDQ0VXQ1lLQT09?=
X-Microsoft-Antispam-Message-Info: EG9tEqKeGdKwz/SziGwM423GyCufjj99BB6MKWn/dnfUPpoPEil3WH+7224h3cFSBT8/Fe8cwmjJTh4w9rfirWn7HMhYW08vUgQjc1TOErsBsRma6JQyoEFZWojNE+igKAnaGFBhNE7zSnQkA7/Oql54f9qTzdavIaUvVnGQTgKOrIJUDwVm+YXd52wmdOrR
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2502;6:O0yU98iXKvEQCovVNWLYE+/yndrffjsVgWZfOze0I5QvoQN0Ft4bVSaTdKeeQe7tbRdcGTI4VemNtdusJlHI//Hcmj12HHSZj5IaDJH7bIDuooIC73/UArvIwdbuvC6XUulFQVdW48RBb0X8MlYqM2DD78ZJYlYWZwW7Pb2X4PWoreTSq9wm5Rx4cH23pa5c9WNMbHYmPgKpv6m5nA3G9uGTYu/nq69Fbif4AOhH9pI7MK7fuW8BgbQ4scdHsebbYNBgONtb0KxQdCkwBlxeT4b7qT+hM3Egc/haZWgkDw8l1TNzq7bRU4YCenCSFxLnGYmMCU4ROtgUw0mTHCRSRWxp1FS5Vt/fwK9Of8grAOhz4XLKTsLiEAfBZPMVgDbz/DbF9wUICIecVi81vONidG8Ow3qh0RIvCgftnoiGxJ8QJKs7+vkOECDYiOLYKcpWdzTsmvvLPLdymr7tPP4JPQ==;5:FxynqlgCJ9cto3D1ZjeMejvortgEP2YheS8tjfZMkoNXYbtt1RevdZtHMODv2hzdIlmRBJiHbIvckGTrnjSywYUlUrC4Pv2zde134RkHzdcVRrcVKg2tBad6YHFQl5WG1BrcXuDqMSUUKhz9yuSWn2h2QRdTNp2X/gwwGwzSXBU=;24:mGbbDYXFRB0DU26S2ruhsfZJl+h+zRSAdHRK/mqlGiitl47HqnQEuu+pdfkrSqKCzB8tRNe0tUFQzoHa5l41KJO2Uke8lCz6RNLIbGXj+ys=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2502;7:9GaoHGeo1aowitbGmkn6Gyqw/YjJ/kQBZDZ5mKbbAJ9Zl+GwSFdVpRVvyprMVEAvxEAWjvhkFGCWOaA/p2gQuMgZvOlqEMSd2xlwOa7uH35vC/8BBhqYuHS7WqDytfPpJuQFtKJeET4k2ocGr2w9o2/ZmeF32/ySnoQDHu9d60ILJ8rOGkFZmGd6JStRCMgmXkm7kmP/xMWFKd5HgJVryP4wWD4B3TVY3V0cli6SU1SrxVedG48L/N49JUwN7z2e;20:aXPHF7ydUUT78d52PUkwFiYgxuz2B36vwuQhT+atTdNqavLs+ERl21IUgTJPeEW4Yj0f/CjUnly2GRsA0qay7ImOWq/KjcTtAi8bujEHnwtu0zZsAJVxQnC1n8by8F7Wo6mhUvkfObbjEXNJaDN3eoiUjTJ8eNTJjkrYod/kLMw=
X-MS-Office365-Filtering-Correlation-Id: 6b2a92aa-dda8-4555-707f-08d59e9f2f83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2018 04:54:47.0049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b2a92aa-dda8-4555-707f-08d59e9f2f83
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2502
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-09_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/18 9:45 PM, Ravi Bangoria wrote:
> Hi Song,
>
> On 12/07/2017 04:15 AM, Song Liu wrote:
>> With current kernel, user space tools can only create/destroy [k,u]probes
>> with a text-based API (kprobe_events and uprobe_events in tracefs). This
>> approach relies on user space to clean up the [k,u]probe after using them.
>> However, this is not easy for user space to clean up properly.
>>
>> To solve this problem, we introduce a file descriptor based API.
>> Specifically, we extended perf_event_open to create [k,u]probe, and attach
>> this [k,u]probe to the file descriptor created by perf_event_open. These
>> [k,u]probe are associated with this file descriptor, so they are not
>> available in tracefs.
>
> Sorry for being late. One simple question..
>
> Will it be good to support k/uprobe arguments with perf_event_open()?
> Do you have any plans about that?

no plans for that. People that use text based interfaces should
probably be using text interfaces consistently.
imo mixing FD-based kprobe api with text is not worth the complexity.
