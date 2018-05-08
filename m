Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933178AbeEHQup (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:50:45 -0400
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:52769
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932815AbeEHQul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:50:41 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-1-logang@deltatee.com>
 <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
Date: Tue, 8 May 2018 18:50:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: DB7PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:5:16::35) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:yXt//KIPKbgdEEf3w11e6CQ98f85NIFE5GAs0SMdhAsG31nQG5hxWtgZQYicyvPk34KnOZxx7VFfccEYDjKyOtV/Cst8P1x7e6md0Nts4QuDEy3vLlmktTYf8Au1Q966lpksBapdDtVKTz74u2Zodscvl+dEY4C8sEsDsrzDQ9bBAuVpBxEn/h/FLIS9TznKEnfFEzb0ugT6MsH7YKfRKzQXkkAA+QURWy/PEXRM7JkOWjfKXGC1jayYDDIDpykO;25:XioloRF0TynJnwNsAu5ogv9J0Sk2ON7gz/TSZtXdXhP2qbReN6jylBU3V/XEyY+S8qnEkDn3E0u/B5fAzTMiczU8YopaIIZrZT+mfxv2vvLtI6Fqdxq7uhRUH72F3K9LZWB90wzN56UC8YVE/1gMesd387ycrlK9yaRFXT7H4+gnyVdXZrJvHZ3fxZxFeTvcSP6SN/l8aAtfMYHhtKm2v7hSS0RHRLvqErUKKjNB7BamnHqXT7zn+XeqJ7EwsgiJQbezZlHiceSQ0OQqESvwJ5Mlu0jVdMMiZ6nFs2MUek5lszOcc0hLHAhw8BYSFS/4Noo7iGa9ONNxBBm+UTCz6w==;31:PisGCTUJ6QQotZfeJuzenuW9hIM+0PvbPeDjAdEqvytcJEpKLDAqobgOjyunR2gtBcFmL1xZ9W6rMmztuwTZGaarGuKE/iBoKGd6SiS/Z+eHWNZB0wWqzvEugc4H5JipUNPrlrFZYUue6aE9tHs0IY6urDRSbYr1H0aKni8F9jxEu3PAWvlXGSRJ939Cl6UQlVg4zqejaj5ArEVUKjvNT28oZFLRYJ9wo7srqpiavjo=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:OotXHE9OjTWhiqYKZtnj6WmCQm/k0YKzSc2MQRtZKG4wiEXZtSTO8LoSiK5caO/pE4W+tf3sNP76w00lghbhnXtvuv+0isat7jjNeY5rmWcemoq8ka9mXNQ4j2VU7Q8NRJIZChGvTXTD/uVsksQYSdYsygoMx/1Pj1qAlPDM/8VAJ2czL9U1979M5ZNB0bIDsTE4ZYoEMlPChd/ZROThFhivsRWpHvxWLkDvKLpDOus1fMsFhFOJsxbMzCBWHYR153IbYH7wLJrhIDJoLS+YFsQ6JxAmU1cnCkHd5CI2TlLapRLQGtWmJg934Y/JaJU8w4pj+RhBGS/PnsFNDjGz2aSIUHB8akOwff/2IdomU01M1J/XWHJdvNZjcJHD3Qj8HTQIVbxJudyPAvlBtj/EW8IoGnvlxre7YARh4+jirOSWY57iyqzId+I6rIz3PCXBsZqcB33bYXDiqACx+wP5jbk/3cNHdnAV5zKOT7/5Gzc5zMX6eVkZ4dlXZdM/1klH;4:lvnVnxWks76kfuDxwQ9t3NQAUGxWVLae1gdodxME5AbEhTveZTZ51c0t4m+OGOpzP+biopAuv503gIml/oHZUpmhDa9loedB4CuUwZyWfFvDTjECmDWje/sE2qjueQ1hcSy4mM6Wb3mweOmfrxY3+oH8If8cu/pGLvhZntwT4iGjMar7xDndii6GjxRSFiJ0zjOe7mD91CVhBJNgK/SgChqKXji4gE3BtBPkgU6MrabYcB/RiTKYbcFHwA7Mg+EV15PN17A2GrKGy/6+R3EaANwfKB5TaA33YwBL+rC8aDGr8in/Bs3skONJHJGtns2+
X-Microsoft-Antispam-PRVS: <DM5PR12MB1721A126F5BBD53EC336C46D839A0@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(100405760836317);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(189003)(199004)(65806001)(7416002)(31686004)(53936002)(76176011)(65956001)(97736004)(93886005)(7736002)(305945005)(6246003)(52396003)(46003)(186003)(59450400001)(52116002)(8676002)(47776003)(6486002)(486006)(5660300001)(229853002)(8936002)(81166006)(16526019)(81156014)(551934003)(23676004)(52146003)(2486003)(65826007)(72206003)(25786009)(2906002)(1706002)(106356001)(2870700001)(386003)(31696002)(86362001)(64126003)(58126008)(11346002)(53546011)(67846002)(50466002)(54906003)(446003)(6116002)(36756003)(476003)(478600001)(4326008)(2616005)(68736007)(110136005)(6666003)(316002)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOkZoVGloQTdRUzRxR1VVQXRBM1hiN1ZUZ2NQ?=
 =?utf-8?B?T2p0WWlZd1ZqTXd6bFU1cVBlN1MxZDQxVzgvekpLYW41WnowaFQ1N2oxNlUw?=
 =?utf-8?B?bXVsVVRocHdNL2lMMDY2a3Vnb2lMTDlFM2JkWm9iRm5WTDNGMi9LLzJ2U1hK?=
 =?utf-8?B?UnRsdjZDWDBpUzdBdGd1TUUwWEJ5bmF5Ymlnbm9SRDIydFNWZnBFWDVhTFkv?=
 =?utf-8?B?aGJMLzRXTWVnRGVOUTZzSjFUUGI2TXBBVHRZY1c5MVhjdjVlK1NXWnFtOTNq?=
 =?utf-8?B?MG5TQW1pdXVxckh4TkxmZlBPL1M1ZjBrMmtUcE43ejN3bzY5SGozSGtsN09W?=
 =?utf-8?B?ZGtwamxWZ0Q5c0M3SUcxOGVYalhtTHgvbklpNk5JWUx4aVYwVkFvbGp1dWMr?=
 =?utf-8?B?RnRpZmdxMmlUY0VYUEdud3ZwaUF0Zks3dWhiSmVjVW94NERJRW95NkNTaHVY?=
 =?utf-8?B?VDcya1FUQlJwVU9uVThZeVlCWkZTRk5IT0lIYTMvc3dCdVhGN1U1djNTRms4?=
 =?utf-8?B?TERRRjJKQUcvMlluY2dNTStrVEZaNXp2a2ZxeU4xMktWNEIra3BnSHhaZ3lz?=
 =?utf-8?B?NCtZWVVkN1pFbGZLVlhsbUZFeXFxYjdnNHpwR3phWTNqR3ZGanFMb1hIYzJ4?=
 =?utf-8?B?NWpnQWRxeEs5bUhCSXZwek41cm5FVFB5NlJzN3Q4OWZQYUxud2NtVFdxdXJT?=
 =?utf-8?B?alNmS0orclNTTGNseG9xaGhjQjJURlRCVzRDUFdOaGpIQnE4UjBpWGxQSytG?=
 =?utf-8?B?d210V2V3Vng0VysyMGNWMnlsdnVzb3kyWEtCUmNCV0xsck4ramJRN3NpVk5r?=
 =?utf-8?B?M1lKZ0pYZnp2eTkwUmFHTmh5VUhLZ2xvMEYzVDV3WVVMNjlyTlFTNFYvWjU3?=
 =?utf-8?B?bmkyOVNOU0xXb3JNTGMwcVdVWUJBTVkwNHk4QUpteGgvekZPMzNUOFY2ZS9q?=
 =?utf-8?B?TzRDQ3RTaFdiMXA0YkNUN1dzZHNFYU5tOUVHSUFOMHV2TC9NSFA0UHh6Rk4r?=
 =?utf-8?B?R29xaDdwQ3JmcllZcGVDR1Baa2dFa0VETDBGTTNteTF6aXR4NERQZVFIMFJB?=
 =?utf-8?B?UzlSNEF1eFl4bk91aU9lU25aMDFqeXlwVngzUWJ6RGhZS3pNaUVrbnNQaXl0?=
 =?utf-8?B?L2dHaWhvdi9uQ1BtYTlERlkzSjErdVE2Mml3NmZ1ZldFUmlRcTh0aitJdHgy?=
 =?utf-8?B?MjFON3FFaUMvRnByd0VsNmxyWlZORVpNVnhuRFhmR0Zhdzljb1kwdlJHSGVK?=
 =?utf-8?B?ZWpHYXJoc3NGTkJ3Z1o3Vll2T1kvNld2cjhDbkY1TFNMdzlFQmRlR0NOeEN4?=
 =?utf-8?B?VGhNbXk1WWlZQnNZQ1hoNmVWcDdicEtIbFYrOE9vY1EwLzVsY1BZVzcxSVB2?=
 =?utf-8?B?UnBuT085RnJnNEdYdlhwakVoZUkrclJSb1dmZlQvVlRpcDBOejhkZjdSZk9K?=
 =?utf-8?B?QzI5T2hNNTU3YXk0Wmx4T3FESWt3YnJpeHJxVGZlUmQzV1ZyNWtvMG9sMG15?=
 =?utf-8?B?TXMzb2t1b1ZpMmMvQ2FWQWVBS1llYUNMTHByY3hTTkc0RllLd3pobTd1N1RP?=
 =?utf-8?B?ei9GRno1bzRqYkl4SnhrNlUydWRrSkxsZTV5R0lkVm9xOXBTUDR6ajRoVGV4?=
 =?utf-8?B?REZ2VDMwVWw3ZFNwV0FtR0hGWFNkUVRZRk1vRHBDTVg0OHBJSTdKZGJQaWE1?=
 =?utf-8?B?UnkvUSs3cDgyK2hXb25meUhkdDF2bGhXM2xWVTJzTVhUV0FlTVFSK3BmbC84?=
 =?utf-8?B?a1JicXBoMEtSY1ZTME4xYUJONmVkSVJ2emVIOWNkVkRFWnU4UmRESVdQSi9M?=
 =?utf-8?B?d25xeG5jUHplRUFiRU1ma0V0enhvNFU5MnNhanp1WmVpMEdTenRzVVRTUlJr?=
 =?utf-8?B?WUVzcVZHdm5TRHJxczhqTisrUkwyR1dYN0xiUHRkOTNzQVRoMEhtMU1WanNy?=
 =?utf-8?B?SUVvN1JoZHR0WCtzRFZ5TElva05tL2kvS3dhUjBHWDl1WStGWU9ZU05GMjYr?=
 =?utf-8?B?cWRVY1RqNEZBNlcrLzVBK3ZwSkFOeVlpWXVIRmlBWVkxT2N3K21acjRYZzRk?=
 =?utf-8?Q?8FjE=3D?=
