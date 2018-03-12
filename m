Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-942284-1520877000-3-11529810876670758734
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
    t=1520876999; b=CyruyzHnefF3lVXga2lVJdQyit5XplzBt2M9WQVNx8ppWHt
    6sW1CbzFH7mitRZLkyHeMK2wl5fLM9lOZ01OU719QDefdnh6dLH0E4fSzu6p6eND
    LpBORxbggApRvL7ZL7Ik9IRUUhWIOSLhG3/vp36/WPuYlfLxyoAkq13pJ/3hm1pB
    8RxRAoBkbuMUB7185230phHmyZEjPtTrK/dtBx8K/ytAySUuIDmLjuTk/6kvi+wT
    Ob3ZcenQwwvowU/zGZ4tBIW/ewVVibAFf2Flzmdag/xYgGQQ75ELhCkL7n+r7++D
    DLBrRMHGe1ExCLgHsEqwdQ/5TCo3Xg2h7p02w9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520876999; bh=gAW1fOycB0pFzwoYEnEmYWiNsIJD6/7YLeWmPyzqfWc=; b=P
    r+0r+j2UVdPqBB7f2/1gFsi5tnDeQ7us2R+MLaSYLXdHYUGJHUgGp8DvmAJATqkE
    KAqFvDYpJjjXXw9y8EqNX9wm8Oggad92RkM6E7m1+SgPUkJ9eM95T2qeiq9VgdvL
    nGnudZlYu5Sbgy4dCu5cLkGWRWGNqMzGX46T6Xj/hrETFQVb5hdHRv78qrreuZoQ
    ACBzHxtHjTRmiiGtauBUsRyIg0Y+P4csK/I37symO93BlsFD4WbbrdAcWZ9sKg7G
    rtEwkMYpWPX9EdrA+Bet8FAu4PCxammg5UGYcxswwDzZqcLAOwfeuEtZPTBQip39
    +kBf0d/u0CJt7ovBAUvzA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=VE0iNG8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=dTgh+Wh5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=VE0iNG8W x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=dTgh+Wh5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932574AbeCLRtn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 13:49:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932231AbeCLRtk (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 12 Mar 2018 13:49:40 -0400
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Edward Cree <ecree@solarflare.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
References: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <20180309.133509.1275903267249306409.davem@davemloft.net>
 <CAGXu5jJcuSojm_KN5+JQ3fV6J09V6dmNB6haqu11xkXTq=nxog@mail.gmail.com>
 <CA+55aFzJEkUGfRkKqc8twaDSdSH_r_OWnFm-e4uNQf4SrJy7-A@mail.gmail.com>
 <77cdc9f5-b51c-a18d-5422-763cc4e76279@fb.com>
 <30db1e8e-8eb4-5072-8360-6cafe26db113@solarflare.com>
CC: David Miller <davem@davemloft.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <46e60759-e095-cb3c-4505-e5632916cd55@fb.com>
Date: Mon, 12 Mar 2018 10:49:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <30db1e8e-8eb4-5072-8360-6cafe26db113@solarflare.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:e6ca]
X-ClientProxiedBy: CY4PR06CA0027.namprd06.prod.outlook.com
 (2603:10b6:903:77::13) To BN7PR15MB2498.namprd15.prod.outlook.com
 (2603:10b6:406:86::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a46a5f-a807-4bf8-3c0b-08d588418f02
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2498;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;3:+BNOSHs3WuNMORN+JPkXu3OlccDurvPZE2yybyVcPKAjzIJzsfBAbOoP9k1H1xAeXkigOb7r9BNgXHzkugSsInMca6fk5QL8X4+iwI0RQq6ogS3usx4f5FVq2oSl+axUXgxZpdYe3G/ujB2OS3tcBUiRJ8VM5uuueHqVZS9s4+WGMhjvH3GMwtuzI94Qle8wOmKuTn1N5mH1zF5dRK9OP3CiAK89hgl52zU1uVuO+OoSKNcmip03lIc6Qkqz3o9T;25:A1BokHG6nz86Zpa8KpjmYS3OuRqQVkQa+3W9wDhx3ylNkk8iWzxvckbUFyJ/208z+MhcCJTtfw1tYjeeOPSevvrhsA26aUzB+v8bj4zIZKXtx2UCRo80BGIbvMycbG7Yu/ikgbmabTHzbv6U/mmsVhtIkVeD7U7l2c1kY9tJlt55DnsUM2VE0xgAisEp9nZGoFxjONH0oMxXIKRuydUO9LSkjsHNI/ZqS7AA7xQpUrZa4ZWpcW0va5t8bnxAuWn+HoA10q3ThZ3mFmMra9063R9Rqr6WB6opJT+NqoWyWcfItE5eVC7wQ5gpslRyO7JTStFdIIUbNhZFVgCNFv3X9w==;31:K3Wry2uiBi4rXefYQxCLcRyd3W82Iyh09RdByF5BP5IpCdnzKEYpv5IWIv9mRahUbBQNrnVEfKqa2r/gDGZYVTbDub8euuFoBTbXgat2n81zonbS9k/xex/nwH/tbFpD1zrqsp+XWDOUqhxJ4wXesLZt2KuuI0wF5qQLIfnRACY4wGxZGWb1GexVkI6HUMFBkKEh8jTR9IYFiDVs3mLwnd1aTcq4H13Na878Bf4JJwY=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2498:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;20:CW3UNoxfMhEAG0pznFBH0rrsMAD9uGMwx/sSG5SGDTF6ATt8WOgLS7ptVIxTBAZN5yilu00u/tm8cXQG1JNFtdkbXcEfu0cOxqp+cZz+JmodAdr/fFBnSC7rEUchRH9DDZ1aavP9Fo+xCPoKWLeiajAz1ty7zlQ5BxIoR8PEtUmXpsdslfpLq4sUEU3BIebGH17iLYcBmTtLdCYQSsnVqmZB9MbY+YbHIYlKwISVmgs+X6n80oR1F4Ku5hVpX0sjzGHuTWZxt3XUQTOjtexJwb/Jm169ELX19VDevPVK7I9HDEAsL0bRSYDmZbcDaO5bs7repiMZZTvncwMgt016ARIXtRJzVj9fc+fEdSNc2WUgQ3q6S5LuWbGAKcuMV9VMIxJM3+NQfFlVaBbalNC6b5MTCTNNhFIv4AN87AspnL7aKgvAQBRnaATnAY8tOpUf7zhbCvaLCknB4GylusvsD7u50ctacA0Lbmlx0tmPpKcyqGQAlMhNZiEuLnirZYe7;4:GXl8q5Gk4hnX3r+mxOLfooPcTO46IEtwUen3UxUJzrM/meSMSJPnxg1JD3fHqz/kX6DefWgHz6rE6v+64Vn61PPrLtYhwj5IhYB09s08mm2kmtNEUqRuJvmDSxs83UpP4sIM7kvf54N/R+fRYEIZkWjULvJUOFjOQHM+PJLBHydYV4VetLtKsJxAScO/6t/lVQnfQZ8EhgV8xUFlUU/DjW5cLe35rdr3u00I0pK+dQ/cN2degyx7iX5SF0z0ESMZNnDO+Y9U2MAs05ZpVIlOrQ==
X-Microsoft-Antispam-PRVS: <BN7PR15MB24984D86AAA151AF1FCD86F5D7D30@BN7PR15MB2498.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231220)(11241501184)(944501244)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN7PR15MB2498;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2498;
X-Forefront-PRVS: 06098A2863
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(39380400002)(346002)(366004)(189003)(199004)(93886005)(64126003)(230700001)(305945005)(7736002)(59450400001)(67846002)(36756003)(6116002)(46003)(386003)(53546011)(105586002)(47776003)(65956001)(65806001)(16526019)(186003)(54906003)(5660300001)(86362001)(1706002)(229853002)(316002)(39060400002)(25786009)(31696002)(4326008)(106356001)(68736007)(31686004)(65826007)(6246003)(53936002)(50466002)(2906002)(23676004)(52146003)(2486003)(52116002)(6486002)(8936002)(478600001)(8676002)(81166006)(81156014)(76176011)(97736004)(52396003)(6666003)(2950100002)(58126008)(7416002)(110136005)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2498;H:[IPv6:2620:10d:c081:1131::1375];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjE1TUIyNDk4OzIzOlNtU2wrSVR5TFJXbDF5WXA3alcvd0JpY2t5?=
 =?utf-8?B?SmMxcUtaUHdhWXlLLzF1VXNBYVVFQVhsRTNhSGgxR0g2VmxJcjY5U0loSmpS?=
 =?utf-8?B?UkV6U3NEakZQSGhxcFp0bzFGcW1ueXdFc0VxTkFxWEhGbXVTTTZNMXZ4ZlZI?=
 =?utf-8?B?QWF3VDBiZlhucFg3MklyM0RvS3FLN2k0aXRxOXZuZkVheFRDV0E3R1NCMlNp?=
 =?utf-8?B?RzdWUkVUSzh1TmZoRlVhUFczZXBXYk9oK3g3K1RQblYxaVowRTNCVVBIdFZ2?=
 =?utf-8?B?azYzYU5sNDl1U1JLOGw2andvRUU2ZFhXYnRwbFBWMzJDWUNFU25qRWpXeFRE?=
 =?utf-8?B?QkpCd3N4RWhqWTYydU04TDU5bEJLUjlidTRxVDNlQ3pGUFY1T0JveFl0S2tq?=
 =?utf-8?B?SHpxKzhsdEljWVVqaTJTTXhiWWJmd25vU3ozSUdlOVFMdmVFZVFlNWNVYkZx?=
 =?utf-8?B?Zy9KN3Q4KzYxT3h1ZWtYMHlLM0ZrRUFqOFBsUnNlM0lnZ0lQK2JvSDBKbEFS?=
 =?utf-8?B?a1dvb29HRHp4b1JyeUVGRTJ0dzRPSVZ1MXdJVVBQUVlQY1l3NnlrNkFING1V?=
 =?utf-8?B?SlJpYXg2bThaVk9RUStuc0VWMEZaKzdoMXBHRCtUU2FhbmtiQlVFYTRyYTNu?=
 =?utf-8?B?dDc0NndZUGNmdTB2anUzQ3RRYWZCZ213NllBWWdJTURkQjkzUEVIdyszdmZa?=
 =?utf-8?B?dWNsV0MrUUd3QzhucVJhb2R0cWZYTGZ1VG50TlExUjJsNEdoNWFueElSSWcv?=
 =?utf-8?B?anhiL1lWSFRic1BJVHpjTGt5V0Y5NkdKelN3N1ZOMEh2dDkxblRYU3NxS21N?=
 =?utf-8?B?V0U5SUgxVzRxSGZxaHBOSGhwVlR4bndQRmR4SkZJNXNNajRNYWFLZFBNOExo?=
 =?utf-8?B?MklnQmJHdEl2QUhNOGN4WjYvSFJnSUNRYTROOElHTllkMk5FZVRsdUYvV3Fo?=
 =?utf-8?B?NFFVcXNnbStLWGtUTUN6U0NyWHdIUXpCdmNJb1V5dXptNGd6RWFaaTkzWTY3?=
 =?utf-8?B?Mm1sNjJxZHcxMU9vRG9jY1hmMkNQZkFiRHpGRXByay83M2xHYkpxUFMzT3V5?=
 =?utf-8?B?OHZzNDVLOFcvOFJvMDdtSGRxRnJteUIwSGh3UFp6ZEVYVGdGb2JGclpjTi9V?=
 =?utf-8?B?ck5icC8vSGpHbG9DT05tTncwQzU2dGlMeVZvRHdiRGJ5MVlmRS9TbllVVHFI?=
 =?utf-8?B?ZG1GeFI4WlhEQjBma2lDWVRySmFiVmp1Qk40bjR0aDRhWlRvYTlCTzhhaGpr?=
 =?utf-8?B?ckg4OFFETGlJRWVEaVFuNmY0ZEVldFpBYnYwaDY0ZUZXelFBYXhHUllnVk01?=
 =?utf-8?B?Wm1EQWZoUEVXeFN1RUhUM2dtdWd4WDJMS2ZXSy93VGFDN3VoaGVkemJpUjRL?=
 =?utf-8?B?MFlhNm1WaDJXZmdsMCtPSEhjd0dBNGg2OUc4MkpHWGsyb1g4QjNlcDhCeWti?=
 =?utf-8?B?aVNYWEZORUtmKzY0akpMTS92cXkrbHFhL0oyTHFCUVNCWUw3RnYzZmNwSEJl?=
 =?utf-8?B?U0lqdFV0U25uVFVNd2txeEI4T29NTTR4bDdNcmlWV29PVGhNSUd1MVZaT1pl?=
 =?utf-8?B?dmxlOVFqM1d4bi9sZXdBdUtqV1hWeTY2ZWZFUGxmUEEvYXFLZVhwRkVmbHFv?=
 =?utf-8?B?eEJHWkxEUS92RHdCbXFMZDNSUzF2WmpuR28wcG0rWlZ4dmhSNGh6OTF1ZVlp?=
 =?utf-8?B?aGZKdFRkKzRXczFCNjZzY1RQbUhsR3BvbDJES2FuV2VTV2hyN21QZHVaSUdC?=
 =?utf-8?B?R0RpWmo1VTJRajc3MjFQNWU3cUZrbGlIUUcxb2Y4Y0JrY1ZJNEw4SWkwNnBN?=
 =?utf-8?B?eHFpK1dENXpRM2xhVlFFU3JkcnpHZjhEMVF1RDk1RTdIY1pETmxVWVoxZUY3?=
 =?utf-8?B?cHhmM0laYnBrWVVCb0ZGcnBXUDVkM3lmV3VLTzdNMnRHcWxWVS9DUUZlVHB2?=
 =?utf-8?Q?JoLSmu8GszcOTYH3hhm3fCTdVf1hBk=3D?=
