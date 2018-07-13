Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8975ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B862147C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jbU5KsMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B862147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeGMGzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:55:05 -0400
Received: from mail-by2nam03on0072.outbound.protection.outlook.com ([104.47.42.72]:45440
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726171AbeGMGzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdVQEH91PSc5CD6+SbPUguC8qC976LN1j4tplDtT2XI=;
 b=jbU5KsMull5lnX8xLqVYNv/IcS/hLqmgiWQ11fwPaXRh/UDuOQyGF/8HT4fgXGfCTqGendsHE39qeOGugPT+jdEgzRVHX7glKqs53y0/U5BC8uIzWfg7bnlMUzrHQMXPHAhUDtfUBAwMAHagxD/41zddt5YRLeUCyUQv9OAJtZw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 CY4PR12MB1720.namprd12.prod.outlook.com (2603:10b6:903:121::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Fri, 13 Jul
 2018 06:41:48 +0000
Subject: Re: [PATCH] drm/ttm: use swap macro in ttm_bo_handle_move_mem
To:     Sinclair Yeh <syeh@vmware.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Roger He <Hongbo.He@amd.com>, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20180709152447.GA27520@embeddedor.com>
 <20180713023750.GA30532@vmware.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <56e7e63d-f66f-194d-4f0b-3fb9642e7ff9@amd.com>
Date:   Fri, 13 Jul 2018 08:41:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180713023750.GA30532@vmware.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: AM5PR0102CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::31) To CY4PR12MB1720.namprd12.prod.outlook.com
 (2603:10b6:903:121::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f306c3fb-55fc-465b-57c7-08d5e88bb675
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(48565401081)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1720;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1720;3:pNfNCYkexRPQ/UVs/irGUfxor/Kxfd1G+MdZW6fUaFAsH19Xw5l89Gc6smQ/9tZyJi+NAt4RWWwaDz+REIfCCH0ON84hH3dJY58p1mb6l0e0cTJjIZAfuZo8ms2/TvPhkAsKxRCV4cRlc73pSLhp590fLRl3SEEa1jdDm11E7xZuZzXY2W0sB8K6d8Q9brDSipGnYvACUDXq/TZfjHfiBg0kwQtqHZBBRGJ+nL9zmRtak2e2iUozbcLB5dIi9st1;25:Wgtj1nRVBa2AHSCq+6BL8oCPo7a49M60pchZlzxr33bcDEDxcwN/HRLKR8WO/kSokLSwiTvT/QL4nElA4OyWoY4cgTuYW2vzZqDlci6clXkPeZr1DFW5fpD6pbVdVjZCoCZr9d1bwLgn+O84zQLLkNsywor0rGUab/9c85bW8pmleFc3RblvrG+x9OxSP+cMs74PI76WyWhDaG+J2MzXjEaPXQ8WAJ87Zq3NyE7oNg/mJ2Ai7OICer+tcWYdA6LtW2LYQfJNySCatDdp+WyNzkX4d3aQfofjFhJJNRykvR6gWCloPOhmhA7cHGkyB+YTU+PjPHakMCScKUAsp7t4ug==;31:z9rvMCFzaT9OTNcIQWAl/cZQkB1oLt8GD81mv8uwZhJoj7mvgyc8im1wkJIHYdNlsETCUfsSOnWEcnL4WH1c9UpGsL/Ebph2ph0F+9WwLgE9lfuJ/5mxKBwWErarbSaIE+35KWCM1HJxKbhhsfjMJ9SpkxfyFs6OzejV/fsCcuCq5PhY+8MnRn8+LOH1y8scvGkzQB1GiRCT4BYuqFysHKk8i3mGbToMHwc288b/vHY=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1720:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1720;20:JFBZ//09eaYOR6zbWhiFBOZFiaGTDe/09Z6WWRcclmt0tji50Qp0dnH5S59TiosPQejbAHIrkUwTvouUoNKxGDv6w9cJuXse/b+zLcsQ52AaK9P2le+pw8qazQoISpyqGOQ4uZj9Mv6Yt25GsFHlaSuqUi+/6wA408BqvoNIFQeGLXwF2qBLLtiMxzF5giMhPqTC9LVHBH6118IUbpbaXCqI426gGOF9qma3FSMrQY/J9nWtk4FRG+/8hXRtdkwxpoMWu6cKpoZqqvMWP7aN0sH31P7qGldMFYEezUKb7teU2jxN1kp10WWYXcU/Np7SkXhI5t3mD/fTnOO5ma84ZwkmaGeHjFyaDXvliMhOXQ3qNzopYp74P1BoBTYyfcDOXg7yUaC70w2/SUOd0ajKkGI8vUyhemN35MwuilNEoFiWaDbCRKITocLtTUv2kGHiZs1Q+rWGh+f83rYVEmggqITx6tGlPjITiOw6YjV8/gvKei7J1FLrYvrR9UnHhL0W;4:enz2DaaWolLGxzVOW3ErdJHBdAygjZ7y8eqi2i3+SShVWIefnqhCNI98g6ShvRRBRCm4BcfAWLWxKcRweEh/jQTffKG4ZAHAWdm5tZ04+z70hKKvMgN4+cHxm3PXTPVSlt1GJqJKueKpZlRespIY91Yrc4fJKyfDF+SQ2JVQ5mxbzdUAxuSByFzvJn7CPZKitCJ41uq5NPbYy5gky8A+aeT3tHHtSUk+/mtE9Jo/xbqUvZJuZKH35VyfPESuGw3IvOmPJP8+s79MIr1UnqaKQuL8GAvDpDDLBVVUwdkLi1rFgDhDQ/rz2EDFFxHzlWTWI8blpJNGi1uU1I7zI61ovf9Vz7gp9eq+2Ag/rnRfuDglf5oESFDnMKQkq4WfvipN
X-Microsoft-Antispam-PRVS: <CY4PR12MB17200CF063DB1D796F6A3F2C83580@CY4PR12MB1720.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(189930954265078)(217544274631240)(219752817060721);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CY4PR12MB1720;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1720;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(376002)(366004)(346002)(396003)(189003)(199004)(7736002)(16526019)(6666003)(305945005)(65806001)(53936002)(67846002)(86362001)(47776003)(46003)(106356001)(81156014)(105586002)(45080400002)(81166006)(31686004)(65956001)(478600001)(186003)(4326008)(31696002)(97736004)(65826007)(966005)(8936002)(54906003)(8676002)(5660300001)(72206003)(6246003)(110136005)(316002)(58126008)(6116002)(25786009)(1706002)(64126003)(68736007)(229853002)(230700001)(486006)(11346002)(2616005)(476003)(6486002)(6306002)(446003)(50466002)(36756003)(76176011)(52116002)(386003)(2906002)(52396003)(23676004)(52146003)(2486003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1720;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzIwOzIzOm9lMXVvZUtxTWxLK0hKaHNkVFZaZkZpeVJ5?=
 =?utf-8?B?cWNORVlsa1BnQ3ZTS0hURUlEenhzRWxWRzZ3czhRSzN6S3R3YjZUNUZNWWZE?=
 =?utf-8?B?NEVLWW5LQldDVnZJZWIxQkM4cWdKVGErVEpwQU5FbHZqbVBXQkFaUi9Nam5x?=
 =?utf-8?B?NUlmR0ZEdDE4bUEyc25pRDlWcDAyM01pNDQzVFBtNTJjd1AwT3c2cFNORFVX?=
 =?utf-8?B?ajJUS21aa2pVb0FMdnhvSVc4dFpVb3N0VjdNeVY2eE9mRzNkVk01RlQ1TGhv?=
 =?utf-8?B?a1g1STArSmRUbmptWHlBdlBpZU84djkzL1EzVXhoaFptK0RnQUk2WjQ5RXBt?=
 =?utf-8?B?TzhNUmhGVUh1VWY4NUp0NVpDeHFRTFFzZmNtRXd4R2hVTnFRKzdCclI1Qllm?=
 =?utf-8?B?TTR6cGhjUDN1YkZXRE9YZHdMc3BhNFFWNDNXRHJ3OHEvZy9oaTlWUXdDMkVS?=
 =?utf-8?B?STVkZEpxTERYWG5BbnZCNFRHWTNScW8wSlpHWDBrRjhYNXA4Q0NVOGZRczg4?=
 =?utf-8?B?S1ZUTUU4UCtYcU9tSmU2RjBlVlpVR25kQnE1aUh1ZlZmOFFmVjhZWUpRc1Nw?=
 =?utf-8?B?TFMyK1NqSENQSmxuNVkvVDZTOGM3VElOckxhaGc5emZ0Uzg5VGZCdnZVTThI?=
 =?utf-8?B?eFBWVWtFM0tCM2Y0ajBRSmhnc09xbUZiUDBmR1owNnBPRzF4U0VSLzFueCtH?=
 =?utf-8?B?V0RPVWhUTDFxOGRCU2hnRjFpYVJKUjhTenB2dHVSS2MxNGt1eWhvRW5hNVhU?=
 =?utf-8?B?TnZnRXRuRkFCWitOQTJva0k3V294M2RNdnBJN2RoZFh1YnQ3MU1PNW5DM1Zv?=
 =?utf-8?B?NXNETCs1aUsyS3FwYTVNYmUwd2N5TTUwRWI0bk4rcTVKV3lIT0puR1pEaElV?=
 =?utf-8?B?aFJtV3BPRld5Y1pvR0U4aFZoZUpoVUxYcUdGTmVuQmtnUytRcmFGWE9hclQv?=
 =?utf-8?B?cDc1aU9WL1Q3aC9KVEFldnJyMHdRQXk2djFtcXZGd2pCcEJkNUh4QnNEQ1By?=
 =?utf-8?B?S2p3T296WUgvUFVKa1R2eDNQQ25qc29DYXBJN3pYWVp0NmYrY0lQbHdWcXJ3?=
 =?utf-8?B?ZE9SZlpLY3BCeXBWZUJPQ2VLSWlleFNTMVF6VVlDVWFKZW9oR0Q3ak1BcHVz?=
 =?utf-8?B?TVVURGhXdlh4ek5saG9NNklyOFlJWWMrSHp0SE1zN3hTem9QL2Q0NWVnQzdI?=
 =?utf-8?B?T0hiTGQrOFpUV0p4ZFFxODhmWkhvYUJ3WGZvOVR6TXljeWJLS2pwcHZGbmpq?=
 =?utf-8?B?M0VQc3ZSMUR2QkQ4RkkwMlVnbHNXWXhneDY2R2xHMHBoUnByVVlkb3ZOeFZh?=
 =?utf-8?B?eno4cFB1U3Q4SG1vMGRoS1VmRHYvOXdRZnFTK2RLbFJteGpIWk0ydStNcVBF?=
 =?utf-8?B?SWpnNW5iOUMzZjF2TGtVVmFHV01XVWRqQk1wVGNmSlFIVy9MdytTbzZqQ1VL?=
 =?utf-8?B?T3NJUFJFaVB6bGViUTZqampFL2JPQlFxQVlQZ0hWWEI2UU5GSTFoaWc5NXBt?=
 =?utf-8?B?aHRac0hOZit1WDZMTGVKSlJ1UG9TeHovRFBaTGJsYkhpWmlxNk5YaGRjSWRI?=
 =?utf-8?B?Sy85ZXFoWnRGZjJ5QmpLQUdWdlp0U1FNQVZjTFBSa3BFZmdBMFlVd2plZnFL?=
 =?utf-8?B?QkF5ZElxSUxBQ0RlNnpTU3R3bGFSVnFOd0FuMmtEUndsUmRhNjlqcXhnbFQ4?=
 =?utf-8?B?QnNVUUxZTnBJc3B0RmFLVTNhVEF0V05mZFZWSzcyek93ckY4ekZYaDhueHp6?=
 =?utf-8?B?S0s0WWxteTZjVXdUbTIzTVlZd0lvdHgyNUJ2bkl4enlxbFBsbFFaalZjZTND?=
 =?utf-8?B?WjEvMm5UOHRyUFpwemNZL1RCemlBaWRKcGxBY2l0akJEWU9OOUdXdDR1WG9t?=
 =?utf-8?B?eUhsVUdsS3JLMVdUWjV6SERLZ0YyRDRUUFVtb1ZLV2ZNZUV3Vk5DVmtnK2Js?=
 =?utf-8?Q?aELiRszfckaNwz04NAN/lVIOWOiFjs=3D?=
X-Microsoft-Antispam-Message-Info: BcN9o1EN+YqPQAd1xoIixcA3dCU5TgA8tugrxr0mtQmwpv3lZv8WTYcR7wwV5GvWK9gtJ6UAomUOAoYcEuTWZhvnNbkv1QkTQQhvEtL2aVRW/KLupGxldLBOukZaS7AE/Q4NUthojJm6AvzQrj5uqPg8morFXTa4zlSRfcLereYUvVkY4G8+OJIF5c3I/0WCEYgA+fqPlIc4DbkLl1DJ4omVSyAx2yFuKPDuLegM+s+hsLCXI0j0+BPaY8TXPOOBjR08Pgv1mgh9v+9dtHDSc4q4hqqbStCETpJ2bWPTwyy+so1hXP7SMLiAN8HzABlbP7gjbOxLaPr5FVNf83QibldNxlu1ymFEyhuklP3rQwg=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1720;6:VwEYXxQ+nIQgTxiyRPi58vR0gwgcXZTAkNY5HrL0/x6lmWtIAD9ExwmFAus2mulr5THtkizhiyAL9dUfYHYnsIc9c8SJZWmyOSccQejqJZBc5zfaRDtWMplQoE4yD40lmljxDqJKK6P1m18Xe6pzNAcBvlIWIkCaOA4wkt9gv6tGj43pSH2kYz/r+wtZjPN7yMgBTpcjtoRWo6ZsAWZpCKSdfKKpJiYIgl179+90tMwlZ+m8h4qAi5w9on7iTMfCBKjKWpFrY2z+pdpOAhO04mXDPkym1zCwivxIHAdifS9NAexdYkFUoagF6bDr+p7BuwAw9fdd8ZfCK1/xLMGbTKe3z6qhT9V27jIgLuTO324LYoOS2sEtXpWDMhmrkR6IJKPMvR7XQM21cUJjfENPCcJz9ztzvKnvZWXFgMTBLLWUk7/bXQhqRbPQ+vBL9J5TtijBKeB5xyhne9kVK4OKtQ==;5:RVcNAPa32WYO4ootJyvyRxrhy7cD9IY4h/qYvDx08IiLQ2vXd6mGj8mvzEAvJO5zhGLIt77PzC/y6NZc4b5I3VkvLcvSycP7/uAsLlRQh8LyUHFF73rXYFnv4AhcQC0KCES3xD8pwp5GLCrlAbAEKZPH+xfC6xfBzC5camBZhB8=;24:ctqR69Yz8QFD9QroZjTVSGzGYVm25wlH0xyGED8jrMRPEeb1Gkr6Hu8kADoAqf2GjMuLTXZkXvmSWJtKMiZOoCmWSwqRI+2MMIgesx5BELw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1720;7:qqzdjj3J1irnmbltICYBqabgl3JmztDluOyxQeEqQTNfsu+BJKcSPPiIXXK6ncx9TQocdAT0+i0t2WfII6nVZH+3VH2MopVjaTCIBhGWi5rC456KeFMqmbA876Xb6Nhw4pKxM30Q0UKoPYKqv4Dci7iIpJgxiszwoOFYHFt9oIuIaJ+jQ9ErcrgUFW9CZZDUzhsgNNJrBdISbXv2x1al8QRLN4z9lOriAHZ3WLDMaYwaof9TmEFDrgAd8hgsejiL;20:ZwhOC8IpzzKd5hHaCGjHubInfhhIVjWblC3jA492eeyHdZdt0yJu5wRLIN6MFN1YkdeN2at9QnkPbl6pzsGdqvLhyjKiyqfezzRpomrT2bLF5A3nvE+e2+TUxm+WHHquQs888TNB//m3HRdaD9GiJGaEtSlxepYhg3da7rom+mazeoo0ORWvqhUyETvSwSAVjmZPTELKGzM5TYYOhTLxkC3ONW1U6uuMLBqOrVc4rqWl6jc3K5bpiibxNreQJ8GJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 06:41:48.9504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f306c3fb-55fc-465b-57c7-08d5e88bb675
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1720
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 13.07.2018 um 04:37 schrieb Sinclair Yeh:
> On Mon, Jul 09, 2018 at 10:24:47AM -0500, Gustavo A. R. Silva wrote:
>> Make use of the swap macro and remove unnecessary variable *tmp_mem*.
>> This makes the code easier to read and maintain. Also, reduces the
>> stack usage.
>>
>> This code was detected with the help of Coccinelle.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>>   drivers/gpu/drm/ttm/ttm_bo.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
>> index 5d8688e52..5142dcb 100644
>> --- a/drivers/gpu/drm/ttm/ttm_bo.c
>> +++ b/drivers/gpu/drm/ttm/ttm_bo.c
>> @@ -287,12 +287,9 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
>>   
>>   	if (ret) {
>>   		if (bdev->driver->move_notify) {
>> -			struct ttm_mem_reg tmp_mem = *mem;
>> -			*mem = bo->mem;
>> -			bo->mem = tmp_mem;
>> +			swap(*mem, bo->mem);
>>   			bdev->driver->move_notify(bo, false, mem);
>> -			bo->mem = *mem;
>> -			*mem = tmp_mem;
>> +			swap(*mem, bo->mem);
> This code assumes bo->mem is the same as tmp_mem after the call to
> move_notify. Is this always true?

Actually the old code assumed that. Using the swap macro now fixed that 
little unclean implementation.

Christian.

>
>
>
>>   		}
>>   
>>   		goto out_err;
>> -- 
>> 2.7.4
>>
>> _______________________________________________
>> dri-devel mailing list
>> dri-devel@lists.freedesktop.org
>> https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=02%7C01%7Csyeh%40vmware.com%7C3bd79878de5141b5187408d5e6326e6d%7Cb39138ca3cee4b4aa4d6cd83d9dd62f0%7C1%7C0%7C636668026634710967&amp;sdata=2raJ6TBpcEM5W7hi8iCEnrEdcfJa3W5ct3tF%2BlSZLkQ%3D&amp;reserved=0

