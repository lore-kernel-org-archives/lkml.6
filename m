Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146336-1521240936-2-14089825360948145341
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521240934; b=wDKYcgiXQA+Fkx314zlf4UIbkH85xkz414KX7RYlUrHtmFJ
    IF0QdwjwadfDH7cM1IAimDigcrJHZ0UJwk8RlTlHxuvahkkSKoV0GFXDLkVgeYmy
    VOg2H7TJ1fH5G/iKfs3/ph7QyF7ogH4Aa00Fe1NwPyJnYeSun0fil9dpYa6Dllzk
    EsyBxRVwaFRlzjtPeUZiohRjClcNwt1DoC9g5IVimY1YiKSLsLEvLD+EvY/IrnlV
    HIDJ2eDRkKZFO5us21bJMU4S4HldRmnK4lRM5V9M076tXMctWb9jdUNecp/b99ot
    S/8On4fkCxFCP/Qryy2Bg4PyrTte4UL6hr739eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521240934; bh=6VCwScOxKkvxKsqY4XCZr0DuHrkeZqMsbbdAyhtehpg=; b=p
    Mvffrs4RULtAbiklQ+x4m7DWTlbz4Yi8GLn/snIzN7T3FKdF1nVZUXZX3arGzI1K
    Xx8d2GyeYAUDDC7ZJ/TCFUDonsXJNR5e5YUXNsXnH9j/+aWc5Lz2IWXTP8LffxKF
    J9Q8tB0Z7mipss1OYF1ytkIgIwJeFh8n6d1s9IVskwiYW9Y3PS4ViK4/zyzo584w
    s4bc+vbKM8hQlQecLHAhauguebVqx2NY/lUffjW1HRboKxwREfRi39yFwbbtFAiR
    KhKodVUWZt1mH2tZ3fKDnimnJGOQ/y3JESlvSxgQgpwTauYMhNCuAhPBEjbQ1yJi
    Bwei2S8n8EUA2CxuA8S/g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=BLGu0DJB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=AVHvmei4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=BLGu0DJB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=AVHvmei4 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752715AbeCPWza (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 18:55:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39800 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752774AbeCPWz2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 16 Mar 2018 18:55:28 -0400
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Dominik Brodowski <linux@dominikbrodowski.net>
CC: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>,
        kernel-team <kernel-team@fb.com>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
 <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
From: Howard McLauchlan <hmclauchlan@fb.com>
Message-ID: <f47e1374-43eb-d7c6-dd0a-5d530ff2b4e2@fb.com>
Date: Fri, 16 Mar 2018 15:55:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::4:6d8e]
X-ClientProxiedBy: DM5PR15CA0029.namprd15.prod.outlook.com
 (2603:10b6:4:4b::15) To CY1PR15MB0534.namprd15.prod.outlook.com
 (2a01:111:e400:59d8::24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03d7e92f-a2be-496e-18c5-08d58b90f74f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:CY1PR15MB0534;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;3:628zJBOZNmgTx7m89wz/gI5kpqat4qVZgz92KdNfY+kthJLvTCxcMb/hTGI2QEYO8Yz80W5Y8DS7BUeYdtKEkpS7e1D0cF3Yuqs5I4p8Bbv+tpdMaPZwWz9H3jKUxTJMyqau5RvDiU5Xx/L96vkd36EG0S8b03+lT9BxlPZLe1424Mw+VWCbtyQlrI5oxSvuWSA5j4DFPN0n/Nm9kjJTRd6+KdAw0vEo0g2C9nfZCBxj0Bs0uG1e03catRvdiMM8;25:A5eyWzZNSAlbRCHKWlBZ5llEOK//OleM0tCmrHJPEEXV+hW0n9AV+2ftSM57t1asmk6NY7Gq/rEJk0Ekg0mX+Y/uUY1zNarxiYUPjFX4aNe3jo7ifL5qKsJhrxzslf6HeXX9SJRWNBQ3GeK73Q6yYJknvbHYlkKv/KuaIuwH7UTv9fOI8yhBzOO4iT9PlaDfGb918KE3tV/kB07ec/LWIcZy8w9AIbFQr0YjsSpEk0If9mwtW0KMqtoSj1K8GXnBtwl4hf3pqjy0UOrW1ShnmFhI1MkAZt/CDbi91mTjGkRoNRviW2bgLp1ZE2hj1fA97mZVH6GOzAsEmj6vft/+y37OwW5ESPlyDHA/ucFgU4M=;31:npq1newbsSS7cU79KIP22ShNE8pjXsqEqu9IUp/LhN+/DElz4hNbUzCzj4zw5y6Vwqa8hmibG+T0vgzKWkdSQOUWsgBeVlB5eT77WQtNx4jP/ID0ioLjJIMdSp5IB7B4SytxEk37JtsUM5fHkJIAMSY2xBanPlWNilC2qrACJDDY5C+X1Z0bkLBaaPnBM7QvEYf5aPSywoxZtrTM7wU9PIcPB4Uf3Xvsbs77e3Ep0Ng=
X-MS-TrafficTypeDiagnostic: CY1PR15MB0534:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;20:UuqBTMXX4uhFYemXMDjqVxYWc/ndjmC0Mazhcb+1iZ6TtoXnaryI5gYVZPqF283QMjOlMBdhmowZoEVQboKDElGsZ1xFn2q349BwnDTUtx2YCgFDqhk8NSPSB2a2HYlBDPaSKFnScVY/GAFc443VKC+8uSRaTN0D1NuEmAT5obZcM52lePdgz0ofvboMGXmgWvTQllOdmRrIGnMBP/5GP3d5azK4IBWakwV3vwGO7g8NwmXpV2XPP4hfF7KO2W6Ubs/RlcgwYMqjeTx/oBK6SASlt7ScolW0awzUg4R+ISsGJEu8mkaQdy+EPKTQKdoej1kgdelERWmXFqcGpze+srdHMXSbHScmOMG0mAoPsC7x+FqcTG9WyG+GB3GOPe7ega3nJBK62IX+myqavOZbPO9tVMmohEFBrRBiWPJr78MbfghPbxAvybYIHqAm9whdDbpw6OC812npXAMTgGwFlXL7j+Ioi2zjJPPnme+YZ3Nm9GWW3TyiNV4rrgAzBSya;4:jLHcQyqUg4ShYywa1SX3/DqqE/dtWYyQz+9bhWQqY0HZgpdxSjEn4PIE3VdArsI1OKqDg3K0G280Ux9WkaVL369uzHPj/mDC8Hq7VntWSARwO2vXpMZsCvg1gYWtAw8JZE+Bg0AchltIEjuqJ01M19XLlQC1ZOpXpdL7oplJde/pBT3iKo8VfIDlzmi7qTCdwOX9rgAk+NBC+oJljYVwIuOHzVYl1enbOW376UulFicgoVl6R6u8op0Brsdj6pXEuDUqqZOUyIy1TeRE9W/uurJtTe3NLdvBPIM0nCqbU1Z6+Pg39PFAqOQlX1TCybnk
X-Microsoft-Antispam-PRVS: <CY1PR15MB05342D62FE20ABAD55AFACE1C7D70@CY1PR15MB0534.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231221)(11241501184)(944501285)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR15MB0534;BCL:0;PCL:0;RULEID:;SRVR:CY1PR15MB0534;
X-Forefront-PRVS: 0613912E23
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39380400002)(346002)(366004)(39860400002)(76104003)(189003)(199004)(36756003)(65956001)(97736004)(47776003)(65806001)(6666003)(76176011)(53936002)(65826007)(105586002)(68736007)(81156014)(386003)(8936002)(59450400001)(8676002)(6916009)(81166006)(316002)(2950100002)(16526019)(1706002)(53546011)(46003)(4326008)(52116002)(230700001)(2486003)(2906002)(52396003)(52146003)(7736002)(23676004)(478600001)(25786009)(6116002)(6246003)(31686004)(5660300001)(54906003)(86362001)(229853002)(50466002)(58126008)(106356001)(31696002)(305945005)(64126003)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR15MB0534;H:[IPv6:2620:10d:c083:1309:ff83:7b3f:34e4:e069];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjE1TUIwNTM0OzIzOjNiYU4rd1MxMFhGMzc1cFlIcXZ6YnZXaHQ1?=
 =?utf-8?B?Y1F0cU1TbXVlTS9sSkIzL010QW9MSEoxeWJXSGlXakovdWxXOGNrcThBNnRP?=
 =?utf-8?B?VDJkYkw0Tm45UlY1dmJETnJ4ZUlPcU1GU3Z3OW9TaS8vdFcxRkFVQ0tldGlY?=
 =?utf-8?B?UFRkejh4Tzg0c1pRYWppT1FweVNDVjJGL0pFZHFRa0p1N1Vvc3NyeHlETGpM?=
 =?utf-8?B?S0M4dFZXbHEzV0JzSVRYS0xiZ1I4ZmRwZTY1RU8xTTM3NlZ0d0hzUkFpZ2VS?=
 =?utf-8?B?OVgrMGNsQjFJbVBxalhvUENPemN0bXRKNE9UOHMwblJuUjZFUHJCSGNZUTVl?=
 =?utf-8?B?RU5WeEhmNGdsZmdkWWpBaGZjZS83Kzd4NzI5NFYxdWVTOXBZalhtSWZDTlRQ?=
 =?utf-8?B?U0pqQXBIRTBId0JpZ3hZSFhFSjFXM0cvUGhmL25pUE8zdjUvZFJaa3pIdXB2?=
 =?utf-8?B?M0RaMDZHSk1NSmZ0RTl6dXRBVTV0N2swRTV0OW1vWU1JVTNMWEtZa2lRQmxk?=
 =?utf-8?B?T1FUOWZFbXZOR3BQSHhaTm14N3VpYTcwNTNRS3ZRUW41bzZFaTNwVXhSaVdy?=
 =?utf-8?B?YVlEOVlRaElRN21wRU1tbFY2RXV1QXVzVnBFWGcxcXVQbGIrV2oyYmRjVjlW?=
 =?utf-8?B?b2xrcXd4Ky94L2NHVEV1WEZDZG5TeHNEMUJHbUQxZ3QzQ2pHUCtmUk5ZRWRz?=
 =?utf-8?B?NFIycUZFUkl3ZG1NN3NFREtvNVAzMkIrdzVndEFWaFYydmc4YUhremk1b2Nr?=
 =?utf-8?B?dFhlMm5wZjNYMGlXOTkyeXFiUSs4ZVhNV2JKczR3M3pMYm15Z3hZbldCOG93?=
 =?utf-8?B?VGRJMi9SWTZxVmRtQUdnRWtpZnVzVVhTR1cra3crQURLSE1HQUZsdE5VU3VX?=
 =?utf-8?B?QTZYWHB3SUpyWjhISm1kRXRzMTUrTGZMK2RPTGgrSkF4UTBkNG9tbU00cm94?=
 =?utf-8?B?Smg0TU5IUFJBM25tZkZXd3ZyQzM4YWtrRVpHWndjVW9nelFRdFdlN1B5NmZq?=
 =?utf-8?B?c2tXb1pZb0YzRVNSYmVWTGNZbExkVGFaVTRKQWY2ZzU3VHE1bzJBb09VNW95?=
 =?utf-8?B?UXI4N1dwU1JkcEdDbmpPc0FleDlibXh0MURGYmFqOW56K2xYNTBFdW4wbFVE?=
 =?utf-8?B?UFM0dEFudzZlOFNtM09lOG5LZGtkSmhxL0dDYnJFQnN4d0pDVXkyQ0VGQUZi?=
 =?utf-8?B?aDVuZkVQcWJ3bmV5bGkwZlJKTGQ1aysvRk0vTHkxdlJlUzFyd2d2YTNuL0Nw?=
 =?utf-8?B?bllzVTZWdnpteTVOYmZyOGdJY2JLYmRKS3JZMUdoc1ZjU0JERVBSM29DYU1E?=
 =?utf-8?B?Zm8yT1luS1liTVlUcVVDb2h6eW1weHhTWTZHeWRqQjRDSVkwVDhjR1hObnN4?=
 =?utf-8?B?WTB0MmszN3d3WFIwb1VaZGF1Um1NNlNNdW0yekFjMDdWakpvSGUzWk14SUNU?=
 =?utf-8?B?ZkN5V3p4VXk5MFk0NXBKN1NNVzVQdHFoWXhsK3JIYTZiYnNEUERyRExWTkFj?=
 =?utf-8?B?Ums2ZjdKMFQ2MmhvYjBXRFg0VDk0RHhZdi9zSWhwU0Mvc3VDaUVLQ2RUZnla?=
 =?utf-8?B?TWVTenE1L0FwV294em9kZkNNd0hRc3hYUjVjTjd0ZjVmSzIzNk96cWMvdHRD?=
 =?utf-8?B?VXIrTUdVNitXR1BOMHVMdUNxc200MWQxYU8xYUpzeUtUcmd2V3NQYlgxTFo1?=
 =?utf-8?B?Ny9yNzNKZ25VeHoySU9TOHAwRG4wUksvMk9vcndpT1kxaVBEZEVjKytaUWhT?=
 =?utf-8?B?eG82ZTlIUUxrTCtLdDEzb0ZmcUtLMEs1SUo4aGdjYnd4M0tTR1Y5QnhDcDZ2?=
 =?utf-8?Q?vpE9e81DK1EzK?=
