Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932581AbeCEWJk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:09:40 -0500
Received: from mail-co1nam03on0078.outbound.protection.outlook.com ([104.47.40.78]:57037
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752063AbeCEWJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:09:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 7/7] x86/microcode: Synchronize late microcode loading
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-8-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <c8a59153-8ec3-a236-2def-8d3974c3807c@amd.com>
Date: Mon, 5 Mar 2018 16:09:31 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228102846.13447-8-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR04CA0060.namprd04.prod.outlook.com (10.171.243.153) To
 BN6PR12MB1140.namprd12.prod.outlook.com (10.168.226.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d2c6fb3-5ebb-4c21-548b-08d582e5c8aa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1140;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;3:q3m49MBI8nkIwAiUVnThhx4z//OUKhgloegndovfZMNoEvhOaSBn+3vcORg5TIhZMgr1dT3GziUGhtmXAjbw1Vxtjn+5KwnCgX8fcBsNuOAiqMvOFtbNBtjWfwrkN39KCVk/c5jjwOdZeJDKCGt2fAQtVoxVoJ6rcXvBghmlHvCPlENnJ6VCn3Ozj5qmgnYC+6ryFYkY3RnpKWuwGypCLVrxh/+p/Rhn44mzqwCZFw/T0l/FcuGl+KgRGUpb8qZX;25:rL5mv8938+SV3KprKpwjyF91JkiGHkD0a/4Fm2MjPUs42d9fx0rcIhw6dLF4Rhxlv+muALsVk89RS9rI6qvULN8/4wcl3yqqqSH3oFNhfvRL75zz20XTV/LLGGy/hBbml3fB5BEuSV1jjXItFqmmN/ICDWdEO8RYux0OfCPqxhg9FQFc0QCAqJCsbF5bGvkMy460xk1HsOaiwRhqvFwVTtub6tecTdqTUdaKQwY+cqIVZoZbzPvD8CoKJf14ug3u4POVFvr5xyntWP/cFdEQi8TM5Prmk37AgIM6zMJcPXj17ltp1fNTEq0te1RQOY2ZewrpCR4kR8x/lhyli8noVw==;31:VogaKvPakPJk4lTGbaIwrktYc1oNl4xWfeMHhE+73VhG6Qvq9Lk4Z51wuhbvYHKIffq7+j9WzB5xiNxxIclFCPm2esKEy+KdGueZumpm8v/HDrxTbAeh+Aq+MxRHGYafbXETjU5r1xyYbHbCrK07khIpaafslp8uAKaGh5rWQcmYPW7mGYB/1Q7WIMHpa2FmzMeqFjIfEIrp+Hn8YDWCYMSWSeYHFwEP5m8vLf6FLw0=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1140:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;20:Wdy3Szx50l6tDaE5UBTFK2atiRTwvXytO6a70KaXwff29bjFkxreqEQr5UjjKNQ7gYJzV9nf6bXAQ0epU5g09UEekUVcZd3Pq/y75P7SzRvTK26xXTQU38Ht7o6P4Aut5drR3InBoWoUydIl7xPzkBJRIKIF2KC2XPc+kPe8zJZOECURiuu12K7vP8t5c6OwxpwljszkuVZ/LczXlszqyYDroL6Uvzk4jGHCoeu9BVxbzDUyhpCki6j1LMCUl6rJQDkTHE7D0TT+g5F44y1synBoxzgdFiiqVl/cJIoypfb2/JW5WVgAWQmyh5g4Gk9S+k99w0kSLLwn7u5ZANtuqC8KeBDYGPmY0HPGtXIfaauSgDffw7pRnaAw5kZNlLHttVXECsNieKJucHfR4/nbSW5aVYKBwO5eLZrVeyosZJKQnlL4QAxVyNTIrL0eOMBj8b66Nzauqa4fqoaH+fPGzQJOMuSwGyFmofy9eQ5pg1YljcG8WcR46gqpn3VWdnJW;4:tXxJkgSgWgUrfyA1V+ml2qCVBHhrWZa+110tNNst4cEB0WNCJzqGLkyUd6+sB4YIuCdhycnjMkSEqwMA+kcXjvvYyvkmap9RP6iBQv+/eDAlk6BnHNTusrZMS3FWUPaqDbHUpHypP4KnIXjVY1/5Nx6OYGOArdySyxbNROV88/pVWEsujJYFRKlHOKvw7bk8RGebvth27wVG5HkCR689UunbaGqPi2/ovGSHE1gzllfywYRNz3iLZfgGPfm2MrGtL38Mrs/Odgmb+L7bP30A1Bi2sJhdn+mO2nFpSE193qLmI9gkxeAZ9tk9irszg8M9UT0lj6MFv91zEOmWyHHTmw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1140E46607B11BAFA318D844ECDA0@BN6PR12MB1140.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1140;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1140;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(6049001)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(8676002)(6666003)(81166006)(81156014)(8936002)(16526019)(186003)(52146003)(53936002)(23676004)(6246003)(52116002)(2486003)(76176011)(106356001)(65826007)(68736007)(36756003)(105586002)(229853002)(72206003)(31696002)(2950100002)(305945005)(59450400001)(2906002)(478600001)(7736002)(77096007)(90366009)(6486002)(316002)(53546011)(66066001)(47776003)(65806001)(65956001)(386003)(31686004)(26005)(97736004)(58126008)(54906003)(16576012)(4326008)(110136005)(230700001)(25786009)(3260700006)(64126003)(6116002)(5660300001)(3846002)(86362001)(50466002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1140;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTQwOzIzOnRNQzRNNldQcERuNTFGRHp0MW1YUDd0a1BN?=
 =?utf-8?B?SWJRQUN0bDRMZ2RXQ28wVU9OZXRtckcvVzJiN3pPS2RQbmNiblg4VGpPTitp?=
 =?utf-8?B?aW1IajJXc0tPTTNEUVZId0MxS1BXZnVuSTZyTVBYbVkvNjVkdDJlTEszWVRU?=
 =?utf-8?B?TDROVk4vOUtlQzR4NHBQbS9NRUhYdXdVN2hJcVRBOXNrMC9TWEJpUVJjeWJC?=
 =?utf-8?B?Z2NTZ3N2akUvODI3N3EwOGxMcUNBZUxDQ0xiWHE5UWcyT2Z0ckx3RklDYmFQ?=
 =?utf-8?B?MEN6NElqd3BORVR1N29RdEJpVFdkTnB0MXV3ZWlWUzRsMXNUeXZ3VW54NFo5?=
 =?utf-8?B?TitiUWNRZ09KT1lKL2dXM3Mya29qazlMTXNaMGo4cVhoZWdPeWhXMU1xRDhG?=
 =?utf-8?B?SVNyTlZYdGlINkdsS0lTMHA5UEM0MlNGcjYwTHA3WkRjK0duVTRXMDVrMXp2?=
 =?utf-8?B?UDJsSGdHV0F3NjQyYXgxSnlseDdCUE1jdndsZEY1eUJiYlc4U0tqVjJHSUJC?=
 =?utf-8?B?UzltWWpLQkltMFk5NVQ3eTZYU0JzNTZHNE9aTk9vc0MxOUl0ZlVxV0RSOStQ?=
 =?utf-8?B?YXQzbm9yNFMyQzhaRFMvV1ZIOHFMZCtzSVlTV3RZVlQzRklua2xHLzFQdUFi?=
 =?utf-8?B?b2VNVlZXZ1JRUTdiV0JHMGUwcHVuQ1lkalhFa1hjbjBPMjZDVzJ0Z29DLzcw?=
 =?utf-8?B?SE1vTzFMaERuYU5XQXpRT2M2WkIvU2VPQ0JLVHVoNHNMUEpqREQxVGVQRm1x?=
 =?utf-8?B?M1VlUUtWUHkreENrbGNqZkhRS0tFZmt3ditNVXBxOXBvL1kzTGtTK1hIaUg1?=
 =?utf-8?B?VEVqckozVjZFYWdLVmxSUXhBVnRiVGpVOXV6VGhCMGZJYUVOT1FBVEgwZ2RB?=
 =?utf-8?B?OEhJTXNRL2JNeHRGZldicG1hTWczSGEwdEJQeVNIamtPRjBpa01rNlBVNFZ1?=
 =?utf-8?B?aWROUmpKVmVYU1cwUlhGVWx4dWRGdXNYdkVaamo2empvUlVud1hzWk9CQVZv?=
 =?utf-8?B?RFUvUURTV3hxV1plZmxGbGxpS01pUlhnZnRrRDlHL0lRRnBYdmNXSmJITnBJ?=
 =?utf-8?B?eDZuS1VTTHNycG1LQjBWY3pyT2RJcDJIdW51eTJlOCtWT2picDJZYmU2cHRG?=
 =?utf-8?B?VHNEdzFxc2szWEJrREhNYytDRkhzaGRub1Z2YTJmK0hUc1FwWmU2Q0krY3Zk?=
 =?utf-8?B?TXN3cmNLODFQajhtc0l1NUU1azVWeUpUVlJWRDdXcU1tVk1aMEVCcnJmcXVI?=
 =?utf-8?B?V2JYNzZLUWFWYzJDd1hZN3liYWV2RVZhb3JhU3MrZVM2aTZyT3gxdTBzdCt5?=
 =?utf-8?B?U09NWWM2cXBFMGhqcWlZU1cvNDJDbWFSeENlM0c4VzZlWEVNSHY1UU5KVXI2?=
 =?utf-8?B?emRhVm1vWUExQ1RrRWQ0ZFRxVkIwSGlKSnBOV1A0NG1qckU5WWd3aUJkeVUz?=
 =?utf-8?B?VmY5bGVBV3Y5c211bTQzeTJweXNBdmw4U0hWMmoxSWNlSVhLZTBBQkRxUWhL?=
 =?utf-8?B?UC9nVnliYlhmbldaZWloUTdZWjZpYk93a1k4dlRWbk5XWitIKzF6K05CQlJq?=
 =?utf-8?B?RHdqRC9XSVl3OGdhUFJDZytLV1VzMXBZWVc3NUtOc29LMENpdEpLUW5TMFJx?=
 =?utf-8?B?Vi9CMXUwZlNjeXdWNitrNFYyL09lUGlrdDFDRGs5TUlBa1NwTTNTSi9BK1RX?=
 =?utf-8?B?VTMwdDRqL1pBRVV6engyUk1LRDZwbFBiUkdxRmVJTFR6ZTUwT0FiUUdxbklw?=
 =?utf-8?B?NEcxRUZ2ekpmT0YvRkhWM05RWnhWZ0JZWTlSRFpGS0EydWFGUmdJa2FIWk5G?=
 =?utf-8?B?SXV5bWFqLzlNQnVpVElua3R0U1Q5ME5XWVVUaUduN1dMRi9ETGRZY01HYmVl?=
 =?utf-8?B?UXRIMWZZS0VHc2tQMUdvaWhOVlFDWFVKOUNMR3NnVVZVT3pZQkIzdnRaNlBK?=
 =?utf-8?B?bWY0VWpIRG0yRWNkcytOcTJ0dXFYRHk0ZFduaW1pVE9ORE8ydEZJb0JoMklN?=
 =?utf-8?B?WEdCSFVLUmNPbDN4U3U4ZlNuMlF5N1BQeVpMYXV4N29xRHdTRWFnVEhLaVV0?=
 =?utf-8?B?bTVMNkdyY096U1I4WUVER2hmOU5MVko5d2djNVFRMm9pbkM0QTA5UGRXWWpv?=
 =?utf-8?B?cHc9PQ==?=
X-Microsoft-Antispam-Message-Info: BVl8DNsSZFSSQ/+AYq+MGO7tXBfs1vnPr7dvuI9jbwOkhh2aipPzwxjSYcyTPX+xDqLl+pLua1thLxb9m4cFPhtl74iNTrmEy/1ymCgR7e/CPUW4BZtuT5+BMzIia5DybGPBeOI5RAGmbFZE2lHjzlMJO7oD45IEOk8Y9jf97ek3ylR8r726tFES2+ldAJAI
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;6:RZ5tTaDjp7q54LBUQ7DoQo9r5P+Bgx5Xa5hDhpRr/2zNMH7MQ7q/JObpNbmmxRjSjxUsyF1dCFET+YWmU/FBnbZ0VgxbdmMpdKCbVdud6ENZQgtdvokBjRy6N5nIj8NDIvj+vaCNpudDrycqmeHq5GrFf2GSUCfjVZf2xhfcDZamc/AFRj5QfXfGT7orRCtIZkN8Y0yIu+8CygMy6RaeUsqDCQgB3BGFce5sdlkKnJ+gkY7+5exhbeNgCTkZ4oipzeqayjOWyo8V0kB02ZvcrdNrFyaBGIN/Uz2dgGKtDulrg5ZS6qNAe8mTDBXP2xumlyvl61wPs9aIlhjlDn/E5e6aK1MKCd7R8E/EmvW0Rmk=;5:Fc5DH94VN1IdsEsdAN78i9sf5W8VXREuB87qDuhYjxYqSxwt+OAnLCDqQme05g7+rXnZPNvHrLX5E1+YxnYt70MuGs9UwXFhqKpgEmH6CHO3fSv1S7JEWg7p3feKzl4qQGdh5Sc/yDP5oaPJ75QAtV76saAliV70iUiu5OF0HBM=;24:j72UH/BAiHMTZfmYzXTQLgP1GFTBRCYuw+GJbbPC4tky7mK0kEn6IJMHkACC1HSzrliyDlMRl8cg7+WsAkB6J3MILdoV4p7RzGfsa+Zvusk=;7:VqgIsrf4hslWRPee1CTq/G+It6cQqS6NCi4J4fDDTNTBG3ODFbu073+fKDHkcSE1uh8kU6kYouApiomKUWp/UTpyNEPNLTOiusQSf2hOlEJ403S+qcE92TdwzzPAlUDA8baQBMb1ced1jkQ0HU8bfzI5ENzyRNoqAI0Qu0TUtuQuwPT3GnENLy724yCZJUBKbWg8REMP3hg26K5x+G246UCqECBKIohKvP50wbyMhgwajIO/tyquJMxZaCcCaOkf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1140;20:TBQjyVOil5yqEGze3SGGuOcuz8UbRhq2dG45ntlndETqqu/700sLD3c0lfFletJhlwJ2g8ULhUBVLOdeGZA5qsv3m9J6v5vuPazbrwjoMH7KLRv9tvg41zjDfBsENTu/LXLxumYs7+al2JqKFtTbdQeasnHhEN0zkTdF8ls6pw4lKVsjlk79ipv17K5Y8NaYq7Ynt8YK6IWcWjhXqO34gYy2cl8S+U7bm4xUHrCcjQD1uXEMM7gNUk0T6e60Qa0d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 22:09:36.1802 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d2c6fb3-5ebb-4c21-548b-08d582e5c8aa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1140
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 4:28 AM, Borislav Petkov wrote:
> From: Ashok Raj <ashok.raj@intel.com>
> 
> Original idea by Ashok, completely rewritten by Borislav.
> 
> Before you read any further: the early loading method is still the
> preferred one and you should always do that. The following patch is
> improving the late loading mechanism for long running jobs and cloud use
> cases.
> 
> Gather all cores and serialize the microcode update on them by doing it
> one-by-one to make the late update process as reliable as possible and
> avoid potential issues caused by the microcode update.
> 
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> [Rewrite completely. ]
> Co-developed-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 118 +++++++++++++++++++++++++++--------
>  1 file changed, 92 insertions(+), 26 deletions(-)
> 

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