X-Microsoft-Antispam-Message-Info: 7X5nGQdPo0HMaRLFdg7f4MdZBfpKKYhMsnqb1KXe6zBcEMqdFiE2cs+Wv08efLwJqoxbTOkybAWvk+UhzuCHd19DT4FwcevXOaz30fw5s1/ctQ+bjtpijQp7CU4SthEKswS5L5qdXjwhv7AcBeNTMU/bmkfIOd7noj2qbwWPJMmUOODOcuHGYhSq45Kv9mSm
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;6:Sc5esmUDzMPgvtQnbgJxeKp5yPnL9c+v6q6Hoj4i9T9zSlEsdqr8CXKvc1vKAB/uBSV8sIRcQI0NLutnkc5uklewrhxlsQNFTt+JPDLHusWRPdE8bNX7oeFor5GQBbC6b42cxix8FSOmam3UFKDmWRrBSCoeRdn5y1a8Pr53+ir4GaLnXktjaDTNneDUuxxxhdUsK8edcNzgX4o9cHz4AwLvFhnrxIr9lzo+JfEoziC/PQGIUv863g6IR7M/WgTwgsMr3oz1Ii30aI8yJ6xtKb86sqXk12+2ix6N8JLYND/jQCkTvaaMeWVtZzLfQyqTBOAz9mEizviCRTluh5ap96Wdkp/qr7ID4qPRg8URHSs=;5:pGwgNtAtwdh3VAtuRQLBqUVGNxd2GUorC6zcrHF50FfLZKFUhH5LcPhGDxE1cC/MWWex6xCSTqptv8z8JFxAESu2WZ+hkn1tdTifctaHa+I0xsSRabgWvl9AHnj8X0jctZkVguKJ8LzOakZ3eKNAit7ap2qR6UIlx2qHizhVNT4=;24:dliPOhakF2vWjJWLahUzWAgwcOCYBsDFXMY5Nn6CyMzO6KueHY91cEccRaLWt1e7CWaWf4m3SytzYJ9n3GkMwS912SZzb3mkscTs9tBsnNM=;7:xpvdHts5z0F5VDPhOt94TT+U9arp4sueog6bi9YLcW0NOURhH9hqrFBjw59V9wtcvYtI6AddNTraYkRw5erV5p801hNmKd3mJFEqaT3G3vU6twhRcbazWRicM7YQO95DQEXJq79DRK6jWuXMspcHQY8KL+QRCuSGyAdh5kCqB7VOovmOSdGexuXYv3ncau38VUaErUpHnOEq2DrfVWWgYDgwkUR3XnB0u16fDILpgUSOeIGFHINh5X+yKADtyYny
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;20:c3CWzojOH31L6W2GeeEG8vIAwItDuRYq8m0c/v/vpdBZW2jhFDpGkoVkR6S7WalKJWvCYD+JmVdgA/QKftRjPnttBqPijODjAXTwFKWKA9lHKtpPcktkvY3SVGtyuatYWiEKuvGPnW5uwwjJExZZbVL3ZYZMqDEDudxubznhYBM=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2018 17:49:07.2739 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a46a5f-a807-4bf8-3c0b-08d588418f02
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2498
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/12/18 5:02 AM, Edward Cree wrote:
> On 09/03/18 18:58, Alexei Starovoitov wrote:
>> It's not waiting for the whole thing, because once bpfilter starts it
>> stays running/sleeping because it's stateful.
> So, this has been bugging me a bit.
> If bpfilter takes a signal and crashes, all that state goes away.
> Does that mean your iptables/netfilter config just got forgotten and next
>  time you run iptables it disappears, so you have to re-apply it all again?
>> It needs normal
>> malloc-ed memory to keep the state of iptable->bpf translation that
>> it will use later during subsequent translation calls.
>> Theoretically it can use bpf maps pinned in kernel memory to keep
>> this state, but then it's non-swappable. It's better to keep bpfilter
>> state in its own user memory.
> Perhaps the state should live in swappable kernel memory (e.g. a tmpfs
>  thing, which bpfilter could access through a mount).  It'd be read-only
>  to userspace, listing the existing rules (in untranslated form), and be
>  updated to reflect the new rule after bpfilter has supplied the updated
>  translation.
> Then bpfilter can cache things if it wants, but the kernel remains the
>  ultimate arbiter of the state and maintains it over a bpfilter crash.

seems like overkill.
I consider crashing bpfilter same severity as kernel bug.
Whatever firewall rules already installed will continue to work,
but new ones won't be able to load and current set cannot be queried.
Control plane crashed, dataplane continues to work.
Still a ton better than whole system crash.
We have plenty of work ahead of us without worrying about restarting
that umh and reloading its state from tmpfs.
Something to consider for later phases of the project.

