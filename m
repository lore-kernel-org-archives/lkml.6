Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1986828-1520649315-2-16774698820387287806
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
    t=1520649314; b=lnvpfT+V/DhaGBToPB3E0VUPMTwYeCe+0UvQlLfnlPCerOC
    xlDhrKjLyjKaCiU65Z5XZpt6pSv+PV8ZB5ZocAU4KreWvSKOB50yz7GxiXsN1Q4x
    yj2SPyHAHDI62NOP+o5YEGMoqrO6Dg8Zy97ZIv74T9re+WMhoJGxrVJQJsSsQcnT
    x2F6ZyhBJ4UnL+1tjpWMD12DJY10/TTDi7V4R3JNMFH7Kl7iZGEStql1E3nCVFbc
    V/VEZsBifWiR3k3ZieddImlegQQ77PVZeXN7azAWi0b4wIIlWhEeqnp+mz1E5bD9
    EN5rmYIWqglInCxAQES8f/o0EyKPVyAYqDB+LBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520649314; bh=QmobBmwn19FsRv5yaOHvCxiqZtkOBHX3ifDubcirc2o=; b=q
    ofU27zt4LWSx9T0cP2WUaBPfk/hpixrWODtoteWGWmR9r3TnBuz1A7yBAJTAukLn
    s/6kTS7wvFuB1kVxJuM3O7pFzPp9OEoVKHwzSCLluVerY9qHmtMx13Io3CZVhFuQ
    /EzrqRfOxbJJR5EV7yxp05bCXVwJP2tNoaf/nBRuqbvpy8h4/LjJfOwn3bX5Sste
    YjNu4SIwUhgiSz1vWwnpQCTBFqzp2UHToWiqRmV941lUgyw1mg66pkKCaW2z+s9c
    bGLssTCN4SMieNPueBysVzSI6smlp5Y3qDrFETKcGzqifQE+C6EMPcbrFvt22/5V
    +9Lc2pmYCRkMZx2vAXm5A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=kECjX/8r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=NDNLuNAz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=kECjX/8r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=NDNLuNAz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932772AbeCJCfE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 21:35:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32922 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751613AbeCJCfB (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 21:35:01 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
CC: Andy Lutomirski <luto@amacapital.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
Date: Fri, 9 Mar 2018 18:34:18 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:7688]
X-ClientProxiedBy: DM5PR20CA0023.namprd20.prod.outlook.com
 (2603:10b6:3:93::33) To BYAPR15MB2504.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3fc5968-45a0-4594-136b-08d5862f7039
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2504;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;3:BPDnzAHOPyOlgqpQk3vDV1jDLipVZC+bt3YmO2mc7hgYlqqwGtTJ3+Wo1TTB8eueWtkDismyEdikpORSRe6kou9uv2ahLIiZUAXdHKpSakOB3mXEfw7XrA7ohb5Gw/0yrxi+T86a34MBr8QbOvhg5kNLtWtyiiLyFmYYRYizMTk5a0NOU/16gq63F7VLf7ybp58Bd+m/ue1mHh94dgrl5BIDe+0FwGORQH38yE8y4JwLyPWZNGeYGStUN4ztf8Ra;25:RtDmbgk8gAYy1V/RZJwGypbgR7XLzN4klZiLfoQGXQ28A2RX2EG0Hb5GFH5GcYmwdcYemJwjPaXKS/be6HsAX+cSYymoSrnaRM/uLMj7e+W9uHd5l7maZd+jGER8zgXQ43j8OPuQ7t2p5nWCWr45Z4LjkwQWEi62fdnMNDcegY94kzsoo8/thTd1iSlt1OX9LFQCVQWub5A3NlOi1JXzHldT4a9HgDy8C6v3kXQS8Vri+qv8NZyEEfNC7bs1a5abbR4ynsm6d9zwerav7UY78eKF2Ium6lKnEtSKPYMOd54WG/+TQ7fJbTrwqqePAlWyKMUaJnVy+MBsepsJNlC/YQ==;31:J+76o4vfv5L+wIkxjEbwM7826P0Y+kp5oJQ8x9IWJK3jLb9TD2DrLNwdNjE8OhfvVSRq4Ec4iCRhBKV2W8O8GD7LhCFSwISEIDmCVsb/U8SerENg8vG4982Cg3495d0gQfpi8OrXyk6Ie+CpSf/DqbU7VixWXvsjZeBVeKxRRxYXaUS4csCXgTACiIXhwOUXjIf79R7zMIhCdqF+VkOJh0xhZbpN+BleXyOjjhk63Is=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2504:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:DoZMGPtuiGr/GGsdkUinVjECB0/mbut2g8d9eFdvr81I7x/xM7quUaI+tHiddXTcgMfVDk3gx4PVHufvRju07guAyh+lbYZ6A9Ab+BjTG45LF7UkTJmqI3/fhgZ0lMtMwusKizjDcwWY+kWFWr3d+WaiblYKTiNyZs9a9iaBVxkJHDSbev5fUiR9eMpwVB2vomHJOTLke6ylMj7YSS4o6QxeBp8dAYyrQC1qPekO6m4JKZNFynzgdqpV2AVkmbD2a1KY1UAVsUy9SXw8rELIzJp7K/UQn9uhIw80Po9re/a/7xcABQOmAPPSSzB62b3LoHpqBB7qGKOLWJ/OvcOm8O14vOgaMbdRWfMSHUguhMti0jRNPyndCiizG0oxbcSrb9km0n66EfqUoxJpJODBsHsjhCNJhcGhvaIUvl3V1uSfzARCFsZaRYdApz0ORk5g7EWnhjpEk8Y6QycQe+QPxic1/DCkc5fHIpDPeey9K+8jw7uWpVLnoHrEsYXbZn5k;4:hxuewny3gkgy4DVbJFblOl+2yhyBy4TOXdgQnr3XWVpdDMkZ4p1aU3rbXVX5ou0vIgJ1A7VyJCLHJWx9LFgpeexgpeSQtU2lfJLX1lzjRJ6lyIVSxO7LTw1pojX9SuJTXPBMsAYRGBvbhkR9y9ggz3YNZUt9uyanI77DU0wxR7CgBjDI8wKmZURyZTwDIIR64+z6DO/JBoNHLfkiOaAh8s/ratKwBVg1S6vLaluA0OICGDyv6hnsNY/oy5SoZ8Jm2DCzEumuA7nuvUuUPBHBXg==
X-Microsoft-Antispam-PRVS: <BYAPR15MB2504D74F8342C5E5E2DDFD47D7DD0@BYAPR15MB2504.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BYAPR15MB2504;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2504;
X-Forefront-PRVS: 06070568C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(52314003)(52116002)(8936002)(68736007)(93886005)(316002)(46003)(31686004)(110136005)(6486002)(81166006)(81156014)(58126008)(105586002)(8676002)(54906003)(76176011)(86362001)(106356001)(31696002)(53546011)(52396003)(23676004)(186003)(52146003)(2486003)(16526019)(305945005)(386003)(7736002)(478600001)(67846002)(59450400001)(7416002)(97736004)(6246003)(64126003)(2950100002)(6666003)(2906002)(1706002)(36756003)(65826007)(6116002)(5660300001)(230700001)(53936002)(4326008)(65806001)(47776003)(65956001)(50466002)(25786009)(39060400002)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:[IPv6:2620:10d:c081:1131::12d1];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTA0OzIzOnAvZEJRUGZWek9lWTYrWTQ1T0NYeitlVEpQ?=
 =?utf-8?B?YzNYbDEySGs1MktnbzB4NS9LWkFoVzMvYlY0azMvMGswb2FsS2hjZlNEMHps?=
 =?utf-8?B?YmMxdE05OFpnRmxrVWN0NjlwN2dQNUx6OWt1K0NOZGRNcEpZcDZyck4zQnZ1?=
 =?utf-8?B?WmZSVWVuK1VlbkQ3RGVsWmhUQTFqRHBDOHBxdEVpdkVXeVdZMW1nUXl0NFZT?=
 =?utf-8?B?N282SXROckFRbG1hQUNYYjF2eitZK1FCMXdjek5QNnJoL1llMXhGQlZpcWhj?=
 =?utf-8?B?MW1hZWJVRVFsWlRDQS94Rm5lYUNydThMZlZiSHM2aTFPUW9yQzVFWVNSem5u?=
 =?utf-8?B?VDNJeG9oNENabTNtVyswbG9kT1Rsanl2VVRSa2tDN2w3UDJWZVN6emprdGlQ?=
 =?utf-8?B?RWljYjBtWUZOWVk5bXB1U2ZsaGpsTXpEOUN0R2trNXFzejNMeDBCbFVYemdU?=
 =?utf-8?B?MHg0Zk5STUcrd2lsVEJFSEovdTBTcW81cHRsRHJzYzFtbWJycmU0ZkJ5emRX?=
 =?utf-8?B?bUFGYnc3MjhwS2VSZW9LS0VhLzdoRzQ4a0tzMnFabTAyWFZqdFlpTDBTbW90?=
 =?utf-8?B?cWVxM1ZiY3lYUlNDbnlzalA3eTYyY0tsZW5pZXFHK29FRUNQNmlaMEVxVmgr?=
 =?utf-8?B?aGRVaDZ0TnhPL1kwMDlSZHh2RWJUNERReGhGRE1UUzFSRHFhMjdtVXRlY3kz?=
 =?utf-8?B?VW5jTGg2cGluZDJzT1A0Vjk0UXZwcEk3YWxxM0xmRW5sOG1XQmhDYTlSRmZW?=
 =?utf-8?B?S2hwRURtTGxzSG9GRXZaSHovekk1alFwSU1NbDlKNWZVL0tTb0JaZzlObTlv?=
 =?utf-8?B?bG5DcUptdEZrVERVWWduWjV6Y3ROdGF3ZTMzbUNTWjQ3dnVaWFBRUk51aFVt?=
 =?utf-8?B?MXNGb1FxaFQwRG1qQVdZSEZrQ3JLNTlobVNiVlBxQ3pXdGZhQVRJb0ZuWVlX?=
 =?utf-8?B?ZGVoZkQyektvNmxybTVyS0VMZGd3MlF5THVUYXVJUXpJdG9CV3JydmhFWFdJ?=
 =?utf-8?B?azZiR0RQTHNHd1RrV1RnWWxpTkJXV3Vxc2NweHRMdHNtSzBKbTk1d3dRcDFX?=
 =?utf-8?B?ckNmU2Uvblh4OHJzWjF4Z3NIdFNpTmllaVdESGlGTHZ0UElxTnNON1pKU1A5?=
 =?utf-8?B?SzcvY3k1QklxcFk1TVFqenFDenhVNkJ2eE1pWkZHWmxMT3J0d1h4VjgwcDFS?=
 =?utf-8?B?dS9mcmdvaGFBTEhzMUIxY24vbkFGeDc5d0cySElaOXI1Y1RMMU4wREsvZ2pz?=
 =?utf-8?B?d0JGTXA0Vjk4d1NQVjB2b2lqMnRFMGQ2eGpzMTB5RzdEdUFrTTZ1RzJrK25W?=
 =?utf-8?B?K05BelhqODBnd3IrQmJ6aVhaNldzYXRaTmJueWsyMnZvZU4zV3VQRWNYcklE?=
 =?utf-8?B?VzRvbys0Si9xdHYzNTgyVHdsWlhoQkpQVHVLY1FSeHMxZkxUMWt2MDdJQ09P?=
 =?utf-8?B?T0pTZjI4UUhjVlNFb2FkTzQxVGtrUlBWcTQ3MksvbnA1Umx6N01CZmpYV2k2?=
 =?utf-8?B?a2tuaEcvZHBtK0lzU0h5SFB1QjVrYkY1QU0wZlRCK0hjdWY5OU9WcnNjR00x?=
 =?utf-8?B?b1VxOUZPVWRVUDRldmREUFV3dHFjby8rREFBL2xvSjVJcFk5T3d5Rk9rc1pC?=
 =?utf-8?B?Ti96YWNEWHEzTlFJbmlmOWRvNENoL0FPRDkwYmlCVk5YUGpNNUpKSFBLOW5B?=
 =?utf-8?B?dFVJVnBsdC9mNnZ3eXVFWDRWSjUwREduTHVKK2QxaVc3OVBTbHhSSjNsT29R?=
 =?utf-8?B?ZjBsVDdwUjhMSS9YNlZDMkl4QTRiQmNMVmVkTjFKYmhRTWlPWkM1ZGNyQUY5?=
 =?utf-8?B?TDVNN2ZCV2c4cU9kQVlPM3BMN2hsYVArSWpkQ2xvMUlxaERhZVJ2YkFuVXJK?=
 =?utf-8?B?WiszT3VUUXR3R1MwTXFxYnZ1NXl1UEpYN0NlSTFBQWhKZktxNm8rMVNEMDZn?=
 =?utf-8?B?MFc0aERxSnhIWElLZVY2NjUzMzZnWjlwTzdRUWhxUDdXZ1A2Vi9EUnF3VmUv?=
 =?utf-8?Q?Mwycpo?=
