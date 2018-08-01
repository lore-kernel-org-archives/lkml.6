Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B997C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DE120841
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 04:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="MZSQ1tU5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="DzN9bWLo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DE120841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733004AbeHAGIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 02:08:17 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52412 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731869AbeHAGIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 02:08:17 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w714FCRm005022;
        Tue, 31 Jul 2018 21:24:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=nknTmsp+si0jAWh6RNV/mBva+alEY3j6EDMJCyTprDE=;
 b=MZSQ1tU5E2lno+ODVCpmKiyShdC4trXpaIgfJ8IW0dZnexVha3pfY0HKFbyTrgtB6YGL
 m79ZgrRcwm+xa2HXnfi4Ous7YnIA8iY69j822gGUjM06bzHG7sI195/yLJJhxT+4r9jv
 ERiVME1FbWV3CqbOBhCGpWF4cA+xC0bBXlw= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2kk1df0hn4-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 31 Jul 2018 21:24:15 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.27) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Wed, 1 Aug 2018 00:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nknTmsp+si0jAWh6RNV/mBva+alEY3j6EDMJCyTprDE=;
 b=DzN9bWLo5NbSVEGlrduJauHBjqan90m7LO0ny+0vMyhc4YC081LechawQVt51Fpg5zW4MkbvPcNdutj2M+OCrZ2LisGIh9+o+vBRS7CTN1KGTCAjCbx0w4mjp/J4ED8cukeOuOE+an/d617SIVZKTz5xt1qh/2pVDpMAkhcGRC0=