X-Microsoft-Antispam-Message-Info: R1VPLPN0bheX8a/U0pW6JQ3Q8UULnCFo/772OxomnpMWjX6/Me7dMkoxY1uChHXGdmCCS1e0jdjAFqw6lp1tQ3UbdgusiR42GG/e8JHplRMTrNYkSWaTvO1P5qeCLABNkyMTXPHBFlvsjUlQUhuyMF4LFQNw5GpUJzpquACU2242TfUxu5b+WXsFE6CiFDH5
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:PrUjBe5znEebwbNCDA99ceQdM1rhmpt3goRob+ubUfxAhMTDBsQZABM8aQDiFAqDQnvb9wEn9N/qRl95Z0DuGouo6d/rLi2RdxsWB5XB+rT88dRDqmSInllMNTO3SswB+3C+UraD8rtKDCnjjl6Y59j+VxpdSvXCQhSSQ35UE7Azg/1eSnalOlyBCo6HGw48nDCvQrKatrBfW1dFXVU2GaxvDA7fphQdm058m0b4EBiSNHIyM2aCFL1k9eVTgl1PRfp3AJJ6xaKnj6AOBGlEb0DbqhQRDawIiqJSwwag8S6q6YrKFnjqgkbAEFSNBoKqAgahzonwZTuvlrPVMs9Oxe8bz/zHCRkmiwB0A+KTZmNpRGRPgyFpgjbJs0b1ZWofAkjL4vSaWHu8lNhZz1nRLZBHaSQd6Dhy08liEhHS/Ko743W08Mdgvr12+8WN7pAumc7/XQaQDvaZPVkG/rJl4w==;5:IShPHxHIZVeJrVU2sO74ejV8I+e4pJkJao5sqRrSfNYLrEvfO3dN0Ys641zk+xxVt93GYqY3ysCa36SIDneqioS0OeNs8WmQGsfW1qs6CpaTpQX09SJw6MXEylU/39zdqZ5LTslwuzH+vYrSeLpPd6/PWuKFNqdIeWRltYaLelY=;24:a+rvJuDjPdh7tEMSNMjz6Xu5+J+8sNqjPEbt5Ml74rN50S7QlXaV4Bn267vmWKHbRgaGIE/mTSEHuXrkxALMLBeQS/hwXyN0aTZOXC6fpEQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:CDXXltvCgiyyXfLifqNE+EH6r7w/jSsDopOget8j1bw5Z5AgfoiqHUp+MaiKp967KCevjSTP8ktPJ2h/a4cK57zESuDdMJYZdRW80VCDfaRcBAbbKY6deZdmCDThpxHw8os34alL8if+wBRowKgv9bA7lMxJzCPaDpAwfGZ4PY1iTorglCYhtezqCVxv7WhFcI2Ae9qkRtWXtO5sshen6IHCo+QPAFLbNP0sEaxDnAhH8KS6LQU4fKL6UU4WzsDs;20:eQt/4lBCzL68WKxLCyDl5/M9pxPj+h449n06cXpC/fEcTmMBIxWNMiEtItx3vxNHfuwsqB607TxztebnG002cF3JSdmuJ6+6Xs4GxsENzgcjfd3h+n93DLypGAyJKg/gyhpCifhvUyqxojNdNtuWV87sDGoqEPKVq7JO3LSetcOlVyBqu6KsomUzQQZWrdh3VCv3ggQpzOsYwILFaD5av2aFax7346+VdxnRb8PH/XcpaEMUTP01rVac7gpTJcIQ
X-MS-Office365-Filtering-Correlation-Id: 70caff59-2742-4627-42d5-08d5b503d3e1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 16:50:35.2077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70caff59-2742-4627-42d5-08d5b503d3e1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 08.05.2018 um 18:27 schrieb Logan Gunthorpe:
>
> On 08/05/18 01:17 AM, Christian König wrote:
>> AMD APUs mandatory need the ACS flag set for the GPU integrated in the
>> CPU when IOMMU is enabled or otherwise you will break SVM.
> Well, given that the current set only disables ACS bits on bridges
> (previous versions were only on switches) this shouldn't be an issue for
> integrated devices. We do not disable ACS flags globally.

