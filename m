Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbeBUJsI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 04:48:08 -0500
Received: from mail-he1eur01on0060.outbound.protection.outlook.com ([104.47.0.60]:11040
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753054AbeBUJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 04:48:05 -0500
Authentication-Results: spf=pass (sender IP is 193.47.165.134)
 smtp.mailfrom=mellanox.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=mellanox.com;
Subject: Re: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
To: Chuck Lever <chuck.lever@oracle.com>,
        Bart Van Assche <Bart.VanAssche@wdc.com>
CC: "jgg@ziepe.ca" <jgg@ziepe.ca>, "arnd@arndb.de" <arnd@arndb.de>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "leonro@mellanox.com" <leonro@mellanox.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180220205924.2035765-1-arnd@arndb.de>
 <1519161268.3737.12.camel@wdc.com>
 <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <a4ab4a2c-8b96-837d-d0a3-d06625eb484c@mellanox.com>
Date: Wed, 21 Feb 2018 11:47:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <F2FB1034-BFB6-45ED-878E-6FADD756157D@oracle.com>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Content-Language: he
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.223.3.143]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.134;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(2980300002)(438002)(189003)(199004)(377424004)(81156014)(81166006)(8676002)(76176011)(7736002)(64126003)(356003)(305945005)(5660300001)(106466001)(8936002)(110136005)(77096007)(6116002)(3846002)(229853002)(53546011)(36756003)(2950100002)(26005)(6306002)(6246003)(106002)(16576012)(65826007)(50466002)(2906002)(67846002)(47776003)(316002)(58126008)(54906003)(31696002)(478600001)(4326008)(31686004)(230700001)(336011)(86362001)(65956001)(16526019)(186003)(966005)(65806001)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB3258;H:mtlcas13.mtl.com;FPR:;SPF:Pass;PTR:mail13.mellanox.com;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT054;1:Pft4koI7zs2NPZ9aYUt8HGJWVK8MHrn9pQjtqfogMFdM5k1qu1/EZO+jkI0DpOT4i6sOtNow2ZaDOd4PrQ3XmtMadhfaBbloWLcCwz2a2m7gX/VrmArsoiLWTR/3JGDq
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4739b127-4f91-46a9-7800-08d57910315c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(4608076)(2017052603307)(7153060)(7193020);SRVR:HE1PR05MB3258;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;3:PCPhlfXFxevfqPxB5rhxW2PgYcQ3qi/GPINxfQrZ1ehrJjjZ3IzEU0B2RSmIfjmMGjPlPQvo8Sni+L2ZPkG1gUuFX0gHYDhTXTlzWbrJe6zov3dISPB0GiEDH1/9eYhm4mo0WSkFafCWiWU+W4FwvDuT1EEmsY+sBYuHh8wjmAujLDsEYBJgUjTUmxmLGuTBx1fyDcZ7nH3Q4+3JQA7rJmPu9ehAHbaJGhmEDLzQz+C+h+3dzRn1+mzGYSBjoKPXsNbkh85ZZBtMyB+EdCbJkTj8cE29/62zW4EIwa3TJ+3+apuBUreVESAQBWF9N1OYsxI5g3QMcRp88y/MWjKgzTtD9ggYbnMAPGLUt3mONxM=;25:NP/9kY2ZcZM8D80QXsVejC4HLZVgH11Xp7FzOzJskjOnYaerHPw4Rrp06DQFe3vhm8OvBZZGzHsHNrIOPmFwassXBjnxSFdpmOZmSPsx2K5w5M3+eXbPIQOWETZmCGJubosSSwwbUrmScotH7X1xTrAierrW5/oj+FpvvJ7cJHWcYVlihl5ulc5ndI639WhdURhGzSRZbMJsWOTAQLwGfOqB8kunZP05A2XNMU7EI8y61Odjd4OVG1CD+Od/DOTfDz9x0Lpl/LthatsRUxVeYekUbVQ9C+VgKz8xpxLFC4ktjU/Qo1vVZ4dy2NHwJQQs5rq7LPKUl5vdE/TdVuv+lQ==
X-MS-TrafficTypeDiagnostic: HE1PR05MB3258:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;31:cjSmNvdGpIaMDI4o5oIAMZG4ANCg/KBTM8p9kV61WUuHoIrqSPwEaLSRokbRAxBGOOc21qibMhRDt4yn4X9G9nj4s7yPawa48DHejRICN87owjosqzp1L6pSbvrTiCbwJyrQi0fy+b6VHHHABg4ZD/51+lf2QVd4LDw71J+dE5TnYIpGcPp3uWJ+wCSYAIipxomQ5F0seSeo5HmzL1LP+Ob5dMsppQ2TSNIEqoDvloY=;20:VkSbDGm7tJ5xPTWVhlaMs0Ei0olFr5rNdm3MDAC1VH9HFmeyJVVgQw3DLm1iFpEX//pIPvQaApwNYhhw7+lt46ZTe0QIFEJHpvNMx+BmWFkAxk4b2zNLZK7B1+MnwHHJgLx1ckCitUVJFXfrs6LdQngXqDHwwg7/3t0KVaItMyiWpw+BgX3w/k+2DNxR2wU0KA6tp994wNuxbfiFMVAdnWjShN+d+ihvuyOfHPzEGjYDcMJrx3uVgrwbAJL+AIaqMRt09sM66+Gf4v6JuQK/9A9yIEu2guc73JeQAFjMMu9qV4wUF3QA36f72jJo9uvo3GyDEBoyABahHqJMdezi40RvAN6HZq3XSReOgWbSQu2zhggo0QDu2m9OPceUQGorBxRxeTYU8FXPyiz3A3xncRe7UiwTgluugm9jUkIzIyXBlS3D5hE5nsMgXbjYEd2uBPy2lGizEFmBAJhhMBSd/J70IsS/R5cfnVInVk60yIq7LTnvNiD46bb/eo+7sQPt
X-Microsoft-Antispam-PRVS: <HE1PR05MB3258D3189ECB80E067368A53B6CE0@HE1PR05MB3258.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231101)(944501161)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR05MB3258;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB3258;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;4:8wZULUKC0mVfL7gdWFBtqkqvOuqb/gJlLXfL5VeYLWy21jyhjvox5lErfvgzyIB2uRpzNxXPJIs7nST9GKgEOPApneMb95S1aGY0Q+i1e8lWkyOOcwvhCQu9FU+nBMqECcs6nEHwaFAT25hzawlXckBLHGWCLpbXKNAK3mmgB6owJZyzsMAPXYFmwPAMmhCKdsMcrcqStvMHJWdV06BDOWiIUbF/KttpZvazVanzTCjdbDmj76I298XnQvalNc44lm1+3p995Sw+dsNekIz8xOA9A0Gt6oAF9sQ+iW+4vT0s4/MijjyJxeUbn8mq0Pjw
X-Forefront-PRVS: 0590BBCCBC
X-Microsoft-Exchange-Diagnostics: =?windows-1255?Q?1;HE1PR05MB3258;23:+FxvJn+GMqCqbdh71cik9CF/ykxamBAqLzGhj?=
 =?windows-1255?Q?7Y4v/LwXzb1HVzVaPWaPmzIG/AVT16P53yqCYC1JvIP34g/nbM0zXR3Z?=
 =?windows-1255?Q?1QTzHeGtoH5tnRPNojKhtVAH/hWYSa+CEVznFLPNDsrKPhtpFhdOouQs?=
 =?windows-1255?Q?4lBp7DHCOxDUSFSMhZNlN1DYuuNNKZMay6DjcTlJZsIvHZ0i74rU6vmI?=
 =?windows-1255?Q?VOGDu2S6UgFfGOQ2qeoCrUWKQcA4xE3oUl6607Zh35Xb2AON2/2/VILr?=
 =?windows-1255?Q?7sfkhe9/1lOBN2CweXIYkTgWoOSWyBZkXjjgfiOgokGOHPayaiaSwnr6?=
 =?windows-1255?Q?mH5LfWBKJAsym0KV1zFm4GxBOq1xmQnjDvRTOwyex7RfuwaZBM1RlcM2?=
 =?windows-1255?Q?0Uva06CYmadEzlIKYYp5rz6hgcHxE5B2N5BebwKA6dDvNUmNkAURZj8+?=
 =?windows-1255?Q?8x5csEQlOnoiWokXqchKvrHMDQGsJo4cWMG7v4mOYiq6Bf/SCmUlayrX?=
 =?windows-1255?Q?sEuFeSFtJUtIn3UU3q89tdOBwbQy2e4DkVrP4S45+xRred+4NJYFXf5L?=
 =?windows-1255?Q?Q17Uq/MM/WznhPYqRI6m0DOjl6/fYvDAofhdo30z6BlPYMZ5HbJCjirn?=
 =?windows-1255?Q?ZM15cnwSCX2Lwi4ey8b5kAsbT7Xp5u3R6s0PcXFTvdPUTDfRc2q2bnC1?=
 =?windows-1255?Q?AEakeRJ2euXx7zNUybFbSqvKQ+9ruGcJYjbMVct77NnP5SS98k2wslTQ?=
 =?windows-1255?Q?wdtRJYq0UmgVsOCSAl7XLJ8Oc/YiRVvHBqB28UZ997Z/JPsbzD8wBpVA?=
 =?windows-1255?Q?hioiXm9zIuk5cWnkMAnKaiCraN50eY8cG0PNwTYFE6ykXwdpasgsICJC?=
 =?windows-1255?Q?+gqVZbBYHhBmzKmmUwSvLYyTBhCZn25zquAuX07A1FxUBR3TXCneAzqp?=
 =?windows-1255?Q?LRutYl82uaQEygh074xnIt0sowLtEB0TS2y/dNCsEU/xQADMAp7YdlAQ?=
 =?windows-1255?Q?SqwNKt4tXe1pwsmbFr0jSoyObKGTN5I44wRXLEGFZiwXWyeVtwgosfu2?=
 =?windows-1255?Q?JDRzzC5hoOiAduuLwBZvgwRiHUz/SCKFcYMD63QAS+EU7lNY3JqJuDlx?=
 =?windows-1255?Q?DVJHGhyfSjZ549Dql9ZstVjeNdaOWHRkqLqmi7hfzEs7wEVBTt1MiTWR?=
 =?windows-1255?Q?QahznCljL6sjfbDTaMiWWSbXoE0liQ8mM+0DTgPphxlSwTObXFfcZB7r?=
 =?windows-1255?Q?RtCd22QHzr4zhQpHGQKWR7Z8u9SDOBBdMJXXLkdFyEU4XX/RYMT88kS+?=
 =?windows-1255?Q?nvEoNg5luVCt468j0gtLB3MTxzmmWlQ0rQVaTDZABvWQh8=3D?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB3258;6:kycZb0bemILorUUSbfmVM4AnMPy856JJ4pSyxG0m8ReFYtLrHxsJ+U+iMaPY64MESSpBX8YIyqcWSYYZCwL6t2joG14ouyXjpKPqUzDd/qc3MOuxBY8+c/sqfuA+TeHEXZeHqJiHgUKA9YjbellKHCe/14svmkG4K5Lvd9HBP0eikXqtI9nOM/j3sX2/wc2Ffhd8NsaO10Es803HB2eF6U7hK4JX4hUG6bhFvArQDpORKcNytxbCzenS2JOWIA5OshzN6d1grRv+sNbOxmjzomnZBfaGAPDh7MwuXzdI9m7LNtbQWPU+5RV+v9rZ77DCUKtco1kt2xMJbNXiR9Pki4keJfSl7b0jMFYNE34cKWQ=;5:CQAa6/BRP/30BeokRL+CmwiqQXMhQlRJ5PZXgGtLNLF+w3YBv16FpkJJ1jO2AmecN2WIAHPgUyBvtjfeS+pzj4hmbkDiWiq/0a4eDjjkr+uHU+FDBfaJc2fXGYjoSffxBK9s0jBuNfNXD26z4YvLOErT2S0QFu9jS0HSoHmiiRs=;24:1foyBY5OAQnroN2L6P2W79qela4hTUKnnTJIQqyFlNAgkZgPQTbqWIkvbPLvpeVaKtEt4xDZxS2jts1kgT/Bk3nfD5KtY6k/oWg0eAg2OaM=;7:1/gjhfes/sJUgpFWgqZ8QJ9BVjudOeJ27sBYazb+CWpvPFhDdUJPF4BkIn3DXVW/wMGXCkJQXQLJLP18dD2KFvXS3CCpucycH1MA3rGoaaabrlXHZLAPGCUfPg6c7IvuYfbdkcExUVa5AWTsfcBxRgq3L0buk2a3hFzAkgt2wdfFOBm1QO53EgCY3ybgfiTI0EAPOta8W4UcPjhibfrRUWzcaJ1JzOa00Xy/sWnL6DsdJGjIfmKRlxDk2mZ8hfJg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2018 09:47:59.5655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4739b127-4f91-46a9-7800-08d57910315c
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.134];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB3258
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/20/2018 11:47 PM, Chuck Lever wrote:
> 
> 
>> On Feb 20, 2018, at 4:14 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>>
>> On Tue, 2018-02-20 at 21:59 +0100, Arnd Bergmann wrote:
>>> /* # of WCs to poll for with a single call to ib_poll_cq */
>>> -#define IB_POLL_BATCH			16
>>> +#define IB_POLL_BATCH			8
>>
>> The purpose of batch polling is to minimize contention on the cq spinlock.
>> Reducing the IB_POLL_BATCH constant may affect performance negatively. Has
>> the performance impact of this change been verified for all affected drivers
>> (ib_srp, ib_srpt, ib_iser, ib_isert, NVMeOF, NVMeOF target, SMB Direct, NFS
>> over RDMA, ...)?
> 
> Only the users of the DIRECT polling method use an on-stack
> array of ib_wc's. This is only the SRP drivers.
> 
> The other two modes have use of a dynamically allocated array
> of ib_wc's that hangs off the ib_cq. These shouldn't need any
> reduction in the size of this array, and they are the common
> case.
> 
> IMO a better solution would be to change ib_process_cq_direct
> to use a smaller on-stack array, and leave IB_POLL_BATCH alone.

Yup, good idea.
you can define IB_DIRECT_POLL_BATCH to be 8 and use it in 
ib_process_cq_direct. *but* please make sure to use the right value in 
ib_poll_cq since the wcs array should be able to hold the requested 
amount of wcs.

-Max.

> 
> --
> Chuck Lever
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
