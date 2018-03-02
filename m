Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935091AbeCBXtU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 18:49:20 -0500
Received: from mail-by2nam01on0082.outbound.protection.outlook.com ([104.47.34.82]:20544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934783AbeCBXtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 18:49:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH 2/3] crypto: ccp - return an actual key size from RSA
 max_size callback
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>, Gary Hook <gary.hook@amd.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <51c265e4-6153-3e5e-316a-ebef059ac36a@maciej.szmigiero.name>
 <20180302164451.GJ21579@gondor.apana.org.au>
 <087e7b27-f839-8d4b-8da8-5d0fa2f8caf1@maciej.szmigiero.name>
From: "Hook, Gary" <ghook@amd.com>
Message-ID: <bcf42353-4b07-a14a-e76f-6c520b7b0ba1@amd.com>
Date: Fri, 2 Mar 2018 17:49:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <087e7b27-f839-8d4b-8da8-5d0fa2f8caf1@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: BN6PR14CA0032.namprd14.prod.outlook.com (10.171.172.146) To
 CY1PR12MB0697.namprd12.prod.outlook.com (10.163.238.158)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 047f75ba-3eb9-438e-0aa0-08d5809833b1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR12MB0697;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;3:Ou1EVoh1eDHBowXgS/auI2tLjXvmgcZOaQZ1SD+Ss39HG6fJKBDeahHHVu1E+cEHnDcUbfpBJFdeaAYl5S9JEQulwOb+T61bZoV/9+jIkMWxsZzVrthWlMXF/4f8LKeRTc90G5gYZTt1XwPKNiHKO4UtZuoerD+Y4Ial3yUw5emEbjNk7g7mpiCyHYfWQCLy6R/pWOwqokRM7EFicOoY9AXEbd1RiqXGeY4doX7nRuOP55TjDbD85sD50vt6tBNj;25:Wz6vULdUW9TC3SYAbk9EBefhojH+altJSBorkJapHKy7eH6CmClMhAnTkJPSpaJqPo01bPdXaM4JcK/VgI6gmQakdRSMInSQd4yU1MZr+wNYO9Um6IHJ5M79PyaZCnT0++Ymz7j1SOTRUdR8LTP1LivgGh5+qe2zgDA9SOI/AzWF8sIdVtf5VT/EVYqgNldtZaE77JXYtEw4LAD3tVnzeCotiptY9Zr3f/G08h105WytxsguxFjxw+bBSFWZSjV93yB6U6kIB8C57z8ZZb7f7EC8KcL7USj6jxmnIyIX6tvLsWsx6svIcB8xi83vBHByPABQqvtQOD3XN8aSkV8W6Q==;31:zw7O1I8IyUtyhToCGDU3TH+TlKGdBJlGWKQEoy4DQZpinJm8Gdllq5cW6YVfyUszP1yb4EZYSFavOrXxnnfRrzQGHDcf0PhdsX1iy45OoWOuWUq4ExxIPq3Rl7YQUqSTPkkS05OFGVaCUt2F27Fv5dV1e2ZgTyhrIi9KmmjYVjlx7j+9PuCtB55ZzFwnHC12OJLEoFFa65vSJVaN3JZSZqlMPo4IuULHNQlpBfn1+S0=
