Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2643336-1526390373-2-6464246994186117670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526390373; b=M0qdmCzsneTfvps54BhdrDzfZQYf76nVRjxgjwjWOovUXmgN/q
    eYEMgU4TiYiCEgyRe4OaWmlQQ9rLObLBoqFx6P6ucNApiiDSmxqguCaZW6Pb1Alc
    8A5niDcPXJsTJFzjjuYO3ilx8Mhd0av9OAshf4lau2+yOdCY6k9WroHsNU4fdoua
    wV551vrK1rKkruRk3StWalctHpvonbDb4fwSW2sKU889cqUY+2sgGXFlSAWA/sBk
    algGvXYy625vwNp+b8E6VkYbyLLHrNO2mgL+5rFtCwjAvU70xBVJDv85d/ca2zY3
    mpbxCJrZ1jtAIFJ5+mPOlcZob3DKb0yo1puA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526390373;
    bh=oxk5crLHyGrJwpJA3Zz6P3GrB6N7Rtmz0cNUGGpMOlU=; b=RUd+fmICF5Wd
    Eb4ArzDrNPAS5ndgNN1udp1pbull/ONiiO3np1oVDBSvzIulYVt4wzCl9mVNeUn0
    crtA76js1KQE3cY4WVAaeaHIHz2hejD9TMVk05n6R92zsahI4UpZEHp8L8ZGD4hq
    fXjzRTEJ9yix57xQO5O3AZlODVUOudhahn3zHr/u4dra26z3PFPrBEHHKy4ULdGn
    Myi56ztDRTf2gDJ9lPXtHns0zuxRlHsyOg4Ckod7Zh+FY1zFTN1B0C6xI4b0g1W3
    WVCnrzkQL6HlPpeRnrPQGKDEZaT7ophDn0CndkTx4YDwOdmi7NysxfClEtM3HYCP
    WR3z88SDTg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=XdgFQEP0 x-bits=1024
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=XdgFQEP0 x-bits=1024
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
X-CM-Envelope: MS4wfBu7nxiNhYJTMIt+40ZHT10inAmnMP6A0HFMGkrMusQKpK2it0uSHQGufFrdFnsBj6+vh/Z1AlL2+QeFzYLgiCtnHpBlQRCp0JH49apzerqkfScrewUb
    1M7LwDe43Rb2NQLIcmmYfYZh8E50Pq0/Mq3AGsdIEfVLyZ6eTNNZNPJuZjTRC1IL8QAY9SX4O6evZLnfKqK5IxXm6HU8TTAuinYEC2gj/c2K6SACz5Hq36EY
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=NydCiPpRAAUMs674UZYA:9
    a=uiW90UQV7qpOZlv4:21 a=Gvzqddf7MxMMx5Bp:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753030AbeEONT3 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 09:19:29 -0400
