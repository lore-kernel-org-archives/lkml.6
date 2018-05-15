Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2709797-1526393483-2-10097783835744725326
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526393483; b=FgdFwR3SrvUSaUqIDUUpr7AX2hitZ9H1scQOEYhbF8vNJz7YPP
    u3XzH2HyivqrfUxYW+W8fQFn2uXBoHvLXOBBOamFnyay2/IkL7IfjiaUYUHrLqL/
    42Tqp4MxOIzpLIvkZilAIVCjGzRLn9mQSxuZU2yLSoA0rzP5v+rw5bTVWiNB/k3k
    EKWNZA5/hP3rBR5Qo/tfGle1NoGWfbyGzXBlb98fYs8fBB+cvNfZohNO7esB0dBk
    +ARe+MTsIBflU5RvWZQM+UutnmTS5AUrudtj6fXSJ7VtBryuiB7/6IYwrY1nc35C
    dF3SPDUNaDicmvD5YScPZ7HuhaJuQXvQzdJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526393483;
    bh=u+NkkwosjubXp/PwmvBPVlHvWXahFSQPeqxk+ypGJx0=; b=Ii057UWb1QUR
    uvbgcvPji0gNFba/VT1N8+deA7PbfP31NVtC3N1wRlMC7nVmBvyMhlxAp1Ea9JyU
    L82S2xc5z7mz2TaNXzvkY/zkhAhIe5LsTKKnbZDdcG1xuNdN9pEJhT/R19wuLMET
    qHDt9En6Olh7ZVdwN6D0ZD12LWz94uTt+kdOYx3Ssf8nEsS6kJhBteE2JLSBSUee
    bR6wZzXzapy3bUtPP8Rpu+1nVTVraTaigz9IJPJCBvDpVfSQeGAyCOr4fAiEL1vr
    no5EofJmcXTj5Nsbmvtt9dtP6qOgsxBlPzoRgYLMFSfljHxQUfpOOS+n8BhRmVe5
    P220NfDKOQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=LUoZEi6m x-bits=1024
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
      header.i=@netapp.onmicrosoft.com header.b=LUoZEi6m x-bits=1024
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
X-CM-Envelope: MS4wfBhoW1/qIAMHpQ38i8dvNWrSAkH4pbLN0w0sq5QtMUIj6deYW3L6aOVLjYSf4ud87eAdajesCV1G4sdBwO/hAges3ycimI/lO0/H6tzUuABMR/yFt14I
    yd33NIMtPIJiFXkbPPM0AOm5jJHmRyOEXvoH17ivxgwzs7h6Rci7o5caQ5IyXkn02AJPKX5qJU7A8q+tT+9UfF+ek7qk8MkmvctZ01U4jghHTFlJKLU8BU6S
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=TVhCwgqN-_JlGS-3digA:9
    a=PRsv3tmMQ4SJl83U:21 a=oxpJnznK5y8MwZ_L:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeEOOLV (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 10:11:21 -0400
Received: from mx142.netapp.com ([216.240.21.19]:30381 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752392AbeEOOLT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 10:11:19 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="253925057"
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
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
 <20180515120355.GE31599@bombadil.infradead.org>
 <afe2c02f-3ecd-5f54-53ab-d45c11a5b4aa@netapp.com>
 <20180515135056.GG31599@bombadil.infradead.org>
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
        "Rik van Riel" <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <da89bf77-fcb5-1c0c-f5ce-66e552d9a54d@netapp.com>
Date: Tue, 15 May 2018 17:10:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515135056.GG31599@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR0701CA0018.eurprd07.prod.outlook.com
 (2603:10a6:203:51::28) To MWHPR06MB3085.namprd06.prod.outlook.com
 (2603:10b6:301:3f::30)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:MWHPR06MB3085;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3085;3:adeHNY0i2UYQ9wLEWogr3wElsfqMuJodRDfa4kJAk6IPDJ84cbqoNknwGnTqVrYo5hQM+ZbbbpxH5H06HWwK5nNO0mWhehYGStg1F8VOuONbGjPPkhbe1AhR9q+5jpg7AYQCicYOPNlGBtm8yz/baRJ6ozHO0l3SB32CpeIU6FIXabFjSo+PUkuvDLuxUjNs9VCMvP/AY2ig9SaeaNYn4Off2Q3LXT2yWL2QkFGWamDTUNGD6Wdc40NAlxy6o5t1;25:QYSzG6QjTLC0XkY/SGVA7JJiuPHUFtn5ZNqcfSoLBdSBkwX276S0wA4Cw0ZwCyeaLDPTUmDJOWsCVdrbuEz0M7VmN/nh+QoLSHlXcgAoq7WIZPzcIboxsWThuvHcTBl7Tzz4mVWsdkkuWNB6WLb0vlhx5ByRCfiFlKlBEQFj6yAitKCrD7vjMzEzNF79Q2f4i0xGKxG0inZ46VowH8ONG3F6IkHwvCevLFZ1EIUWSmU2Gn1tyGPb83I9D3J7YpC7kFblsGfmtdgB1rwpLqWv8QPkqk7xJzVrC4wZFjG3ierysSoBvvWcjpTWc5r6vzV7t/++5yyH7+IWiPLhSPvUGQ==;31:ipTL5ulJ+V34r2tkyRDdtx5SnvSkQPFdVbS+H31IX9T5vFwdGRTwWsa/e+h+u+qZbSDGI0LWyvTzfJ9WlPfxD56gEthGJVeTueSOypgPnvVmdfi8wvHsV2OUlZdfbxH+YFKeQvhpFOFP66ugOq28sV/lwQdoNCkV3vaDvLC9VkgOK75XvNu3tMuwtqBP77zFLPZel2NZp7QeQStR4uZhD7JwmYMNKCmbC424iAYMCnY=
X-MS-TrafficTypeDiagnostic: MWHPR06MB3085:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3085;20:2Quzr/XU0T+X8CMtucPrFXUyQjbrB6eHq+e+yTLIZ6ozW7gI3A5OEeDHlLrpEH+gmPnEEQgQLwgYlTyoB/dO/pflltkK3v1GW+1E3F43fykJRdG1BLCYpj+tT2UvybxKrzVacny/U5svkFHdDuu/UdEx4nEsqqmnok6qzoxc6KyL2TiJSfSXZfeazrnREJVtrLkcAEHqJL5F3zLtt4bvrvYnKNWSGYUqdTlPa/BI41nxpi1YnCPSqFRBYmXvzqYUTL8rr7tCGQmQmatx18A3tyl/ag5Zblv63cRQ9hRa2rP6UB6+YaswuRD4fApuiMgtOI7HI1Wig9/bU8H1VGFg4LZNNg3SUhrB96dvVrqdoTWJQB+aAFOwNGqVvc/oh9RYpYVY9iz/bOXHG4UXpo9aZrdC76zKvuC+w7kiDJ9MpYaMCq9ZKcb/tW91VhhMahZucincSOVesBiEdE+DqjE53Dr5bR2P0XdCzMQcNEI82N7eKCRNo9zACDsNcYsiWTiA;4:R+GpKyLEEGiKr7X127AkHSMYqkHbaO8aezJ69P+DMJYZ6pEB2TrQUdyDgBmCSm+5/wQPC5gw2M5zfO7eTY4ZJwN/9wjkVgXWIKm7wSeqL8tWmHzcwWgPLuf5MYdi2Rx/fv/R7QwC40tsyGzXJHAOL6i/Xv3XDYU+f64GS8Bx55e6y3+krPq0UtbsPkI8thAvJ/ohytSxmNMI0rt4lhXgTRcVu9cpjdERQlZLPNQ5TNrfFNrIBsq1L2E1thbcZTjUoIfLqO9MJmdpgkoxZyrnkA==
X-Microsoft-Antispam-PRVS: <MWHPR06MB3085373823BEDECE8EC28F0FEE930@MWHPR06MB3085.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHPR06MB3085;BCL:0;PCL:0;RULEID:;SRVR:MWHPR06MB3085;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(6486002)(6666003)(26005)(486006)(476003)(25786009)(2616005)(956004)(446003)(11346002)(8936002)(106356001)(6116002)(3846002)(81156014)(8676002)(81166006)(64126003)(16526019)(50466002)(6916009)(7736002)(76176011)(478600001)(68736007)(72206003)(36756003)(305945005)(16576012)(58126008)(5660300001)(54906003)(316002)(8666007)(93886005)(65826007)(97736004)(7416002)(386003)(31696002)(59450400001)(53546011)(53936002)(6246003)(230700001)(107886003)(2486003)(52146003)(23676004)(47776003)(52116002)(105586002)(31686004)(229853002)(77096007)(4326008)(66066001)(65956001)(65806001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB3085;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA2TUIzMDg1OzIzOlFtK2VJS1FiSFMyU040dkt0amlaQm1sMzlF?=
 =?utf-8?B?RGVOQ2IzUk1nQkRmdWtWUTRVWjFDc2d3MVhWUllOS1RjTzArTTNOdEcyenVJ?=
 =?utf-8?B?MjJvMXlqa0RwMy9HZ0NKS2c1elg3MlFBMEhlNU5XVUR1VFpodzY3VjNONEZm?=
 =?utf-8?B?dlBqckYrVDhPT0tiZGtSZnptSDczcEp0MHkrRWNFY1gyZEtGZDVQcmNoZ0JJ?=
 =?utf-8?B?YVd2c3Z4MmJjMDZpTTJxbEFPbmM0RitBOHBrN1hYamFhUEFubUtySWkzbWdE?=
 =?utf-8?B?L0pOUEVYUnRFVXByK0U2MktVR0wvN2R4MmNSUE1QNDVrKy9KZUVzcHFjbWw3?=
 =?utf-8?B?dFR2WG50ZkF2Z2FLMGNWZG9SNWpOaHNFd0hGOUs4K3gvWVMwSitrSTNTT0RO?=
 =?utf-8?B?N0V0ZVhIWWJWRUdsWDdLcmlkS0hkejRJWCtXVlA5cFJSb0VXdEV4MVcvaFI2?=
 =?utf-8?B?ZTFxUnlRYXg1ZWV3Z04wbE1qTTlGN2hSS2VUdlM2QUF1cmtabHN3c2pLYThF?=
 =?utf-8?B?SFBoWFFYclZrQlVMUU9HdGFub3R6aVZPb1pGMkVPbWJlTzFRMGNnN2hDWWVv?=
 =?utf-8?B?MXdaeXhYcUdaaER2MzVtQnNObmFzbGV4Tk5WaXdqbFJ3MHBmUmxLbTNabHRV?=
 =?utf-8?B?eDZ0SlRQc041ZjFjY21zMFBTdmc4UUlCWVVKOG1YTE11Ky85TnpzWXBRNUxi?=
 =?utf-8?B?SnpvcGx4cHpQd2QrZkJFb1RRU3BLQXJVQzduR0ZMQ3U2Rm9abFJ2MzBpSndG?=
 =?utf-8?B?NlJZSEQ2aFcxdmd0REx1Q2JCMVBxZHpMTWFDSFc4OTB1ZEtxdW1UVUtrbFlN?=
 =?utf-8?B?bXpnUjJxQ1F2VElCZ2NpNU1pbFJzbU10Z3JnTVU4WXhXMWNIVlZseU1Kb2Mw?=
 =?utf-8?B?TlVrcVZQRi93OEtYckdwUS9KcFBuQ0lJYnN1dEQ0R0N2SE9UMmxPVXdacUFG?=
 =?utf-8?B?S2lNZk45cFJxV1lIZytkbXUwcnBPYVJKaUNlKzNWYVRKTlFLM1BiWWtKa2dm?=
 =?utf-8?B?R0hzZDVWZEROcnhKTkMvNXcwTTFHQXVUOFVLZUw2L0xidUhmQUtnMXhESDVI?=
 =?utf-8?B?alFQQXZsQ0dTamtGTXd6bVl4OXpXRXUzb0pLQ0ppdUZrVXh4bXlzSmNKNTBH?=
 =?utf-8?B?ak5sbEhNTDRIV1IvdlpIa1pITUl6RmplaXpUVkc5a0FlaGs3bjdXd1l3Ukp3?=
 =?utf-8?B?ZTZiL2NxcFhJY2JkM25SNGZGWTluTktrbnJlN1lDYThiODJYaFpkWVhxRWhX?=
 =?utf-8?B?V08vR204djVUbGFvWHExMEFJbEZLMHFiM1lyY2RUdVZXaVNoUUxWQjFCN3lZ?=
 =?utf-8?B?U0JOVjRqMXN3dTQzbTdJNXZKbDRTQlY0VTNadmxFZDh4eVRlZzJoV0Nyd3Y1?=
 =?utf-8?B?YU5oK1JIVXY2ODZTTVFRNlBmdmNYaTZzQVJCU1RRZXZUMFRHdlIrY3VpUEFM?=
 =?utf-8?B?QUsrMFQ4Tzdoc2dyKzgvOFpydEhyMVlaRCt6SUtiajVwYUFwMWxMK3BFNUZr?=
 =?utf-8?B?Q2dhakdNc212dHJTQzBGbWtmM1hBc0x1YTlFdFRxWFhIMXd4aG0wTjA2aEdP?=
 =?utf-8?B?M3dEcUNFZ2t1bUVDVjNWV1JTckx5bmhld3A2YjlONUJ1RjVBc0NudzJPbzUz?=
 =?utf-8?B?RDVlbHVjdDdvclYxZk0za056d3REVElobDBOMzVnWkpHNnhZb2srSTIrWk5Y?=
 =?utf-8?B?ZlRCc3JQZnJWdDNMT0p3UEN3WERqRy95UEpsSm03dlZaK3NhbHkxQjlEa3Yr?=
 =?utf-8?B?eUxoM3IwZHVjSkYzalJpaTgrNlB3L1BJdlJNc1p4anJtUFRvb1VLTUNZbFR4?=
 =?utf-8?B?K3dKMDRQMmRtekdxdUFPKzJjQzFBYkpQalh6U1lPN2ZQVE52VE9YSmtROFlx?=
 =?utf-8?B?RDNORlJoYUJlWmtqWFNjdlhOMExhUGNQdTc2MFphZ3RBb29jQnlzeEFpRHp0?=
 =?utf-8?B?MU81cllIVWlNZDA2cTRrSnE5bUEvTmNlcEZxczJpVHJNaFdVbFdHYjBENzJi?=
 =?utf-8?B?R0NWK1BIZEJ5U0ZNWDhoY1Q2MnlvZFAvWUpra0VhQStXWlQ3UyswRU9BY3pk?=
 =?utf-8?Q?JST3Rztpk5Lep3DV6cbuwgk6S?=
X-Microsoft-Antispam-Message-Info: xJ8hLrgLBSRtiBfujDo690peZiffidRWlHThSo8gE4Y78mcYQVbqqyeFc+zWvNFMCDDLossBCnplAD0uCMlYmlZY2PUZv9mydO+B71ogrpAB/mmZQlKtiktm7lHPvFbr6cEGJW81ribJX8PB10fldm3kF19EKW5/JzIn4sGAltRtPui45wD7AJbyv8kWc026
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3085;6:8Dh/mYePuCjKLV6qil3z31qdox2G7ykHasnXKXMM6oHngNgMhUlFZMMmaPAIAexhTIariVv6ChpHKY2nilGtKDpbmuFfcsxGQ0/VhPU5Bu+yvejHtJ4BuSwLLsYGY80VK5Qfes/rlaCJX1pQz30zRmfSFiyP1Hva0kpFw93CtfG4hZzYSnN6P5ijv2EPbOR8wcSKQufLwVSUR9EZ5dJeFag2/pfWyJmAzLk7Zh/tMG8QeSBR0z/i1nWis4Yq0U0LaxlU1hoxBbhgC/rIQDFJ42KDuJDDBs3KgCFUxZSrndWE7BHAegd+fF0fevuL+VzpqQRibthTJRgXtSnHhI2kG/RO6keZqxgTq+ocZPpErhjHECvJnOHGdZxt4wroKf4feabYEpSa5kEvypg2CEYO1Z6FUPwVczu71v4x+lPC+n2fR3dTZCt9ChmyN17el5Crkmgj3fj+/b0FVCuLJ2GcgA==;5:6GFbex17NKveQimU2625OXZpFCb1NU6wIJ8O3xT+fGE4MXQOBn0TzPwwMXu/iq+HLQuIETSILnfKoM2/FREJ5C/VaSuO6D40B/DJE3WFHeFFQqSPURDRlBiBoVEFDvE/aLHWDcGAd1D9T1ZvvwT+LB3iLo44KIDriajjg7jC7hs=;24:zDmHzHWVHCde0VU5H/bYRh+MSCS7nT92dR2K45wztbMdepE9M+DZrf44ih+bCmwqVJ2EWOaZstWfc76ztuMOBUCFX/1sMj7WpmeUDcvskIs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3085;7:3jWsYwyyqeESy5QFgjl3BGi2uJv9Rb1ysnK8XIJ1v3+A4ePwjzfc8XIBe5bU6F7PGQw8ruRVVj1X9ASuXV+j/IPHyFWjQ38vXdv+pqQbLI/bgo19KBMdJczPwEs0UoarEQfiIjuUFlgAKD2iJSI1xYBLSYpxH4mpbyKi1moWbM5c3+6dP5GSUU81Pm39M10UaCqQA+eeNy6U3yC+msxh0rU0Ic+kV0U1BoXuq23TdVVUGl974C8Ve/0YHNSAcGSD
X-MS-Office365-Filtering-Correlation-Id: 062caed2-de54-4828-b70f-08d5ba6db842
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 14:11:10.2749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 062caed2-de54-4828-b70f-08d5ba6db842
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3085
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 16:50, Matthew Wilcox wrote:
> On Tue, May 15, 2018 at 04:29:22PM +0300, Boaz Harrosh wrote:
>> On 15/05/18 15:03, Matthew Wilcox wrote:
>>> You're getting dangerously close to admitting that the entire point
>>> of this exercise is so that you can link non-GPL NetApp code into the
>>> kernel in clear violation of the GPL.
>>
>> It is not that at all. What I'm trying to do is enable a zero-copy,
>> synchronous, low latency, low overhead. highly parallel - a new modern
>> interface with application servers.
> 
> ... and fully buzzword compliant.
> 
>> You yourself had such a project that could easily be served out-of-the-box
>> with zufs, of a device that wanted to sit in user-mode.
> 
> For a very different reason.  I think the source code to that project
> is publically available; the problem is that it's not written in C.
> 

Exactly the point, sir. Many reasons to sit in user-land for example
for me it is libraries that can not be loaded into Kernel.

>> Sometimes it is very convenient and needed for Servers to sit in
>> user-mode. And this interface allows that. And it is not always
>> a licensing thing. Though yes licensing is also an issue sometimes.
>> It is the reality we are living in.
>>
>> But please indulge me I am curious how the point of signing /sbin/
>> servers, made you think about GPL licensing issues?
>>
>> That said, is your point that as long as user-mode servers are sloooowwww
>> they are OK to be supported but if they are as fast as the kernel,
>> (as demonstrated a zufs based FS was faster then xfs-dax on same pmem)
>> Then it is a GPL violation?
> 
> No.  Read what Linus wrote:
> 
>    NOTE! This copyright does *not* cover user programs that use kernel
>  services by normal system calls - this is merely considered normal use
>  of the kernel, and does *not* fall under the heading of "derived work".
> 
> What you're doing is far beyond that exception.  You're developing in
> concert a userspace and kernel component, and claiming that the GPL does
> not apply to the userspace component.  I'm not a lawyer, but you're on
> very thin ice.
> 

But I am not the first one here am I? Fuse and other interfaces already do
exactly this long before I did. Actually any Kernel Interface has some user-mode
component, specifically written for it. And again I am only legally doing exactly as
FUSE is doing only much faster, and more importantly for me highly parallel on all
cores. Because from my testing the biggest problem of FUSE for me is that it does not
scale

I'm not a lawyer either but I think I'm doing OK. Because I am doing exactly
like FUSE is doing. Only some 15 years later, with modern CPUs in mind. I do not
think I am doing anything new here, am I?

Thanks
Boaz
