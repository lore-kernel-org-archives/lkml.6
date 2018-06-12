Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_MED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EB4AEC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D01920891
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 18:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AVwJ7XMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D01920891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933249AbeFLSjN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 14:39:13 -0400
Received: from mail-bl2nam02on0087.outbound.protection.outlook.com ([104.47.38.87]:54816
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754087AbeFLSjL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 14:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52cUGabUn0KMcQRFF1TOtmUWfEPT4dOSw7l/5JCZ6q4=;
 b=AVwJ7XMqsWDCMn7ewXwZHqAMmLNaUd79GZ+zbcrS4FSM3rcqTL5tLxUk6p/jnbmrTesKdB6G0JBazEP5sR5QKWVQ8z1KEhkWFwZCT818BqeSMIm1FiXblwtST7s5/CWeGofvUJDATYhETLX3/eAXphPIqSBNT05xdhRrZntBI3w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 BN6PR12MB1443.namprd12.prod.outlook.com (2603:10b6:405:10::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.15; Tue, 12 Jun 2018 18:39:07 +0000
Subject: Re: [PATCH v8 1/2] iommu - Enable debugfs exposure of IOMMU driver
 internals
To:     Greg KH <greg@kroah.com>
Cc:     iommu@lists.linux-foundation.org, joro@8bytes.org,
        linux-kernel@vger.kernel.org
References: <152761784341.2654.8609366076331539902.stgit@sosgrh1.amd.com>
 <152761819480.2654.5371070582955429468.stgit@sosgrh1.amd.com>
 <20180529184101.GB10618@kroah.com>
 <3249cc11-09d8-2078-28a6-efd3078ca0e9@amd.com>
 <20180605170824.GA11965@kroah.com>
From:   Gary R Hook <gary.hook@amd.com>
Message-ID: <bfee19e5-7953-7bda-2c46-9dbb4d002512@amd.com>
Date:   Tue, 12 Jun 2018 13:39:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180605170824.GA11965@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0401CA0019.namprd04.prod.outlook.com
 (2603:10b6:803:21::29) To BN6PR12MB1443.namprd12.prod.outlook.com
 (2603:10b6:405:10::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1443;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;3:GiMs8vCyQgvt1mpqNa6ARXrblx3AMDuqVjqhJEO/tm5PJSNaNOtvXHIrUJaxAUbuRrDD31G4i4TQGdlX4OlqPNInu+FaqcSbIyLxSYf2TONEcHdvIjyGIAsLGA+JT23gWCwbwd94A88J4HO+eSahBQxT/o3mYTnKUtj7beZy1VpnSeIgg/tK8bL7SztyDiA5DZaKoUuF1kBgT4OztafXzBAQfRuBEBVUZuL2qEBsugL0F4G8Xllvh/8Wxtib9zlE;25:lpdtt6tKUOPP2Bk0lQoifi7wjah2v6ep0PJFbAV+tDwi8dKl0mwjU+4s/L2PQpUePdU76GEu5MVGZkq1ptTwo62zK3OjCvbYxsnIMhjOjZVzbhuuSZ4pbdGIH330Bu3a+0qhQFMjOgMhw74a8kUGy7tUVEHjk+rHPAM1v0MWPMULyTWXlkgKP9K8XXHfjLBi9mci28YcV3uS1bVgf/gp4MNN+eo4cMePGSPERYNbfrN5DAln2lQkqJVj6Oo5uDQGtM4+R8P67ExfXM/Tdx3iYpBbtHcpi0N4HBAV3nVMeNHnDnZiEdvKxm7emS6aqo3hIVNVaOnIVWPQAtLMkIG7ow==;31:ODdCO4XVXIcf3vdXhvUigA0b5/MlamNdLxWDAaXhaUYHugS30SHug7MbPQE5JpjCc38a6P5j4SM4RysNOvQDQ0mYKGn9ukAFUzrMRsMi55ZXaDpLXfx63cHkhxCypRsYXN9fOlVeYA0CfEEnaP5D59zAvgl0nGl3Tosblcl3r8EIid0TNG3FZSxk5aLEcMvPf/f3jF7UJuvkbYHjb7BpFvsH+NMtnaGjeGh0ACkoXDI=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1443:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;20:8aUkOAjRXo0B5qYe+Mgo/FefZX3i0pI/XYIm9Au7pcMH9vLPIGQssWQmvhcHgSGDTQDO1CvcxWRQRH9MM/5LgrebPaBgNPuf7TQ5FXyw8DwAcuq/hlYRtfdnBzq5KV92TYtGx4o5h70R+lXux9abco3iRkc+XtbbtIq20o4A2NMaZvRYH1y6/dxbO184Gve4EBAjkucU8ro9PClTEmFKkdzy4ECOhF1uIcHt10+JEy3xS16+mjTBMVR+2E3fOEvhhOqk9vCR1v2oD7duQ772+JQc5nRBIOEsPCB1oq0orNF8uQABzFK173/Td++tzo6XZCgvCl4sYr6B72Llop4DFLonhusjkJpLvYzCnSKeIEZtW2iV+Vl5LgYFcnkpIm+nAW6YGv+9tH5q1WxRvRpDCM+dLhb9k+aD/akTspZK9H7N9Or80WgKy6s5zRleQ6HZ5FGe0ZC+exB33ryAPjSHxiXg3tFUVjgakzW4XZGZBKM22f7ncFlnRpZNuDHCj5Wt;4:gUo5Rfs7Q5k7TZyfZrQS0ry6tqNFEwjg5V0SuWtO5DDFBP82CILw+JzxD1tBLAXTdKS+ymiV6I5O2U9nZzUlM/u1BHkbWQK6a2DOuh2eJMkXjpFTJkC9oVQaWdGanTWNsj0O1JT3HNgcZKnW4v/S1K7XBUNBLRJHlXH/ufCyFAkMkl8z9bh0cymfVVLX3eXgBVG5GTi6I4fXfnAV1Y5Iti8VIdcJsbNTKq+saXgdQwwBiiToJoyRGTzR18adFoqusMOEBdknM6RgoI6DT2Ld+w==
X-Microsoft-Antispam-PRVS: <BN6PR12MB144388CEF70A45C89C9E17B2FD7F0@BN6PR12MB1443.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BN6PR12MB1443;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1443;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(346002)(39380400002)(366004)(396003)(376002)(199004)(189003)(64126003)(386003)(53546011)(81166006)(8936002)(106356001)(59450400001)(67846002)(50466002)(230700001)(52116002)(76176011)(3846002)(6116002)(6246003)(446003)(6486002)(23676004)(52146003)(316002)(2486003)(16576012)(105586002)(476003)(2616005)(11346002)(956004)(486006)(53936002)(31686004)(25786009)(47776003)(68736007)(36756003)(58126008)(229853002)(8676002)(4326008)(93886005)(6916009)(65956001)(65806001)(66066001)(72206003)(478600001)(77096007)(97736004)(26005)(5660300001)(86362001)(7736002)(2906002)(16526019)(6666003)(65826007)(81156014)(186003)(305945005)(31696002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1443;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxNDQzOzIzOllhNGJmMzBHc3Byd2FTdzlVblUrZTlJQzdP?=
 =?utf-8?B?SnBqTStrREZaWjA2SWdTVUZ3MzZpekdWeWRLZm4xaWFTY3Z1MWQ0SGpacUYv?=
 =?utf-8?B?Rlo3REkxWmlENFZ4eUJqZVF6YTZNSGtGL1BQVDk4R1JwVVgyQTY1SHoweUxL?=
 =?utf-8?B?ZW8xVnllZTNMNE1iVW40MlppUmsrYk1aekJSNmkvTW1kdENPV0dZdS9FWE52?=
 =?utf-8?B?SVFkbjQ3bnJsUHNHN0lhOCt2Mk1sSmNTK0FlaC81V1F5dDJjZ1VBZDIrekN4?=
 =?utf-8?B?VlpVS3F1a3lBclZhSnJheUxzZmVQOHpMMjN4S0ZYVk1Hb2FxR1JGRUNxalpB?=
 =?utf-8?B?WWN3N2FLTWxydDhiMFZIK1VTMXViQ2U5V2lHRFF5MVYxaFVlaGplOFk1L3J2?=
 =?utf-8?B?alYvTlNvMVhIVDA3TFhaWlREbi9vT0grdTd5aVJ5UTR5eUhNNHpGeXlpeHlw?=
 =?utf-8?B?YW5DMnNQQlZ3ekJzQ2ZPZlNza2NVa3g4c1N6Qytya1JRTHFDS05OV2tsaGx0?=
 =?utf-8?B?cW13Qy84RkFKNFlIcjB1UkNxcndQNzZLNHNuZG5uMTgralhsek9SVzVmOVkw?=
 =?utf-8?B?clhwaXhZbXZIUUtGbURIY081TU9tQUNFaFRLRThrd3VNOGN1YytVYTYvTVJE?=
 =?utf-8?B?cjZleTYvelJBZkh4ZS9FZXpTMW43Q3dsWU1mTWVCakNrSytwUUV3UWtEMUJq?=
 =?utf-8?B?V0pjMkFyR3ExYjlRcUo0YTFoVSsvY3BRWkdmQjJEMld2SHI2Mi9QeGdiN3Z3?=
 =?utf-8?B?aU1wTEp1MDBmWkJvYytScldzRWtUTzVhaCtUT0dKbjZKeVNYRUd3bFZ6bTJr?=
 =?utf-8?B?Vk0vZElCY0d2SXVqSklPRmt1MDZRQ1dUZjdKOTFNMWM5MlVpUnJXMC9ISEFI?=
 =?utf-8?B?WmhISkxpbFNMRWRaT05LUnpTMWZxemtSSFBYdGNnbk9tcUtkZnZHUlZSWDNT?=
 =?utf-8?B?RmFBa2FjODlvYmRBYjBCbVExVDltdS9wK2JWekNUVXVyMmpHVjhkYnRDaHZN?=
 =?utf-8?B?dEIzbG1HOEVFUjhSRWdweUVveG00bHpaVU15SHNxTUxSVEVpcjRlSkp2c0R3?=
 =?utf-8?B?MHYzY1hvVFhLU0NpODc1N0tGZVBlL3k4ZzJxU09VbENCT2Z2WFBZWXFoQlpN?=
 =?utf-8?B?T1J4Mk9PL2VlZ2xHR25GMURzVzJONnh2RldqMnRhemprSkdPN1M2eFFBT3Q2?=
 =?utf-8?B?UU04REpZUzZFUlJ3c0c2eXFwU1RZZmdzVHhURzZxS3NlRWI0aG9RMVpxQmVJ?=
 =?utf-8?B?cmhxMVJLN3BKTHp3NGRKZ2M3YjBhdVhML3labUY2S0hsMHlKZU9kK0hLcllK?=
 =?utf-8?B?K2dYczZySDRMalVFZGFIb09YczlOOHN1S0J1WWNEQXUvdk43OXJEbWVGOGMx?=
 =?utf-8?B?NFV4c2VoR2VJZFJCSDNQaWFRY083eURJTEFkLzVoQ2FLbzEvNHJERzdVUmJq?=
 =?utf-8?B?Y1RWSTRQSGc3ZlppakpxQUhhZ3NuVVB3VWFtRExORlNGeEN6WGlHVjlPZmg3?=
 =?utf-8?B?T3R4THA5Qng5RzJXTDZCTVhyc0cwQ3hNekJTOEFpZkdnY01OYWVlSmYzRWh0?=
 =?utf-8?B?Y0liWWJvM20zNi9BZ01tdmRsQldxNnBaZGFJQk1ONXZNMzdTOW9ZRlpXN3Jp?=
 =?utf-8?B?UXdETEdsOHBESW93aC9Sb0tHT2VrMnZ4aFFwYmFYeHh0OEppRmFqN3ZEWlE1?=
 =?utf-8?B?T08ycEY0bDZ3TTA3a3hRQlAvQitXODkyRWFqN3F4QnVkSkt5WTVDRFNPRXdz?=
 =?utf-8?B?ZCtLZjJVQWpQODhyb2tWTFU1UlFYS2dkbmVmb3VoRGQwRUYyV2NBclg1NzYr?=
 =?utf-8?B?bHVNSUM5RnBOenlTNXdJN1VGb3U1MGxDVDRna0cwMGZQZHJDQkZSRVV2TnZZ?=
 =?utf-8?B?aTAvTTBqZ1I5eVFaeWtkN3duOGZHeU0vblRWNTVsa3JlRms0KytIZGlSTDZX?=
 =?utf-8?B?V1FqZ21KNjJUR2hzK0cwK0sxRzNsQTlVZ3VPaTdQV1hFQ2pISlArUlN6YkZt?=
 =?utf-8?B?d3RrR3JOMjVLU1hVN2ZBSEtEVjE4MFRENzdVcERtb0tYaS9IS3hzSnJ6bWRu?=
 =?utf-8?Q?Uiqk=3D?=
X-Microsoft-Antispam-Message-Info: ZsZJsdtaIUQMbDXg0LjdFsBysfshjTCjS+bNfYVJTnXny4pFHyDU2V9o0l0s5eK3W/yt59H8m+cawLvXL8jYb6uVsjylDDdrYt1C1Yki7lJT/BljZMVSUrhYZ4lephLDn5ppYDfcFQO31FpPYL02Zkn4JAgZvxJeEX7I8sylac/3EcjzEq6E/tdldnvsN09/
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;6:VVlgjUCvxWsqV7kq77btjxoUmhIjfqr4/2FBynYYx9ZHfBu8gxg27BzXoEHn9m5HLt4d4zoc+L0mIGukTD7EJXKv/P2KNMirmCFIeyMXaabOrsDGesb2YQy1xhdAf2i7jEeWncsmfqBWHH+pUFsMX0cr0Ycplyq/zFNHw+dKJE+tcnlbPmKNTvo9GKsY62AClpIP3ts01nm7sAqvH3Ukowh8Vljd3SBpeJG4qI0+Ys2zBsZN52t3Q2ARYfwGyMc0poIFL/ZIhJGUuGYwfWFqXvNEADmWfc5hew/9EBjbD6I2JrSEsnegGEkeCggsi+9hzwdmKtAsWH+FFm05uNfUVkwaHSwl8G97ATE4/Ei2PTYKD0XM581gj/+tn9u+6bwgw/ctzF2fOiyT7cLoSSprcultwLx3wDy33iF2r+8qOxkX348FAN3oXo2akWU/CGlrkAdnCE7C4ykOjesk5SsUow==;5:LuAHSyQFiJxe7JKQpjiQ5WbQs7YPuIxmRVmbDMoo0NbzZ5ikq3Hznq4Nh2dqhcZntBezf+HhNFUstmGLbqk9TVLSQ9kZizqh/dDdqdRATbmCzdj3h/CV3OY1dx1oLUiJ8mXskva+E9k4A1bzivS/dy84mnc9Xzxu5FocF4if15c=;24:mZgzk0xIbb5tBd5UC9t7zQ3q4rLGb0Ia/tfMluESgRchR851l+uhWGIPCKOIWqDbFA0cfrtSYfu021IodJ8N8admpt08yT7V+/9meP1TLB0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1443;7:xW9+v7mnDuDFSaUw5mCjVNoDAILpPeWp4HX2X4MLg2lsQY9BQHSdk+gH3nQeldkQlM3Jm7hegkzxEqKeZeO1B741HmiMO01k8H4M//LppOCKJ2fITJPvm2sKmlUdQt2VjscnlyxqFVJCLdjSMWh1OWf7T5GxF8aT4uuLgRhkp+Z8Nk9CoQdWsteNuGg8ZjNvd2q2oqXTryKJuGN5kva+bPeMto+Bh26xJLPJVjgsSTYWoxj83NgGR6Cbyrw1H1Ar;20:r7xmZeKscF3TTPEP0TnakU6dQQ+hKzYTNeoD7I7CTtpt3kiZwPXIil6pDgzAobFdfacabhfJqHmpeMOzoT9GvKDlFF6Ayb/4QL0+Pnf0T4qAFN0i4h24J/or8Eilxxdn9QoOYMaH4zqhRpoLw6EOYrV7bmLPj9SQ1fO2MoZI8tuHvFhbnLKABPrN9/xNqt5PoWUyS3Sup+oVuaAC0EpEB3qaz5WqY3djS8vZ8Ns07tpCGbNlXZGwaSH5KsipIUDy
X-MS-Office365-Filtering-Correlation-Id: 22189586-32d6-4c52-3eee-08d5d093c84e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 18:39:07.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22189586-32d6-4c52-3eee-08d5d093c84e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1443
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 12:08 PM, Greg KH wrote:
> On Tue, Jun 05, 2018 at 12:01:41PM -0500, Gary R Hook wrote:
>>>> +/**
>>>> + * iommu_debugfs_new_driver_dir - create a vendor directory under debugfs/iommu
>>>> + * @vendor: name of the vendor-specific subdirectory to create
>>>> + *
>>>> + * This function is called by an IOMMU driver to create the top-level debugfs
>>>> + * directory for that driver.
>>>> + *
>>>> + * Return: upon success, a pointer to the dentry for the new directory.
>>>> + *         NULL in case of failure.
>>>> + */
>>>> +struct dentry *iommu_debugfs_new_driver_dir(const char *vendor)
>>>> +{
>>>> +	struct dentry *d_new;
>>>> +
>>>> +	d_new = debugfs_create_dir(vendor, iommu_debugfs_dir);
>>>> +
>>>> +	return d_new;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(iommu_debugfs_new_driver_dir);
>>>
>>> Why are you wrapping a debugfs call?  Why not just export
>>> iommu_debugfs_dir instead?
>>
>> It was a choice, as I stated in my other post. It is not a requirement.
>> If you resolutely reject this approach, that's fine. I'll change it, no
>> worries.
> 
> Either is fine, but if it stays, it should stay a single line function
> :)
> 
> thanks,
> 
> greg k-h
> 

Then I shall leave it as a black-box function. Single line, of course.

Thank you.