Received: from mx143.netapp.com ([216.240.21.24]:59633 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753001AbeEONT1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 09:19:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="259077172"
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Mark Rutland <mark.rutland@arm.com>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515120750.lro2qbskw5cptc5o@lakrids.cambridge.arm.com>
CC: Matthew Wilcox <willy@infradead.org>,
        Jeff Moyer <jmoyer@redhat.com>,
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
        "Rik van Riel" <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <a9a3af34-6ea0-5639-e9b9-2aa11825f11b@netapp.com>
Date: Tue, 15 May 2018 16:19:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515120750.lro2qbskw5cptc5o@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR06CA0017.eurprd06.prod.outlook.com
 (2603:10a6:206:2::30) To CY4PR06MB3078.namprd06.prod.outlook.com
 (2603:10b6:910:58::32)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:CY4PR06MB3078;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3078;3:kYn/50gBdvBao7s8H/86tZwlZF1HcAeWkPzWCmKZGGVI7AXBlzNiEL6+IDx5CTpHs8tSsgkmmeycKbW10+OVOJ0ebbfgVJqxYAYrj8PwRLkdlpb18Xn1dVutYMP8k1iFMuVZRkZAlUUqXG8b8CNA7CvJTtUw0gWo9D5ytesDm2n818zw0et4aJmX0DLMGdAtJ0POyiWtmrp2w1J0aCznXGZJncd9itlxDznUc96l1PLMBtPlR57inJDTk+cPd9ml;25:hL3LacEtnLc8n5w0Wb+UQ4NW7agXgyJQnbSGTHJf9TsCqIh4ke73QelWgV1H+k9qwbQztNf3yU5/unVFa5BlsDYoPHRAgJ3qjXMpMsnHk7tH2JjxjK11Vbf6CoaDdggazLPZZxgp+TNh+jEH7hLc1zbihuXFUwiClMEGCWC1I/39wTEw7tml0+haaCblGY3ujH2iBnznbD0g9tK4nB9Fnn+reWBaa9wF5lGlAhMse2wxRvVsJuXPbhIHn5pHYPW5pQYULdEeu5wA/ITgQ5n8xXqerDL7tTJ3AhKHZjwM3rWthavWcXDTncw2/40Q+Ia9KEDREiseSuwoJ7MchtA2kQ==;31:OD/EhrUUDGXvnfMv7ZubHJ8RvgoFLf0PnywgfqSwBWXoXjXhA8+2ZwqZoyyOqy/XGQXn3nwWB+69xMSU2iVVpRYD9e7RrL3EaGHQAWwp8SNPM3sl2WxWpidpdCsZB0URHqjlojJ2r6Z1pXfEylepK4BJOIRt1KVae6JtptL9FKT/fCKv9yr5MVjrwEhMQr9h8QXFdRWt+lxf7aIunBdZHYZHlI3/Lrwu1dLiKgmaeQY=
X-MS-TrafficTypeDiagnostic: CY4PR06MB3078:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3078;20:nzlxUlvbNvxJmF6ewy50sgC/cbX+x7ax0VA0ivCWsmnB6gOxFbb88cxHfS+CV4UkqE6VjUbIez+2w/eD47TThS86MnYTsmjWVtMoe1Ip30N87SIg0lAI6n22J79Y5HvKQlQHb7D3R1XzKdZed9TEsseO47EJsu3gcBkaaCz5TKDTkP4ybF1LKxO5nbtjg7KolgJGaoksXedhGRD6AIAc5z+M6YsMkhT8lFItWo9JWVVRT69UMv2Ad+UYnTdYBAK3xKil7k+KASgcqUIUqKEqCwEl2rpUgKKVRG1aoSwVzEUr4HnhB1HYeOeVShMb1gr//4ByAT2VXSmalTPZer8onjg+9qkC7qx99PE9XaOYTk2zU5rd3TOG0BwYAqfNoE38KdRDSTy2/Ews3gjdTdS/2tYdPfICSxWhxJMSftz0WuBdOI3cjHUlo/a8wWub9lPSQP1eJ2bdSiEkBxPwQ5GXk9+Lf/aGa5smCIT/FArXyZ2SmmYecXws0Hs4+25qULEB;4:7R7wNglzjmRG1ZsUzBy8pECa/H+rj6Dxxe38/D6Kv3s/fkgMGTFlI2MNViU/u9rf/Z5RG/I8qGZsFiv9cozqUjaYtzriwnQwVt+ccFrCsgEzgSW6UXg0U6+neLHydjBgBHTVCUXRtbHgSLnhClKlaYaeNPMED1Mh4b/yKuhBrYK/zPLXabtBTDwhU2A99wYvkPXJgjpCHuiExz5/7uxEf7jo5TqeGLH4YJPocXza7j+OpfoISb+/KLiEp9UoWQhWymGYrAO1xNlnvcInKEVE1EivNQ9IAhzlw8jkFFaTxXamTL70xx2jXuEanSzK3Cz+
X-Microsoft-Antispam-PRVS: <CY4PR06MB30780F49C471A0713EDAD98DEE930@CY4PR06MB3078.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CY4PR06MB3078;BCL:0;PCL:0;RULEID:;SRVR:CY4PR06MB3078;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(346002)(39380400002)(366004)(376002)(52314003)(189003)(199004)(446003)(53546011)(386003)(7416002)(229853002)(16576012)(36756003)(77096007)(316002)(107886003)(6246003)(8666007)(7736002)(68736007)(53936002)(305945005)(16526019)(52116002)(81156014)(81166006)(2486003)(23676004)(52146003)(8676002)(486006)(2616005)(476003)(26005)(59450400001)(956004)(11346002)(76176011)(5660300001)(31696002)(6486002)(6666003)(6916009)(58126008)(8936002)(65826007)(93886005)(54906003)(47776003)(2906002)(31686004)(105586002)(230700001)(3846002)(6116002)(25786009)(72206003)(4326008)(478600001)(65806001)(65956001)(97736004)(66066001)(50466002)(64126003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3078;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA2TUIzMDc4OzIzOlc0MnFGNmFBMm5tc3dmcWJtZENaV2pyaUJB?=
 =?utf-8?B?Y0RGQVVpWDdNVDhSM0FuSU9vNWJFQ2NwR0UxTGNWVjlYWGxoNXViOXhnb3Fr?=
 =?utf-8?B?YnlRVVNMU0UwZElSeWNMMmI0dFJCNTNST25WYVVwVzVlcVFza0ZIVTlEelFT?=
 =?utf-8?B?eGJaT0xCbHlxZUZBVnZ3VFoydER4MjEwOVprTEh6M0hUeThtMUlCdWU4bXVJ?=
 =?utf-8?B?eTNvelhvejZKTHNCcVNROGRZcTNINXpOelVXanpEaFpKcUJ0aklscnBtaFNV?=
 =?utf-8?B?eVVHNndpanRzMDdSNndIVnVMMnVtVXR1WVNEbE0zaFcyZ1h2UFdIM3hpRVI0?=
 =?utf-8?B?cThwQlFmNFVyY2toN1g1dWlEaDFjd2RBN3liU3dPWnpMTjhpZi9ZR1doMTlF?=
 =?utf-8?B?RUhCR2pwcEZKL2hxRkRxUmViMW5oL3VvZk5kc3EvMnR4dWFzRzMzWmZKVnFT?=
 =?utf-8?B?S2l6Nzc1L1J3L3ZpVGZpTkl2SmQ2dWprUUJHeFkzS0txUFRlUEhNTm5mZnRy?=
 =?utf-8?B?MGlqaXp6TVhkK3cxVnQwd2t4ZmNadUpYZGgzRC9Pb0ZYb1FqT3EvdTNNK2li?=
 =?utf-8?B?SWFDRlJNYmVZbVowWXpOYlkzc1BZNmYvVjlkWVBvTGVCTHczQnc3SVBXM05Y?=
 =?utf-8?B?ZEFHM2xqTlc5OVBZYzUwWXE2R1NRTUNVcDREUldSRzc5ci9DbGxhVmdkMG0w?=
 =?utf-8?B?ZU5ySkRTTFlGZVRWUkE5WkVvVUw0dmtiT3YyYzFLS1d2MFl0bTNMMWdyZE1C?=
 =?utf-8?B?VG1YQitkcE9qS3BnUG5HTk53eU9XYVg2UzRxQkd3L0UzQ1RiQjhNS1pLbEV4?=
 =?utf-8?B?elBwVm96OG80d0dlQ05uRE1FWkJkeUp0YXdUODZpbHFlSlMyVGQwTFRqWEpN?=
 =?utf-8?B?a3lUOGZGUnJvc1ZsL0RBTnh2c0RSQlUzbnRWZ1ZRRk0xRURpeG15d3E0Ykg3?=
 =?utf-8?B?SHExdEtuRzFXWWd6MnBlZ0ZaVmxPUkVJRjEzVERlN3U3a25wQytPd1RFcVRt?=
 =?utf-8?B?NzBHOHZIeWxLS1cyQVVDV24xWjg0ajhWWHY3SmZYYk5tZW92anpvSlo3K1A5?=
 =?utf-8?B?ZGVlTkVUMGNvcXdKVFRaU1lFNHFUVDFKSDlUR29XQVRqZzRvU25oanFqQzVP?=
 =?utf-8?B?T1NrTTlPa3NSbWh1TE43dnFJZ2V4L0c5MktacGFnVFhNTGVwZzZhTmxkNVR4?=
 =?utf-8?B?NlQ1dzM0RGxRYjY4Vm53T0ExeXptdzhvVGVUak9NRkJyVDgrVmNJbHlrZU5t?=
 =?utf-8?B?T3FJUGdTWWlvelZRdngxSzQwSjZOQlpSZERzaGh1M2dUbjRaaW41Y0RPYW1F?=
 =?utf-8?B?eUozRjVyNXl2OHFGMjJRUVdOM3BoQWFETmErVUY2SEF0NnY1Y0ovTERKenJ6?=
 =?utf-8?B?Vk8vbmgvbE5ycVNZaGYvOVNGa0JOVXVrZUxQR1VPaVQ1Q2VEMDJ0LzNnVWFP?=
 =?utf-8?B?bXFvdUdwcW5UTTlOV0c1RnpINEFTbXZUbXlCbzA2blZmUmdXaDVrQTBjSklR?=
 =?utf-8?B?RlZJWlFrd3hrOGg2ZE5Md1locjdzb1JpT3hzMkRjM3YyRUtMQ1BkbGhTc1RD?=
 =?utf-8?B?MzBLK0RianBiK3VmRDBWMGQyUGhlSFkwdE9XOFhKR1VRbVJWSUVBK2RiZ0l0?=
 =?utf-8?B?amkzN1dQdGRDWFUyUWpnQ0oyZjFCNlFpWU1UelM1UGpnQTB1WWNEWVltZXZX?=
 =?utf-8?B?ellmNDlDdXo5WXkxT3JnZ0hFNlFCSjd6QW8yWVpBRFJXSjluRnA2aXlCdVd5?=
 =?utf-8?B?OEZZSU9SUnVSWmZnQWpVbnFLSkF3a1p6dmNmMDlCWTRITjh4eHBRQ3U5R2tt?=
 =?utf-8?B?bkh2WFloaytoVWdySm1JOXV4SXp0KytQWmw0R0kwVlNsUi82Nk1MSHFsYXpq?=
 =?utf-8?B?bmhpY1h4QkRITE9uSE5OVUVvM2h0TU1ESWdaMHdINjVzN3FtNmE5ZTd3bk1N?=
 =?utf-8?B?aEVkWklkeHhPTUVYS2drdTB2NlhKUGRUQ3RCbHhONVhlTkxObmpXbXlJR01Y?=
 =?utf-8?B?dktEMkNNR2lnc0JZQUVtVTB6VlVEdUJEM1dMaXN1ekQ3bURlejFZaGNpMHpl?=
 =?utf-8?B?RjJTRVFDVEozdk4ya0ZoSFdEcUNVMFVkN3hGVWp4Q1RSRXF3Qjh0VmMzdWQ1?=
 =?utf-8?B?eGc9PQ==?=
X-Microsoft-Antispam-Message-Info: iPapteuhFMTCjywpMvOLojpDzxbVpVyURGlcNCjpCREaFy+UsD8TmI6EaZEQxkUqY2FfGOWLp0cShowaa14OE+ElQhs5FMtNZkcD+owYwgRuzQ7Y3cODwDzTI4AO7m41Ch4IBDXwL4owA/c+CZSkTx4r+UGI7tcmQPOKAWFtqfjTSwVBSDH3b+1+tIc9g4Ua
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3078;6:I8HyICyhM0FIjWIS5AvrY5PBppyJiuGLF3FeRf7TTwDLN1FvxMTlkkJghsBJhxcB8RYtUFi8NnIcr01sFyosSmLBXoLzTfaOwfDWPsFknpOeMqLCM13ZbBdwrAGrHhtOKqbn12gGiXQd9xdRCse6X4kMOjFkE24hYElQp6oraBOKHKpvz+L+RI0vKlrFVLQax5kEQlNwaYYzAoZ4EbyxTFp53iZYydFplByZMVlltxz2zsbKTu+IskZwcgMufpKMIiaNdHLdW+pAqy0bg0Yl2SndGKEgT82Zc1UsZzAt7hO1FDBWvEEbk2RHv1iy9eWvaoZLhhB03VQah/KQdkKX0Q/tOdW+Tw4wyV9TcCSLLXD+S83+ZplFUpREXJtCI2fSxt3K56Bnue308+2LGNF3a9YrXCD1rDMD1dE2wrSmSxXqIjA4b8M+kYw61NsXdH+r89M0pVkkFymRtaeHtILYpQ==;5:sKGraAF857uJ80Rrw6AYV4NXb5QVdAkH28beaGxHbvykYzi+2bQ0xyP7fbVf7Va92X0IV+r+KO/ajaTcRpaEpG1hPb4ibCYByc82RYQ+7+AxN/qzgKFT3CkPe2CxHSI96zIQXGsRJCaHVW7glN0aHrgA7Y302hiMYDQMye30DAE=;24:6d3uKzgJ3N1hCibA6s8muwer5YI6bBuicMbFY+n0sweTBDSqV63kyO9yLng3UBL0mcK3lWXeGNbAh1H6KzFFZNtEj+4xL+UNxb1UhqWQijw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3078;7:zXs49n3OR/7gCCAhj5ADHoXchlH2e3h09UiZNY+XK7QD7z+yOm6Ra+JZcSNOr8wFRjLVTvFReO8TAXOOc588IKtqX5KZkKDisylp/fe5vKzKr4PaPlRpZmyiiFtDAGz+WPqHV0eiSWpbhtNxmL2s96bvp1+GOnEaaaAikg1oB3NeLLlee1kkexVphnaEBWqwdyhMUHBRfClORlzvb6TZ23mXzVykGd/06frNsh2g+fMG6G8kf3GYpUc4QXvE1VIL
X-MS-Office365-Filtering-Correlation-Id: 8a2a14df-f836-4e37-2c1b-08d5ba667a99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 13:19:20.3054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a2a14df-f836-4e37-2c1b-08d5ba667a99
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3078
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 15:07, Mark Rutland wrote:
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
>>>
>>
>> Yes I know, but that is exactly the point of this flag. I know that this
>> address is only ever accessed from a single core. Because it is an mmap (vma)
>> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
>> only that thread any kind of access to this vma. Both the filehandle and the
>> mmaped pointer are kept on the thread stack and have no access from outside.
> 
> Even if (in the specific context of your application) software on other
> cores might not explicitly access this area, that does not prevent
> allocations into TLBs, and TLB maintenance *cannot* be elided.
> 
> Even assuming that software *never* explicitly accesses an address which
> it has not mapped is insufficient.
> 
> For example, imagine you have two threads, each pinned to a CPU, and
> some local_cpu_{mmap,munmap} which uses your new flag:
> 
> 	CPU0				CPU1
> 	x = local_cpu_mmap(...);
> 	do_things_with(x);
> 					// speculatively allocates TLB
> 					// entries for X.
> 
> 	// only invalidates local TLBs
> 	local_cpu_munmap(x);
> 
> 					// TLB entries for X still live
> 	
> 					y = local_cpu_mmap(...);
> 
> 					// if y == x, we can hit the

But this y == x is not possible. The x here is held throughout the
lifetime  of CPU0-pinned thread. And cannot be allocated later to
another thread.

In fact if that file holding the VMA closes we know the server
crashed and we cleanly close everything.
(Including properly zapping all maps)

> 					// stale TLB entry, and access
> 					// the wrong page
> 					do_things_with(y);
> 

So even if the CPU pre fetched that TLB no one in the system will use
this address until proper close. Where everything is properly flushed.

> Consider that after we free x, the kernel could reuse the page for any
> purpose (e.g. kernel page tables), so this is a major risk.
> 

So yes. We never free x. We hold it for the entire duration of the ZT-thread
(ZThread is that core-pinned thread per-core we are using)
And each time we map some application buffers into that vma and local_tlb
invalidate when done.

When x is de-allocated, do to a close or a crash, it is all properly zapped.

> This flag simply is not safe, unless the *entire* mm is only ever
> accessed from a single CPU. In that case, we don't need the flag anyway,
> as the mm already has a cpumask.
> 

Did you please see that other part of the thread, and my answer to Andrew?
why is the vma->vm_mm cpumask so weird. It is neither all bits set nor
a single bit set. It is very common (20% of the time) for mm_cpumask(vma->vm_mm)
to be a single bit set. Exactly in an application where I have a thread-per-core
Please look at that? (I'll ping you from that email)

> Thanks,
> Mark.
> 

Thanks
Boaz
