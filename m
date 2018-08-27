Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E170AC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B50208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 22:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n5oS9w8s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B50208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbeH1Ca5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 22:30:57 -0400
Received: from mail-by2nam01on0058.outbound.protection.outlook.com ([104.47.34.58]:51814
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726994AbeH1Ca5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 22:30:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzP76qKB0BKyQnH2kQYg7Nh6+/WK/IuTFRmnhcGgPac=;
 b=n5oS9w8syJpUiz1YVztQZI/0yqRRoVwP3rFAErjv5R/FaQFye9t8RxMON6YHbbQgOoDG54sNF/Ms2t0f1V7whsFv3prPuwyGTj8uDaPUU+KuvZFx2xuUSHgngWss8R8CManKwmFz5ZBvGSGP7tZR718N78iJoJqydaX/ow0Tlvw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from [10.236.18.82] (165.204.77.1) by
 DM2PR12MB0172.namprd12.prod.outlook.com (2a01:111:e400:50ce::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Mon, 27 Aug
 2018 22:12:01 +0000
Subject: Re: [PATCH 1/2] x86/mm: add .data..decrypted section to hold shared
 variables
To:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1535369080-20290-1-git-send-email-brijesh.singh@amd.com>
 <1535369080-20290-2-git-send-email-brijesh.singh@amd.com>
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
Message-ID: <8c7250e6-c7f6-cfcd-08f8-fd35a829f032@amd.com>
Date:   Mon, 27 Aug 2018 17:11:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1535369080-20290-2-git-send-email-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: CY4PR13CA0091.namprd13.prod.outlook.com
 (2603:10b6:903:152::29) To DM2PR12MB0172.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 989b635c-2ea8-462a-f642-08d60c6a1d67
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0172;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;3:DNuZvVRSihqgsBki3nyF7ViIp0o1GF6oHr38oHYPwMR4RpOnpvGVwgpXV4to+v3NZJDtR5bA4/satl+ogaU2zBN9HslnCVGYBfjmNpr4FqWWHzlLa1R59aVEd2ZbzpQjdsGfEu3KJ2d2yo+iOvmd0k9yC+ipX7ELmeZGe/hJYc5QFF9l59DtDJxskdwTZI7q/9ZQnsL4TBYR4waHbeNLrhx+M6RUQ4sMcP3EwmqRP+NSWNRFtasH3Pf6qkfDapda;25:s1Elm6CkB5GGmpg6m31zNbBOeEdiOaiR+PDs9vckZr7wG4ks50SBf/88m3DCB8rHZJRATa8BgePQ0+VcYhwpha5y2S9RJKdiDVG11i1wgwmrQC6BQotTgTtt5QjuKXkEnbwvxoHC4U5HMBGI/azNJaKvSmPBW1//P9SNC/yyDYlUZfY2u+10IWl+7mP3ocs6WIQ8cfVDcSm0tw1MxmfCtzjZ8BqbqrPlP+uiFZiVCQ+wOR9i5ccfhZoX0L+uZ47ahf7xx5KpzEHI+EXvBYuzplV5hMYKv4Ap99MKL0fY2BOtYsUEux8DmkL/WidaqhLH2KJITxSt54VmljjMzFUZOw==;31:PB5TTqeksCp33vQKSRTkqVGFkXDwhbGQnFGgtEuwpS7V0SDWJYyxv1LeNqcBxdbaNXu9bxXs7q4vYNBMaJsKUfbxWOlW9E6Ss6Mw2x9BtHZJUP463NKPSM7c+hd5XsWI/+RqLGExGn5P3Rx/PkGFzAIcA7OU3s3SFMZQceqA9G1jXV2mFs/LkVL2O/eulbWeMPC/6wDjqrDSTFfeTtWY2aRFzkOLwbz4WXeYHETkzhA=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0172:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;20:O9nEG7MHO+A0Bg8CnNpBMBeNi9jmSVHh/fnfCJOp/xsXQ0ihe+WXZSYCLQqcFKdEfXcaNSamVzsN18DAPPH3vrej2mgYLTpAko+hil7BS6/ZogG6+jQ/CDLW98alYNYxW6qy9rM/9QlhTDn3AToBJML08vLL4dgKyyc6g3HSySb122tOGMmGSKQGUKBYgMojcMF1GZdiv8qUoC/dJ5NtZYS4F40V6/M22WvN2wIyy3N8fiXU3UYC69kPz8qhsBZCR6f+5ihrHfMMF75Zq8yVa+ls55N44hbzpY6OSE3ircNRg3qEa4Pj5JN1zfVA3c+OlAlX8eKUYFRnr+0l0nZYq47cqtGUnhJRmiShr4Qmyi8FSMIzMUNobMXiyK96JAaV1OfGAh1hClELSLQ+3kcYNW6AJ+qCrC+P/SMru/hJqABnowD2dmXdVWprZEc49XqT4OcLPiPUdXsgzGmjjMY7ZiKjhEMPQ9JEsz+oD9HHfE2y9FvHTG2lJFWUu6LpFX6S;4:TNX4vtiLjB0H5dSy3JjOIJpxYtATvKcK97YrPyLBwcG297wyrml4qZ/cwimGCbnHSUeVbCy2GY/qJamf0GNMzTeiPEiDP/cUkxplu+nXGppy6kNEVpnFGB6ZPQbYpHvvdJdWaZhQGGhPdEmUrTcD9uznuZfsn6oLLWnAEcOnHdL5uux5nWEtdeml5x9Uv88+hvrnJcSslSTOZriKLo0QtTP3+0ubpiBSJkB3f6Dl83DZVSltNCOxnNQLtR/k3O7QlmKZf0wHjapdwX+vflP/mPr05NDdKNDhTmXSpz40HQbUhmsfyLXIwUUftlHGNQ59A9ArqpMjt0yLKlVjtu/2eZB247fGgQWl2L2KhbkSWMkPL4yKeEfWGVF9LTaUDi6hKWUql6PVt2fv7RRmIbIApA==
X-Microsoft-Antispam-PRVS: <DM2PR12MB0172DDF7F1E64B5DF16677D9EC0B0@DM2PR12MB0172.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(163750095850)(228905959029699);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:DM2PR12MB0172;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0172;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(386003)(50466002)(956004)(11346002)(446003)(476003)(2616005)(53546011)(186003)(77096007)(26005)(16526019)(76176011)(64126003)(486006)(58126008)(16576012)(316002)(54906003)(7736002)(305945005)(36756003)(8676002)(229853002)(68736007)(72206003)(6486002)(2870700001)(2906002)(5660300001)(65826007)(6666003)(478600001)(23676004)(52146003)(52116002)(2486003)(14444005)(8936002)(25786009)(65956001)(81166006)(81156014)(65806001)(86362001)(575784001)(53936002)(97736004)(31686004)(6116002)(3846002)(4326008)(7416002)(31696002)(66066001)(6246003)(106356001)(105586002)(47776003)(142923001)(101420200001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0172;H:[10.236.18.82];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcyOzIzOm9qM3FuSVRIdm10bWhYSGJGckhxSjRVcDJz?=
 =?utf-8?B?YkF2NURaOUxRaFNHY3hXWXZHeXhGV0FtL2JPUWZQQlZJVlJHZUZITkZsTGxB?=
 =?utf-8?B?RXM5aTUveWFiV0RtalJ0K3BIK2M2Z3pNalorV3hJdm9VUGlzL3l2ejhFOUlJ?=
 =?utf-8?B?ZVhXa0NnaHZxVUVCU1RnRjZJMzhvTUNGSTRoMjFkclhzRkxTUno5RDZJZVk3?=
 =?utf-8?B?T2NLQzArMHd0NjMzZWZaMmhiL05lb1h4dEdremlhL1V0L2hVTnJ6Ukp5WUp5?=
 =?utf-8?B?eFpLQnFKZW56dzJwMUNKbzdlb2FoeE5XbDZKNDc4WTdHUW8xUE1aRGpISUww?=
 =?utf-8?B?TnZXZVFQUTBpSXk2aEc0WHdGZnBhVHJWZUQ4aDRnQmJ0SCtvVmN2SWcvWnZQ?=
 =?utf-8?B?b21Fa2RCUEY0a0J2eXdUNmUzRjh6NjV3aXAzU2NMUWhiSWZHei9QZ1Y4WVdm?=
 =?utf-8?B?QVpwRDJ0NTlTRERSTTRVKzJ5dzNRWDVNZHRoaFdEQitQRHVtVVdwU1Jkc3d6?=
 =?utf-8?B?S1J5K00yZ3IzUWVsMWZ2QllsSEFXM1EzdlFLd3ZPWk1FY0NhY29PT1g5ZFZN?=
 =?utf-8?B?WStpL3EwMG5rVDVwRitFSFR0WklHbjNKNm1QVkF3Q2RQR1F5NnRYOUNkMGFr?=
 =?utf-8?B?ZnBjN2lKdWNXc09peGw1ak0xWlBxb2lSVzNvNkZuc1o1YlN6ZGgzS2NHRk50?=
 =?utf-8?B?OHBUTHRuTVhoNFJKTklWVkQ3d1AvbGxwTXcrTFE5M3JxMkJOQStFRTUvT1I5?=
 =?utf-8?B?TDdZNEY0TGhqdVc0MHlNQmp6RWV1RkNiOEVPeVoweWhtTjBPMEZHVjFid1k1?=
 =?utf-8?B?QUdjSStIV3F3ZzZtQ0s2MXYzNVNZd2NnbHllMGxGY0MzSVpvWVg5STBTMjU0?=
 =?utf-8?B?ZVBjVEJkb1BucTVHMC93MTg2enlCell6dGY2YlJ4QnR6dXVhSmYzMm9hczV6?=
 =?utf-8?B?bHk0NFAwR2FsSkQ0eFdlcTRRWW41U2tVWlZiejNkM3pEUHpkN1JweFZCYi9a?=
 =?utf-8?B?aDh2eXg4a2g0UU5GazlHbVhudERZdUpyUHRHWlV2QWVyeTdMTmNtVUJ0UUNP?=
 =?utf-8?B?WUphcjJGM3h6aGtXQmcxNDJOUW1vMmhBRzRHNDhUM1RjajhpNlFLRmlCb2pB?=
 =?utf-8?B?ZDB1NVBPeXlTRUNnZHlpR2I0a3A0R3dKelB3VHM4ZDRWZng1NDhnbnJuVzkx?=
 =?utf-8?B?Q0lOaklOVlNVYjFkMmlwTHVJcUh3MVBlNzRrLzVWeDVjbFl0ZWRadUswcXBG?=
 =?utf-8?B?LytEVFdwN0tvUlVrYktWcFQwczlMeEpvMlBiODQrbk9lSlpNS0ZzTW0yblY5?=
 =?utf-8?B?aXhZTmd0L1FucWkvUVQ0eXNIUmtXbXE2czlRMSswZVYwTDRCOEVFSTZnMVM3?=
 =?utf-8?B?ZGZoMjV5eEgxTkZyQjVpMkVtWk5sUmlBRWNDcjJWTVB4T0RJaXVpU1JjRXFr?=
 =?utf-8?B?MkxjWjJxZUkyRUpjbDNSZ0plbVhVc3FqbVVpUkhUVnl0MzhEZk1qMVJReFpk?=
 =?utf-8?B?ODNZNDJEUW5PZjNibWROM2dpOWNSNEhkajFjNVQ3SzJDVHZFTjc5YnRFbjJT?=
 =?utf-8?B?RjJ0OXpwNzRYc0pvbWhQbDUrM0s5UGkrSGRTazU1TUdkQ01WZlVLRzBSK2lq?=
 =?utf-8?B?K2lnN1d4aXNMT3BkcXMzQUJqQmVvanlxRE9STjYyVktDd3dFWXJGaUY3dDlj?=
 =?utf-8?B?QTYySHB0akNBOXBiSi9LUmRkL2NVb2lQRE1ESnVnQ1ZQbUgzRVBlQm5jcVdv?=
 =?utf-8?B?SlpZMkovTjl0TEdQYytkRWxCOFZoUko4UU4wdTVYcGdGdDV5M0poK2V6RzBh?=
 =?utf-8?B?M21lVTdOSHM0eWhwL2lYZ2p2ZzdxK0VKQmZ1Nkt1d2FubEIrWDVPZ0N1OWZh?=
 =?utf-8?B?WC9wZTE5aHVMa2V1T2tjNVpzTnAxS3BPY0xyRjdvS1B1Umd0UlBXNUZUQXJQ?=
 =?utf-8?B?TWFHczF3KzRVOEFhb2ZZV3gwYjBza2tBU0MyUmQxbVI4Q3JaZFFlYTNVL3Mw?=
 =?utf-8?B?QXJJUE5BT1dodGcyUEV6QjRUODRUMTM4Ky90WnpKM3lkVUtkNnJKSUJsY1NI?=
 =?utf-8?B?eTB4bFlhTk9QZVpnZGFJaERvWHpaT0VDU25iZWtUMlA3ZjEzT1hUYnBFVUxN?=
 =?utf-8?B?R1E9PQ==?=
X-Microsoft-Antispam-Message-Info: xTPY9tfm5DzygQjdmUcBhj0IKXAEDtYORFlU7WPvUq7C6a0gdakRkbp5wmXt632H/+msR1x5mzRqhrBcfaFgm1a7t/dVDiZRPBHc/eL2rj54j8X5SLkl6tYlXYWzrcKhTjGjQWftDbpSCgmSK4UtHUnJsSGduVb+5tcYYZCWROSArUhVLl/YKK54vMHnRbYD/ShNqQmEKZkhJ2CP3nDkcHSJMsHGmYQJwlxF0zCBS8dEMmi+JCcv7BEi/EdJhPkzjNMUFwccxMBKZPcygM5syLByKm6q29MwoDISdYlgZUQGOD+swijy1uH0pkU3e5INryky8w2z9gf3aag9XnSdUMQXGXHiBYoYB8d4XIdIia8=
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;6:CuSGTG2IfgdtjOx7q7YQbzc3VlYWt9xHelLapmVFbEvJn1HhepmXP1zlvpfZ4qEtjMmYWyPBLGzcxw2L8i1cRa8c7M4oNASQo/PGv1F6SIHfm3CD+TaHBk6m/g877aI7R6BAt20sn7yDlCkPsPFAWLW7wzWEEG3zkkl8hsJ6tbS02FxP87Fi7657NRYJoHzvB/yw8uMgMySoieQtKGblcBuQjRpH93Tv6XtJonmY8SOMiNfACTs4xinN6dMob2EukH9NGVnH1NAf2L19SGqNWn2MBzpe+IRnZDwfh5xQNyAFKYoAOWumhUnsKiiEjsOhu/VHsADw7zxpj2Kdg/gTXxYRgoTfXGT/Avzzpo9uQKLTbl7aehjCLoR/t/UXyg+VIcZbbQC2KUBV5BoNWw45hzBLX0r+hXZy7L1jChNrlAtvprGnhJGtc2CEt0HhX+kOnye0cFLelBAuve+YlhjpTQ==;5:ORs5W6wWB2D85qZjyHmE9s5tRzHhjeJ9sL9slUNZetYq+weT0YorHMlgb8UaEuOc6745p834ucFJe1WdpHEUCLiSXyqqnn1wRoQDvgJGE+RypjHb9VeqL9Y9OJ/eJ77XDN03OXrcKmb00zYifuztBz+oL4XogQ/vRhh4fMwAe98=;7:XXCD1Y9nm9nSI6x2XyZKfgN5xC2cneaO611zBbwUoY428rAwcVCkX7jPouCiVtpTaixPvLhIxvOWu1R5XUQXxnIArlWhau3pB2ZQnGA/uX6w/Q4KGWkxCGvKYE7sKeCCv+arZSs6a09k4zXTAqn088pVJ8J636iIZSruyad5ywPlCtCt7rqm6k7ZrFOL8nv/50bs1YNt53SDPlnYWKklTkGdn3fgWbfCYsoEa9QBX0DHAmSteQ8hlLwniu5tHs9T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0172;20:BgxIGck7o2dOVzbjFbHQTYlv6vUNidn5Cq5LqzoSU+D/cWclOQCHh0htfY6ENUB6Jf0cb1aunz+KCLw2UjNqQokXPvPZzNmwfqvhg26vM1jA4OF2LS0YC/zE+P7iFV4PH7rcOjhKini/IzLtpkkl4js+mffGRv9plw00JZuEYtWF5LW1UHK98pQ4bi6J8RBPebCcqP2LnehyaQdJC4tI+eoQypZpKCCn7sZWjmCKXNva1WR+OAtby8nMC5Lfqx8g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 22:12:01.1110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 989b635c-2ea8-462a-f642-08d60c6a1d67
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27/2018 06:24 AM, Brijesh Singh wrote:
> kvmclock defines few static variables which are shared with hypervisor
> during the kvmclock initialization.
> 
> When SEV is active, memory is encrypted with a guest-specific key, and
> if guest OS wants to share the memory region with hypervisor then it must
> clear the C-bit before sharing it.
> 
> The '__decrypted' can be used to define a shared variables; the variables
> will be put in the .data.decryption section. This section is mapped with
> C=0 early in the boot, we also ensure that the initialized values are
> updated to match with C=0 (i.e peform an in-place decryption). The
> .data..decrypted section is PMD aligned and sized so that we avoid the
> need for spliting the pages when map with C=0.

This should probably be broken into a few smaller patches.  Maybe a
patch that adds the section and the attribute, a patch that re-arranges
the mapping setup and then the in-place decryption and clearing of the
encryption bit for the area.

> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> Fixes: 368a540e0232 ("x86/kvmclock: Remove memblock dependency")
> Cc: stable@vger.kernel.org
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: kvm@vger.kernel.org
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> Cc: "Radim Krčmář" <rkrcmar@redhat.com>
> ---
>  arch/x86/include/asm/mem_encrypt.h |   4 +
>  arch/x86/kernel/head64.c           |  12 ++
>  arch/x86/kernel/vmlinux.lds.S      |  18 +++
>  arch/x86/mm/mem_encrypt_identity.c | 220 +++++++++++++++++++++++++++----------
>  4 files changed, 197 insertions(+), 57 deletions(-)
> 
> diff --git a/arch/x86/include/asm/mem_encrypt.h b/arch/x86/include/asm/mem_encrypt.h
> index c064383..3f7d9d3 100644
> --- a/arch/x86/include/asm/mem_encrypt.h
> +++ b/arch/x86/include/asm/mem_encrypt.h
> @@ -52,6 +52,8 @@ void __init mem_encrypt_init(void);
>  bool sme_active(void);
>  bool sev_active(void);
>  
> +#define __decrypted __attribute__((__section__(".data..decrypted")))
> +
>  #else	/* !CONFIG_AMD_MEM_ENCRYPT */
>  
>  #define sme_me_mask	0ULL
> @@ -77,6 +79,8 @@ early_set_memory_decrypted(unsigned long vaddr, unsigned long size) { return 0;
>  static inline int __init
>  early_set_memory_encrypted(unsigned long vaddr, unsigned long size) { return 0; }
>  
> +#define __decrypted
> +
>  #endif	/* CONFIG_AMD_MEM_ENCRYPT */
>  
>  /*
> diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
> index 8047379..6a18297 100644
> --- a/arch/x86/kernel/head64.c
> +++ b/arch/x86/kernel/head64.c
> @@ -43,6 +43,9 @@ extern pmd_t early_dynamic_pgts[EARLY_DYNAMIC_PAGE_TABLES][PTRS_PER_PMD];
>  static unsigned int __initdata next_early_pgt;
>  pmdval_t early_pmd_flags = __PAGE_KERNEL_LARGE & ~(_PAGE_GLOBAL | _PAGE_NX);
>  
> +/* To clear memory encryption mask from the decrypted section */
> +extern char __start_data_decrypted[], __end_data_decrypted[];
> +

Should find a header for these rather than defining them here.

>  #ifdef CONFIG_X86_5LEVEL
>  unsigned int __pgtable_l5_enabled __ro_after_init;
>  unsigned int pgdir_shift __ro_after_init = 39;
> @@ -112,6 +115,7 @@ static bool __head check_la57_support(unsigned long physaddr)
>  unsigned long __head __startup_64(unsigned long physaddr,
>  				  struct boot_params *bp)
>  {
> +	unsigned long vaddr, vaddr_end;
>  	unsigned long load_delta, *p;
>  	unsigned long pgtable_flags;
>  	pgdval_t *pgd;
> @@ -234,6 +238,14 @@ unsigned long __head __startup_64(unsigned long physaddr,
>  	/* Encrypt the kernel and related (if SME is active) */
>  	sme_encrypt_kernel(bp);
>  
> +	/* Clear the memory encryption mask from the decrypted section */
> +	vaddr = (unsigned long)__start_data_decrypted;
> +	vaddr_end = (unsigned long)__end_data_decrypted;
> +	for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
> +		i = pmd_index(vaddr);
> +		pmd[i] -= sme_get_me_mask();
> +	}
> +
>  	/*
>  	 * Return the SME encryption mask (if SME is active) to be used as a
>  	 * modifier for the initial pgdir entry programmed into CR3.
> diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> index 8bde0a4..511b875 100644
> --- a/arch/x86/kernel/vmlinux.lds.S
> +++ b/arch/x86/kernel/vmlinux.lds.S
> @@ -89,6 +89,22 @@ PHDRS {
>  	note PT_NOTE FLAGS(0);          /* ___ */
>  }
>  
> +/*
> + * This section contains data which will be mapped as decrypted. Memory
> + * encryption operates on a page basis. But we make this section a pmd
> + * aligned to avoid spliting the pages while mapping the section early.
> + *
> + * Note: We use a separate section so that only this section gets
> + * decrypted to avoid exposing more than we wish.
> + */
> +#define DATA_DECRYPTED_SECTION						\
> +	. = ALIGN(PMD_SIZE);						\
> +	__start_data_decrypted = .;					\
> +	*(.data..decrypted);						\
> +	__end_data_decrypted = .;					\
> +	. = ALIGN(PMD_SIZE);						\
> +
> +
>  SECTIONS
>  {
>  #ifdef CONFIG_X86_32
> @@ -171,6 +187,8 @@ SECTIONS
>  		/* rarely changed data like cpu maps */
>  		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
>  
> +		DATA_DECRYPTED_SECTION
> +
>  		/* End of data section */
>  		_edata = .;
>  	} :data
> diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
> index 7ae3686..ccf6e2b 100644
> --- a/arch/x86/mm/mem_encrypt_identity.c
> +++ b/arch/x86/mm/mem_encrypt_identity.c
> @@ -59,6 +59,8 @@
>  				 (_PAGE_PAT | _PAGE_PWT))
>  
>  #define PTE_FLAGS_ENC		(PTE_FLAGS | _PAGE_ENC)
> +#define PTE_FLAGS_ENC_WP	((PTE_FLAGS_ENC & ~_PAGE_CACHE_MASK) | \
> +				 (_PAGE_PAT | _PAGE_PWT))
>  
>  struct sme_populate_pgd_data {
>  	void    *pgtable_area;
> @@ -72,10 +74,28 @@ struct sme_populate_pgd_data {
>  	unsigned long vaddr_end;
>  };
>  
> +struct sme_workarea_data {
> +	unsigned long kernel_start;
> +	unsigned long kernel_end;
> +	unsigned long kernel_len;
> +
> +	unsigned long initrd_start;
> +	unsigned long initrd_end;
> +	unsigned long initrd_len;
> +
> +	unsigned long workarea_start;
> +	unsigned long workarea_end;
> +	unsigned long workarea_len;
> +
> +	unsigned long decrypted_base;
> +};
> +
>  static char sme_cmdline_arg[] __initdata = "mem_encrypt";
>  static char sme_cmdline_on[]  __initdata = "on";
>  static char sme_cmdline_off[] __initdata = "off";
>  
> +extern char __start_data_decrypted[], __end_data_decrypted[];
> +

Same comment from above.

>  static void __init sme_clear_pgd(struct sme_populate_pgd_data *ppd)
>  {
>  	unsigned long pgd_start, pgd_end, pgd_size;
> @@ -219,6 +239,11 @@ static void __init sme_map_range_encrypted(struct sme_populate_pgd_data *ppd)
>  	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC);
>  }
>  
> +static void __init sme_map_range_encrypted_wp(struct sme_populate_pgd_data *ppd)
> +{
> +	__sme_map_range(ppd, PMD_FLAGS_ENC, PTE_FLAGS_ENC_WP);
> +}
> +
>  static void __init sme_map_range_decrypted(struct sme_populate_pgd_data *ppd)
>  {
>  	__sme_map_range(ppd, PMD_FLAGS_DEC, PTE_FLAGS_DEC);
> @@ -266,19 +291,17 @@ static unsigned long __init sme_pgtable_calc(unsigned long len)
>  	return entries + tables;
>  }
>  
> -void __init sme_encrypt_kernel(struct boot_params *bp)
> +static void __init build_workarea_map(struct boot_params *bp,
> +				      struct sme_workarea_data *wa,
> +				      struct sme_populate_pgd_data *ppd)
>  {
>  	unsigned long workarea_start, workarea_end, workarea_len;
>  	unsigned long execute_start, execute_end, execute_len;
>  	unsigned long kernel_start, kernel_end, kernel_len;
>  	unsigned long initrd_start, initrd_end, initrd_len;
> -	struct sme_populate_pgd_data ppd;
>  	unsigned long pgtable_area_len;
>  	unsigned long decrypted_base;
>  
> -	if (!sme_active())
> -		return;
> -
>  	/*
>  	 * Prepare for encrypting the kernel and initrd by building new
>  	 * pagetables with the necessary attributes needed to encrypt the
> @@ -358,17 +381,17 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	 * pagetables and when the new encrypted and decrypted kernel
>  	 * mappings are populated.
>  	 */
> -	ppd.pgtable_area = (void *)execute_end;
> +	ppd->pgtable_area = (void *)execute_end;
>  
>  	/*
>  	 * Make sure the current pagetable structure has entries for
>  	 * addressing the workarea.
>  	 */
> -	ppd.pgd = (pgd_t *)native_read_cr3_pa();
> -	ppd.paddr = workarea_start;
> -	ppd.vaddr = workarea_start;
> -	ppd.vaddr_end = workarea_end;
> -	sme_map_range_decrypted(&ppd);
> +	ppd->pgd = (pgd_t *)native_read_cr3_pa();
> +	ppd->paddr = workarea_start;
> +	ppd->vaddr = workarea_start;
> +	ppd->vaddr_end = workarea_end;
> +	sme_map_range_decrypted(ppd);
>  
>  	/* Flush the TLB - no globals so cr3 is enough */
>  	native_write_cr3(__native_read_cr3());
> @@ -379,9 +402,9 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	 * then be populated with new PUDs and PMDs as the encrypted and
>  	 * decrypted kernel mappings are created.
>  	 */
> -	ppd.pgd = ppd.pgtable_area;
> -	memset(ppd.pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
> -	ppd.pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
> +	ppd->pgd = ppd->pgtable_area;
> +	memset(ppd->pgd, 0, sizeof(pgd_t) * PTRS_PER_PGD);
> +	ppd->pgtable_area += sizeof(pgd_t) * PTRS_PER_PGD;
>  
>  	/*
>  	 * A different PGD index/entry must be used to get different
> @@ -399,75 +422,158 @@ void __init sme_encrypt_kernel(struct boot_params *bp)
>  	decrypted_base <<= PGDIR_SHIFT;
>  
>  	/* Add encrypted kernel (identity) mappings */
> -	ppd.paddr = kernel_start;
> -	ppd.vaddr = kernel_start;
> -	ppd.vaddr_end = kernel_end;
> -	sme_map_range_encrypted(&ppd);
> +	ppd->paddr = kernel_start;
> +	ppd->vaddr = kernel_start;
> +	ppd->vaddr_end = kernel_end;
> +	sme_map_range_encrypted(ppd);
>  
>  	/* Add decrypted, write-protected kernel (non-identity) mappings */
> -	ppd.paddr = kernel_start;
> -	ppd.vaddr = kernel_start + decrypted_base;
> -	ppd.vaddr_end = kernel_end + decrypted_base;
> -	sme_map_range_decrypted_wp(&ppd);
> +	ppd->paddr = kernel_start;
> +	ppd->vaddr = kernel_start + decrypted_base;
> +	ppd->vaddr_end = kernel_end + decrypted_base;
> +	sme_map_range_decrypted_wp(ppd);
>  
>  	if (initrd_len) {
>  		/* Add encrypted initrd (identity) mappings */
> -		ppd.paddr = initrd_start;
> -		ppd.vaddr = initrd_start;
> -		ppd.vaddr_end = initrd_end;
> -		sme_map_range_encrypted(&ppd);
> +		ppd->paddr = initrd_start;
> +		ppd->vaddr = initrd_start;
> +		ppd->vaddr_end = initrd_end;
> +		sme_map_range_encrypted(ppd);
>  		/*
>  		 * Add decrypted, write-protected initrd (non-identity) mappings
>  		 */
> -		ppd.paddr = initrd_start;
> -		ppd.vaddr = initrd_start + decrypted_base;
> -		ppd.vaddr_end = initrd_end + decrypted_base;
> -		sme_map_range_decrypted_wp(&ppd);
> +		ppd->paddr = initrd_start;
> +		ppd->vaddr = initrd_start + decrypted_base;
> +		ppd->vaddr_end = initrd_end + decrypted_base;
> +		sme_map_range_decrypted_wp(ppd);
>  	}
>  
> -	/* Add decrypted workarea mappings to both kernel mappings */
> -	ppd.paddr = workarea_start;
> -	ppd.vaddr = workarea_start;
> -	ppd.vaddr_end = workarea_end;
> -	sme_map_range_decrypted(&ppd);
> +	/*
> +	 * When SEV is active, kernel is already encrypted hence mapping
> +	 * the initial workarea_start as encrypted. When SME is active,
> +	 * the kernel is not encrypted hence add a decrypted workarea
> +	 * mappings to both kernel mappings
> +	 */
> +	ppd->paddr = workarea_start;
> +	ppd->vaddr = workarea_start;
> +	ppd->vaddr_end = workarea_end;
> +	if (sev_active())
> +		sme_map_range_encrypted(ppd);
> +	else
> +		sme_map_range_decrypted(ppd);
> +
> +	ppd->paddr = workarea_start;
> +	ppd->vaddr = workarea_start + decrypted_base;
> +	ppd->vaddr_end = workarea_end + decrypted_base;
> +	sme_map_range_decrypted(ppd);

I think this needs to do the same sev_active() check as above.  It might
be working only because of the inherent instruction fetch decryption,
but it would probably be best in case anything changes in this routine
in the future.

>  
> -	ppd.paddr = workarea_start;
> -	ppd.vaddr = workarea_start + decrypted_base;
> -	ppd.vaddr_end = workarea_end + decrypted_base;
> -	sme_map_range_decrypted(&ppd);
> +	wa->kernel_start = kernel_start;
> +	wa->kernel_end = kernel_end;
> +	wa->kernel_len = kernel_len;
>  
> -	/* Perform the encryption */
> -	sme_encrypt_execute(kernel_start, kernel_start + decrypted_base,
> -			    kernel_len, workarea_start, (unsigned long)ppd.pgd);
> +	wa->initrd_start = initrd_start;
> +	wa->initrd_end = initrd_end;
> +	wa->initrd_len = initrd_len;
>  
> -	if (initrd_len)
> -		sme_encrypt_execute(initrd_start, initrd_start + decrypted_base,
> -				    initrd_len, workarea_start,
> -				    (unsigned long)ppd.pgd);
> +	wa->workarea_start = workarea_start;
> +	wa->workarea_end = workarea_end;
> +	wa->workarea_len = workarea_len;
>  
> +	wa->decrypted_base = decrypted_base;
> +}
> +
> +static void __init remove_workarea_map(struct sme_workarea_data *wa,
> +				       struct sme_populate_pgd_data *ppd)
> +{
>  	/*
>  	 * At this point we are running encrypted.  Remove the mappings for
>  	 * the decrypted areas - all that is needed for this is to remove
>  	 * the PGD entry/entries.
>  	 */
> -	ppd.vaddr = kernel_start + decrypted_base;
> -	ppd.vaddr_end = kernel_end + decrypted_base;
> -	sme_clear_pgd(&ppd);
> -
> -	if (initrd_len) {
> -		ppd.vaddr = initrd_start + decrypted_base;
> -		ppd.vaddr_end = initrd_end + decrypted_base;
> -		sme_clear_pgd(&ppd);
> +	ppd->vaddr = wa->kernel_start + wa->decrypted_base;
> +	ppd->vaddr_end = wa->kernel_end + wa->decrypted_base;
> +	sme_clear_pgd(ppd);
> +
> +	if (wa->initrd_len) {
> +		ppd->vaddr = wa->initrd_start + wa->decrypted_base;
> +		ppd->vaddr_end = wa->initrd_end + wa->decrypted_base;
> +		sme_clear_pgd(ppd);
>  	}
>  
> -	ppd.vaddr = workarea_start + decrypted_base;
> -	ppd.vaddr_end = workarea_end + decrypted_base;
> -	sme_clear_pgd(&ppd);
> +	ppd->vaddr = wa->workarea_start + wa->decrypted_base;
> +	ppd->vaddr_end = wa->workarea_end + wa->decrypted_base;
> +	sme_clear_pgd(ppd);
>  
>  	/* Flush the TLB - no globals so cr3 is enough */
>  	native_write_cr3(__native_read_cr3());
>  }
>  
> +static void __init decrypt_data_decrypted_section(struct sme_workarea_data *wa,
> +						  struct sme_populate_pgd_data *ppd)
> +{
> +	unsigned long decrypted_start, decrypted_end, decrypted_len;
> +
> +	/* Physical addresses of decrypted data section */
> +	decrypted_start = __pa_symbol(__start_data_decrypted);
> +	decrypted_end = __pa_symbol(__end_data_decrypted);
> +	decrypted_len = decrypted_end - decrypted_start;
> +
> +	if (!decrypted_len)
> +		return;
> +
> +	/* Add decrypted mapping for the section (identity) */
> +	ppd->paddr = decrypted_start;
> +	ppd->vaddr = decrypted_start;
> +	ppd->vaddr_end = decrypted_end;
> +	sme_map_range_decrypted(ppd);
> +
> +	/* Add encrypted-wp mapping for the section (non-identity) */
> +	ppd->paddr = decrypted_start;
> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
> +	sme_map_range_encrypted_wp(ppd);
> +
> +	/* Perform in-place decryption */
> +	sme_encrypt_execute(decrypted_start + wa->decrypted_base,
> +			    decrypted_start,
> +			    decrypted_len, wa->workarea_start,
> +			    (unsigned long)ppd->pgd);

This doesn't seem correct.  The first argument should be the dest,
not the source.  I think this is working because the mappings aren't
actually being updated (see sme_populate_pgd() where the page table
entry isn't updated if it exists).

There probably isn't any reason to check if the entry exists, so
you should be able to update sme_populate_pgd() to set the page
table entry no matter what.

Thanks,
Tom

> +
> +	ppd->vaddr = decrypted_start + wa->decrypted_base;
> +	ppd->vaddr_end = decrypted_end + wa->decrypted_base;
> +	sme_clear_pgd(ppd);
> +}
> +
> +void __init sme_encrypt_kernel(struct boot_params *bp)
> +{
> +	struct sme_populate_pgd_data ppd;
> +	struct sme_workarea_data wa;
> +
> +	if (!mem_encrypt_active())
> +		return;
> +
> +	build_workarea_map(bp, &wa, &ppd);
> +
> +	/* When SEV is active, encrypt kernel and initrd */
> +	if (sme_active()) {
> +		sme_encrypt_execute(wa.kernel_start,
> +				    wa.kernel_start + wa.decrypted_base,
> +				    wa.kernel_len, wa.workarea_start,
> +				    (unsigned long)ppd.pgd);
> +
> +		if (wa.initrd_len)
> +			sme_encrypt_execute(wa.initrd_start,
> +					    wa.initrd_start + wa.decrypted_base,
> +					    wa.initrd_len, wa.workarea_start,
> +					    (unsigned long)ppd.pgd);
> +	}
> +
> +	/* Decrypt the contents of .data..decrypted section */
> +	decrypt_data_decrypted_section(&wa, &ppd);
> +
> +	remove_workarea_map(&wa, &ppd);
> +}
> +
>  void __init sme_enable(struct boot_params *bp)
>  {
>  	const char *cmdline_ptr, *cmdline_arg, *cmdline_on, *cmdline_off;
> 
