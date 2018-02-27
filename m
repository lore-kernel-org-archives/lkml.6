Return-Path: <Gary.Hook@amd.com>
X-Google-Smtp-Source: AH8x226k5R8hR9TUvIu5tMeB/jJXCNdS2JHAUKRetEk9MOhR1i0XpV8BnMQXu/tiey4JuqzYA4VT
ARC-Seal: i=1; a=rsa-sha256; t=1519753567; cv=none;
        d=google.com; s=arc-20160816;
        b=DQVGi7V+b2yfeKkwuwUKVWZybTZ56mTd0qSYDVFgBBaTZAoAC+6ayXMhWqgzca5eza
         lt9IHetbCNBDZWC8xnemRy26T0DYnVxNrbrC76+NKIe51c9WmpyGbTU3YAvCp/jLM8q7
         KYBIurCiz+PFLgr5NwpPVSncHiIFhYuW5jUF0HpDJviaqeAReCyhU7dkQj+OTOXRE1i4
         tWbBuFZJA8Hcy+KTE4Qwougj+ChqD1Hlti2VmdFvsK+uO3cu/Qp+yJTDQXRYlqLkAP/f
         lF/zRh1VVutIGHi0M4k08budHDyXHWfX6tlB83Tk0JJWI31/Hjjcw+rRN2j5YRRbVA0E
         ZjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=XJJJnDA9dobNjHqDTGLZaFjQXRpSH35hYcet4JR+apo=;
        b=IVV91einhpr3FUBpXf4OfcWxudIblJXz0OVUBLC4gl4/h421oH8LC90YAwpUjMSMm/
         oOq4P91VQGNEwqHw6UGPOODNiTFHyl3aWCTBO1WdOYF8IN3Mw6DKQhh/y+g/DDJyhDlj
         zgy70LhIInA6a6v88fiJxKcbKDr7ULJlfpnVhTm6ZRykzP/+6F3ir5lly0o5LbNrSp+F
         w7Q+OU1SLaAd3Jx8q20LAJwKwXdWDbRZJVaV0PomlG49vtZ3uQfeuON3fXwkiAYQ6Ey1
         lMq4XKU0Ep+AwRrUqHUIsXKtuMPTV2N53dARxroWcgMlWVv3OklEBp4y5ZLpWg1zxWvV
         Jo1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=i4S0U+Js;
       spf=neutral (google.com: 104.47.37.53 is neither permitted nor denied by best guess record for domain of gary.hook@amd.com) smtp.mailfrom=Gary.Hook@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=i4S0U+Js;
       spf=neutral (google.com: 104.47.37.53 is neither permitted nor denied by best guess record for domain of gary.hook@amd.com) smtp.mailfrom=Gary.Hook@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: Can a driver->probe be called for two devices at the same time
 (WAS: Re: [PATCH] crypto/ccp: don't disable interrupts while setting up
 debugfs)
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Hook, Gary" <ghook@amd.com>, linux-crypto@vger.kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
References: <20180223223307.18882-1-bigeasy@linutronix.de>
 <3f0e1a62-a7ea-6d0c-d305-67080803aefd@amd.com>
 <20180226083508.th2m3xssp36lx3zh@linutronix.de>
 <372b353d-017d-a72c-b750-9417f6265874@amd.com>
 <20180227173314.uko5xpf4od2fn74g@linutronix.de>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <6a32bb01-209b-cdf2-093c-fe749627c806@amd.com>
