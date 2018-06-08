Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7964Nn8lGlsadAAAmS7hNA
	; Fri, 08 Jun 2018 06:44:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 16B33607E4; Fri,  8 Jun 2018 06:44:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="O1oNqDik"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1AAFD6074D;
	Fri,  8 Jun 2018 06:44:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1AAFD6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751719AbeFHGoY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:44:24 -0400
Received: from mail-by2nam01on0059.outbound.protection.outlook.com ([104.47.34.59]:7040
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751055AbeFHGoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sprMj2fwHjRZqvCAEtHLdm1jDi94YbKPIPxYL3A7cQs=;
 b=O1oNqDikBemKCoYu0szm2R21mszaFEb8vpJw91ubmiPg0FSCwmxwCnmdz+hwmm3PRKKEH8wMRRTSBDnxOnobTxazmPKll47sUZxVWJXAf9UFzpHP8Wbx/qyq/6I9WfFLVfYwOWfmK1Vxdkj03py4MpIW2MwLSDegaPUBAwFJCL4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 DM5PR12MB1724.namprd12.prod.outlook.com (2603:10b6:3:10f::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Fri, 8 Jun 2018 06:44:19 +0000
Subject: Re: [PATCH v2] gpu: drm: ttm: Adding new return type vm_fault_t
To: Souptick Joarder <jrdr.linux@gmail.com>, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <20180601192724.GA2001@jordon-HP-15-Notebook-PC>
 <CAFqt6zZr5WaXk9QSEE7100zs94Tx0p4inuXUF5WXgU8=9rp+bw@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <cc337cc0-12ba-dc96-c504-aa5a2963be0f@amd.com>
Date: Fri, 8 Jun 2018 08:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZr5WaXk9QSEE7100zs94Tx0p4inuXUF5WXgU8=9rp+bw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR0402CA0024.eurprd04.prod.outlook.com
 (2603:10a6:208:15::37) To DM5PR12MB1724.namprd12.prod.outlook.com
 (2603:10b6:3:10f::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1724;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;3:lsgtHmZf91nKfGWGc1aAkvXvlbZky5VqbYjFoFkUe4hHDcFNRSSz0PSm/bJTvpfOwZkgXYXVus0gYrsBMWqaE2ROfYyj1iikQZwrP4ZUi42iu6d5SRoVMc+Q9ke8EJ1ZXuviatPmyiT/5ikfXFxsdVRR4SpwCqMXVQJ9FUMX0Fd7m9yhr8fdIxiL9P3VjBKU8Ix38g/Vg44IAO9zOThF40DuPkujz1fB19d7lmZkXNGJcBTgZzd6M5P+ZZyQ8LSv;25:9q8QeF+/SRYXE22N2BhheDVdWedoHnuFRJ7c1Ournw4pkFn1rg+RRtd7UDKddq4JmKQs+tTIyQ8nJ5ekN7OMSp6btEH9C1XiPH4f4rrQV7c0xLP4bfB5ZlCnpmw3JnllMASZJ9vDRVPwf44zvAXXQZrqPa4NyMXETdL5fwutPXN378KLfDLFVnC4WW9mwm8ZXledgJRUfkRl1gnvS3T+7vuAS1q9U/L/6mAnE3/+5glNkTPy6L0YS5eaDPFNvrQknZYjg8nzBNZQO8mgifaQUR/ZMDpcReUX2X2kn1Ta98W1GQaXtK38nDKXrqR4cm+A2ZhF9e6oD30iZsqzpyzSNA==;31:OThWxyVFyQd9JD2M5fae/4op6In8iEa+cLTyCA1Zhv2B+JRA4bYfIi82jhxwnjjb/HqqirqOOcB08gQ1z0K1hRP9MmQkRV1B80kbpZUeiysUiFB4QLIfUnUdw3Ooj3G+SzNfn1AOY3kvzPnQ4t0s1BBjUmxGm8DjC0bhBLgwoaSoUceglBlif3TYAWKW1+6GLiGRxc4eBoQXk+JMQQcbtVyPg4aR2PG82NH3rieCU6A=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1724:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;20:6OOdnIsQtRV6ANYQe7ruZ2Tju3qQK8Funw1nTUXg0hoDbLIJ6zVbQufN7o42kCsxtZBVssqo8Ri6EAaIcySKHSiXLAs1NK3ZOyiENs6lM0MqrAAKlJoU+KhUQX8nL0iDmLHkmz1x6Y7xU9fAwoVKSlGmNOYKyy4oJAFSEqqVhB6vfPF628jxx2BVn/ThSk7XywFysQjrmdj6MqvCPi91QV2uGGiuiW3nkpUbOvTmWOHDkTYK6kBTrt0eBi8gHH1pDnUiRn2UlDJldtyf5TBnQdH7U03k7RlXJlC1kwsGipRNStJf7zccz20kToXQrVs64sHZKwEBxAzQYX9Lfgp1Qt7RvLTxy+3GJr3McSpxM0FQQcgtlwmd25vyJIrniZCglJJmjnyt0q2WDgnWmS6wnWoSfrzK4YdQOBgmx4pgmQbEioM1Q9vTrPAKncKFIT0kO6+/awS4xsH5Ez9ihpl3/mS911oFVneHO/i28VvvqpWnapCeA8hovSUQDZIf1aLh;4:ID7Y2H9ELBgrFz5CTC+5mTmH7GRkJJIdTKNrsJD7igueeF7CKsu9sUY/MaAUsv2ZHjg27M+6sWch/xOYnOUj9C/L/pYQC8j57bFZO/Dn/1SWP2cbFpNl6rSEjdVq8uqcIYPR/KEHNuU67JOMzfLFNssCNB4r7YeDqTL8KCzf9LD7zipR8Rg0yL6/mtSEGkZFlMcpsWC4Ldgdma5iC1NeggD7F4W5Xs1KV/yQw3D9NB3CEATpxzWxtQ2K6fpZiRP0n/N/aI59QprhKalGiwpNTUd5jd/ADmcv8MHd2g1t4XkjZ3ZqmQMrRiU2/W0MynBoJDU+ydd85bsX+GtJfaBkHA==
X-Microsoft-Antispam-PRVS: <DM5PR12MB17249D672BC97390B5AEC2DF837B0@DM5PR12MB1724.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM5PR12MB1724;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1724;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39860400002)(39380400002)(396003)(346002)(199004)(189003)(476003)(446003)(25786009)(316002)(11346002)(386003)(53546011)(46003)(76176011)(305945005)(58126008)(36756003)(31696002)(67846002)(229853002)(81166006)(81156014)(16526019)(4326008)(186003)(86362001)(39060400002)(68736007)(2906002)(47776003)(65806001)(8676002)(6246003)(65956001)(53936002)(5660300001)(50466002)(65826007)(8936002)(64126003)(72206003)(97736004)(106356001)(2616005)(105586002)(6666003)(230700001)(6116002)(486006)(6486002)(478600001)(59450400001)(7736002)(52396003)(2486003)(52116002)(52146003)(23676004)(1706002)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1724;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzI0OzIzOlU2SDRKaW9aeWlOdnhZT2tKZzQzSkZRaUcx?=
 =?utf-8?B?a0RqV1RCZmM5WUxudVhZcXYvM3loWnVTUFo3RHBNNXlndnkwYU9ZMGhXZG5p?=
 =?utf-8?B?REJmMm04Y3dOQ3crYXg0dTNZNzhWeWVZNHB6cW9aUFVaL3FkMDhWUythTlJG?=
 =?utf-8?B?NXNvY1U0VWozTVZBWHN5MmRUaERCd3VEVzBicjcwa3FFck42elFOS0d0ZTUx?=
 =?utf-8?B?RkcvSVp1VUhmYWdqYytSNTFlWklMWFBPSWgyOU1ZZ0JWYklVZnRLTGl4aEZI?=
 =?utf-8?B?S2ZmazhIRVU1WUEvOU9iQmdYWXdyR3lzdzZ6QlQ4VmRiRW1YM0p5Mi8xQzJ0?=
 =?utf-8?B?b3NSZUFkaFRsdmMyWEN4WFBDVnNTYmJNUWRvMjhXclN4dE1kb2lBVVlyeGpn?=
 =?utf-8?B?YVZUTzk0dDZ0YmtIeTF6elpQOTNaRFpTYVZ3akR5VVc1MTBGUWN5a0tNYWFo?=
 =?utf-8?B?YTV6RVU5YmZoRjBaTk9mdzFxZ2k5RGphM3NVeU9HTjdISS83Y3JYaHlnanNX?=
 =?utf-8?B?ZFhpTEdnc2JDVS9ZTHo2SlFQOVhLMzUvVFkzSXFwb2l2QjlKcmQrSFFTTzlm?=
 =?utf-8?B?QnpTclkxQ0cwRzlZS296bXpLV0d3OUZ0cEpUeXRBVzA2UXZHUEZ5OUN0VXUr?=
 =?utf-8?B?cWFxZU95YmVqMG9GREMyVjJFVDNxZHRjZnZjQmRMek5vTjdCLzhZN3krYVFD?=
 =?utf-8?B?M3FiSTJqa2cwNDhXbENMVk91ZVVTZTVyb2hQTGcrYUlQRFFKbFp0SlNnM29u?=
 =?utf-8?B?OWRZVDJwaXBKV0pWa2pBSUV3MXVFS1RsY2tjYm9KLzMvR3JNaXBXMXlPSW5a?=
 =?utf-8?B?K0tiV0ZjdFYwTTBKQTYzUEw1MHZFdnlzWW5xN0FwTnMvMmdZMUkwS2JNU2V3?=
 =?utf-8?B?Z3RDYnorZnVWcEsxZFJuNjZPRFlmTkw3VlhPZDhIRlkvcjh0RXJ4U0hqOUZl?=
 =?utf-8?B?N3d6SlhtNXNITHp5aGdydEt1V0RVRUdZVTRqRzZzODNYZUxLRmwwTVhGYVlh?=
 =?utf-8?B?ZThrWlJZc21JUmZJejVUUmhtaGpjTndMODlBaDFjUWZ4OVEvTkRPTm9NZzJR?=
 =?utf-8?B?djNmcE5jNUNZUzl3am0zOWdFTFNXQUlvd2U2dGxMYUlZcDdiYUMrTTdtOXMw?=
 =?utf-8?B?YTNHYXVLMUFseWFSN1kzaFA4SnhwRUJOR2hjM2ZURWZONE5oWHM3eUQ1QVRy?=
 =?utf-8?B?Q3pZLzdOd25qdkRrUU1EZUpaMW1XVHluTGx5YytPdjBUaEhXeG10RStINUsr?=
 =?utf-8?B?enZBeVlTVWhtNjBydmh2NDloWisvbHN1ZlRUdlNzNUFpcGE3Ly9RSWxaYzBP?=
 =?utf-8?B?bEdVc2h1UzNqZkN0YUZ6VExaQkRnSVVvN01pekc2cG82Q1RZazhXY2M0WTZJ?=
 =?utf-8?B?UlpKaTJvVUdDU21pYXYweGNoSFlKVTFmQnJURlJ1Z29KVHF6RW16TjdzOEh5?=
 =?utf-8?B?cDJPOUIxQXBqV2RVZUVldmxaQ1FFZW9XNHh1SUZ2S0dwY20vc3FZaXJhREN0?=
 =?utf-8?B?dUFTeHl5c3ppTVJCaHhFWStQd3NRdm9GWGdwdmJXWE5haTc0cE5pVm04VTZk?=
 =?utf-8?B?SlBYbVZlRllVT0p2Qms3SFEvU2NvdTZSQW5HaDh1QS9WdTNRUGx3bmNnc0Fj?=
 =?utf-8?B?ZlgzNEorOUs4emVYTDBXbXRSVFhDZjR0bHRuRk0xY1UwQmV2TldnSWVicllz?=
 =?utf-8?B?dVUvbjhGZE9VbkZHZXYvM2pKbE5qNXhvS1lNdGJGbGZhb3Q0ekZWSHJjWENZ?=
 =?utf-8?B?QUQ2ZTlteEhGa3NQb2p6Vm8zTFViem42ci9TUU95NWJKcGMrdHE3N3c4SG4y?=
 =?utf-8?B?eE9QMkE0NkhCSWJvaklja3k5SDdFbXVsbkM5YSszbEdXZG15aWlJL091OFNJ?=
 =?utf-8?B?emxyNy9WWmNsQ2lOT25kQi80WlN6SGNnOVJsWVpWSEFpZW5WZXQ0K0t1bHdB?=
 =?utf-8?B?N2dmbUlRQlVBPT0=?=
X-Microsoft-Antispam-Message-Info: 4pqQZh7dOLCqYQDNggUKPTMFd0u88WafITf5+YtiFJtDfWcFyavUQyMeXCcy6Y73J67IHeENO5bBLju/eRg/alq56Knm3pbUg3ebARyq+glW3LG/6L37GnhGjcql8Cyx8B28dLrJmSoRh4gnWRQ145zhlk8Vh+o8fwTuvAdq/kFtMzvzEJ1uxRu9BnZbkur7
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;6:FWOCcUMDmnd15HmXiea7WIURMtAgbiS/uLQGKajaHuGp2EIKFhrsvrgOiflo6eWccK3YGTanU2k4mSjy3U68e6MnSBRyiT4R3UHdeKn7sAz6sVW6nJYGRSVvaOiyDO7fFkEDNGgNDNulX1cPoyg13zV1CIM5MSHeSf7LOBpiF1KmWJNjcBDYpl9fm7+Fkm9rWvZrVVbWAVfknbblQ8yaidTWAzVTQNPWAUe+BeMz0QxF9To53FLYvne1buxIorjV5jNuRwBKsUo2gBSzEfQofAXkhOv8hekkaGhwqECbuvvR0WCWOX7YuGrPdoIUIj9PVTfiGPs1snY2cSUllcb7gP0QbFHQ1LZqpWlbRN0NwNMNlYi7dYDuiT8tlpVcr0oixDVC3nfya/EpxiFy9o/W5bD/HqDTM2+asyGqLmgVdO99YbeWnGCrtxjNg3Pv6N2WXIc96+HJarwMQMNiwU5/zA==;5:rr724qlmjSYpETwBn6vVuWpwS96mKcxxTCosNDzG8dyej1LIM9rt7FHkbCzF2Iuw7QowBKYOYgx0+axZTOeJa6QR5821t0SfieCfAkNLQDQ55VJRLLhneCfQg0UP5z8Vnxe//H2X9X7XtBjS9lWcoo36XAY4NGtDBrLKVqarrmg=;24:GPBN706JaZPHMOJTWLS9zthhdpgl0O+eJ/M8zJRqLiXPqs2d8wpgVGf5bDH4jv8qQsiBaI4KISBw15DrUX/fq8dtBL33wX9OUG7Qtkkb5XA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1724;7:kpATXeM6gQYIqxKFb+8oh4kbJ+NoYbHRT0Lqa2JR/5I+PqbrfwP8TbIKiRQrBKUnphRqUN3bc4Utpkmsp8XlBkz0TUlcK8sAaYvCdpqUNuyjSxqfTuNwYBMtpjY7TDwhmwd+9fbQ/SBzlWcvI6e+1Tm0x857OIKBDBdPpe+cyezj/YeczLWTez2UX4he+uwwi0BQ20sZfBVWt7M9PdkFv+uaD4vIpKwUFvFGnNg9uBUmd+iDU21KiXJRrAACLlV1;20:ne905UCHQGy8tve56Aj8oEUhWgXJ5LrCceqqfeJjeQZISE2T6K9h0E3HxbkoApgM7YYgSrOjvtG9bx09MIItTNixxBWO9Z5VXlTcVMoMTiId3MRANsPjzlLdC246LIhcG/eVmDmqqV2veqt8Ssxhfu077MzvEV2ORtyckM4i1ZVYQTX/eBCEGudHig0wxyCdDl/LmzK2k+5LnpFnF5gdfVe/62cZgNrqcnmdTMGvm94KkJJSEyWjKSyf0OP0g2rs
X-MS-Office365-Filtering-Correlation-Id: e542068d-a679-4ac6-2ad4-08d5cd0b4395
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 06:44:19.5268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e542068d-a679-4ac6-2ad4-08d5cd0b4395
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1724
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.06.2018 um 06:36 schrieb Souptick Joarder:
> On Sat, Jun 2, 2018 at 12:57 AM, Souptick Joarder <jrdr.linux@gmail.com> wrote:
>> Use new return type vm_fault_t for fault handler. For
>> now, this is just documenting that the function returns
>> a VM_FAULT value rather than an errno. Once all instances
>> are converted, vm_fault_t will become a distinct type.
>>
>> Ref-> commit 1c8f422059ae ("mm: change return type to vm_fault_t")
>>
>> Previously vm_insert_{mixed,pfn} returns err which driver
>> mapped into VM_FAULT_* type. The new function
>> vmf_insert_{mixed,pfn} will replace this inefficiency by
>> returning VM_FAULT_* type.
>>
>> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
>> ---
>> v2: Address christian's comment. Put reverse
>>      xmas tree order for variable declarations.
>>
>>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 45 ++++++++++++++++++++---------------------
>>   1 file changed, 22 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> index 8eba95b..9de8b4f 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
>> @@ -43,10 +43,11 @@
>>
>>   #define TTM_BO_VM_NUM_PREFAULT 16
>>
>> -static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>> +static vm_fault_t ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>                                  struct vm_fault *vmf)
>>   {
>> -       int ret = 0;
>> +       vm_fault_t ret = 0;
>> +       int err = 0;
>>
>>          if (likely(!bo->moving))
>>                  goto out_unlock;
>> @@ -77,9 +78,9 @@ static int ttm_bo_vm_fault_idle(struct ttm_buffer_object *bo,
>>          /*
>>           * Ordinary wait.
>>           */
>> -       ret = dma_fence_wait(bo->moving, true);
>> -       if (unlikely(ret != 0)) {
>> -               ret = (ret != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>> +       err = dma_fence_wait(bo->moving, true);
>> +       if (unlikely(err != 0)) {
>> +               ret = (err != -ERESTARTSYS) ? VM_FAULT_SIGBUS :
>>                          VM_FAULT_NOPAGE;
>>                  goto out_unlock;
>>          }
>> @@ -104,7 +105,7 @@ static unsigned long ttm_bo_io_mem_pfn(struct ttm_buffer_object *bo,
>>                  + page_offset;
>>   }
>>
>> -static int ttm_bo_vm_fault(struct vm_fault *vmf)
>> +static vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf)
>>   {
>>          struct vm_area_struct *vma = vmf->vma;
>>          struct ttm_buffer_object *bo = (struct ttm_buffer_object *)
>> @@ -115,8 +116,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>          unsigned long pfn;
>>          struct ttm_tt *ttm = NULL;
>>          struct page *page;
>> -       int ret;
>> +       int err;
>>          int i;
>> +       vm_fault_t ret = VM_FAULT_NOPAGE;
>>          unsigned long address = vmf->address;
>>          struct ttm_mem_type_manager *man =
>>                  &bdev->man[bo->mem.mem_type];
>> @@ -128,9 +130,9 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>           * for reserve, and if it fails, retry the fault after waiting
>>           * for the buffer to become unreserved.
>>           */
>> -       ret = ttm_bo_reserve(bo, true, true, NULL);
>> -       if (unlikely(ret != 0)) {
>> -               if (ret != -EBUSY)
>> +       err = ttm_bo_reserve(bo, true, true, NULL);
>> +       if (unlikely(err != 0)) {
>> +               if (err != -EBUSY)
>>                          return VM_FAULT_NOPAGE;
>>
>>                  if (vmf->flags & FAULT_FLAG_ALLOW_RETRY) {
>> @@ -162,8 +164,8 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>          }
>>
>>          if (bdev->driver->fault_reserve_notify) {
>> -               ret = bdev->driver->fault_reserve_notify(bo);
>> -               switch (ret) {
>> +               err = bdev->driver->fault_reserve_notify(bo);
>> +               switch (err) {
>>                  case 0:
>>                          break;
>>                  case -EBUSY:
>> @@ -191,13 +193,13 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>                  goto out_unlock;
>>          }
>>
>> -       ret = ttm_mem_io_lock(man, true);
>> -       if (unlikely(ret != 0)) {
>> +       err = ttm_mem_io_lock(man, true);
>> +       if (unlikely(err != 0)) {
>>                  ret = VM_FAULT_NOPAGE;
>>                  goto out_unlock;
>>          }
>> -       ret = ttm_mem_io_reserve_vm(bo);
>> -       if (unlikely(ret != 0)) {
>> +       err = ttm_mem_io_reserve_vm(bo);
>> +       if (unlikely(err != 0)) {
>>                  ret = VM_FAULT_SIGBUS;
>>                  goto out_io_unlock;
>>          }
>> @@ -265,23 +267,20 @@ static int ttm_bo_vm_fault(struct vm_fault *vmf)
>>                  }
>>
>>                  if (vma->vm_flags & VM_MIXEDMAP)
>> -                       ret = vm_insert_mixed(&cvma, address,
>> +                       ret = vmf_insert_mixed(&cvma, address,
>>                                          __pfn_to_pfn_t(pfn, PFN_DEV));
>>                  else
>> -                       ret = vm_insert_pfn(&cvma, address, pfn);
>> +                       ret = vmf_insert_pfn(&cvma, address, pfn);
>>
>>                  /*
>>                   * Somebody beat us to this PTE or prefaulting to
>>                   * an already populated PTE, or prefaulting error.
>>                   */
>>
>> -               if (unlikely((ret == -EBUSY) || (ret != 0 && i > 0)))
>> +               if (unlikely((ret == VM_FAULT_NOPAGE && i > 0)))
>>                          break;
>> -               else if (unlikely(ret != 0)) {
>> -                       ret =
>> -                           (ret == -ENOMEM) ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
>> +               else if (unlikely(ret & VM_FAULT_ERROR))
>>                          goto out_io_unlock;
>> -               }
>>
>>                  address += PAGE_SIZE;
>>                  if (unlikely(++page_offset >= page_last))
>> --
>> 1.9.1
>>
> If no further comment, we would like get this patch in 4.18 / 4.18-rc-x.
The patch looks good to me and I will pick it up for the next TTM pull 
request. I don't think it will make it into 4.18-rc-1, but 4.18-rc-x 
sounds realistic.

Christian.
