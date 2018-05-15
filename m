Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2422075-1526381188-2-455091631772149473
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526381188; b=lhkDlx7BFsqiYZsN768D60tzqgZKey06izI76egjlkJMp2gNhl
    0/kaAhJC84KkJT6xslxW7P7Bpez5pWUvcpz3YRmPFwnInLheWPeIldY4xFXGbhC7
    Eok4BJMIZYsRVaBL6aBYTfXxk/Q0h8S2NqPUlZIV3nqyaiiNd+fVRQlBy5tiPWCe
    YQgYnuJPEJrBenPBGBNXFQteRX6RJrBvemx2DmVHmav5bscoSb9kdCP9i6w5adgp
    fbJLxYEYNtHW3jVvXIuc7xD/SjNilSwtFA9z+o2D1j1jLF34PpeYI0CV/84w6hiC
    P7Lb9RyV5BB13dl6tESChj1pevnjSy0IYpcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526381188;
    bh=R+qkmkTV9u/9C6qCHM4ljYUX8fSCY1BUpIjQK9dAzFg=; b=TTPGhQ6LBo36
    bwUkAMktrhtWzt3oV2T9iIfkCNtHzPE/wVzBiA/Ex3s3ZZcahMQxDD1yu8o95kEt
    yXlMUQZC18/InjvxkN6zFW1JFA3KUoOCQNKPpbpNAZj3k5ZPDmMZL+0TX/thgZVt
    wAgrOpHIwDjA02g6Y5pV+pWW5QgUVL4ApeDpV4ptK/DMxl4cecXBxNZ4giiI6/3q
    2UFBPxWDI+wYKEAQ5zaz4Pf3HT5uwBkGpIa/yQkAYKlIqgavj87V36Eq2YSQgEUq
    HzmZk4LJW6+Z4NSs0AGQntN7tewdDaZcU1wI6cdmIcZZl7K7NtTZMb98uA9EEnDB
    jcDgxnwCWw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=SF0uUmld x-bits=1024
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=SF0uUmld x-bits=1024
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
X-CM-Envelope: MS4wfFV6legpVxJVEyDKuGvHMIy3CB8coFG64qUHxIm5k8OBweFsHiZgSBaM515oZITq2BqlIvXH/orjhaN0FcxE6xxFl+HpPyr6NaXT/NvoRlGwaRVJ5rrv
    PpxOxYjnSnb+aXrEZabrIjJNMDHGf52eIVF/TB5eMImmkIzIJ52D+a+5iv+V7zKRGvEbWXsKRlDq0GPRoTmc+qyeRCmmgr8P0sxnkmHWxpT8Lw4HrF2wxpsr
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=o1CIf58gbKV5LAPBbHAA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbeEOKqY (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 06:46:24 -0400
Received: from mx142.netapp.com ([216.240.21.19]:30081 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752038AbeEOKqW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 06:46:22 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="253896907"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Christoph Hellwig <hch@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <1d5f676f-b5d1-3ad3-c7a5-25b390c0e44e@netapp.com>
 <20180515070856.GA8522@infradead.org>
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
Message-ID: <11632615-e6a1-11d0-ac8f-3d66e49a23d3@netapp.com>
Date: Tue, 15 May 2018 13:45:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515070856.GA8522@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM6PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::38) To DM5PR06MB3083.namprd06.prod.outlook.com
 (2603:10b6:4:3f::32)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3083;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3083;3:fJ+J9mpz9T5GiF9Bn22IwzCkp92S08G0vVADYUUPKvCrm1+190z80/ZaumJxWi7Xptcef9cKXa6aVBbpD/936hM161M8YJNS3S3PCrfhyJ5HZiF36SBqt68jL1XhFhdq3xAiFPEJyeG9LIM07rszkx2Ay4FPg1JzZgvpPnwGgkWGHjjIVIoZm85BXY9OKLwjHoUVWbefqZAdnbq+NAMRArzlG51oRSTcA9NP97foDyd66S96L2im5TEosp0xM0r1;25:InnGxo+XgzOpptmeFjZ+ZthvND8XNe3L4WKhSeuRQ+l1iQyJcxoGw804IMXsTDrn8vyHbhmWcjWqRCnuz5ny1+i1lQcEYk5YavZUG3jEus2kvetM3y7c9KmVw/ShfreHxhF7fEyAJSHTGRvYEDKC7HhJleCsVJKsuAK6b6bzs6ccbt4Iqwi4KqZzse0hSaqq4ip8Tmp9dZpzB+JQiK8KPNlYadQET0PdC0TibAFEI/fCRQrU6pC4WHgSde9RLfOaTxg2YiE57x4UK3Oz1ezUSNZIsLM4o1UGvCwqeJgV60H1pEnBAmasbQGYkFuvDKObKYceeEHTAypwTG5LadtFqg==;31:mBRO2rm8oUy7rJUO1AZ2UoxVQokTjCvYPekd2x57Iiv4kcsWHEeK+xRszrzij8g5N4oIw2RUE8XT8+LKMaV432rgbhlSXJhL3pixbGxViHJyB7ZQff7d42KURLEEDs9MsfqtGoAUD0bSUNdK55tiz34Z537ioUDvcyNqXEdK7YX+2uaElpECPjzygCzf313wfmdUCkM5rNvfAY7ijHDE36vAYcI+GSjy24KoosKP1PI=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3083:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3083;20:t2dq2pwk/6Adf7uuFdG7xJBxzVhrmvVk/kiR7Poic0UutK0P6bd6w9rPjRV9/YH9A9TGIJwYB/WTYbhKjJBUMdfF8R3Z8Y3rGUMRiVmjh1A5JTNG/6WtiCZW87hFSKMzDxgIZGz7ouR4HMdVWiULEzFV9i/hvSDO1sVmMkCMw9O31tE0rjI0h7Ch/s8Sf2DGA3JFh4Q/vdg7dE5XZpnic7XfYuZr6Q6dnH0+/uD9/kjh8dFyUy9ZhUq/UItCRiWQDvY1tMNoLvPPa5rn3BUzvf9P1KmGQwwPkwEl8zRhbTrjNijjLwKWIYUW0DHcVFpj63hsxrBYC7ZzNKDVn1AqcdmWgvL5Pz71S0zOOhsFv6oLtLaPNyLu/9RNMQGSxiu/XBnJ9UvkEUA5QQbOGT9UmT89F3Wtm8yRvhicxVjTtPxV9cKs31p8Yu+4B4W6NGzeq+mkLNnM323+MgLR1ODTJBomViOMgs4rKgT62Rk5rY4BpK7VibmNDPN7f7lZc4Oe;4:1F4OpIk4E6HIf+nPN954RLSY4Yu5Aln9TcIYmU8IymQdIxN08oRYmNlL8vnQwLq/2bXA1zEJL3qtFEFA6RgDHFEJJY1lNnW2S2/CUl5DViYPmJjvIYwUkBBwcudKzaXSRIMBQuijEk64wZ/Tx+DnBsQL3tbZPsJE3bOHpj4571jzVZ1XPwg4ZPbZwMRbazQPBRe4MSdjZ74YeJogAtXyK7/z1fNDWSim6C5L2L28GdjAraqUWDlqqgkn1LHs8iRBRgJGJC47mmSz/GvOa8LwtA==
X-Microsoft-Antispam-PRVS: <DM5PR06MB30831BCC10EF2CC5EAAE374BEE930@DM5PR06MB3083.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR06MB3083;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3083;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(366004)(396003)(39860400002)(376002)(189003)(199004)(47776003)(478600001)(81166006)(81156014)(486006)(54906003)(6666003)(53546011)(3846002)(65826007)(6116002)(386003)(36756003)(8676002)(7736002)(72206003)(107886003)(7416002)(65956001)(65806001)(66066001)(6246003)(97736004)(4326008)(8936002)(52146003)(23676004)(6486002)(52116002)(53936002)(2486003)(31696002)(305945005)(5660300001)(229853002)(11346002)(105586002)(106356001)(64126003)(2906002)(16526019)(2616005)(476003)(31686004)(25786009)(316002)(956004)(6916009)(50466002)(8666007)(26005)(76176011)(58126008)(16576012)(446003)(230700001)(77096007)(68736007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3083;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDgzOzIzOlc3cUxjUU82Nmlyb3VvNytMVnhlbnJDaEZk?=
 =?utf-8?B?Z1dHbW9RQ1JkRk14dkVoOGthNnhMZTZveUJCTW84bURlSDhVTUQraWpWcGNj?=
 =?utf-8?B?RDhUZDFNblFBZUVTN1liUGtwNmJQL0EwTm9XZzUxUFZYV3dlZ0JmaUZDQTBM?=
 =?utf-8?B?MVdTRE5IbTJjOFg2L045RGRSTzAyb01FT1hWdlpHZE1GaXpUR2s5cE9zYlBP?=
 =?utf-8?B?Wlk0Z2NBTy96eUs0cWZJc2lVdFd3M0czOGpqZldwN2NiVmZlQXNneThHeXRF?=
 =?utf-8?B?ZkJ6TktoOTZCQk5NSGhzbHViaElDMXNEeWtjNm9mK2p0MVBWN1ZCTzRUUkNW?=
 =?utf-8?B?UUxrazQra3ZQWjBVeGxrQ2FQYm5NYm5PRms5Rit4VUNsRW9KMUdsRjdJWlp6?=
 =?utf-8?B?Q3Z1bmtMOWs3eTNqTHhiTkhrR0pkZmZ5NzhqUit2VmlmWGo1Z1FpYjR0Ukpr?=
 =?utf-8?B?bWtqV0Rxc3BKUURtcjM3ckk3Tmx2YWVmWHJlMUpMdjRzUFNWUEhER0RkS2dS?=
 =?utf-8?B?SnVuOWIyRVV6SmdNeE5IamtCbi9PSVpONVpaQXJsYlo5MUk5NVE5ZkpCN0hX?=
 =?utf-8?B?ZHpLOUpLb3lOTnlsZjZQeGZZTkMxN2dhZDdoUmlleWl3aGZkSTZLd2VDQzNS?=
 =?utf-8?B?SGdzc2swRkp2WU1FL2FrblZ0RmF2aCtrZ3ZjUm90L0F4Y09kMkthd05WYVF4?=
 =?utf-8?B?NXRYdkE3dTFuS1ZLT0Y4cHJJSm5UU0ljMHdNRmdpOVFOSzFPbFZaajJxRURa?=
 =?utf-8?B?Tko3bTNjWGlvck9mTkVSVGFJaDBYeUlnc1R3cDJBWkZFSWFwWDNKT0VRNUMy?=
 =?utf-8?B?c3Jpb0NyZ3pMbzZ1VTZlWUVUOFJ0T2o5UC93VTFNMzdhOFRUTVdqR0Q4a2F2?=
 =?utf-8?B?dFlXby8wQ3Aza0xSSWdIZVdzQ1NwYWZ5RTRMTy95Z2dvV0FGU0MvcksyMUVO?=
 =?utf-8?B?eW0zZVNKSEJ6RmxIa3M5WXRGdzc2R1lEeU56Q21uTmd1clBVa0xKV25OY0J1?=
 =?utf-8?B?S3VVNGhLOEVNV1hGVzVKSjlHd3h2YzNLNUt3eEtZeTFmSklGNFVZRnZQMEd3?=
 =?utf-8?B?ZnVEQ2ozQ1A5ZjBmQlMwMmV5VC9pQVVrbW9pc2Vub0lyZnllTDJzbHdsek9k?=
 =?utf-8?B?UDNYdmdpNy9nRXBHUHNQQWE1L1NGQW5iWmVXeS9OZDF4cUlhQ21WcVpLSEdn?=
 =?utf-8?B?MGVDNlQ2MVhDSUR2NXJJRUZMaVEvMjN0L05rNVYrZFlIdkRyei9MbVpMUnp5?=
 =?utf-8?B?SFlvdUZUSDl4RXJhemtZL2Rxd25pNHNDSzdzYWpCTVFLaXNxMVJNQ0JtUzdi?=
 =?utf-8?B?TjBaUUZZMjdxY3FBNFlITEZrWlNPWHZhczFrc2NOYlJ5N1RyYXdZZXdVMFQr?=
 =?utf-8?B?NUpNWXN1U2I3RDBkdVpHVVBHV1JOai9FWTRDVllER0NCaFp3WXYrYjQ2TVlY?=
 =?utf-8?B?UlRKK2FlOGR1K2lObTlqR0gxbTczdXhMOTdYcTUxMGU0NnFpS3pqSUw3WGQ2?=
 =?utf-8?B?N2N3NFJqUTVSaWFldXYvYVZyOHF4RGFkQXNZVTYreTAraUMxRWRjYjVJUFJn?=
 =?utf-8?B?WmJaWnJIUW5rUDlzMG0xOE5jWGxvWkh4KzdJdkFsdDVLbHk2ekdEQWZTSDcy?=
 =?utf-8?B?YkFJUUFJcXBJRnVlUDJnZ3VoYXF1OHV1UDg4dEVMYTAwY3RYTEZMTzgzZFhO?=
 =?utf-8?B?eEg3empmQWFGb2ZzclFldW9rcXptaXpvamVYUnc0ZTczZ0g3QkJXa1RZQTlz?=
 =?utf-8?B?R0VsWTR2Wm8rMFVxMjk3Q3l0TGtibHc5QmhoZW5QZjlXSk83ZGQ3cU00Z3cv?=
 =?utf-8?B?OWdvVG82M3V3OVNIc3pNY2hoS3NuamY4blhGd2Z3SUZITlJqeUF6TDJsU05I?=
 =?utf-8?B?Y2doRGdwd3hHRUg4V3U0bjVtVGEvMnVFNjQvWUl3UzQwNktzUmFYckdsZGtK?=
 =?utf-8?B?KytHeHBzdzFBSTBaZzVzMmE3MGp0cjd3c0puZFR1cVFGcUt1QVp5T1hGaDAz?=
 =?utf-8?B?bFdDMHJKQnVHSElsU3BJLzEzbDNqZkhucjRRdz09?=
X-Microsoft-Antispam-Message-Info: peYoqAEBvK/kr3I0+kvgIyGB6mZXyBbeyzaOFUtwFl3ri3w4k+8R9pzdY/FqqvFXN+aCmj5nRCupgDedClCzhPdEt/YVAQR/d6M7h/H2kLrroD6d68QFmE6oEGxjJHTCB3rHQMBnTGOSK25pJTH+MiX+5ipjTW7UtLHOuYK8vPCFBm34w6iYSJr62FhmdqIO
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3083;6:rYRWh20sK4b0pUWblH4gHlFEnod1e7zIIm8FmCJYy4NFnm+GEjsF6yh+meBaAymZq2sM3FrnboyPw30UT+Kx5DFe5qdmy2Dk5aSam3DPSGWNJsCuFWbr1+M+6zx1tJsLvemZ3z1b/gUUHOrqFW69sk9AsuBmQYkMEy7j1coc70Dd+0ID85RyjWDw7OVN+Jy7TDAM+mcgxrnib4RpXDvzgE6H61IHXDOis2nIkZhxklHGrwRuC85NYVlH5ZGpwIyp0Pd4MsHFDPK45RWR2DDZXGVVkFNNg/4CKX1UWfD7uuECe6ge4dEk5XVeAeI25aPSCB987rIb0f0Ja1y4OmRYJjbSJyIXYrR7qZ7N55Jl5Cwsx7sNB/lw8iNF83BcPMqiFWrKbOIW2mYAX/EDB7kknvBa5nAMR+IXVqoDoOWRUiOZezRgfBHqPxCs/t92qrX3wMAlZkezlV/mjmO715QA2A==;5:MY4tow4QSt4PDaESnbGj865CieYik1nXIePp66b9ZnwSnk5RWVzu3Wv1S3rBHeO4tN/+dnR1X/0otXF1Uybms2fmf+nLfoZHJ4TwgdlJ214JKjWwjJDBlItxQYY1UOwwkx979yZeeeEbXv/bSpdFiHJDQG9GsOSegXd7dBY89fE=;24:oePeL42jG64U6IplieiRJtZDaCqoLOtu9oQTBfjLKF/dHVdHT+EfthmbeD6kUs5TSa0ErScV5FC/bjJnZ8BHVM5NYwLuNLxY0IwbbxOwlgM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3083;7:7LEGKUoazjl/uaG34YK3VW3y18sp5c2e4FjDM4rjNLQy0hj5tYJeFOdls0T3MsLObTrQyUGr6AOIKkrMYHFqqGy4UzUOduwTz0NjmeMBPa3IBJiadX0FCRcRPoc9NX+Vo6zE1ge6+Kfv5aBM3zHBCKEfKKs4MYyP9knEkjO129bRHcoJd6YBQ9BvHSLN37W31a+fWNHzYwHCSoUotRMewJbHZeDGUYQLKeJx13q9OH03GMHttWyiDzBdkHJueZg4
X-MS-Office365-Filtering-Correlation-Id: 1f737d2f-28d5-4295-18b0-08d5ba511468
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:46:09.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f737d2f-28d5-4295-18b0-08d5ba511468
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3083
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 10:08, Christoph Hellwig wrote:
> On Mon, May 14, 2018 at 09:26:13PM +0300, Boaz Harrosh wrote:
>> I am please pushing for this patch ahead of the push of ZUFS, because
>> this is the only patch we need from otherwise an STD Kernel.
>>
>> We are partnering with Distro(s) to push ZUFS out-of-tree to beta clients
>> to try and stabilize such a big project before final submission and
>> an ABI / on-disk freeze.
>>
> 
> Please stop this crap.  If you want any new kernel functionality send
> it together with a user.  Even more so for something as questionanble
> and hairy as this.
> 
> With a stance like this you disqualify yourself.
> 

OK thank you I see your point. I will try to push a user ASAP.

Thanks
Boaz