Date: Tue, 27 Feb 2018 11:45:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180227173314.uko5xpf4od2fn74g@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR21CA0059.namprd21.prod.outlook.com
 (2603:10b6:300:db::21) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 914b4e22-fe6c-4609-f0dd-08d57e09f9a5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:vbSkSGcCWCha+REVBAUMMfrc1e1fvAMgToGyaEvdt3vsMXs2Uw5lDb973QSovqd8mmpi8t3yQiQqYPWGoNP0C2GMxdMP6CNjKIe6kW/2w9skyruLWXqJaWGDR19Ypbevf3njndFGHlomeHWX0lGUhJnr0AVxfJrhN//mlJg6EnUayC5DnMe0lkc6NL/uAi8o7WI+n1aEwn2NX9GI80HF6qB/Ox1wpa3jWkSBGFC7AFcqjV8dSJFUlDFTjEhV4OTQ;25:bUTxTyhWTjT1veoeuUTFr9r7ldXLdXz9aZjbnJkljtIwMMxwl8yq82wCFYhXSFl1/M+hu2xLA/jfe2WKDwunY0lgamvlQmve2HaX7RkI5j/jEozcRYBX46Sxa9jOoSBNVqbx15iNkXNFUYME+QORUhEtzBWIT7FarxsD8t/CBJMkpEZyb6P4ZXyLLeEYa1OwB3n0qONRR1HXX4V/KyjY0R2ifWsifqX5HSoTkv1Y7Ip9sTeOtWkk2poRkX2MpUTXtvYrE4G8eQr9H01BeniUK1IJuawHn0Z3Y6tRXo6VTFn/9+t0AzKb+DsJTveZEsJc9V8I1iqK3XvWxNuU2OdqCw==;31:fx2M/+4I2kEhdVbNh0arSJSvvS98lU2pL9mHf17SLZY/EO0a3rU8pGThprXNYo1CytHKHsMxGgzBZrrcQAui7y9MpYNS48J6PaJWd1zerIRKknq4+IKPDBHaFFI663wLMguCnRdxVft0tLPAnL8dL8eoLG9ElpyPMUplJDw1fjCwrWhkkUEymxLC6nNIuE9nEgoXnxj9YW4jasBFglVL7T1FGj6GndgqJds+34kK68A=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:OZn/fk5/fMS8VtrBoOJk2iXp0x6OXjbUkXEBJaLeRbR1tKbyxBKh+DdJvRoYpaXStDt3a35u0kbjN7ZbN9PzmRt29ye9FK22Ey51p7QnCxYMpsag2Wq3xM4XY34+wRXsrKO/PjDPZbL9+bjxkpAXGdXkkOKcAtF8gi20Z+5IayiPlCrYySRRaJDZC4rZsvnPpnU+bkRtVRTduMz3q1cHRU/LaGYxGamdpeBWe3QPGxv3M+H0JuwUoS7OkQbfkkHsf+3q/g+iU1P55yAKZcygTELYR5cTr4t8rBRp4qv+avVBQuP7gKVe7ytBhAnBp0JX1N1PTdYvdkbhPOELVM/6+n9pVeDo7nCyixLmCL9Jx+VSmnTJTC0nsXQJ5e89g8tA16ldH3aR2i1Owp3cCCNLw2oOseJ1yVdnZDrg/fQ1FGq/9Ytq24ooGJGJvzlOM0sSXhSnnB/JZ62nvxo0442x/EAUnXrZ8IgTXG6ikzO/ABntxONZMQqoo7ONK7VNhKt1;4:lJPfQqVl0Kkmo8p1lMpuuH/REaBDiJW5dVtjtHLAL7vUjwxGJDTNpSHhLbxNtfFmosR4yof+Fwj6CDHitMC/y6d7N9JZqmjTq170KVFWIWZN4MIgh4bfMGw5gNwp1maSy2G96/f1wbQ+Fkqw8l5/VtpgOEpdRP9XN+65RA8mVYhyCqNojW6XOZftggzq3Yrj93QoEZHI8k6fQ2+aEvZuFDVepBSX96Yc0EHrDGaUwfZEhk8s6rUUivDVYvGgjzKVPo9Ad8Rw0xWZ8RUG/eUGOA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0702E627549AE5324DD2A685FDC00@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 05961EBAFC
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(39380400002)(346002)(366004)(396003)(376002)(377424004)(199004)(189003)(230700001)(16576012)(31696002)(58126008)(386003)(53546011)(77096007)(54906003)(6916009)(229853002)(67846002)(186003)(16526019)(50466002)(2950100002)(36756003)(106356001)(53936002)(31686004)(316002)(105586002)(6246003)(59450400001)(6666003)(93886005)(26005)(64126003)(478600001)(4326008)(97736004)(65826007)(72206003)(8936002)(6486002)(25786009)(65956001)(65806001)(66066001)(5660300001)(47776003)(76176011)(52146003)(3846002)(2486003)(52116002)(23676004)(6116002)(2906002)(81156014)(86362001)(81166006)(305945005)(68736007)(8676002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOldsSWFLVFc2YnlBNUVEbTdpTllGdFNHb2k4?=
 =?utf-8?B?aExoS3BxMjJJOUF3YnU0UkxJRVdOdmJrcHhmTzBYbU1iNUdrSVdHOHQwMFJn?=
 =?utf-8?B?RzZJSTZ6aWZGL2hnUzk0U216R1VneUl3WU1EY1Nma2tHM0xBbW94SEoyMkk2?=
 =?utf-8?B?VG5IMDVqek1GeTZTYXYyR0ZyMjNjSDN2YmVuMDQ0K0g5TVJTd0NNWDBQZXR2?=
 =?utf-8?B?ZXA3WWVlNTY4THJjMGdIQ2s0dExpOEtjTjdEUm9jWm1DLzBsWVBtU0Q5MHJ1?=
 =?utf-8?B?QVRzQkYzY0xZSVNGdGh4S3lsZmtOS3dud2tSWXl0cS81RUVuZHlRRGNSTlQ3?=
 =?utf-8?B?WFBINlpUdE1WVE9EMnYyWEhrdUk4T2VMam5RUEoyTk05SmQ2VENYelMxZWRz?=
 =?utf-8?B?Vzl4SzRINHZ5akFGTFpxbzdId3ZEK2tYV01CbkFkVkViaVJOcWlSN1FkYkMr?=
 =?utf-8?B?QlA0ZmlRMzhxQzMzUGxJWlV6cFBkdDhjNFR3WnlBaS9hRWhjNHlaTU5mSG1X?=
 =?utf-8?B?U1hpVU1qeXBIZjBpUHd4dVV3L3czaXZlSnBBalIrUm91YTZpMWI5SXprWEFw?=
 =?utf-8?B?djNzWFNpcktSVTJJME1PVWdyVkZNQXVsODlMbGZVQnllNThudTRyU3I0a0Q2?=
 =?utf-8?B?cmxhRnZ3RVBLNFR4TWJ4eEJOYWZMTndhSW1lV2NUM0p0VXhubEVZN2VYK0Y3?=
 =?utf-8?B?ZUViQ2Q3aDd1dVNkL1NGQWtOR2xTdmZKWU5lSlBIRXYrN0ZkSVQvUHdxdlVU?=
 =?utf-8?B?bVdPc3VyNnZrSERuYzNRQUxqSDJWeDM4bUhMY1EycHF4VVArZVY1ZTFHQXJR?=
 =?utf-8?B?bmR4YjYxOXhXMGFBNCtGU1JWZHFsYnEwK2VBVmd6ekUxcEdwRmhVL2xhemp6?=
 =?utf-8?B?R3BsS0doOW1EWVp0QittOUZtUkFpb2NlTWF4Nlp3dC9xTkp5anZrWkl6M0xm?=
 =?utf-8?B?ODlEN05GT1ZtZ2o1dGwzRnc4Mm9YOWRtRHFKb0YrTHNIWjFDNlJUSHVid0pu?=
 =?utf-8?B?am82cXp2c0FwVVI0OVJqWHBXQ2M0a3lvUTNkM2xVdHNHNExHZ2ZoaXJwdUNO?=
 =?utf-8?B?THVtYW1qMWlCMmNWeVBKdjBaTVNDZHh1aG9ETHJnN2tBclhNK0lTcmt3ZDR0?=
 =?utf-8?B?VTluRUEzcm9UcXcrSnlnTE84d21WR1VaSjJCVCszTzI5Q2tXWWJmaHFQbEJV?=
 =?utf-8?B?QnpjZjlLYUJTMlI3Y0ZyZVdGVGtlalZ6RHBBczBsVzIvU1REMEZobitpUjV3?=
 =?utf-8?B?WHBwdVEzRnhEa0llMWFZdXY4QktKQkxFM0NPeXRKM2VwNi9oV0hnZU9YTjdU?=
 =?utf-8?B?b3VGSnAvM083MkNjOXMxWUljYnVFaythYmlXQTllUTNUZ05zcGFoYnZiZzg1?=
 =?utf-8?B?VDRrSnhGNkExZzUvWkFSd3IwOGpQSlozNFVINXB1UFVnbm1SeUtsbWppYTIr?=
 =?utf-8?B?Nlpxd1VFVUxidlhuZnN1WUdIQ3VZY1ozZ3FndmwydERuenlhSTcxc1h2bVhZ?=
 =?utf-8?B?MXE4dmJzc3IrRVpvMjVOSFNTd1BsZkdnd2dSZHBqRCtJTGFsUklyRUdXT2lC?=
 =?utf-8?B?ckNsR3FjVnNzTGNTNzMxRXhoSEczQjMwTFNhRmswSEZSOUlLVE05NUhNdnNU?=
 =?utf-8?B?dHlFVWNRd215SWlRbGlJRUpmd3U3NFBkR3Y1WE1qdGVCbHR2NmRpMEhOeHll?=
 =?utf-8?B?azlhMWpZNWgwMXBwM0ROUUtKS1VCbkZjSDFyMC9qUkZ3ZnNkTGFkdkhXWVVn?=
 =?utf-8?B?R3p3dnE2RXcxTDQ3VUw5UzhuT0F3eVdBNEtreG1VbzQzZ3ZxWS9yMUZOa0hS?=
 =?utf-8?B?NlU4c2x0QVlZbWF5M2JFeW00UTFWcXN3UDlHSHlObUVDR2VGWUozOGdrL0dG?=
 =?utf-8?B?VWIyZ3pOL2lXb2MyV2JJK1FTVENzNXRMMXp4RmlLanNYSzNDeWJpZ0p3NWlM?=
 =?utf-8?B?UEdWcGVnZTRiL1M0Zk5LSEYvQWllOUptQVp1QnFlR24zNWhVTGxJOHRwcU9x?=
 =?utf-8?Q?39qGBl?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:s94XsmL5hzyTfuVD8zMyhjQffZ0Vd8E9m3D3IPjokcFSL3nAXPdmgCZZN1UOdrlIAjRtmsnKSqzL4IPuB2Xw5UcqalkkfYsV3b3eIX9nZy/AGNj5cE2M/34fScaJpG5UQzdfzjNsY9ucXClBDuGjYcBdhFafa1WoPas0Hk/k5FDmJIkVP4KMIT9gcTw5Y4CJYtEr9ZvIwlQWNYG2TrYaXDJ7VPGz9u9Q4qm9tMw73bpWCdk67fdl6n2JAGnYVgN59Jzl5BDUgZWfreCjCAeQk144YfKd1K8/BaDFTD+c+6pnwqazbCUCYPZ3YdW9ynyO9zdy4hNNZ63pqJEwmstEY47co2+mv9MB4RCGtTfaPug=;5:bn251ALo9h2YIUfuBME2uslHVsee0cnozQFsGmzBzGhUWfBUn+/ORGkw63HTgmXegy6FDWv4oJocNlMKkrLbU2TXBq40lrmFZssjKoAgydQ4RfvMJspGQBpojxeX1w2A2XDPWGiCRdJA3dl2joT6sY1diJAM2/0CIkcGcZiXKXw=;24:MOpz+XviegxiUaM0On26r2NgTlbFrmFuxwzzdlfbqB+v0Uffn66PX8wKPOfkmvBF65olPSDPacWYn/+53aWJFic52LqUdnKyUfZ18OA3/es=;7:4tg61T5H4J+wNQod+A+MXcpey+VxMH2rxn+cmx3czOZxcrplihsFSNNX7A7j/6vQrF0VRcSi1ebtVSpYZmLPzqJ/7fjep2VSNJO9Md6NKw1TyZS3WqEM7xs2G/LUODGnMjzrBuqzpL3wIQusNqoNwYlqXlDITooQvxLjv8gZlhaeO6sVd9Y+3kHQ2BBsBqxLl70Ud8YpEaqh/YSx4eFtcJfjRCeJqtf+Ha2zqUZ6kRNzCJK4oqf+awDTk0YIGT1j
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:9YfI2bymtuW1nwThxwS1hRoJor4jsxpBBQitC0P/vd+TjqIGD1zGayPVacQ4aVbyKOPAiEXJBvZ2VlMY9hjf0Cox/vTKCceqZmNGDl7UlVem+5LTGG+4sdye/+Qb6CkTikDcnqz+nrujP3d9CqafPjJGOle7CgB1daZiZE/+0iBPkC0hsy3i8fX7CYnPN66H0WU7hrcJ6zeVU2qM6dCfNGZCrIoTltseb/87rg/lf75OFv8OB/L7bICqB6YKrmM4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2018 17:46:04.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914b4e22-fe6c-4609-f0dd-08d57e09f9a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593576313003977918?=
X-GMAIL-MSGID: =?utf-8?q?1593577116749828132?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 11:33 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-27 11:08:56 [-0600], Gary R Hook wrote:
>> That issue remains unclear to me: Are probes of PCI devices guaranteed to be
>> serialized? Observations on my CCPs says that they occur in order, but I
>> don't know for certain that serialization is guaranteed.
>>
>> Is there a definitive statement on this somewhere that I just don't know
>> about?
> 
> So the question if a driver can probe two devices simultaneously. I'm
> not sure. We have PROBE_PREFER_ASYNCHRONOUS which defers the probe to
> worker. However I have no idea if two of those worker can run at the
> same time.
> 
>> I think a mutex would be just fine; I got this wrong, clearly. Let me work
>> up a patch using a mutex.
> 
> I've sent one. Why not just ack it and be done with it?
> 
>> Gary
> 
> Sebastian
> 

Sorry, too much chaos right now. Of course.