X-Microsoft-Antispam-Message-Info: OQUqfCNXNcFdpJRXn3t0CGK9F0n1ZNFufNz24/zKcBGOzahvFGGW+jgbVGjoKXZevEbhJM+i8nJ253Zdh99MLPGjQU8LPglxwnPjO/PQNM4h2Kh+roObV9ZYCWwtXVHrIip4i2dsSTyz7Irx19lzrACC8opKtn5QRhge9/0Wk0lJaq0vDw4XRl5TDtuIRaTX
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;6:l/XVESQxz3vK1xmeX0EuWVEJqTiNBDIJGHFQ0keMGuIQep64ZFfcII6JGgy+rR3r1/xR5RcrJoaKST6kt5xFJ6IZiC83Q1IbsnUZAzye+ZSwufRr1GzP9wwJplQaXWtUSzpd8tv2jkr90Xp6iibMYGfr5Nn0bHXCAEo6NDER6t+JwIVh1MITJyfMr3fpSkesJpnadZNiZckt0mHaOlCqNWW2+TsDVg4xgbE+nrbUChJNHb1mka+zu9P10BQDeLdr0pueUpQfFqwTczCxGd8BkCq+YaBOD1dOqYIGnXc8EnO/BgYLLmFwXgWoSIaQjznKLrOtmusBobI1xIh9PRJJ3fUkxIM6kaxdlsPIshSzKMs=;5:BufreXyCgNWhRzBsAwWLVux2QcXF5oQabDX6cH3trU8oHPr2h43a1bi7DEqgGAMBq5jU4WBNBfdGIz4w/K+7Ubu44lS+gY48xROqaeQXkQwHlGezbOYBExHGVQTjGYX32mWZ8hvx8ORWJdPFS88nGPKpplSn7rvN+iYQ015vmoU=;24:MsUdO1KLWIyaqi8OstkH8ge/kn+11K2i9AYL5T6uR6IKNRmIY7Y3CnARCmRY+DGlalWIFhq1Dj/BKpU1VHOZP6uBxDLafLeM5WqgMw9D3Fk=;7:60or9eEyW7+Mbl+2fRGgx7DsvzYUlhIOXjMxQy4T7Po1l7cdMrLjO3Vu31Yg+6XblR9OlqaXne+jDuvbjQaR2EcgnfaTTwvEpI0NXrgRMS3seUdfx7Ay1jMnkO0SM2wGIWlm6owG5nzAYJ43YHRRlQ3TiF6ZfYfs6Pb0Dz8vXOiLXxKJsH1G+9y2/pyIdY+Tm/VqBCRV+W1DuYzN3s45feuukpt4h82r0rYHZY6nY+h7d/GF8z5Nm0djGGOrPmIW
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR15MB0534;20:9dxxq7BnaJFNQgUNp3bbvNYU5Bpx/+zEb6dsk8OffyjoJZbYaaiTHzw4voOC79yrz0pIZ6t5JA47ZWeuE2YQ+Dvv23+F0lXj/Ug5bM02kp+QtPCFsiIlTZymvECLSUOTsnFwQnVDLwdhvcoS1KoteAbxG3iJiErtbhb6lwXqvUI=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2018 22:55:07.2719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d7e92f-a2be-496e-18c5-08d58b90f74f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR15MB0534
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-16_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 04:56 PM, Andy Lutomirski wrote:
> On Tue, Mar 13, 2018 at 11:16 PM, Howard McLauchlan <hmclauchlan@fb.com> wrote:
>> Error injection is a useful mechanism to fail arbitrary kernel
>> functions. However, it is often hard to guarantee an error propagates
>> appropriately to user space programs. By injecting into syscalls, we can
>> return arbitrary values to user space directly; this increases
>> flexibility and robustness in testing, allowing us to test user space
>> error paths effectively.
> 
> Temporary NAK IMO.  Specifically:
> 
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index a78186d826d7..e8c6d63ace78 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>
>>  #define SYSCALL_DEFINE0(sname)                                 \
>>         SYSCALL_METADATA(_##sname, 0);                          \
>> +       asmlinkage long sys_##sname(void);                      \
>> +       ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
> 
> sys_xyz() is not just the syscall itself; it's also a helper that's
> used for entirely silly reasons by various bits of kernel code for
> quite a few syscalls.  Fortunately, Dominik has patches to fix that,
> and Linus is even considering pulling them for 4.16.  This patch will
> most likely conflict with the final result of Dominik's series.
> 
> Can you and Dominik coordinate a bit to get this patch or its
> equivalent landed on top of Dominik's work?  It might make sense for
> Dominik to just add this patch to his series so it can land with the
> rest of it.  Dominik, Ingo, what do you think?
> 
> --Andy
> 

Dominik, 

This patch applies cleanly on top of your patch series. Is there anything you'd need from me to get this in on top of your work? 

Howard 
