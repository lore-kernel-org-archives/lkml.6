Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751399AbeDFG4J (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 02:56:09 -0400
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:37114
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbeDFG4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 02:56:06 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [RfC PATCH] Add udmabuf misc device
To: Matt Roper <matthew.d.roper@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dongwon Kim <dongwon.kim@intel.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>
References: <20180313154826.20436-1-kraxel@redhat.com>
 <20180313161035.GL4788@phenom.ffwll.local>
 <20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
 <CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
 <20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
From: Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <2411d2c1-33c0-2ba5-67ea-3bb9af5d5ec9@epam.com>
Date: Fri, 6 Apr 2018 09:55:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: DB6PR0301CA0044.eurprd03.prod.outlook.com
 (2603:10a6:4:54::12) To HE1PR0301MB1946.eurprd03.prod.outlook.com
 (2603:10a6:3:e::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d6e5b01-5630-411a-0329-08d59b8b7618
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0301MB1946;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;3:OgiCfgT9pDaFaj1zwweBTVcWQZog4ZigOtfFBU5cKn5Yz+4PbIj140defrJR6EgzuSCI4x1RmlgRBIA2cy74/aogPKX6q6wMP25lu68np8vJuP/2yohR33DhQj/LsIFyKU0WEuL2rGQSzHYCFxVl+S8F6TmfD+RiUlDdOQdCyR5Wj9mhDnGfz0GpiCrBQnhLFXSPYRdcTbyf785a2gR4Zsana+H7/6puR5TVHiyax42K/W/zJv6W3dXMkvai22Qt;25:w0QT/dzpOzJY7cC+gC3qAq/5GBNcYsAnNqctXOUZ9Ix5EpJbMTBhQwvUU24w/ZEYSdJZm/b38JhwRTRZdwU5e/1jd0gH5dLOPZK8fwbXTtmQ1itHHFBErtx/f6VcKDVShEGvPohPQTHCHQL0VIgRkuINXZwV7OtO4vCD68dTutVLeGbKVF0n/0UCfXzH/+cxGkd+Oa18Egrae17bTVXa6TZmlCBc6Y79kKJVxkajo4CqsnNUvRP4AMvizYGWuFbZ0PpQMXQbllLq4OJvXH4vocuGuEHacKVO/yh5K7eb6abBvtboDmKDCosLkIp84LMR1Bu90RSpR6haFns3IpS5nQ==;31:0nulab/y1zOojebOswSmdqEFc81gB1QxqGKzWnlQEE9qYW08gsgq5OsYrbP4aSb7gW01q6RhDGsfXT4ildmJGKX0qxKInzu/2cnaCREKOu7vETMZ3fI1VA6YVi2wvu4r+tHRUN1FKZCCgDO2AVx4+l/M/id3DciPmpqWK539g6NuYMSUcXGJIfVsf/7CqAzegLwcreL0b5fw0M08ijpylcXyiJL9oBZUIag9NXh/J1g=
X-MS-TrafficTypeDiagnostic: HE1PR0301MB1946:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;20:dEIMN9Xu54yZ63P8WntN+LuzybnLSabF/Ml3BJsgoVA3oszs0EerU6eMYmAheDlzw1RUSZHRSmCy+9WjsuA8N8PEhPzQ1Q50RsypusnUf+MxANb0F2kLA0P6kcEdzgfBQ6kEPeGH0uNVDWSFE4yDbVm4WZKz75qyFdjd9iKcC9MeGmJSa2VHCysrT0iB+3Ky2Ed+kFwb7tTtM2N7NaOZJMu4t1d0YO9Rb2IjlfWOO3V/72TPlDRs8DEYKsHfnS9z9xU8KUVqYhpOl7uKZSUvHdoj20SRrWH80bFHA8JmGk+FcQj3VHNucvx1pT2v2/gf1sl5neBULBkN4rDUfxqUE9QJileENMTJO01DiM8SK89R7gHRl0l5JJEDSpTbkU9DaHoowLvV71uq2vJsIB3I+zcAm0pmMe4QOcObMLNgfJn802rT943L8XqDNPQU+WKpC+PeRkr1yl8Ey9USMID9NuFhin0vLRr++2JFbupl3jCPVNVC4BqAIJ7+pjK/fzrm;4:vds88xqHwcPbRA0SA/5yZEJaPX/QIGgTC8nbxr81oHRtU6hXNo0hQk6ZkppCG0P8K4NwT8PylPSKhlDflp80nWKgmbPUrvEJR2JhmTvuqqY/DHUsEdkirq/RxL7R4Bh3S8e7syhhgBmqeSDl4O8AQRmofDAqc8Dk/xV71cZdpWvf9+UKnwb+BjAwZu1+H+Zdgyao1v/KedvR+mpizcskgOAmHerxW8RZUB+CvGtDMEqh4pf9oyVemx3TxzvRQEJBglMVtOi7cOATd00Lzq+2WqyJnZA9cIvTYHTJWqHnj0ytkbVOqp5ZEYBupikO871wHi9o3UZKbIZ6bWH+fqGMurM2hSSMtEyXhPNKZ8j7BMzS6jBgmQFdNe24tmVnRZQr
X-Microsoft-Antispam-PRVS: <HE1PR0301MB1946EA3DBEC03D25A5B31712E7BA0@HE1PR0301MB1946.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(5213294742642)(21532816269658);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0301MB1946;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0301MB1946;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(39380400002)(39860400002)(366004)(189003)(199004)(5660300001)(25786009)(186003)(47776003)(6666003)(2486003)(65826007)(110136005)(23676004)(4326008)(7416002)(55236004)(52146003)(58126008)(54906003)(106356001)(97736004)(105586002)(6486002)(93886005)(229853002)(966005)(316002)(16576012)(2906002)(2870700001)(7736002)(77096007)(16526019)(305945005)(587094005)(6116002)(76176011)(59450400001)(6306002)(386003)(8936002)(26005)(53386004)(53936002)(68736007)(52116002)(64126003)(478600001)(3846002)(486006)(66066001)(65956001)(72206003)(65806001)(31686004)(8676002)(86362001)(31696002)(6246003)(2616005)(956004)(11346002)(81156014)(36756003)(53546011)(67846002)(446003)(80792005)(50466002)(81166006)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0301MB1946;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAzMDFNQjE5NDY7MjM6N3JzQkFTK2VPUmpQVnRyVjI2MjBiUDdj?=
 =?utf-8?B?MFhaVWlPVzJPWStmRlgzV1VUTklMNzVRV2txQWtEcGkyRHpvRE9uSm91VUFE?=
 =?utf-8?B?dEdESGp1OW5WVWdtaGdsRTZuTkJONXVzVXUzWkVSQTBJekFMRmlJNGYvK3FC?=
 =?utf-8?B?QU43SDh5ZVdveDBFbStwcWd6WkVXTDRUak1rdU1FeHM4ZW9jaW1Zc1NQZ3ZS?=
 =?utf-8?B?VWhwVlFiSWhuNFZpSEhnNXdxeGRsdEpmWjVEVm5oQ1NqT2JrSnNoall6akpq?=
 =?utf-8?B?SUQvUWpaaE1pWjQydE5OZ0VwNGtjWWl3VjJsSDNUU0gxeFZCbjM5dnBidS9n?=
 =?utf-8?B?eFM4NW15L2Y4VEpqb3VIMjA4R21aS2dWclpPNjNoWFpVd21tOTZ0OUlpN3c1?=
 =?utf-8?B?VWFoM05nOHFkcEtMZGFHbWp2RkQ0MTZNTnpjZHJtWkZsQmo3M3RIaDlubmg3?=
 =?utf-8?B?a3M1MWVGR2poQ2pVVm84b0VyL2s1NDUyTkZiNnB0eDVGWXhLd1R4Z1gyL3Rj?=
 =?utf-8?B?RDFVWVQvWU85UXpYd1BnUjdRL0hpME42VVA4R2JwblkzS05kSHZDQVJ1cGRM?=
 =?utf-8?B?VG5kRldSYXFnTlBFQWRvVnppSmRhZDljdk10bTNMZ3Z5TjczMnRuUHQzNXVu?=
 =?utf-8?B?ZnpjaHVrTWJTZTBWY3lVaDJjSjAwRk8xZUZESFlmQnAzL25GRGdhTW1yUm9y?=
 =?utf-8?B?ZEJaMzQyc21YMHQrUGxHZnNMeklzcDJpMDJIeUdjTkxXTVhRN3Nwb3NHcGpC?=
 =?utf-8?B?ekpZR1VZalp0UkFhS2d1Q1d2T2VOMEFiejBZUm5sYVZyRzYvM1ZJZmlJUmxT?=
 =?utf-8?B?ditXb0dzc29Wa2hpQWZCcU1KNS81elNySXNIek91aGcvWWlmR1hWQWtMczRW?=
 =?utf-8?B?RHFPWDY5dDdHa2FrWEZNd2pZbEpXMGIwNVFJYVk1V21sYkZPbEhYNmhKQ3dP?=
 =?utf-8?B?bzZlemVqb1ZUREw5aXF2ajhvZ0R2SzdhdXpRMHBobUJTNlZBV0x2dUlTRm5N?=
 =?utf-8?B?SWVaTS9zY1R5Q1BXbUJ3VDZvNU9kSjlYa2F5Sm5xSWU3Zm5NUUtQQjZVcmZR?=
 =?utf-8?B?SEEzdk5OcTgzQWVjRWppUUJ4RXRFT2ZsVit5ZE05RitUWUJPR3NtbjFYcWRN?=
 =?utf-8?B?Q09BRTJibXIyaU1jSXN1Z2VBSHZNSDFYaHF6TkFGRGg4R0t4V3VibTJxenhu?=
 =?utf-8?B?Z0d4a1QvYm5lL282SWwzZFhYTy9HV2FRVkYrbVZNOXp2V015RTNyOEFxbXBv?=
 =?utf-8?B?SnVUVi9WU3ZjdXR3SXpoQVFZWDZCbjZ4QmNldXBXMUFLYWlneWRRK3BPMThP?=
 =?utf-8?B?Mzc2MldzaXlLZmJTOG5OTUlMT1NITmpsRmM5dEhTekgyeDJEdkpiRkhBdnll?=
 =?utf-8?B?SlVyY0ptQldBUTZYWHFSVWdiNStkRk9qS05vc3k1bk9KY0ZNUWlSSVRkTzh4?=
 =?utf-8?B?VWRKZHErN0R4U2QxcjFmZDZhY1M3Uk1ZUmF2VFgzOVQwRC91UlNKSEE2dERC?=
 =?utf-8?B?d21HemoyU0FZQkVBajV3L0lBazUrdWc5QjF1LytKbW96TUhMNGVIUVMzZVZy?=
 =?utf-8?B?K3pJL1pkbWdRN0djbnRYamV6akZFZmdkMmdpTDUzcDhYWjN0dWVVM1ZTK2tN?=
 =?utf-8?B?SXBkVzRFUWdUQmNUUkN0eDJwVXQ3SVFvNmRzN3l6aHA2RUo2Q1J3MElSZmVP?=
 =?utf-8?B?MFRQenlmbTlIZzB3QmtrSUxLNmRRaEcyN3huZWFWSjUxOTZJSlZIN3lic2U2?=
 =?utf-8?B?ZDVrazRGUytsM2p3ekYxWmVTckhRYVNNSUNmNEJBUytnK3NoUHNJM3BrNVVH?=
 =?utf-8?B?aVZvYS9OYklRc2t5SXZOUzB1eGRxc2dIWDhZdDRsMHRZaFNCOU5lYXd4ay8y?=
 =?utf-8?B?andBeDB3YzB3N2xZRVlSejdNaXlCSDN5Ly9TUHUvUWsraCsxK2JjazdhNi9t?=
 =?utf-8?B?cWphQjVnbUY1L0NFNFZPQzFoZVhMS1RTV1JWOEgzS1IxTEluY0pLUHp6eVRQ?=
 =?utf-8?B?R04yS2JjKzRzakNOaXI1UEpSdXc5R1VUUWRZR0N5eGpFdkFJdTdDdGMzZ0c2?=
 =?utf-8?B?WmdsNHFCMlBxSXFUZGdXL0VtdkEyamJreGpMZlAydnF0M0hzMUYvS0RpNXh2?=
 =?utf-8?B?R1dRVlpoRUNEZ1kzejhMWXhjMkM1TXRIeEl5ckhVVUFDSkNEbjd6QllsWWRk?=
 =?utf-8?B?NkJ5V3dPNUNzRFRYNG0rODJqOXJMOHRWRVIzSW1UYTNOcWIvWXhHd0srQVha?=
 =?utf-8?B?NDNZY205YWhnd3cyREQxS3d6eVNKeVUyU0VKZVlaSVlKczdublNhVTlBPT0=?=
X-Microsoft-Antispam-Message-Info: dVOH+oOwdOgOffn31F7Ovi2AYZgUlpPAqCBCA8OXqK+lGrC0mTIPvM3/zMN4PjKXua8eulWftUsrzJeymOzdJ7tTW7sCMx2W3obRbU1Qxq0utpup7xh6TwGR2Tcz+fVw1tvLd+0NcQgfyfloN+B5d5bRExvosVst0FXtOabI4khe22E65wtoA4DVar4tNkgE
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;6:XIJKZhTPZHxk7qxv6VRQlr+0ScfbEr7VqRuoZchsYd7biujxciFDadcOgxfe0YgnhoJkQR0BWz2WvsMKV0czwstxjcDAAJ+KrQOai4rvTgJfgYrMe8SlEsgzdaM35Mq8JTkosiKuHCOTJ5r78ThR0iYgf2qEsFSVdU3bFhP06ItfYqlcZiH16VNMApTDetMxQ81pxZXBw2unqj/WOgZSqjLVxfdzmaJfF74K9IkQvG9n2uUAMDaymWEflgJZqX7YrzO3i00G9t45t0+Bv/hpez4nkQBi4Fj3nYv1Mh0oIv8Y+hJilReU8rSbtKmURPuGukqDm1Gns9+y7yQw11d3zvLlQvnEHSerJfcTU1S0fG7ZGmxdEcEThqyvLHuUhU1HFzRc/3b7lAPJjLy5Ind/0MjXXKEkApvcBJKJ0+WmKOxvQpMUKtjKQ1rmrwsKWzCfpKemHcHe8xW98bz5xx0erg==;5:Plpu7+lBv0IUEzEAvZOL1igTJkg6gtMRsCfkhpi2xNPN5CWa2FQ3LW1QzikJ/FMHEHk0+ZjrE6g7aKtOaiYBE5YeEdW4TrIpP4ZIkdr16K/z7NcL7YUcSWCfmhYGjIbEG8675jRFkWnmaMtUVVeA79a3PHxwknXF4kiRXbnXVIY=;24:BPwUkltKLYwTzgw6S0UrKest7ZwN/CA28XGjMfk0IV7nHhfBXC0Mnb5U1YFJ6ozconu++0ivCFKCKWH8IrzbjpDYKKN1f0/bug1/z86iGfs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0301MB1946;7:7OSyBPctsSORlyHocMIb5e5nMnSwmLDLSMWjTLxhlSl53EwGK82l9Pv90JM9v/tM/g8tTz0jl7FsZzY8IPfZNGgSGp6aV6jIrjCSlFGhq//dkMqQ3D6zYLs9uVPFDpVAu5hA558NLIuQ1f/Lskr3tf5Piryhwe4AxMeMLpxzkbljxq7Srv0rXjJ736140P16zoisAC1PL29rsudZ6Ynv5v9oKHypBLcSn3FPPny99Cp8XS2ZiwLeTTPMKbo1XoYn
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 06:56:01.2930 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6e5b01-5630-411a-0329-08d59b8b7618
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0301MB1946
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/2018 03:11 AM, Matt Roper wrote:
> On Thu, Apr 05, 2018 at 10:32:04PM +0200, Daniel Vetter wrote:
>> Pulling this out of the shadows again.
>>
>> We now also have xen-zcopy from Oleksandr and the hyper dmabuf stuff
>> from Matt and Dongwong.
>>
>> At least from the intel side there seems to be the idea to just have 1
>> special device that can handle cross-gues/host sharing for all kinds
>> of hypervisors, so I guess you all need to work together :-)
>>
>> Or we throw out the idea that hyper dmabuf will be cross-hypervisor
>> (not sure how useful/reasonable that is, someone please convince me
>> one way or the other).
>>
>> Cheers, Daniel
> Dongwon (DW) is the one doing all the real work on hyper_dmabuf, but I'm
> familiar with the use cases he's trying to address, and I think there
> are a couple high-level goals of his work that are worth calling out as
> we discuss the various options for sharing buffers produced in one VM
> with a consumer running in another VM:
>
>   * We should try to keep the interface/usage separate from the
>     underlying hypervisor implementation details.  I.e., in DW's design
>     the sink/source drivers that handle the actual buffer passing in the
>     two VM's should provide a generic interface that does not depend on a
>     specific hypervisor.
This is what we did for display, sound and multi-touch on Xen:
we have implemented generic protocols which are OS agnostic.
Have you started prototyping such a protocol for hyper-dmabuf yet?

>   Behind the scenes there could be various
>     implementations for specific hypervisors (Xen, KVM, ACRN, etc.), and
>     some of those backends may have additional restrictions, but it would
>     be best if userspace didn't have to know the specific hypervisor
>     running on the system and could just query the general capabilities
>     available to it.  We've already got projects in flight that are
>     wanting this functionality on Xen and ACRN today.
Should we add corresponding communities into discussion then?

>
>   * The general interface should be able to express sharing from any
>     guest:guest, not just guest:host.  Arbitrary G:G sharing might be
>     something some hypervisors simply aren't able to support, but the
>     userspace API itself shouldn't make assumptions or restrict that.  I
>     think ideally the sharing API would include some kind of
>     query_targets interface that would return a list of VM's that your
>     current OS is allowed to share with; that list would be depend on the
>     policy established by the system integrator, but obviously wouldn't
>     include targets that the hypervisor itself wouldn't be capable of
>     handling.
Can you give a use-case for this? I mean that the system integrator
is the one who defines which guests/hosts talk to each other,
but querying means that it is possible that VMs have some sort
of discovery mechanism, so they can decide on their own whom
to connect to.
>     
>   * A lot of the initial use cases are in the realm of graphics, but this
>     shouldn't be a graphics-specific API.  Buffers might contain other
>     types of content as well (e.g., audio).  Really the content producer
>     could potentially be any driver (or userspace) running in the VM that
>     knows how to import/export dma_buf's (or maybe just import given
>     danvet's suggestion that we should make the sink driver do all the
>     actual memory allocation for any buffers that may be shared).
>
>   * We need to be able to handle cross-VM coordination of buffer usage as
>     well, so I think we'd want to include fence forwarding support in the
>     API as well to signal back and forth about production/consumption
>     completion.  And of course document really well what should happen
>     if, for example, the entire VM you're sharing with/from dies.
>
>   * The sharing API could be used to share multiple kinds of content in a
>     single system.  The sharing sink driver running in the content
>     producer's VM should accept some additional metadata that will be
>     passed over to the target VM as well.  The sharing source driver
>     running in the content consumer's VM would then be able to use this
>     metadata to determine the purpose of a new buffer that arrives and
>     filter/dispatch it to the appropriate consumer.
>
>
> For reference, the terminology I'm using is
>
>   /----------\  dma_buf   /------\ HV /--------\  dma_buf   /----------\
>   | Producer |----------->| Sink | HV | Source |----------->| Consumer |
>   \----------/   ioctls   \------/ HV \--------/  uevents   \----------/
>
>
>
> In the realm of graphics, "Producer" could potentially be something like
> an EGL client that sends the buffer at context setup and then signals
> with fences on each SwapBuffers.  "Consumer" could be a Wayland client
> that proxies the buffers into surfaces or dispatches them to other
> userspace software that's waiting for buffers.
>
> With the hyper_dmabuf approach, there's a lot of ABI details that need
> to be worked out and really clearly documented before we worry too much
> about the backend hypervisor-specific stuff.
>
> I'm not super familiar with xen-zcopy

