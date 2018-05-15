Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754280AbeEOQ51 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 12:57:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59006 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752453AbeEOQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 12:57:25 -0400
Date: Tue, 15 May 2018 17:57:08 +0100
From: Roman Gushchin <guro@fb.com>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
CC: Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] selftests: cgroup/memcontrol: add basic test for swap
 controls
Message-ID: <20180515165702.GA26711@castle.DHCP.thefacebook.com>
References: <1526400353-12991-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1526400353-12991-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:1d81]
X-ClientProxiedBy: AM6PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::42) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:btHFqm73nVznSwd3NcYu/cQ4kVcZ6hR3zv+QAHQxfJIj5ymnUOycFfzyGcPehKPGgG3TNnemoxHPgSVKet+PTjV7RG6z9ktOYF/KTqgLjmG8QgRw0nOwqwBrpabQLD6zcKrjarA/xGDm/Ve8TJjo5CNX8draatq9CU1HghCfu6YU6R1KidIC/oB4y4kIj9BH0dMrRhk/oX8Y6nTkyJj9k0AlSlV6Whb79HT0FFX8BDP4IHqAf1ZfEBcJ52jaJRgp;25:lUbYwmsKsIjk/Byue1xh3D+/GCL19W/BwUaDrJC7dB5SASi7UqmK0lyGz92jnWVpbmwh6mSs1eAz5pUhZ597PJz21+Ok3uLlFgm1KXQAxLC5cWz5aHwBKUIDtpyaPMnrjCIk4qJwUUNBrEKEMG148MS3yCNBf7P7/xHFij1iFQOhZTNci2x5rMHykheO0BYbMZ/GMzgQGn3F7E+p4OValsFxMRH9Z3v47kBPfT2HoddTTPq6IMcbcmZ0E4YnofDSlHH/ezKoMjDCAZrqsRa7kqavY7oTdlPMVk2f5f3jVce2G07OGtbldAcCkF1acPY00xZUlKx5d2es+i70WU9rDg==;31:X9XV/LMDHFKW3jVHudmYMRKbfJA0WUUPYoNvcTx4zjdit9+z2cRS1UyzZ6z+HvWhWqUDbgjM8xy+kS6DYNNv3M/jyW36+Ts6NNCj3dVPIIiyiXR3sRzg2ObHoFlYBEK1Krvz6A1MTW5qKlmMagsaRRBDYq9vThTlOCO061S+HRAyGfCUbxuct7ABiP905aE0+Dovr//2jSqiUbpntuyIqofD7jvD/hRGuevH1HMe9yg=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:gDLU9RrT4RXrkQGQpArDEpp+lP5GNY9kOw9ar6PTEfBHDYhx/jje3kZP6R2lcXRxSn5oOdZ8KrG1BMFEtILf00f73EfyiwCXfkK/rJiK2hHR1pzNMwImUdrpN6dCzVOxb6R+EdNKlPg6L2Y0EYCLkYU5rzBwwxBBllCJ4c2vmgmOzU/1aMDN3exQWbRIjtyaG0g3GhN2y9uxpVcvBkYBks2eD/KuLPdbPUAqdNVjUnWW9y1hYj8QeyI0Os+tK3IQqmz0MdK4MUjB4sX9VykEe6sWybxXnL6d3f3FSWDdedPFilnE96yqNBWYjQiJ9VhUqzZs/YNwjj64km35XgQfcmqloAoU206vR2dcc4QyWcCbAW7/wzYpKdKwZ1bV6lSmP/XKwI7xBcL4707iUPSMJSsb4gzWtjsD5F3SsQgJ86AsW6IvcWDBa4+KeDB3ALGR9I/IZuQIhrgGIdnArSb1WK+o7JbqiD/vlz0FJIFPi87n5iOPL2c340jdiJF+kYnh;4:wH/v8LK+0HQK9vCuBNnFy1gl3OPVQ5Cia5Jl/YRLaxftqEcZlSjFJV9UapHuYBJK27vBlEKv+zaqM8Gpd1k/mlH7Ie3lWRW6hQNOILa5eKnWM4ULFIwK2PCsDK9i+UhiNH7hIUgsug8bPtotp3zhkW+pWExVbR5iQw2jSDc5t6PCjM74AFTwH9Mo0hHNK6Ofr6Pf/rrzgjSPfk4DdpFBDAEQN6/eyViIayTZ8sqyxXi7JsJO0DTw5kDdv466yqN882iFAQP+arhLxHaBsVOUCV4uA5jQH4gfKVT53MYcBh1ul1YC6Iq7JImKaDxx9f1YeWZEqvDHTtEj+tcHwoJJGtvYSRHL8RBoxabPqm3ocLs=
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081308E2BB0C8094B8B9548BE930@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484)(104084551191319);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(376002)(396003)(39860400002)(189003)(199004)(105586002)(46003)(68736007)(25786009)(186003)(345774005)(486006)(106356001)(478600001)(16526019)(11346002)(446003)(86362001)(476003)(76176011)(1076002)(9686003)(55016002)(4326008)(97736004)(6116002)(316002)(2906002)(23726003)(6666003)(54906003)(52396003)(305945005)(53936002)(229853002)(33656002)(81156014)(58126008)(52116002)(6916009)(16586007)(8936002)(386003)(81166006)(8676002)(7696005)(47776003)(5660300001)(7736002)(50466002)(6246003)(6506007)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:Yb/no35hrdKH24mREyNUnn7/i/9A49c/o6S1o4PyY?=
 =?us-ascii?Q?bOCsUpOYT22/AOHVtE2YLbDDRyhKqORtMOE0R/NmUPoCDo3PijKupR8yHgMG?=
 =?us-ascii?Q?vpmPjKtH+CLNNkGDheh5XyrdcuGSQkJYPQkVSXsfK+Xr5CJAKxs+KNeOmmyf?=
 =?us-ascii?Q?lgTQrNMhdVnK6fTf/lrmuOp9GkcpbWAFos5HMdfb70/HD6RMbq65Bqq0+38h?=
 =?us-ascii?Q?P7tOuE5x677g/9Bqa/DqtNJVv3wGgCD4+2jFOeQ1NnN8q6kOYxxoSdQPzVUu?=
 =?us-ascii?Q?gr/Bp2Z2RPGZzQUv6EBQJDlnmvibjmun2Xz3PRGtfkkmW+FALE2lwQ+aE/HT?=
 =?us-ascii?Q?hg0WDgjzOvISXq5Dmw35D0lOcHTfygu85FLQ7mPmzJzkxjPv7s0QxVLoZR2V?=
 =?us-ascii?Q?WQEyawMv+shWeI28q19zKSgA9HRhf1UeQWvnYgspoFahkAq7KWSR803ZKvAH?=
 =?us-ascii?Q?HfHPP6KB6bWszlo43lYKXJ6ybbBRyJ1rle+JX3zh51mqj8bWBeUDCossO6P0?=
 =?us-ascii?Q?Fj20En72iksMcgbsosNFnXssrgIqJfmQ0towSu+PDZOsMaOGG7h1d3ExVQwe?=
 =?us-ascii?Q?wqm2yF87Sm9j4CiFXASmM4rpUxYOug91CrdoogsWnOF5uBgXnkBzVb2k0g88?=
 =?us-ascii?Q?0Ag8WlkyoWbGiwp+3npan/+RbaHkV4NAX/RIEXZlLtWvXS5oUXs0b7q0k0U+?=
 =?us-ascii?Q?jd4yNV6MP0KRtdvUYT9uCOp+aN9cgArQH+P67TuR3O5/vTbAAOWbyi2s/Xa4?=
 =?us-ascii?Q?wcGsAdlWqIwsjJ3DzGdXStLW++rEi/FHaMSN7VbxdWW3ewQIMwIwdvQyLrTS?=
 =?us-ascii?Q?0906tYqqObZ3J8AVN8VuUUtkeZ+gooidU2Ekz4Ttfke4tsaluChXDxCRjD0X?=
 =?us-ascii?Q?YITTajt6bu+JD301p3c/L8S3VZnZYD1DvUmVI5P4X/44A7r05jq4/wkCfz0V?=
 =?us-ascii?Q?WTvNH0H2wg0ZdFZsRj4choVtGOYHiy58wjioqP1uakQa3dRCcnYfGpOr6Bxb?=
 =?us-ascii?Q?JdQEpXwBTiPsCae57nObUoGpM2s/kd3J0T3ZTnnukENq3UbA23iwbzMeX8jP?=
 =?us-ascii?Q?KL99crsPKkuZwQyxIq7XSFBiyN3KzmJHcVXQ0Nlt7GXnMWRHmHg3gIi4tBmu?=
 =?us-ascii?Q?ehAc0+N+mob/VdHiywFg/ROaFOqKT5bTjsIn0FBu3+0DZSLqkVcJ5pw9i98w?=
 =?us-ascii?Q?KocXfcjLwX8hk63TKtwT3PlIgP2shAtdJ2uPUO8b/Vd9cE/wzUgzA2jgp2/g?=
 =?us-ascii?Q?i0t3I1/xZiCKFgIR4XoRYZNrRXMZoYGo03iy9K+?=
