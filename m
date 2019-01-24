Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AB6C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB642184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="u9V0sZcg";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="Vx6ltav5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAXHBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 02:01:05 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:38984 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725287AbfAXHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 02:01:05 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0O6slNV027374;
        Wed, 23 Jan 2019 23:00:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=fc9IXfGdE9sM+XtxwZapVJdQk8emv1URaobNKTvsalk=;
 b=u9V0sZcgOT8YCSQrpiCez6aMncnU+edrc2de30ykCLtlni+9Dt0tONRapWKusn5s8/ct
 15xLhi9zWxQDcoGuo7RahE34zQdcK6ld3Ds8/vKSv7uhKdk5joJvaCQocFRbD7EbAACQ
 UYJushr+Wmh+Vugkh6gD2wi/Pm9as5y5UInHRVxFed6XC/JXFaG8++knnig8+1acMefQ
 bsqWTqcRV9nP5YCt0ARc6LnJ2XBZKhz9ufoTthdfLxs8Y7o2hKx0rvBmJSs5loLs3S6G
 fycr47O63LfQsVavc7RwiTpg9dEtDhUU9dZ69c7P7zJ8B/AI+7E9FT3SNxDoZZO+Momx SA== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
        by mx0a-0016f401.pphosted.com with ESMTP id 2q6w0kkb88-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 23 Jan 2019 23:00:48 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Wed, 23 Jan
 2019 23:00:46 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (104.47.48.54) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 23 Jan 2019 23:00:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fc9IXfGdE9sM+XtxwZapVJdQk8emv1URaobNKTvsalk=;
 b=Vx6ltav5ZSZpRmFDDhCGyh823EXtrif/DhcF7f6Xxw0OWATHpdPqBc9zpuFBCSLlS7RR2oXW0olON38QwFPaa9GZfxcMA90GD/YZLjhouW9EbiaJ17DatjQRyxapJCXCtmdJZlqYrqSmD5OSf+niulX4eoWO6b1KXFrXSIjctFY=
Received: from DM6PR18MB2460.namprd18.prod.outlook.com (20.179.104.155) by
 DM6PR18MB2537.namprd18.prod.outlook.com (20.179.105.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Thu, 24 Jan 2019 07:00:42 +0000
Received: from DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c]) by DM6PR18MB2460.namprd18.prod.outlook.com
 ([fe80::bc61:3698:d8a8:f93c%2]) with mapi id 15.20.1558.016; Thu, 24 Jan 2019
 07:00:42 +0000
From:   Shijith Thotton <sthotton@marvell.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
CC:     chenwandun <chenwandun@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Wangkefeng (Kevin)" <wangkefeng.wang@huawei.com>,
        "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>,
        Ganapatrao Kulkarni <gkulkarni@marvell.com>,
        Jayachandran Chandrasekharan Nair <jnair@marvell.com>
Subject: Re: [Qestion] Softlockup when send IPI to other CPUs
Thread-Topic: [Qestion] Softlockup when send IPI to other CPUs
Thread-Index: AQHUsFLrrYWN2sDbSEeIkTghgif1Ug==
Date:   Thu, 24 Jan 2019 07:00:42 +0000
Message-ID: <DM6PR18MB24607427B3B2BEAD80A75780D99A0@DM6PR18MB2460.namprd18.prod.outlook.com>
References: <95C141B25E7AB14BA042DCCC556C0E6501620A47@dggeml529-mbx.china.huawei.com>
 <20190119235825.GG26876@brain-police>
 <20190121142127.GD29504@arrakis.emea.arm.com>
 <20190122054400.GB6445@brain-police>
 <20190123181530.GA234790@arrakis.emea.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.93.218.67]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR18MB2537;20:j53mggkNk3vVKWLCIN0+heKAriIPd2fKN5gdLL9aTfk0sAwVSkWxtq9PLOSij2CMtxzLIAAJfzJtJIXryaYWPKC46zcpp7gIYd6Uedbz8Q+KGjwYjrWx92LoOQfD4uIpN72W+MRsSA7oQLrsOqKcNYqWo2SeiXGvDrGQRu/G5js=
