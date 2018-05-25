Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936108AbeEYI2w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:28:52 -0400
Received: from mail-co1nam03on0065.outbound.protection.outlook.com ([104.47.40.65]:6688
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935989AbeEYI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:28:48 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH 0/3] Add parameter for disabling ACS redirection for P2P
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>
References: <20180524214816.14485-1-logang@deltatee.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2aec7435-e59b-9ef8-825f-029188f6e549@amd.com>
Date: Fri, 25 May 2018 10:28:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180524214816.14485-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM6PR0202CA0016.eurprd02.prod.outlook.com
 (2603:10a6:209:15::29) To BN6PR12MB1713.namprd12.prod.outlook.com
 (2603:10b6:404:106::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1713;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;3:u56UWomb2rLMqEgxfjrpbbvTumHeD1j5m15OGzaLTLk36YEK4tBuecXMIaLtcTkYNdObk2vMaFDE299YVSRrCxk6AKLsYdXyDV1tp3Pazt1GjISr9X1QisiGXkc5e47+nOk6JXgDNdVlqCZ5YgXnDNXi1jYzB6MYLsg4vA+4fq1h5WoVt4is2u9aR68fcX+WgY4tcyW+MmKtTRALCPXDEZbdOMJ9D+71zEO1OXCuHY4BvYjSDPW8ZXG6N5hhiGA9;25:Ao4IZ1R4hEKyvHwy4e7UWKS4Gfhd1FNYgBVGa28Ybs1c0vriOJy1Z7D6+EqwHg41rlMQ5suXJvad2F+4K473t4pRLTBBwUd0bc1zJvanhkVxH3nSO6hEWyVovoPwwR23PRnlZNmNw+yPUtjWrVVi59CmlH3l5+wE4z+/3QYCEKrX/lwArwMGEKu38js4e0DdOEchgwK8zKt9i7f7MbKQ4I3RebbcNWtFg1vvzLftC9Oxses1fGcE+xN9PMtxBJrXZRRLHPJzayfWQRHTHYBiK3kXO5tSXHBZ/nmOi51fSmib4OLH1AXT3k9Ei+DCGI2vGGidcu2GBOP2sapPjUGp8Q==;31:bDvajHPjdOyUDPSRlIcd5tZ/6Wfh+N4AJQ5w1EWYhiYlQAqXiF5jvfOfMuwunKwC0JnkrosO0IjTXcf1FN8GldiZvBLIqJb0MRvAMKL/e9JfcTWCHGqGWBjLUk1moW1pTmvkAg456Ph0pWRDkwd9V979DY5DBWJorcrjdcCCGx3VMjB9HXaVbZeNNeBPiR63OKnKJewyjCZ4D/CN9sNlLiErK2Qfx+JS+B9oOHoikCc=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;20:QIw99iG2ut1P/orNavkCv1jpm6NLl6IedKfEXluvmP3lLlEcQkr3t3j5rW+S1ZccGrnrrL1Dr1IUEJMUVC0jEQgYOF7LnlJ8M0wp/l1k3EcKX69ZfQCX7NGv2sKd1oiGaC9c80u5Wmdi8WglpuXoYThTAP/E2jakp01lGzo2PZ9h/Ta9FyKC31LMicbU8B8kMYDjHZNiE9AVwoUTWFJ+pTAZbOGUDIBzL3AL5MB4kKimdr4BQ9UjP1lb6TiiNfKhxO6sgtlQv22ECT36vly4Jzktqwh08ngKLoQlHTX70qiSUdQH1C9FiypP7VUm5zEIPXrTbZfjtJzgpdtaVqUuVZMeactfcOlMOMZXdIdeV4LAsIjwLmBEmBY9CCjopfVrcEVGfzk2Nv5zSKLghsNTCRR86iYMot7Zn4DWAKjC5jFmKyjq5lzBu4g4LMyZGc94uOmUBkWrCpsu1247npYFcbMW8QBTDKCjv0+luVbt7pnU572aisqqEximDt8lR4oW;4:VbqhmB6Jr6HJmupNokH7LgLvOSW9WMsODWMyHR9tzOSJI8So1MIWn4Qsp6tyQ/6yytuLrBNkzHf0z1Cx0GgSggd2VyuLLRvJ7X92bXzbibRqvEwf149SNdSBsWKNcxj+pQ/xSoQTKT2thHcvuChyNF/P602xMpBNr5NMjtPqsR8oGGGx+R/j+/MnGCcw2pj+xnxoNtwiCZkyFqAhMJ9IHzUzcwQa7424Xd3DJL/EsvMzWeinYj1hXED9lF4BavWOtDT2wksHpd5M9aQkdCqntwRPtsqn5z4rY7tUaxEyC1YzxRxBCA/gFSEyOb6GUtfW
X-Microsoft-Antispam-PRVS: <BN6PR12MB171345106DE44F6E5223778983690@BN6PR12MB1713.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1713;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1713;
X-Forefront-PRVS: 06833C6A67
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(396003)(366004)(346002)(376002)(39860400002)(39380400002)(189003)(199004)(65806001)(6246003)(65956001)(47776003)(54906003)(2870700001)(36756003)(58126008)(316002)(53936002)(446003)(476003)(11346002)(2906002)(229853002)(6116002)(6666003)(186003)(16526019)(6486002)(7416002)(64126003)(486006)(86362001)(386003)(76176011)(50466002)(67846002)(52116002)(8676002)(305945005)(7736002)(5660300001)(31696002)(46003)(25786009)(68736007)(65826007)(2616005)(478600001)(1706002)(97736004)(72206003)(2486003)(52146003)(105586002)(52396003)(4326008)(23676004)(106356001)(8936002)(31686004)(81156014)(81166006)(59450400001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1713;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzEzOzIzOndhbEJEWDJSOHVua1BWWUs2STdESUo2NnFt?=
 =?utf-8?B?Ni8vZEFtR1Q0NkhxKzAzdEhra2krRlpEMkhTQzZnazVlUHZWRVhaQmV1Zy9q?=
 =?utf-8?B?OTBSdFdWUWpjcWU4N21yTTYxWDJIeEhYNTk2SmYxVzB0cDZIREFKd1k4eVhO?=
 =?utf-8?B?T2VETi9QMTFvN25VZzA3LzNpMW5QUW1mSmM3eFhtbnJqTFBSTzlWY2JpNUV3?=
 =?utf-8?B?N3B1ZVA5QnpmcnJsblQ3Tlh4TVM1a1JtU3QyeWtGV090eGRtekN2SkZrNUZs?=
 =?utf-8?B?ZkJUcnlZNUg5alRVdVRvOUU5KzgwZXRRM04wa0pkUzA1eHE0bVp1NFNVc2w2?=
 =?utf-8?B?MVMzVVZseW55U1ZHYklHMEM3QndxZkwvOEdGTFFPM29ERjBkN3g5cXFNVDhS?=
 =?utf-8?B?YlhTSzVWc0NLY1N3WTBXb0Z2T3k4RSttb0VUN1A1S0lXaUN1V1J1Sk1oN0JI?=
 =?utf-8?B?VGhNME9rK0pvY3plRGk1MG5DRnVNSncvNnkycys5cm53Q1RycDRMWnQ0ZENh?=
 =?utf-8?B?RzB3Yzg4a21kSEZlL01CaHV2N3ZlbS9CZVlqUUw1a3V6TU0xSGEydm1tZEVF?=
 =?utf-8?B?Y0Y2RDVPVEJhUXVWelg3bWJqVDVLK2VFOFhaRUpPTWlEYXgyRm4vVkFjU0U5?=
 =?utf-8?B?RFFpanBPN0VRUmpYdGVtOEhMR2h0bll3ZzVYS2ZPeDh1a1dhM3NYK2lmK1hz?=
 =?utf-8?B?NmpZOXhEUVNiWHc4Ti9zZkt6amNwVUNXbEdPUFhpQktTaUhjN2xsaVo3UXAw?=
 =?utf-8?B?WEE2aXhMSWVxYzNaWStpeEFDYmdxKzdtMGE2RkVKWXF6dXEwcHV0MmpJcTU1?=
 =?utf-8?B?MkNISm5vak1RbFBsbk1jWXpQOHd1ZU1TUEJ1UkJnRzhBcU1RTWJLS3dnQ1ZZ?=
 =?utf-8?B?OFV6VkwvSDVxMGVBNGpBbFJqT3V6VC9GTmRId2RqZG9DMmljYTNQU29uNFJ2?=
 =?utf-8?B?Z1dCQ1F5VjZCNElwUFhhNUdkNTdDQlZVVFg2YzlTWjk3SWFyK2lCQVlKT2x0?=
 =?utf-8?B?WlI1bWZTUEdaUGZHZjhJR0ZlcWJZM3ZqWHIwellPbWd3ZUFhdFlYWml6UHlT?=
 =?utf-8?B?d3J4b0hVNG53RmlaUW5zNjVqZWdVYjVxQnprQVJBWEI0U29GZnhZTkpFWC95?=
 =?utf-8?B?cFZ3SzMrZ0ZCS1gwQWh3L3EwclBaMzB6ZmFHYk56Q1kveGM0SVh1ejN5Y0R5?=
 =?utf-8?B?T1FiZE51aHVIalhWRHAvTHlWRURtdmRzMkVHeCtjVGhlLzJIMDhxQkliSmxV?=
 =?utf-8?B?N0NsS0NJOFdkdjdFNTB6VjA4c2NmY1RJZE5BeHp2akt0QXd0YTlBOW1seXFY?=
 =?utf-8?B?UGhENFZ2WU1CQkdqUVROc2l1THMvSHhNbkkzWVFpekUxSDA5WDBwSmwzc2Fu?=
 =?utf-8?B?YzZRWC9IVnJlTW1JS0Z6OEx0aTQwbjRlVU5sbUpWVHN2WnJzTUNnZVhFdlRO?=
 =?utf-8?B?cTlIUTZjSGdFTGUwZzNOU3hnSlBYQlNIbkJhcVZMMGVHMUpHOTJ2eEEvZEEz?=
 =?utf-8?B?V2Y2MWJBbCthRGQyY2RzbjJwQ2Q1LzhGYTJsVGd1blBneHVkaHNLNnZjNCti?=
 =?utf-8?B?OHVCUzdRbFlLdC94bmxBaWdGeitMUHE4NUtHTFFPc2FHSFpzOGRwQjJBdldt?=
 =?utf-8?B?YXFFUTRLVTZUNC9Ddld0cy9JYTMwUU5NZ1JidWl2eHVTSEkvSHRSZGpyOVk1?=
 =?utf-8?B?YUxmVlplM2M1cUNwZU5PcXAxZjBFa2pwdEUyTkVtckNKQzZ4a25sbUZZYkU2?=
 =?utf-8?B?M010TEtSOHQydWU3bEd0cGZKR1lRMVBVVnkzakxZUW5YdUVKS1Q5SlkwMGxa?=
 =?utf-8?B?ZEZzdmpZVEdhb2xBVmVpdjJBZTNLNFRLZkQ0TzA4dTBFdWZTbHFSYXNZdjY1?=
 =?utf-8?B?ZDRCS2d1bEN3ZTBIT2ZYMXFpK1FSdHowN2pGcDFnREtKTUo5bUxyOU9SM2hI?=
 =?utf-8?B?OVBlY3Zjd2pQeDRPcVllZWk2UW13N3dra0tMTVB5RUVFL2FsSElvSmRWRElV?=
 =?utf-8?B?YVRtb3F1NkI1cERpZlNQd0FsRyttNUZUSnVpbXdMbGczRnQvS3ZZdG1LTFdF?=
 =?utf-8?Q?XDXw=3D?=
X-Microsoft-Antispam-Message-Info: BE8waLh+ywn14T+CUdL09pLWzD0krMr9+7p470DCFxyYYoadffR9CQLB8qIHZ7SeSOT1DktvWHto+w7+fYM84LsgI94LpNqIm/AjZ17asfpJKE1SziJzuUVj39FNh8TvyzHdCjmqt4BP252I131a9RbRB9TTcFD9FgjnraH1K6SS0UJQfuF+1jvFEfogUTyI
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;6:oThTO83NELYPmE13+oIXAdfkUuOsBP+HqguybHqOK9NI2qIkCQnQYQvTifnZZycOkjvr1romWkxwMGx6mvZCiNVphVgGOI/yggnrT4hNdG6fF2bJe9cT+cbF2V5OxXzVizBRl5bYXIhMwTBFUYHMf4/Ip/n+5QICAqPwZKKwsWJo6oF+6MRQW5EtEib88zk6Nyjo+5AxNhMW5+eEZ13X7y1zPm+SGk/bovxVm2jwF9UMsPrm+VNOJOG7FMNvtDKjdqccSVPkmqHLsNaedS1J9ePLnRcG7p8QVb6KBOhK1crOSg0eu+BXnMHG+ocw+NsVXnXa9LTjEGXOPJzIGrJA4yU+2ynz8Yd4ih6fV9dZmT96J5C/I30o6rFEQ1JNtQMZTGHS+g9+B57SbyZ53IywtHbpPeDdn6/0wCQHANkquisZ4uqMJ739C6rZTuIySo6SK/TIZsHp9pS3oCt+rNynbw==;5:txsGkgiUsBX1UWjp0IawIPP9UGenjxQiXhB7h9Jjvf3AoHl/jOWoNs9mAvV8Ivk6gEc1jufXsrZVOZDPVU6dodqd3rZwJDxva1Y5l+Zs5Ma28d4+uq1wjxvV1bSNd6w5tva4jui0+QuyXe7ZwHIiC5nbu3Q9yTEri0Iu9fb0rdE=;24:bASPVb4V2Z/oNTI9HCvmcJRpRgE5ur+NG+abd4G4AHfXSCWT36QNJvaTVnZpIX+gRQDmZnTq13k1UqqtqPZ2lA//lYKlsZfvfLTyyyQTQ48=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1713;7:GuPlXOdCivgtIdpSS/6IsOUIB/B0E+2Y+niyBTEzbK1fcGb9AWMYRaz6E0eflAIGGVUWn05clQ7FJGk+g1OhYXs6UrSYBZ3wo71JiGEjjqG2MguGPqmi8Auhfg+4UW0kaUnlm0dEAeh7MFGRSgyXcFXG2uWqd58K6vJFw2364CAvKx5NaCf7g6TBJhKaVlqFa5EIGzIJMzcD+w4oB2s9mvOY13Wx76e1XVoMpFaAvnLXCBv8W5+yusecXTyVI5XZ;20:wcYCeUvq19QH2kVVKHhXj9lgGVSp5e17mMBMTbtOkowUkyvJ6Bf9iaBNrGIJNcMSCDekEvC/GJGdipzxCtab6Z1u/ySFyqwOqyEVpPgP1MbDLFrLSwyXx0WgjJVOKUKsNOiabHZVyglDkQLOC5xowFli7DQtUdT0rJXUtTahc6r/FdHg1UB4PfyirgfN13zdelzzLCFBDwABuPM+9IIOih43WIsSvTUtZPt6cjGyuYTED47jidai8z4l8HVoCdAX
X-MS-Office365-Filtering-Correlation-Id: e413ec8f-7160-4415-5ccf-08d5c2198768
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2018 08:28:42.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e413ec8f-7160-4415-5ccf-08d5c2198768
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.05.2018 um 23:48 schrieb Logan Gunthorpe:
> Hi,
>
> As discussed in our PCI P2PDMA series, we'd like to add a kernel
> parameter for selectively disabling ACS redirection for select
> bridges. Seeing this turned out to be a small series in itself, we've
> decided to send this separately from the P2P work.
>
> This series generalizes the code already done for the resource_alignment
> option that already exists. The first patch creates a helper function
> to match PCI devices against strings based on the code that already
> existed in pci_specified_resource_alignment().
>
> The second patch expands the new helper to optionally take a path of
> PCI devfns. This is to address Alex's renumbering concern when using
> simple bus-devfns. The implementation is essentially how he described it and
> similar to the Intel VT-d spec (Section 8.3.1).
>
> The final patch adds the disable_acs_redir kernel parameter which takes
> a list of PCI devices and will disable the ACS P2P Request Redirect,
> ACS P2P Completion Redirect and ACS P2P Egress Control bits for the
> selected devices. This allows P2P traffic between selected bridges and
> seeing it's done at boot, before IOMMU group creating the IOMMU groups
> will be created correctly based on the bits.
>
> Thanks,
>
> Logan
>
>
> Logan Gunthorpe (3):
>    PCI: Make specifying PCI devices in kernel parameters reusable
>    PCI: Allow specifying devices using a base bus and path of devfns
>    PCI: Introduce the disable_acs_redir parameter

Thanks a lot of taking care of it like that. It looks much cleaner to me 
than just trying to disable ACS without a parameter.

Series is Acked-by: Christian König <christian.koenig@amd.com>.

Thanks,
Christian.


>
>   Documentation/admin-guide/kernel-parameters.txt |  39 ++-
>   drivers/pci/pci.c                               | 358 ++++++++++++++++++++----
>   2 files changed, 336 insertions(+), 61 deletions(-)
>
> --
> 2.11.0
