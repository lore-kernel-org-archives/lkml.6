Return-Path: <Gary.Hook@amd.com>
X-Google-Smtp-Source: AH8x224a5R9fZQfgTYit4BZBaFI3EPDLL2tuEGNGx+BrEZbqoFWKQjdjWw67iS/Iz8NdbzrTsX8Y
ARC-Seal: i=1; a=rsa-sha256; t=1519762291; cv=none;
        d=google.com; s=arc-20160816;
        b=o/23n7SIpqR0BFmi6hoZ1QT+75/eMTDLkHcNwZJWD471MnEUp0Djox9OAfCP4e0t+Q
         9F4jLZ+npJgkxqJIyTrCwp/eS2u3bzT1WXIDnsiciEYtXc8BwOQxx/j80AkTBPaPwzzL
         1p302bziNyoEKlGMWUUe9fFO6CP5Ow1ww4EbEyA291n+Ifg3FPi7y7yg/h24pOthol1R
         QlEjmDbereIvoDEQqdJTFOtuqE37B5DBQjmERc/VgECiQR3pkhLH762i4GcEjJt6fLho
         sasUryw4S44k7tRSnGQeaoKBALI3Kr2UdQL/PTGbg3/Su3m7zk9dCuXG/vILnrZ0b5iV
         46Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=sgp1+/nzXg3bmOAe0U0WQzceyz9kjWIVoKqAHxQVOEE=;
        b=upT7sIS20WKNfV3ePG9Tt7TfiIAwhdEh7n840Dgj/mNbItj1QURgr8xMIoxZUvUfa+
         DSpv4vnK5BCzJisuQu4YjU9O8CHOtzNVcA7KHQQJSJtS+pqaXSHXmnCdfKS0TELpkMG7
         XUVBsUiDPEniylTIyvIX8C/9DOdn7ZIumawqYuUw//45xFXhOX+6bCosGjHvWI6HmCm1
         JPZ/C8FEJYu1AddvnewWdwIHQgaiBFnioqwuyZ6fFEh6LtJW8pGzQep1Wqg5PD8G/zg8
         iqaF6j7Dwo2u4y7yeAQ6wldnbyso+FxlEnmFefl2IjI7FjVjRyGEsQMB3n21CWU4HWRp
         7Y3w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=nDbNTWdz;
       spf=neutral (google.com: 104.47.34.66 is neither permitted nor denied by best guess record for domain of gary.hook@amd.com) smtp.mailfrom=Gary.Hook@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=nDbNTWdz;
       spf=neutral (google.com: 104.47.34.66 is neither permitted nor denied by best guess record for domain of gary.hook@amd.com) smtp.mailfrom=Gary.Hook@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: Can a driver->probe be called for two devices at the same time
 (WAS: Re: [PATCH] crypto/ccp: don't disable interrupts while setting up
 debugfs)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Hook, Gary" <ghook@amd.com>, linux-crypto@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org
References: <20180223223307.18882-1-bigeasy@linutronix.de>
 <3f0e1a62-a7ea-6d0c-d305-67080803aefd@amd.com>
 <20180226083508.th2m3xssp36lx3zh@linutronix.de>
 <372b353d-017d-a72c-b750-9417f6265874@amd.com>
 <20180227173314.uko5xpf4od2fn74g@linutronix.de>
 <20180227184034.GI20601@kroah.com>
 <20180227193605.nhkagbqjkadqqruo@linutronix.de>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <d9fd273b-5d48-a005-ac30-c8bc8aa803ab@amd.com>