Let me describe the rationale and some implementation details of the Xen
zero-copy driver I posted recently [1].

The main requirement for us to implement such a helper driver was an ability
to avoid memory copying for large buffers in display use-cases. This is why
we only focused on DRM use-cases, not trying to implement something
generic. This is why the driver is somewhat coupled with Xen 
para-virtualized
DRM driver [2] by Xen para-virtual display protocol [3] grant references
sharing mechanism, e.g. backend receives an array of Xen grant references to
frontend's buffer pages. These grant references are then used to construct a
PRIME buffer. The same mechanism is used when backend shares a buffer 
with the
frontend, but in the other direction. More details on UAPI of the driver are
available at [1].

So, when discussing a possibility to share dma-bufs in a generic way I would
also like to have the following considered:

1. We are targeting ARM and one of the major requirements for the buffer
sharing is the ability to allocate physically contiguous buffers, which gets
even more complicated for systems not backed with an IOMMU. So, for some
use-cases it is enough to make the buffers contiguous in terms of IPA and
sometimes those need to be contiguous in terms of PA.
(The use-case is that you use Wayland-DRM/KMS or share the buffer with
the driver implemented with DRM CMA helpers).

2. For Xen we would love to see UAPI to create a dma-buf from grant 
references
provided, so we can use this generic solution to implement zero-copying 
without
breaking the existing Xen protocols. This can probably be extended to other
hypervizors as well.

