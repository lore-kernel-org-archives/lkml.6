Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D68C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E74225D63
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 06:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Z7cQqkXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E74225D63
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753629AbeF1Gob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 02:44:31 -0400
Received: from mail-dm3nam03on0072.outbound.protection.outlook.com ([104.47.41.72]:26903
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752108AbeF1Go3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 02:44:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8C7e8l6h1TQImh/B3wNN+CahG1MEw01Az6Fr/oDep4=;
 b=Z7cQqkXX7ur9m8gCGnpx4OUziuthGT4LzhKyqoXuqKhmitAXkE/8hofadarB45bwuLUHKaO6pzHVLrku0AQjxyCiPbpi5CHrA8mtbnJUJO9zqnKf/cRne+SDs2BFU62ECEi7Y8cqjPNZnVZxfOxtvfDK6hPgSeQMzg7mfGYGSus=
Received: from BL0PR02CA0102.namprd02.prod.outlook.com (2603:10b6:208:51::43)
 by BY2PR02MB170.namprd02.prod.outlook.com (2a01:111:e400:2c20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.884.20; Thu, 28
 Jun 2018 06:44:26 +0000
Received: from BL2NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::209) by BL0PR02CA0102.outlook.office365.com
 (2603:10b6:208:51::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.884.21 via Frontend
 Transport; Thu, 28 Jun 2018 06:44:25 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT050.mail.protection.outlook.com (10.152.77.101) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Thu, 28 Jun 2018 06:44:25 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:52440 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQfI-00042t-Fr; Wed, 27 Jun 2018 23:44:24 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fYQfD-0004bp-D5; Wed, 27 Jun 2018 23:44:19 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w5S6i8ow029142;
        Wed, 27 Jun 2018 23:44:09 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fYQf2-0004aI-MD; Wed, 27 Jun 2018 23:44:08 -0700
Subject: Re: [RFC PATCH 2/5] dt-bindings: xilinx: Add missing zynq boards
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180628054205.17737-1-luaraneda@gmail.com>
 <20180628054205.17737-3-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <eda7ca2a-e2de-8939-0784-89b619f6035e@xilinx.com>
Date:   Thu, 28 Jun 2018 08:44:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180628054205.17737-3-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(39060400002)(65826007)(36386004)(229853002)(106002)(58126008)(316002)(50466002)(5660300001)(478600001)(476003)(2616005)(9786002)(426003)(126002)(8676002)(336012)(44832011)(446003)(11346002)(486006)(31696002)(76176011)(81166006)(63266004)(186003)(77096007)(26005)(47776003)(31686004)(81156014)(65956001)(305945005)(230700001)(23676004)(2486003)(65806001)(106466001)(6246003)(4326008)(36756003)(110136005)(8936002)(54906003)(53546011)(356003)(64126003)(2906002)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR02MB170;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT050;1:yZc/jwcp73r1YrtG6eE8qoYVIzyZ1cn2Vm6HL2XFUNVSe+3/OTDEHb0Agb8Tzn+70YKVoJk7zE8wVeIuSQJKBHxpJovGFkl5E3LKp8UiVADDG8F+EaJS+r1DSHMUdUGY
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef44f5d1-4f86-4ffa-fda9-08d5dcc296ae
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600026)(711020)(4608076)(2017052603328)(7153060);SRVR:BY2PR02MB170;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB170;3:65vj0w6O5U9OvtfRxyaWebfbJIru9thWTMbs6J9FOtPuWwFz8rG7169373cCXS6ON73/RvxXknexEm0cUq7z61ba2X4DuJbXRRNcCpXjFDBfNOBkKisfeIUajocJhEciyow/yk2UdBI+/31HEYKlLVDTpcbIpbwTK1UARuX/URXFTOAN/EVWbjLmWrnRvJi0toi95rfvpNXJXDY5gRdw/YHUfeU8IELoh9h8StcAkPE7TmNlvYt5RVxfERAbTkfayUpBOru/cLpNWuyPiD/1KOtHHUCts11PY2RKjdQhsm4Gtx/TGMAgHzPI/lAVKkd8zUJCg0QIlCorEeVlna5DQObAf3ZuhiKqTKg63lBHVWw=;25:+H2QLpanKF/N2kH9L/d5fs5oE4BrvcSI7JmjX+W1xGnh8MVj4Y4dCjf1OQK7YH5JwODennq6rHF/KpN2R92pmYWSnPVUg535Vl+q5L17z9NKDoutyzKot/zkkD4mPw3M9rU3gd2HYNfoemlDShpYMGUiPhAbY3slGuHWGs7V2dyE/7fuEYVjORsmwcaADFKq+43fbcqOHLPgBbf8fTJr+MpwqjsSqES8foAHZnKy9DgK+kQAmRSoVu4ClPXiHH8US5yGbyj2wdfrV4jeTwb9HxblhIZDAGDryOQ37nCS/wqMht2JaoJlickQNxbFfHw30ESptpkpviFa1w2Nl/Y8Kg==
X-MS-TrafficTypeDiagnostic: BY2PR02MB170:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB170;31:dBKoXKz+UhS/qJJgRo7Y5TQBXYxWJigkIFKstV7WetBTm7LA5/xbgSGOxZSBjibDBgNMVRUG5ndgySSbXxzaHguYLFjreL1uAl2ImJxytXV80ZZpzY9oIFhmE4TkeXp2s+93MqIcSOIC4yZS1V/hUUYgA5Nf3G1WK3nMrd9t6dy89SjKrhbGwmie2zotuufZrdmhREthamc3pyBO4d4s1wxqkFZV1hgOhTofNFm6Ato=;20:T8jvzk6yPhnvEb7oOpktBNPcI/K7STJrS0GSq/Y7O2OGV0ksLeQ7hJA6IE03Ah22l19KN1A1LWDyFADKTR1C0AdLMuA7k9tdxEqsripjZxhlOB0MnQow4POSGkMAhpr7szLxFsUE4w/gB4xE/Anr+uHyMUJyZ8hcBimshyb7CnTiM/1D5RGl2rD4gwH1Y4TBj++dlJTfQQJ1O3zhinyC7SFwufDMy1RHZQ+w1WlGSkm0RyLY/qKBmZykZV+Ohg7QhleipQrBVXCtEldN4R6YuZ7LlvHfV1q4ZpOHlC5+af/cQQ18Kq7k28U8xfaI0Zf80uabuE7pozjiCcn3aNn6W7SHZ22dHjuyk4bZMk6INEJ9PR3vnCoIaofM7rTHzy5HUWrbO0Bz4P+rFakhFXjF7JiQyX9Cq/dpdnPuB6LrQp71RTY4Lsr28C8JsaX2BsXgqSDZt3+BZPUYCjr5tCkymCa0jrddiJK+uzz/NrCq+LhBFwQ7SOuFOpAWEUzwXCH4
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BY2PR02MB17053DE90FCB73AF9BB8200C64F0@BY2PR02MB170.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR02MB170;BCL:0;PCL:0;RULEID:;SRVR:BY2PR02MB170;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB170;4:4IbrfR6/Pe+Dc3K9L08XV8kbWAlz+qbYLx5aVWG860GSPtaAKEiH1bBGna627s2Au3aiZcgatNUUSqR/D1l9b5xTCh8XB6xQZrVXoo2Rm4ImP7YYJr4S5njGJQjEt+Jmfxr3CiXDcEq4opqTVkrKgHmF1ufq1XFYlImfIV1ZXP0GR/+PtJo5JAlBEu9pJ/zyey8p40+rEJ/XJrvJ91pvryQI+axJjh+xfw8VJr4OJ7vMnkwsLSbHgqvU5kK/X5BgyIODAIW1P7horSpcdl1plB49WDpZnRLpwqObzu0dGU6oE0hMB6FaEzkTYgcbDcR0
X-Forefront-PRVS: 0717E25089
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjAyTUIxNzA7MjM6SUdKQWxLWW5CdUtMWTIvc1ZCYkVMaUVyMmov?=
 =?utf-8?B?ZklwcVRZekYyc0ZlenlLdXo3bVJPbzRyanZwOUZTQXkwbHdaWkdTQ21CN2g4?=
 =?utf-8?B?NlhxSmRMMFNNVnhUanB4S2hCWmtGMFI5YVhUTUtzSldwakp2T2JET0Q4REhT?=
 =?utf-8?B?OGtWWjRTV2VOaU1OdHBMbXVQbk9mYmpFUFBjbHRrZWZqeW51ZyszOFVkNEFP?=
 =?utf-8?B?VHNUUVVQTytKMnQwbEQ3cnpOUzJ0QjhLcHorL2wza1ByeWNYRCtEM3pLWU9I?=
 =?utf-8?B?Z1ovUjdSS1ZBekd6UWpJaGF1Q3MzQnlBQzNRVHlKUDU2Skl1L0drVTlyMEZa?=
 =?utf-8?B?Qk1VZXZjK3lsNjFWK1JQS1FNbnZOZUg1Y2F4clF6WGRzNEpHaFdwdm50UVVh?=
 =?utf-8?B?SFg5U04yaDFWbW15MmtrcXlTaTVyN0hVN3Q3S1pDalRYcW01NCtMUWxhM0tJ?=
 =?utf-8?B?dW9hVm1KcmNDNm5vVTRMS1NDcFZtbVdSVkovM3g1V2pDRXB1UXVyYUdva3h4?=
 =?utf-8?B?bGt4d2xZU2g4RXlCSHVzNEZpNWxCU3NVelZKU3E3d0RYVzdKMFgwZkdEZ2lv?=
 =?utf-8?B?cUlkVjNYbyswN2xsVDAwVlBIZEZnTDVEMU03ZmxqZ1J3Y01HTUV1amdOcnY4?=
 =?utf-8?B?NFFoVlZtd3pMbThSWm02Ums0OHlLQjFORDhvZWFpL1JaN2k5azh2OFdqckFM?=
 =?utf-8?B?dUhxT2g0V2NSd1JSa0ZibWZlRWxOU09vYkErRWlRVHllVGZWMzhGNWNtVGtO?=
 =?utf-8?B?NTBBVmtucnVBZ203Ly9xcXkvTkVEQUNLYjliM2UwZ0ZZcktPUHEvOStaL1Mr?=
 =?utf-8?B?ZE80enl3WFNIR0M0UVcvYTR4cndtNXZkVmdkandTRjVGWHpoZXJyR2FQMG5M?=
 =?utf-8?B?MVRkcWhmWnZQMWZHYkhXQzBpTEovQUszSGpwTUdBVE5YWDBwazZWWlJzYTdn?=
 =?utf-8?B?d1FYTnRYR2hlNHZxL0pUTEhkTG85dTlEc2E4aUVHbi9aQWp0Q3VvZkc2STdF?=
 =?utf-8?B?UzJ1cjlWYnBzRTdSOHRUV2lYbDQ3ZWVwSHdyNmRZTVdSRFhvM2pla1dVSDZT?=
 =?utf-8?B?bEtWUXpVNnlwZVUrZ0dHZlhHeE5FL0MweE5RTXVYUlNWalo2SzhtNmN4UUZa?=
 =?utf-8?B?dVpSZGJWWm1NaXovUExFRWtqRmtFcW1LbzJxQlRHZGwyNU0vQWIwK0g0SHRD?=
 =?utf-8?B?dXJ1Mkh2K1o0MG5QNXR1eC91V2N6ajBVczljT0hMZ21xMkxIUWlwTU9obHFz?=
 =?utf-8?B?SGZzMHdzaitrUGt4UUw3dG5LbEx0MEZoR3JSMWhWUkZSYkN2VjJhaUc1Y1li?=
 =?utf-8?B?QXhSRXlyenJLajJTREZCMHpMTDdvUWxKbHRyRy83ZDlma2VyWmxsRlJlaFlW?=
 =?utf-8?B?VVFjSE4rY2dYdC9pTWdicTA0T0htekgrd2Y1Q0s1TUh6eGt5YUZRVXBxbk9T?=
 =?utf-8?B?NmhMT1V6ZmJ5V0wrenhzUFJJZUltUFBsTGwwRk1lemNuQTljZ3RnN0FOZWEr?=
 =?utf-8?B?TVlQUTMrWU5OcEUwTk9STGFIS0F6WGJ1S1A3azVWb3FZZGErMUVYcmE2VUVN?=
 =?utf-8?B?UDVUSFplbGVXZGxGMWpVZWR6Qy8xN0U5Y3F5Mk1OSnJVVWx6UWVjODJ5dFlV?=
 =?utf-8?B?bEcvQmZHbEc4UUQvRVRRQUV3cW1VUWwrbzEyaGxJU0NpdVJXWDl2UDRBVEND?=
 =?utf-8?B?VG9LbHovQzFnakdzZWI3b2ljdEhNeFU1VmdIMTlHUXhxMVNLSXIyNGx4RVZF?=
 =?utf-8?B?ZEtMcGwrUkljTWVYME85VTE1bnNsK2xMWDZzU1NsKzk3TFZsRGd4dVo4TU1E?=
 =?utf-8?Q?4gNhm0q0egPs?=
X-Microsoft-Antispam-Message-Info: aJ5Ycw+l0iWvyE10dMKx3jKP0kA0eBWboeEZ6wmb3cUrzHsQOVHk5O46tNvo9wNaWEWKfMmNXnp3EKYKpJgxjHucp53/tkydZJqci9IlZnwoMwlUuH63R/c3nRozstcGKSz4M7BuMGZjk2nCTJ+T5qRkOan77p1pMPK8QBSWNRwa2D7YkkmTQo1VpFXyiPPFU+ON3Z2u7zbj9tvbGskrjtsipiLIanx2DmCGtxtvt3t+C/aShqZQ68LmGuFMDjyXcltuhWiVmpdFBSs3O6WLXPdLhiocPIC8BfSZJ8te9MGEC1iNyR/R1SHTHS8jVNTNeo/5CFq/5ToXyniJa98w/pmT6L8I9dGWy28dtzHXbW4=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB170;6:JUVh6v7Ix7zs1H53BPTsd/wLEvCX5VpuVHZ/y/hH1EFu7CSn4VKf21MhpSHFa8SzdqB/Ag05bja7VnuY8p0lIGX6NSLDC0RO9la25VCj/JwEbjjOK/d7atZLXbfvgi7nd3ZGGaVTQXWkMy0SwimGATTfRpxpIk8+O3H9M6TMUktoY32C73Rs37qslmmCkyvsjE0jIJjxLdlwvHtxH0MxF2MsoGjRzHHmLF9RZRw8WU01k3Cc7T48lz0uwU9mFVs0CoLkC8dBpQobgrBmC4a0JnoQQuHUvn+4riIsv150k/tcRmghgOm0jcXOmQEcEmmv40GLvFFk/AX4cL0JMGy0iR613n1Ne+J3uOAf/MYmmC2m078nofPpQtwTtleCcVUiQVpJQi4UmJbOmK0vHqp4VmxoYR0JZ2bNKOsaM1+na1cKjFrp1j1RzdVh4Qg9E1TeU93tPUOcUBVphM5PTVbxkA==;5:WbE21MaLeBua8B8GPz0kCLda+3F7pbDGPeeEspBaRYtLe68juy4yKEZeZQsOt7LdLLxBNwqJnquMaKDhCB8WgMhgn+XgEG1BOOdnu/TNdqySNWsb7i2RFK7+G6zcOgZ9/kiEHmDj3twfAoJSfvIPHhV+bXhA5Y9x2ZfrW0iTQaE=;24:nIVu7RzJMJnojGFSttBozCR/wJ4O+7UwwqBrBNGl+9zxPJMMqeUoPWgg0kQ843TU/Ma8ujbmzKvx4hVIl8RXcOd/LFqfGPeqQAgqtqDmjF4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR02MB170;7:CJ//R/cTIrc7qdkzCIL5gyFqKF1LNHCWpSt4P9inXXv+SRSjsJ9BwVKWgFHGllptx9uo1jm7PZcRRtV3IRon0X3I/3HcHpi9hhrzfdqIuJ5Pny2ehxfQVFqzDA52d6cZZoyeWBVEcGT8QcRFC8B6p5sFj0nFBI/2j8dr10bnOkwz61c39wKrDs5uuM5miRaUPpMfQFD7I/9C5ir6NUZUkOjhGtILmVoMV2OQ5y7gtC4zDErj8m0Sqdn0VvRL6Uot
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2018 06:44:25.0734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef44f5d1-4f86-4ffa-fda9-08d5dcc296ae
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR02MB170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.6.2018 07:42, Luis Araneda wrote:
> The bindings were missing when adding the device-tree files
> Also, improve description of existing boards
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
>  .../devicetree/bindings/arm/xilinx.txt        | 22 +++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index b9043bc35..f1e911058 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -8,15 +8,33 @@ Required root node properties:
>  
>  Additional compatible strings:
>  
> -- Xilinx internal board cc108
> +- Xilinx CC108 board

No reason to remove internal word from here.

>    "xlnx,zynq-cc108"
>  
> -- Xilinx internal board zc770 with different FMC cards
> +- Avnet MicroZed board
> +  "avnet,zynq-microzed"
> +
> +- Adapteva Parallella board
> +  "adapteva,parallella"
> +
> +- Xilinx ZC702 board
> +  "xlnx,zynq-zc702"
> +
> +- Xilinx ZC706 board
> +  "xlnx,zynq-zc706"
> +
> +- Xilinx ZC770 board, with different FMC cards
>    "xlnx,zynq-zc770-xm010"
>    "xlnx,zynq-zc770-xm011"
>    "xlnx,zynq-zc770-xm012"
>    "xlnx,zynq-zc770-xm013"
>  
> +- Avnet ZedBoard board
> +  "avnet,zynq-zed"
> +
> +- Digilent Zybo board
> +  "digilent,zynq-zybo"
> +
>  - Digilent Zybo Z7 board
>    "digilent,zynq-zybo-z7"
>  
> 

Not a problem to add missing strings.

Thanks,
Michal

