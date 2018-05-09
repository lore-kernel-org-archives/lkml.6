Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934973AbeEINkw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 09:40:52 -0400
Received: from mail-sn1nam01on0059.outbound.protection.outlook.com ([104.47.32.59]:62624
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934915AbeEINkp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 09:40:45 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
To: Stephen Bates <sbates@raithlin.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180423233046.21476-5-logang@deltatee.com>
 <20180507231306.GG161390@bhelgaas-glaptop.roam.corp.google.com>
 <e58e8d27-42a5-ca69-3b68-c409a2922cd1@amd.com>
 <0b4183ef-e720-204b-9e85-b9eaf7a4136a@deltatee.com>
 <a943a92d-15cd-fb2d-21c3-5e5cfccd9eff@amd.com>
 <3584a6ac-95c7-5d23-1859-aee30605776e@deltatee.com>
 <20180508133407.57a46902@w520.home>
 <5fc9b1c1-9208-06cc-0ec5-1f54c2520494@deltatee.com>
 <20180508141331.7cd737cb@w520.home>
 <d70cf286-f7b7-99a5-1042-022506298fed@deltatee.com>
 <20180508205005.GC15608@redhat.com>
 <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <a1a36f88-fbfb-b5ee-6dcb-5c5bb96132dd@amd.com>
Date: Wed, 9 May 2018 15:40:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <7FFB9603-DF9F-4441-82E9-46037CB6C0DE@raithlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0402CA0024.eurprd04.prod.outlook.com
 (2603:10a6:203:90::34) To DM5PR12MB1721.namprd12.prod.outlook.com
 (2603:10b6:3:10f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1721;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;3:/D7URBkhIb9iPSp8nPccBmJ78kq/6RCD6xKQNBf/aJ8Q7HrI/hM7zUlgelzkpoOFRljUZxeXuNWk8dajfFBXnAWlRxDVdFF0HDTQCHjgjW7frvp04YdnUBlOvlrdHfjfTbuVFfi0XLP+3/f1DJe3DlPtMVj3zf0OhNcTV3AKqV0otKZ7C4C2J6/mkQ3yDd/alwVspl8wznh++Nm/d9KeBgc0xC+2DbLGsPljCGl/7v8xdffKNq49bhubcGCLPB0o;25:n7mu7hXmlluO2HWEGJ1l6NwjHw//2sApmBUeD6QjfJiygMiMKtwDkbMLk3qeGD5ty1mUhj8SqYJ/HJJz5uYV65ED+X4otIzPGFzIzfMIVQslYUy9gm+0BZXdoCdVOge5PL06Le+idd/SIERwx13F/6V73qijObCfXSQPTDIJILytbow0pUnE+BGF8ZrnC+QC/gUFwA1UK9ESQA/W9EmVE9VbNISrqCT8Kai09AoG/iMmGYeHQiDVvU1CWtXaR5zqx83wnLRZNZ0znGf7U3oDecm92/cq00QZuFo7eJ0COn99g1pt+LNIg8Hs1RR6FfrDs6SC4JN+eJyJQtJu0XFj8w==;31:5fUZpeo83A6p9UxN/U4WdfFt3JtM1g7PNvur4A3lp3fjbVRtALUgc4I2miOIAbGjTXX0wgu8+lQqjQAG1F6uFQDKRJ15PeQcfE9tMli93a1IQmjiGRR+wyXbpDHoGS5n2cOuky0Inz1mEt1zBeEwCDvJUO6j6hqRhhnQUhDJ2UtpwjixuRzuM4dmKSn6J6z3mm+BZM2Yi6jQAEfyJ+NCxw+op9SFkaxQ2iPbIZHj6Ik=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;20:9yBbpRMKdk4LSXOIRdHKRftmSPasgyb+7Hf/6JbvUUN5q6VIBxk0iN8o0tyLTtqU1dFBEhrcsfr77srJGBR2CnfwQtbAhxHYmkoPVWN7k9SiiRC5OTyxiAP2FMeYeHprjrL6mVHrPBDQBA17Xj5PzK+0Z6/J5HY0gadCh1zpDjm09ekfKp6FCQylaZMcMgaOFodDG4sfMXwfQFSRch9ojYGqaAAk5A5Kx3weaM7at8gWk8dm+1cffUWl8AVLfBshcXk7V0g8TDEkHDW3X39YQmTpIxwvAad51OxSTR7YazyOztTvpdkwxtG82RRiBidoiHXdNmdtZw+cWwA/nE//yGC08dGXaO6pYej4h1CRPz/R+NENiOIMpbdMmXO45bOKiRdqUNIS3TsWFvwipuld/jsGP5MO47xkEqRWDx6eH/8K17XS0dKMwQ+WeKq4wT+mMBlOHmIWGQPnchNULtYUlCu93Mt7Yo20vDcSOuu+gw6Eulr7JW4eRmMHQnYH4lnn;4:5fER0tzQqGyyDl8BDLM/+eZjqfomaOe900ThExFmKCEF7C8lj7NtdWGYKsVkVDLQKB8tPLyhPVLa2MDrZS2irBLXzraOJAVEU3xDwYB58afuOiF6EcIp0wIb6TxasGszI+icdsGY+fEqOPvyHndt0uP2zLDOA7Uw1b924FuXUFIuClIqxJCmZ54C46HLicBJyEh4EGrRvOcUgjwsT2w/8KwCqAHc2guKSA3CCXLTm/OzSruyhPZdAHCDRRAZkxlZp5xL/l+pOjIdZpAeh3GtSBkcsGIuMdBzaXrU/NsInSX8jRjCZlUa5nf4WJaa80yA
X-Microsoft-Antispam-PRVS: <DM5PR12MB17217BA74A85CB0A3A65774583990@DM5PR12MB1721.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR12MB1721;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1721;
X-Forefront-PRVS: 0667289FF8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(53936002)(6246003)(7416002)(59450400001)(93886005)(7736002)(52396003)(76176011)(65806001)(97736004)(305945005)(186003)(46003)(8676002)(229853002)(6486002)(23676004)(52116002)(52146003)(486006)(5660300001)(31686004)(65956001)(8936002)(81166006)(81156014)(16526019)(2486003)(65826007)(2906002)(72206003)(25786009)(1706002)(106356001)(230700001)(47776003)(386003)(11346002)(31696002)(67846002)(64126003)(86362001)(58126008)(50466002)(54906003)(4326008)(36756003)(446003)(6116002)(2616005)(478600001)(476003)(105586002)(68736007)(316002)(6666003)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1721;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzIxOzIzOjZhc0l0RXUzOE8rQnduNjE0eUlIZXJxVGJj?=
 =?utf-8?B?VG1HZW1WQ3l3WUcwQ3BXTVBSaUcxK2FHaW1LemNrbk14TDBpbEJMOGgrTjFN?=
 =?utf-8?B?Mm5VRWZvclp4T3ROUmMyNHpNckw2dldZWkNhZHgyMVBYMXF3ODUrVTNnZjBr?=
 =?utf-8?B?M2RRUXQvTkh6enhDUFRxOSsvUmt4NGhJb0pWek1yOEpPQ2F3RHI4eklyMldY?=
 =?utf-8?B?Zy93NENHRWMrdjVQZW00S1dWY1l6T1R6dWlucFRKY3phUnoydFdGVk1vcE5J?=
 =?utf-8?B?SG9jUGVSTDQ4RkNpQy9naGJuTXdHUG10d3FtNW9KM0dLSEFCM0F3Sk5rd2l2?=
 =?utf-8?B?SmtPZ0hSbkJDQ25VZzVoL1ByakVNRmEvcDRDaFNZSmdLOXlTQjJmNGIyZ1JO?=
 =?utf-8?B?akhnNTRBRVUzeGpNTDREbmNyZ2N2NDEzdktLMVR6T0xneFlSVEh6NG1LY2V2?=
 =?utf-8?B?VDdSRU9IWDJ5WDZ6QzBLeUx1ZllsRlArRUNpbGQ3eEE2b29aejl3T1duMmdn?=
 =?utf-8?B?WUVreXZrNVZRUnJSR1BGbUkzOHJSV1JrRCtHdllZcDZzRUwzOUpmRWpPdkl6?=
 =?utf-8?B?TUNJY3haWFlyZlFTa3p3NXBxRXJrY1d5M3JpdXVIQUUreWtwOXZOWkE2Y291?=
 =?utf-8?B?RGZnTGd5K0RyZkNTYk9EM0xLYnpDODE3THVSMUtkOTlDNzB4VHJCT1AzSWl2?=
 =?utf-8?B?d2pqYWZmZmFOMlgzZVlUY3lOMXpWak9vUXk2K1BIRFEwcWpHNUM2WGNQVFRp?=
 =?utf-8?B?aG5td2RjaXFYd0pVR21acFhBNFV1R0Rid3puTU1aUzVSaVJENDI2bnlsSi9r?=
 =?utf-8?B?cG14RFROOEdFN0Voa1lYd2ZJbXJEWWZrVjlJM1BzQjQ3eTJnRHlkWjNDRFA2?=
 =?utf-8?B?V2ppUkNuR3BwNUFCaFExWmZQY3JPSlM5NzFSb3FQd29VMmRkVk4rWTFhczM1?=
 =?utf-8?B?Zng0cDhEbzdXM05ranRsbG9ockxmUyttTWFTT2p6OElXRlZhQWN2NmwzYVB3?=
 =?utf-8?B?TzBhM0xQQnJUZ2tXdTVjeHB3MHBPUnRxaFhtVnlLaHNsRVh5Y3k0ejVWWUxI?=
 =?utf-8?B?ZU9WVDZveGFiT1VNR28wd3dkdDZna09Ba29yd0hibU8zZW14K2JGcUhYc2pT?=
 =?utf-8?B?cVBnOERVWWRlczhBOWtveFBYVll1WEJiRUk2eHQvQlJCckE5Q0tzNkFJOU80?=
 =?utf-8?B?YWtpUUU1bHRJekVUei9rTDZSSDFCYUFJNFE4ZnlMUndyRzlCU0d3US9OaThC?=
 =?utf-8?B?RGw5eCsxSk0vN1Fzd3pwVlZvUHdwblEyOFVPbDJ5eERaZThNTjJzUWpjSjRo?=
 =?utf-8?B?UHNyMnRlOCt4U01WNlFtY0dabzBUVVlLaFY2WTVGVmFld3U5OUN1Y1RPcUxj?=
 =?utf-8?B?VjQwbU9aWHp6YTRndnoxeUN6NytDWkk4OXFxSEJzWHVIY1l2M1VaYXRybERR?=
 =?utf-8?B?UkJubUZ5TjR3azIxNDl0Ui9lSCtyZGs3eVdsTzJZcDRWRUthNy9yNDhpNDdM?=
 =?utf-8?B?dHg0NDlwV2dDRmN4WjFrdkc4ZXIvRktZMjlxTDh0eld3cnBENjREdy9JLzF1?=
 =?utf-8?B?STJXZTdZOE8wVUxPd2E5cHp2RnAvS0RlMm54R20zNHF0TmNmcjVIQ2NneVdv?=
 =?utf-8?B?b2pZdi9kdWZtemYxY2Uwb01tMEcyTk5Cc0F1TmFEZkxyRjBaZlNHQk9lZllj?=
 =?utf-8?B?RXA3alVnaStlNlFPVzI5WlhnaDl1d2VKaHlIcUY4dVlPazErZ25ocTQwS29X?=
 =?utf-8?B?bDdDTnhGVkZDRE1UZExWYnFNZUhMZjYyY20vQzdMaTdsSk1uSU8zRzZRelYz?=
 =?utf-8?B?dUJhTVZ3VGFCeEFuTFhyK3NueWxOUmV0UXQ4bFkyTThseVJCWnZrdStSUmhE?=
 =?utf-8?B?RGZZRzRKSXJBay9WK3FJbW1DTzlwQk11VlFxcVB0WTA0TVBVeVBLdW1EYXJl?=
 =?utf-8?Q?XThvbWirixO3NGhGLVbk7gH+ubRAo0=3D?=
X-Microsoft-Antispam-Message-Info: JWZKgs89r7/3Jq6R+E5SHGNCjxuSJklQNnbni188D1iOcBQ8X92ke/3LN6L966rrRpGae5pxql2RnaL+/rMF5H47HxaxyaSB0NK27NclagpEa3S/2AYPQcfgAROT75+fQJWKycVqToHq5W0LfeVy3LTp/iOUUdvJq3NKoVqd4Yleiki+Gwjeb6awn/mhRM0E
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;6:V/iJZIZdRtyD7bZt/Vv+05OAoR5P2h224evrsKdawUrMK9Zq1PMkhZu6Ba16XhoQkOoo8yax+b7k8O2iddqImdVTHfrDzQyysuF7HkQ0f72HjHc/XISthqG+U8rCD6EV3LLBfln3AbvVR2NqV4myyVMEHXTL/RNSX/psdf9EOZAzln6FURX/7AvTyKImnEYGrar0SRH00O/BZtUwrtdAF/PoR9tJSzjY5R0Dy4qRPrHhCNB8oYHMagGAuV1svtzzqLypLZNWyTcaxtSt4eB8K4LM0E1OGufPt4MvJdNaLl2/CwSw5lFwTVaJjwsmjPW5Dns7BQ2UkiG3hQPRDehzwusXj68u6SbqLI32E0U1ZNcuBFXoWTM7IfqMuXYzkTcTOVUsgBb9PbhTL5/dT6AaNwKJAu3SCcszNpVUVDgx5jAFZqN68T2PL+fBQNKq/HC8NjhNt6oWhTNmgF1YLsw9Nw==;5:DveRWqNdlBiKN4oSMLMg+3Hd7niU4dIROOpB/hD8uIiykbVJ0AWV3RXi+Dxhtfb6hqWh4LHxU2xjjRXK9NbAbkXdlCuWvCvcQbl4QyXHUWgB//g8allGMzMOc915HrPZL6lswDkeo4fGXH9beqbhRTPDRlKD+ira2z13XZdLzAA=;24:X5vKThVXOo8I9MAhUSBYKyVPwCx2iyZ8ebACpsf0BhjP0PiuXIKxsdudpRR2YHfhkh6wPazgWP1tuElKq7APl8qq+VpllHvlBIMZuDijRM8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1721;7:iRsFgP8oPzzVV1Fgear3kJ+KoEiEwglUPeZT1E9M9rjga1JVLcKwqnSpXgU2lmkbI8hFs1Eev2jdKQER2VTnIYSQWEbfHPU4uJwjuu02cWSGDXKqNvL+lFn4pMiCrT5qsC4pF58p050hXSFag4x12QLUpKnL7uSSbTlrvL0GbWoqMv7nzDus9vkffiWG4EXSPm+XRba8gZcIWG1nXC3rj1xmLTVXuLcl+PKu8yH4wGCt6MITXOIWPNxaCkeSx2JZ;20:fTU29S5v+5Z7Dov+YSGFfQJ36SNNUm8PpNTCvmr+HAwHJcE/V1AWr2sZ5sgtqUT2vEtoMiitUQtZJ+MEO473Pu1ncSnCw/WkRslqqKeFkbGMlzw0LhKtg0OZvSEc4LaHjR2BAQspQjs8lPczVn3GMKgtXOru2fzmhPS4yxvBUy16+IPZpv8jg//Z8YNlZxUwyQPtmtPSwhmCa9qKyp621qDSSbneiv2DiGG1dNih7RDUze1TBlAuvLILBDaTcvkf
X-MS-Office365-Filtering-Correlation-Id: 9afbbb1e-6b26-40b6-cbb4-08d5b5b275ad
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 13:40:39.0610 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9afbbb1e-6b26-40b6-cbb4-08d5b5b275ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.05.2018 um 15:12 schrieb Stephen Bates:
> Jerome and Christian
>      
>> I think there is confusion here, Alex properly explained the scheme
>> PCIE-device do a ATS request to the IOMMU which returns a valid
>> translation for a virtual address. Device can then use that address
>> directly without going through IOMMU for translation.
> So I went through ATS in version 4.0r1 of the PCI spec. It looks like even a ATS translated TLP is still impacted by ACS though it has a separate control knob for translated address TLPs (see 7.7.7.2 of 4.0r1 of the spec). So even if your device supports ATS a P2P DMA will still be routed to the associated RP of the domain and down again unless we disable ACS DT P2P on all bridges between the two devices involved in the P2P DMA.
>
> So we still don't get fine grained control with ATS and I guess we still have security issues because a rogue or malfunctioning EP could just as easily issue TLPs with TA set vs not set.

Still need to double check the specification (had a busy morning today), 
but that sounds about correct.

The key takeaway is that when any device has ATS enabled you can't 
disable ACS without breaking it (even if you unplug and replug it).

>> Also ATS is meaningless without something like PASID as far as i know.
>      
> ATS is still somewhat valuable without PSAID in the sense you can cache IOMMU address translations at the EP. This saves hammering on the IOMMU as much in certain workloads.
>
> Interestingly Section 7.7.7.2 almost mentions that Root Ports that support ATS AND can implement P2P between root ports should advertise "ACS Direct Translated P2P (T)" capability. This ties into the discussion around P2P between route ports we had a few weeks ago...

Interesting point, give me a moment to check that. That finally makes 
all the hardware I have standing around here valuable :)

Christian.

>
> Stephen
>