x-ms-office365-filtering-correlation-id: 195d9aa4-fa8f-4086-2638-08d681c9a80d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR18MB2537;
x-ms-traffictypediagnostic: DM6PR18MB2537:
x-microsoft-antispam-prvs: <DM6PR18MB25370FB599466BE96CC69F34D99A0@DM6PR18MB2537.namprd18.prod.outlook.com>
x-forefront-prvs: 0927AA37C7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(396003)(376002)(366004)(189003)(199004)(305945005)(102836004)(446003)(6506007)(4326008)(53546011)(93886005)(186003)(7736002)(7696005)(26005)(99286004)(76176011)(97736004)(110136005)(54906003)(55016002)(486006)(476003)(71190400001)(3846002)(229853002)(74316002)(6116002)(6306002)(71200400001)(53936002)(25786009)(316002)(9686003)(8936002)(14454004)(256004)(14444005)(6436002)(8676002)(105586002)(81156014)(81166006)(33656002)(2906002)(966005)(78486014)(6246003)(478600001)(86362001)(66066001)(107886003)(68736007)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR18MB2537;H:DM6PR18MB2460.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yX6EZNlyBevqX9BqJVd4P14IUogxtVgrvw1MRTlH3o1roxwOMkPjtfREBuOWPdpfTMKG3XfTA2w6YSSMtzyax81oN+hSe4mvKdiiwxX4PR+mZqe3a8s402FkY3sAec4jaKwnoWBV2viiDSQx0O/yozAQqLlOJB9aCtTAKPU/5XI2byGYVZjDEkeaOYyZgXpTN3njmhAsf8vI4WkhByTfMrv8eCjHfO1aj/9+PTaQ22ftNpYSlb89T5qo4t8fYmaSmEt4B7+H3mp425W6i6zCYoRbYdQAbMqTTwNL7jLiV5RDffLvMb2fSk2bCHCvIRZpKEKIX0wLfkw3nD/LktcpuCjskK7VTv2roO+BgD4O41EtVYjXS/8i2O7ToteLsIMphzCeygQIIgrQ7q2FAbAs40oqCGcvn5h9viqL3hM2vo4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 195d9aa4-fa8f-4086-2638-08d681c9a80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2019 07:00:42.6722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2537
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-24_03:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901240049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,=0A=
=0A=
On 01/23/2019 11:45 PM, Catalin Marinas wrote:=0A=
> On Tue, Jan 22, 2019 at 05:44:02AM +0000, Will Deacon wrote:=0A=
>> On Mon, Jan 21, 2019 at 02:21:28PM +0000, Catalin Marinas wrote:=0A=
>>> arm64: Do not issue IPIs for user executable ptes=0A=
>>>=0A=
>>> From: Catalin Marinas <catalin.marinas@arm.com>=0A=
>>>=0A=
>>> Commit 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cach=
e=0A=
>>> for kernel mappings") was aimed at fixing the I-cache invalidation for=
=0A=
>>> kernel mappings. However, it inadvertently caused all cache maintenance=
=0A=
>>> for user mappings via set_pte_at() -> __sync_icache_dcache() to call=0A=
>>> kick_all_cpus_sync().=0A=
>>>=0A=
>>> Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cach=
e for kernel mappings")=0A=
>>> Cc: <stable@vger.kernel.org> # 4.19.x-=0A=
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>=0A=
>>> ---=0A=
>>>   arch/arm64/include/asm/cacheflush.h |    2 +-=0A=
>>>   arch/arm64/kernel/probes/uprobes.c  |    2 +-=0A=
>>>   arch/arm64/mm/flush.c               |   14 ++++++++++----=0A=
>>>   3 files changed, 12 insertions(+), 6 deletions(-)=0A=
>>>=0A=
>>> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/a=
sm/cacheflush.h=0A=
>>> index 19844211a4e6..18e92d9dacd4 100644=0A=
>>> --- a/arch/arm64/include/asm/cacheflush.h=0A=
>>> +++ b/arch/arm64/include/asm/cacheflush.h=0A=
>>> @@ -80,7 +80,7 @@ extern void __clean_dcache_area_poc(void *addr, size_=
t len);=0A=
>>>   extern void __clean_dcache_area_pop(void *addr, size_t len);=0A=
>>>   extern void __clean_dcache_area_pou(void *addr, size_t len);=0A=
>>>   extern long __flush_cache_user_range(unsigned long start, unsigned lo=
ng end);=0A=
>>> -extern void sync_icache_aliases(void *kaddr, unsigned long len);=0A=
>>> +extern void sync_icache_aliases(void *kaddr, unsigned long len, bool s=
ync);=0A=
>>=0A=
>> I'd much prefer just adding something like sync_user_icache_aliases(), w=
hich=0A=
>> would avoid the IPI, since bool arguments tend to make the callsites=0A=
>> unreadable imo.=0A=
> =0A=
> I wonder whether we need the IPI for uprobes and ptrace. I would say we=
=0A=
> can avoid it for ptrace since normally the debugged thread should be=0A=
> stopped. I think it's different for uprobes but changing the text of a=0A=
> live thread doesn't come with many guarantees anyway. So I'm tempted to=
=0A=
> simply change sync_icache_aliases() to not issue an IPI at all, in which=
=0A=
> case we wouldn't even need the bool argument; it's only used for user=0A=
> addresses. So the new diff would be (the text is the same):=0A=
> =0A=
> diff --git a/arch/arm64/mm/flush.c b/arch/arm64/mm/flush.c=0A=
> index 30695a868107..5c9073bace83 100644=0A=
> --- a/arch/arm64/mm/flush.c=0A=
> +++ b/arch/arm64/mm/flush.c=0A=
> @@ -33,7 +33,11 @@ void sync_icache_aliases(void *kaddr, unsigned long le=
n)=0A=
>   		__clean_dcache_area_pou(kaddr, len);=0A=
>   		__flush_icache_all();=0A=
>   	} else {=0A=
> -		flush_icache_range(addr, addr + len);=0A=
> +		/*=0A=
> +		 * Don't issue kick_all_cpus_sync() after I-cache invalidation=0A=
> +		 * for user mappings.=0A=
> +		 */=0A=
> +		__flush_icache_range(addr, addr + len);=0A=
>   	}=0A=
>   }=0A=
=0A=
We also faced similar issue with LTP test migrate_pages03 in past and this =
patch =0A=
fixes the issue.=0A=
=0A=
http://lists.infradead.org/pipermail/linux-arm-kernel/2019-January/623574.h=
tml=0A=
=0A=
Thanks,=0A=
Shijith=0A=
