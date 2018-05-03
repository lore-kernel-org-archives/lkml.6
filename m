Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751190AbeECJFp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 05:05:45 -0400
Received: from mail-co1nam03on0042.outbound.protection.outlook.com ([104.47.40.42]:46304
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeECJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 05:05:40 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 00/14] Copy Offload in NVMe Fabrics with P2P PCI Memory
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-rdma@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180423233046.21476-1-logang@deltatee.com>
 <b8acf835-df94-9967-2327-8f0e39d88511@amd.com>
 <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <3e4e0126-f444-8d88-6793-b5eb97c61f76@amd.com>
Date: Thu, 3 May 2018 11:05:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <805645c1-ea40-2e57-88eb-5dd34e579b2e@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: LNXP265CA0012.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::24) To MWHPR12MB1726.namprd12.prod.outlook.com
 (2603:10b6:300:112::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1726;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;3:nEGBAOTVdL89MwTfA7N1P+/q5TZ8C8kpq6ZU0/CGi9JLSeFwoZBiFdoO+nalUdClFRjPqtDilyz9UjEtMRbg9W775NZ2DEYA6BU8bEwr05g7Sx411WeQlp6s+C09yvvfQrP8qZlG8zGW/Wpg5Icg0i6sjmaHUEmEJR+9QFqS+QJP1jpPOseeFfV7O4UZJJtUJW/28oRhVgU6acDa1w4VeaCj92OX6ro4Z7+efCqSrOsquN2P049dtfiSKX4bWPGK;25:c4XkD9rLgK/oLYu8DJ7jsGVBPvbIMOXbYKEdV7fZrYdntAzunnQrx5KS6wZ9lp117/tqVu3Rx99OriUjYv6KkmocLckEqVQZE1JCMLv+gC6HuqSa/GA0HNJNqV+GgkOxLNQfCg7GCjaXGAoKGKMk4rF+i413qY/qbvNmCD+z1M/zCREWmORxvr8uT8yg7PMU4Ha0s/WxKd6NJHDeIlaqILX73VruFYfBNIyS+Jn5VFZXcP/ExTcqCTM1XDVo0ij+xkPP3744MSXuSHviugcWWphpQEkK3v97cxq8s+Q1QXWqSi6qDo2gkgdF62JAo15hrsbt2zePfBzp/VWmzAH4mA==;31:YZ4Uqvf5khIHULxSVpvp8fTKINieSDFs+r8HC/s3XmVlZYvsSUF9otiQnRAA/7rSKQ5qTvbbDUxvTlNAHbt6ZjjAdyB0OhPBVYMQzmDh+GgJC4qte0q2LOueftQYLcLojsk+u5zOMHfUehcP/fU2JkkmdqwAGVRywFoVnsCteUla2iwe1ytF5WoWAzKGipQva7WcmDjw3Lk0L/ugMaTSTOYgC3Txy/gdqh3yfQ6n2KA=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1726:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;20:dpyCbmRC+reft1tDYAK3Mth0iSCjxMqo7u4hP1vK+fPwmdCS6BI+kPsjTzjfF99pG1wqYC/iCkXf7KY+DKzgaGE5oWXrhfU0LzBI5xZ7weiMkM+8RUAxceIpNmiT1y3GLIemMsOEuvuZensibWQqH5ARk7xNGPd6eXgXi4GJo23DgmwD+zV3LE12k1xieaTBhuXHQX3vOgUT6WHons/cyTE/VPUn1tYQznXFAjFBBg4rXeO82lRmWOirnibYZxnFxlqRj1hBqAnF/8asZk6X4JZIm+cuBpDFciaj/m+MSOwL9EPCa0CtfpgAkKcFC8aXK2NTRshGehCqQ5e6mqHf9om1OHQAP8ESZ3K6QQFMjVUQ+JH9YJd+D79HoGWg4r5g1IOc9sd/O8Y6APxQAw7+1Yw8P1eQH7CYb7MG89hzEarPW0ECL4R/z+6I3iCIVQPHpmstLY5+aMvXMDO+rCV/bljel03i2ToZC+D23WeBnI/kJvH1ex2btBwKqmfk39hS;4:dcaLvIZ2XC6SZXIgdX9dNIvClU7nHZcqkeFNrOo3wdnQDM5HiGP+142SJgNb6aLQMGtE/0L5wZzBSEZ9NHg6bvgL1zfdFivagRa/QaG2Srb0KH6TC43Y0V1NT1p074hxzlKxrm1hf7k7Yvnu3OeKVvJtLt2UgEHRNk/Sc30yiEDUdmuc1rA4519+pvZRNU8jjaIdUWHDWr1dGt2eJumVivnWIK04VotS3q0s/IiIUbTAObDfNIMoSgfPEbIjHLEPVMWXAVWqawJy+/UPLwMfqw==
X-Microsoft-Antispam-PRVS: <MWHPR12MB172616947CC06E0D4B24669183870@MWHPR12MB1726.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1726;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1726;
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(65826007)(50466002)(551934003)(59450400001)(2616005)(58126008)(5660300001)(6116002)(2870700001)(81166006)(476003)(478600001)(6666003)(72206003)(11346002)(8676002)(229853002)(47776003)(31686004)(65956001)(7736002)(316002)(65806001)(7416002)(8936002)(105586002)(81156014)(4326008)(386003)(2486003)(23676004)(31696002)(551984002)(86362001)(53936002)(305945005)(97736004)(52146003)(36756003)(76176011)(67846002)(1706002)(46003)(52116002)(25786009)(446003)(68736007)(6246003)(52396003)(53546011)(16526019)(186003)(106356001)(486006)(6486002)(64126003)(54906003)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1726;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNzI2OzIzOllnY2FCc1Z2TUxoeEc5R2FpcENVSmZ4ZE1M?=
 =?utf-8?B?elVqaDRsRmxiYXNmVmI4YS9sSlpQbGsyTkoxN1BCTGtoSGNmQldRM2ZXcUcv?=
 =?utf-8?B?LzcyMXJScE55bm1VcWdNcFlnVWpCTE1oUU5kdk1ZWG5mTDF6ak4rd0hpT0th?=
 =?utf-8?B?Vmc2ZW9FdGpPYi9tTVp0WnF2NFpkR0V6UlRoWmhGdTlJNW1mcnF2ZW42UGdi?=
 =?utf-8?B?K2ZRWWZPOW1uLzdwY2dvUDRwVjVad1dla1dZNWxBTmFnMXlVM1k5VW4xYkFZ?=
 =?utf-8?B?di93eXRsUVFNYlZ1SmtHdnpMU21JWUw3S2FuMy85MXF3MXRmNTd2b205ckRC?=
 =?utf-8?B?TDZ2UktlbHNmblE0V2dwaVFKOVZ3U211ZXBMUTA4cU1YeFFiZ0xUQmFLNWxw?=
 =?utf-8?B?VDhEVHdGbUFSaEcySkJzMFptMm80eUhLc3lMR3hnNE9JbW5qQWViWnhYc1Fz?=
 =?utf-8?B?RTlyRFZkZ0pmVVFhRXJDNDBYVXg3TERVY0tUc05KNGVnZGhBRzA1VFIyWVM1?=
 =?utf-8?B?L2YrY3MrTzZVemxVMWpxSGZ2U2FjcmlXVG1oM2hsYWFNbVNCRVIwTHQ3TzdC?=
 =?utf-8?B?TjJDWGN5cDBmeXBrcjVhWTNUYmdLRzNCTFVSU1JmdGVHQVdXQzUxRVhhNjJl?=
 =?utf-8?B?RTl1TmtKR0pNdkt1bEQwc1NQQlB6VEQvQytkQytibm9yc3ZDTkhzTE1LQ3hX?=
 =?utf-8?B?emNVYXFTZ0ViZHdKaWg3cndGOGZLNWxDMVdGRG13TkIvTENDNjJlMktiSita?=
 =?utf-8?B?Y2tPZ090akl1V2RGMml0dUJsNUJ4QUdrWWs5djNra0Y3SVBqZHhzRUVmeTJy?=
 =?utf-8?B?ekdNTTZzNFFIL0FSNmRVVkhXRjkwNExKNVBEOExFRGxzRjRscUpOOTg1SlUw?=
 =?utf-8?B?OVB5N2d5b1lOdW5TM2ZPdk9rdzc0Vzc5eisvbFk4WHE5WDZxMGJsSjUyemJH?=
 =?utf-8?B?TkgvSGswaE1vcUJWM3NSR3lYOFB4VTlxRGlvTHFnb2R1R3N5clNGNVkvN2RF?=
 =?utf-8?B?UXpoOWlFb0x0b0g2TXhLaVEwTjU4ZGJnWmozbWdHNFd4Q1FKeHBKQXJ1a25H?=
 =?utf-8?B?WlJURUVkNG54NzFxSW15MVFvRXZpTDNtODY0cVM1N0ZWZzVXQzE1RitZbmoy?=
 =?utf-8?B?cUU4MHk2anUyL1dtakNaeVEyT1pzTUlsaUl5MSsxVE04N3djQ3l3QjRjVnE4?=
 =?utf-8?B?NDdqamJ3ZGNsczk2NDdVcndrenEvczdGZlc5T0hFSHQzTm85ellDTnNvN04x?=
 =?utf-8?B?MmdKNWoyeHl0Z2tTZVhMTjhWVjdoM0JJVmVKTDB4aVRHa2htVnlnU29Fbmdo?=
 =?utf-8?B?U0NiWW0vVmZEK3Q0bTNIV1RPLzJEd01GMW5UYS9ZV3QxWGxCZVJIN1VDVmVO?=
 =?utf-8?B?RzZvd1FIaExFSVFVa2JCTjk4SVRCeDNvdHVYbnRKcE0rc3NnOS9PeWVHOVpq?=
 =?utf-8?B?bndpWmxHeXF3SUd3RGZCYS9kTG5GaTVxYlp5ZTdJeE1odTBVVEZsOTZBZlZk?=
 =?utf-8?B?UW94VHcwUHZxNkYvSDJXblBkMy9wVmEyMHNlcWw4NnU3SCtGTUNia013ZDNj?=
 =?utf-8?B?a3Vsd0VlbGZOdjFFZE5WNmRmbjdrK0kvVXFwUU4rcEVKWFdJdkovVWFOVEhP?=
 =?utf-8?B?QndBWHUyVm1hdWlJTFUvY0R6SXlvK2MzR3FaaTU1a1JsSkw4ckxBV0ovNmNZ?=
 =?utf-8?B?WE5IcUJZcisySjl6QjdZTDh1R2t0NyttRVlDaFdiTFlYVkROYjBiWUdtcGdt?=
 =?utf-8?B?czlwdTM2U3hnVEY0Q3JDWEFoQjcxUXlsVExqTS9oZUVEWVZjbTd1MEJabUM3?=
 =?utf-8?B?VUlldXU1NHh1L0pxVTRpWUZhelUxZVdWSUdacU9PUmpwcUszL0RDZmp5Qy83?=
 =?utf-8?B?Sk9tTEdOc3JNM3d3UmNDTWxuaHkvS2R4ZXZRS2N4L0Z6U2JTTUhUd3VVdmFz?=
 =?utf-8?B?TkN5Q2xibFV1TmF2cjNQbElGR1BTS2phSEdoK1dtbmU0aGJ4MlVOTjZqVk5D?=
 =?utf-8?B?akZobklyYStST1NTMU9ZN1MxSWxUMVNZTS8rQT09?=
X-Microsoft-Antispam-Message-Info: fdqszJk3UmRRWmSyDkRP/PyXW9jjAbQWLUJqcH69JlJ0eO0QCgy8fG7Tc6uHHXkMjbtlQPc5T4nmmjVGirO5JFCnWXx1SESUbxLwGPVYP3Z9UwzRkN2lHPHL55heN3vGQHvt0ufBmFc2A3Uw8CJ1t/ulrIWNAnTgvwcanec6OvtUNqfo2vVDTme8IXxvcj8o
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;6:C6UuXafhZs8PrnMS5Y6wbT5yTIYCODGLYIzCS1BNmkZJdYiou/W5HuiOPDjTXGhDMPFnhq8sDJIfKNYYexo7776YpSXeTtVFm4pK2AoASm5ObxGyhZpA6Gd6MB360zriVpHtd0T2e9fC6O16eUItbSh67k04RGeUFMRWNRg5FJn3DTrDGqbqbNSNPHjNq7e4LF4u1+hk4H6JM9xrXuZV6gmzbTWFFrTnD9g8t2Snhl40stkiqK+04PAfzk4aakMUQWqA5JVOGgCNC80uD16NXbZkSgDkP+I+dQMI03Bb06FNLETKOvIl3nGfPM1inEQsRtk/gQtuS+V5wotLizCapvgdg5EzawRioPNR+hKxrpTaFdAJTaXSj36BKfxg/Prg2nKiZO4y0CZ+PsIk5ToJ9zYSA0ZTVxDqayOTHwv5qzCDEeYRFUR6uOk4qSMX6/3JiBHzXxYd9majUp35PJFNMA==;5:UC2AIxTMPknmFOO83VKXxZikcihpOvI1XQki4IjMJQ2YUL2DDEO12AM54zBS3NXEGWYBiYCZ2Ea5oIfKRO9FC1zwKIsM2Cq6rWxnMdPdOURcozHEFMf613HnIY+9ngZ4E2UyZFx6AHIkCrF0c2O5oLEt5lQ7SgmhzJdQVSOU+zI=;24:GXXV5/OFWbupr/7+WD0vEFfLKCUXPZL3p0Bh1bupvEsPgOYMKGJTzlRjNjxtfg0Pgb6VCe97cbosk9rFo1d5x3bNyibYcdi+5qCc00RfdDE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1726;7:GJVrYBcQpe35MtsJIefuyBPMKYl8+R+MJLrmRnrbEJGZWJnYZH8LS6JwkCweqGXK6bvtqSwxWD0q9binBu8KBaEZSscrC57WyeWXIRfHvNFyjPQ7iK6uzPZjVTCWqV1hAEWCm1jjeSOstb+3RcLx3mo457Piwqxn9UhyYn7VCtwWQjiHnBROFIAYss7byvpi9tT3vb0+SJkE5CIAWiVXxQlmz4dlPe3h7FlJyGzYI7Z8OFx14wWggBH/EWUuQlXm;20:N2jrm4wq/6rY7+Gt+SVpYrWvN/L/o961Z1JGtKvf7A5z5bjeDNj6XbUQ5+AHHPXnDktcQIuYUxM6x0Qn5+LtpX2Bc/AXgVLuXc1pIdwxmOmQRyJWX6potQqmJzy3nbmJXlBmvscHiFzzHDCO8wPspleGS2iygBE+g7ILlY7d3QsJZEclKpfHxG+ndZ5EYWbk3TvYWyoQDOoWnFlxuVVtvEhCYpT5wl0WhGULHMoBkM/9D/RktWiTYyLyWZ4gMFca
X-MS-Office365-Filtering-Correlation-Id: d0fec333-70b0-4fc5-c597-08d5b0d50952
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 09:05:32.5610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0fec333-70b0-4fc5-c597-08d5b0d50952
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1726
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.05.2018 um 17:56 schrieb Logan Gunthorpe:
> Hi Christian,
>
> On 5/2/2018 5:51 AM, Christian König wrote:
>> it would be rather nice to have if you could separate out the 
>> functions to detect if peer2peer is possible between two devices.
>
> This would essentially be pci_p2pdma_distance() in the existing 
> patchset. It returns the sum of the distance between a list of clients 
> and a P2PDMA provider. It returns -1 if peer2peer is not possible 
> between the devices (presently this means they are not behind the same 
> root port).

Ok, I'm still missing the big picture here. First question is what is 
the P2PDMA provider?

Second question is how to you want to handle things when device are not 
behind the same root port (which is perfectly possible in the cases I 
deal with)?

Third question why multiple clients? That feels a bit like you are 
pushing something special to your use case into the common PCI 
subsystem. Something which usually isn't a good idea.



As far as I can see we need a function which return the distance between 
a initiator and target device. This function then returns -1 if the 
transaction can't be made and a positive value otherwise.

We also need to give the direction of the transaction and have a 
whitelist root complex PCI-IDs which can handle P2P transactions from 
different ports for a certain DMA direction.


Christian.

>
> Logan
