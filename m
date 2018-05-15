Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2556315-1526384533-2-15221867438635752092
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526384533; b=jCs4BcONlj66etmELNXR2izA1sHRG8vsu16H39JtwUxzAOR5sB
    GQGpctmXbsZ2a7HZWLWHY8hPc8nnH023yUyN/oC6paUJOYJklgAHZGfYFqMQ7I1A
    f8E5Q9172ZqF+oLGtAvnLbH9IbqXRcbia7+5CQBAg54P8WiO/l6e4GjH8c5/UodR
    3UoDNgNmLosF3FnPO+uM//IfSuLx7vDG2yi8/wSm0pMDncS5uW6x5AsF5uT1CAwY
    09qix8Pdct4+ei0U3AWHWhR+9z8LcJg0uJHG9goxgnRG7smVh2Op3GGuJ9amvhY6
    fpt1jXhRVMPPrrmLwekg8BddT5BAfLyx3dZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526384533;
    bh=RhnkILG+g7dLop0SySYJ4b+xtpTs0Bnbiy7ZiUZWvWk=; b=NMnnK+7jkTOe
    p50bBeMPrAXWy06DzQhnpaYAcQq9O0qZX6KYhx+F+FrbIH53+ndUG249+khKEMx6
    UktanZEZOzm5+rtp/GGZziqCof3Rz75c9XR+l2SfBN4upBi7Jkm4WqthRDe/G/EB
    swf6NZ+rQkN3keBhWd1IDfGPPciLLA8l4SqUx7Dl8wNLPJvnziiGjfqaARHSgkll
    N4NFSz442S2xxX1t1XQornKOBCMs3ZIyYNOjJrLfbELIGrGyS3VPLDnjmzpboDIr
    Y/yazHpOAozamMIFWSXcw/9YFvuuG+VaObjmH0LgjyE1UKLmtzGwVHnrvkRiWmqK
    Ls/y5shz2w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=aBU6ML/f x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=aBU6ML/f x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHeEgp7c+GhftvqaTJORgGoGmnio687u4eOqjVr57+AvqulSkaPxSmP5Deg3VafiHF0MPTlhKUl+NYk655Cfi/rtS/ILXWyV/PNIdVdN7pwfXXZocv3V
    gHlPPOA+soKIxqYKRReO7T75v0Jz/CnIhH2Tx1WSdtOn93G9Qph0vlTEK2CnH69p20AOlhR4k38QUsYTF+HtBUlMavrlKKeEl3HiXY94X1waSYBRoQEmOnXz
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=ddmsiizCI9YUcsR6ugwA:9
    a=HJBJOVHYWg4tajna:21 a=KQrKn5Vb5uwFOuqi:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbeEOLmI (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 07:42:08 -0400
Received: from mx142.netapp.com ([216.240.21.19]:28589 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752836AbeEOLmC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 07:42:02 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="253903614"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
Date: Tue, 15 May 2018 14:41:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515111159.GA31599@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM6PR0502CA0010.eurprd05.prod.outlook.com
 (2603:10a6:209:1::23) To MWHPR06MB3086.namprd06.prod.outlook.com
 (2603:10b6:301:3f::31)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:MWHPR06MB3086;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;3:gu2I7zGWvq0Sw+y/rL5eDTHFUnjamsy/5gN/Yk/Jrc9VMwC8LmvCZ5sFCNTsfJqLetLExn8QRFZDE3kk/fWJl1mZ7fbo5m1Ib3YlupxxMCJbGnGiY6PAnLTPw0Ug71lMpYvJNUcDuqyV/0DAKHmVoeWfETk7idaJosHcPIqGQwS0y8uxePPNjQGK7S9ZaUotOEDcvFisDj8sQS8ImnYem0pe/r41KTO8es07amjBSDiRNrpka69qOyUDX4fQQE8O;25:V4DsEMzA5kigp04r6huUZOCyvSRcG9ou2i/7aFcAVDe6zlaoXZXV8LbOGIVUlgtQuIxMhpUO9SjxoHILPs6iIVgS8Iyqd3NkZO73UFPCcM/Jw/z6ZNb8JGe3swrLJJHtUoaP12tJroCTM6QnouPtTh/E5quuCemcYWaLrtEYHHgLk4X1xaOCO3xo5uEOOob4+9X0O8IqyDLdwmw2SX5s3Pj+V2Q8GMdee7bgG/JQLtBfBQ3EoXjik0XkPcmn4UmqJpeTxRzxeUg05XVdNjKYqkted+y1MEmTGVkx9rnQESFighkBBgp4cC+YJvLWo44Yt/qvM8TuF+AQ0mvgc9b0Uw==;31:S7Npspb3yNSFNMkhpSD258o/ZNZTyMqkPLWPSWIn9aA4H8hXNZiAwvmft+VGrLzkMzQESaGxw+41OxTAvy3DuOXoVNmhwWQBEWhLhrjzyfrawc7WSgxNhmTrK8j6M0aolzWT2COSfx+NuQtkvOUVgDsVmkgsuG9JDc4b5xBDX6gqgaHu0lHxOK7R5rEcSv5uCxb05LTgrZsFFseW7ddWz8epzADVeY/JjSu0kShtXpE=
X-MS-TrafficTypeDiagnostic: MWHPR06MB3086:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;20:rCBd7MCMorOAKz29NXzw1zY0MYgkLv2LXFT1nwdo8wC7sGcG6zqYutrW3RP3GFos6BjChglLqRQx8vt6fwZBpIGgbA++vaGb27bcSTCJ9nmW3cNNfzewxiRVShGJjbbP5vHYGW8LI/9WvHZ41AdStPpa5GavaiOPJ/xLnsyXJHAo8TSlIZK+JbzCUmQumZwQUptxHQLCNPzoS/tWeiZo00pbKMvjodziZPTCadnug8f71SsMfkrHwaSW1NZZIkqPcbM1QORvtA7Jk97G6LcGu+GfadQfK0ALmteRPQrdbfE4vHKvcxsJTpOQthFupW1ZBpwTrUaW2NF9piceYQOG8EGToVqwuk/c9O1X5tO+nhc0zndiHJxCHDWP45nvC9NKCUd5eqNf0KKfeJ1kQegQ6RIlcmlh55c34EPAo5aou3gL3V9Ia2GpLAfVVL780ovAcGKHpXdJd1dW89QnobFVR833MrFq/sUl60ycx1LnQr5CaNI1W2/3hCcns+lzNgbt;4:fd+k7yaUNRwqt0zfAeAfa0YFlbFNGkC9qEEpB0CC9Erqco2CZrkZrcwCMv8P07rRmjfBHJBRPfto7i3lAfOy2EvVJyxvwZqD6n5cCkraOYx9ZKbZck5LafLM2fQ4lowwJmK5Yn46P5HeT1owCKOo6Ljh0VXaVNeYxJHa2bd1dN8J4ZLMlnr4I3ia2jyGi7C0CmD4lHpt+o2A2r9VXndsJ0ZqBufQUIa6p+6ve+eV55lrQF+jlZsfNnQLOJ8rr9FnlMvKyZB1OQ9crXg+6A7mxtP9JmIxbCo84o5E0tB51q/3pTSEiqZkv7q41k302S9P
X-Microsoft-Antispam-PRVS: <MWHPR06MB3086C7D8BF861384CB996EE8EE930@MWHPR06MB3086.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR06MB3086;BCL:0;PCL:0;RULEID:;SRVR:MWHPR06MB3086;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(366004)(39850400004)(396003)(346002)(376002)(189003)(199004)(6486002)(5660300001)(54906003)(7416002)(58126008)(31686004)(76176011)(486006)(8676002)(65826007)(52116002)(23676004)(52146003)(2486003)(956004)(446003)(476003)(53546011)(11346002)(59450400001)(2616005)(68736007)(386003)(64126003)(316002)(16576012)(8936002)(81166006)(31696002)(2906002)(93886005)(50466002)(229853002)(81156014)(7736002)(47776003)(478600001)(6916009)(6666003)(8666007)(230700001)(305945005)(36756003)(105586002)(16526019)(72206003)(106356001)(26005)(97736004)(77096007)(65806001)(53936002)(65956001)(66066001)(6116002)(3846002)(6246003)(25786009)(107886003)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB3086;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA2TUIzMDg2OzIzOnd6TG1SQ0R0V3NxOE9JUFd4dkRuNnpRdTlm?=
 =?utf-8?B?UTN3WElKV1drS3RLNEJIUnE1V212ekd2c0ptWEVLSGxHQWJ2a3ptUFlTbjZU?=
 =?utf-8?B?ZVhWNUZUYUxWekdkS1ZhUnRlSWZ6MXVvb3ZnY0xrRkszaFVTSExNTUJmZ0tQ?=
 =?utf-8?B?ckxUbHVyZ2kzQ20vTkt3Z20wWXVUOWF2clRnQ2RTZGVuaGdHN1JOVDIvZDk3?=
 =?utf-8?B?UW5LTXFVazNZY3pFaHMybU55dEU0OHArblFxNWZhcWlXV0VaYnczS3p6ZEd4?=
 =?utf-8?B?VmJjQzdvZnIwMk9PdUw5Ty9oTVVZUGh1cm5yN1RwOGtTQ1R0VjY4ZzE0L0tF?=
 =?utf-8?B?K1J0bEFTMGMrSXdMZjlRbHlQMCt2VFgraDdRYVdSRWdOQ3MrQXZxeHdtdnpy?=
 =?utf-8?B?dDR5ajdKSVpFQUxjMitvNDVsZG0wTTdpempRc2xHekF1Sk1jTXRoWmc5aVQw?=
 =?utf-8?B?cUpLeHlZQVczSWRoS1BpeE9jWTBDeWUrcTZxeHMwRzZ2M3k5bHo2NlNSRzJW?=
 =?utf-8?B?SU5ZMTcxbG8zV1pRV1FqL2lZNWdONXZ1SEh1aU02cFRvamZPdUxIM2pzUFJm?=
 =?utf-8?B?T3NWNy8wcEEwbEJKV1FNU3BiM2pPNEk0Y25WdjVreDFXWkQwa1JJQ041ZHZG?=
 =?utf-8?B?YXVQbGlHRFdjcnhsWUdTei9TNGI4UG52dU1sMHBXQlRwdVFiV0U5aW54bUtS?=
 =?utf-8?B?MUlIaEVSOXNINE5CYXhETWFWcG1CK1JLYVNqVWpLVk5XWURWci9Wc213RzVr?=
 =?utf-8?B?am14VDRxZUZlMnU2UFc1YXZrRWFXbktmckdWR1VFaWljY0hLYVpTdUFDbmI5?=
 =?utf-8?B?czk2Vnp5eGp1elBRWWFKek9vSE1QdHRxUW9CRVY5WEVWL1FSRjV6SnFaalE1?=
 =?utf-8?B?UysxL1VQOFRPajNaVDZaQ1NZWDdKM0doeHpXeUFhcENvT1lyaDN6ZWUrL2JJ?=
 =?utf-8?B?UVpSQlFJSnFZeXlJVG4wUjd5NnIwNGNVRDBnd29GbElzMzJWM1BqZ09rbklr?=
 =?utf-8?B?UTZQb2FIZW5iQTlEK3EzYW5rMldSTER4TDhhYTJoa0tydHdWVHNQSVhRNm1m?=
 =?utf-8?B?RlFvWkNCQnJ1UTI3MkpmRDE4MUFMektOT2FXRXBNRjlMZjJWMnRNVGlOTDdW?=
 =?utf-8?B?VmJ2ajAzL2ZIVFBLa0ljWUxEaUJxcmNhWnJ4YnpkS00wdWpQYTZZSFMxNWlO?=
 =?utf-8?B?MFZjNStwK1pTUVRYc2lkNDhUSWdqci9GVmlzT0NDYnpuL1M5TnYvV09yNUU0?=
 =?utf-8?B?VEcvMFphTTQrNGFBV0RCM0RBc3pHT3BqVTN4L3J1c0lsK1Y3YXpCOHNXR1hK?=
 =?utf-8?B?b0VhS3dnK2RRdHQwQ090RGdmMW9sSEdJNUdhWDRXWExvbUdNSGRRK254S05y?=
 =?utf-8?B?L01qVFJGSjIwOENpV3RMWS91SlJIVGt2WmdrVCtEU0xBMDhTVkFoTUxFelhy?=
 =?utf-8?B?MjErRldQdDNMcHNGSFBpa3k3bFRpK3p4bjdSS2xZaXZEc0ZxY3R5Wm9xSnk0?=
 =?utf-8?B?R3dBQWFTa2VpcVdqUzZ5WXRlTkhZOHJTR2ljQ3VoWjMyK0Zkb1dGa01ubGRs?=
 =?utf-8?B?U3lzSnhSMmZKYVpVTzZ0N2ZkRURQQ2hPSmVlTUw2OE1iNjE3Qk0xcy9WUkVB?=
 =?utf-8?B?Z21WRHU5VEVrNnluRHVOMFFPbXVjY0F0YjZxNVZSeWI5TjBJQ3RkN2Z4SWw4?=
 =?utf-8?B?VjBVeDh4eVpMY0xBcGU5MHRWTXZnaTVaM09zUklRRDErY3hJb2M2YjFGTEVD?=
 =?utf-8?B?SzFKc2hPWE5lTmhKSUFYL2pCWmFVN216Y1piNzcrTjVCK21vNUJ3czQ4bzI3?=
 =?utf-8?B?RkYzYmpGaGZ1VHZRdks2bGpqZHh0TUJWSFRpb3hZbkpoVDdmdFp4ck00dVpp?=
 =?utf-8?B?MzQ1Wmd1RTRNRzJBeGZDMFBFS1gySmw2ZzNRblpzdE9BUGxiWWpJem5JZXNr?=
 =?utf-8?B?cHNTYk9lU0pBU0tnR1c0ZWVIK083bFpxalFOMkFjODJpODhMQi9GcDYrcWs0?=
 =?utf-8?B?emxtTTNaeVc5Ri9aUi8zbUFPeFEzMHA5OWU0ejQwdFRYS0swUVZHVjRXdVBr?=
 =?utf-8?Q?zOioDJnO6FQjeoYtwEkPmV3I0?=
X-Microsoft-Antispam-Message-Info: ZoyqiF1Y2GPFxhRnhRf7Z0pVRQLLnOndJddR3DWoa36woc8JRqaMixa86BUBH5RvdpZAs6yvuGMbeks0fDtIcevHilQ1SougVJ9m7SQmecoE02Aw5tYRxwCBT90XfIKkMLdQB0JhEdLvai24NReYQe3Mf+dmL8QW/4FX1/egSUXjZ7qreEVFuQIQCnLXLtLP
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;6:FoPePRE54Gyx161JXuBgeA4hkezhQ7PNGVvuU+1tbYFXYk9LucEvHDEvLfBpSpzBB5cxO4YhZuOjpNTXxoTsK4HPBRZS6PbEH9NOlQHG2Cg1DgCiIrGnrsCPGZLN+6rKlU4TTJVMaMAx934bu5M8KqFndKtucH7plGkPgbqqZa75OOCaFk4v1oKG2J1V9ysgAoOZjmnmx32NWlN8xTh8krB6PwKDfXGg0LYxRiUV8xowYk0MqjqaP6AOePQl30VV5A4Fj9Q764NaRnNeVGUwEnClkvw+xuE+qwm85XFbW0+s62oAb2Y7alOQAOSaw/N1dE/F95Q1xv49VqrnliM9bSJtJIcNpMNbFiF/al7H1PhvonV3zzGU5i2Dr8VSjcgwcmJ0zuT320J2FtkDa5X6aMnFas3gvljjalOua+LrNeiXCgp4TkIDWjC4w+2+3HsyVwykxpJRxEeLXrBZMUrPsQ==;5:EtLVV+qacZKhU8Xrx53wjzXl0qt32jULhHcfiJGr58DOjLFSx7G2AtCYsZMcR1FqrtNZxxaPgNzEzOAoD05ox+RGDvUtUFxKcf1CJejYznmkrkHG/0ip+l6301sxKMJvn0HJrQO6ozJu4R/65U8OuWa0aVcAAzv1EESmA6c+2Pk=;24:imFytOIEdj3+N4Yoo360apNWv0ue1GCL4gtVQ7H/c5ITbUBboa4X9aBumQQXmiQ5XoxfZCofImKonXckFnLl/baPprISaZvtyXv2CVLSi0s=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;7:h8km71t8RG1WJ8T6e4aCBb+dwe1tzLhSbgmuXTEPmxP0JIElcUGcsc3984cAkKNBZvPARBl0A6Cr4zauknfMwnyZskuBz5ZE5u3Ecggl94Sa2L/3HdyNfP9OTUkIEm1XG++FdhfZnDx/GoWtn30zHitlEPor2oG2oNv4zISzNbfSoQ6v0xke7LPAVVvmH+4HcuTUzVBg3KaZqRvuFDiqoa9BmyN7uDHfZP5X9Kek/B5Le+C+ewtYmZU5F4cm9fSJ
X-MS-Office365-Filtering-Correlation-Id: bfd54457-ff23-49de-d766-08d5ba58dddb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:41:53.7330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd54457-ff23-49de-d766-08d5ba58dddb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3086
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 14:11, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 01:43:23PM +0300, Boaz Harrosh wrote:
>> On 15/05/18 03:41, Matthew Wilcox wrote:
>>> On Mon, May 14, 2018 at 10:37:38PM +0300, Boaz Harrosh wrote:
>>>> On 14/05/18 22:15, Matthew Wilcox wrote:
>>>>> On Mon, May 14, 2018 at 08:28:01PM +0300, Boaz Harrosh wrote:
>>>>>> On a call to mmap an mmap provider (like an FS) can put
>>>>>> this flag on vma->vm_flags.
>>>>>>
>>>>>> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
>>>>>> from a single-core only, and therefore invalidation (flush_tlb) of
>>>>>> PTE(s) need not be a wide CPU scheduling.
>>>>>
>>>>> I still don't get this.  You're opening the kernel up to being exploited
>>>>> by any application which can persuade it to set this flag on a VMA.
>>>>>
>>>>
>>>> No No this is not an application accessible flag this can only be set
>>>> by the mmap implementor at ->mmap() time (Say same as VM_VM_MIXEDMAP).
>>>>
>>>> Please see the zuf patches for usage (Again apologise for pushing before
>>>> a user)
>>>>
>>>> The mmap provider has all the facilities to know that this can not be
>>>> abused, not even by a trusted Server.
>>>
>>> I don't think page tables work the way you think they work.
>>>
>>> +               err = vm_insert_pfn_prot(zt->vma, zt_addr, pfn, prot);
>>>
>>> That doesn't just insert it into the local CPU's page table.  Any CPU
>>> which directly accesses or even prefetches that address will also get
>>> the translation into its cache.
>>
>> Yes I know, but that is exactly the point of this flag. I know that this
>> address is only ever accessed from a single core. Because it is an mmap (vma)
>> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
>> only that thread any kind of access to this vma. Both the filehandle and the
>> mmaped pointer are kept on the thread stack and have no access from outside.
>>
>> So the all point of this flag is the kernel driver telling mm that this
>> address is enforced to only be accessed from one core-pinned thread.
> 
> You're still thinking about this from the wrong perspective.  If you
> were writing a program to attack this facility, how would you do it?
> It's not exactly hard to leak one pointer's worth of information.
> 

That would be very hard. Because that program would:
- need to be root
- need to start and pretend it is zus Server with the all mount
  thread thing, register new filesystem, grab some pmem devices.
- Mount the said filesystem on said pmem. Create core-pinned ZT threads
  for all CPUs, start accepting IO.
- And only then it can start leaking the pointer and do bad things.
  The bad things it can do to the application, not to the Kernel.
  And as a full filesystem it can do those bad things to the application
  through the front door directly not needing the mismatch tlb at all.

That said. It brings up a very important point that I wanted to talk about.
In this design the zuf(Kernel) and the zus(um Server) are part of the distribution.
I would like to have the zus module be signed by the distro's Kernel's key and
checked on loadtime. I know there is an effort by Redhat guys to try and sign all
/sbin/* servers and have Kernel check these. So this is not the first time people
have thought about that.

Thanks
Boaz