X-MS-TrafficTypeDiagnostic: CY1PR12MB0697:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;20:Vjv7Jw5D7UZY7qSwp87jXuxY2KooZUXvfOA1Dfxa3Z7F7kJx4XD2MIbyziqMH3C75aGUwmDiX5zEnLyBzJGGu4eejUWAoCU84/alCQejAjpfYjlFFY3Brz84YsTj9eoLtNq11OeokuXE95+8iiKa2RCquLYv11af0bba8JTPCoHglUDu6e0IoLEczDUGVnxx67zrPjFlvarKdO7hrDfXZFyjOqlgThZZCQ6HaMd9hxdzcEqetLCauIscxog9cVCOda/7bVZ7fcpwoxbkcNFq3SpH74WPHfAQokVxyNj3oN7oE5sqr+K00c3myakW0Ei0xfrLrFjKSXSeEhhJmuxYrAdh2H8chcR2gt+pn3koAYmRKyRozAfXjuohJgPkLHMWhc8cxTqbU6+PtKfNNOTs+tyaSgDyEJTUn2uM5lf6s4yl2LdUZDYrovy9dCEgNPFyJCEGEnCseGRBULqywDwM0CqlsAdP4BAFqwhNOzjJzVh8CYXDduFteKsd2vXtLVMO;4:weXeg3qXQmZmHlHbxLhP6OfkfLPtXINKNn+XS7KgsCxLdNYOjRIdxRDdELuwlOz5W8iqgiw8e6VX21Rq3ML2h1UYqCd7un6DW3rBLT9SlgyGpfzQTQE+LpAC0F1oSyGuglgm3/LucNKvSZjBBu0MEQTttbc1IE9QWkObNVYJB8s34oYld3czUDYSgaKGM/pB0jibNCn9fQB2azz1T4sh1FF8z9ZYdQQ3hoqvdUp/bBPicO+QYa0sPfw3Fn+1Pjy3BjKSNhjE4ZsOWIxHhedPv9OO0vJY3OZEPAW+TcPuoZx3piqDLAxdj1tBDqgjsOw8
X-Microsoft-Antispam-PRVS: <CY1PR12MB0697F6AC71759720492A1FC4FDC50@CY1PR12MB0697.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY1PR12MB0697;BCL:0;PCL:0;RULEID:;SRVR:CY1PR12MB0697;
X-Forefront-PRVS: 05991796DF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(39380400002)(366004)(376002)(346002)(189003)(199004)(97736004)(230700001)(68736007)(36756003)(76176011)(316002)(16576012)(105586002)(58126008)(59450400001)(54906003)(7736002)(110136005)(31686004)(5660300001)(52116002)(575784001)(1250700005)(305945005)(6246003)(8936002)(26005)(6306002)(50466002)(64126003)(6666003)(77096007)(65806001)(52146003)(66066001)(90366009)(53936002)(2950100002)(4326008)(2486003)(53546011)(65956001)(25786009)(3260700006)(3846002)(6116002)(81156014)(47776003)(386003)(31696002)(106356001)(72206003)(966005)(6486002)(229853002)(65826007)(186003)(16526019)(8676002)(2906002)(67846002)(478600001)(81166006)(23676004)(473944003)(6606295002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR12MB0697;H:[10.236.18.126];FPR:;SPF:None;PTR:InfoNoRecords;MX:3;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjEyTUIwNjk3OzIzOml5aUg3QzdFZUN2Ky9ZVWRZK1d0cWpiVXRK?=
 =?utf-8?B?MzNSc2wvdFZrbjJXdHpaUWgrVGVGWHM5K0dSQzkxa0VPN3pDTEQ2MnJhYVBR?=
 =?utf-8?B?M1F5S2NMWWxJM2pCZXNpc1FqM0tXdVMydHNyZHlFU1p5aytLc0VyZ2RiOWxs?=
 =?utf-8?B?WEFoZXVsaTg3ZVMrZ3RoeDRBczg1eWhhYk1nTS8zYkR5ejdFMHpOaUQwMk9y?=
 =?utf-8?B?RzNFdmNsSUxYZC9LM21JUWIxMVM0TENKT1VIV3pDK2JVQzlRQjdTV055TWZK?=
 =?utf-8?B?OXFTQzVuc3cwdXIwSHprWTdRbGZGSFFUQVZES1A0d2tOWWdjTVhFQW1NN29K?=
 =?utf-8?B?RVB0YXUwd0hSYVN2WmU3TTd4TEpPZHF5Y2NFWmt5c2NrRDlZWGI0VVFjUklq?=
 =?utf-8?B?WisvN2M5SUhmaDdhRzFKdW9HYXRUWmIwSjB3SzE3UE5sK3g3QW9YbWFEaHpl?=
 =?utf-8?B?cURaRUh6OHFGVVF2bEozUGw4aGdQSTlpWWV4Ukk3K3BwZStVYVByNndFSXR5?=
 =?utf-8?B?dHBSeDR2VTJocFo3Y1l1WVdEVEIzaUw1OWRBMkV2NWJvVTgrOEpBN255Umc4?=
 =?utf-8?B?MThEYzRPWmFrNkdFdkM0YzhlRnVObCtjWUU4dmQ5Uyt3SUpGdVBJaUJIa28w?=
 =?utf-8?B?UzgvbDFROWJXUHhzOGNrclBXbU9WTGMvYXpKalVHdUhPN0taL2JzcE5qTVJL?=
 =?utf-8?B?T2Z3WHQwQ2RsREpDdUlCaVRGZGJQNnAxU0FKMGlQNXNkR0J0ZHBDb1NrRGVw?=
 =?utf-8?B?eVpkOGV0cGE1cUhyV2oxaGtqbVNQejhzWS9IZkcybUU1Q2RDY0ZUZjUwWDEy?=
 =?utf-8?B?dVhVVEZybVd6dFVmSUhNNkc0M2ozdWdXQWpNanRXczE1TUMxSlZ3SFBvaTlY?=
 =?utf-8?B?M2hHb25mOC9aVFAvWmJ1MUlmUUVzTCtPR252WS9IYS9xakgyMVlBUGpnVlky?=
 =?utf-8?B?ZWFxckdYa1paY3VvRkpoY08zUjFvaWNDTU5WMzU1TFRNdHlKVTdUalFEYmdU?=
 =?utf-8?B?eWpxdkh0blA5MXVmVUhRUjlqQ1B0T3ZpMm93R2hxUXRzRFI4SWdPRkdDRito?=
 =?utf-8?B?a1g1QlZ3bXF3TlJ3YWs1NVdUMlJydHFJMlZCWE05TGd1YWN5Nm9XNDVkVjdN?=
 =?utf-8?B?MWZ0Wjl3M1EzZ2ZKenRTQXptelBlRVdtTmVMYUd5L0RyaWhKT0I5M2hlVDFx?=
 =?utf-8?B?ZnI5RnBWOTViVkg2blNjL2R5S3hONG10L21LMnlxbUJoYkxFWmw5UVUwYU5L?=
 =?utf-8?B?WEllWjJ3ZDJjY1pKeE9iWXdYMzBkOWJPMWtYcmhZKzQxYWNPUEkrYm5tdDFz?=
 =?utf-8?B?MEgxakRvcjZ6MFZtY2FjNHRsbDUwNmsxZlpPVVV1dDhUanIvamloTnh6ZWdx?=
 =?utf-8?B?R0xROVNMUjBiNFNIYmF2d1NadE5INGtVd3o0U2l6ZUNKZkVrR1NrczJNRHFM?=
 =?utf-8?B?QUlmUyt3RElyU01zOWhTYm0rMlYveG83WHd3K2tCU3ZQN0RJa2VWKzhHZGJ3?=
 =?utf-8?B?bUtFc0FsazdoS3RaV1RyU3ZMdXhha3FsVlR5cWgrUFR5NTUrcWtjakl3Zysx?=
 =?utf-8?B?WGFkazZqaklweUJjdW1JSVhnLyt5K3pBd2FxY1l2dnpmSktzZ0tuTXdrc1ZG?=
 =?utf-8?B?SElrb1ZXSHpzZG9IVytGc0NtdlYyYkpIOThaV2V5eEpNK0tvSkNBVW9ITzRj?=
 =?utf-8?B?cjg5U1NOdDF1L0NCaC85ZjY4OXNTdUlUbTA3RG96VkhVOGZPVjBCUUUrWU05?=
 =?utf-8?B?YmIxMkppSkkrWTVucThQdmptSmJiT09DTTJiQ3FUM040NUdTbUhvYzludnFT?=
 =?utf-8?B?VkNsODZlN3ZQeC9mN3lYNFg4b2FjRVZJSFNHZmdBMDBpZ0lOaFRhcC9nak9N?=
 =?utf-8?B?Z2tGVkk5RC85a1J0SllKdUZ4MkJhbkR6VWpkWDE2SWZ3ME4vTW9pWnFxdkpK?=
 =?utf-8?B?cm0rM3VvZURmK1lFL0FMV0J1anFsckh2a1BraWkwNFJsYXQ2SHJ4Ni91STd1?=
 =?utf-8?B?c1VqcUx0ZUd0YnVDd1dmWlpKVE12eVBleTVIbFN4SnNhSHJ4QkpOTTlWNEFL?=
 =?utf-8?B?b0xHSjdxODUya3JPQU1nNzlMOUZSbVBNc25qcG1USWx4ZHVjaXhPMHkvL3Jt?=
 =?utf-8?Q?wTdLncT7LBIMwVUayDhznE5mYt+IHxmqmzyd5QeoLf35?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;6:ESD2vYK3X4o2olfO1tQHL1UOSr4yVBvdvGa0sv8Kyv9rbebrjw4fRO0DU2H47z4e1RCG0RyFMC7TPGYZyqMfR7M/AP4HTr3+tvpAlfQdBK4J7TUCCkAhBqAcMcqFgD8pvzDMDc7laHByIX3d8WUxtQHh3chny5zA6eGVgnfEeVdEMIIBtQSyNkq6snFOLdNxjvAjGECcSBx8MXG/d2e32Oa6eUykYZHPEvsML1a/dsoCVCmK04pHUG3tTIGz05uqQILAnN6+9v0CIQKXF1KTYKlVhS0qYX8WSJC7AYyc3GAg56OL0av3rl3TD0KsHUmHzEioTlJIZ3H79wL72KPLauhiwxTHGqI89Q7MZ2WT5I0=;5:M9BMoAfLIlK1nxpnpoBi9ehVFhy/tnuD2+bZ4vCcxMhoaPAWYizvTu4wNWwXJM6EJ3ntwA2VLvlX58fn8hyO9n/KFQbpw3DtxmK6j4eAx4RY3uXp8GChYirVZ0v1n6V11YHlzt59uj9lscjGM4H5Syw0NqwYGtJrSlSj5ZtLUJE=;24:R4A8+WMORV4U4GO6ss0abyKe3QU1EGauugFQs3+3/8tQU/4gONqcF0X2lu+i+Bg00PYN5YY/5ERuNHyL34nFf0H9ZPWPfa5jP5TnGw2tB/w=;7:VnodOiZSwjYoxs5BJ1TDqdNHLp9Hi/bgjcJjdEymvfkELzM2MCbdElLLcS1Rs5Bom0XI9Hdfe0uXQV2lISwIuw1ff7PzVA4/RXcV9vNnEQpLEA66qIYFeV22J8tK+nJqoso7lVsltNXtcxbmI/qEaunhGNs88HPufMnnXfX2mVyi2Yu0Pq0ulJZjRKGtiRZ1zALQlwpiLe9zZLstas6AiFfi1fGne9my86fQNWfZi2bqrBR411pHnHuYAwcHi32m
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR12MB0697;20:4Zt7sU4OdR+rlfZrhaWlxGg5TRDLjjOIY3jhUSwSUveA4HuYrJmHK8tUgM1StCD/w76czekhUt29iEHZMMpDnyXv08031NHiPyDYmC40vLof7X2HGofufazIzRtSXrg1KPNrzyGrZkRnVWDpspglx/AgSJfsEarn/y/5UCHC32KFQglOxTqchvJSHtsxldFcE7AEW9dn4+misw//u9T9mCBqZJmqCoQtu3dbKHtpi07qa2AIwxWPFB591UmwdNbU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2018 23:49:12.2636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 047f75ba-3eb9-438e-0aa0-08d5809833b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB0697
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/2018 5:15 PM, Maciej S. Szmigiero wrote:
> On 02.03.2018 17:44, Herbert Xu wrote:
>> On Sat, Feb 24, 2018 at 05:03:21PM +0100, Maciej S. Szmigiero wrote:
>>> rsa-pkcs1pad uses a value returned from a RSA implementation max_size
>>> callback as a size of an input buffer passed to the RSA implementation for
>>> encrypt and sign operations.
>>>
>>> CCP RSA implementation uses a hardware input buffer which size depends only
>>> on the current RSA key length, so it should return this key length in
>>> the max_size callback, too.
>>> This also matches what the kernel software RSA implementation does.
>>>
>>> Previously, the value returned from this callback was always the maximum
>>> RSA key size the CCP hardware supports.
>>> This resulted in this huge buffer being passed by rsa-pkcs1pad to CCP even
>>> for smaller key sizes and then in a buffer overflow when ccp_run_rsa_cmd()
>>> tried to copy this large input buffer into a RSA key length-sized hardware
>>> input buffer.
>>>
>>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>>> Fixes: ceeec0afd684 ("crypto: ccp - Add support for RSA on the CCP")
>>> Cc: stable@vger.kernel.org
>>
>> Patch applied.  Thanks.
> 
> Thanks.
> 
> However, what about the first patch from this series?
> Without it, while it no longer should cause a buffer overflow, in-kernel
> X.509 certificate verification will still fail with CCP driver loaded
> (since CCP RSA implementation has a higher priority than the software
> RSA implementation).
> 
> Maciej
> 


I commented on that one here:
https://marc.info/?l=linux-crypto-vger&m=151986452422791&w=2

Effectively a NACK. We are a reviewing a proposed patch right now.
