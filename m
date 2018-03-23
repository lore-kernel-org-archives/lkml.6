Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeCWSe0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 14:34:26 -0400
Received: from mail-sn1nam01on0079.outbound.protection.outlook.com ([104.47.32.79]:56048
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751806AbeCWSeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 14:34:23 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com;
Subject: Re: [RFC PATCH 0/3] mmu_notifier contextual information
To: jglisse@redhat.com, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Dimitri Sivanich <sivanich@sgi.com>
References: <20180323171748.20359-1-jglisse@redhat.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e22988c5-2d58-45bb-e2f7-c7ca7bdb9e49@amd.com>
Date: Fri, 23 Mar 2018 19:34:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323171748.20359-1-jglisse@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR0202CA0022.eurprd02.prod.outlook.com (10.168.182.32)
 To BN6PR12MB1714.namprd12.prod.outlook.com (10.175.101.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 845efc81-7a59-411d-0870-08d590ecb119
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;3:9gMUfyT8M3MkwKnZt/vhwjqunUNJeYaQFgaN18uMJvbHafWJ58EmMR3nspRmcuZ+uWwuVxEQeKeqMbnMZd5eQJWpQTkmOwBIpepVDsAs+p0sOD0sSxedI1etuRdubXSLBk0qwgiG7Hh3i+2tvovoTAm8qNS7hL0o6KX2GcYyzw1NJ53BwBjoyplybDgeTJbHi5ATJOyTRFKLWel1g+KH091O18syGZBv9xC+Pv439VxeyDJ+dspnSQ3DmkEknzg7;25:w6OOVuEk3oZ1gQVqXwXuEcqOrjwMsuJcQ/JD+HzkVP3x4lf05PMoGxmO/Qn65HgoL2h3IHRHd04wJr8xJVlk+GeDMYoIERAVlKuL5/RNZrnH8RnMwXLbC0pRrgnpQ/q3C9cYN7wKpyP2DRKH5Zn/xTjsYY3rgbOe5IFG7uC62Ja39GXFulYOsO6/nm3u8DZNZwNZQfn7mzjLmmLYLS7OMLt/IEtPWz0F/4yvniRtfYERPWkfLKfb1v+z0VNdr2CNhbjxdWCTJVMGfJoFUfgLF5wEM+5TwgvnEupdFaTMZ3F36O8XSOrhzRGx/DPPETmgzIyVzYltYbi5iXzwZpq0Rw==;31:qI+b4IYNxW3zsLSt2bTWZ9Z27EgEJ+DCHrV8e42r8irEfs4pBS/foO9/ED8MfwmqEvwdffHACsapGl5+ggjxn3TYysYJHKgo7XU6AZwFq4xgfmi80MV4KsMlseVhxCHp2aRTTKvenk2fb7xQaJztjN7lhR+z566Ny7QTqtJ7APiFXzOdP60HtHMzPI4f4ChXuOeEA7yVvA8FSNyxzIyinSSMbVGj4IPGHQrs2Qszt04=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1714:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;20:46x+ioGR2h9hPhyZ/D2SXHkVP8WvGUjmexyUic4481WWH1PodwJXUpjvC3nrdMrL7FyZe4+Veprd/rtye2GHQ6idVU74EOoMWatua2RjTKzVAP9CWovfWHrVkg2PUjOsCHb+smaYfjPumOP6YvNDo841LSKFzgPFv+WX5t5evLnjhyvIYW2hdkCPjloHXlm/xEUgtkDZ69QQcGrTGjtxYk0Az7q/RbCLKDy/1whPV2UfMFvNDa/Vo1znCKqR55FaY6CMjZ/uGd1H4xoCuE/iuwpBCtcs8KUAAt/5xnTB5iZ5p/eW1zZ0y7sScQy1mgCp+uRBTTwXMbmQ/4A7uXvg+sKjyFXKM8Uh9wDtC/HKRIR3lotPq5pr8zHs3wi/ALo2cGmcQLLkm5COoQHqXSs2ftRcL6yVPbkcA9MD6aaUWGntlgr+Bv7OQfRoLwCqU6HiVnIBPZAtihIGW4Hi0ZiY3HkAXxHE4PmJ1Ef5xsBtjMrwhOSDwnDg2RxxNgQ2HfII
X-Microsoft-Antispam-PRVS: <BN6PR12MB17147451C76BF1A790B9D79E83A80@BN6PR12MB1714.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(18589796830644)(36064498253994)(767451399110)(788757137089)(211936372134217)(153496737603132)(228905959029699);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BN6PR12MB1714;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1714;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;4:NHga0t5VROf5a4UkNzwBOLwvn/ImXmZ4YRtU6fhqODQuqR6/s6LJaw/iIhs4eb3ncIfKneU85jQcNGRXnFGRLAbVqttUHUmI5G03MWofbmGAppd+h6ILRvNUBVwTx6pXNI6H+/8stuHRo1AR+FQ6TGmUeMrgTKMqswfEsOKAO1xd22Cjkg1RFN5p2/Vvw6DYqD6F1NJe2GswycqZEHtG3bqb8hj0Qw2MjMixykaqohSV+ADYxGN/pt0PDLVFTvFofiEIQtUSzLmF2RgDr8mBi2sdY5v2RbJMsI9FuYbttVTnysu3PirP8yNPeVQ7lU9ByECTxr9tFQMYBshKJgKErff06i62PQ0Seh9tck5LRR30sBk2JTldpwpriyFw4CAXoanKS1vHy9piYH+UI9CwZBC/YzPCHw2NE4ZBcTWQRD1ZEHbelgf7k9TGPWJ6zAmLrVDjZS0fVdSi6cEUoXV4sDEjqvPxpi+NFVw1KdRThWOt9zcmdSj9+R46Fkb2aHhR
X-Forefront-PRVS: 0620CADDF3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(199004)(189003)(4326008)(16526019)(31696002)(186003)(25786009)(86362001)(316002)(65826007)(5660300001)(386003)(7416002)(65806001)(105586002)(65956001)(106356001)(47776003)(31686004)(6486002)(68736007)(478600001)(6116002)(229853002)(6666003)(81156014)(81166006)(8676002)(7736002)(305945005)(8936002)(52116002)(6306002)(50466002)(53936002)(6246003)(64126003)(97736004)(2870700001)(67846002)(1706002)(76176011)(54906003)(2906002)(23676004)(2486003)(446003)(36756003)(46003)(52396003)(52146003)(72206003)(58126008)(966005)(11346002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1714;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNzE0OzIzOlhKQStkblNiWEhmNkVUb1R0TFgrbGxtYmVW?=
 =?utf-8?B?OHdrZkZvSTBmYmx6YmZpOUpMY1FwaDVRS0czU240d25jTi9kbFkzV0UwZ3l0?=
 =?utf-8?B?QUh5SnFReXkrL0daOG04Y2NrVUlsTUkxRGhvSmRsaGJESU8wSTNqK01Ld0g2?=
 =?utf-8?B?UVVMNkM5QVc0dXhGMllrb2V1MmY0QlExa1RZak9NTEZsUVlGME1QTFRrU1dp?=
 =?utf-8?B?THdEcjVNTzVMclJLVWNwQlZ0WmM0ckR2dDJuUFV3bzJRQTlseXdXUzlVUnox?=
 =?utf-8?B?WXN4bVA2dFRlN000dWxjcjR5OE93YmxPQTFYU0VpQW5CRHFuYlBzS1FNTU9S?=
 =?utf-8?B?YkhRamFGSGw1K2lVWDhkVTFFU3BwZWtWUHozSzdPdUkzeHErYS96eHNuOEo5?=
 =?utf-8?B?c1lwNHVsaXRUcFdxb1BTSnU5SVVTdFRueDhMa2FNLzF4YllmRm9lSzNxT00w?=
 =?utf-8?B?OXV3blYvOVdpaGtCWWNxeTB6UUhaazFMTEptMUk5K05LWGdVc1R2TThMQXNF?=
 =?utf-8?B?cEYzcmV5a05VVWg4WkJpczhTVngySW0yR09nRDIxQjk2UDdOdjdjemlrdjRU?=
 =?utf-8?B?NmYzWS9kZitSblVTNHJvUXo2RGhmUDdQbCtIbXB3RlBVKzZyU0lOSW0yL3BF?=
 =?utf-8?B?SWNkbW5IR1M5MDhLQ2VlS1BidXZjOHNZRDIrSEtnaVg3YnNYZVB6eWtWV00r?=
 =?utf-8?B?K0JtU1UrSDRCQ0VXZEJOZHN1UmwreTByM0g0a2R3bDNZYmxqNmRRSkUrSnF1?=
 =?utf-8?B?YnV5MnZUSGFoZC9MOHZ1MmJSOWg0RnV3VXYxSHB0WS9jdUFuQUFiNEdpbzJ1?=
 =?utf-8?B?WklMeW9kU2JtM3h2OUxpeTFqSzRiemhRWXVmeTVUdGU2L1dKMTBMZzNIT0NS?=
 =?utf-8?B?WWY3eXZkRXJHYzh5QnZrL0xKYkoyZGlad3Ircnl2Q1ZodDFCZk11QWQ1MFdK?=
 =?utf-8?B?RVlSL2F6UFJOdG80U3djcGk5TFNGcndiWFhTdzlVejNKSE9Odkd2ZU9mMWM1?=
 =?utf-8?B?M21aRGJTb3hZZHZnSW8rSjJpWk5Kd3BoZjhqdGp4NEFvRm4zVFJOK214ZUZo?=
 =?utf-8?B?ZmI0RXE4NVBtK05BeitCWFNHSzg3WVZzYitUZXlDbEtuZ2tzZlByZE5oblc4?=
 =?utf-8?B?WUMzdGI5aWV5MEwzL2MzdWR6SHQvUnlrcElHeE5RVyt5N2pTay9NOFNrVUh1?=
 =?utf-8?B?Q1pDSEhWcTBoYWQ0djJhQzVma3NWbEc2V0piNjFCVWhmVFB4WVNNYngyelp6?=
 =?utf-8?B?VGF6M2JMTHYxYWVpc3hHdmdpaXJmaTZ5TUNZbklDblMvcGNPUS9mYUVpVi8z?=
 =?utf-8?B?QkY0Y0NPWDUyeTdYaHQ5cHRpUFN5U3R0UVArUzY0OTBPK1hXbzZaT05pcTNm?=
 =?utf-8?B?ejhIdzNCYXpWdFZTY1lFVnV1TXBJeGdVd3BabXZvdUVEdytWRFFzSWVBbzlm?=
 =?utf-8?B?Q1lmb2tqeThOemZocDBnZHJBbmp2Q1U0NkJ2enJ5c0Z0VGxTWm83TmpaRjNr?=
 =?utf-8?B?SHJ4WFowbDZJNk9yQjhNZHNhMTgzaEp1S05YR2RXc1VsM0VaNTBZWU9SaW5u?=
 =?utf-8?B?cUxnUGxoR3VyaUE4ejJ3N2svaGYrYWhxRFZXNmVnRHpGY1NQWUpHNjZtdEky?=
 =?utf-8?B?RXUwQkpyL00vWkpIV2tHbHI0dzhxRVk0Q3JqS3JoVFFuZVd4ZXVnQUpFN1Zh?=
 =?utf-8?B?ZitaL0hkczhacFJXRHR1UWlaYnNHUXVuTVk2Q0RxeXRlUldMYTk3WklEYzNR?=
 =?utf-8?B?aVMydGV6ZWEybkpGRnRCWjNraC9YbEttSlF3WXpmcnh3R1o3NUVJcjQ4YXRr?=
 =?utf-8?B?bkhHQys0S011cVBRNlpjNnJPaUw2TkFBVFR5eHFvaHpJZ1pCREdrSk1hTFVk?=
 =?utf-8?Q?VVX8vrCKMrE=3D?=
X-Microsoft-Antispam-Message-Info: PTWktPD0Wi4dKmfstBakE4ZPsKFtiMPElG/4DUxStirxh1s2Ve85qx+iULdt89VUO+xjh4qF2F22t68A5WymGSYomKyioeebfKZ3imQJCYXHFScsEgeL4gZ/2sTEDJuXhJw5SjU6bVHmWlb/k7ES5mzkw7mvxXnsBr/8f/mkRn98EW232zgLDL3w2bJ79y9n
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;6:EFLXX0TRCg3MFF/fuF1v7AVw9lbjYETSDkrCmCJQW6tBXMxRP1A+5jY2P0qOkJpd/hSRuEy/GCDxZyOyviMVn8La+TtQVvdZKw1UfmWpa8w2okstYtTsWlxJrJvtNnoVfptO6bLXQz0g3EQUQCBnjTZ2Bo6suOJtiFeVeE59ICDpstTBC4b91ITxqc7su36S7iSX4S70FY8sqbgC1FsGkbvDhgFEy/B/8kghcHB4LyyqQ0mY8GA3unr9/edq1eYC9YBbqwRQBis4+b+DVWhJo6VUXJsL5dbKvwbR4nIcNfX0ZbPgrOs/i0lHiCHEJxHSRSGxt4og8mwQS7YPDEmUeWM9GHpC71GXTJbEZach8N+VpTmdys0Lhf3+Kaw17PYvHeBkGidNeecJmZDBQu05PzBbbEM/OWIDtUxkuNbR0oOg+HpcxkDcJBrsVyfyA76blhv/RKje4T84YVmRBbMJMA==;5:66ipFq78c3IbS05FdKCnOWPZojJpK8PZLkCUnJoJU8V46W7H99fsxGpdD9/OhfPx3TYlQNhraeHoVKfp0+0jhXGAdW0EFx6IvF8XblM2v2wwJSKSemE1sMIH7rSLZ5AmWU1G2ZD2RFaYknOAeAGatex0PTb5DGJiXpewO+WgwM4=;24:L1WsONdbo5nVeIXFPBtpIsv/XKWXOWyGy/D5FsPpCZq7DPKuZj9R7DC2qXVXW+hVnbNp0ovE54hZsAgnwUYMZ8KDJ+TNuk/9IBZWHC63dDg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1714;7:TFZTj5AY0SDLIuMYf/mAt7Qu66KXNxurImZVrVfDiV7KkIW010JaM49SClb3O2u3B98AdSC/8PcjFj+d54Dbfsq84je6EPG9nmoC6HISTg5+xFwHiBpdhvHuNw9txnMGMM1naE09y5ENoZ34Ei93dLhfH4V65FynmT4YSeLeFgtKA3r4oPOHVTwUvpd0H0SkGHzodp1AkC/rql4CFesGb5fxo8+9qU21M5Qn1rrWSmW/52jqZ3a2ErAE0zH3XI5Q;20:iLqZNUyMqPAHsMKZGBHIY73IO10IjJsvrf9RTIZo0KqeMXhhSzu0gGkB+ECJv8otymfgmpyZJLEVfuo+KpyD+rx2gBl7j5MzqATJNpxo/17AOlhiogJErIwuWHmceq9o6I8aPYh6ZCaEetsj2AqLA+70B2usJP6aXBh9pv8ozY/zTRbm98ZecGnHYLw/56uSBtGEvNyoZDB13MQNkAHfxYtYwTRAXpQde9or3h5PDZxk2bTkAS8BwCVIvIympu16
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2018 18:34:15.7817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 845efc81-7a59-411d-0870-08d590ecb119
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1714
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 23.03.2018 um 18:17 schrieb jglisse@redhat.com:
> From: Jérôme Glisse <jglisse@redhat.com>
>
> This patchset are the improvements to mmu_notifier i wish to discuss
> at next LSF/MM. I am sending now to give time to people to look at
> them and think about them.
>
> git://people.freedesktop.org/~glisse/linux mmu-notifier-rfc
> https://cgit.freedesktop.org/~glisse/linux/log/?h=mmu-notifier-rfc
>
> First patch just use a struct for invalidate_range_start/end arguments
> this make the other 2 patches easier and smaller.
>
> The idea is to provide more information to mmu_notifier listener on
> the context of each invalidation. When a range is invalidated this
> can be for various reasons (munmap, protection change, OOM, ...). If
> listener can distinguish between those it can take better action.
>
> For instance if device driver allocate structure to track a range of
> virtual address prior to this patch it always have to assume that it
> has to free those on each mmu_notifieir callback (having to assume it
> is a munmap) and reallocate those latter when the device try to do
> something with that range again.
>
> OOM is also an interesting case, recently a patchset was added to
> avoid OOM on a mm if a blocking mmu_notifier listener have been
> registered [1]. This can be improve by adding a new OOM event type and
> having listener take special path on those. All mmu_notifier i know
> can easily have a special path for OOM that do not block (beside
> taking a short lived, across driver, spinlock). If mmu_notifier usage
> grows (from a point of view of more process using devices that rely on
> them) then we should also make sure OOM can do its bidding.

+1 for better handling that.

The fact that the OOM killer now avoids processes which might sleep 
during their MM destruction gave me a few sleepless night recently.

Christian.

>
>
> The last part of the patchset is to allow more concurrency between a
> range being invalidated and someone wanting to look at CPU page table
> for a different range of address. I don't have any benchmark for those
> but i expect this will be common with HMM and mirror once we can run
> real workload. It can also replace lot of custom and weird counting
> of active mmu_notifier done listener side (KVM, ODP, ...) with some-
> thing cleaner.
>
>
> I have try to leverage all this in KVM but it did not seems to give any
> significant performance improvements (KVM patches at [2]). Tested with
> the host kernel using this patchset and KVM patches, and running thing
> like kernel compilation in the guest. Maybe it is not the kind of work-
> load that can benefit from this.
>
>
> [1] http://lkml.iu.edu/hypermail/linux/kernel/1712.1/02108.html
> [2] https://cgit.freedesktop.org/~glisse/linux/log/?h=mmu-notifier-rfc-kvm
>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Leon Romanovsky <leonro@mellanox.com>
> Cc: Artemy Kovalyov <artemyko@mellanox.com>
> Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> Cc: Ralph Campbell <rcampbell@nvidia.com>
> Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Mike Marciniszyn <mike.marciniszyn@intel.com>
> Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sudeep Dutt <sudeep.dutt@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: Dimitri Sivanich <sivanich@sgi.com>
>
> Jérôme Glisse (3):
>    mm/mmu_notifier: use struct for invalidate_range_start/end parameters
>    mm/mmu_notifier: provide context information about range invalidation
>    mm/mmu_notifier: keep track of ranges being invalidated
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c  |  17 ++---
>   drivers/gpu/drm/i915/i915_gem_userptr.c |  13 ++--
>   drivers/gpu/drm/radeon/radeon_mn.c      |  11 +--
>   drivers/infiniband/core/umem_odp.c      |  16 ++--
>   drivers/infiniband/hw/hfi1/mmu_rb.c     |  12 ++-
>   drivers/misc/mic/scif/scif_dma.c        |  10 +--
>   drivers/misc/sgi-gru/grutlbpurge.c      |  13 ++--
>   drivers/xen/gntdev.c                    |   7 +-
>   fs/dax.c                                |   8 +-
>   fs/proc/task_mmu.c                      |   8 +-
>   include/linux/mm.h                      |   3 +-
>   include/linux/mmu_notifier.h            | 129 ++++++++++++++++++++++++++------
>   kernel/events/uprobes.c                 |  11 +--
>   mm/hmm.c                                |  15 ++--
>   mm/huge_memory.c                        |  69 +++++++++--------
>   mm/hugetlb.c                            |  47 ++++++------
>   mm/khugepaged.c                         |  12 +--
>   mm/ksm.c                                |  24 +++---
>   mm/madvise.c                            |  21 +++---
>   mm/memory.c                             |  97 +++++++++++++-----------
>   mm/migrate.c                            |  47 ++++++------
>   mm/mmu_notifier.c                       |  44 +++++++++--
>   mm/mprotect.c                           |  14 ++--
>   mm/mremap.c                             |  12 +--
>   mm/oom_kill.c                           |  19 +++--
>   mm/rmap.c                               |  22 ++++--
>   virt/kvm/kvm_main.c                     |  12 +--
>   27 files changed, 420 insertions(+), 293 deletions(-)
>
