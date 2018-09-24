Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD4BECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE9921486
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="e9BxKD6g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE9921486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbeIXNMq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:12:46 -0400
Received: from mail-eopbgr80105.outbound.protection.outlook.com ([40.107.8.105]:3392
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726061AbeIXNMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:12:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2uKBySU1P76kT3gmyWvhpVVqlqi9qk/kZcrgEBDi4A=;
 b=e9BxKD6g3LRU9Tmg9EhvA64d/pyfH8VQqjPm7DJu6czv6ZbMVzfsirHpfKXfuDZw5lBvO4gp0cNxd8iUx5Ont50zknUQl+HJGaLGQ9/yZVYf7Gsjbdsxr44cSF+DtcTHbYyYBtXYJwnpS/9ToipV14OyDSo41wql/+vlQWzD+s0=
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2458.eurprd02.prod.outlook.com (2603:10a6:3:81::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Mon, 24 Sep 2018 07:11:59 +0000
In-Reply-To: 
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: Re: [GIT PULL] UBIFS fixes for 4.19-rc4
Organization: Axentia Technologies AB
Message-ID: <2bdd37c6-17af-e216-d865-fad2c6ff6dae@axentia.se>
Date:   Mon, 24 Sep 2018 09:11:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0155.eurprd06.prod.outlook.com
 (2603:10a6:7:16::42) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 861f6aa9-16d0-46e6-6aa2-08d621ed04ea
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:jDHJper6WFsen58jSjD7apfDkg2o2JL204oiRKTfCosf8YipXk69EYLyL/agd+QDcnHM7qhcXVq+bJOrND1paSe/l93wYfspQD7paTbe6zhMprxKlE2iLQGjm3gXscjnBHXcoc8BnZ8SXsSIfaTQmPh/PrD4LgeU6pf1yfnSQC8cAE5YGNBZo2WTfrHAytBCmTq/kfDWGQ+xPLdp8wphm5HaVRTxcwaH4pEO+HIovAJH5wvU0GeWGTcxLfe4BrUD;25:BkSjZQotSKqxQuaFqY05UTI+v3BueyxD97FvJTwJ0Cw3grJbwvPTl/xvadsnQqPkLZE6/uHhZkj/mKlE6cxuxj2qBWTkQw63pkV0mZWVpDyS+9MGQ7k33GNN6+c1QGlh98a3BGdNn99qnxafyJhEKtFbAB3LCKliq9ZBlMk1cy0uSxnvegpyE3hr0t+oVR14R2GYKiMbKLi7tdpEcv8xYJdqilO8E1TtPRqqrjaRP9AiM63JwiBOrN99qsQ7BmDHxzDC2l5o7TvhpxsPFI9RdnP0KugsAjpsOegaxmz5E47xcZwugDkpYx+2UNfxHzi4Rmm8+c/D50g15g/w8qORbA==;31:9o8nmJvFgc3mNTBI25WWKNgoE0+l4xETl6SLosy0jBLwP3fIVYej1cZMFYGWc0hUGePn+S3+c7hoUqxXWQC4Zd+VTBJE9/x4MWKlhdT3OgvLLktUv1ohmOCuLegxuQO1+Ija9DYvEcDvAIb6goDoN42KsvJGbHKaLqJ2X05bSBg+qAkzqftmoP4WvsUfymA+LMTrFjYCKTOXsbuGnS68YuD+xr1UrjCvqGKWtOW87RY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <HE1PR0201MB245835756F871B6FA094B87BBC170@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(52105095)(3002001)(93006095)(93001095)(149066)(150027)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6043046)(201708071742011)(7699051)(76991041);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:nEA7zydaGWNBxPYf2vg7NxbjSdLY+81l/ZxcAbcXQ2GRTsZhLEIfqYsWIot6MbMECtzBA4J3cZSCXowU06D1+8aFTy+9FNWzLKnilvTZWALOq6GZ5PHEkH19ZopiS6jRc3R6a7PeAnv3a0LiDzbeBwQAqwxmEZtzM/TWMpc28sCwHgVEp5/uLJbq4G2RN8AmI+Dj8GizTi/pYNErbMzPgGyMjM19+xR1p+y8Q1NbRkgaaaTHq/oEAsVaJz0taiWc5j1XDFR7T2ORcQj6gI5xSQ==
X-Forefront-PRVS: 0805EC9467
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(39830400003)(136003)(396003)(199004)(189003)(105586002)(26005)(106356001)(65956001)(66066001)(65806001)(486006)(956004)(476003)(2616005)(6486002)(31686004)(186003)(16526019)(77096007)(229853002)(50466002)(53936002)(97736004)(4326008)(6916009)(25786009)(3846002)(6116002)(36756003)(230700001)(508600001)(64126003)(6246003)(68736007)(36916002)(23676004)(2906002)(2486003)(52146003)(52116002)(6666003)(117156002)(16576012)(58126008)(316002)(54906003)(31696002)(65826007)(5660300001)(575784001)(74482002)(86362001)(305945005)(47776003)(7736002)(8676002)(386003)(8936002)(3260700006)(81156014)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6SzRpdUx5bndvVWsyVmJiWkR2YkxMemdW?=
 =?utf-8?B?Mk10cFF2ZjlNSXd3Mm5JbDg3QkJ5NXVnZ3hYVDVyblF5dzcyVWRGWHpwRmkv?=
 =?utf-8?B?c010Q3RlUTN1TmlRUHNJbDFMeUFLeVArUnJVdUpIa1NTNmcxd0Y0T0hqa01H?=
 =?utf-8?B?L2VpNjB6ZDg1amZMV2pZMGhoaHloTTlFU0RValRMeHVtYndtYnRNSWtJTC93?=
 =?utf-8?B?N2NRTFpCelFvMmozYVRESFpoV0JDYkdIM2Q2U24xREpwSnQ5ZFdyL1Q3TXhH?=
 =?utf-8?B?WDU0LzUyN1ZMNUUxMFZNcE03RXNULzlkSEJ4dFpvajJ2RTQwcmsvTjJ5VjY5?=
 =?utf-8?B?V0RTMURaRHFlcWFKQU5qbXdCWktOUE16TVJnS0JHcnFhNG51c1FaRHVObjV4?=
 =?utf-8?B?OVF6NzZlMkFzT1RXRi9UcVhVL3F1akhxbVZTTjJYc2tlWXhia0lya0RHVkhX?=
 =?utf-8?B?RURuT0QrMFZGWU1VZGRWaWtuRnFTNWQrYTRuSVJhaXNsNFczTU91Qnl6UEtF?=
 =?utf-8?B?UWxpc0RPNC9Ncmw0Z2J1NjJxTmdWd1ZqQkNWYm1JL0kzS0FGTEt4UGRZUURE?=
 =?utf-8?B?bWRncmNSaXlubUVLSmpyNFh2a0VSSEVablM0ZjBkNUpxSllCQTNVMHNobC9s?=
 =?utf-8?B?MG1UbHcxdm1nbTFKRlJqdmJJWXN5NEpyU0RKei9WRHhvYnFndDR1QjB1dC94?=
 =?utf-8?B?cC9vL2ZJay92Y2lkMWdENEZKYlNZS2tsWFU2NWFSWi9WOTZCYWJZNkxLdzVC?=
 =?utf-8?B?UzhlcEdOK1pqWnFoWjN0RnRiUnNwK1Q0aHZLYk5Dd2F4dFQvbFNYZk1nbVZz?=
 =?utf-8?B?WU03KzhGMWd2RnFUc000am5peEo2Ujk5TlRHbDhHYnVJd3VHV0NzQ29qSndU?=
 =?utf-8?B?ck53TUJHanpMT1pTS1ViL1JWMS9lSnV0WEluQ3FlVGZxQzZBV1UyZ3kzMTlY?=
 =?utf-8?B?NkVhRGVxQ2U0T2pVNU9waVRKYmFLZ284dmRmSEY2V0ZIbVVBenI2elViamJj?=
 =?utf-8?B?bzRweC9JNVBacytxUkZCYmI3N3ZnQmZYUGtadVp1SmxGSm1GRlR0OEN1eTlT?=
 =?utf-8?B?TmlzRVhMb0VFS2J3b0J3blFXdEswNEF2dmZXNWI5b0g2Nmx6K09WMkpESmxj?=
 =?utf-8?B?dUNxTk5RbXlicjlYSkk2b1dxdWFqblhYcS9KbGt6UGdkNzJtR2ZoUFJQTHVL?=
 =?utf-8?B?TkZka3pnS2V0RnlpMFFSK2NKNlQ3azJ2UVc5ZGpwd2NQd2NBckw0ZDJrL2ds?=
 =?utf-8?B?eWJDbDhtZXNpZHA4bnZrL09lZUFyRWZaTWtJcXg5cTNPZjczb2VGZ25rTGwy?=
 =?utf-8?B?eFh2M20zREUzZEJWeHZqM05Xems5VTBLT3FWYml0ZWlaTTlPV3JlMlpRNm9z?=
 =?utf-8?B?UE8zc2ljZ09HSG1FNTNleEI4dGJoS2hDV2N1VDRMRXI3dzYrdHFac3pVUnp5?=
 =?utf-8?B?RmZEV3NIbVdsL2xYYXhOMkVMTzdtVFd5ZS9LaTE5YWpkbWFZSERFc2w3R3R6?=
 =?utf-8?B?cnBjYXgzRVhzL1BTUWxYNlpid0VjV3NLVmxPazJxYzZqTGNoSW9xOEEyZEFm?=
 =?utf-8?B?bkVCcDluYkhTRzR5Qkl6UjUxTkM1NXZmeW5pOXlNS0prdzlzL1FZa0hyN0JU?=
 =?utf-8?B?andpakVlYzUwVjRqTTc0eFJFeDd1WGtLWWtkVlA0OGVzeUJwdXc3SmtsRHBC?=
 =?utf-8?B?MnVaMUhPREVmeUcrWlhmV3lLais0QnA0K0k1OWxoMmx3UmllSkhkRjJwZE9u?=
 =?utf-8?B?V2YxZGQzT1UzcEExK1RrWU1qWXBMUCtwVlo0SW1rQnZuZmhta2ppSFliY3Fj?=
 =?utf-8?B?eGZSVjM3N0hodlMvZk1Bbjg4U1dPUnhmK1FkVms4SzVsdlNKeWgwdFBSVXVk?=
 =?utf-8?B?Slh6YWM5c3R3Tjh6SkdVYVdPdTFRNW5vaEN5TWJWRTZYcDVOUEZYRGNXS2tV?=
 =?utf-8?B?R3NvT24rRnhhZ3p4VEtsNjNjV0czcGVQRUlvSDgrK2J2WWdZL2lKdTQ4YjF1?=
 =?utf-8?B?VlM3NUlINUQva0QrczJ3QytkZW5HV0lBSk8xZlB3PT0=?=
X-Microsoft-Antispam-Message-Info: e7AvNsLu88xqDL7B10ra9voU4f2InOh4dkUv+qWFLIThvNXug/LUcsUl2mD8bS3VndcVmTXBUmbstTsrPCiJ1C3fh/tN3m9pwgIg5Ivune511nEyN7XFDgJeZVx6w+rKuTmpyBsggkln+SOiVT+l4CXXc+cggK2CKQ/UqcHFWcQG42NSD+LkgMrhj9/yvlisy47RNN8sRrHDOFmeulvGGp12RLqix7DifIZAwJPTvKEB7CKc/L9Gs+FKJDWoBOR/QTarQL8WRP2Y05P7YmiXIkMJ7pFBxjrDfPceiway/xHLPh4svtE3Ws02JyALM/FdmnT3c1C4NJKYQEcwzMW+xSpqkXo/3FFy9XzcxsM19ns=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:mtUJn6uaQFU9FYLOtqBD4bJqPPsPmofE4kr9IRd1+Csv+4ZieUBgNYCVHSUf391KCatkggfAcV8BQQ5OALxL0t/yLEO630VBcAgf0fPU9qOb24xluRiDSgCZIbXJt7hYbz4injQ+UTnYDSceU1Z/wCHVzj9O3UZOzj0h9aupSrVwXcljwbD6OOS0ztvqlJFDfkJB3GmYRs7zzrhEyJTnwP4Pnq05BhDCZX9Wd7kn7dd1fJ7XH4djTm3l/hSwEWyXgHvn8HzzoIDhgwQR+HJKeosW0ENbcug4BHy6Tw0DOonYMmyfbvx69esasw+BuvgSEFFfz8L0u9xpnxhpJ8aKeeZFImv1hm83U3Cje/r4T20SBN3KpqfpzOLRKs6o6sEDUYM0FEd8uu8jz5ghCBGXvOv1dxGTM4D80n+dwDfO6vgVerVDOOI0O0AVx6WTXhQD2zfpkqUxbL1aHdx9UeTc7g==;5:UedxGIQmDbHB8/zJj+SQDprN5J46dNz3r7QsfX4/ub3+NA+oFmGe78zs1X6FMGBUp7qiWi62AGYwQPpFjIcuhNwjhsTsUVvH/3y8XZAaUMrFWxi3MNEixhtRTiPHvX5z65xysdPTZJzIChCjZ5/2R1rWyqWNTLAuLz6uXXF9D0c=;7:AaQDmU4jECJjOloXwg3p4dlU53Z/iUSIwMG0DwVNAU94zloe9+t69C2+xgSRqkRsdCJ0kLlXSd4YlUY6FfauvLWJmojiGl15IMAVHouGD5bT3JXOVG96kGeBgld8yYutGhcMtrfalP8x9FKYNISdw1iGAkbvBFJWD+IsHH/RsgA4hhnugoq1KhBSfnOdGwYI2kFv5F96Hbpfewz09pvbBLtYtGb1jcKgSAU1Jl6InkLP+r/K9JuKHSM5Mv0q4rWX
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2018 07:11:59.1499 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 861f6aa9-16d0-46e6-6aa2-08d621ed04ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fredags, den 21 september 2018, 15:53:42 CEST skrev Greg KH:
> On Fri, Sep 21, 2018 at 11:33:15AM +0200, Richard Weinberger wrote:
>> Greg,
>> 
>> The following changes since commit ae596de1a0c8c2c924dc99d23c026259372ab234:
>> 
>>   Compiler Attributes: naked can be shared (2018-09-20 15:23:58 +0200)
> 
> Wow, bold move, new patches with less than 24 hours in your tree.  That
> means linux-next didn't see them :(
> 
>> are available in the Git repository at:
>> 
>>   git://git.infradead.org/linux-ubifs.git tags/upstream-4.19-rc4
> 
> Now pulled, but really, don't you think that they should at least go
> through 0-day first?  Maybe no one runs ubifs on mainline kernels...

FWIW, we do...

Cheers,
Peter