Thank you,
Oleksandr Andrushchenko


>   and udmabuf, but it sounds like
> they're approaching similar problems from slightly different directions,
> so we should make sure we can come up with something that satisfies
> everyone's requirements.
>
>
> Matt
>
>> On Wed, Mar 14, 2018 at 9:03 AM, Gerd Hoffmann <kraxel@redhat.com> wrote:
>>>    Hi,
>>>
>>>> Either mlock account (because it's mlocked defacto), and get_user_pages
>>>> won't do that for you.
>>>>
>>>> Or you write the full-blown userptr implementation, including mmu_notifier
>>>> support (see i915 or amdgpu), but that also requires Christian Königs
>>>> latest ->invalidate_mapping RFC for dma-buf (since atm exporting userptr
>>>> buffers is a no-go).
>>> I guess I'll look at mlock accounting for starters then.  Easier for
>>> now, and leaves the door open to switch to userptr later as this should
>>> be transparent to userspace.
>>>
>>>>> Known issue:  Driver API isn't complete yet.  Need add some flags, for
>>>>> example to support read-only buffers.
>>>> dma-buf has no concept of read-only. I don't think we can even enforce
>>>> that (not many iommus can enforce this iirc), so pretty much need to
>>>> require r/w memory.
>>> Ah, ok.  Just saw the 'write' arg for get_user_pages_fast and figured we
>>> might support that, but if iommus can't handle that anyway it's
>>> pointless indeed.
>>>
>>>>> Cc: David Airlie <airlied@linux.ie>
>>>>> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>>>>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
>>>> btw there's also the hyperdmabuf stuff from the xen folks, but imo their
>>>> solution of forwarding the entire dma-buf api is over the top. This here
>>>> looks _much_ better, pls cc all the hyperdmabuf people on your next
>>>> version.
>>> Fun fact: googling for "hyperdmabuf" found me your mail and nothing else :-o
>>> (Trying "hyper dmabuf" instead worked better then).
>>>
>>> Yes, will cc them on the next version.  Not sure it'll help much on xen
>>> though due to the memory management being very different.  Basically xen
>>> owns the memory, not the kernel of the control domain (dom0), so
>>> creating dmabufs for guest memory chunks isn't that simple ...
>>>
>>> Also it's not clear whenever they really need guest -> guest exports or
>>> guest -> dom0 exports.
>>>
>>>> Overall I like the idea, but too lazy to review.
>>> Cool.  General comments on the idea was all I was looking for for the
>>> moment.  Spare yor review cycles for the next version ;)
>>>
>>>> Oh, some kselftests for this stuff would be lovely.
>>> I'll look into it.
>>>
>>> thanks,
>>>    Gerd
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://lists.freedesktop.org/mailman/listinfo/dri-devel
>>
>>
>> -- 
>> Daniel Vetter
>> Software Engineer, Intel Corporation
>> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
[1] https://patchwork.freedesktop.org/series/40880/
[2] 
https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c575b7eeb89f94356997abd62d6d5a0590e259b7
[3] 
https://elixir.bootlin.com/linux/v4.16-rc7/source/include/xen/interface/io/displif.h
