Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeC1S2r (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 14:28:47 -0400
Received: from mail-co1nam03on0083.outbound.protection.outlook.com ([104.47.40.83]:45639
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753024AbeC1S2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 14:28:43 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 2/8] PCI: Add pci_find_common_upstream_dev()
To: Logan Gunthorpe <logang@deltatee.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@infradead.org>
Cc: linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org
References: <20180325110000.2238-1-christian.koenig@amd.com>
 <20180325110000.2238-2-christian.koenig@amd.com>
 <20180328123830.GB25060@infradead.org>
 <613a6c91-7e72-5589-77e6-587ec973d553@gmail.com>
 <c81df70d-191d-bf8e-293a-413dd633e1fc@deltatee.com>
 <5498e9b5-8fe5-8999-a44e-f7dc483bc9ce@amd.com>
 <16c7bef8-5f03-9e89-1f50-b62fb139a36f@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6a5c9a10-50fe-b03d-dfc1-791d62d79f8e@amd.com>
Date: Wed, 28 Mar 2018 20:28:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <16c7bef8-5f03-9e89-1f50-b62fb139a36f@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:8109:500:e1c:65c7:691c:352b:3c79]
X-ClientProxiedBy: AM6PR0402CA0028.eurprd04.prod.outlook.com
 (2603:10a6:209::41) To DM5PR12MB1723.namprd12.prod.outlook.com
 (2603:10b6:3:10f::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3459027b-cbe8-4ad5-5f25-08d594d9bbba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1723;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;3:oFkfNRsetXF8SCIk0JHOJns5mkNr1iVvUqFSh4Msz2dfLGxdk5iUiHVEmflNn6RkvlTx5ACwMN7VmS/wgucCYUYuAT6i4U0UreCxxp0uEaVLs5KOCzj55sn7YSJEcieNHwv1eyGiborcChS+3j+dUi8FrKRMtHaNo/JNlhaRSXgh5Lmx3rJtZZHXZU678gcMLtMQktmxaWIKtRhAIbOQJa3AFQKZ8aKslWkBaehBj8wf/iamK9ibjLMEEm79VBf0;25:utq4cVl9Sthzu2Q8i3iBGObmYTZVvD06HTKQvmb0721ucNU6grFgyeUhFvfwKXeUJSAzVVW17TsjUHqNHjxNlWDYP+3A2YTQlNPks7vhjHrLJsqggcaqw/7sSxfIaJ4qCVlS0a90yGYvYzNOANwftcgCJAAYh/41B/q19oR7IsvmtPBbwdVHisojfiHufR7GXfaucxwt2nQHRKOpP2iOYTxR/HUcxBVNroK+oqZDif26Vl9If0XaCpQtZ2UeQnXNbmI64nxuXKpFXH4bcyFIVaUwnSzhhLbFWbwNfJIrX2jzKkpqNX8XE+U8CpGBqt/hseJccPRAnegDlYpvd4qqmg==;31:mUp3INAjw7bQxWljwxEb6gzJoIHuZkA5Ly1VpLj6NGoTiunb85KyCnxc4C/pBDE99nyhBfSGKrSgOb5MWtPsBmBWpPNmzxats/a6xeG3feYokuRIjITaPFvdt9rJj3t9dJUCJ0+pUkHdkhHfnj05T5oNyM+Hyr4GAMYNrXZg1i2khuGVVOeaDam1RpkFskPyZTi56dD5A+0MRIfFRgQgGpUSa57V8hIPHBkA7JPo3c4=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1723:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;20:KR19uadu95e2/EcbKxotwADelDL9ng1dR2YVAunz7ArZwrRRUWDxW6LX7qLR1oK3HkBbO6vsK4/C/n9/RbfxSylBK80mBx6IKI4jhFwoT/+eKJuTw0U87NymMyh88RhSOkIGTPRRHMProo9CPA3KFXfej/B6t8w4hZbuQ54nuZ4GRGODsfJawCB7pjFlsIutTVp5KBUNN+vqOfMA8i1+CxsTqrrn0g2CsUyphmtZArojbR5BWIXzR5i9EuU8i0jDdXOguV8LvrUNIwika/ztP6+HWtdxVIBsVlzHkXzzu5ctA7zd+w0L3ETb08npGPPp+GBYHMqOzv4bFEzZg2qyFvREd8tsgA1nuoPMr2tQG/IuhNvqVSytWRa/GvatPl1dIpxIiKwV2kcco/AE54jXzLyIuurY31hnmY1oLq65fR078XXFppeovOd4Xz7M37AQ/EiTPrr+OSe6/0LkVASyQkzcLNu/A3ZDKNh7Nyvw+bHasccNP1WHypdh+RTtEu/U;4:ASSTqjyhHQOj4UXefyM231ELN69AK6R8CEvUXKZlzeuq92QpyXSUCa6Kuj2ThLme5hEWybtjroGCAYE/YmKAWQzf+GP3li4RMaw7BxteZkmEuF29235pmmNAswoh+80QIr1EHdNJTqmePK5iLhn9EKziU84rWyabN0E+y7rPjsX7iiNxWGbPYZtuvw1fFOt/ixniqQQx+02oMB/c4wiH7fwQTaUQeNXw4YdfSN1COZqcXPDzpvYCijZSCVk/KYhiHnVvql309sBZozdrgGek7jvhrx1Bu2XV4qbxe0HuHHAF1wKpz4g4WthaoDV/pIui3DX2nDQNFueWlBx7L5PAniKY1CUM3aAvjmnMEwsfge8=
X-Microsoft-Antispam-PRVS: <DM5PR12MB1723C62C9343410CA8CE158083A30@DM5PR12MB1723.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR12MB1723;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1723;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(346002)(39380400002)(366004)(396003)(39860400002)(199004)(189003)(46003)(966005)(2906002)(72206003)(1706002)(2486003)(105586002)(52146003)(7736002)(68736007)(52116002)(6666003)(6306002)(76176011)(305945005)(6116002)(53936002)(23676004)(478600001)(67846002)(11346002)(50466002)(229853002)(476003)(551934003)(52396003)(446003)(186003)(65956001)(2616005)(5660300001)(6246003)(2870700001)(53546011)(36756003)(31696002)(16526019)(65826007)(4326008)(65806001)(58126008)(59450400001)(25786009)(6486002)(31686004)(86362001)(47776003)(81166006)(81156014)(110136005)(8936002)(386003)(97736004)(64126003)(316002)(8676002)(106356001)(486005)(93886005)(486005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1723;H:[IPv6:2a02:8109:500:e1c:65c7:691c:352b:3c79];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIzOzIzOjJZakV5WmhYZmh4OWppajhpY3pwWUVSR1Mv?=
 =?utf-8?B?QnBneEFyanF5V3pnTnlIMVhmNGxKZ3liSjdCOW5MRk5ESDh4UWV5UWxyRkFM?=
 =?utf-8?B?czNINWJNSHpKN3RxNnYvT25hQVVaWHBlVkYxZGdiMk5BTkhXc3c5ZE5XWVlD?=
 =?utf-8?B?aEN5emhpMVhLZGtWY1Q5dzRmaWxubnBHNTBiNXQ0QVVsZ3R0ZTZIWG5CWkxC?=
 =?utf-8?B?N09sVnZWOXVxYkxjKzZnSitZWEQ0NEw2Lzc0d2lxVHg2RzhqK2FrZGRsWjNW?=
 =?utf-8?B?QS9mVEYwOGdYSGlFT0VTZFlWaXhlQXUxbU5SWk5NUGpNR25XUXczMytyNCt2?=
 =?utf-8?B?clcyZ0lSdmlRRklwekhtd285cC9nZEEwVVhUUWF3NlFoN3Y0bUhFZE91RFd6?=
 =?utf-8?B?eEhYNFUvU2pQR01xc2Naak8xV0cyRnhxR2R4M1R4SmFPbmNCTVA3OThJMWJU?=
 =?utf-8?B?dUdlaFdxbnR6UHVZZkJRdW8wbWRJRk5LVjV1ZlRNQXJqV090clkySU1YcnRF?=
 =?utf-8?B?T3lvbzREREp1ZXNQcTg1eFc5dGpoUVo5eVlvUGVHSVdNWlBXeGhadkNmeVQw?=
 =?utf-8?B?dDJiaEw5TS9ueExzb0RwTjNRQjlFYlVLUzV0ekhERXVLbE9keFh4ZTVwUFVr?=
 =?utf-8?B?emhkb3VjeENNa2s1RDZSSHFYUUpjMmY0NXlvcThaQnZkTVQ3M3FSSXdtcjlR?=
 =?utf-8?B?UzFIZ3hEdHRHOHpRNk9iUUM0MlNKRXRWN0MraVZTaURoS3NzczkxOWhTaHpF?=
 =?utf-8?B?bGFpcG10dFRWemJUSU5kcmhXb1dOV2NETzMxeEFhZHlGYVA2SXpYL3M3blc4?=
 =?utf-8?B?MGY2S2Foc1F6ZWpCM3hQa3F5WDE5a0txK1ozSXh4Qmx6QThxa2JHZTNrY0R4?=
 =?utf-8?B?U2JEVFA2aHB0Q3IrUjV6T0J4V3JUYnVWZ0M2SXFMWWFJdFZ0WXNyaTJNMi83?=
 =?utf-8?B?bEluUEZyU0ZPaGw0QkZ5NEVjMFNGRGNNNk5Nb0xvSU5uRW51S0hpMXI4Tnk5?=
 =?utf-8?B?eTR6Sm13ZzEydG9qOTF6TGM3UXBGSGJoZE9DQjk5T1VIbTdyUmMvTGk4WG5Q?=
 =?utf-8?B?NWIrb0o5ZVVHamExc1JkUzZGaEZ5SE4vdWdlK3NBVEtETlNhZHZZNW5FaytU?=
 =?utf-8?B?aWw0TEdTeVlQOVVQazVHdVo4UTdKMWJtSGtyWU5BTU95clJpTVZvcTBPYUhp?=
 =?utf-8?B?Y1FlZmdkSW1senFJWUpQelhSdnVkVWFmQTh1Z0xJSS8xWFJBSUY2SytYaEUy?=
 =?utf-8?B?OGJYU0Fid2tHWGlRTW1GbStaVW9DTlpkS1huY2h0RTVKVTdoQmtHbzgyVHA5?=
 =?utf-8?B?YytGVnhyT2d4R3RNSGhKRmdJTEVRRGJjSVhMWVdJTFJteURIRFFZb3VEYmth?=
 =?utf-8?B?eTIzYnZZbktZMkQ0bm4wbEZseDdRTjl0ZFo1cHJ2UC9HVFNDUDNadThldVRJ?=
 =?utf-8?B?NTdBOVJ3eWsrMWxoWjVUKzJCcWJxMWMwV3ZnemhhbzJXV3lIY2d0N0ZYRzV5?=
 =?utf-8?B?Mmd5Q0NQYVUzVkpVUmtwdHREUmkwVTFTd1RUdEZKZ20vTXV1UVFEYUVjWDZ2?=
 =?utf-8?B?VlZ1OUsvbXRud0ZRN0FzUU56emdmRThQQkVuTFk3K0NobFBoOEpTUi90YzZi?=
 =?utf-8?B?R3EydWJmeHppVUtsS3k3TzJlZURhOVRjTmFVc3p2Rk1UWC8rOVJ6Yit6Nkpw?=
 =?utf-8?B?UDI1QU5CcDhBT3VsR09jYlpNUmlxUE5WL2dlaklOT0Y5Z1F6VGFDNlFxdlli?=
 =?utf-8?B?UzNxc1pWeHd4ZGVpdEMrZCt3bGc5LzE3bHZhVnRvYk9XY0RuYXk5S0R5MFRu?=
 =?utf-8?B?dmJxNHF5M2FhY1NNZk05dy8wcTVaOWVRbkRQbDJ3cnN3VUs0YXIzczBuN2NS?=
 =?utf-8?B?RVlCaEYxbHQ4VDNvczdLem5FK2pxQ0JQQng5R1Iyd2cxbU56aCtYS3hrcGxq?=
 =?utf-8?B?YmhNejVZb1gwcmxoTVhiYUZqVCtZNjRXbFkrWVlNbUZTeXhISG85b3VUVjVW?=
 =?utf-8?B?SHNEbnNTK1g5Zk12dWRDaE82ZWEzM2YrMko5cHFHV1RpZit5QTV5L25DOG5Q?=
 =?utf-8?Q?UikA=3D?=
X-Microsoft-Antispam-Message-Info: fvyKeL/uY+YOhgm6jGI5ZMeAMcyGu5xtaYg3mqRzvhAIQ36gv+deA6hWmn7ZEqDS6RV/S/dogwaO5OlSTHDdFe/yC7RVNJJG7sEsPbU0c8RVRJnpArecQr4LO3DDQOJCAn65yGcdbdodGYFu6Tj9DnPW0euCFx3resTECmMnXc1vX3ceA0PI2udvotn59MdD
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;6:aY249Rl78/aelSb+HPKI1T4LRZWTcLAeeFoYwAXjBATCMwsidVH+QCTwHzgjq+H5701NNtFhhojArZAI5kEh+JsAP0dYbYUolGBK1Lqto7nx8GJAjWfl017sFjIcv7Z5EeawtUkFEps7MFR0t1T3VyfbNwj+/i3sV09kryi0O7aSY+xSJI8LQd/B9b4JqhYGpZcnTS9PQqDer/2qr7CSeIeK7aZ+/sifzU4zOAfwdtTk9oc5WCXUF7aq5dduFMxBCQjpkjhbpvrJkneHa+wkzgXGvqkpKRf9Qe3Zfgm3yiWt1akKPq1AVYfkeMpn+hbiW2qi98vLIkMshApKCqg3lrpHX5+bakIlR+nONEDF2S3w0unX0xDzuANi/J6oMR8iZByQ7dmzX7CsCfFad57PxW9Os2/9z0vYj2AcRS7qdXLY1rQ+T3MXWN8mSlJyA4hRucvR5fHmz7WYFTf+58iopA==;5:rvCfOmUO8IBZcHqq9JJTBwzu1t0lq/4/Yl9CMD75w9Tz0+u9V4AJVm5zLy6wK5xjXwjVX394ZTl5UCYAkIplk7y1Z2bxeFqtGft6/dBRYRQxl8gmZ2kGyUg5J8VKYaP4Ni0EfzStKkSU3o4KRCT6dG+JMSZA3YL72dprIG89Xf8=;24:RotL7s1xPHFM87ZsANd80LwmEbkM5BrBubxMuH5TQXIbhkFzg/EUAwlZZYdGc7UjoUWAYgvMYKiGLJf1bqAns88YipMsEzHcg2pTtfq6g8c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1723;7:QEp8EVfuk5NuNvNZ6GQWjamm8S35QDl5IBy7IbacYNcr4xed3NlcufvxaXnVIukH1kHR+lKjrVX/JPFfpQMFTDCBzoqoko41nuoYq6vIcgr92tWETSWpz4IqVt6ckVmhsy8e+NF+kfDQdZQtZ8Wep1mPEuX87Br2R9+tYztdvufb4V5tO9cXCJ8ht8xUzpGGqIVJFzrGsadCKFIi17bHFtAIMzkJL2MCgkef90MakiuBN/gubmga3SD9fVPYiOn1;20:9sJJm1IOBE4Xmf6wkZeBZoOv4yTtE8Ic91fXtmQUDudg9V+Ce+YN8jnG1jg+7NZgyIBKW8a1dF36XGuEU8iuhum16uV3XD/cQSKgVvNwACvLzhEuVCy2x/tvWPsjSaTw7Y3t8AOf+6K2OACS0D5pt6ImLWrd4rw897S7LyvEoIkSV4YFV4tt8ObQTjbzu4dkyVTXzJnexpfZpyH4pe/shwNn5wa85NZYoIqoPO43LLUw6L6/Bhgf6/5ORFHSA1zc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 18:28:40.5379 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3459027b-cbe8-4ad5-5f25-08d594d9bbba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1723
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 28.03.2018 um 18:25 schrieb Logan Gunthorpe:
>
> On 28/03/18 10:02 AM, Christian König wrote:
>> Yeah, that looks very similar to what I picked up from the older
>> patches, going to read up on that after my vacation.
> Yeah, I was just reading through your patchset and there are a lot of
> similarities. Though, I'm not sure what you're trying to accomplish as I
> could not find a cover letter and it seems to only enable one driver.

Yeah, it was the last day before my easter vacation and I wanted it out 
of the door.

> Is it meant to enable DMA transactions only between two AMD GPUs?

Not really, DMA-buf is a general framework for sharing buffers between 
device drivers.

It is widely used in the GFX stack on laptops with both Intel+AMD, 
Intel+NVIDIA or AMD+AMD graphics devices.

Additional to that ARM uses it quite massively for their GFX stacks 
because they have rendering and displaying device separated.

I'm just using amdgpu as blueprint because I'm the co-maintainer of it 
and know it mostly inside out.

> I also don't see where you've taken into account the PCI bus address. On
> some architectures this is not the same as the CPU physical address.

The resource addresses are translated using dma_map_resource(). As far 
as I know that should be sufficient to offload all the architecture 
specific stuff to the DMA subsystem.

>
>> Just in general why are you interested in the "distance" of the devices?
> We've taken a general approach where some drivers may provide p2p memory
> (ie. an NVMe card or an RDMA NIC) and other drivers make use of it (ie.
> the NVMe-of driver). The orchestrator driver needs to find the most
> applicable provider device for a transaction in a situation that may
> have multiple providers and multiple clients. So the most applicable
> provider is the one that's closest ("distance"-wise) to all the clients
> for the P2P transaction.

That seems to make sense.

>
>> And BTW: At least for writes that Peer 2 Peer transactions between
>> different root complexes work is actually more common than the other way
>> around.
> Maybe on x86 with hardware made in the last few years. But on PowerPC,
> ARM64, and likely a lot more the chance of support is *much* less. Also,
> hardware that only supports P2P stores is hardly full support and is
> insufficient for our needs.

Yeah, but not for ours. See if you want to do real peer 2 peer you need 
to keep both the operation as well as the direction into account.

For example when you can do writes between A and B that doesn't mean 
that writes between B and A work. And reads are generally less likely to 
work than writes. etc...

Since the use case I'm targeting for is GFX or GFX+V4L (or GFX+NIC in 
the future) I really need to handle all such use cases as well.

>
>> So I'm a bit torn between using a blacklist or a whitelist. A whitelist
>> is certainly more conservative approach, but that could get a bit long.
> I think a whitelist approach is correct. Given old hardware and other
> architectures, a black list is going to be too long and too difficult to
> comprehensively populate.

Yeah, it would certainly be better if we have something in the root 
complex capabilities. But you're right that a whitelist sounds the less 
painful way.

Regards,
Christian.


>
> Logan
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
