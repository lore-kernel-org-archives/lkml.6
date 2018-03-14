Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-220671-1520985672-2-6148348611020806177
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
    t=1520985671; b=Nhs9T7B9wkuTa9fnI4adzY9xpdLswFxPGAb2c7Wxsjz6K5z
    PShGZyIHijQt5e9cJqgMLorJ8HoinSPdBrXFHdHyZHdE7RQxx7u5HQpkju1EX3EW
    +/RKMfbAiNFgA+RyEfBH7+keke1Cjk9Z+fTlcV92gZLl8gfj0UPutyAfm4dtVbCo
    Ufz/aotim7PGq4SS6SYwATH7xJkSwA+hytUNxwdTXsJoXgFBfo7bnQg/nFHiy/hd
    fY0PBc9Sor2CKkVpuF7RJucv0zFsRvWxNVxbwqMzBNnxnU7EDNslzdYAD7f9gZZN
    yUBQJu7PVmRqZ/e+LmmnjVC3bhOYIoiNhzwCBZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520985671; bh=zDtPGaxtDF6eJarz6Kf8h2eMB+6YCCq5z2HGTfdNmV4=; b=Z
    VYul6WcKdikCnX1fWR48wlGafQIKoGo7ynmBTrCZKoSOEeUpfvXRYmj/v8fYMQg+
    /+gBr5I2VkH6QLo3lXWjWUiviZ1WrvlOdj630zQYDz9U3OOfdL5zuL4fzfc+X03T
    luAVKbfNNPj6vvPsszFOZy5g3OoG5vVbbEcC2s8wdIwfrsPQItFFuCdzx4Gej/7i
    ue0gSRN+ewkQaajdFC3in8uElrt2Kfj+WBwOvNHvQ+DF/HbfzqTUwot4byRF4egV
    6uuOnBiFDe6sEmBVHn/m9vFcXU/gqkPvaHJ5cE94a2RlVNmYFgxvG8cgMOKPDLWA
    7l08J8lx6Pwi0+z1JUKhA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=nhC9n1ov x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KOcRYQof x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=nhC9n1ov x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KOcRYQof x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932948AbeCNABD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 20:01:03 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932511AbeCNABA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 20:01:00 -0400
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Yonghong Song <yhs@fb.com>, Omar Sandoval <osandov@osandov.com>
CC: <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>, <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
 <20180313234509.GA4981@vader> <67172932-df1d-5585-601d-a7ce70a2c86b@fb.com>