X-Microsoft-Antispam-Message-Info: nuXkTpIAAL8qe1KRIb7MvYPexvyiFx1QhvjXd87tar0qmCpdOAE3gux0Ggnb6KYMOMajtrXgGAdsix2OtK2cuyhyhLKal0YOMGkp9az+xh/xZIKcu91xi2iBGq7z4wXavOh7TyMyJLUEKMnGqrT9frIWu05QTi665ld5cpvf3VvtWH5eq4IFnC5BLL3URGpB
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;6:PfPH26LGVoA1b83WAWJ08EEVXwlM+zED8ajcWVS0aM3JrS5ZI1OXgP8QGxGJhJeS98LdRzXV3LJXRbX+dIq20nwkKs6lPYXjYhCucKx4VIEeKY9cgR7hk8JNX+/846wNOFP+R+K99KIsDeXNZkV7b0hFI7znUEaFn7YsIxQhKSJ0/K+KhvZbaQ19QLQZ9iWPQtjn10CSREHlFrej1Bg1gXe2zc6+7NDWql+6mgIakt0quYkdf3rBvk6ToEm3jaSxHEgvtQpv0zke9sZrqCfmKZiUpIwFeAUy54AioBXn35ONZKc7NcskbIk8iiTDlMK8GqKAwMLgdxTnierevbiJqwrfJ/m+acNN+7JLlezoHwM=;5:hJUmtczRDQRgm9yQjFJMTTfgNi0dnqRIFzRuoyMk3V/YNZOFLzFsrxgapmPhufncB+laj4G2QYyJIrsMWF19nAj/rueZhRTg/ht7JW87RtsCacuMXwx+OO7jXGD+GSesmVCuHONDgKRwwQUrIdvtIK5X1NcoSvOxpxfEbGTNqck=;24:ndsHF0L5yVz0qvjBgpDQZp5ROboyIzMbVs7djTzlApuO2L9GG6hv0XO237XrI3c+ICBRloYUnRJCRapdgRzY9MzqosQpS1/4U+d5YhVFmhI=;7:8yziXjDlKQNQsD+RHoA7sTwWSsWJ3ucaSWOOvl/C1axv/GVeULcpJMmcDBD6NlxFoKYdkRM7gT4P/AdFVKNZUVIntgSyiaQlKgdVhaukQR5PzqrTk/bqeOANzfMbMkEYr2LdZU/UlFQ6oXqftl9dhi1TwhU9vSMP/Hq1DF3Uh6DQdkLpiX2zZV0CmDxoyZjeJ3zbKOvRKOjgjD7XijZDIzCdxJNcuVaU1qv22qAKTqK0LOugtrVe8iOHlyXrqL2T
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2504;20:pt/rz4mFyh+WqJLOxjcGoSUw6eAPw01m+aPkYB5ncoUMOfI2lisJIyFBKaZThJzNA95ajEfWyouROpojv68dKh6q3DZRRopjs8J0IHCwF6LGPURyo+P95SQsDu0ogVi/1DpHwVYANOMEt306iQynixtBCgi3DI2+KeNSAtEWyXs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2018 02:34:22.6229 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fc5968-45a0-4594-136b-08d5862f7039
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 11:38 AM, Linus Torvalds wrote:
> On Fri, Mar 9, 2018 at 11:12 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> How are you going to handle five processes doing the same setup concurrently?
>
> Side note: it's not just serialization. It's also "is it actually up
> and running".
>
> The rule for "request_module()" (for a real module) has been that it
> returns when the module is actually alive and active and have done
> their initcalls.
>
> The UMH_WAIT_EXEC behavior (ignore the serialization - you could do
> that in the caller) behavior doesn't actually have any semantics AT
> ALL. It only means that you get the error returns from execve()
> itself, so you know that the executable file actually existed and
> parsed right enough to get started.
>
> But you don't actually have any reason to believe that it has *done*
> anything, and started processing any requests. There's no reason
> what-so-ever to believe that it has registered itself for any
> asynchronous requests or anything like that.
>
> So in the real module case, you can do
>
>     request_module("modulename");
>
> and just start using whatever resource you just requested. So the
> netfilter code literally does
>
>                 request_module("nft-chain-%u-%.*s", family,
>                                nla_len(nla), (const char *)nla_data(nla));
>                 nfnl_lock(NFNL_SUBSYS_NFTABLES);
>                 type = __nf_tables_chain_type_lookup(nla, family);
>                 if (type != NULL)
>                         return ERR_PTR(-EAGAIN);
>
> and doesn't even care about error handling for request_module()
> itself, because it knows that either the module got loaded and is
> ready, or something failed. And it needs to look that chain type up
> anyway, so the failure is indicated by _that_.
>
> With a UMH_WAIT_EXEC? No. You have *nothing*. You know the thing
> started, but it might have SIGSEGV'd immediately, and you have
> absolutely no way of knowing, and absolutely no way of even figuring
> it out. You can wait - forever - for something to bind to whatever
> dynamic resource you're expecting. You'll just fundamentally never
> know.
>
> You can try again, of course. Add a timeout, and try again in five
> seconds or something. Maybe it will work then. Maybe it won't. You
> won't have any way to know the _second_ time around either. Or the
> third. Or...
>
> See why I say it has to be synchronous?
>
> If it's synchronous, you can actually do things like
>
>  (a) maybe you only need a one-time thing, and don't have any state
> ("load fixed tables, be done") and that's it. If the process returns
> with no error code, you're all done, and you know it's fine.