Ok, that is at least a step in the right direction. But I think we 
seriously need to test that for side effects.

>
>> And what exactly is the problem here? I'm currently testing P2P with
>> GPUs in different IOMMU domains and at least with AMD IOMMUs that works
>> perfectly fine.
> In addition to Stephen's comments, seeing we've established a general
> need to avoid the root complex (until we have a whitelist at least) we
> must have ACS disabled along the path between the devices. Otherwise,
> all TLPs will go through the root complex and if there is no support it
> will fail.

Well I'm not an expert on this, but if I'm not completely mistaken that 
is not correct.

E.g. transactions are initially send to the root complex for 
translation, that's for sure. But at least for AMD GPUs the root complex 
answers with the translated address which is then cached in the device.

So further transactions for the same address range then go directly to 
the destination.

What you don't want is device isolation, cause in this case the root 
complex handles the transaction themselves. IIRC there where also 
something like "force_isolation" and "nobypass" parameters for the IOMMU 
to control that behavior.

It's already late here, but going to dig up the documentation for that 
tomorrow and/or contact a hardware engineer involved in the ACS spec.

Regards,
Christian.

>
> If the consensus is we want a command line option, then so be it. But
> we'll have to deny pretty much all P2P transactions unless the user
> correctly disables ACS along the path using the command line option and
> this is really annoying for users of this functionality to understand
> how to do that correctly.
>
> Logan
