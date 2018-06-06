Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rjLDauz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 60162605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932567AbeFFI0a (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 04:26:30 -0400
Received: from mail-sn1nam02on0056.outbound.protection.outlook.com ([104.47.36.56]:63952
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932364AbeFFI03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 04:26:29 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: radeon 0000:1d:00.0: GPU lockup (current fence id
 0x00000000010da43f last fence id 0x00000000010da52d on ring 0)
To: Borislav Petkov <bp@alien8.de>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <20180605144404.GA7389@zn.tnic>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7921bc34-6e63-7869-0695-70baf9d480a1@amd.com>
Date: Wed, 6 Jun 2018 10:26:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605144404.GA7389@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM0PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::20) To BN6PR12MB1714.namprd12.prod.outlook.com
 (2603:10b6:404:106::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:SlJ+fZMXZ02c3Svy1O+kNN03ULO6+suOH3F5nbCbYyZQU86gGdLyhojyA69U284EBhydxAWLhBbosR2O4szWmSmGODvPwU6PAqaskTTrO0IAGh2322o+SO/PtbExoCIJqMkWfOua9fc0uFgjXvFY+tQKRncrYdtgLrduy+caQiCqVoFAoHxPFRlz8XR+bHRnGMYb59O1n4bVpttA6Oqr1C6uqmFeEM/Zcg92oSfYXkgs1qbEBbnPaxggxf8r8d6W;25:qpxIXliMcktmoS39kejHgvVAwChC1jodrwpcaJjd+k5gw77ZEPcRnOR+t5dPkqc1XUATNvNx6U7u4xMU8KmkQeVrQdhKkrfLeBOR6HfwcvEAGanidMYraJqVn4DBACFaBaPu5JYdUEWvFzodsPSuLEqG5H7/abg9xwaLXzGBace9853x9vQb9dKZrVnvEb44j13fawxBK7T098DDrYzw3dJ6dy457Fi2+mtkhIiRAWHpE6yqXoDj1QsD0UfP3hiWOdcIvlm8zAPA4FZabyVamvdwSwZQdbXxaEdOwFR+HU0WYpaK43AKVU4fLXJd/JVguMhiDRjv4v5gNJpwf6f7gA==;31:ymNvs75zNBHNZv3RDC+3wi+ceYAkhsl2y65gVNz2IUYbwS8A3PrUZHWtE/DJEGd1WTktC0fgdirItc7t0Q0fv5ZDQOr19w0nJAGAFtcIBUHn6sc3h3ZF5FcOBbAMTcjfdkVUHn0gt0I6crJJIOSVNaVV4g6gZJdOrzfHjAALdNqaSEjKeWrg1hCiSOg6DzkmmeiJ+HGrHdERxjTkeU1VsDmWDr5j0rPZdNdDYA4NvWw=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:FrbgTjpWt+UOUM3FeRkG4W302U4GGcDXZbKcfB7/zdGiHJshtqSFooKnfijqn3WSxBHMJPJLzHzsLVRdMg6FnqkaAwdimp75eKQeggWe6g9LGTcwVSbUOHg0ltlh5kJW0dBxiuGBBoscJp0qNqEfYvaK3HHjotBXEm9peMiWDHto8I6f65gNS6fV1ncOnAiEzk5AQ/JKxjfZzjjaiy9uqU0ZelWe65zL04sliYeWn63s6OIUXDgLyNULBg++1e78VBhJVNq1ydyNnjZvu9tzcfP94wgDOekvJHxa21W5xSsR8HRPE/pAIRRE8JZfXXUOU5BIbHdCQsrMXaZbmNYtHUeuNQ3OngYP9oifH7YYub31XBJBINXOR1V517qZXJsabk4n0VnXZeA12qxrN3qJHhp8dSXYv33lcHM6trQLJeNFSaq1zY/H69+FaRAcNV8W6SICmELOpFxQ6kaOd/04D4yRiC+KUvTOw5nR3nxlpG9vQeFMAEfGmv6NG0gf3k4W;4:7arVdDlYHKa8HTXiZ+/vzQyjEl4P3mkI5QcqcgBNbU3G2n/gjDu5EI4yyq3KANCoXgVJQchPniFxQdTMMmVpIaCUxOltDRtSbMauPKpcSp8fuEdISe9D1dNLof1p5ZgU0ZCFREULuem1GJUakgIrkhdRMCq8HECa63y1i3juCLEVO2dtPvclmoI3hjL5MIWDjmP6ZO7fBaoeLgD+Y5iv+OR0j0CjNcuK2waGdlWyKjMaxnAlBM3E6lmQVvBNzi4xoc0ms2MCHZmJ3FBaJJoQOA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1714CC4DBAE77C645DEEB9F283650@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39380400002)(366004)(376002)(39860400002)(346002)(189003)(199004)(97736004)(6246003)(65826007)(2906002)(15760500003)(2486003)(53936002)(23676004)(67846002)(52146003)(46003)(52396003)(486006)(52116002)(2616005)(54906003)(478600001)(476003)(36756003)(316002)(386003)(11346002)(8936002)(4326008)(446003)(72206003)(81166006)(81156014)(58126008)(25786009)(5660300001)(8676002)(16526019)(186003)(6666003)(31686004)(64126003)(7736002)(230700001)(6486002)(229853002)(68736007)(50466002)(47776003)(65806001)(86362001)(31696002)(305945005)(106356001)(105586002)(6116002)(76176011)(1706002)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOkRqcXJscWZqbHJ3cG55RnJWbnFKa2k1dmU2?=
 =?utf-8?B?ay95d01zbjk4NFlibE5NN3BSekhMVTAydHQ3RzRlUklCdDYyRTh0d1lSaEdn?=
 =?utf-8?B?aVJobUhrN1hSYk12OHhXNnpaWWFickpybGI3WGl5cnp0aGNlNkZ0QVQ1MGIy?=
 =?utf-8?B?NllrUXc1VDJ1VnNCTUxKemNMTC9rMzlzVG5YcGo5eGFJWUFKV2ZVdnR0cnRl?=
 =?utf-8?B?MDBkb2drQ3RNRDFsWGlpRytmSmhNd0J5d2hmU1dsQVJjQUxnSkhNbk9zV25S?=
 =?utf-8?B?ZUdGSmFSN0ZCUDY4Qkp1QW1tdTFYczRUVy8zMUR1NHpBM2FuY2V0Z0IzU045?=
 =?utf-8?B?ZEJmTUFBa21kZTNHQTIyci9mZTNEQW4xNURJbWluYWRvZm5CcXJjRUwxMkds?=
 =?utf-8?B?V2xWdDYwQjAwZlpGakx5V3gxYUlBclZZTmRIeW9mcmJQWU5DZy82VnZFaVQr?=
 =?utf-8?B?dzR3SG5UeTRkOGdTRWhIWC9iSWt1SXZvSHNrM3JNbFkvbjdlcWhkdVBZZ0Y1?=
 =?utf-8?B?ZVZHZzhmMmxWS0YwNzVpSkprbExaN2MyYm1JWlZKYVVMVDMyUVBZbnRJZC9H?=
 =?utf-8?B?ZU5LV3U0S1RvaENLVnJSeXlHVTczdXB0WEF4ZHg0QXdYRkxoVTRCN1BpN1hr?=
 =?utf-8?B?QkE1ZlZLL0pyeW5DZlNpOGV4c0hqWmptR0JuRWtmZ0JQV1FWdm5SZ2dhZTJ6?=
 =?utf-8?B?ZXpkVC81UnlRSldWNU9oR2MydldkSjRqZXdZQW5oVWhSWWFxWjRkN3AyR1lu?=
 =?utf-8?B?aWp3SGpOYU41R1diY1RsQU53bm5scmNoamlPUEIxSWFJd25KZTNzTWJVaHQr?=
 =?utf-8?B?WmlTNEFyWUZLVDFmYk5jaThNRkJLaEhSblpqTlVYVFNPeUdjVzMyY0NIcS8r?=
 =?utf-8?B?T2pJQXpKNi9oZnFmb2ZKRTVPa2xESENQTEIyZHpaR09UUTIyczJKeW9LdzNm?=
 =?utf-8?B?NENvbXpFUGN5U0F1VytHK2VTNG1wLzVlcDdUa09iUWQvam82WDBoR3NEM0JO?=
 =?utf-8?B?NktwN0ZWR1lpZ2dLaWs3RlJGdk96S2crNXJUZ2FWRk9lQmR2RmhUbFIvVjFo?=
 =?utf-8?B?cFFMTUhQK2QrQllrTmpldXdZSnduSUtZcnVmYVpzNGFFdDJFOVRlc3JTWE05?=
 =?utf-8?B?VFg4bk9HNk1ZeGdsWUlBdFdqeThRdXV4aGxqRnlXWCtrN1JsU21zQjRSajVH?=
 =?utf-8?B?S3V3dmYrSjZuNnNJeTNXeWd5NHhEeFZnTkpUa0NHV3ZuTVJHUVhNRjcwZCtY?=
 =?utf-8?B?ODBFeVp6ZEoxR2VhK3dha1lGUmVjZnBTUExlUHE5Y1BsRmdXdWdVUXVNYkdn?=
 =?utf-8?B?K2w5aFQ0c3ZGbDRBVjhFdXZFZjhmRE5reHMzTWgzbXlEV0V0RlgzcFFpZUhk?=
 =?utf-8?B?ZldtNkpoWXVVYldSc0FmblhHN1hnZDUyU0NpcTY5RXpRQi83NkYyUjQvWjZl?=
 =?utf-8?B?SHRUYjJvOGh5K3JQR2dhcnRSbFpMR0tQbGgvSlhHVzFCSmQ0cFRzOVJNeGNt?=
 =?utf-8?B?Z2JQYzl5YTFhamRBaGQrc0hETFcwV3VBekhSeGhocEVuWDJ5S3NVM0R0dEUw?=
 =?utf-8?B?U1hDcmZHVWFOUjl2NVBvbXhJVGc5NHgvWEVQVUFMNEppU2wxQWd0M0JQQ2ww?=
 =?utf-8?B?U2FyZjBUNnJFejZzZGg5YU4zUEZ5SHVRazNrTFZBLzg3YldLcmtteFFtMlVo?=
 =?utf-8?B?OTRIZnU5eUx0bEkzeE9IT0M1aDdYc0dmS2VKVk9sYUxFVHBRSUpPdU1POHcx?=
 =?utf-8?B?OHpqZ3FCOUxMREtwVjJ2cHZrUzBBMXhuMkNRSmRZZWs1MkNaUzZ1WG5rSzNj?=
 =?utf-8?B?ZTI2M3dvczk4QnBJaGpIUTlDWG5xWFJLUzNwdDVFMkNYSGhXczZURERQMWNW?=
 =?utf-8?Q?cbYbGX1Olns=3D?=
X-Microsoft-Antispam-Message-Info: xJA1bW+UrpudkkCw8YAAcp2Um7yaImtvDF11vrDyV7Y89c46Ntk3XZ4JQD16JMon2APWdqN6B/VV4gdVW6XtnbKtThH///pLEvNXiCP9tAqBE6AtfaVyuNj0SJtSP9I3tKRhUxz+DMZsrXy4FhUt4CMg3wP8emY4LnYBz2/8PB363eEtipYWF6AN1UKUFbDK
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:3AJmDigbODA/KEJyv1h+TU93hX3X1u9ebeGvHFbz9UskZU85n3NdyPUVD26LNbZ3exiilwZPoefPLFBMzu2sb8PUjLCniGJBan8A5NVm2+uDIHtcmN+k23NQdWDHYzF9NK7sN+/yvJGXfvD+B0eSgudIo4bkAtu8O+DJ7GWWp23W4efm6c+Fo2rLZQuG+6t5a0eYbYUf2hykbgbBN5y1SleJgKpQQCp7ffVSPqPgscLhx97G1oVXhczHvfHEYI2x45bAWwObFlbiUesCu1Y9V0vcA08Sx7rpjDVeVh1GGWlnzHz63zNfJ3Cqpw5wBAf/JL2qKQsQYY2LDo6k8G+W1wnY7eYzejSHhLaA6ebeZaszZsz9zx6F4WY1c2hJioCvrfrdZtbHWCUIpcQRX+SxMxc4hPf9cf3qyq59NJur7fQP1cWmu7NFLmWDwRm1+eNKK13rfUkpu9NCWY20mKv1zQ==;5:eiVk/EmgDX2VBkrhVR1YmOLfIvgOJwmKA9sTyYObiYd3vycH2NB6dU48aUi5B8Y5d1EWpDeSv9gdoURLjBaD3ceFxNs/h8YG09vImfwDlPoW29H1GijZ9LdmUpLxfDBZmSWTjjlfDjlnqKG5zL0cKEy/S71xd+lvzYwEr5E3kdY=;24:ZCRy+diHc8MDFQQNOjqnZzAcrij6Juk2+ALKVa59L4bVU5GygKebBlum1hKIVdQziyuNdOJmKIQZmuPBasgSM4xjFqEDB3b5K+7ynvHGabM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:QJTc8NGp0EmjQWbEATKnuYlfM0+HD9v2mbNbpM8T8IdN7A4v6SqWpxgZVaTXrDlLoqLJqG8up3sUXIxsGCCJsW3ct9cOKrJu3QEycblWPih0Ui4pC+VP3oA1HuEpmjdhuftzLnx7e+Os8ETkeSmaEvbR+OzEASGUJ2UqUGlg/UlSrbyvBWfu0w1Yhv9M/cQkb6dZldRtea/0JttVo+rsYZxy0zKNxhNPVV/U7dzrzDf1TzqRLNYczWnxNC+/b1gv;20:7YXdKdKGS8qRSBvJPDIsbeKYiQuI4p87AO4CDPb237sm5ZL3fEDA1LiQQJuHuDY+1knXEH8WMDAN4u/tdfij8babjWXxcm5/HxBEZrv1fQGbsCGzNsRVl1HJV7TkBjM1yTTRGaWxmmnDZObdIieQi/pCs4M5sOZPLEce2zJ0AKkFOc8Ggw0JzjEJR8kpm6WeUPwXf8l45k0W71Axr4J4ciKSCat/HPwzC6PK9ChUCaaLj36z7ZscggjGmwvuL0t+
X-MS-Office365-Filtering-Correlation-Id: 25959c97-1da5-47d3-125d-08d5cb873290
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 08:26:26.3812 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25959c97-1da5-47d3-125d-08d5cb873290
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.06.2018 um 16:44 schrieb Borislav Petkov:
> Hi guys,
>
> X just froze here ontop of 4.17-rc7+ tip/master (kernel is from last
> week) with the splat at the end.
>
> Box is a x470 chipset with Ryzen 2700X.
>
> GPU gets detected as
>
> [    7.440971] [drm] radeon kernel modesetting enabled.
> [    7.441220] [drm] initializing kernel modesetting (RV635 0x1002:0x9598 0x1043:0x01DA 0x00).
...
>
> in the PCIe slot with two monitors connected to it. radeon firmware is
>
> Version: 20170823-1
>
> What practically happened is X froze and got restarted after the GPU
> reset. It seems to be ok now, as I'm typing in it.
>
> Thoughts?

Well what did you do to trigger the lockup? Looks like an application 
send something to the hardware to crash the GFX block.

Christian.
