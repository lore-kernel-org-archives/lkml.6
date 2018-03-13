Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCMSyK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 14:54:10 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:58912
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751606AbeCMSyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 14:54:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com;
Subject: Re: [PATCH v2 1/5] iommu/amd - Add debugfs support
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <152055660594.63229.5131049527614494130.stgit@sosxen2.amd.com>
 <152055664720.63229.16209149030018336339.stgit@sosxen2.amd.com>
 <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
From: Gary R Hook <gary.hook@amd.com>
Message-ID: <30bd9559-0e44-bd18-6b9a-ec35bc8276f3@amd.com>
Date: Tue, 13 Mar 2018 13:54:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdK6qFopBE4rD4yNO5GHccxyte=GhYU7YGcWOEYSCyX8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR08CA0047.namprd08.prod.outlook.com
 (2603:10b6:300:c0::21) To SN1PR12MB0702.namprd12.prod.outlook.com
 (2a01:111:e400:c42a::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 81d43744-021d-4bb6-4f6f-08d58913cbec
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0702;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;3:tMIZU+0nDm/0/qBffNt8rhLGW3y3OiJSeOPjXAsJlI6S+BxoFzUK595ncNI+lsu70eeo65x3RFAh4IGgosDqP6htzvKc9nb2VKOrxgCP5Y39ljIm5GL3mTKU+6Ibh1MUsb4aQhn2X/21GQpqHiTi9PQQdkAjaNqzvidIXAc8GIX/zS5ijKhBnERr7xxL/SzCW+6IH61cIXEUGjk/jysVt2U8L9iynsiDKb4aAYQHyDS34bl7K1DGBRPUZztvA4iY;25:4mPH+LLNHxphYMdu8me23ujEJzpEGjWcY9n0+RkXqJIGCw9vVlwyd13R0ll/sJ+Fov0UXP/aHnNo3Oc7CO/EvfFFsl2mN5DlwRq0uy8j2+yuVAu7PRXT/x+HIhBVDiASjzDjJU6GELmJ9ROo/SSXfBy3sjXqh08u/yw9NorWH1y9NtM44YOrq1QFuq7D9kLlJftzT+Pl35Eyb/q9oE2HFx6j7rEAAU2ei8n+4CnUGCucLCrmruy3l7uPrlThF/iXOfL81qGrPuc2suoXn1LkAEqLR4kqMnvYaKc83gZb8zo20ARxzpwCcyfX0ozoy89ta+5Qd3ZF+ljJIo66H5UzuQ==;31:5sQzJ9JMCD2sw/a4xmFW9bnCMRX2OX2KMcXkDx5U38mq7U4xcLibxG0sg/YXTnLhN3WuSpTBE1y8yMZfYlkcgJDzFaD50Sy1P21nOLdry6/GJod2NTq+atT+1apYo7Y2Ke7alcFjzs/JyVwFkUqvFxJDGpRXM/9YiKNhdZ8tVWWyLWP0WXXHmtlr5LH2ba5HSE/MkV9K2NT0jMyeZQG7DNLnIZGSRcCWbJpswTVx2GI=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0702:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:ED8fGX2D9PwPi1Lhj3XYytlOgYmWR5oAZXlJPX3qf5dJ2tkd0UP/2W9lODFpX/xffX2H/hJw+ywprwblXGIazN8tpJzmmtvsSpN+oGDwFvNKQU3PbiPl8uONCOAS8yJzjHTaEObA5pQO6TVcYes/FMwd9edSYWeVuGWcAlrGdGMAOR8GV48B5NcgEMe83nkVliqFH0yMdotNRkMnGun1JFoCMpoEHt5fIi/k9Lxg7rh6KjATTfwL8gFEeGjFa64Z9GGc2d9pgcXiHaNlQo/92QY0h6iNqfswGFAt3ajd6LxpSTVjL8+zfF8ufmpwEwgyP3ecZLGtqFIhCItv5+jGce0jehJ/tqoXCbt++ytlGiPe4LeMlGcmBIOcd0siUWloW1uUwmgv+DMTNHCwQ9r3WxXHHw6PLCyFrCybeviXhdOP1QdSecwUA0UkKIeBWdF4DZf9rLIpR3vDiTTGW11EfmmhfLrWzI2f6L+zD52IFougLWFheEhWvk4MtDO+//Dt;4:ygaqRdfK2MKSN2k5qB5YQ8NVd38eXtNQ67LcBFsNJonyYQ+uhNBQXdSxxS9mTsFyWEPFWVym95/m0IkOOR/3NZcrCUIC66neSsiWjGZ6RkerrQV8CED4Zqk+KG4lb80mFPdRBzyL/me0IwIWV5CbUUtNO7/vswgNEiQ9gH0FRmg+BBiDKDKyjUg2mBFt0EZSC80Kc+YwH/nbV0TSYcjRDz2KUDyYP+GRyXUEQoaPpFpo6jf+OGdoYX9K3aynmeEgGtSRzHNpXg+Zjer1Yp0drFf9Aec4A32KzCyCndgp3izQlt8E9wPdMYgOQTQK5VPo
X-Microsoft-Antispam-PRVS: <SN1PR12MB07021A4F5EA55B46C3ACBBF6FDD20@SN1PR12MB0702.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN1PR12MB0702;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0702;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(396003)(39860400002)(376002)(366004)(189003)(199004)(54906003)(6116002)(59450400001)(64126003)(67846002)(31686004)(16576012)(186003)(386003)(6246003)(65806001)(77096007)(76176011)(2906002)(2486003)(4326008)(6306002)(53936002)(966005)(25786009)(53546011)(106356001)(86362001)(66066001)(3846002)(26005)(65956001)(52146003)(23676004)(47776003)(58126008)(68736007)(39060400002)(229853002)(52116002)(36756003)(31696002)(230700001)(478600001)(7736002)(6916009)(2950100002)(6666003)(316002)(16526019)(8936002)(81166006)(81156014)(8676002)(50466002)(105586002)(65826007)(72206003)(5660300001)(6486002)(305945005)(97736004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0702;H:[10.236.109.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwNzAyOzIzOlIweTV2aXQ0WTUvd01PeUQ1OSs1QUFMbTM3?=
 =?utf-8?B?ZlZqMnB4NVdJV05ORzJCUnA5OWFDQUp6L0FFUjduNnB6b3NRbnMzM2tZVm16?=
 =?utf-8?B?UU9ocTZKTFYvTUVwaU4xYlZDL1EzOXd2SEJON242aUx1MkxheUN0ZU1pVW90?=
 =?utf-8?B?aGhjRmI2UTBnRmRNZzBzZHlYaDc3REcrNDE0dHJ6TFFxKzMzKzVzWUdYNGVM?=
 =?utf-8?B?TFEzZXJXQ2FRSTZuWUw0MVN4NmppUG9mMHlYKzRtRjQ0clZzMnhPY2NTN3RQ?=
 =?utf-8?B?WGlGbFVVMVNvcGF6MzRJTmo1bW9xZ0g3T1pKM1ZVdDhVa2c1K2xxQWhVQU9Z?=
 =?utf-8?B?Q2Z2TllQa2RUcW51UlkvdUxKZTBTSksyNGpKNTZvYnlocmNRci9waDJHSERJ?=
 =?utf-8?B?NXFBTVhrUUZpeDBqbHZvL25taVJjT1hGOXVQK1NsRU90ZXRvYWIvMDZtUW9K?=
 =?utf-8?B?TTRqcll4T3RjUUlvNHNYdmE4MTJFUlpNOG0xRmRzNDd6bDh0bC9JT1I2QVdM?=
 =?utf-8?B?N3lZL3Y0dXBCcnJJRUV2VGN3Uk0yYzRZeTRPS1crNHU1YS9FYTh3MjQyN2g4?=
 =?utf-8?B?aFJhbXNMdDBvTTVGakQzc1d6ckVQOSsyeUg3MWFHTlMrazYrdHNJOTVpUEQy?=
 =?utf-8?B?NVdIMFFhUVV2Y3VUV2h2RFdpdVBrUVhCdlpjRHpDUFZLU09ZNFo1Q3lnYTI3?=
 =?utf-8?B?dGl1NzRhQlBBdG5lS25XY2lUaFZzbnFmaDkxelcrMis5N2dibjJBbndJWGZo?=
 =?utf-8?B?KzRxTHNYNGE0bE1NTzE3bjRWdHFxejlxYWZlYStpZCtSTGR5blUrZ3Zyc0M4?=
 =?utf-8?B?RFN4ZXNrUUQvd1VuY3Z5QkVWdndsTHVEaHNKSkhFeGc1NERpRGl4WGQzakxX?=
 =?utf-8?B?TC9DMFkrSytaUUdiVDhjTEFMZDFxbDA3VWNXRndTbE9Dc0pkNkNqeGsvWnpt?=
 =?utf-8?B?TURiWVpUQ01hMVFLOUx4czNZTTZVekxNSVRSWkZiVXdoTGM0dDVWZEpDbGY1?=
 =?utf-8?B?TzFwYWlraXpaYmdFaVdlQld5V2RvQVBab3Q0OUtKNVBuQTFKRFVBeFoyRWdz?=
 =?utf-8?B?MWs2Qm5CMmZtczN3cTBiaitIWWJOZlNKSVdMc0RRdlJ2b1FDcUcxVVNZbzVL?=
 =?utf-8?B?VTZTSExrcVpzN2piMkVQQUV1UmJiblNIZ2kxV0w0V1VQNGlYRStOc2tWWmtl?=
 =?utf-8?B?RFFJUGxEY2hBcGdwb3h6ejlESjVXZ2NxcisxSU5JcEZPMURUM1pMbGJCSjJy?=
 =?utf-8?B?bWRjaUNwQjJaT1FaK0RkZXRFaHNJdXhmS3dlN0hGYVg2cktLMFFBdklNSFRt?=
 =?utf-8?B?QTBhOGFRUVRjWGkxa3ZiMGs0QnFManJGcmFzeHcvQ0tBbkZDV2RHM0dDOHFi?=
 =?utf-8?B?RUJXYVBWTzRqZ3Q2dHlCRFJnWS9pM0VHODhaVVJTU1ZSVDhuVXF5S00wNUt6?=
 =?utf-8?B?aFZrNEljZ2s4ZExVeFR5S3lpMEJNaEIyMEp5VXQ1MTNBTTM4YmxkOHpSRzhX?=
 =?utf-8?B?cHhDUGJ0WFh5bm9OUmFxcHM1MEo0a08yTS95eEx6ME1WWEc3T0laTnNJRDk3?=
 =?utf-8?B?bU4rTHdtUU1WUWNjWExUaTBJRUF5WWhyUXdpMzM0U1UzRWYvWGU1SnNZVWcy?=
 =?utf-8?B?NWdhY0Y3ZDlKZDdwSlVXaVNGTUhIa2RxY0FzNXc2ZjZnVFlGVnNORWxiemF5?=
 =?utf-8?B?WXM4aG5YUHhEWjVlYm9GSXFmREJDSkpBbHVqQmZCSXRtdTdGYURsUHgrZXhk?=
 =?utf-8?B?SnlBdlZubi85K3VPQ0gyY2RRd2RiSTcvWVlrKy9WVjJlYmJUVFJzRUZiMUI1?=
 =?utf-8?B?NGtuNm42TTgyMTZsbW1EalpCQlVDQ080YVBtYlpJbGlSWEY2Z2l5ZzV3TlZm?=
 =?utf-8?B?ZG5pYlNrSHBiL3JOQlBMY1ZmdVZvTFZFS1N0WHBLeEtxNTNGRTFjQk11amN6?=
 =?utf-8?B?RWRib0JmWWp4alFFMHR0SGdSdHVBQTdNa0RMcmk0Uk5mWWNHOUpsZ3c1d1c1?=
 =?utf-8?B?Q0ZSYUdYcjVFc1FUZkUvQktkcWduWkJPclpoQT09?=
X-Microsoft-Antispam-Message-Info: jRkuK4VJf5rZhmeGjA/S6gQX+PAIvimMr3MhMpxN48j5YafT0381ML5BqrtrXwhYfve8+gwq1TU3V+p/xrvtkwmKFZQtXPsy7FzRB975ROT13kVm8OS9YUhNCzVOvOKXG2htK4YNO4HgODy2+QxEhtnPeQ693CXoZH8DgSaOXLZFwmqN24g9KPh8lgKbToA+
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;6:nQbFS0krHSvD6wFCrIpREJfAf9k663jQ7HCyPsGvMBRs6n/y5oxnixyT6tsOz99OmZx33J29/qntVW0M+1+L+8JmMxFxr6ZDu9FqwsGaptMkH62ZjBl7UCyFPLTg4fOjoAPBqXH60CJe/+hTWHOwSHRq0YcuKskOgGTDinOlqEEQCNN05BaCmxkQAUc6mYyqkrZL0PJwXpOQBenOtzBmSvH1ybWacFYwwPStX5oGyn2FFjD7fTh9gJhi+cxZpjYIjZlafYWGzEXdjQ0o7MLGvGAKitokkBrWbdG60q+V3CD295wcpCPeZ75rBB/73tO70+vemO44WUV1GvfXSGblwxjtENhgquFBPpyhVAXWAng=;5:aCuQpv2tDL3/6yAfuH3xuWq2tdGsUXJUWY6RSxwtVdecnOC1Y03pIRqrqccthLIKUdex3HMERV0wW/frJl5phj+tIvdU/1loje8dJWC81OQwPYA/U+kfj4Ccn78NYwv380OHPyA1HAbNcRRy6Vu5a4dgHOiArTRVynB//5Ri9Gw=;24:XA0GkS890BGN1L9o4ff5rCjf+H+cQfDsn77HOhYVWCH5PGpXtV8gCCmK7Roe47AKHvkfFwJmDjaeWWb8Ck+bOAwg0PFCKVNoBbocggdaHwk=;7:Jvaxb612GRg/gBh8q/xJQggSjV5GAIvWjMHCcSNfaYa9s2+fn1+d8mRwG1kw2QLLszrDhuv+6fX0Qa2TXa+70LoJY/omEL3PZchBkAKpp2WpENiOHpIfAJcSqARbHcingZSf1euJlyKj/D2j3S53mfgtLPctCIVSVzA3FssXDoAsL5sSwIKyvGPpf8txIOIMWzcuVdxz++FcU6Jwzvj6RDn/CET0lujXQ667EZnDr80vlYu+oPtn5+Qp8xzB2iFS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0702;20:/hW3D19H1ZiJs1tl01kYBWF6DE4Z9kbIFhAtCfGV3mN98p/8P5CZX1ZVLXowsa/jGggMKDXYRuMHG35DAQJ4q46wYPro2QzMuXgMW5GqlfkyHuTBXhzDeLL5IIRVRkeKUsOxY7gd50CwyTqeQwY8Af3IqYELrXmaR8TMkB2CJtdWc1JE9jKB9+gAqxqNScnsfiPtQf1MaWb1ZjyXfQD+QGPDn6POOi1gRd3pvyU9B32E27qKMWsFc7OaBoWosWss
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 18:54:05.4563 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d43744-021d-4bb6-4f6f-08d58913cbec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0702
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/13/2018 12:16 PM, Andy Shevchenko wrote:
> On Fri, Mar 9, 2018 at 2:50 AM, Gary R Hook <gary.hook@amd.com> wrote:
> 
>> +       default n
> 
> Redundant

Roger that.

>> +#include <linux/pci.h>
>> +#include <linux/iommu.h>
>> +#include <linux/debugfs.h>
> 
> Keep in order?

What order would that be? These few needed files are listed in the same
order as which they appear in amd_iommu.c. I'm gonna need a preference
spelled out, please (and a rationale, so I may better understand).

>> +#include "amd_iommu_proto.h"
>> +#include "amd_iommu_types.h"
> 
>> +/* DebugFS helpers */
>> +#define        OBUFP           (obuf + oboff)
>> +#define        OBUFLEN         obuflen
>> +#define        OBUFSPC         (OBUFLEN - oboff)
>> +#define        OSCNPRINTF(fmt, ...) \
>> +               scnprintf(OBUFP, OBUFSPC, fmt, ## __VA_ARGS__)
> 
> I don't see any advantages of this. Other way around, they will simple
> makes things hard to read an understand in place.

I used this technique in the CCP driver code (where it was accepted), in 
an effort to do the opposite of what you claim: make the code more 
readable. Given the 80 column limit, a large number of arguments, and 
very long statements, IMO something needs to give. I don't find the use 
of #defines to be obfuscating.

I'm not trying to argue, but rather simply state the perspective / 
reasoning I used to create a source file I feel is manageable. I have 17 
more iommu patches built upon this strategy, and this seems to be 
advantageous for all of them.

> 
> 
>> +       for (i = start ; i <= end ; i++)
> 
> Missed {}

Wasn't sure about the M.O. given that the body of this loop is a single 
if statement. And I don't see anywhere in
https://www.kernel.org/doc/html/latest/process/coding-style.html
in section 3.1 where curly braces are called for in this situation. May 
I ask for clarification on the style rule, please?

> 
>> +               if ((amd_iommu_dev_table[i].data[0] ^ 0x3)
>> +                   || amd_iommu_dev_table[i].data[1])
>> +                       n++;
>> +       return n;
>> +}
> 
>> +
>> +static ssize_t amd_iommu_debugfs_dtecount_read(struct file *filp,
>> +                                         char __user *ubuf,
>> +                                         size_t count, loff_t *offp)
>> +{
>> +       struct amd_iommu *iommu = filp->private_data;
> 
>> +       unsigned int obuflen = 512;
> 
> Sounds like way too much.

I can tune these up.

> 
>> +       if (!iommu)
>> +               return 0;
> 
> When this possible?

It was intended as a sanity check, but if this happens, much worse has 
already gone wrong. I'll remove.

> 
>> +       obuf = kmalloc(OBUFLEN, GFP_KERNEL);
>> +       if (!obuf)
>> +               return -ENOMEM;
>> +
>> +       n = amd_iommu_count_valid_dtes(0, 0xFFFF);
>> +       oboff += OSCNPRINTF("%d\n", n);
> 
>> +       return ret;
>> +}
> 
> 
>> @@ -89,6 +89,7 @@
>>   #define ACPI_DEVFLAG_ATSDIS             0x10000000
>>
>>   #define LOOP_TIMEOUT   100000
>> +
>>   /*
>>    * ACPI table definitions
>>    *
> 
> Doesn't belong to the patch.

I'm sorry, I don't understand. The added blank line doesn't belong to 
the patch?

> 
>> +#endif
>> +
>> +
> 
> Extra unneeded line.
> 
Thanks,