Received: from macbook-pro-52.local.dhcp.thefacebook.com
 (2620:10d:c090:180::1:8945) by CO2PR15MB0073.namprd15.prod.outlook.com
 (2a01:111:e400:5068::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Wed, 1 Aug
 2018 04:23:51 +0000
Subject: Re: linux-next: manual merge of the net-next tree with the bpf tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Okash Khawaja <osk@fb.com>
References: <20180801113508.54323706@canb.auug.org.au>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1774afa4-5b21-61f1-e921-4102a1950771@fb.com>
Date:   Tue, 31 Jul 2018 21:23:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801113508.54323706@canb.auug.org.au>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:8945]
X-ClientProxiedBy: CY4PR22CA0070.namprd22.prod.outlook.com
 (2603:10b6:903:ae::32) To CO2PR15MB0073.namprd15.prod.outlook.com
 (2a01:111:e400:5068::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 590f0b9a-3d46-416b-0f3c-08d5f7669682
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CO2PR15MB0073;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;3:z6ScqWRCFD7soke33atv9TWQQczNmYmFQmTsyLXlyR1gcToyCblS6AxuldV7vDwiYXFLXCWYOlLbX2RlR9Fh7tw6sAk5twIOXQ0vygHTl1yKfqdM4ToL+sGO1b559rT4WQjZi6Yi8vlKzf1c+nFLR11n25sFeeKMZJq0KZa17RS9fINPg8+EzmpJ4L3GzpR68ONIRrsekFXYVxX61cwczIMhbjcll8AyT2YXRT737bq97Hcud4h7ZVXjjLz9s9hL;25:tXmKwy7se3mmZnFmihfs//c6GB2U8egL2hKhoSMaYzCGZPWnDMO873INkZYAToKtIk8DbNJRXbA0XBzB3Jvs13/wqPR5UetO1aFcVN7OyNkCteLOslvbcJMRbU+Lhq41Ejw9oPtdRWo7BBUNz8WYMHnWCnPoNFKtFafzQkNYV+x3ItLn3UIyndX3Y+ihm4n6MrnX9trUhhvIfvASsZ1yuXm7qvN+gbc7bvwukahUrLmt8XDLrTMHVUh+cOnhAlGXG/gCLtBSCVKWiXb1C6OjPG/g2a+RwVHW1V5kUtTmndn+L97JLANBs7UH0HnVGAbgmRSBkBQ4cP4U1rCcDVjzcw==;31:wbD/W/zDqDlL6zW9c2BDQp4NjbbfUYyaMr9POaeLcsJIac9YK0yVemnrWci7Hi1LkT7B2yfWUkI3oqTlk5p1HgQF/RYW6PL27Ebo0r57s7VfEhOQAQg9JS69J4szi9WlHkJAySpvRHC76KRRqg++HSK/lcexYL/2YCSxZuDDHMrd/GoLMVgyhRq6JEbC5S7gcvflcPabyQJ/oo5LksM3t9e5H/YI2sSVD+u6FEyZyOU=
X-MS-TrafficTypeDiagnostic: CO2PR15MB0073:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;20:n6e9a+VxOXru7QTIGxPw4YHNV4CK0a/1U/knMbrxaqgoQVDEz4EwgBl0LLIhL8Fp3ByeNRgSscEiSNChVEeKHLbG3Pd6WrYWGhVL5lZ92PiPnafFqnyMhvN8ouNqu5Pn/zdk0wI27nhBYPJPOU73+Ehfkg07dmSpSQyb1Xj75LvMJlOaGAJm54QuwmfclP4TW7R/NlfJr1v+fipVSfZkt8wCQogsueRX0hggu/pr1p8xGyfhW1NHj7A9JCYdIBzV/M8pMTPTrRFF7Frbug++hCi0xiZyJ5OAlCSOvMDdSCz2nqOuSKZMvgS0osyuaL7RvrKenNj57TIBHLEMTEBlWq0E/Jhy4lpcj96ljFfafHbFKEuGiWA7IT500oSgSWDytICg2Zmw/7yT8FS59XhpWaf+u2cFjCHeEnpFbZYqamGbaW9zba+LBEDVs+3fj0H4lzglJ4nFMdiggYeD3SDm5/33vf4WdMJKxLdjqXrWUSW3KPdmCvRWPoDYV1ukmXyp;4:rekV49kbCgwcoxONBW3esJE3ltdSbcOOjAs8dyeG9B8ISQFevZsmNqj1zeCPfpO//gBmFT0Upf0bvQzHe2eI7tTI45gtwAbiHvb8w6/w7fNZZS3FDG1iWZ89fGTJrB+Gt2JHp/Er/2lStd+UI+voinkCqg3ebfOdw0ZxluHfRREmyud8K86wqVCKfSon78JRdH8wlZDUX8gy3hALJ449WRvM5/+oGWDCVtLWMQEqHb5LLbJweLIGC3O7tvTiEp1vuMTmJQkBe+5GV725DQorFA==
X-Microsoft-Antispam-PRVS: <CO2PR15MB00736591E1AE4CE0680A64CDD32D0@CO2PR15MB0073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(11241501184)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR15MB0073;BCL:0;PCL:0;RULEID:;SRVR:CO2PR15MB0073;
X-Forefront-PRVS: 0751474A44
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(39860400002)(136003)(376002)(53754006)(199004)(189003)(229853002)(316002)(6512007)(64126003)(5660300001)(36756003)(50466002)(486006)(25786009)(2616005)(4326008)(31696002)(110136005)(53936002)(8936002)(6246003)(54906003)(2906002)(6666003)(476003)(6506007)(76176011)(52116002)(7736002)(446003)(16526019)(52396003)(97736004)(11346002)(305945005)(65826007)(86362001)(8676002)(46003)(6116002)(23746002)(58126008)(67846002)(31686004)(81156014)(81166006)(65956001)(230700001)(478600001)(106356001)(68736007)(53546011)(105586002)(65806001)(47776003)(386003)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR15MB0073;H:macbook-pro-52.local.dhcp.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;CO2PR15MB0073;23:836w7dSzt5V3aIha4OKwlmh8z7zpoqTO261by?=
 =?Windows-1252?Q?vFqSRm75JP3igNn/5Yrf+1lRgsWk9wccM6AFMLOUdBTT2R1c7CE9uC5T?=
 =?Windows-1252?Q?GRDxsGYrMa/H0yptKlW0lRlj9GbT6KuXp8lmsUXlWYNY7xgB1MaShuux?=
 =?Windows-1252?Q?xx0/N/2D4AIql2R4muJbt4UGr5PgPGhgrwhqr3/l8ByVTgI8fUq5/bHF?=
 =?Windows-1252?Q?rssUjwQ6GHzxhxEggRAabQoiIAIVFHWrV1TxPCQUw05c3LbGPYW6Y064?=
 =?Windows-1252?Q?szOlrCGuvKqJ+ftEV0hn8okxs6aS+ykpEyNX6iEemt4fdE+EpECxj2vC?=
 =?Windows-1252?Q?SywBI3gupTLhCEZ5KXW7ErgskewRDhG7253h2VQ53RFpl+aO6WMPWI9T?=
 =?Windows-1252?Q?UrGjwkegD9Dg5kSx3D6WMQ16Vr+9Mm8xp9yozgFGq8KXsLxL9zTk65E9?=
 =?Windows-1252?Q?sRj4T6XNRRTEy+Qz46Zjqe1dEhhuuGDtkXXfyIToiCBXssUElpgQx03W?=
 =?Windows-1252?Q?BXIrx7w03Dq+mW8wxgw+Kv1nCE9M+SjugpmQa2CXuCBHU3D4JzBggUx9?=
 =?Windows-1252?Q?isg5dYqQs7qEwis8kzX8QEAxhSKDY9Sqs4FBa3TVTmmtW46vLeNjMo92?=
 =?Windows-1252?Q?yGfVfx4met6ie9uCdF0696Y8vmtYnC05wR2/N6eSAleLgWOa1uPLyRvP?=
 =?Windows-1252?Q?lxWNTU4SCVivcvjc9Ocofmtn6Fqq0MwvDl0RgTT4LgT31s+jr/GuQnDr?=
 =?Windows-1252?Q?QBGfQSInL3TOIJJbxnQIDaMl7qdAMJhEmP1+60WP+Ww6Y3/7570FOWnj?=
 =?Windows-1252?Q?d149oj3hvnBWe5xNRxKTfJhmQ36rlF8SuFPEiLV+QPhNuaCBJm8VvySU?=
 =?Windows-1252?Q?nYhMt4gVI+OtUAUZF7H87yt2tKwzUkZcWwGD6xWGi1uKQzSAFLQdR7yC?=
 =?Windows-1252?Q?WMnEtB8U6bU+aXU6X0rTrdGtnfmvhHNw5u8w4g4b51JhRE9Jn5FbfS1X?=
 =?Windows-1252?Q?WAr0q5nXN8hk1KxhiweomTQQpKS9L/CUwIsX/mUEbDskNDeDLQdz0AsU?=
 =?Windows-1252?Q?VhA/8iuCZU3VjRycg4qQhB95TBuA5ST1DC8X9ZsAyho3CBgTQKPMWog8?=
 =?Windows-1252?Q?6trctQBl5aHdjUgEH+rQKNQicxOsDNAGBKdHu9pM3wfpxxcSdazLoRbq?=
 =?Windows-1252?Q?Ebqh+Nc6YaEju5YBtBvkGdYl+LDTyq4GU6hgMFRhiMYiB7EW3J1W33Lg?=
 =?Windows-1252?Q?B7v0JZHvZLDUC9i6/43lAXUlU1U3CNm6mxtmUK2IJ9g0RXC2Eg7iv518?=
 =?Windows-1252?Q?7H9GD9n1Fz/psR6TF8A+FTY6r6J4BVNUhPGhewGIB7D9xB68ZG60jaCB?=
 =?Windows-1252?Q?yEsGY+nepWcTNIQdb+mtzxAnyVA4U/bWMjm+NtGPjrrxZAYCRAdpB4HN?=
 =?Windows-1252?Q?/hKTWosgIGzxSu8k3eS8q8cdb0MYLyJgRePyyGpuRB9y+nJWrJwU1QUp?=
 =?Windows-1252?Q?GyWSQg=3D?=
X-Microsoft-Antispam-Message-Info: 0s9pY8TpWkqzT213Onsn0AsYGp8s+PeOB9b0Y+qFXRZCSSgCDlWJ9V1PSVtSEbwV2H5oiRSCgNkw9HnqdkdnXCQUlL3EsVIRLs4kYvg65jwgLxe8uvlaowo0aVuZYd0h9v4dO6rzGyLBSXAnEwCA4HBnGetOAHtXuQAhx81X/Qtn6SLWOggyO3tjR+gQv15JfmPaXiEeP8zkh5gF52/P+Wn3EzWElUdLdhH7DITLrjvZ8smrseLWc/wM+gySdywtV3jQDjZZs8suecJHN7/UA8yHm6f9kvedEpTeahuv27E8GR3XTLjmRLlDbGPvyw0bQUjFFTpTw2mwy/q3NuXKm9IFEmwZKcaJI58EIUbrmcc=
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;6:XtITJum8PZ8VYNJDfUYm4FUbJmWoTiLxt8BDTGSbHV02HXGKVAt2l2ZhO3anUefQB1qgvewN9Zt9Ci2zmDK10cSjYLjfqB97tBHIT1cHWT1lG1B/DM8Qsqz9l+wzMlEYSNAt5C5Nmjzids0/NI4Tp2M/kdfbEnX9+kAgsal4NqjxRfkPUMSkSuIKg9fn+/jpvxVrE96BxE3c/cGc2y5LR72UUyHX53gTNimVvG9xvpbxNgSqyIXL8PiwPUiZFXhAbtjZeYxyN6gBgQ29kQqZiKa9AkgQH+qr4EnwIdDIoQp1+WpPjjzA3v5u4ZznBspTJhapxHkjstFyrDEtWj+8Vt8zVzARYAubGM91c8MSUrxqCQNVyXEh1aMjM+UhrF0cvjdPzOzhoE/RygysFpQCHk5mnhPcz0QCKwRzYgDKgcnENyFmiQcf3H53OeBgtmjf4Ysy7gO7VAdR/NBERqmKDg==;5:a5QcEpFZiOkRmvybw54MUzLD5UhkpZFa2w0DzXGGclnRkhQuoLSZZwK9DTCk54MsR4dBTg6++aOx4VX4WX/oo/rsQxWPlu2e8x3r5wD/WVw86+8xqzEpIE6dp5k/oZGZB/AysMadHhv903r6tQ3bDOBD4b5ybiBNgG/HUj5uoUk=;7:gDsEqNQLBbJ+viPeyluWsPIVUh4khX6NvyyqW0U6dmRKvHu281cKcGonbr5TeBtWw4eFeaJP+f5jaAlWBDBb09JaP0ZcAy5G3XYv2nHws167OZ1FBsv6p98hcgO3WDt2sBZaMkFpqVaChM2SWedoZJAGBR3v76Lgmue39xvez/sChdbQxKbf4NdJ+J0yTm8+Lt2mSgSr37ryr5bLSJCFRnjCzsZr00GnFMRlNRt+ZF8dqcFE/wcFt6tIufblGDOK
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0073;20:X4GJLKLzsMei+BKQk3GXCG39kF2Ii5tqgw+bHSwcXQrp745EAOGdl8LdNVkCh56cmd6kXkAkbqNFxBluI3lNUw+tZFyTwSrvdaaJV1JrC2NMleUtoqA081DWCf7qzy8rTI1BqUJLcwGpzrzN9lMLIFQexyvXjw1MpGEGYFUpMQY=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2018 04:23:51.1742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 590f0b9a-3d46-416b-0f3c-08d5f7669682
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR15MB0073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-01_01:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/18 6:35 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the net-next tree got a conflict in:
> 
>    tools/bpf/bpftool/map.c
> 
> between commit:
> 
>    573b3aa69406 ("tools/bpftool: fix a percpu_array map dump problem")
> 
> from the bpf tree and commit:
> 
>    2d3feca8c44f ("bpf: btf: print map dump and lookup with btf info")
> 
> from the net-next tree.

The merge looks good to me. Thanks!

> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
