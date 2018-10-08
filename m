Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0274CC00449
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07022085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 05:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="xVI7fQ/l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07022085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJHNFN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 09:05:13 -0400
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:56019
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725842AbeJHNFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 09:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gOeCgzWw179p5wgLsvzVLMlBqiQJBvPNWAGXXXF3Uk=;
 b=xVI7fQ/lJted4J9Cy3ak9q/SNj5t9T+Rzkd4/fDXxGW+EZrr9d/0T0C4A0mO/2v5ApauZx2qozq+2RkfolGwbEHZmFHKYko4+KwFeXnsDp3y0Je7TyJNoERSRyQgo7J7KVJsoLjA5FazaoNop04Man4guYD3kPviHrl5w0S3Q9Q=
Received: from BL0PR02CA0098.namprd02.prod.outlook.com (2603:10b6:208:51::39)
 by SN6PR02MB5231.namprd02.prod.outlook.com (2603:10b6:805:70::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1185.24; Mon, 8 Oct
 2018 05:55:11 +0000
Received: from CY1NAM02FT007.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::207) by BL0PR02CA0098.outlook.office365.com
 (2603:10b6:208:51::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1207.23 via Frontend
 Transport; Mon, 8 Oct 2018 05:55:10 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=temperror action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT007.mail.protection.outlook.com (10.152.75.5) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1228.17
 via Frontend Transport; Mon, 8 Oct 2018 05:55:06 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:39432 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9OVV-0000tx-Po; Sun, 07 Oct 2018 22:55:05 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1g9OVQ-0003FD-Ls; Sun, 07 Oct 2018 22:55:00 -0700
Received: from xsj-pvapsmtp01 (smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w985spL0012870;
        Sun, 7 Oct 2018 22:54:52 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1g9OVH-0003Bt-MR; Sun, 07 Oct 2018 22:54:51 -0700
Subject: Re: [PATCH 01/13] clocksource: Convert to using %pOFn instead of
 device_node.name
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20181005143253.GE1881@mai>
 <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <2157c9c6-90fe-d77a-fac0-0f88ed4c9e49@xilinx.com>
Date:   Mon, 8 Oct 2018 07:54:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538750143-4282-1-git-send-email-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(376002)(346002)(136003)(2980300002)(189003)(199004)(11346002)(446003)(31696002)(426003)(63350400001)(476003)(31686004)(229853002)(8936002)(63370400001)(2616005)(106466001)(336012)(50466002)(230700001)(63266004)(126002)(5660300001)(9786002)(53546011)(76176011)(65826007)(77096007)(478600001)(36756003)(305945005)(64126003)(6246003)(47776003)(81156014)(81166006)(36386004)(65806001)(65956001)(4326008)(316002)(186003)(54906003)(110136005)(486006)(58126008)(106002)(2906002)(23676004)(2486003)(26005)(44832011)(8676002)(356003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB5231;H:xsj-pvapsmtpgw02;FPR:;SPF:TempError;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT007;1:/ggQQ1Z609zhAssYyALHZaIKGcKpdXO/VXH3TYJx2CQowTalhog71K4wqHBzsjr6y/QUJStUEBcb4PFLWijSoZDPhnNPOjtU7Yiu1XK1xqvVHBJ/j1MRPEuTg4pWwrHf
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c36885-29dd-4398-acdc-08d62ce29a66
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060);SRVR:SN6PR02MB5231;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5231;3:AcQ41th5RtWcDj9/pjk7hEjtodRoJIjXW548q67Mb4SgBRG/W3SPO7ne/MLSrLv6ica8gHUu5R5iwBHmf+7u4fVFEiQ6q6VYQsAF+5fsUHyGf4wlJgRG3bXXdQJ0wBMS5+cyQRok0y3CIWlK7jtqcG8BWwwuO4998j0zqphW+WKwcc71Q+it/6cbR6i4IYjsluMX8ZZFCN06eHp5jFvfzxehSGN8DVQjY0c8YWdYU5fN1TLT9fM/tYZFSinoBlaeHSDDGylJcvYZqlZ/kbNaR/TO+sQr4ox0wJW7MeKcjdWnKysEzcAQOMuifEPSX9jvh2D3325hk2gH/FyDYgXSO6l3tl29WZImEuc3Xq/wthQ=;25:pgxAUvHL3BuIKETeQv7DnM/39umgiro84q2t8YehUMOBJl9Z+qUR4DbY9APts154l0jEThLYVOfQVZYx53+orhRTE4qDRugu9KZ09x/RIEV+Grtw5toNLPgzI1iPDkfHp1F/JOIkXrc6bpY5gmlDtEuOCcMKCXFBsJCKb/liNYMmc3TaVV9a6AdveBMyg2i/UC+8fOM/T09dP1CuFfExqXpcO/BZ4sFMXPJpjoU09jCWObAD47dzAnJhhyV1+kyYaK7ORrP+1KOKUeU/gmsoYQtl7zq/AqHM7jF2ed2PGK3LPJuockIbjxJh6/W6AjunrvDiAsPr5JQIxZNFxDFksQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB5231:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5231;31:L3PajOlRQpHoFLAPP0sIEPSV6b/rDUDI9zBYlwfhhwEtOweIkKDR81hy9D2Kcgnhds5Sf2aRwis28H0f7L+X8UOYtUxElJXsx/x83gzAymvoV/ulBsnFZVieD66+oQtPbxJ6S+Ehha2mhVfkpN3QoLkcZsf/CnEDdh1inQRG9nCz/BuvcRJBfIinURUTdms/fpCXt5xU2+rHpYxyrleZjUy8yMp3jgDKM1cZga2V10A=;20:Ctij1Fma0yaDbEwxpPUqq1mYdeNw5RzJx8H8WXtEnMo4KInA6mweWMgsXrkDJ6CgwIscvZAsfwFMCmWrQ2s6+YE5eO14Cd7f3OvnwDMaDn4TkuQhEIOj6SoA2Yartgfp5mf5wEHfQOT3JpielRP3wPRgQK/rgWKrWjjM01jxnh/EBwh24FrQ28Ti/u3CJoWr8TM49UgpbF4KJp0t9eSV4LG7CN/JUdxBcp0Rh5n1wwMM28aHCVlI17Vfz1N9f/pnQiiaf+t9pLF8fDevxj+u8afCE140kRgBIj5DpPWt/yagdxgE9+1OnF8xHxggvfBSpq/1FBbDS0w7GTTu57fq/u/Ywd8DO83NfbF0dPVHd0koctm53CPbmNUtzVQCuHhn4+Z2O5lBKLqRHENXCHuYyq0L4d4U1nHhjLgxN11BhyQgXox2JpJktRhm6sV9hBc0e7Jt2hMTxLug2hS+5+STWnYBaqFmxV/E2MDO8JeubA1ZO6R2mOHXcjLwtSvrWhjE
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB52313A77E36728E27E0EA4A2C6E60@SN6PR02MB5231.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:SN6PR02MB5231;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB5231;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5231;4:f555VhbSLLIWKvxZPLQcN06jxKSlyqbZaJwFUGB/k830EOVc7oX0KX2bTAnFHsAdVzkROUdP5aNNAKZD+x+NDMVO1EXl8fH29gYyOUWvkL3QMzD6m7jqOcnAkFjBCpA/ECihvFI4EXogMSDRIk3QN1gTgqu8HuzPNvbcd6/S35mQNibcm5WH791/m3TKNX+T1Dd6gcRgXAs18eR8xHiggL36iD5zSIA1xxMhuAtPSyNoT98/xE8dytviW7a+RhlJ4tY9RJzxdIicLEDVpX1AJI0+KGqjCP57LKLaCnJX+5Unms5QdhiazI2AwldteJ+Hx6SuaMwQAiosP7Oe1VxBxCjR03nTWOvgZxPhU5c0sD0=
X-Forefront-PRVS: 081904387B
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI1MjMxOzIzOjFCMmRGUVBMRFdQcVJ5TVc0TE0wMlFnbHRB?=
 =?utf-8?B?cjVyR3ZIa0w4U2JUZkZNdSt0YWYxbEhRZXlEdHdKNktqRWFxeUptMlVBSThz?=
 =?utf-8?B?VkVheWFCVUJuZmw3enY5a2Y3UEdRRVZBcmZERTc1dFNsbDZsUEV0UFlhK3RJ?=
 =?utf-8?B?TDJ6cG1TMGJzT1BGcS9aZ21zSWRzVElwU0xLQ1NqV1d3R3JkdTdMK09PdVFu?=
 =?utf-8?B?TUxDZWtxRk9UV1lxb3JQcngvK3EyNWpzRm14UjV1MU5PTnI3Q0xhQWJNNWMz?=
 =?utf-8?B?MllueFFaSU5STE1uSmlCL1FVRUxoVFZrcTV5L1hjZ05VdUYvVHZ0MFp1Z0NU?=
 =?utf-8?B?Vi84MU8zMFd3YzIyL1ZYQmtRMjY4ejdpRHZJdC9NTlYxUG5ldlR3eWFSVmJh?=
 =?utf-8?B?WTlyaW5mOVZQQVZNY3k5aUZnVENENW95cXczTFhUZm5PcW1tYWhFLzhEMmJo?=
 =?utf-8?B?MzJjR2wrazFZWklXZHZjeWt2eS91WmtnR25uZDV6Ty9iUkNIbExJNGpCY3R5?=
 =?utf-8?B?T3NRYlM2WUFTeXVQSmZ3dVU0Wm1iT3JGN3RkaG0vS0liZERwSStJbzlpa0l2?=
 =?utf-8?B?TEE0dkE3TDJNNUVnbGIyTWd5aUxZOXNTeDFxTEl1dUV4OVNGZERhRVNDNWU1?=
 =?utf-8?B?TWlXNDhxTDh0WSthT3VaTGR5VGZyNkkvTE5ib05BZGxyMXJMY1o3YS9MZXFB?=
 =?utf-8?B?eXFaR0JNekFRZzNOVzd4bnZ6dW1JTGU4MlpDYU5HVHZUUndGRXZMWDJMQk1G?=
 =?utf-8?B?NGF4TVNKT1FLdEFQVTFDaGdUeVl6cXhhcXk0MmNUbCtCUmlCZldwSEp3dnpX?=
 =?utf-8?B?VlBGYUp6TlFacDZaSUZZZWFDeU1HU2xXT01ZcXVmbkZvL3lEZkpodVpPOWVy?=
 =?utf-8?B?V2ZRRDU2RXVOcFBtVGV1RFdRd09uRjU4K3VUV204bFlsN2VPa1NDWnBtSzhj?=
 =?utf-8?B?NGtmMitFY3RCUVJOcFdqYkxIanBnVXNtdmtURWV6czk0Yk9qRC9aaURTN0ky?=
 =?utf-8?B?K0E3eHV1S3p5MUt3eENMTUI3NTgzQU1QUVl6R0R6VmZKOVo4NTJnQmd1Z1FB?=
 =?utf-8?B?VDdDeGFnYmJWdGVxYmZjb2xDcGVyY25UZ3dqSm1vN0Rpb29KbG45VzYzNDU4?=
 =?utf-8?B?c3ZncFZKOHFaREQ3QnU3Z0R5Nk91MjhRaG0wcW5rQ1Ywa2taM1o0amlMbUdj?=
 =?utf-8?B?M1F0OGRxdkppYkxJYkRVVnZnOC9LeVcwSU1pNkVReThvTEZJMERWS05hQzBD?=
 =?utf-8?B?NUk1Y1laTUJsQjQwZ3loN21nUDZyMnVXMnhSWWpBSEtmQjNEa2U5REkydG8r?=
 =?utf-8?B?Z0Qrc2xnd1pzaHJSc2hGdCtJQmFkVmFnV0oyQVdpVXdBY0JuL0hvTGl3ditL?=
 =?utf-8?B?TlB1ajJvTDdGdTl2RTFlNWtXQlVaU0lhSjMxSDZrT2FCTXlJcFpBWlpaUTJj?=
 =?utf-8?B?N1ByVXhwN1NCMnlXNjRVRVNTNWpFcjdhcFl3SUtacjVoaHdYdC8yNnNVS1Z2?=
 =?utf-8?B?UjBDdjZMM1hJMGs4Z2VOekpyb05KQ29mcWxKbWdmbHZkRCtnaER2ejV1K1Qz?=
 =?utf-8?B?K1RIRGp5czM3aUlZSVIvZG5GK05HZ3QvV2M1dlRUWi9lN094TGRHNmN2R0JJ?=
 =?utf-8?B?S2FGMVpadjFHbEJYYkY1ZkwyRHJCUXlHTVRtdjVxaGNKc0VUYW9rT1ZvZTlt?=
 =?utf-8?B?dnlMTW0xSmJjaWErUmtaRnJKOEVTK1JadXVrRlZSbUxKZEVsMW1GZ2ozTnJs?=
 =?utf-8?B?UnRZREJkUGxVRWx3Qm9NQ0lVRmZFWmlCK2EvaGpBVmw4ZVZ3OW1MYjlaZURL?=
 =?utf-8?Q?Eiw9f2nTgUwC7?=
X-Microsoft-Antispam-Message-Info: BjOyjItRH3nYe5u1RrKCnDJ6BSuD8TTLqcusG5vD8wlIlpKl2eXEYQ/eMj6a32omJbb4l85mrdc7queD8jQboJXM2NpdtwpzlTW1hmfx/abuW55bOj3O0yY0Gi1CDP5L9Kp7C9Z4jZdGqbO2k/cK5IdpjZ5Rb31Ux5hoLdQWBInPaCx8jo1Gy/Enn6nhJ+APJ96+hxDN/dmvz9ozgKQ9KCmHg/U9tNq2czrxg7oWuRUiLD3tIKkpt4kVU0JqO2EX7utEMacMxU/l6IB5IoFCDwXuUXjTfzspIGqPX9Erwz7Tn/YOk3uq41wvKpJnSmtUl9QkqO8Zwkgh9C0l8rIDVE/RqCwQdlcasAocjIxpZR4=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB5231;6:R3KE4tfDRKtSVCcnkh/DYyNQSB9CVY9Bce/hKM2wdZiIUZZNGS395oq81s26joDdwGvie0+hAhWRUH37A+HmgKE4ziLAYwd8PnZEHbO27sDlcOZ+KCh+U9ADLtOA2wpuKhsZ9BaimvSZo8/sTCAWrSHM+Nm6s2pl/135tbNpdnm1KtgJBYox4vedhlOt/9m89tmZl48hW971MkHmMG0r5r+m2gmOyGOV0TpsWvcEgH51jT5oe0ePLeRo5lJnzyP6KizpPSaI6ArYS5W3/4xRcEhC2mrTpHaRM8X9MXiX2qvITttISvW5SSMsEJM0TiHJimrLZaMFxrOB4WjTGhRJfUmc1llDDVHDPfrika2XsOoXKIKEteaBawmDABhurhEO3R8+2OuI+GXMj9KAMllPw9/FTPGwXgd0+Jp4QIA/hMzybip3t5+b+CYkoFY+jwgP3rtZACBoTOkCq1+JLBKxKA==;5:3H1gCUw4kTlu2qa8xywT8yLzT1SwRIN2UAY0sVUJbg72w6PkN1UqrJoL7ysC0U5DKm4We8Owq7n/JurdpVn0S2EfTBE6DbqKShHno0PhBOGwQjvf5VNzOvlea1dpnftXXQPmvcj8OivUzqRoSP4XoGOxv0SMRlFPfzIGdVPkuh0=;7:IXmWor0LzxHtGwfGWUt4nTC9/JvoWjThTmmXeqqTwlXz77zoKLsb5vOhTooaRgcwnKS5yLTKhAvvlGEsA2BZnlIkOQqS9lZIWet8x5PYMJDWocQzHLWjGw1eh1gh8jx1idTAJtyajIZR4UhywT9mLSgx6SiUHnbQSEVE8s8N7brV+3pQX0gYW6spHpYLtY4i2Y4fC6h56yDK76GgBLOTxGPH7zUtVn1VKXiycgbP6u431ef4lUHPW4hDiEZT42No
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2018 05:55:06.5404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c36885-29dd-4398-acdc-08d62ce29a66
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.10.2018 16:35, Daniel Lezcano wrote:
> From: Rob Herring <robh@kernel.org>
> 
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/asm9260_timer.c       | 2 +-
>  drivers/clocksource/cadence_ttc_timer.c   | 2 +-

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