I agree that sync approach nicely fits this use case, but waiting
for umh brings the whole set of suspend/resume issues that
Luis explained earlier and if I understood his points that stuff
is still not quite working right and he's planning a set of fixes.
I really don't want the unknown timeline of fixes for 'waiting umh'
to become a blocker for the bpfilter project ...

>  (b) maybe the process wants to start a listener daemon or something
> like the traditional inetd model. It can open the socket, it can start
> listening on it, and it can fork off a child and check it's status. It
> can then do exit(0) if everything is fine, and now request_module()
> returns.

... while for bpfilter use case we need a daemon and starting umh
with UMH_WAIT_PROC which does fork() right away and parent does exit(0)
is not any different from kernel pov than UMH_WAIT_EXEC.
The kernel will be in the same situation described above. The forked
process could have sigsegv quickly (right after telling parent that
everything is ok) and kernel is waiting forever.

That situation is what I was alluding to regarding that kernel<->umh
need to have some sort of health check protocol.
Regardless of how umh is invoked.

I think what Andy proposing with kernel creating a pipe and giving
it to umh can be used as this health check and means of
'load exclusion' to make sure that only one requested umh is running.

Also I like Luis suggestion to use some other name than request_module()
Something like:
request_umh_module_sync("foo");
request_umh_module_nowait("foo");

in both cases the kernel would create a pipe, call umh either
with UMH_WAIT_PROC or UMH_WAIT_EXEC and make sure that umh
responds to first hello message.
On success they would return a handle to that pipe and umh's pid.
The further interaction between the kernel and umh will be
via that pipe. If kernel->umh request times out the kernel
side of bpfilter would sigkill the task and do request_umh() again.
If that request_umh() fails there will be no retry, since
at this point it's clear that given umh is broken.

I'll implement only _nowait() version, since that's what we need
for bpfilter and when suspend/resume issues are solved somebody
who cares about usb driver in user mode can implement the _sync()
variant.

All that on top of tmpfs->file->execve_file hack that I still
need feedback on.