From: Howard McLauchlan <hmclauchlan@fb.com>
Message-ID: <dd848cd6-a926-e67d-e194-4cdc695110d0@fb.com>
Date: Tue, 13 Mar 2018 17:00:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <67172932-df1d-5585-601d-a7ce70a2c86b@fb.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::5:747]
X-ClientProxiedBy: MWHPR22CA0047.namprd22.prod.outlook.com (10.168.250.161) To
 BN4PR15MB0529.namprd15.prod.outlook.com (10.164.61.151)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45c21893-35e4-4fab-2976-08d5893ea0ba
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN4PR15MB0529;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0529;3:maJZcQ559yG2zr7fSiAbCyLqFDfFIoG1IaJdkaTqN8XcyJKcRVaBgVW2aVxMzL1waKXtlVDRxDh/zVq07drc7diprXI9iheToCNaPA6tZUcFKe9cLSCuNyacgEQwuNabt/Rfj4ydRdcebbvgS1BilROw76lor2hSiKiOvODG54CWJCLt4UfawKLyEkfsk3JMbCVfTIfVj4b+PweghdQ1b4IjpWS6lRWqa57jOsVCeduLChNxJQmBrzh6sdRgtfxP;25:9ZrfHUPYA131xCCNCnjF5pCMAxJXB4iesUTiNnXDzx4UbIdomq3rwQBjQmEUG1Zve+3xzSqrxzOWJSd70B9BeDlrf6daiQkEdk72BqC3M1HNuJC2kVKpP4QX2AUusDu2YpEqp2SXD+pFdRvIjqyr7MglXqCSFiDxDastrDWxCS6SfgxFWQ4OJ3bvPs1KfhfTI6QSe7NxanSVlEbNZN+fa84LvOm5fGduN2nz2QL7Suor9MOryiJyLP4gVrhRpNqOeCBU4Bs41cuaRW3Knc5iTkU2xqXK7QUAZHHZlO0rgfXleWnHLJvFgb0KOMSIxromPIfPYFUShQU2nDZ1ZC1Y8koFoC/qH0C9fcQThag/uvY=;31:JqKKP4qUx/RJlD37YQAgtUS1xAnypT8ZIpy93KTOvoiXkfgohgDXK+7Elr5rVUZ+CnJqOn5H8orsg1cvAjs17FyC/tOp/c13o2idM7k36jGjpKxNxExbpfrFaFRKfnAF/R8ONm+VLsGxQufpHUq7ZCj4wCy9KtBg45nhYOGO06CRSNnDOEqwXcEFesUgyX851BB9N/WC+W+ANUfRwSf1Dgq6mQKurlZRJgktcigdC7g=
X-MS-TrafficTypeDiagnostic: BN4PR15MB0529:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0529;20:mOGBNg+Y9uOocsItdZ72/UOV0JecJ1eYMFH1KlblzSp6xr/99Uzu8xQvU9oqYpuaAarhr6HaLMTKbVSUI5+mgV7IaazEv9l8ceaq7V/JctexvwZLdO+IJoc7GW4bh60cq/V55I2uk+8kAjZisUAkx8IbImSqmVlZ9+aWpOooqznEL8QX79UhtHGuIF4HvVXlTIIJAVjPDXmcvW2uoDNkJ6bunXCM2amnlHWLphVyQpVGhoXEWVrxWjcGzXtJH65bs1GUbIi5eZTkJ+CbFPQnOKUT+KEmYyYqMJ9BnD8yIqjuoSNuxCqqry1nZ4LH2ANYGiNIdI6BoiJYw9MK7oKRqO21VeoVv7Hd2rgxW6kQtkodicp0iozQ4WrvlqxjWp8gjacB5rTs3XethlCHiml0yAYGguZ4DUP75EdDvyqfp5LxzpU5j3/ayNCaqjtZhuEZMo5fiR65xVNqzNIZHJqAHryxXHrj8gq82OdxH1QI3Mr2N3t64P4bVNmMyePl8X+Z;4:hcuYsmRrwLZpE5FKQXc1cC2lXOmGdMo0+Q50RLgha6+ElBLWAUSesI1WXdKnQHveuCyhb4ur4ScY+Dk+1irfpRhGNMjGu+K6jjy6D+X0RiVk7OmVxG73LnvRDfMUdj/a8GFnLNDWJg7nNST0JBGeaRjlka8m6Dq68U90G595iYZKIgfKrGFHxpsDghcOdjgXSoByrxdMBeRzMreJ0VjnGQnxY6nG916pVfMCkF7TP+ZC5H8+/GkS6rCTItHffzrDOfW7YnRN+oClQjQJRz5CtugAbpzaz099CgFf9UiKcEjw/dpdHcQy2P9BEE9UGKf5
X-Microsoft-Antispam-PRVS: <BN4PR15MB05294497810253AE6FDE2412C7D10@BN4PR15MB0529.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:BN4PR15MB0529;BCL:0;PCL:0;RULEID:;SRVR:BN4PR15MB0529;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(76176011)(36756003)(50466002)(47776003)(46003)(106356001)(229853002)(2906002)(4326008)(68736007)(7416002)(5660300001)(86362001)(7736002)(478600001)(6246003)(2870700001)(25786009)(305945005)(53546011)(6486002)(386003)(53936002)(54906003)(8936002)(97736004)(6666003)(65806001)(316002)(64126003)(2950100002)(58126008)(186003)(23676004)(52146003)(52396003)(8676002)(16526019)(2486003)(52116002)(105586002)(1706002)(81156014)(65956001)(6116002)(81166006)(65826007)(110136005)(31696002)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN4PR15MB0529;H:[IPv6:2620:10d:c083:1309:ff83:7b3f:34e4:e069];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjE1TUIwNTI5OzIzOitDa2RxS0hFSVBtZlk4azV0cU9HTVlBZ3lI?=
 =?utf-8?B?bGw5RU54VVppL1VydjZpMkFMRG1heG5BRnlJVFR4T3A3QkNpZzM3WlhQZXI1?=
 =?utf-8?B?VkZUZTFRU1hHOCtub3g0VjBlYWtrV2tUV0NlY2RFL1F6NDZCSnowcSt3Y2dL?=
 =?utf-8?B?SGk1SHdnUEQrdFU4Vjl1cnFuejQrTC9yTTltd2dkS20zcmc4VGI0QS9nWmFv?=
 =?utf-8?B?N2gwVGxFUERERmdFZ3prS0g4OVZqWDdxTnJSRmgwRklIMThQZ1NYN3ZHczVR?=
 =?utf-8?B?Yk5ycFhCcG9OejFldTE0SW53bmlIaTh2ckZRdy9NU0dyRmRFRktPUmE5MDdC?=
 =?utf-8?B?TUdNUW1OTkc3amIvM2QzTWtKNTVieVBURmJZTzUxU2dpcTYrcHh2MWlDckFF?=
 =?utf-8?B?WXlnVnVURllHeHpJdGYzQXl3MEx0clNheFptQXVkM2oyRFVHS1E1VlNUS2VB?=
 =?utf-8?B?TGxDaU5zUENDa3BUUjhtTUJlWWI1YXpSU1haY0RrSVQyemZ2dkZVVUhxSjFN?=
 =?utf-8?B?d1dWVzFJVnYrUysxSFBBZFVhNWlKVE9hdC9oTUhWOUlaR2E4b0N6a29PT0J2?=
 =?utf-8?B?WXhlemhaR3pMVFlOc2hNSU5Cd2Z2N2ZBWFYvYjRKZUpPRmcwRGgwcU84ekMx?=
 =?utf-8?B?VnN2b29YZ2lrbTlLV3NjblprTmtNazRhZXAzVFNzVWMyN1JrWXVwbUtuZXE3?=
 =?utf-8?B?RUd2NlU1MWI0aUM4UlI4Mzc2d1VqQ1FWTDVwaTdHd25sNWRzWC8ydk51ZnNm?=
 =?utf-8?B?SC9kOVdBdzhmZE5EeWgxV005RmxUNktGVXpDaXoyRVNFM1pUdDYvTEQ1Tk9F?=
 =?utf-8?B?dExHaytmVmNNdU1lb0dvcjIyRVBYREVDdGpHRmhNRjdyUnpLVHBwVkdPOVRt?=
 =?utf-8?B?R2w2elZGVTErYmgwT1pRV2hTV3FEdFFzcDBJd3ExekJadThYbVRDc1pTdkgv?=
 =?utf-8?B?N1RpSklkcjgydm1SVWJVbWhQQ1V2ZmRLMjdqWXRRQ2dLb21PNlgzNXJOclk0?=
 =?utf-8?B?dFNOa2swcHpwbmZscmNiUHVZMStySjB5cjhpa0o0WFlIdnVlVm8xbDQ1NHl5?=
 =?utf-8?B?T1M5elBzVFB1UDFQMnhCNE1KaWJnQVNiUzVQc1c3aFZPZ2JyUDNQeW43MEJp?=
 =?utf-8?B?ekROamRNdDd4NjBjdGRPQTJ4Z1lwblJENGhBWWpxOGgyMWxXdUlMLzczTjZy?=
 =?utf-8?B?MFBkYVo0aktJMWlvcWtzTk5pZ3NJQk5IM0VncDBjN3RkMDlpQkVFZWtNLzZ1?=
 =?utf-8?B?ejRTNHJ4M2sxRTkySk9XZENNMVFiVGlQU2RZenRiRDFDU2cybCtnVVc5MVF2?=
 =?utf-8?B?WEwrY29kRXRrVFlZakVmRW9uUDdBbnJvMzZwSUorRTV1b0lxMzdLZWE0WERm?=
 =?utf-8?B?QXo1RkpvRWlBUlB3TUNlY3BBMDdwTmpuZ0lpanlKODBnNno1ZWg5alpDOFFj?=
 =?utf-8?B?UkhJOFVSZTdyT2NOUVpKMzlPQkUyMkF1U1dUOEMzN2JLR1RLdlYvNU9vZHF6?=
 =?utf-8?B?eCtCa1FjT2d3TGVtaUtZaGZNMTNpbGtVZ1FIRm5VcXg0TzFBbFZxcHhDenZh?=
 =?utf-8?B?SEtWYXZOZXlPUzBJOU5qZmlwSW9hdE9TU0FhQzRBc05jeDdKV3k5UUQycXVv?=
 =?utf-8?B?d3FYWXFUQkgySFcyOVdRZzVlb0pWZXR5R21MK0o1d2c4RkluOVRIbEJPQzhw?=
 =?utf-8?B?ZDRya01kbXZhZEVGV3RLU2dXa05Zc0w2TVUzTktVL1BaR3JValdtZm1aZUdH?=
 =?utf-8?Q?TfPqYJiUEn5yhIGgRWb6qC2LjBqI9CtkpP+nU=3D?=