X-Microsoft-Antispam-Message-Info: 1o5iw78ZB12SqlNTcsTzeSnENnW3xr/S3GCv6zVNdlbL6xVQfDidLdtOujcWsNcpLvAGWPwXGH6RBzzZwpgDvB/sZoLUD39voTLGjZpjqM/qoq9Nh9uLso2wOe2aoj+gNi5qFg3awPungGblT5uxWNp+e99MbX1MvOOEwAdvHUPuDO4DX6QjVbBsSE2jeTc7
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:myKsehiAKuS98XU18KXISt34QJIwTRZsDINn64TqHwhMSxETyuFV8fblnPmBjIrvnaOjHOkf89IWMl1kIh1n6ZpRxVs21ILOMZNXK0nqLvkSS3yXBhEZ2y6JovWCPM23cWGk24y11cIHFr8aLqmLRlu9JupvWeT7mxcfp8JD3cOQ7BG0iBebw8/RhY2CIrSuE8igjUAfdhKhhro+IzPPUbEL/N01QRQLxA37aUJAeyOxz1Q/JDH/1o0FMAj80dW3PSZNo2Dl58ezfDSHvq27LXM6Oe0yinyklwaQQJY36jEdWhu8YaSzu7ZDRls+86Cm5AfZvIIulKdfaeKnQI2JW4qvSMsMfRJSD7G5zrrhMuDKIuvfQgzu1Z1TvPKGAqSY3nE83SGo84ScQDpaiPq0IgkmHxa/1cSyaCbNnivCKt77GBeDxHtp/1yAr459rNB6O56QibnB8njOdEsNyCOUlw==;5:eHD/aU6hxeuL7yTTAXE73l2Bx0fmSwayZF2xnDb7xo7TzjZi7gCyBkGyvSwyv4PJg48tUziUTvMHGif8G4SCvXm1K5ZtL0tPxQM09GMVb20NztxhIbn78Df20AWrd7AyHMkgmjsB4zl0Z3LdO2I+mbgwhFovZjzBqBdlOuWcbVw=;24:2iYCOQUjZbRb8x4VJDvJAsaYw1AM3Ip+6VwLR+tJaZiPw43Hni/PWBxUiHnTwGVk6ANDTX+z+HXDO6nvr4R2VgdHeBns2iKHExamd/piFeI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:rK9sBP4GumFQKWUGg9fGEPboDUPixiqUGdg9ZIusjzELd+ryKgPecMFxl9ptKOpv0SHMWhG0/dxNmjG8aUI0/OdM8iXIDGHiYRs7I9J5xRDUY77X8T57fTc0NiN+gax1op14Luahl2tyIbXDJ6T8Vi94mIQTjGiHAdEouxD10d8EedrGqXCzm1yohXSSPKKuNbrNVEl2NkN+N2dktVXnTPmS+X/t9yWKQbMhH/YWn6E0Ovoa9QbbaV/0+Bqv3c5u;20:yMHK/pOwRphkZYV3YXBVgFEZa9JPoUQsDRVTVrYfZT0hBCn3MrFCtZfZj0478ISRSnybfllh7+pSxh0+lA4Y/OoshRGiqv5IOJ2WM3jE0UV/JExAyafMqpM7HfmSjdoTXxE34PbCG9DAv/mSH7hLZwfERRjKc5BegwMZFjzlwUI=
X-MS-Office365-Filtering-Correlation-Id: 4df562c8-dbc5-44f5-c639-08d5ba84ebc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 16:57:18.5871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df562c8-dbc5-44f5-c639-08d5ba84ebc2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 07:05:53PM +0300, Mike Rapoport wrote:
> The new test verifies that memory.swap.max and memory.swap.current behave
> as expected for simple allocation scenarios
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> ---
> 
> The patch is against kselftest/next branch

Hi Mike!

Looks good to me, thank you for working on it!

Acked-by: Roman Gushchin <guro@fb.com>
