Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF122C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B24208C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="oHyCb8O0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B24208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=Netapp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389522AbeHGRNf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:13:35 -0400
Received: from mx143.netapp.com ([216.240.21.24]:17651 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387617AbeHGRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:13:34 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Aug 2018 13:13:33 EDT
X-IronPort-AV: E=Sophos;i="5.51,455,1526367600"; 
   d="scan'208";a="276463240"
Received: from vmwexchts02-prd.hq.netapp.com ([10.122.105.23])
  by mx143-out.netapp.com with ESMTP; 07 Aug 2018 07:49:28 -0700
Received: from VMWEXCCAS01-PRD.hq.netapp.com (10.122.105.11) by
 VMWEXCHTS02-PRD.hq.netapp.com (10.122.105.23) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3; Tue, 7 Aug 2018 07:49:28 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (10.120.60.153)
 by VMWEXCCAS01-PRD.hq.netapp.com (10.122.105.11) with Microsoft SMTP Server
 (TLS) id 15.0.1367.3 via Frontend Transport; Tue, 7 Aug 2018 07:49:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mWCgc/Zkv01Sm+9KethCJFmsakN5YBtOEL7JtCozNLg=;
 b=oHyCb8O0St1WH/Ki2pnffCxzGMBiAzoIf8ZWv0XoWaBHc7G4t0AfkNPnBajhW0D66GrSVDXIHImPi/lzpOvYZ3SyQHIhI+cdnDOTuW0sECGsmdE1ohsmKdkDczXLCYIFO4x7fBJFm1J0e3dGu3nptaNZqDhTL9a1UXvrzWm8OSg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com; 
Received: from gouda.nowheycreamery.com (99.9.112.69) by
 BN6PR06MB3156.namprd06.prod.outlook.com (2603:10b6:405:41::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.20; Tue, 7 Aug 2018 14:49:26 +0000
Subject: Re: [PATCH 1/3] net:svc_rdma_transport: remove unneeded variable
 'ret' in rdma_listen_handler
To:     zhong jiang <zhongjiang@huawei.com>, <davem@davemloft.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1533640809-1221-1-git-send-email-zhongjiang@huawei.com>
 <1533640809-1221-2-git-send-email-zhongjiang@huawei.com>
From:   Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <2c343d78-e668-1b97-a4e6-228296da0d70@Netapp.com>
Date:   Tue, 7 Aug 2018 10:49:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533640809-1221-2-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.9.112.69]
X-ClientProxiedBy: CO2PR18CA0049.namprd18.prod.outlook.com
 (2603:10b6:104:2::17) To BN6PR06MB3156.namprd06.prod.outlook.com
 (2603:10b6:405:41::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9c69d04-7dac-47da-cf62-08d5fc74f998
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7193020);SRVR:BN6PR06MB3156;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3156;3:TDa2C2Wn4qA5qH8hgcr6S/zOK7RrpAdN3ytgtrxuUHaKZjyA3qVoIyyFQoog83V62yrnFuHVLXAkZTx/faCaYDGeAu2XPlPNyWRagcY2LO0qCDs0D3URdzUhaiTNbNge1DQ99Qdo6M2H6SpIv6tHxrlIaJsPGeGmmzNFd3VRWfh73t37y82IBmOTpXIXn0of1WgB5UW/jQe/QJfmaytXicE/1bS9uLMUvGumS1fHMnJlCSbFUNFZtMfighDtUAhx;25:soGlHpd1D7dbeWiOFk6blQ85OP8rn5b7kPXpgu0uMQ1s/6vdA+4DU7xyUhm2cXmg1fz+EDUdBVvXiJelSyEPzsztco397PVJ9DwpMZtyMxZxDX7HGVgDm13oowbEOMdOOOt96TWNjnF1o6XuHpzNaqMOqlz1rfT07P52c193gwi+TXm6EkhkMv3o8tbl+LkGirZ00VoI+xL77smZrL1v4SjEgczHt0mmX1q7L2i1WlPzDfydgcsWcnupDvxvdDsvtSOTGr70V9IDO11yJpIYfs9PMjqXvA1s4wog3LS3b0G3rSuTBnksgwH7V0Tg6/amyZtNevm1cTRLOInDt+0vHw==;31:tmGsifnJd37I/5kPsJ2/bWWTECb2NKjTkLEQJOIisuJMF9djXIleYEzPycN0obfc96nR6gtKJlnh7hHMJ6WxLVcumUtfxEgVWdP8FAV3GFTkoj6cWygkAF+anrexXMqJoKin5VEYLJce5PXe4Tc9wnSKbAj+7dukIHF3R0QNT2DSGjE2LOxzpEkitWcGS2i1gza2m3wTiiylkG3SLnyBWb0e15NXrBhcl05ajyBvXKA=
X-MS-TrafficTypeDiagnostic: BN6PR06MB3156:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3156;20:U8XZqzY+5bUF4HIpGPV+an3HzEiXfPq/jYfYxwDWCZGOQik5pyOlzJuxX8y96y/NKloM2TH/h4yBWMwRw+UtbvOKjtvrEBqkSTIzrk8gETcxgEz2urz3eqxMMsF1suKxj58hHbmcYkcH3cbnd/Nc4PKeMebb967n8C2QKV0dxN2aWAEtG7lVGfyKbYY+TppHev2Kp2rzkxZKjtZLnRcO4fxsRCVFMx0HpsF5fttT/rWKcWaIbU6nCjDhh2thy5g5+IqXEN4D2e5RkyemkbLG/xPD50gdLYRYcs8dw5ALrGxNb9WVR6u8hdIqrUdM4M2z9Kq8IspB3rmgCdlNaN72M9WwJQFyBnvFCBI7MwnObzQ8snf/ENxq14MKDATSaiTIuA8+xh2OJ4vv0Na3PlHuohrfwQXVFIStENjOW4KnTeAC9dhwUlZZ72DKIm7AynGlPRs4QLMHH0MueBJ75RRXhirbhjbFOtZk3QDrM30DnvG92e8KsXf4q0U3hjs76k1z;4:sFcImHA7SniDjeNz4lKKVdaYsYjEcjsDGgh/H4K2FeQ0aiRaZGw36gplRjtvmM3coVXjfhEtx6aqMXlQkptTtjH/neSu7CB1q9ChsQX8mcHeUpwI5E8SyzfVLJbRjs2w5U0dUDL+7eb8H3Ns3b6j9j0KRuK64K6Ln+TWAIJwwj3wnnf+dwDqgQoGsXwEUD/zec/R+t9ETYeY4WMAIv+Z0HeNdUH+WNIs4XN1nXUEf9MD1UTro/JmhgNRYcvB6ZzxgOHkh2la1qZnEkjnOOghV7LLBi12UmB0mvoxBRJGXV6eaiZsuWq614VKcqX3/n9HhQVEC8ELTfa1iIQ9MCR/bTVT6b4VTjQrVwDDsOfaMcA=
X-Microsoft-Antispam-PRVS: <BN6PR06MB315667B96F3950E4B95704C7F8270@BN6PR06MB3156.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863)(50582790962513);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN6PR06MB3156;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3156;
X-Forefront-PRVS: 0757EEBDCA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39860400002)(366004)(376002)(346002)(199004)(189003)(97736004)(23676004)(52116002)(68736007)(6512007)(58126008)(69596002)(76176011)(25786009)(4326008)(2486003)(52146003)(26005)(65826007)(64126003)(305945005)(31696002)(86362001)(5660300001)(316002)(16526019)(186003)(2906002)(6486002)(36756003)(7736002)(229853002)(8676002)(106356001)(3846002)(31686004)(81166006)(81156014)(478600001)(53936002)(53416004)(11346002)(476003)(72206003)(956004)(486006)(2616005)(446003)(230700001)(105586002)(6666003)(53546011)(6506007)(386003)(6246003)(110136005)(6116002)(8936002)(50466002)(47776003)(65956001)(66066001)(65806001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3156;H:gouda.nowheycreamery.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: netapp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjA2TUIzMTU2OzIzOjRvcWtXZy8zdGlwWEJjQ3hzdzgzcU5BMUNr?=
 =?utf-8?B?ekV3b0hvbFJ6SWVqQnAyRUZ5a2lJRGVhaGFlc0NJV3hqMkFBNUVucURLa25N?=
 =?utf-8?B?RzlteHpaYmIzdWZZelc1c2dYTmpJK0JkUk9ORVVZWjdvTTA4OGdVSGRpRTgv?=
 =?utf-8?B?R3pFK0V3NGVxRlFDVmhwVFpDQXZlUXYwQXRxMk1GOEtOS1JqUkdRQlBJUVFn?=
 =?utf-8?B?Rkw3VnhrQ3JvZTkvVkt3Vy8yU09kNXpKRkdtS3ZIdncxMzdEaVUrOWkwcFdR?=
 =?utf-8?B?QS9uYmhTVy95ZllXRmFRWHQwblRkbERCL3p4aHdCVHRwbHFmQXkzYTBzMjIr?=
 =?utf-8?B?QVFuTGlGZ29TcC9CWDRKSEV2aGNWVHZNV0VrTGNGUVZDOGI5VWVZcE5MRU9q?=
 =?utf-8?B?bHFIMkRDQ1UrNXpoWmxuMWI1UEVXNVRTcnZ0SHlhWXRiQnR1RjJGbThWZVpZ?=
 =?utf-8?B?N2FERFhoZGptQ1FQazV2T2UvaVlxR2h4K2xXRURxOEhwUGQ0dTRSbiszT3Rv?=
 =?utf-8?B?eWdQb1E3bDBZdlM3RXJLdFAwQjhBb3RMSkpYMVE2WVNjVkdLcWlZNE1iR2NQ?=
 =?utf-8?B?UDBtbFkzdFp0eWl4ZnJPYW9IaENjbnY3ZGNBRGtqREZicFBkc2JUa2NUU2Mv?=
 =?utf-8?B?WVhsNTE4ZXRRbnp3WHk3b1p4OVh2a09EYXVnWjBlck8vSHhsL2FLSDB5ZXZ3?=
 =?utf-8?B?c0xPU3NuSmhYelZ1Wmtvc0JoZHhXS282Ui9XM3Z4NitMRVBvblVvdWFhOVE1?=
 =?utf-8?B?cm1mSGN2N2d3TkZtWHo2M1IrdkdId1o2K1RqYzFPTUdqNFlxYmJjQ0dnaVFW?=
 =?utf-8?B?a0ZZRnZCbzBDVThhWXo4SUZ1SGhrMmlMbXVTbjlYT3JRMzZReEMrRWYrMjdZ?=
 =?utf-8?B?UU40WUM0dkpxNGcxQjV1SkpFZ3dkdTRTVGtnN0orL1ZCNFplZjZaY09NbDZW?=
 =?utf-8?B?RGVlOTV4VW1RT0JNS3VqZEM0Q21seFZEeFh2cUFWZVZVRU5BaE5GTWdiSGdK?=
 =?utf-8?B?UGZMaldBZG5oOVkydENBckQrc0lNMXl3WDVXQ0F2bHNOMExRZWJnUkNIZUsx?=
 =?utf-8?B?SnJMejNmODFZSkNBaEFJTGpIZmFyd21tNHJYUzJpalFaeHhtSE1VV0xXVkI0?=
 =?utf-8?B?WmRaOEIwaHp0SHhhNnhhUktJS2RoY1B2L1hCenBPNWtCZVIxY0tYZGlZNldI?=
 =?utf-8?B?bnIwY2MxK2ZYbWJhNngxczRpS2JwSUZIeTFWUmZkaGgwYUhKRHI3bFovcmNv?=
 =?utf-8?B?NVE3NlI4a0l5Zk1UbFNPM29tUHExVTE0ejJaYnRlMmdOOGtvbUU3RnJ6T2ZF?=
 =?utf-8?B?U1dRYkt4L0ZmWG01YjJha3hQTHJnUEUyb1NtdU8yQVQ0NGZPLzdsZUJyTTRZ?=
 =?utf-8?B?QTBIMWlMNG40Z3dCSkF5Yy9oaVFWZStIVER1eUExbUFmdXF2NzMrdkZ2T2Fh?=
 =?utf-8?B?MTdBUnR3bnRpOWxjdXNXOWRmMC9lVU5UdTRmaU56OUdmV3Z0b1FMNlBYZWMw?=
 =?utf-8?B?WHo2bGl4bUlmTVJjcUJuL1I4cDVMcFZEUEtDditCY2h3SUI4b2YzTExyOTVQ?=
 =?utf-8?B?Uk9QeUVDcFlmT0lxdlpiN2dMSFlsVHY1aFJVZmhXUjl2b3BmaTJ5bXpENFZE?=
 =?utf-8?B?dzVCc2t1clBKMnk0NldUd2ZYNUg5VUZvdGhlWGhRdTIwWVpuNWY2YmFjR25v?=
 =?utf-8?B?R0E1MzhId3k5N2JzRU5hN011eHQ0cHJUUlVMQjl5dzNTaDlEeXl0MDlCTy9O?=
 =?utf-8?B?VjlMbXRyRmZld0h6UEh2Y3BKRU5OdWFQV2ovMnprbjRRRmVmNnNKNHRRY01a?=
 =?utf-8?B?K0lGMmJEek5OYmNyTHY2NnF5dVNzdlN1T1gyUmhmSFVUNnJSSElEZ0NvYWNS?=
 =?utf-8?B?ZFNRZFZUODA5M1NZNmhZL3QrZjV6Q3YyV1E3WjNPZytWU2R3QzBvQ1VEdFky?=
 =?utf-8?Q?5VHG9vXxU1h4Dc8ZCO2ZxKot1hPS6U=3D?=
X-Microsoft-Antispam-Message-Info: 5v7nsVGN3hvqh1a1GUhNpPxQbadmVhOx07w0a/NDR1DJbbhj2O1kPRenPH9x3dr9Jv7gCf5CbdIOFR3vcxirKVaKJVqQQIt+PtBPGwPFN24RhFHnuxt1L6mqIMMQRR+HnBSCgqaCJyOgqs/QFBeQEWq+RnUjU4wRYvhyK4K/RxIh1qb0zK5eqyCH4TKCrehc786bhS5Y4ba23XGEv0w+utW2hKZCc7xj3+dm4MJWFWN931JRfnFPjGXMAEwqIf83xtf0mH94ne/XlFPNJqwi1fqVOA4zyE6jScQT5iuDCY7y7WxxGIniPeGOm7sUHEYu20eJ1xnAofDKvQyv93EEqfXctP1MoAb2lqFlDid97uc=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR06MB3156;6:7Lmbd2p/P3+3+mdKUAsVvZukyp2j6ePTJ0I1JEDwRHKlJOpjkL4KOkkU4B4rzRaXRdE+k1C6y8fldlU6t8MR/iL4t5ITL99or6a24fhIwNks4GXMlKeb/Ls1thl6nHj02Il3I9ROjX+BEqgK2m+ZaCJa49gFVtRk/JVoUom0DYgdol8IGgv92U+IdoxBrPwoyXYsDinnicqZbEn9n1lgTnbVRsBBeUnF7n4gNoLzLAcM3I86/RQhl+oXbau/uKpvT0Wzi5gCKMerRMFKN6r8HzNPTKi6I23/VKXgsFaebpSyAiRABuBBiqvaofuj2V4MgFn/1TKtvhI1IrfcvIAauTTtkZ8V/hg71h6SlQrupUrOTkXb1wqKliR9V8LF15ojfDpZGapIt2rPy2HYxlhptN6keMuNETVr7QEbPXkNY9w0MhzkcmSAhFp7PYdfgRx6/w0L5SHDh331rDKFDxYzRA==;5:O9s6Sxn0P30UXCpXIBYK6IrEMNsj6588DORDgH7FXcHZubkil3jgkRCpoPckpxGE4nxctOPvo+/fPClh6uFexj8ZOTsTPlKlTJksSuu/N1tG+BHx62tcyITFvci8szFlafBS22l2yWEdvxaoGr7ZZWKtHLHqskJfaMHQikI5y6g=;7:Eydw+43hvWloMMPDNKevmCqcXKgpc21oKrv9w300M7FBIjtooTvVQsHoNL0ALZKjQhjHgtQeSU9s/GrwZXiSGBhuW2wOe1vpPo58L64mkzbORmZV5mcjwzoFx0l+Y8WyDYxbCg7CNCykpQrMROC+hGtA9jrZMZLKjtDgKlCthC9p8BT72LkSlx45NhhKeeb1dpjiBoFQu5LPi8fptVFryFJWmotWeyl+qVnDRwiMzpxJs465AUmjP0z9HE+B5LjK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2018 14:49:26.0618 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c69d04-7dac-47da-cf62-08d5fc74f998
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3156
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Adding Bruce since he takes nfs / sunrpc server patches)

On 08/07/2018 07:20 AM, zhong jiang wrote:
> The ret is not modified after initalization, So just remove the variable
> and return 0.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  net/sunrpc/xprtrdma/svc_rdma_transport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> index 547b2cd..2848caf 100644
> --- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
> +++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
> @@ -296,7 +296,6 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
>  			       struct rdma_cm_event *event)
>  {
>  	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
> -	int ret = 0;
>  
>  	trace_svcrdma_cm_event(event, sap);
>  
> @@ -315,7 +314,7 @@ static int rdma_listen_handler(struct rdma_cm_id *cma_id,
>  		break;
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
>  static int rdma_cma_handler(struct rdma_cm_id *cma_id,
> 