X-Microsoft-Antispam-Message-Info: hz6UgJW4DwJC7JRuzWCa1fi9N9+RhyQ07lIzlP2dUnhZv2bFqp32mnqvqRpD1PxSCyi04cp6c/CFF/dJtWZ6B8TOzJuElFwrsXlsYLGGxgHQ/unXsX82KAqu95/cBhjSGi3vlCfn4+mAm0Ba1BI2ErCqMeDmNYRDVc3SHSZ08l3Lr8gjzUSfv6csQ08ooFU/
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0529;6:KkLuR3b8wKGFSoc6TL5ak8hsz4N5fcZ471JDapPw2hM88hxG3QNtFJolRHxhQkF+RQ4NRSWDvsLdMf9X+g4UALbSVGRzzCPx7KzhAXRMETnj1HSyfvn1MaqUVZ2uKTjd/3RUHpT0eqdNW3oZFgTo0mxdCw75i9vZiaIglkTbMUIaBCJA9/mfninBvgTj1b2Ap99tcxwMPTySDTBZXwj3Kg2l6+f6Yg01TwBTkO6Gdf02xRNyIMy2uyhEiErqFjBoyzQTBVfzp+GW1dWwm4ofl+fYX61SdSzTQ7q1vdL8/V/apO8yluZiJeqDXa9zJBCF1qmE3rVEYF46z0ruONOf2ohRITVfPczgPCd5lXfKK2k=;5:PulNkjqiUXGaFcC2iLroNST1RUhSVhs/uU3wHLNcTV1ZTB1/kPKpJcMiQiNTtEQsy6z9Md5J9daJio2K9tD6HfJPTmOXDo6aP5OY1JK2oApIzhDnUducvH1sQeesY/7CBOVvW2A+gw3osc3LQ+jaaW+rwg5RwbDHKuFUYHEMwTY=;24:NFGiKUsZ6Xijp8NcpiqjPaXLCs/jyrTCyiLxr81zaRBoWDlfjrTUCx6hYI9ItXSMGiM4E4eHfMZ5qU3jiqNieBmNLYUR97k2VPi7h23YK9g=;7:uSFiuJqCvEGqTfhZYiML1azQ0OOUdd1AbxuSnBhAnUOD/hO5u9ipKUinUqDRHnK0E9juqVB3Fu28U2SPz2kxWGXJcvMv/lDfExxSN5lcX3PHOaFACNvpOizJHJdCzPJyKVEqE949TDUlNwBIzVOzmbjvZb03JKwYIx4ujtRL31gt3RNgYZZ8/6xpKs7wpJ+e4GbBuIohnppTxN8TmzSx9yMpsMsUqATqa9Pi4OuK3FEDAf4qJ1PrBizgu4Ij6ySv
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0529;20:A6HA2Pnhkzvyp7kocEr9HCJ9sqvk6dyBHnH9aQGvNt2hge13W0bzCIWqo0mK/z7MoA0lXMcSloJow3d49J7zYTfvQpXjQ5uMcOyhBMBpeMq2Y5IOF42+n/2ph+t5VWuFO0JccQsMbED0c4by9lNlkfFw1Q4WaY7dISyeCCXPAiM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 00:00:40.3602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c21893-35e4-4fab-2976-08d5893ea0ba
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR15MB0529
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/13/2018 04:49 PM, Yonghong Song wrote:
> 
> 
> On 3/13/18 4:45 PM, Omar Sandoval wrote:
>> On Tue, Mar 13, 2018 at 04:16:27PM -0700, Howard McLauchlan wrote:
>>> Error injection is a useful mechanism to fail arbitrary kernel
>>> functions. However, it is often hard to guarantee an error propagates
>>> appropriately to user space programs. By injecting into syscalls, we can
>>> return arbitrary values to user space directly; this increases
>>> flexibility and robustness in testing, allowing us to test user space
>>> error paths effectively.
>>>
>>> The following script, for example, fails calls to sys_open() from a
>>> given pid:
>>>
>>> from bcc import BPF
>>> from sys import argv
>>>
>>> pid = argv[1]
>>>
>>> prog = r"""
>>>
>>> int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
>>> {
>>>      u32 pid = bpf_get_current_pid_tgid();
>>>      if (pid == %s)
>>>          bpf_override_return(ctx, -ENOENT);
>>>      return 0;
>>> }
>>> """ % pid
>>>
>>> b = BPF(text = prog)
>>> while 1:
>>>      b.perf_buffer_poll()
>>>
>>> This patch whitelists all syscalls defined with SYSCALL_DEFINE for error
>>> injection.
>>>
>>> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
>>> ---
>>> based on 4.16-rc5
>>>   include/linux/syscalls.h | 3 +++
>>>   1 file changed, 3 insertions(+)
>>>
>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>> index a78186d826d7..e8c6d63ace78 100644
>>> --- a/include/linux/syscalls.h
>>> +++ b/include/linux/syscalls.h
>>> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>>     #define SYSCALL_DEFINE0(sname)                    \
>>>       SYSCALL_METADATA(_##sname, 0);                \
>>> +    asmlinkage long sys_##sname(void);            \
>>> +    ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);        \
>>>       asmlinkage long sys_##sname(void)
> 
> duplication of asmlinkage in the above?
> 
The pre-declaration is necessary to ensure ALLOW_ERROR_INJECTION works appropriately. There can be syscalls
that are not pre-declared elsewhere which will fail compilation if not declared in this block.
>>>     #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>>> @@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>>   #define __SYSCALL_DEFINEx(x, name, ...)                    \
>>>       asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))    \
>>>           __attribute__((alias(__stringify(SyS##name))));        \
>>> +    ALLOW_ERROR_INJECTION(sys##name, ERRNO);            \
>>>       static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));    \
>>>       asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));    \
>>>       asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))    \
>>> -- 
>>> 2.14.1
>>>
>>
>> Adding a few more people to Cc
>>
