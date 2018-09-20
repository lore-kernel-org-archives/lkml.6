Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38442ECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA2C2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 10:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="bHU1L9fl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA2C2152F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732386AbeITQVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 12:21:52 -0400
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:12640
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730654AbeITQVv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 12:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lYOKzyXD77dlDE6lVATJFMEa6CZA3pUZ/qlYO7pQ4k=;
 b=bHU1L9flFcmICUvD/TMeeA+h6n6RWLuVWDMYuoLD0YvKNa9HEaclw62PGBj9q6MBJdcKFJGAvI38H8ffF5nj4Q0SJj+hA8RKPwflCxkRBhalmDPJtco38MnNnybpvdijosCaF8BPlY3AMIrXXwuKwm5Juy+jX3+WMfy2zJJYO0M=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suzuki.Poulose@arm.com; 
Received: from [10.4.13.23] (217.140.106.49) by
 VI1PR08MB3103.eurprd08.prod.outlook.com (2603:10a6:803:46::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Thu, 20 Sep 2018 10:38:54 +0000
Subject: Re: [PATCH v5 07/18] kvm: arm64: Configure VTCR_EL2 per VM
To:     Auger Eric <eric.auger@redhat.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        marc.zyngier@arm.com, cdall@kernel.org, pbonzini@redhat.com,
        rkrcmar@redhat.com, will.deacon@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, dave.martin@arm.com, julien.grall@arm.com,
        linux-kernel@vger.kernel.org
References: <20180917104144.19188-1-suzuki.poulose@arm.com>
 <20180917104144.19188-8-suzuki.poulose@arm.com>
 <3c4d3139-1b8b-12fd-bd41-10a21b86e7b5@redhat.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b9d1aa2d-4c9d-5da4-d627-aad7a8e110ee@arm.com>
Date:   Thu, 20 Sep 2018 11:38:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3c4d3139-1b8b-12fd-bd41-10a21b86e7b5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: DB6PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:6:1::38)
 To VI1PR08MB3103.eurprd08.prod.outlook.com (2603:10a6:803:46::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6994fbaf-173f-4905-b7d2-08d61ee543d5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:VI1PR08MB3103;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3103;3:YDMZgx0qVLTaovvCoDx16DJFPMauQomBXNVezWPw9OXXGFl9jNGuwPVy5Y7XiZFce7trFUtzToe0+UvkoVBb8tsxhjmiqzBF1A3dxI4ifD057kg5DYiAYPN3znNDii34T3BZ7FbmkXUD1KYEtIeSa4hgx4xL1WTxcXwLCobeUXErBizpmWS1mTeLl+jAnOMV0yJgYh6w5XBu4nMvDIoRFaZ9Aak/jEWqQ1B/6nVsNRkzwTXI4ZxDhhtbQ0otONPo;25:rd8q5WoSFsEVamQNBGrIiu4nbswLNPviPBx9nqk1VPMBoIZ5ws/tP55okT7oCtfSTVOyygWX/qH+bxVAcHbTD7ob8siXE38MSvZvr+uGlazrOIrSVT+tpQQ3Ft2sG7LOPujwavyl9SJ3zu3/p+js5UWH225NXjq4pxncVEYkKTz24rbQIA5kCjiGeLwjNyiu/l2T1bESC3BTzqheB/qN7NvZtiaJmfBS/rhbGxKT3E9TPkitGUdGdYlF/cP6KlWx0O22g92riZZ2XehjX4p4E19/3Az1UBVcaF3Tc3h9fDlcavnAn9EcXhSXDQ3vDrFxKe2AOcspQH0sKoV/dnhk/Q==;31:txlnlxuRgU7g0XS8tgiakcPat5wZD/24sogBEFpMpgauLFDlz0XaDzRr0DzI/kIwBtsSKOqPbmtLUifdS2fQy8W060YUjqcznhY91QRQzA6k7Lasy7rxpl6TQPqRgLL/j8N2APSOT/Dy821G5c8Xyr1kyeaGa3cFP9DtWWzG2qsraKVSvWKY4JYpTRdeRPFTqyw0F9qx+6+ZHTwVrY9/LoyIOMiOriJxM11PtwHxnHg=
X-MS-TrafficTypeDiagnostic: VI1PR08MB3103:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3103;20:XaOpkhOiPR6hovlM9H1PZ0h/LgOJaOAZP4AMfmF/DXzcIcsiy23ZP+RwghkPWgLlLROv8Itn33doz1VGPVlqgeC5DL2dfOUuNoXwl/cJBc6+lb1I5Uo2bBIlhnkE920jp8dfexEWZNShhf/LWcsWy+I9FJv1YjH7Vo4O+tuYzURGAFEYqNF5wmNQsTC92ByU0yVXS+ndyicVBznxHfdhEpxn6EYUk/cgTtansNRaTvE4O7rbkhpGJHJ2M97c/+DXVNE7/aQS7OkGG2dUmN3x4ndQC8GmtEG2cwWCJEOMhBM9Nt+TjClO4IcQRXAlAj6/ohyn34wRzi67Iina/EgX4hN6xCgy73bwyH/nmvKiQA0ZHJVoEkUjeAZa6gd6BSEj+joVHeHJ4lgzTNKemZQ41iPHL4YFHaxowtcf1720R7Q09lgXEXP88lRFJ0yxDg0JwqFTKrYbEcdCGZWs5XRdEepXqcK444Tva7yUMC8md3x9ttX06X7xVyFchzvFFNO3;4:bhWsoHCfpeQz/KvnGaXSUFSoe1OHZJpF7KBWzv4iGaHfCnWH7RdSOJgOyI44YB9IUsmfiPQYsQHYyb9aReFz/ZRyR1Ro4LHaNZkBfukijC0wQpjsvex8aDlrt0NoxV/KAVaz5cEKBb++1l9AJImFh7Ycr6aV1NucELoOxbOZ8+Xe7P0E91kRgJW+pabTF+qWcEr4ljp252+J8+YQOLBDMxaCnrXNtc4XqcPrSMZbpYyBbVbaf06upcoNI7vfsl7WduNEzrSYFoqE1myGAUBNL1iPtRWInuYQAUey67vQqjz8vUgHBqPS2ywn3jMG2l7p
X-Microsoft-Antispam-PRVS: <VI1PR08MB3103658F3EC1C6F4B480E84591130@VI1PR08MB3103.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699051);SRVR:VI1PR08MB3103;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB3103;
X-Forefront-PRVS: 0801F2E62B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(366004)(376002)(136003)(396003)(39860400002)(40434004)(189003)(199004)(186003)(53936002)(52146003)(31686004)(72206003)(5660300001)(446003)(11346002)(66066001)(97736004)(47776003)(486006)(65956001)(6246003)(476003)(956004)(2616005)(2906002)(8936002)(14444005)(8746002)(65806001)(478600001)(6666003)(68736007)(81166006)(25786009)(81156014)(5024004)(53546011)(8676002)(386003)(6116002)(65826007)(86362001)(105586002)(4326008)(64126003)(58126008)(7736002)(6486002)(229853002)(2486003)(316002)(16576012)(76176011)(3846002)(50466002)(23676004)(31696002)(52116002)(77096007)(575784001)(26005)(16526019)(67846002)(305945005)(36756003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3103;H:[10.4.13.23];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIzMTAzOzIzOlJERUg0WVRUTFpOZlIvanFYV3JRQ3FVbVQ4?=
 =?utf-8?B?bmJzMWx2QXNDNHlieGpwTEJ2K0swdzdGL0FOaTE4MXowYVdLVEZUTEJKT05q?=
 =?utf-8?B?ZXVjU2lkajBBRitsR1ZUaXF6UE4xVTJFQUZEOURxam16ajNBKzdGeENNeU83?=
 =?utf-8?B?VmhFVHFONVdLVWtIeDVhdndPS1BjU2dMMU9HM2JVbVRrMXZpTS9tSGRvNnl5?=
 =?utf-8?B?dUdhaFJ2TnFUM2pTaU5udEw2TmlNTzIxTWh4d1B6cElPakRSZGNYTncxUkov?=
 =?utf-8?B?aVNwbHpPUWdobWhDM0I3ckJRdm13Y2hFM0YzdWpmcGsyM2w3NzdCcU45WXFT?=
 =?utf-8?B?UFBveTU3a2pkd2dpak5iM1BGOG9NYUhwcm1LWk1XNVRIeWVFSTBJU3BmZ3JG?=
 =?utf-8?B?UXh0TVRFYlhHRUVlYjZDZmZnY2l4TlpiQmx4RHN1ZkQzVUJIcDZaMzJyc245?=
 =?utf-8?B?RUJsZkhrSVJXaHlRREtxdEpiWHJBeGwxdnNyZlIvQWtBcWtUdHh5c2dKbnhN?=
 =?utf-8?B?emE2QTVrd25Fdk8rZVR0OWxVKy9MdlR0UWoxUW1VRkExdis3N2hxWTFzZ0ph?=
 =?utf-8?B?NXBPdnFhWlFZWjcxZzROOUt0cFdJNGhQK0tjMHRnUG9tUkVENUFlbzFmSHVI?=
 =?utf-8?B?M04zWkNycUhQSmQ4ckQ1bjBDSHdUcG0yWDM4WFYyU09MVzd1SUZJeGpMUVdF?=
 =?utf-8?B?VFNJa0V3bTFYL1N2c1ltVTJlNlFyeWNITTBoR2RjQ0VPSkFHVXZKV2ZZWE4y?=
 =?utf-8?B?bldUdzVNSnRaTzROaGVkZjJRZWo0SFZUamRkTUdSZ1VxSG00c0tENGNHWmp0?=
 =?utf-8?B?ZlhVK05SYVFCN09BUW5DYkh6c0lMelUxWFBoa1JnOEJkUytXd3QvREFxRkd4?=
 =?utf-8?B?QzM4ZHFKbEp1UTNaeVJCUGZKY3d1UDlJR3ZUNTViOFdRK1MyN2FobnZSRmdu?=
 =?utf-8?B?TjluRm1Yckc5U2lEL2JDb3dQY1VtYlhxVC9ZbTNxOGNmUi9mcFlrN3hHa0Jk?=
 =?utf-8?B?ckRGM3hkbVhmdkRXT1VzN3BRVVpOVm54cWFwSkhPR2ZGbW5EZ1Fzb1M1SndT?=
 =?utf-8?B?eTI1Ynl0NGFnZGN2QVZ5Vjl1R2hGSU9GeEV6eGQyRFJPa0xLSEJxYk9EVnZw?=
 =?utf-8?B?cW1IR1ZNWTNHS2hCb1RXeWxrcFdKOXhIaTg2STBEL0dRNFRET3lGNWdrYXBr?=
 =?utf-8?B?dU0yQmQ4Wld5cHlGcmx5OHpjZWFzVXpxaDZqcTNBTzNKWnU3SkVtTVprL0dn?=
 =?utf-8?B?NXpUdmtPRHZYNGVkYzEvenBBWlpXZVZtOEMrRE9qVUZtOUl6TjVrQnl3Mm1k?=
 =?utf-8?B?empBbDc4dUQwQkxVM1BVUGdITHJRNG1nY2pOSEdSb2pJMXN6bmxuQ3N5cFd2?=
 =?utf-8?B?TGF1b1FLK0Z1cFBKazlMZmpnMXZKMHc4d3lGVVdpYmUyQlZTbXNDS3Z6dmR6?=
 =?utf-8?B?anhQUkVUMm9RVG85aGJYWkNETUpNektPRjhjM0oySzBBTDB0cWYvREZsTkNH?=
 =?utf-8?B?Vk5hSjhiKzJNd3ZBYVRRK2ZqUGVRUzZXbGl4c0Y5VGl0bkpMaGRzOW5sSGw4?=
 =?utf-8?B?ODB1MnEwL3NlN3hBTWxUenlpQ3Y0ZUVHYklLRjEyQm1BZDRCQzRnUnBaYXpH?=
 =?utf-8?B?KzVtMU5sbmIvTmwyWDBRK053WGR3dzByT1BpUEV2NnQ4K0w3NGJUeGcyRUJE?=
 =?utf-8?B?ZzVWOFdyZW9KNXE3T2NHbk1aSTJyMlk3R0J6T3djYStReXFXMHFhYXdrNzFG?=
 =?utf-8?B?WFMzam1LcTNHWS81bHdCK25XVUNQS0RNU1FlMDduNFZYZEpUSW13M3NVQ3FL?=
 =?utf-8?B?Qldlb2lwdnpaZ090NVZtYWVYQ2RuNVQrQUdkUnAwZHpJVHZVbUY0NXpLNHRl?=
 =?utf-8?B?L3llY1JjRTF0NVUrRXFkU05yNjJYMmRMTmUrd1NyNUNkNHZ0L1M2T0w0MHd6?=
 =?utf-8?B?bTV1aTNCMlBjSFNpdHVGT0o0R2tIWmw2dzMxOE9CUjhhaDdwOVFtNFQvWDRz?=
 =?utf-8?B?dUZjZ3dWK2l6M0hvUlFGZWlIUUhSdnkxZFVnTWpGOVV0cGNQSGdhRTUyRGNQ?=
 =?utf-8?Q?kvyk=3D?=
X-Microsoft-Antispam-Message-Info: 5o10seljtC0H+ks/0ZNFNZTsD5G4WcpEeY6c6ZyfFE7GK2B2VpfaaWqXBXKYDDJftzLZDGHP5u3GrK9yOyR9hwR7zBtDPM0sF5eSa8szG4eigNL3kszffamDQivxgsrj8B6AC7jfpBej6mNAu2fG/Qzqjxfv28rUmMbXxIk42zma8JHMymGrgOmz5/A3jUTqjGsUEPWxqr0+K/kT+67N4RCNL4mJj9HB0hrRy7dE3egZJCPevcW00UV1qUWfh9vQjUUaTzW9i9GymjV3/3fo+dreqJ9CkQYbH4lBRJdOZ3OzrQkGwjULnSMX6VTqmDRPmYtxG/e3yz981lMcnQLklqGA/n4c2dRxH5LGNLYM80M=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB3103;6:fNgsEDm6kVk+LJJxfR6mg+je4DOl1RXCSORCSmhdXIp12Kot7ofMZSXOC3B3JHuEWQoAtzdjsuPlASk4kB/oSlWxAYIpfQEUiGfYb8NPDfjULRGPqNJdfJZHoGdBkGiV2slyJynOmzxKP17DLMIuXiALg0tYYT6HnoIs49xoecYgLVSj0b3uFaifcptt/M+5v2XWWoqnQBUKoSs7T2NlWkee8tF2n60xSFl3XG33osSYJXlo9y7JfEiIbnxpVaPgkGdqwMXnfu843w7/bb3oKFmyXR7MlJ9i8/Jm7ePFW9PDOaHgKM+aoumO6FbtMSHrLd/ROArtx4+kDZAPiRG1JASQruDs/mJPATOheYhul0edMJU6ZR4vGHG5EgbHRybjeMkp8GbERFZivbD9Iwjd8jIQGLlx+2bs+P2FTUAXosuKbiy9IIFenJbe7tE5kJ18X0G/1pFXdPUOzvsfCn11kw==;5:FGffejqekH81OTV+GFPRrp0l/SvQhEDECktsa/Qo2WFK7RtajxvLdkhhBkHKQDXTjHDH/tOhMclWmmujsrmhw/BDqkHcHerYreFpwFbq/MbH6u+7VY2/JZxVRGJeXYIws8Wjzu6otUrIzVxATgmY44cHtyNMlLehxkBd8I98mU0=;7:caz+mcDma4Z48ppCI1e4MPJcARb6DoGFJGHWilryw/8FEocOg7oHWXLIgvS1W5hyqC0YIpq0Wdzx9WR/zzbgs5fnrhx+Jeet6JRGez6EE+qKIbDUaYnXrqdSBKkfY4foJvtW46hu8LchHQhH5ND7TtBJriLjDT5arRZxe5xvrAeW1lU4PSU1paGYrUc2l6zg95+Ut+rg+PZdgVqwN9TNB6LxeD8sqeTwJq6MFW0w/LflrqeSDayTAgq+gkoKyujO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2018 10:38:54.0708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6994fbaf-173f-4905-b7d2-08d61ee543d5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3103
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 20/09/18 11:21, Auger Eric wrote:
> Hi Suzuki,
>
> On 9/17/18 12:41 PM, Suzuki K Poulose wrote:
>> Add support for setting the VTCR_EL2 per VM, rather than hard
>> coding a value at boot time per CPU. This would allow us to tune
>> the stage2 page table parameters per VM in the later changes.
>>
>> We compute the VTCR fields based on the system wide sanitised
>> feature registers, except for the hardware management of Access
>> Flags (VTCR_EL2.HA). It is fine to run a system with a mix of
>> CPUs that may or may not update the page table Access Flags.
>> Since the bit is RES0 on CPUs that don't support it, the bit
>> should be ignored on them.
>>
>> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
>> Acked-by: Christoffer Dall <cdall@kernel.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>

>> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
>> index b0c07dab5cb3..e0c49377b771 100644
>> --- a/arch/arm64/kvm/reset.c
>> +++ b/arch/arm64/kvm/reset.c
>> @@ -26,6 +26,7 @@
>>
>>   #include <kvm/arm_arch_timer.h>
>>
>> +#include <asm/cpufeature.h>
>>   #include <asm/cputype.h>
>>   #include <asm/ptrace.h>
>>   #include <asm/kvm_arm.h>
>> @@ -134,9 +135,38 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>>      return kvm_timer_vcpu_reset(vcpu);
>>   }
>>
>> +/*
>> + * Configure the VTCR_EL2 for this VM. The VTCR value is common
>> + * across all the physical CPUs on the system. We use system wide
>> + * sanitised values to fill in different fields, except for Hardware
>> + * Management of Access Flags. HA Flag is set unconditionally on
>> + * all CPUs, as it is safe to run with or without the feature and
>> + * the bit is RES0 on CPUs that don't support it.
>> + */
>>   int kvm_arm_config_vm(struct kvm *kvm, unsigned long type)
>>   {
>> +    u64 vtcr =3D VTCR_EL2_FLAGS;
> #define VTCR_EL2_FLAGS                        (VTCR_EL2_COMMON_BITS | VTC=
R_EL2_TGRAN_FLAGS)
>
> in include/asm/kvm_arm.h
>
> I don't see T0SZ=3D24 encoded there and I don't see it set either in the
> code below? For bisection purpose.

You're right, I am missing it here. I have fixed this up for v6,
with the following hunk.


diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index e0c49377b771..fa897eafc2c9 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -147,6 +147,7 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long
type)
  {
        u64 vtcr =3D VTCR_EL2_FLAGS;
        u64 parange;
+       u32 phys_shift;

        if (type)
                return -EINVAL;
@@ -156,6 +157,9 @@ int kvm_arm_config_vm(struct kvm *kvm, unsigned long
type)
                parange =3D ID_AA64MMFR0_PARANGE_MAX;
        vtcr |=3D parange << VTCR_EL2_PS_SHIFT;

+       phys_shift =3D id_aa64mmfr0_parange_to_phys_shift(parange);
+
+       vtcr |=3D VTCR_EL2_T0SZ(phys_shift > 40 ? 40 : phys_shift);
        /*
         * Enable the Hardware Access Flag management, unconditionally
         * on all CPUs. The features is RES0 on CPUs without the support


Thanks
Suzuki
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
