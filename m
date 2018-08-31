Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE2AC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B252620835
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OvYyX/is"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B252620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeHaVuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:50:37 -0400
Received: from mail-sn1nam01on0056.outbound.protection.outlook.com ([104.47.32.56]:50976
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725928AbeHaVuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6NeE3kEKI6V2jax+aPvt4CqHA2iu2FlbFyZmjZSeOU=;
 b=OvYyX/is5yjB3RLVBjiHiLAtMKDhr7hdpL8BtIyRj9waxk8TrM7SH2E1NNPLeIkfzP+MC084sRk+3kiOxtPNtGQ2dX4862Cxl7dSkBjGqhzlJLKO+6yp3C8580TwuAdfUCMriu+AW4GUK9VdKM8yafmU9gVNTTrRDQT+/QostxA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from [IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740]
 (2a02:908:1257:4460:1ab8:55c1:a639:6740) by
 CY4PR12MB1718.namprd12.prod.outlook.com (2603:10b6:903:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.16; Fri, 31 Aug
 2018 17:39:04 +0000
Subject: Re: [PATCH v5 06/13] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <20180830185352.3369-1-logang@deltatee.com>
 <20180830185352.3369-7-logang@deltatee.com>
 <98bff500-4e4c-3a34-6762-16ef4b076d90@amd.com>
 <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <30411655-9b90-749e-857f-318dac7cccbf@amd.com>
Date:   Fri, 31 Aug 2018 19:38:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <6820d451-9591-1979-00bf-60c65fc4f136@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1257:4460:1ab8:55c1:a639:6740]
X-ClientProxiedBy: HE1PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:7:29::47) To CY4PR12MB1718.namprd12.prod.outlook.com
 (2603:10b6:903:121::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1c04268-80a0-4973-89c8-08d60f68a7d9
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY4PR12MB1718;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;3:LWwXXOT58EMUXJwq82AqUl7Mo28Y1gIlgndXcZpS9ZEUsNsyZHw1T/LvMZObZFc73K5n2y+AJrTWTrCMsFt6KJ8aLK3nb/xpAmpk270MO5eVv+7dXtpkBdFpRgmmeL8Q/ZgqG913cFgGTxuikdRRDqyc0ar5I2hRxcifxz7HmfBkxo/DdOQqnPbhFSDaC0rXsa+SQP5eEQLTd1oksgnOWWF6UXQM+TvmTj+QEXOsp+ooOpFPf1piVMMG2nNJgC8Y;25:k4MzGbInfoT+triHCekqNXG9mkedNxYntoDcjGdyGMlgJxt72iCCQ7Gx8A2+ipQ6ZmlgTc3rwYbX38Ki1M20RXPmOse69+tuD8DzDqff3yuIPghVZneuQTYuffIujxhAc4wo5cleMEAC+i8xN+JuN8n50WrkamQosg0wkFE5WLRKPEMA8VOR5dSm6BbIx5WT0/PByuI3EhcfAsnCG6zFqb7OBQmhYcH2SoNprNY1nfGJrqkFmRFFvRYbq08f4mfvuCcy6cN3cGGvkykyB844CgXuWccipMnSEyl9lb/qMeG7UBCz5h8YMs7MRrgQKGTD6o8EWBw9sZnXvC0XUHKwWQ==;31:0BL4Ca6KRIvMZciiFonkDFzjmo4NlVQ2tH7BSFj1bSuCB5wPfD8T36OVP4m6GfF8YTBsc9WpV0IDlQzBDhkr+JEmERmSgm6t+pxXv0IdFBqwaIH+hqvf7pePMklBhZ8gh0w18MYw23O1vjlW40xSjD3m3GjLNtym5Yh+lfRmsjm5OgO3nNt6UIumdQCUi0/RSTnRtMVyRmtueVPuQekKfwVdYmBz2r57Vkm+11EzjO8=
X-MS-TrafficTypeDiagnostic: CY4PR12MB1718:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:ckw9HRqcVxbEVVgv8T/+gBBkOhJyLO0CAEdb5puyVVFQKRch3zctu1xmUaKsByMBo7zVIuepYGxt+g07rSFXSALuwvyEfrYAPb7cjMPRl78brz1u/VlZ5xo35TJrUSE8fvtTXSVcX9NrP0r2AD90hMpbkPlvtE+vMNgAj1WsdQJ8z6HTc+gm2y3KPMpbmX0OhOb9Uw6lCnp2wycP0ZyP40cIOLfnRk5E7s+O5tfhf2Ls+UtiKZ4h7gNO0ngWhgxf9ZeqvFD2jjbK5CmBfusgqZXjj9YbEZ7a6f+mzHJIIB0KeGSj9yScqvfkRpROm2djzaitiYDLc4pfffWRY0ehhW9Ow5QROEQkPbDUseo1+ehxkA5o+aAnuoU0g2GuppqexgOf1/3XtmULhRlycqCDIG3J7Y6TH21BDb/qUe9EI0sXAU0wR9GArdP7FoW6+NAnSTyaF9JcM+KyUugoJlc5NjV4nZvJsVEXFXbpAXiisR3hGPwUv9/bCv5nc09PV9MX;4:vqbRUJgR7TtPcQsX10OvnII2CpmASaaNqoeqRdMmGog8BZJwXF6uaB6pu6KhopQt4JbCDSxtGaVvrjxiPdojW3Q65+avTxTvIGJ+Xxot5/CdCRZvtqIc4SswFJsjY9cX8jgwXpQnC4dOwsAGFHmfELzukk9BdHgNQX4RlzNYN3b9d1/w3mH1kdf+oz6svuN0PWOFMbn9KUZGzpRJ6qLxYOdKD+K72yjlBUr3aytuEVy0erel3QXd1qfWgadU1sxEtVxpHgFFkWUrb0kRyPowLA==
X-Microsoft-Antispam-PRVS: <CY4PR12MB1718C87D9CF1DCA218AE2999830F0@CY4PR12MB1718.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:CY4PR12MB1718;BCL:0;PCL:0;RULEID:;SRVR:CY4PR12MB1718;
X-Forefront-PRVS: 07817FCC2D
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(346002)(136003)(376002)(396003)(39860400002)(189003)(199004)(11346002)(1706002)(186003)(16526019)(46003)(4326008)(50466002)(81166006)(64126003)(81156014)(229853002)(52116002)(53936002)(2906002)(86362001)(486006)(2870700001)(52146003)(6246003)(105586002)(25786009)(31696002)(23676004)(2486003)(7736002)(106356001)(65956001)(47776003)(305945005)(446003)(65806001)(6666003)(31686004)(97736004)(52396003)(65826007)(6116002)(53546011)(76176011)(316002)(5660300001)(386003)(8676002)(68736007)(54906003)(6486002)(36756003)(7416002)(478600001)(72206003)(8936002)(58126008)(476003)(2616005)(93886005)(67846002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR12MB1718;H:[IPv6:2a02:908:1257:4460:1ab8:55c1:a639:6740];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyTUIxNzE4OzIzOmJkcUVtTGNFWU9ycjM0WXYzV3F4TDJBc2lK?=
 =?utf-8?B?V3NYSkUyR0NDZHA2NEFZekc4MDc1TFUyY0pRSXBuYUkyYmlqWk9iR2VMakNS?=
 =?utf-8?B?dmNNd05nTEFKYXozakIrTHNwRVh3dVpKR3hSM1BlOXJsV2ozY2UycFFtaGxD?=
 =?utf-8?B?VjBJb0R2WUdzUHVMb1JRS25LSzFJWThDMkZsNElySEZzRzI2OFRic01vbDhk?=
 =?utf-8?B?WWoxYWN6d08zNzBkNWo4RE9Sd2hHVVRqVkFLMzBzeWw1UkM3eWtUMGxJc25G?=
 =?utf-8?B?NUR4VGJXQmF1NE5aeUlpN0JFV3AxOEQzdCtUV0Z4bzQ4WHdaUkxRc29uTmFa?=
 =?utf-8?B?WEUxRUhLeEUwTHpuV2pycW1CTnlMaGVxeDBJYkpWMUF2UFFyNFFKeklOWW0v?=
 =?utf-8?B?NDRzSHVRbDNvaU1KNXNjc1ZiVGJEM0c5TGQ3dnN2Q2N1NmthWEZhMTdnRk1q?=
 =?utf-8?B?ODRROCtNT1dCZnVNMWppQzQySzRvQWhDVlNrd0pPbTVkc2F5K0F4bmliaHZl?=
 =?utf-8?B?OWlUYkloQjE4VngvOUhZTjdSQklJUXFzMzFoZ2ppZmplNEh4RHB0ZUZTbTJo?=
 =?utf-8?B?Y2tkY3BkcVpoTE5rcUd6cGhxQ3hLNDNsYWxFalFUV0x3YXBOVVNoT2Urdzhj?=
 =?utf-8?B?SGJ6UTRCY2paYlZXNjJjU0RSWWJib3VOZVNDVW5ZdUdZckM1bWQ0cnVMWHRp?=
 =?utf-8?B?NFBZS3BEQXhSR0ZEMXlFTFNTK1N3YWlZcHFxMHloeVpadmRsRE9MR2NTdVo2?=
 =?utf-8?B?QStnVDZvdkFnaVd3dlQxQm1pblB6TnU5SXhFc0htNVdXYUszTGMySWxWZjQz?=
 =?utf-8?B?Zlc5UEwxRzc1eHcxZ0FwSitGbGFpTEwrZXFNOExEY0JRNWNZNDVMRmFOQVFD?=
 =?utf-8?B?VUlNQXo2eVNSTTBLQnlKTG94UDF4ZHp6czRWTytRd0JrZC9pYllZYnpSaTZh?=
 =?utf-8?B?U0cySjZCL2dhOEZkS3hjQUFQb3dza25TUGRMRmlsRTAybERCNEZRc0hncVpM?=
 =?utf-8?B?ckQrQms2YTU2VTY1ODZ6dzBFWjlKU0htRUxjeVVWMmdQaGR6QVJrYnZrdkth?=
 =?utf-8?B?b2pvVGJSTTJjaVNlbE83aFpDOTNkUUdBS0pzbnhjbG9jUmVHUHcyWTRDZ0lG?=
 =?utf-8?B?UnFOUS9jM1Q4N2xIMDhXSkc0VitaTjBjeVlKS2JtVDRqTXh1SE9GOFRLaWV1?=
 =?utf-8?B?VDZkUUFRVXlBYXpEbGxSNTZ4eXZOQ1NIWHFkczB4bkMwOUkxYXp1dlBtRnFm?=
 =?utf-8?B?YmgydWg3ek5jTlhsa1VZQ3BqOGd1NUNSWE85SDZhL3JhdC8yQVlHQUFXVW5C?=
 =?utf-8?B?bXVkMk1DRFovbENabk1tc2pza290YjdPZVdJOUZuK1FGaHVCUUVWM0tFOUcz?=
 =?utf-8?B?Y0ppNDE1Y1pDVkk2S1RvVS9FTEZUTmViZHdoeXNwVGYrcHF4aHkxbndGai9m?=
 =?utf-8?B?dU1JUmZaVGtEKzloR0QzenBSZk85NGVXZ2l3c0Zla1RjNXlxNFVUc2s0L0dT?=
 =?utf-8?B?Rlkyb0JMZUtZeHJVbkNMbzYzQmhzMWtsRmM5ait2NlBCbUJTdklKWkREcmFR?=
 =?utf-8?B?MzVXZnBaNTE5Q1ppN25YT3RNZmVCSXBVY2wzNjhNQ1FXK0h2WjgxelVlcUZI?=
 =?utf-8?B?VHFMTnY0eTMyZ21kRHB2TVBaYzB4S0xXOFRienVNWkwwRWxkYm1QZzJ6d0hy?=
 =?utf-8?B?RXFISXhRcC9rOHFLWTNEWWlzNkU1eFF1VU9zTkl5ZXRaSngwZDF0RkxwRGVm?=
 =?utf-8?B?Tk53b1dpYXZ3cEZQVGhLYXRxYmN0NmF1cUh6ZklmRER3NU9pRHFiV2czdlZH?=
 =?utf-8?B?eTRJZmpRa2VhT0NQOEVLME9jR3lsUk9jSXRaOWxraXNrZFVROUpady9PREZo?=
 =?utf-8?B?RW5QdCtvS0FqK0lZalczVTdFVFBmcjhFUnhsMGpSR1ZhZ09aemZsKytqQmEr?=
 =?utf-8?B?c096eGlOQ3NnPT0=?=
X-Microsoft-Antispam-Message-Info: Sd7VQsRkxNZN2Sw2cjTM3HBd+S6kGcB0b/A6JvOk4LjMhijLXgwc1AntTi8gGC2S3uYwE9c1VvD/V2zAi4xOD7jG3ho2w0p8Y31oAWibsow8iILE8R5O3Ca8NOcukWkaMWX11MjcltjFWd0gWxSD1rwaeOk6BEX7jjA34uzDc7+a6daq96sAsyQ0krjm2GN3ilWoqui3GqcyDXJ+EqI1UsoYysrYaz7Vt6rDc3B0slGVhGz+YOP9+HuR6nddeHLPQM5QPsgGug0u4Zkxix2JbdrxRMd4mGRTFdBNxRndfRrojtiojTDu6k3qTG5pAmPxxLEWu6Gb8q72aKEF1da1bnm7EK6lL2cHobxGEA3C7i0=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;6:3KDgxjBKB22Q32N773/UEFxoDVHQ/51jC1d6sCs9coAIXOkqhTCXynIBkZdQRDd+sUXWicRtld6vZODUaz69T/gvvy8M1byuZfBZzRrK+n2qvD0xVClH6AW0ij9/JC7mK4oFo2JuQmq2ohqpKP54Ck/FQvNBjLcrWq6+OAZUiIzVYg6kLx/mHbpOn+YwtTr/Ia4OmDDijbxaS8ee4Osyb43vlW0YK+sLzpX3L8e0etv5hDPaIfeXZeDwkm57vgXl59HRsmxSQqvoOPXw1V0is3q0thTxyqFMqdhWdL+g/eFCn5fNbf/9YMgAQ6CetSElXjNdfI0QLuKoDoMtewkuTjCYHwsuDDYABYsmocd7jwnqTO78u2CzJciLilWieZCuqQT4w4p0zoHEZO/U6hHFet9ElrD+ltREqXwDGLXqjm2c4oH44IbX5YoLCUjWcQqsJ86tfT2e7GfFMHdpK3MrIA==;5:vNJXXMJvHTliOd8nKLKSy36nZSFxJIYu1JMcT3zR4OrTjOyFnPnK6y41lwcZSjo9ez3iTECSKmVk3psgn3GIMZ5TM6HACVhQ7dvuhst+9O3OpDrhdeMxkTjb6vx0b454UFOzql0k4qvT8Mq9iWGLRPmJ/hQ0CHd3pop400xQyxA=;7:UHPCwyzgTvp6DJKBCAS1B0R48SUH9hAbjbb805tWqStT88yLM+RhIExC+Ujay0EyrDt6Zc2zpOOB0zu3xP54ZUPzXs5jJcOrREcUA+UofeZxdBICHF+IF3gi7LmoFzx+QcPvOgO/M3ItxyOc9DIccWq12oHt6ce9ImsfVPZBhA/+GBxLH8aWqJPc3R4KxeB6c5gJ0apL/vTCSqgB8TsHhe3p1Ia/sMvaIdZ/84HPoQkS4D604ZBZhDSzbHfvHRDL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR12MB1718;20:QCCVt8da4s7NcxSRPrvFMXM0SXmDxmsyrg0ZWddxn/dBHDt/CPLFnRpNu2ut74n6ezlq+rmxxwk/sUC73JuBQ8i507sEf54Ek/GoaDwUnKzY6VnGbBEVBeFFi7pfYCB15xwykSPN6iwRbn3aBvMwiSD2nHPuTXxNLF8JaEqg2rOhXTOk+XfLH6KM05FHVOA8bS5G/v709Gw0nZqM9fVbAuNKl20k8XyTCOs8f1COqCU1sHzDmjFtTzajnIq5rhAZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2018 17:39:04.2977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c04268-80a0-4973-89c8-08d60f68a7d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.08.2018 um 17:51 schrieb Logan Gunthorpe:
>
> On 31/08/18 02:08 AM, Christian König wrote:
>>> +One of the biggest issues is that PCI doesn't require forwarding
>>> +transactions between hierarchy domains, and in PCIe, each Root Port
>>> +defines a separate hierarchy domain. To make things worse, there is no
>>> +simple way to determine if a given Root Complex supports this or not.
>>> +(See PCIe r4.0, sec 1.3.1). Therefore, as of this writing, the kernel
>>> +only supports doing P2P when the endpoints involved are all behind the
>>> +same PCI bridge, as such devices are all in the same PCI hierarchy
>>> +domain, and the spec guarantees that all transacations within the
>>> +hierarchy will be routable, but it does not require routing
>>> +between hierarchies.
>> Can we add a kernel command line switch and a whitelist to enable P2P
>> between separate hierarchies?
> In future work, yes. But not for this patchset. This is definitely the
> way I see things going, but we've chosen to start with what we've presented.

Sounds like a plan to me.

If you can separate out adding the detection I can take a look adding 
this with my DMA-buf P2P efforts.

Christian.

>
> Logan

