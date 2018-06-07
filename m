Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id ZZorL8iOGVuacgAAmS7hNA
	; Thu, 07 Jun 2018 20:00:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A02BC6074D; Thu,  7 Jun 2018 20:00:08 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cRDB7bwp"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 889E1601B4;
	Thu,  7 Jun 2018 20:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 889E1601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeFGUAF (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:00:05 -0400
Received: from mail-eopbgr50095.outbound.protection.outlook.com ([40.107.5.95]:18752
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751037AbeFGUAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=incZfRdfxJtErGx6zluJAYxRzrRiFYpPSYJhza8kTkw=;
 b=cRDB7bwpXGwRo39uDngb/+8vcQ94tzpbDQ9ykDsGcOlINAF5yd5nDdcvZP3VBiSItvUDkVq4AKjfkBi+Moj1cdhn8BP968shANrUMDfrOPmFbIU499R/rUP0NRDf14M0MA+Mo1n/uL69OB+AwpPGy5gkkLuKuDQwFnGjKrgRn1U=
Received: from localhost.localdomain (89.178.233.143) by
 DB6PR0801MB1334.eurprd08.prod.outlook.com (2603:10a6:4:a::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.15; Thu, 7 Jun 2018 19:59:56 +0000
Subject: Re: INFO: task hung in ip6gre_exit_batch_net
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        David Miller <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        Florian Westphal <fw@strlen.de>, Jiri Benc <jbenc@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Xin Long <lucien.xin@gmail.com>,
        mschiffer@universe-factory.net, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Vladislav Yasevich <vyasevich@gmail.com>
References: <0000000000006e4595056dd23c16@google.com>
 <CACT4Y+ZmxgKvgD2RWD1=KEZQqY=vwdhrAZfqMT-gGuj8k8eKKg@mail.gmail.com>
 <cf729ce5-7948-d475-1b20-f31fb313df88@virtuozzo.com>
 <CACT4Y+bPrdK7xSeUk=pgVVyaseDZUAvArBA4bEWPsUi7CE3EVw@mail.gmail.com>
 <e71c0df1-d83c-030c-7c97-13a923aca1b3@virtuozzo.com>
 <CACT4Y+YBY2yGJBHgqGhAcOguag9JUkGkeOz1acgKd=KR3q+noQ@mail.gmail.com>
 <04b6ee08-7919-bf2d-5b77-bd346a0bff48@virtuozzo.com>
 <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6b14e8b9-c335-dd46-98a6-7f58a624fcea@virtuozzo.com>
Date: Thu, 7 Jun 2018 22:59:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b8FkwFe1PCEVDZcTufB4HKVy+ekk=1_YcFH6-RoBGY-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.178.233.143]
X-ClientProxiedBy: HE1PR05CA0237.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::13) To DB6PR0801MB1334.eurprd08.prod.outlook.com
 (2603:10a6:4:a::28)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1334;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;3:Xx/0cJcV/YC8BfqFO9BN976BEPq09+Max6NU/3eELKFYmlWxojTpzHrdTHkjB7xESjSs6r5RU+Jgpta2mgt0rHh9d7dpf1f9YwH6z+pH929k1rY7+TTEFfiR09yV0Yl5q5WGtahxLMNnVOr8IdX0Q+3ZtP96+7Z2DBScQtUCWajVTJx6a6lYyenpgdksVkCPHsOiZjy1dOkByhSrELF1W/oouax+eQJ1TjBWRj5R4A0QCyhXrdflDvqFOTVdB/wa;25:9sFe1himNuWe2Je4vTG4y2AI9bByguld61npGomq+2R3IlYVMDQPyf+iAtpE6VPHAEHxCHD7IGKjWTkFte4DRQBo2OYoKxHo09XMU4l2zdmTLKyN2Jocb0Os6HnuOu0WvJVcHeBx0MKhRyMkpqAz7B5waZXfjsy0GhBoyCKtYuwJCiF7DVdKVhVyj1Kn22B+SIc071KHchZm4zSJW/TVsCnP/469qiSlYCtQvJFcOoJh+gpfPLU/Z5zu0ZHYHl7fZ2+UWYTz3XeXeSrzok8VI1pfTkVTmxTuioACzj8PTNN9gHU/DSKqx9yTRsGoZOTEhrVWEo8sGDgBtFzavFS1vQ==;31:O5QndvV8r5jtqSQVNLSlG95js2Gn6Fe6cMtE/eab384lHnkC6CMwXUoUICFDrP+StgaCAwGJmMfiYHCZXllO+yREcbXLRlhbg7qz8ExGLibE6tOLZnx9byO/yuUXiJiNt2Z+dkXLt75uMscnySa7R/UrQPWJZOgbQbUoX+bnsmq9jwcJU8SPoFNNVzOxmSyxqEXsqIlRxXCL9/1YUizlcLI89RRwhEg+9LwwoMyvBY8=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1334:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;20:6uVndiQjQ15ipAIWT/y0pV3hKzPcXuQMpl4G8HNfjrFX+KimTlDptVcgrsY8mqty5fxBejxoFkmxQZOLe1/emo3ONlv5/oyjuRVgurTW3fAcOtfSVZTzz35u0ETKOIfPB0msGPUrYzrJcQovkAAdS14gARiVnmf2cgKNbMto3EIkS3w9Hv4XF1HsFqgRaitUL621xApEm4RGoVR5FyzpkBft/wzmGliO0dYmrkjYtLHbXB4eksihZ+JZWXS+L07iJcnhuChD4jao2JL1+vuGSq2AeQE/FEvpS/kPIdQK06j6WKYlW9aZnZsLeTsNiQP88YSjnahoc0ifGmckiNuIKNmGObUv+K4IEVZLdkGG68+HYXc5EY2VlE2XnDCs8+bI5kho/vrk+A2P1GBHRS8Yd2WT6L4wyIVxQeaR/g56zeb7Axi5Cj1ZEubm/o4CdMsBdJiitj5iT+MaMmE33O+UnSfrVpPkBNKExPfyHXR4oLXz0/DWDLJjgq3L+11CGQq9;4:Vci5rmFueg384kOxuYqpyETwejChToEVyVlXxHvxtXU55+Tnkmf0l4j81MuQxqP/8yHZwz9/M8rjWGw+04TU7I2x+pBVUz7rqPJpSIyOE1PPG7z2RwRHu4XObfbs9gJDcbC1cHLPYOCRXYxAMFRbP3r7BY/23Y7vDRaAhK37VBU1OqqiyPJl8MDJ3Rx+P1r8mVdu783I0XQcditfT/CVtKkCaD/L/gCBU0QcskdZ45KPj97fh/SIk89QSOK0x7csCI0nFhxIENxofUZzmsCKqQ==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB13341E04F0F5B03C5FE8FA8DCD640@DB6PR0801MB1334.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0801MB1334;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1334;
X-Forefront-PRVS: 06968FD8C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(346002)(376002)(396003)(366004)(39850400004)(39380400002)(189003)(199004)(59450400001)(15760500003)(58126008)(76176011)(81166006)(6116002)(16526019)(8676002)(81156014)(2906002)(50466002)(956004)(8936002)(230700001)(66066001)(2616005)(478600001)(486006)(6486002)(86362001)(65826007)(65806001)(6666003)(966005)(52146003)(6916009)(64126003)(3846002)(229853002)(31686004)(7416002)(105586002)(65956001)(36756003)(476003)(6306002)(25786009)(6246003)(4326008)(39060400002)(93886005)(7736002)(53546011)(52116002)(305945005)(6506007)(186003)(26005)(47776003)(106356001)(68736007)(6512007)(2486003)(316002)(11346002)(53936002)(446003)(386003)(31696002)(23676004)(54906003)(97736004)(5660300001)(99710200001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1334;H:localhost.localdomain;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzQ7MjM6VWpDeGhRRlM5Mnd2QVBNV09Id21QRHpQ?=
 =?utf-8?B?d2RFbzRnSlNOdUROcVBTNnNMMVJORlJ0anJ5STdCZmswVGVmVGRERVBxalNp?=
 =?utf-8?B?VTlqQWRQNUlGL0lYUEpJTGsza3dwM3FmbDRVQjVKZUVEZDg5UG83TEFWaC9I?=
 =?utf-8?B?RnRaNFZ2Uy92a3k3Qk9mbnBoRXdnUkdsdE1uejhYbi83UmZpTEZDNVFjRUxZ?=
 =?utf-8?B?VGhCbHVEbUMvRkxLblo1SGx5YktjM2ltUDBZZU95Yk5QRVIycDNPRm16VWl1?=
 =?utf-8?B?SjhaVnl5YlVyNmZkSEhjS3pvUVBCUFVUb0pGZG0zWTZMK1ZWVFU5OU0vb0FZ?=
 =?utf-8?B?MFM1QnBUaXNMVHBDWWxEOXc1MDA0czZiSCt4TGVKdWF6bXhLd1lYOWFmMVFC?=
 =?utf-8?B?ejlYNDA0Nk9XN1dJNmx6TkFoMHc2WFpTMG5ZMTUwOUZ1Z2xTYUl0RjhFdkZh?=
 =?utf-8?B?TXJKQWQrNVQwOWJtZk13RG1xaXNxWTlyNVNTaWEzSFVETXNHSDlub0xBMW5r?=
 =?utf-8?B?RXk0b0hNMHNxZlBxK1pvWml5ZEVnTVhEZ0FzSXdReHRtQmM1amdCTFRXN3k4?=
 =?utf-8?B?MktYOSsyYzJMYTdjM0lsV050ZDcwc0VvanYvRmdEMU52eHh2WkZKcGxCMXFu?=
 =?utf-8?B?VE9BOG1FVTNQeFB2YXZzZW5GbTFwU2NBSHNXOFlEYzNSQXhScmtuVElYbUdJ?=
 =?utf-8?B?a3gwbEp6U1F0SkhyYmV1OUMwVU9KdS93dVRKWUh1eEFsVHRCbU92cG55TC8r?=
 =?utf-8?B?OENCNmJ6dDQ0RHBqeDZIWWNvS3ZseHNWSkxlamVKOTBtb29tc2lqOW5oQW83?=
 =?utf-8?B?U0swMHhLM3NSNDlXUEo5OWNybDBlOHNyVjcwTGlrdVZJdno2SkpkUGtjMFli?=
 =?utf-8?B?OTlEYlBWbFpZa0NWNnMxZDNpQ3lmM3RXOE9YN0xycUVLU3QxaU1TbEoyazRa?=
 =?utf-8?B?VTlCS1I1VXRyUHNDZWxoMGZJUk1qRVQydlFmL1VIQnk5QmJ3L1JwRDhMbWI1?=
 =?utf-8?B?VkY3cDl6K1lFWDdGdVhqYlFLUmRrckxrY0d2UEEvK2Rwa1FIRGN1bFN5anQw?=
 =?utf-8?B?T1BiYkg4ZDBHR3VQd3JkTDJQa2FlaWlHTWFjTWJqcjRXbm40SGlGYTlsNE0x?=
 =?utf-8?B?MVFCQWEzRW1vVng2SlFLQjg3cVZ0THNZV29OMzZBMDlKeWJqcGdsR3FJRlRq?=
 =?utf-8?B?T2VyUFppUmZUVGpaQlRoNlRQMk9xaGJnQzBtUFBLdnZJU05iMVZsK0VvYVNF?=
 =?utf-8?B?dGRRQ3ZhT1g1QkZxWnVWWThtaGZHVE5rMWw3VUdJWmdKSCtmYXo1L1hzaEI1?=
 =?utf-8?B?UjQzM3lpNXQzVDQ3cElLdEVUcEtoZTFxUVhGMmVnRUtIVTkyanpGRVplcHI5?=
 =?utf-8?B?cGNvM2hzbGhtK2JyZFVuakNYQTk4RGRQdkNhbE9yVDZpWkV2TjBocjA3QVlN?=
 =?utf-8?B?TUZqTWhzV2J2Qk81OEVBeHp0VHdTNkdmL2NyWlV4NGJoZSszWldlMGQ2d2to?=
 =?utf-8?B?bmlaT3BzZWRCVGkwUENnSEhVenVNeTE2MHFBTnZsRTlITS9XbDk3NFhTdWxG?=
 =?utf-8?B?QUFEZUpyN0JNbUk0VFJnZlRZMy9BWXdNMnJITWlsZlNmeU1scG5PNElSS1ht?=
 =?utf-8?B?U2ZBN2dzdG5aZGh1V0ZEd1FsTW0vL2VpWk14UkZ1WUptK1RnY3RMUGZnMEQ4?=
 =?utf-8?B?Y2ZVS2gzeDJnODA0YUJJZk5QdkhlV1JGVU9xMzVCd1hjbGZEWDhsZTNPNFFQ?=
 =?utf-8?B?VllCQnhuQWluU3pFajQyM2xDd2dTV2hlSXpoZUljbUwyc3Qxd0orOWthb2o1?=
 =?utf-8?B?aDhuaFp3MzhubEd2amwyd29lZFlTb3NaQlhmMVNlRnVLb0hyZ1FnWnVHQnJP?=
 =?utf-8?B?U21xbDdNbVVaZDJiZElEYk55SDlqcis1SUE5Z1BITkJ6NkNWVWxveFRFQUR1?=
 =?utf-8?B?ZDdRaGpESmpCWFphdWJTNE9rZ2I4blZjSDVwK3VNZldZZDRadTd4amZrbWdN?=
 =?utf-8?B?RUVJUkZUcytwekxqLzVJQkUra2lFa1p2OTZpVzhtMHBzTVRsM1Zob1J6cnM4?=
 =?utf-8?B?bFNhUWxEVkpXK3ducmY4REdoS1NIdkFmY2xvak1SQ3B2Z25HM1d2MlA0OURt?=
 =?utf-8?B?cllsQ0duMHU2TWhaRGdxVHVzM2RrUHFmV3d5eGNRcHUrQzZFTjR2RVBadWt5?=
 =?utf-8?B?U0djdEIrcEFkQ0hnOHZCVGs1K0t5Y1E9PQ==?=
X-Microsoft-Antispam-Message-Info: RzKAfmUPZUKwvVRRpD0stujBKHcKBpoCrRZFHZLu4c9jYSAyjiGkO/TpNJFdHrOSPBMm+nr+RaUecpGIEFAOnqf9hDmL++FLcBAJxjUfKfcxX/BGWzVdPrLu8efQVmmwQja6e28efoGG1tVrgKmzvLcRI1NxixgDwkheVOiFwuj2bNPkRhraIlyBFyI/oK0/
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;6:LPl+A/5XTQJDjW+ueFANPkEOAuSJTFXw9p2w+sdLlLVbnfcP62fEMjtDXABJYU7DXM1tzl0stOEVopDP9Wbjym2MUK0T9AsN/8k474Fa90GBeE5D/ETPQ2soQD49hZX1iyFAmVZugrNaR5rVuLfUIg6RWoJUCFNfeBeFv8AhwtqOESCgYl6qurTp6nJv5qLAfqasIPyWq5J7EM10N4tTUukT3MJkA1zaQYGcCmZOdPZsg+U8BI7un6mL1BNhaFSNEVS26nOwoCqZlLzW2v2fSNt51LKGilvlTxNLZSQtm/QJpGCvXitV/VQJU3XPngwnPfV3gk4g63VV4cnXVdyHKUZi6czo3LayKMsFbWCFcnyI8iNboN9956/f6Ubjo+qbw1XmZERXNEAv9GXtljTgPypNaDkmBQ7NdIs3IPKVCwDaSqOnx8tF1Ll2pclBPWaj6yrsT9XBlojOO03wU+04rA==;5:Q4aDHx6ua51XFmq1r5JLnili/csOB9cHf3kwQ3N0jAoIWWjE6mKGhbijVdTaXBpID/ifQxZeJ5OdhmneeBOEyDOMzX5v+ggnBBKSc8QhsdoQ08fba5qG36fCy6NzMd7qZ+IxiiSLoqvlggBGCan3x4XXBaUy4x1vGc5w6yCr/gc=;24:JCHYGOVF+VsKPlQuSdEHCeMRDLkGQgMa5uk0IU5UXI3ZhyXsc2bJBZMWSY/IrOqNwPYJ6zQsJ+A+eyd5vuRpzPMPrCKEWZLn12EiZxYIOj8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1334;7:OOgPiZzA/B3m/61qiwZ24xsKYgaBgRNuDIyjyGYknum3tfRKJPHFhxhochP9B4CB9tfsE1msCN0+IRW3joBgKA3ApojzMMdjV/WHsq5O2GskXdg1Afw79kNAKaaDZ4sZ2rgiWmkf09QOc8nZqRfJpEJNo0YMyPA7QA/Xuw5B+5bZAO4UGMXYPqGScHEE+5NxGaN7kzqAgzlGia3WE1GR0ibnvZtkPDg3BdnbKz5QJuJa7jkjmNViO08OiGWwUg51;20:blo83Js7yPWeJpvOte8pjIFyjkWvSK4D9CAZJWkX2kV2Yxfaf8Hex/iLauI1Oxnj/dKAmXX/6c+c/C2QWq5IWo1NugXFCdKj/hU+9c64XGDubJ86Ypqk0cLVXBuvqHq4BPz/eEXDiGpY0b50TcFFlx5QzXu0eJzYb1jc4pnlVvQ=
X-MS-Office365-Filtering-Correlation-Id: 6b941bea-4569-46a3-7071-08d5ccb13eab
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 19:59:56.4244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b941bea-4569-46a3-7071-08d5ccb13eab
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1334
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07.06.2018 22:03, Dmitry Vyukov wrote:
> On Thu, Jun 7, 2018 at 8:54 PM, Kirill Tkhai <ktkhai@virtuozzo.com> wrote:
>>>>>> Hi, Dmirty!
>>>>>>
>>>>>> On 04.06.2018 18:22, Dmitry Vyukov wrote:
>>>>>>> On Mon, Jun 4, 2018 at 5:03 PM, syzbot
>>>>>>> <syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com> wrote:
>>>>>>>> Hello,
>>>>>>>>
>>>>>>>> syzbot found the following crash on:
>>>>>>>>
>>>>>>>> HEAD commit:    bc2dbc5420e8 Merge branch 'akpm' (patches from Andrew)
>>>>>>>> git tree:       upstream
>>>>>>>> console output: https://syzkaller.appspot.com/x/log.txt?x=164e42b7800000
>>>>>>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=982e2df1b9e60b02
>>>>>>>> dashboard link: https://syzkaller.appspot.com/bug?extid=bf78a74f82c1cf19069e
>>>>>>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>>>>>>>
>>>>>>>> Unfortunately, I don't have any reproducer for this crash yet.
>>>>>>>>
>>>>>>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>>>>>>> Reported-by: syzbot+bf78a74f82c1cf19069e@syzkaller.appspotmail.com
>>>>>>>
>>>>>>> Another hang on rtnl lock:
>>>>>>>
>>>>>>> #syz dup: INFO: task hung in netdev_run_todo
>>>>>>>
>>>>>>> May be related to "unregister_netdevice: waiting for DEV to become free":
>>>>>>> https://syzkaller.appspot.com/bug?id=1a97a5bd119fd97995f752819fd87840ab9479a9
>>>>>
>>>>> netdev_wait_allrefs does not hold rtnl lock during waiting, so it must
>>>>> be something different.
>>>>>
>>>>>
>>>>>>> Any other explanations for massive hangs on rtnl lock for minutes?
>>>>>>
>>>>>> To exclude the situation, when a task exists with rtnl_mutex held:
>>>>>>
>>>>>> would the pr_warn() from print_held_locks_bug() be included in the console output
>>>>>> if they appear?
>>>>>
>>>>> Yes, everything containing "WARNING:" is detected as bug.
>>>>
>>>> OK, then dead task not releasing the lock is excluded.
>>>>
>>>> One more assumption: someone corrupted memory around rtnl_mutex and it looks like locked.
>>>> (I track lockdep "(rtnl_mutex){+.+.}" prints in initial message as "nobody owns rtnl_mutex").
>>>> There may help a crash dump of the VM.
>>>
>>> I can't find any legend for these +'s and .'s, but {+.+.} is present
>>> in large amounts in just any task hung report for different mutexes,
>>> so I would not expect that it means corruption.
>>>
>>> Are dozens of known corruptions that syzkaller can trigger. But
>>> usually they are reliably caught by KASAN. If any of them would lead
>>> to silent memory corruption, we would got dozens of assorted crashes
>>> throughout the kernel. We've seen that at some points, but not
>>> recently. So I would assume that memory is not corrupted in all these
>>> cases:
>>> https://syzkaller.appspot.com/bug?id=2503c576cabb08d41812e732b390141f01a59545
>>
>> This BUG clarifies the {+.+.}:
>>
>> 4 locks held by kworker/0:145/381:
>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] work_static include/linux/workqueue.h:198 [inline]
>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_data kernel/workqueue.c:619 [inline]
>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] set_work_pool_and_clear_pending kernel/workqueue.c:646 [inline]
>>  #0:  ((wq_completion)"hwsim_wq"){+.+.}, at: [<000000003f9487f0>] process_one_work+0xb12/0x1bb0 kernel/workqueue.c:2084
>>  #1:  ((work_completion)(&data->destroy_work)){+.+.}, at: [<00000000bbdd2115>] process_one_work+0xb89/0x1bb0 kernel/workqueue.c:2088
>>  #2:  (rtnl_mutex){+.+.}, at: [<000000009c9d14f8>] rtnl_lock+0x17/0x20 net/core/rtnetlink.c:74
>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] exp_funnel_lock kernel/rcu/tree_exp.h:272 [inline]
>>  #3:  (rcu_sched_state.exp_mutex){+.+.}, at: [<000000001ba1a807>] _synchronize_rcu_expedited.constprop.72+0x9fa/0xac0 kernel/rcu/tree_exp.h:596
>>
>> There we have rtnl_mutex locked and the {..} is like above. It's definitely locked
>> since there is one more lock after it.
>>
>> This BUG happen because of there are many rtnl_mutex waiters while owner
>> is synchronizing RCU. Rather clear for me in comparison to the topic's hung.
> 
> 
> You mean that it's not hanged, but rather needs more than 2 minutes to
> complete, right?

Yeah, I think, this is possible. I've seen the situations like that.
Let synchronize_rcu_expedited() is executed for X seconds. Then,
it's need just 120/x calls of "this function under rtnl_mutex" to make
a soft lockup of someone else who wants the mutex too.

Also, despite the CFS is fair scheduler, in case of the calls are
made from workqueue, every work will cause sleep. So, every work
will be executed in separate worker task. Every worker will haved its
own time slice. This increases the probability these tasks will
take cpu time before the task in the header of the hang.

Kirill