Date: Tue, 27 Feb 2018 14:11:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227193605.nhkagbqjkadqqruo@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR11CA0029.namprd11.prod.outlook.com (10.173.25.15) To
 BLUPR12MB0690.namprd12.prod.outlook.com (10.163.218.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bc2ab9b8-fa91-44cf-95bb-08d57e1e4958
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR12MB0690;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;3:isSYOPbzbNw3g24OD1iBtrCw2LxRaFRU90ALkhBztuR7kHvbFJ3ZLxDllEYn7AdgClpZfPJ4UCgla/JPwgxwH6GaGXX3XiFd3edsbfakdneEiaAyc4r4BiP0u0tMhp4wd7L4H0kpgublRSTg+32fNm5dVq4S7KlfVXaNzog/0OPXk4AmFM+aFlAcMEh6XNz4jd/zicCUjlxI1OLDyIu7weuChGITwtP1ZgOZr/3hUyW16w2YOLiavUxRv3CiOoUD;25:SUvXR5LbZTzmNbS/ltf1AsyPzlswuqC7DhZu68bptC6qoZZY9yREpy6JqkaKPyA8b2R0ufQX3y31ndaoWMhAqY/C7eyTom+JgGmL/wbUYrhoIthSyNetFqSivWfd1iA9sstXFR3TBocUWO8xmUG1VgJqVx2MRYxmkd3i+rlJclV+Gc7gScbH/1ISJiepir+cwGDrVzwE/6htsjoIWqbnlSOI5E0pyOF4zF3eggeF4goDikGFYHx8Sa+FKCEP0LJo/nwAIf6I4pYUx1/CQ4TxPA1KMy+fEvwjQHI3tlpIsRaaAVN96BR6m+T5DL0/QW/Mx1CwwEHRiz3CViy+x5U/lA==;31:yP2Cm79ZbDzO6bAypuEbqf72Zv7DhoquBHHD2wqXxYos4avd8YFUx1fzziAGO71/XoJTmQY4NXaqU2dpaA+w+thEWflzZa3lcB050Nxmje5hwnrIvXcU3V6SWGgLTXxWoK6a+V+eM8eL7oBs7DgBKKmAWPKRXxFkkbFOpM54NSTgWP78aatVBrOYStgydr8r1dhJbLAtYQaigPG0Zo2MI/5BGJFI6C4eGgyUfpl057s=
X-MS-TrafficTypeDiagnostic: BLUPR12MB0690:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:VackdF4c1Gjt1/nJtRtPGEfwAKHmitcFLF5UEYdR6Uvsc4vI0jm+pf3t1XcrksMtwrFRZuNCfTGfN7sVAowrKuLWy39jgZurr2wNd+EoWtiDcoBfK8prFRfQaKjZOCIfrJiL8d7MKgWUj6q27H9lnOATzac546kXqVrFOB6O1e6ba2P8ZOym9TtvxTBiZuDB1gh2uTVpgSqVYXNiTfBIgc7pNzgoO52KFH68w92tCMfynk+LH/GE1HVjRYky84ZSCnUA/NChk0Sv4A9EksYJzq6Cwx+tpSRoD/s/2YpuGwgdyBlpZAmd7pxRwHy+4TBWhaupl4TrVnRmWn+OcMQ7bDS4tvEQlUQWFVofEPD7wZTw2PbEdscaLB17pItw3+0bhVbYVRNZE1qj1VOHmCca8A9OUF0j6De5yfRQPG83HaHg/WaswnLzRWWUraStf5Zs6pmbPe3BYoxGCPhPpIZqxypl17xfKQeBC+F/R7+wDsG/oFsg29CwIs5XBeWkdy5W;4:wqk2GK4QgloVyzYLPEw8iRU27SvZxoE/1nn/CZpYFhafQrEttpFtSHnqBCDTlDpU79Zr9F1NPxuJQdqCCj3KG2SOfrEDpCHJ7xUefuQeM+Ub33f//PgBZF4hzLr3gRFu+HkqOtZNRVUyK1yj5U1a0vM+cOE/wEatT5NOQqfmhfFVdDNShFSfr3mJNzZ7ymdxEmktSQTJpEBOPVmDrbeJHrEI9K9Tpj/0qCvFtt7ulnTKKCwqE8trVPTEqwcLo78YdZEhUzbofwb7IT+ojlAicA==
X-Microsoft-Antispam-PRVS: <BLUPR12MB06903D74B1D3E919A1E0730BFDC00@BLUPR12MB0690.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(6055026)(6041288)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BLUPR12MB0690;BCL:0;PCL:0;RULEID:;SRVR:BLUPR12MB0690;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(366004)(346002)(376002)(39380400002)(189003)(377424004)(199004)(6116002)(3846002)(16576012)(97736004)(47776003)(6486002)(66066001)(316002)(90366009)(186003)(76176011)(31686004)(8936002)(65806001)(386003)(23676004)(52146003)(59450400001)(53546011)(86362001)(93886005)(25786009)(72206003)(58126008)(52116002)(31696002)(105586002)(478600001)(50466002)(68736007)(81156014)(54906003)(65956001)(16526019)(2906002)(26005)(6666003)(230700001)(64126003)(4326008)(2486003)(2950100002)(305945005)(53936002)(77096007)(81166006)(67846002)(8676002)(110136005)(6246003)(7736002)(36756003)(106356001)(5660300001)(65826007)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR12MB0690;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTFVQUjEyTUIwNjkwOzIzOjhnZ1VobklCVlYvTGlaS29TV0pLL3BsMXJ1?=
 =?utf-8?B?T2pscjJPdWY2N2E2eWIzd3JUS1Q1UmZReTJtQlJWSEhqbll3RnBrRlRFVDU3?=
 =?utf-8?B?NzkxK2lGalF4UTlnekxaRUhGM3IzUXFRUzR5ZkhGMW8vYTEvSzcwNTZvdUEy?=
 =?utf-8?B?R2liMXZsY0lzN1hHVXRiT1BJZ25DZXluUys0a0ZEb09sbDJuTFRLcEhhbkxL?=
 =?utf-8?B?aGxtaGs5MzJCNXNFMjJ6MmE4Q01aMUtvT0t6L1RiLzY2aGtPeHk3Vi8rTnhT?=
 =?utf-8?B?NHYyUHNLVzJOUnpGS1BXWUhCRW15dEZ3c1FKTG9Ea1dYVWlubGpYMUxaOWo4?=
 =?utf-8?B?OHdIYU9ycndJME1EM0puTXpncmlyMUpSVERoTXNFWUYwcVdFOTQ5VmkzRmRs?=
 =?utf-8?B?bk03dVVieTlJSUxoZ1dSdDBWOHM4c3hnTjdTTG9aMEtFaUFMcTNpaTUvaHNS?=
 =?utf-8?B?bjNUc1ZReDJnNGtkZ0o5Z2FFSDFzcUM0MjcxQjVOZDRDdWVvcmZlNGY3VGtn?=
 =?utf-8?B?WHI5WitveDBTTExoSXRvUm9HdDE4Nlh1ZFRmVlQwNlNweGNVaUJLaWY5bERI?=
 =?utf-8?B?V3VESCsrN3JrK3d0WVlXVVJmVVkzNU5ub3pFcy9taUNpZXRHTVYzWjgyLytU?=
 =?utf-8?B?OFNqa0JqdW1zM1lHS3puNjYyRzdMa2FHbjh3YnZadmhaTEdxcnVaQWxoWElS?=
 =?utf-8?B?RVNqL0lCV1dYd29Ga3NQQTZNVFcxSkxBcWlCOVhIekN2bG5yUmN1WGpvbEtx?=
 =?utf-8?B?SWVDU2J6NStzd2U5ZmN4WWp1YlZPOFAvbVp4NDhmQmw4NkpDMEhDWjluOElY?=
 =?utf-8?B?aE51UWlKTERVNTlBZFJDN0V0a0xYQkFDR3hlTEw4QkNnZmVSa2VPUlQvcDBy?=
 =?utf-8?B?RitKaGFYU0orVUxiYTVrUy9GcFFsMi9Od0tXMGRTVHhjem5jRGV3bXBuSEN4?=
 =?utf-8?B?aWpteFd2bFUrMzRqTFNQTUlwV0RTalRPTnJoVDV2QkVXRGpPQXJwYVI1c2Nw?=
 =?utf-8?B?eTVXZmwwSUhGQWthQVBkNjB6NEx1dHZwbDhVcUtEL0p2WHFickpzRE1MdU5D?=
 =?utf-8?B?VVZLTEgxRXlSdnF1QWI2M1orcjhpdkdEYngvRi91NHZHSG93OGVWMG12RHdK?=
 =?utf-8?B?K3Rab0FCSkZnVWVaVFZVb3lzc1dCK0kwRzBQUWZWbFZQZzloL3BpY0YwU096?=
 =?utf-8?B?Z1pjN1BIUGx3MEQvVzVlZ0ZsQTcrcCtyRHlab3FaTDMwS1dqL2VZdWdFTFN0?=
 =?utf-8?B?YVVuMEVRNWU1emdiN0o5VzBsQUF2L1VZVHVhem44eEd5ZWFac2UrakRzQ3NW?=
 =?utf-8?B?U3dPbUFpYUROcmloVEVubmxMM3JZSWZYVHhjSmpXbnNYNTl3ZEsrZmdyeDJJ?=
 =?utf-8?B?dTZDcjFyeGc3TEZpQm9ualdUaFpMa0oyWUk5V3RWc0tvdmZiTlAwN1hMSmxM?=
 =?utf-8?B?bzIwNDhKYUxwOHM3V2NYbk9IbmoxWXl1N0tMTFo0eG5VaFNIY3pPd0JDWExF?=
 =?utf-8?B?aThlVVFHZFVKVHpTWUluZGFjWFczMTRUWC93R1oxVGx4VERCWWtlMEFBNnht?=
 =?utf-8?B?RmtUNDVzSG50MU16S0VKdklGN1RGOHlhcVZDdU91Wk9sZDRtbExqK2UxOTZF?=
 =?utf-8?B?OTZjaVM0M2hlN0ZrdCt3OUhBSmlJaStwcFEzaFRmdVVKYUhxUCtsVnhZWi9h?=
 =?utf-8?B?bElpU2o0M1FtNzlraXIyemVnOE5sa1ZrcUV2d1NVaXF4UGhBbVF4SDc3d3Az?=
 =?utf-8?B?TzNZU1VqelV6UnNtSG1XcXM1UnBDcUhsM1ljcVJsQ0E0eDBXcCtkazl6VnVY?=
 =?utf-8?B?OGRYU096NUN3MGp2d3JCY2lIWlpDOGc2d3VJOE5VRlBnN0J6UWNnZ2VRdXFZ?=
 =?utf-8?B?VHlFNzR5dTlLZnAzUm1Td3c4YlJRS0NLU1lUVmkyek5aNndVZU9odCtCSGpT?=
 =?utf-8?B?dElVYkxPUHVxWis0d1VMNDQ2UDdQcERHWkNMbCswc09KS01VTHFFcXNJRk9D?=
 =?utf-8?B?Tm02THVYcGNCb21QWlVMVnF6QUlsMlRsSkpSRWw5MjgzQkNrVitWY0c2NTNW?=
 =?utf-8?Q?d4ZQ=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;6:RXFhoRsMwxV9uMNKQWgz/+2FrY1CXsQAYIolYJp1Y3meB0F5DBmK0YYqj/fRNecmzeSYa+6AAhrWfY3+Dbnt5I555bIAJmnEq0tkpF+zPoRiZ8TJRLvWq07rkEzobCEcqKbZMf0Vrt5LQDb5YJZ5OElyw62q6N534L64mqYVWXpy8D2iK3Jmjb9jH/xBAjEuW69uZo+nc+wr7c7wy+F+VBebynAEl5/nVyXMy5bgJcG7oiNgS+tjinidJvQPH74IkzUr0chqp3ORPjv+BaNte9Zerr0QMTxEQgVVmLIhQygRR+iL3e+wBSSr65vn4CO2rJtRTYb2QOc2WAjsVTWiqHzOHEekPytF53cBASSadpg=;5:IvBWam2WXCNJrPHA+4F/jAnJ6zr00PppnovjYuA8XIiwCZJrUoDbFtkQ59jBKW+gqop0Y5TLppMZfdyRSxLoT+Yff1vUGdO44DCEf0QnaByZv5okoFuGA3h/4cLi7Xs8dQleOaM980v6PD7s21O0sc3f9sHWJCoAfpHh+Z0ysGc=;24:eblAjlSI+T6GUALgD3pJAgSkT6jkLHSqxCCyxXp+VkfRWK5S9V5AMlY207pwYhQcsFaPWbr1I9cd1U+vTVR5gjf+6nXV+wrVgqHT5Loq+O8=;7:mtGQ7AzPeCLqP7QpuUeuDuM7BuzVtMGy9sJdYJZhvwSiRTf9SAu6b3B1QU9XIfyEXyBmysV+M52tOAwe3IVuU2lA7fi3nyJkndf5Eb1c1D8pnvaPV7kGFT5wWKjYHUQ4gAQ0BIB0X065Nkqtqv6fVWl6GemE8HCScfZNNmYOaTCU+E3hGo2wauzVOcxdIMLRcvTZODqdHEutOCE1l8YauDjmOKWXFq2+5DhOKl4U3NbHrYT8eAtE697YeUHbdJYh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BLUPR12MB0690;20:KNYUVDd7jJ6In0pburR0JtdmWGgKBa12DR8sKaZdGAk3M14whPjHCXCTNoukBVqDxDja0nUXywcqZXpgfipMQNRNDAXbbYUfejiRR5/o8klb74os64W3VhEK87c4QR/jG4BKh/aeuD71tpn5m/lhOoKdwvhZbTcXbBeVJ0GdMVRBE8TDYpNH+2y/9Q2GN6etBQMqtoh2cBkGnbcKW7InE6KBx9T/odntlqbpZBz0sX2mkPB4jKb9nQIkeKBs07ap
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 20:11:28.3235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2ab9b8-fa91-44cf-95bb-08d57e1e4958
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR12MB0690
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593576313003977918?=
X-GMAIL-MSGID: =?utf-8?q?1593586264543621585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 01:36 PM, Sebastian Andrzej Siewior wrote:
> On 2018-02-27 19:40:34 [+0100], Greg Kroah-Hartman wrote:
>> On Tue, Feb 27, 2018 at 06:33:14PM +0100, Sebastian Andrzej Siewior wrote:
>>> On 2018-02-27 11:08:56 [-0600], Gary R Hook wrote:
>>>> That issue remains unclear to me: Are probes of PCI devices guaranteed to be
>>>> serialized? Observations on my CCPs says that they occur in order, but I
>>>> don't know for certain that serialization is guaranteed.
>>>>
>>>> Is there a definitive statement on this somewhere that I just don't know
>>>> about?
>>
>> The bus enforces this.
>>
>>> So the question if a driver can probe two devices simultaneously.
>>
>> Depends on the bus type.
> 
> PCI

So the question is whether or not PCI enforces serial activity within a 
domain. The CCPs are all on different buses, so that doesn't matter.

I think we don't care in this situation, given that the CCP driver has 
minor requirements for locking. I just found it an interesting (albeit 
somewhat academic) question.

Thanks,
Gary
