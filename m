Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFB2C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FFE620846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qO/A2zFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FFE620846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeFTQmb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:42:31 -0400
Received: from mail-by2nam03on0052.outbound.protection.outlook.com ([104.47.42.52]:18331
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932088AbeFTQm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4czNTOuNBMrq3h+S6HRTOchpKaeKEy31Ou9E4dhfP60=;
 b=qO/A2zFGr6wZ5RlIQ855ZyQ3nWzcBPv0pxOMGfrmBxc1j+cTsyUWiQWPhXebP0HIbGMht9vIzpsBEVDxXADd0CmvvdPyBIS70OizbOUuThdqdW7TOllo3F2IQQglzdVv4Oi00KCW65jAXHtzkyrnBV6804Ck+tpGbS+4QZm/4Yo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.64.67] (165.204.78.1) by
 SN1PR12MB0175.namprd12.prod.outlook.com (2a01:111:e400:5143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 16:42:27 +0000
Subject: Re: [PATCH 3/4 V3] Remap the device table of IOMMU in encrypted
 manner for kdump
To:     Lianbo Jiang <lijiang@redhat.com>, linux-kernel@vger.kernel.org
Cc:     iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        dyoung@redhat.com
References: <20180616082714.32035-1-lijiang@redhat.com>
 <20180616082714.32035-4-lijiang@redhat.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBfwQTAQIAKQUCVo1liQIbIwUJCWYBgAcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEN7/muRPME1TTfQP/A8U028LCMsxhCmg8KnL
 oaXk5iRhiS8bhQILSWS0wTGjnpyYIsOdL4TwLLMfFkCtSjsdQSOnu8RVP3nu1waC/6U2pWWS
 W26B4GwpHfq/mi/PZOBW6+tt0srwxVvuFNVN/uE5r7Girlc8QHQfNyYxZu4eTbl7MuIIwuys
 rCueJGgaDOGps7aeknQhSYIBsdV2CazuEa2T7v4KTsjNbHCesayUbl87tZoBcs5Cf1yeUjK6
 ePSVZPszEQ9Z5iE7meU3+COIQZPvEhaYDx5qpHZjakWpb0AfOspIxgxRR3W+sutOKshbdNDy
 IhbYc9xDjOWooI+6lkNKIdAyqoqq387JndjUuXVYPM3lNY5MVprH8bO1CUzusuMFSB8SlMKq
 p2sUEiS3jBpSd5C3GKxYAOkhTZn1kyNB7CyBVU2R4II1R0aSJf2yxOmWrEboeFO/SZQAX5ji
 A7obQE44zVZlSIlFh/sm7ns2zxJYyafML5N9CA+5RWJ2QQUzzjgZkvTc2lBwvl+kAe5P23aS
 aWbJdEgjV6jwhzHfKtlIznqk/t0quVwEzhzfvzxK/8HL+di2aeg5YxPA7VrjDRLFRGiCUgV9
 gAPlLR92LnUM3XUgdtCAlQ0xPY1qaxbqZcK04zGQu6HtcO7czIwLf5K/pjwQRlMxPIUDFcTx
 gl81owVskfEp6Y76zsFNBFaNZYkBEAC+8m2NNYbxIOqTodhtUPv2VpsoovMYUNLD47xF1m+T
 FryIe0cQ/VeWb9eOBLWyAAbUdE8LO8Qzm3u226/Z5UsWT7q/iQ7BZrcsIJHe+/BtJw7d4u7M
 6s3EDznEdN1O1zw0wSVw6TcFVfi/Mb8eYLK9iG4YgUHfYl/JGqeZNyOsHwUmZtWYFhkG9pm4
 rqjgz838zXSq/zArcVhLFjgH/wpRXMq/nPxIdvoF4AuSnodmSG/8TvtQq0wt0oPZfR7OQxtw
 qZQm1Slpmi9cu5nQokrdm/3VxNCtZyUfWckRjpX8GcNWhTx0/gMuaeq2Rs2nb7u8qQaE8Ket
 kdaOOeo7OwsiIPNTutaI4g1y1BsWTfwRGDQwvZ/atT8nzKw+Ni7bzj+mUbQXkjxB+Rv+aSLe
 BVYrdGOME66Ru5owTNOpB3elfqX5QfBkcU6uTO5syxYyC1JffwSY82Ac3rLKW3qE/xu3uSam
 4i1lxWDnoOlyf4jgjC3XfUS+OiV2CbAWZ42Q/EZ+ilTu6arOSfSv5yQ1cgnX/CZ2A+Uaujjp
 oD/8w520lEjmVqx0FkPL9xH+uuY6aFzavmcqG6X23ooblnwYaa1lJND/5vnJ0dqnhOMl2JeK
 gnFgJEchkbts4CMFwDlwh06svU1tdCxqtftOPi5iR8KQAAUi7a+yYIeHq1l4vZhaEQARAQAB
 wsFlBBgBAgAPBQJWjWWJAhsMBQkJZgGAAAoJEN7/muRPME1ToGMQAN5eR7zVdNCRfNsY8bcw
 xqwTgBu5sugTBghHPRLfQGZOBBg/49iu/6qDu6Q/IBIXc1963GOtd0eOD1fjdtgNzP6WTvZY
 6zzkNvcwZQpWBTlXJa2KqKzdqGyTPZSj0YlY23L461PelTuxdIxNv45pOk32yg83NTqhxBZu
 mlAuPCfFpyH4IEEEB0j+9WEZnzl9cBLzw3rVv9bEIixe5ykSmG8UHJ6FJ6cI2myru6uwzbOu
 n8DkNLspmZppoTpwzPCY/6iljBLUBzDDRD8rzEavva2IhzINkrAvNSW6VpBMSpUBgsEIKxrp
 AFS1ax5uXmwYGyFzOWy034Zz5fWi260qiFplzKCij8t7sCgzOXwEbIt76L1basrRMY7urJm8
 4VM6MeG2mfa92FfrMeL0pnD5ONg1FIuleGlvvKdQdFnE4AlwGcKid5GUD+vNNj/pbZyUpe4r
 zBFsc21/8jXSlR6zJS4mgkNDIIBGiPny3tvKINMZ8VK00mR6INpd+NErd2LxwZ/DQ5ejVyVL
 080CbiD55mxxhqkbd5fHSfdhvvXIIYN+nM/RFLwaQGW9g62iFWlqeNRXezkERDV5ahFqZMP4
 YDdodn0nRVZYu2kaXfOclKPcH58HlrRb8pKTE3t/TNKGY3SmKoznH0QtM27TWeZ9R9RgTYiV
 zSNqP+QUNp6BotWI
Message-ID: <60c6f00e-0eb3-d39c-6a1e-8a1dc1e095af@amd.com>
Date:   Wed, 20 Jun 2018 11:42:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616082714.32035-4-lijiang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0701CA0007.namprd07.prod.outlook.com
 (2603:10b6:803:28::17) To SN1PR12MB0175.namprd12.prod.outlook.com
 (2a01:111:e400:5143::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e3be274-abe8-475f-8bb3-08d5d6cccedb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB0175;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;3:nqaMhIPFM40IKL48HnT+gU8e+q3nl8lMeOGgEsvRzixmFry4fVQH1TWpxcoNp/XPPUwUKN8GrHN3EyNSY6X7SyeSsl18HH1YzLS38qzeSvTyC6Xp4BZhND482UaOZouiODE1kpNO9F45DxhxllWYRfBOuu2SL78+zI1ySY6auMdXutOs4vi4MC+AOX0pKHVLJhyQ4QjNqA4xhI9Xtc9Hc5+Hj39k5bEshPd4dnMfZUYv8R2Msss/5Oq19IPUcyPv;25:j6QCsiMCZwWWklRJWEdAwWRehrP+aaq4X6cu3yT4aR07kUwujh0d853vNyrQLt8BazTcORzL/s+ksinVtYMmlUdaahKu14IUynD3SXgxlRK3G9UKIfbPRMST5Gd3IX2W0aUBP/vu+KVY5PAV0y/kWtzJCXXaZ2m0DjmwCZaOLcGyZuZq+wTUcGg/9t0ucNfP+fjM4F4qNeZZqzlXYotjUz6bSgDi2IlPKN5JzXCWwy7YxwJ+w46FsDBpHAP8iNvvZlwQugnb0DvjlGNmQMipRI7hEcFBf8uHcHIEQNbvXIindGI0Tx/JoR9C3jMk8EQsigsVJjot01PRh4i1IuFz3Q==;31:AsucDm/5TC+RXWPXAb3+Y8fgr7dcFwneWbBDxTTYnch18IL5MUtAfKSpZ7wvgRn5mYLEuASv8O3sUFjSe9B9RzYOTkt1J2nA/hIr04dOnoJ3+6TkyZToIPAkkKtlZoFGQSHsqgQ2eL6LAym/EU18O0H0Dis16PUcXeYwxbXOM3n4T4+5nCFn0ZQ6czvAq9MWafdgVFsC/xb/x5e/45PDE7aIzzyUNrUJu0oAhNod7OM=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0175:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;20:5IEzd1O082j+z+BrZ8x2Ny0mOGv9mY4vhGBEMtHclrTqKiw5ePviYeVd5hn79SzQyB3g7BUQwCfLQBW9JeqxXGmBAU3XyWncL/uCMaOJ4U+3ft4z0pMQVnvPIcRFyw0zh4DtYlQndF15UYhEUHa6F7f5a16VWnP0a+jKkOLy208JfZCwF1PHkYXZckeBZX5mofHcFwjCR2C9EVnS/bWybkHd7brA555zV+TGACAHQ2frOQWBdrpPaGQk7Ais0e7oMOlZFwO2lS3kaqqt+dV+wKiJbj+iJ44UCmNffdTONwYGI7FLIo1fbdE+fD1zCx9yEDg3n/f7EkV6M2xPuO8wpcG9n2SF4dvWWD123HX2k4Bj/KM8COdbm7ny2AB686SAId+FNULNVBo+CfsfYOLNQzxF57HWuuGSIlhbXrHzW3jJRPVe1yVKle4Mvx3+21PehVSuwzNQ8Yt8bU0v4BEN1p4sWJ7BZyVVoTVmLzSIz3fxUCHwmuEIGHrlc9Hetl4u;4:2kTp38PN6jgm1xQmQBn6uQKuFldXMyx4Jl1U3vRg58ri6W654ciIZp4sEA50kiE+1GuRHX8UvK82qC97rs9hgW1rvD9DssqGPksuUzZB5n2EMAEKWXwXxD/OYFeHoE2vYyCc7YjQU9P7K7YTQDxa8+RNYGQEG/vg8jE+PB8O3LDbqfulLlGYxOq44TC7EYRteluXxpzRdo1ACcWKXKXS6Ki2W/+NnTgYQHDJ2ilzZo0My6xfViuRht5yAC4kPnzLXLgx8RL01wPyIOj7Al5/gA==
X-Microsoft-Antispam-PRVS: <SN1PR12MB017533973CAD3354319A1967EC770@SN1PR12MB0175.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB0175;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0175;
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(39380400002)(39860400002)(346002)(396003)(366004)(189003)(199004)(7736002)(52116002)(105586002)(23676004)(4326008)(53936002)(31686004)(65956001)(81166006)(47776003)(36756003)(2486003)(52146003)(106356001)(66066001)(81156014)(6246003)(64126003)(316002)(2906002)(229853002)(50466002)(97736004)(8676002)(65806001)(16576012)(58126008)(8936002)(6666003)(6486002)(305945005)(25786009)(3260700006)(65826007)(11346002)(31696002)(5660300001)(26005)(86362001)(6116002)(59450400001)(386003)(3846002)(53546011)(478600001)(476003)(68736007)(76176011)(486006)(446003)(72206003)(230700001)(956004)(186003)(16526019)(2616005)(77096007);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0175;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTc1OzIzOmdjOHlCMmF0elQwMXpLa1diVEtlM09BMFpm?=
 =?utf-8?B?Ym5PNzI0bGsxYUZhV0liTXJiWThpSk1PSVJhdXcrSXJWQXlCS2w2dmU1d0VM?=
 =?utf-8?B?M1M0VTRDS09PNnMwNW53V3pSeUFCUjhxWTNYL1RBYVRXVFMvb21VRm1rVFZ3?=
 =?utf-8?B?aHdRbW1yTEpwSTZqS2dSMGh2NGlLSVlCRWxLR2k5UmdmTmtuekEyVXI3MG9S?=
 =?utf-8?B?UVo2eHhmbmhpOEhZbHdDWTZwdWdXTktQN0grelVaekRqVEhaOWRTYjFra0lR?=
 =?utf-8?B?NHJ0d080OVpzVElaejJXVXVmSUQ1R1pwUGFYQjgzUTY2U1RDUk9NSXBUdlNj?=
 =?utf-8?B?cThvK3pGZkFnRDRuMzRtT1pBOGgxQ3lSY1lmTzlzWWtveWxXRlM2TEtMUlhX?=
 =?utf-8?B?NlZVbkNqUVVzVk9zNlFmOEtDODFScnk0N2thcUtoNEFkd0RWcHV2YXpFWjRS?=
 =?utf-8?B?dFZiVllqYlEyRTRuNXRMdlE5UzhxQVZOSC8wRVFmd1RoYkZDY2NuQitmYlNm?=
 =?utf-8?B?TnV6YmFFUnU5bVFKOFM1SWg3K2IzejVZdUdGbStDMW9Kb1Q3cXNCcERpbktq?=
 =?utf-8?B?MHlHOXFDZ3JFMWtkWFl5RkRTMzZNR3RJUVYwSmh6RmVVR244RnNhMnRyWk9H?=
 =?utf-8?B?NkJLV0NVenVMbG02Nzl4LzBzRWNmUVRLWkdwY2U5a1NBeFZMRDUzVVNLUkR5?=
 =?utf-8?B?bExMVGRqMndGNHVLRmpHWW1FcmMyMnpoQ1ZoSHh4dWJGejdoTjAwcVE5Z2JE?=
 =?utf-8?B?dkJkTWQrZlJLSWMybk8yQW5WdFFhSVBjRmhVVGwrdXRtOHJLUytvYXM5NkE3?=
 =?utf-8?B?ZHk4KzZNai9seUVHOFBUbzlXOTdwV1ZiMnprbHRYdnFlb0R1ZVFGY2pKMmwy?=
 =?utf-8?B?cTlCTW9Fa05sSGt1aWlOclI2V3dWcXErbWpHZXJETkxQdTZqRzEwU2xiQ0py?=
 =?utf-8?B?N05sLzkvR0kyVW5pN2o1TzZrcmFZZ2pJdGJkSVc5aTU3b0VHV0thdDJOcE5l?=
 =?utf-8?B?WWhFczFIL1F2V3EzZlp0eUZFSkMwUnloKzZwNVQwdi9EckU0MjhvUDM5cjF5?=
 =?utf-8?B?dzBSeUtpa0x4eVBEOTNtcW1POTlZSWNrU3lkSllQZ1libjE4R2RURHBKNzlB?=
 =?utf-8?B?ZHhPaWJQdGoxYTJQZitjWGorUW0zTDBPeHQyOEsvTXRBN2pZRzRKd054QnlO?=
 =?utf-8?B?OExwQjJodU1JTk43ekE4NHBPYzIyclVTNVhiOEZvcWc2bytUWm5YV2plak9t?=
 =?utf-8?B?TDJmOTRkR1dzeGdSQkRuSVczc2g1NWRNd2VnYWJvM3FPREpyejRDaHp1c0pY?=
 =?utf-8?B?NVNkWUZnd2tnQUJWL3d5ci9Ec3htUVdXdWhMNm51RVNmbzlYTWdkT3dnbFQz?=
 =?utf-8?B?YXZaL3FQdGgwdEZOUE40RXA1U2lVWERTNFk3VXQ4dDNuMTdXSVpVRGVLdGtB?=
 =?utf-8?B?KzdQMDd4Y2xPSnpSZzNKWDM4RGE3RmtzKzA1eFBvclpSVVlaaDhHZm54NGFu?=
 =?utf-8?B?cEtOOEFwQ2U0WGFuWjJ1T0NiaGVDM2QzRmNkcmZjc1ZEU0kvbm9OYjdoVTE2?=
 =?utf-8?B?Zjk1aEtpVVVMay9yOVV3WGV4Smt6Q05KYkJ5VDZMOVVzL3FXMjYybjZValVS?=
 =?utf-8?B?ZnU2Y3pvblROYUsyWE9jdmd0b0E3SVoybmcxYzNyVWs1Y2dqQUE0Q0RROHIz?=
 =?utf-8?B?T2FYZWExMmpyaldiOVJBOFAydXBsRVAxZW93YUlLeEdISkhCSnVvWUVtWFBm?=
 =?utf-8?B?S1ZiMGR1WFl4OG1aYk1OejNKakR5ZW82KzFtckVPOEUvQmlRVVVBNHNJVnlO?=
 =?utf-8?B?bExaWGppQ3o2SGxlb2hSK1hJTzg0M3RUb3MvdG9ySk9XTlY4RmN6QUs5cFNt?=
 =?utf-8?B?RmczL2VaeDZXeFRBZlBFSUhLN2ZweUtOVDFiZzUxWXFHazd4aXBSSzNnVHlL?=
 =?utf-8?B?MU5sektYeWtlLzQ4VUJ6WDVlTkxtbUVENWgwVnVxRFl0a1ZiMFZWYU1TRWI2?=
 =?utf-8?Q?A3aeSP?=
X-Microsoft-Antispam-Message-Info: M3xStOmvXrzxfKgtJCwdVaFEtdJncHYb6Xda6IbAvwGvsU5VMF1UUFDuRNiTlmZGGcXI5fJ2lV1VDLL4Sfmi6MJZCoJEcAdUgzfjOCi5YKAtzoiJQJBxHFb7A9RojTERhXMeRmheTn7bMOeWRr5TBicUQmxFnungp+18gV09hBCDgZ+pmlM8waSGMqmTQWOzz5PWkOf0PavA1wJBSNxgyj1ybLjZ3pyqACd9YsA0/QEn/BC0Hm7PGbLYsuwjR5vI/8hmb0kSh+FPEzS8MHgvKU+4iXiMfiH4WgfxeHX6gBSxThF6/GOMvcAHgR57zq/YrEjcyRaguyJdrCoflZoyBw==
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;6:L4t0cHZcUWMcxYO09tWGwM34QNDsL6z7ygw2riFSB3Tjh/UVxHqVa19AicGezPK7pfvVwphwx3/YtGDQyxuN+ZTfhQdkrNVEaWqf1AC1MUoYwrFIeiTDhMNi/r3fydcRsbMcsWuaEouHalUyxRy390lWZ6QvvcAoa5KUYgNUAvJ1OHEp5InOcQ4IkYD1v/MhT4/dacu8ZuXmLJIXbDmeLmgQZ0Mi55Tb/054xGZ5Z3m2Hjy2eM5o4BaPCI5XmqYjpLfJVRFZ2g4UzjGSVkNak25DEw6hUOrXVy3LfWdUulu/OlhG9XKkgKuFXwEGOVXnkLB0QOdwhmxdTPx4rVIdfM+qAIT6c9n9hyV/prplyk36GveLrrbHweucObccPBUeDKGmG0qM5urMvGZsZFQm7ED0Ywtc3x7lM9nCxGJ3E4zAtKy1wnyDVo6GDxUtKKFJ5tvPdNR6HNlup31FzA5kYQ==;5:YNIh+tA3TeibI0bkxQgOcYbU+VhBUqB6Jgpa9OZy5zLWnsq6rXZbCT0nN2sZ1ac0DIOlnhXPGiaegqCjEU8F/AFX5szBNlH01ZbS8OpFn9vRyJ6TlM0QrJep2eUVz/mrLcizvJjDepBc4t86WnCk+IfZMGKqD9O3Jq6n88PCR9Q=;24:r98amJOShh68peTOFsKCAdPW43I2uSM5aJQEZqeWyWvZnsNxC+aAE+E0RNoqBxPplsrG2rUro1E/r29PiTHsVhWfM0fBPerSy0S8TU7k5NU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0175;7:50T31X7x0ZuYmifPjSeHYi6rVcR2Q5aZCIGMr94L7TVdW49bkaKxIk1CrxuyuXfcn0egXWo3AmdpWQAgPx/0B5/6qrnZBiB/C7t/cPpNKyFIwAMSfNcxx9m97PjytAawO4bUjpDGDEaJzVxTm0dm48od5V0dn6Qj1hqGh2NWTCzgy2Patp2Xvjij4B7/w+b+tK+iPPsLOjhUejDqj58GjiZjw5oR3OZUShUo+Ba7tx9ygA07lu0QOWg/kxdZw7HF;20:yOnu1n3mx49RuOJZWcEa0kAqYAU4L9Owp/B7rxH/472jywMGRL76LR5/DW8xOyb0D/c373cSZdqdBJaWeN7Cs8ruisOWdSFoOsBEJyZvSLCXBCJGXgQhgVWKHzUOpNa0zci5NmdHcahXTukw6byYWwoviXeNBs6HXNpohbNutC6alrKj3t1wcPq18pSyyO31P3okavTsL655Z+Z+biQBC0JBhF0xxYA++MFLFeK1f9sx/N/jqsh63TMGMX9LcWE4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 16:42:27.2768 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3be274-abe8-475f-8bb3-08d5d6cccedb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0175
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/2018 3:27 AM, Lianbo Jiang wrote:
> In kdump mode, it will copy the device table of IOMMU from the old
> device table, which is encrypted when SME is enabled in the first
> kernel. So we must remap it in encrypted manner in order to be
> automatically decrypted when we read.
> 
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
> Some changes:
> 1. add some comments
> 2. clean compile warning.
> 
>  drivers/iommu/amd_iommu_init.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
> index 904c575..a20af4c 100644
> --- a/drivers/iommu/amd_iommu_init.c
> +++ b/drivers/iommu/amd_iommu_init.c
> @@ -889,11 +889,24 @@ static bool copy_device_table(void)
>  	}
>  
>  	old_devtb_phys = entry & PAGE_MASK;
> +
> +	/*
> +	 *  When sme enable in the first kernel, old_devtb_phys includes the
> +	 *  memory encryption mask(sme_me_mask), we must remove the memory
> +	 *  encryption mask to obtain the true physical address in kdump mode.
> +	 */
> +	if (mem_encrypt_active() && is_kdump_kernel())
> +		old_devtb_phys = __sme_clr(old_devtb_phys);
> +

You can probably just use "if (is_kdump_kernel())" here, since memory
encryption is either on in both the first and second kernel or off in
both the first and second kernel.  At which point __sme_clr() will do
the proper thing.

Actually, this needs to be done no matter what.  When doing either the
ioremap_encrypted() or the memremap(), the physical address should not
include the encryption bit/mask.

Thanks,
Tom

>  	if (old_devtb_phys >= 0x100000000ULL) {
>  		pr_err("The address of old device table is above 4G, not trustworthy!\n");
>  		return false;
>  	}
> -	old_devtb = memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);
> +	old_devtb = (mem_encrypt_active() && is_kdump_kernel())
> +		    ? (__force void *)ioremap_encrypted(old_devtb_phys,
> +							dev_table_size)
> +		    : memremap(old_devtb_phys, dev_table_size, MEMREMAP_WB);> +
>  	if (!old_devtb)
>  		return false;
>  
> 
