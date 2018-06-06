Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YJ7K0X/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 396C660764
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752302AbeFFO30 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 10:29:26 -0400
Received: from mail-dm3nam03on0069.outbound.protection.outlook.com ([104.47.41.69]:23840
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751925AbeFFO3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 10:29:24 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: Kernel and ADM hardware roulette ( was AMD graphics performance
 regression in 4.15 and later )
To: Gabriel C <nix.or.die@gmail.com>
Cc: Jean-Marc Valin <jmvalin@mozilla.com>,
        Dave Airlie <airlied@linux.ie>, alexander.deucher@amd.com,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Laura Abbott <labbott@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        michel.daenzer@amd.com, dri-devel@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b3f54efa-9497-3bc6-6390-974079f2cbb3@amd.com>
Date: Wed, 6 Jun 2018 16:29:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAEJqkgiNVDzboDK1vsn9rYP0G=Q_mGDrkx1VVB8TUkm35Rs9fA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0601CA0025.eurprd06.prod.outlook.com
 (2603:10a6:203:68::11) To BN6PR12MB1713.namprd12.prod.outlook.com
 (2603:10b6:404:106::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:Ohea9SY7hreYFv59dsNRXeKd9xgJudolOFokZ7YBS2FGxk2xSFl9e5pkynbMcEShbc+3vE9IxYaZi+vAK9T7+XWKLu73ATR/zfUcNt3Hj8mNo1TPk3Wc9uhnl+aTGu4CD3cV56Iz1Mod+hkpPTpTmwFqCz2Dc8zeUGDHuJ9sy+AeJGVNN3zxDl8xRYTdahqPaEOyctFDWpo1IOhIKzNzPYaDUnFAjH9Jw296a+bPyBOIoQyhlXmRANLzcrnRc3Gx;25:rbczplsaAq/zclOUaBti70YfRuQxNGiHtLQ+CVpeOrueoEzq2lMP/ClKZFUzFyzciVSWDC17W5HdwO05tgutmpXrocehU1noZLbJfkwZmlTam0f+zeeWthTYRWSpkYXW20yNrh4aCTL+UryxTU7YIZoQYbzWhYICIBsrjcgvwczW8lZDN/j4b0WZIfuUNVn1srSE1xg9fcZwHf8j+cv0++Q2y2vaAGuALMCTP6ZyS5XV+NKo7GrwARDgFdGOC0yl7HYY77RpvTNIpOSxg65AQkNZ78bOaHUzWvtgqIeOsRFp1NHE5Alq2z7JE6yfxA6blprqmfrZKPyXg2tisVjPAg==;31:rQyTprFfdAxyafB65tjof4Mm6wm9EZLsvkOo3Q1t+uRIjEEHep95waScZcd5+eGrvSJZc2KXs97x0kMwqb8RDZFhsM+8Laqf2N6aqGGYOFo+qgF3G4kn2EX3/cUxHz5hwlinQm9ducFkXLWk38Qq/X43vTegEACf7RSPFrAfRz8rxSTilkMMjod0Rc8+mXhK47E5Re+TGtGVNRhB+LHsjSbni9WyiF7RMUbneg1NitQ=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:LI93jtfLw5w/qXRmPYKnB0IuZAZriQ9/Ikt5WbzOnB7EuUNf75YhIwTQ86VPr3ihmNqCI9NPkLY7eQnBG00c/EMLul+1rerGeHj/DspU7y3HiVTuWMxjd4wYd6P3QWkb4aQOCqsZ4uYL7+3rXcWapDv1mfRsEA5f3yVCgfahfNkymiLNt4yAdnAnVdLGPZqkzq/eHUE17g5fJEJfkNMUh/b5Z9FZVpzve8GEnZjCdSMU1M1fFp1Hk8dDa1ll724ukur5Xtu1/9/ZqGSBEVGEWIK29r0W/aSXjFIuiWivT3fTSldd6wCGJp+Xrr0Ax40wpuHCR5v8INLeOvVobjaCKTqCHAQXXMMUd3ElKaxdo1bhv5iTbK13SjeHi0mhsbpaqpnzS1SUs9sKx7I522I8DpTEq3PvqtdKzr2DUXFZvjU/hGBrpssS3QmPxQpIciyTJB2EMyi7BLBXEGP06iXYgwoyXDdSNggX7hX1I4in/Qkgtvrs/5LNMJXwSOjt85GW;4:LINzNeDPAWUYNiUwlQKkgfnWfZgZqLrgCVdEt3JQb7m98MskRJPCl711kNfVj9asoSBI5qbNWCgQTIPRMdQCDciZLlGVP3d0S09+x4ChJlXa4t7+N5Kqo+ooP0byunKqIZyBTU532ETjXgd6n1onnmUNMJwWFkRxJTboYTl372VRlKXtl3jnOPSRsm3XnEwZaE2Cf8SG/XsAvGLupSUKF081xJzyi8iEbz/R93yaTbYtLwGgTn0P+UyCmiZ/PHguv2XOpGh5155yy1P4yaxniG0onpnZyrgdvN2gqcEKJR2FGUMwFr6ZtJCtnBS8qajQ
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713506BFF61CF2AB5D784E583650@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 06952FC175
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(72206003)(25786009)(65826007)(4326008)(6116002)(68736007)(478600001)(65806001)(65956001)(47776003)(5660300001)(1706002)(8676002)(8936002)(81166006)(6666003)(46003)(52396003)(386003)(186003)(305945005)(67846002)(7736002)(52116002)(59450400001)(52146003)(2486003)(23676004)(76176011)(16526019)(6246003)(97736004)(39060400002)(81156014)(476003)(2616005)(11346002)(6916009)(446003)(53936002)(486006)(86362001)(316002)(6486002)(2870700001)(31696002)(36756003)(64126003)(50466002)(229853002)(54906003)(31686004)(2906002)(105586002)(106356001)(58126008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOmhkTU42MldjNjRaL05xamVZUUIza3FoNFBt?=
 =?utf-8?B?RU9YZjRnOHZSMmtsZUQ3dkdONVpSbjM0Zll3bWtJMUNOTHVCaUJJT3ZrVTVh?=
 =?utf-8?B?czkrbjBmb0ZzMnV1N1c2NmlTWHIzN2ZQRXVLUHlRKzJlYkxaV05rV045dmgr?=
 =?utf-8?B?SDVZUk9zU2o3WjFSZTRta0IxV0dMNEQ2enlkRDdJZW4rV0l3VmhHTHdCOTR5?=
 =?utf-8?B?ZmlFRUkyRE1PVHp5ZTBwTmtoQy82SXZMd3k3ZUNEaWNTRFE4NHRWdU0rOGo4?=
 =?utf-8?B?UUtNUUJiTVFJUXhCK3k5WTVrOFl1UVEzOTBmbDZiQUVraXoyZi8rNW14WlVP?=
 =?utf-8?B?WTg2WUxxUzBtVEdJcU1hdnVXK1M3SFZHTVM3bTg0bkIyQjFROUQvMnAxUjNH?=
 =?utf-8?B?NktPa1Q5UG1xZHF2REUzVEdpVFVOT09PZTBpVldEME9LbDl0ZG1qMWExV1FN?=
 =?utf-8?B?RGhsRGYvMWdkYmJYbVlwd3hWRnRteVdlSlN2NWNTVEFSSnBsRmpVbTFHTDZr?=
 =?utf-8?B?S2w4YmZNRFl3UjFLZlNlV0xRblhuaGdLdjVONEUwbnFRZmhieDFkN21nNFZY?=
 =?utf-8?B?cEhJUFU2Z2U4QmpDdXJteWNLMGU4ek9ZcTBqUExZU2s0M2xmMTh5WDBUSXYz?=
 =?utf-8?B?UTYrRUltbXBvRDNaNGY0YTQ3bFZKS3VyaUdJdUlpeFpNZlBkZ0Y2S2VwTWl0?=
 =?utf-8?B?N2ZiS2lXdDRLN0dQR3dJYlBmRFZ2NlhTbTVuakptOFdIU0xCQzhpQnpkSTRF?=
 =?utf-8?B?YUdRY01JRGNtNUlaNzZlZXJoYitIK0tNM0pNaGs1QjNUM3EwVysrRmU4WUVu?=
 =?utf-8?B?aUNPQTExVWFKc2NBd09UVHZNb09Ecjk5cUh6SVBsVE1YTVpIWFRublRkNkMx?=
 =?utf-8?B?ZU4vNmp3cXNMeW1Ua3dKcStUQWE2YVltLzc4U2d1OFlQcnlTaGJvS1VON0Z3?=
 =?utf-8?B?UWFNbHRHdXJKeW1ORVVpRVpBU0UwWDNhcnRwRzFFQ0hBcWU0S2pvNEk2Y21X?=
 =?utf-8?B?SzRpbTcvSHBoOGhPc1FPOTRzSkx2NHcvdnFmTTFaRGR0S3I2ZTkxSXVkZk4y?=
 =?utf-8?B?WHFwNmpuSFJrSmFuRy9LNDhKQXNXR3l1dW1mSnYrRUdsV05MNEdWQlRsWkFi?=
 =?utf-8?B?VUhnaEtveGlXckE5WVJWbHdNTjQwYjY1N2xXcGhBSkpvUlZ5R2lCUjhLWENF?=
 =?utf-8?B?MTBYT1VwQVI3aFpwMnVsajl0Szdvd0RCcWN1TmVOY3JybnVKT1I3N1c1VDda?=
 =?utf-8?B?bUhsTENkRWdsRjlsTGdNc2JLTWZDeWhuN1lGWDFIcFJ4L2U2VlNVOU9PdG1j?=
 =?utf-8?B?aFM0QldaaVUwaGpocHR3NjFoeUgzazhNcGVpY3hLZjZEOXVzMHgrQmN0MEN3?=
 =?utf-8?B?T2U4MXVURnNoZ1dJZE8rcWFVeDkzVWdCUDVEQTI5amt1WXJPcFdjaXBSZU04?=
 =?utf-8?B?VmJ0aWdWNld1RXJVck56MjRxbld3bEFvZ1lyNncrZ2s3aFNDT1c2RmR6QWg3?=
 =?utf-8?B?TXlVaFo0ckNRSmpENXlQdkpsT1plRGxQQVJZYVFSeWJrTHhvOFR2Z0s1STVt?=
 =?utf-8?B?VGdka0ZmdmI2V2ZwV1lPYVRGMFplenJrUEl3d1E5dGkrY0xJT2tGM05YQzBL?=
 =?utf-8?B?YlREV0VNQkhFWGNtMTJMN1J0cFM1L25DNGQzQXJ5aVB6WkdObUQ1VWJNRERI?=
 =?utf-8?B?c2dHRGdxSE5UT3EvN3RUWWNMbVg2VjMveTdjMGRSejdmTTMvaWZaTmNaY29h?=
 =?utf-8?B?MXFPVTZVekx4VUZrVktsd3UxbWJzcnJjRW5RNUhFSVFYUWVyOGxVeWszODZY?=
 =?utf-8?B?UDBONWNSaVduclFtVHY1Z1ZDWDJKNGE5MzdRd3FMZndCNGR4T29NT1c5aFVt?=
 =?utf-8?B?cndUWmNPc2c0cndGRXJ3c2QvSEdNWmZpWkhVeEFXa1JObE9vMjJPanNKUGFN?=
 =?utf-8?Q?t6QIWrcHtU0blw2/+zWEj5JaFUU1sw=3D?=
X-Microsoft-Antispam-Message-Info: sTDQPOnl2EWgagOmoO6KxGAe7q9YDCgTJN5VNtVes0YWb7hir2HQwAgf121V49aXmh5ggvzx2laE3zL6ZgnfNIRDt7w6Yp9xGsoZQ/b54s5/xsPkNKt6SAu7+gBv5oBbxTsW1kJwpS/wLV2lTdgY6UZPxun3B8ORcDAp75q/TWaUaGImzmY5mhCgx0NikQ6b
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:7RVdcVo8vrlHcrpYwFLjQpT1ZoTvgOygrFezso+M4I4QeiyxPXCpHGO300l0yWjNZcLZGvs/EAV8Jca9PlEECBVtn4/2xY9rj1JqzUbMU39NgJNVMddWEhBgoth24nI8R97CpHM7JHNI++rKoHywIirgWrATgy2EkKRFLDsSxdhYi+INtoYaWAuJAk1NAiYVD+selObYDmj2AwufPgTVSNU88zhBz64f6r1Hz78AgAl5bXMcV/K3ZZy+6F20YgHYAZSa0dZG7PzXqUilD+DEFdmZEgJ1wF2w7sVwsVRYmECCSaat7sUK+3QO+wiOuuzwb52bz/u2jQgnCPn6j4t21JOsLiX08dRwi1Xfr+HSEaQS+r8a21+2KBXQ9KPB3V0HUVjElBEwlsHpkKbGl1OdbNI/xJkotvWf8XpP08dx06fczxOmPnUwSmqn7iGxrlq1UaxkxCLYh4W0YWLr/9B/dw==;5:CPT+Xl+OotrqiJuKsrdJxfzZh7Ym/WZoZO6anOkNRlm/MikqBGtxPtgqxG2yLrBZFs6Ks7BtYDc9M2NcAr1b4+515KhI31zF9nAMtthEOTuBcN20zqFijsQlCmNwW9SWFmtYUPr2K/AWng50gmQF/hdjDgoF/VyUs82/cSkfZxs=;24:x3mvA8ARqBkgiMImjQAsitblEFXAQfwu2r+8FNO9NoKEK0tugwtC8oXRyy+E7TlQiG/QCc4CWyThzOsoxeW2/q9uZ+EgH2SeVw+jnKuaMW4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:jeyYqZ/iT71jWjnLVXdcDik/yMgpZI036+DMZY5ak4yov05PhpOEEipiUIssKS+3sYqPj89s4T5CDev5GbQbMiRtmseWvbF6ze6jM7HbrfHhERvZEcIYR3dm7wAJglkgH4x2S0lVZBa1s9tl3WQhnVuR0M8NJ5SP65wVJlp9hxCmNu4mcBEmXYR57K0fAJ6nSUxLHWWyDB5b2gPIllUfYnYyZ4iocpbll0NCWSJsb8eCZWLNFyW5uI8tYJ7psIpe;20:fA932N2RSZRDiQk4qotMy6oERQ8PrNQCEkOHhk2JH4EmuFbWnJqOy0hJwsUKYg/LJwsMuBYVpTaROAiSG7RrqZTTnWC7LaqCrud4UzjbLiviN+tmyLiGcTZT2r7O0nimJ2JZMj/W82+mS29ufwW4OW7uIfgF5CeaTs7FbRnliAA/2iJunNznE68tja5Zmhf+R755LxUGbVRWuPioKqnQQC1J8pTWTN2YCXZJUOq6I/85CUsO35g8Bm57lPEv7N0Z
X-MS-Office365-Filtering-Correlation-Id: af4e0fe3-ad50-4a0b-72fa-08d5cbb9e56a
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2018 14:29:20.4486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af4e0fe3-ad50-4a0b-72fa-08d5cbb9e56a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 06.06.2018 um 15:33 schrieb Gabriel C:
> 2018-06-06 14:19 GMT+02:00 Christian König <christian.koenig@amd.com>:
>> Am 06.06.2018 um 14:08 schrieb Gabriel C:
>>> [SNIP]
>>>
>>> That has nothing TODO with the driver nor the original bug you reported. The
>>> problem is that SME is active and that is currently not supported at all
>>> with a that hardware.
> Ok .. so are we playing now kernel an AMD Hardware roulette on each release ?
>
> SME was like this in kernel 4.16.x here and all worked.
>
> Also if you don't support SME at all now on that Hardware while worked before
> please add proper error handling and proper dmesg messages
> letting the user know.
>
> radeon: xxxx : SME not supported on that Hardware anymore , please
> disable SME...
> radeon: xxxx: Update your GPU < or whatever >
>
> How hard would be that ?

Yes, to be precise that isn't the job of the GFX driver to care about 
such things.

It is a well known and documented limitation of SME that it is in 
general mostly incompatible with GFX (or compute) hardware, and it 
actually doesn't matter which hardware or driver you use.

In other words what happens is that as soon as you use GFX (or compute) 
SME gets disabled transparently.

The problem is that this happens only on the DMA slow path we just 
disabled because of the performance problems.

Going to propose to revert that or at least only use it when SME is 
disabled.

Regards,
Christian.
