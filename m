Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-782846-1520610058-2-11818174752394261803
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
    t=1520610057; b=wAJUN+pqs3xDPQ5Ylzco+7QdfYeRdipUdvxnRII+rVySDeT
    UHLXIOOHQLKQunaEbgJhhHDaFniOeY9aaQdPnyhIUrt549C2JhE8isExMvc8g5qP
    XQ0cjpQbCdW9eqzl/hB4tIIZH2Mjcw2UBoctfJYR5e2g6K02wOBsab/CGssrNRjL
    QZIToQgYwIwisR9ACrTQTeBZcMrUs/kyLSJEclRwedWg9dkWvYDYlrFqkQieBNxP
    Jxgk0Onwe2X/yec6S9BeznAr6d8PhGddllwa7ChdwFH7SNT5tI2BuK+nqrYL+wAr
    L3G33Fpty4OdRr11KhMBcXxNrjIe2LuODiHfRfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520610057; bh=d9/Jr/tW84Tsu1tc8KKzanw1gbEyW17WJ3x12/QqeUc=; b=o
    01asdBGZr7i+3CwYt0+CGQV1VLS5e0kXt0NDUgc/bE3t0kXJd1fhXoCD9I1sIe7f
    OFc1Io2DsSt61y7SLBYYZxRqZWgDJ/xlckzm76BBiAqeSHVjPdpKHw5COnXm9oBF
    /l/rHkSa75/On/WfPPxtg2k0VKzuc7MycWm5S9uA/19kxMz2Zm6FrFqlrj5OSN1L
    n8kqlrSaNGEke9/I/OVh7T7apQXjpPxgOx7WUk4FFoc9Z+YN6wYWj3O1NF/mhGlP
    df6yTsA8UdlLSFMdLWIpUrPfsss4cjtzbWt9yHgFCiDX8pRAwKU4uA/WK1nXhFSb
    YVHSgXGesmXJ/PG5RjhhQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=ZI4wMCWc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KWFmhCEX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=ZI4wMCWc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KWFmhCEX x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932189AbeCIPki (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 10:40:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751333AbeCIPk3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 10:40:29 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
 <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
 <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
CC: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <6d2e31fa-d87b-fea6-c919-b7d066bb0385@fb.com>
Date: Fri, 9 Mar 2018 07:39:30 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWKLB4e8Cw6ZRiDP535=HzoQJczsEMEpytstveO15mAMg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:200::7:649b]
X-ClientProxiedBy: SN4PR0601CA0009.namprd06.prod.outlook.com
 (2603:10b6:803:2f::19) To BYAPR15MB2503.namprd15.prod.outlook.com
 (2603:10b6:a02:8e::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29abea4d-37f1-481e-760a-08d585d3f85b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2503;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;3:maMbFHX3RsTwqP4XFsGLORleFWVLU+Vm2YZ5Urd+S4pzF37H5mNDVtb5ms4ZFuyTWYIg/zysxTxI+Llaq+jYzlwfsDwc6hpKn5u9AHT1jLbDcXwjkqc+WIrMdoIedGwLgwtOnmkdS4PVfXwvG8PyFYnIjMlf4jbHK5G++fM+Odx8Hor1xKXhA6nGLP2JznWBynleubHapYAVxiTtCKFqiL5uSwYvaUBTqfLzM5k13+nEZjXVHV4UApt+fofkYlwx;25:3FbRIJJvVGLRfPqDYBtjQfjmqMHm70CLqaDS5IErLRckp9JvR1k5BJWvfteLoQIZllfsZK2KFVBb7nRSBag6Bm3YAjXJIuBfAtPqlHpYLzwbWMik2RmqTG4QoOS1uxKUaicB7U3KABnIdv8Yfajw96GNPZbmKqoR+9Smg0yEoH6Zddbk6BJHlaFkYhfSgoEONvnb5la+yIfILNnr2GasCbSk9+Toxs7oheUoGl1nseS1AH6YomFV6XTmVOjywBoHtjcB2e6ra05Vdh2cVh+g7jxiOndTRRAGv+Wgq2XVLOfaW0NSlAq2MhMxeWxFKat+h1+hOpDlThp34jkPosN2oQ==;31:A6f22gYbKwYTuUPzxouOgTaqdxeigyUUjs0V0n78v4rhwgGs1GSDQm3d0lAgnGQbHVOk7jsrcrBsCTUkjbOuEOx23I40wGnDIcnaHtzP240jQBB+tjZ3SmexCLbeH0p7UA1FD4BEzfg6rUgdR5ZehIjGbwWJNy6iLkkiEtvWHa+9PeUR9U8x5N8vkHWvs8zXP9PycuY3GzhejPrcvQYNuLN7EqPpAQF4UfqmKk4vPNk=
X-MS-TrafficTypeDiagnostic: BYAPR15MB2503:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:0oqvKfPBWhtNTzm7rzf++yv6470kGDap8rdaAkJqKUceO0mWDhIBtqc7oEB8owBHGMMD2f3boq1fkhRYUpCnass4R0OT0ola73RBRLhtY+MlUIp8S87IiS07RmUYrEsuhzwda8HomWzEM7SlJ/y1Y1pOyqanstQApLLNoMlNKeivKhxStBhKnP4LJ20XNTaI74LI0yNz6ikJhnYbxGOskwuFBVzOErM9BS+U2sakthqI0Qr9gBzjWe4uKAnDL8l9LfzYk0/zSMkn9qsUlgJ8zcvKD2Sz3YvE2p+nWDrUQ5YJCFvKdzIND8I2Fetc3K7DUy5v1/IjtqQLbmI/OTb7pH0cAuM0UzCZHZmEo9w26qRH0/AVNgmgnczE4RyopbxmpC1sZ0hRnMiSZQ12AT8Z5U1/IHoAd9kNhHCQ7AEOrn6TdPdOzYJzh27D4HNsnXbU83ORebjnKk63r/cLpVPDtFf5Y64H6ulj7WkG9+esZtmyoShXx9h2I4IhiQc99BmC;4:01x4UQN8UNX/Q3N5RipDqqRArZDflIckBRqFOAH4xU1dtnWCg3xdz9+7HUIgoYVpBRukBjBdW0MVzkId7wUa/MoBzgNBXSJjFHSGEoatQIAEzjitq4HJ1U/7rSEtBiR+IUOEqYDjfZ0fQQiq1yJV7R+RC4xUEJSRmtSLIQNisDgqLKOIgsRGdIXIMOUPnIOD7coovJpBHRdGBfO+JY5HAqTcCgvYR1aM5R98u64M0KwCZQKtCfWgHjRLJkzUAQqKreC9Crpxr9dxW//6C+xudAFD612drS16CVuUpC/SEBzV9fXlgoPRY6UhPG+9O97GFz4sBa0BPel0ySyhUojoAu+3oy98BBftNBMrc3xbrBw=
X-Microsoft-Antispam-PRVS: <BYAPR15MB2503D3D8E1201BD51D13A35AD7DE0@BYAPR15MB2503.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:BYAPR15MB2503;BCL:0;PCL:0;RULEID:;SRVR:BYAPR15MB2503;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(376002)(39860400002)(346002)(396003)(199004)(189003)(23676004)(52146003)(2486003)(52396003)(52116002)(86362001)(81156014)(54906003)(39060400002)(2950100002)(81166006)(6916009)(50466002)(229853002)(31686004)(76176011)(6486002)(64126003)(478600001)(4326008)(8676002)(67846002)(8936002)(68736007)(7736002)(6246003)(386003)(53546011)(25786009)(46003)(305945005)(7416002)(16526019)(186003)(6116002)(1706002)(59450400001)(6666003)(65826007)(31696002)(2870700001)(5660300001)(65956001)(105586002)(36756003)(58126008)(2906002)(47776003)(93886005)(316002)(106356001)(65806001)(53936002)(97736004)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2503;H:[IPv6:2620:10d:c082:1055:e43f:a97f:ff02:4c5a];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWUFQUjE1TUIyNTAzOzIzOnFXTHNWbjRUMXNQdjF4Z2FURWoxcnYrSFlO?=
 =?utf-8?B?YUFabDlBVDJqSXB3eUtRRlZGdGNCcGlhVmZJdkExcGZBYVlpNEt4SFVhNlJS?=
 =?utf-8?B?U1N4WkJPSnVlS1p2dHEyS0I0WCs5VzZTOXU1eE8yb3FsejI1Nk0rSnRhcGN3?=
 =?utf-8?B?WUZweElSNU4zSlZ0OEFkeFZsUFcvQlFnZ0lFcDJ4L0V3b3ZlNWtoSFI2OFd3?=
 =?utf-8?B?S2NHS0dJK1dJbHQ1bVZYVXdzZnEzcURCeFpuWUJhd3IvWHEzdmdEVFNHMEE3?=
 =?utf-8?B?N284ZFdsSldsQkRMNGVxOUFmRFJtR1FGOU9aSnVkaFhMeHpTWWxKanFZZE9a?=
 =?utf-8?B?c3pmeE43andxNDlXT01CcEpnQjRWUmNPR1FEU2JxTTBaZ3d6ZGdtUUxMMjh5?=
 =?utf-8?B?L1lOT2d1ZGM4QWJtemEzZXZVaVpMRHdLbkhEeWhNTzV1T2QzcU5vMW1EL0tv?=
 =?utf-8?B?SU9zeCtxWSsyUElvelRoUnBIV0UrZm5NcGFsc0RDcG51OXp5R0xUQk5wM1RC?=
 =?utf-8?B?NG44RjV4RXFMOTA2dng2WTIwRVVlU3RoY0txQjNJVStJbXJaaUc0WGt1VFpx?=
 =?utf-8?B?T0tCMWkrSSt6RjBDTEJacVZRSVcxb0dnTUlWU09KT25TL2xYdUh4YUhjeGRO?=
 =?utf-8?B?cDhOK0J6Q2Q1VlMwdDZhaTV3NU11S053QzB3V3lSMUxPU2RCMHQ4M0ViZXVy?=
 =?utf-8?B?UnBMb1dqZjdxK1FLNFIzWDAxcGx2enlaMklXOU81R3VYTlRTeE9DZmZsSWU3?=
 =?utf-8?B?dTlpdTdkZkowc25QZ2RPdEt2bnI5amU1R2ljVkMwOCsrcy91ekJ5R3hNbnp0?=
 =?utf-8?B?TlJldTN2amxXQzhLL2YyY1VhNWR4UmROZXhxZyt6N2k0S3lIc2NOSVJSU2Ir?=
 =?utf-8?B?VEt6RStvUTkzRS8wTU9sV1ByTHZURk14d0x4MUplTDlYaUxSdmtPMDR5aHp1?=
 =?utf-8?B?VVVnajlOSERjbWY3VkdMenJDSVhqbnNOZC9rZkdvZlhrRjVuS01nZnVjU3hH?=
 =?utf-8?B?NkVwdUVtdFU3OEpoZU1ab0hUZVUxcDNkWlQ0L3JkNzdlY0dHZHBmR2xNUUFm?=
 =?utf-8?B?L000V0RBTitrUUpwdkZCSzRvWXVPMXg4MEpNR1lKNHdoRWlzWU1BdStySlA2?=
 =?utf-8?B?SVNJVTlnNkFqM20yUGV4THVPdTluSDI0L25mekZYVWg2NEE2WkxFTVBLL05Q?=
 =?utf-8?B?NzNzd1ZUWWVlQUNDK2wxTEVWbVRuNkF1WU5TMStlS1paU09xeFp1bm0yWFd4?=
 =?utf-8?B?WnpzREcyTnB4OHVSZXpjWW1wVTNkZWN6QjFwZXRTMnliRHdqUzFLT25DSXF1?=
 =?utf-8?B?MDNGK3RncXZLWXN0enNoN0dSajhLZ2hIK3dtcnZTUER4eVRCUUdLWVZzZnM1?=
 =?utf-8?B?YzFyOUNRVlJKQmltNmcxek5BWThTNEYvOGwzVERZQURGNlNjOFM4RFV4R3d2?=
 =?utf-8?B?aWhkNzZpRmFkT2tjUDlEU0FjaG1TOENHVVc4RWMyb1docHFVSC8wazdwcmti?=
 =?utf-8?B?RWhnalFoZVNxZkc5SXUxRnJlWVhVVnZBTXU2UGRTN25TeFZHUXd1eXNkelp3?=
 =?utf-8?B?aDhVaFJxc3BFWWJTNmdrS1FxQUd3TS9qVlhHT1dXOUVJQ2JsMEJlTjdvV1Ni?=
 =?utf-8?B?Wko2ZkEwWFV4eE9ITGpmcStMN2FrTmhEZW8yb3l2dUdOTUlKLzcxdE0wWkRo?=
 =?utf-8?B?SlVIVlkvWjlYejE5Z1FPKzQ4VDUxY1dDdXR4VERhVGZjRnlEbkRRLzBjZEtq?=
 =?utf-8?B?TVE2N2hETDdPbUZ6aGFVQld0NnRuK3ZrbGk5Q2YrVHNyelpMdyszZDd2N2Fy?=
 =?utf-8?B?TVQ0eW0vY3RPb2RydnV3aWJtTmJGRVEwaTBFTVdqMFpxL3BYRTRObDlveDhL?=
 =?utf-8?B?Yy9JLzh3RzFLWThuWTVWRkVOWVhBSEJobUhBS1ArUEQ2V2VYQUlNbGF1dWVo?=
 =?utf-8?Q?1F+xV1qmGwb82fzRBZLHhu2UmTFwz8=3D?=
X-Microsoft-Antispam-Message-Info: 917pxNQ3RfRD5SYIAZcxFIOfWUiPbt79j37428NoPT+zGO+hz8XoAXPYTN2KT0bYNNZ8fGS+LyCHm3HFMvThtP1kTT278GLP4a44S/G1/eitKyX+UPtJjdHO8SBgGTF7cZhpx34Ol3Bbc1vW1L0GYsUjvj7PaZIIv/OeOOgUouVNvnK+CtyAKP7APhLYeNth
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;6:XbnM9tj+IHvMiJXbEyIAkq4kLrn8OmpxZ8C3z9jOKdjtGNNUzSebKAsmZFg4WsTJ/viXQAmr5lam62GRSGJ3wy7qtxaeSyirhPZ69NvmXqD2jU7gNZxLGpByDonU88Xd7mnUEi3zgHCGpcMSukb4Qsfr3o6lxpB0CjKAuEmnLs9SFzXCbTmJPJqKKXVz6MTc+qEnJYQplVYqt/UR9bILOKoJ67gmeFsQ9m3ihUFO0vvbOVWYW/rKDg5DIMYd00y+Wm/s0KX2NEICiMVVUryiZuovTA4pLVuYxXx0wrTbu9tf8UTKt1Oa/eO/eGu8XHce2I2qOcysxr3McpvUe+DJIfqzutVTKMyO2IrvSXrm1Fs=;5:KaYK2eqv4dJTp2Nms5TXacF10K70hpbLqdVSJkPtkiMWoTh35v+eKfvxeHPQf0qMkqNRHKRoCUyTpin8k8PUHW9tncsv9596m5Zd0LnfU70ig3AlojVoODvgb8nEsymriH/CuMeaHxa1Fx5dKj441rAbmkkEFjkL5TiqMVLFXNE=;24:Q+w07WjYQlFXrN3FsfbIJlKJc9S9dJLmO34bbzbgeH0oiZqw8DP28HICRAeaaVphaQEa5stfzowCKt8ty/CZUh+IXXJnpvLFhbQ0aQ8yToU=;7:f2iEb7EsMIo+SM49C0R2joA8LcYkrFjKtqfYxQjDANljdr48KlZ3jJfOhJTcB3QlNLOt6MWd6/cOvPcEDtjjHX0Q0ybgvBlaoeyMhDysrrRkc8AHoQADM73JqVbhM4W4w77GlkgUN44p99I68trj8PySnjMwa+pcR5V49fzMEBRZ6GNyz35WGB/LcAr+9xpbU+iYQ3a7nV5GSubjpcIra8xM0IZYioKAcJig6Qq+vmOqNlkThHGTOuBuYo6OtZZy
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR15MB2503;20:hesOqiUdceTFy6L5DbV54ADZowNCa1v8wLcikV/hOkbLF3zFRGw5ptRqGM4fhWlhUDSun5zwamXZGP1cxQurx39YqO9zTR3sX0PzHkljM+aYuiRvqo4ZcPNWvnBGSASinkO28JWa93Dcwvf558EGcTp0aKUpY5vm4hFao7xYWdw=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 15:39:37.1786 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29abea4d-37f1-481e-760a-08d585d3f85b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2503
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 7:16 AM, Andy Lutomirski wrote:
>>> On Mar 8, 2018, at 9:08 PM, Alexei Starovoitov <ast@fb.com> wrote:
>>>
>>> On 3/8/18 7:54 PM, Andy Lutomirski wrote:
>>>
>>>
>>>
>>>> On Mar 8, 2018, at 7:06 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>>
>>>>
>>>> Honestly, that "read twice" thing may be what scuttles this.
>>>> Initially, I thought it was a non-issue, because anybody who controls
>>>> the module subdirectory enough to rewrite files would be in a position
>>>> to just execute the file itself directly instead.
>>>
>>> On further consideration, I think there’s another showstopper. This patch is a potentially severe ABI break. Right now, loading a module *copies* it into memory and does not hold a reference to the underlying fs. With the patch applied, all kinds of use cases can break in gnarly ways. Initramfs is maybe okay, but initrd may be screwed. If you load an ET_EXEC module from initrd, then umount it, then clear the ramdisk, something will go horribly wrong. Exactly what goes wrong depends on whether userspace notices that umount() failed. Similarly, if you load one of these modules over a network and then lose your connection, you have a problem.
>>
>> there is not abi breakage and file cannot disappear from running task.
>> One cannot umount fs while file is still being used.
>
> Sure it is. Without your patch, init_module doesn’t keep using the
> file, so it’s common practice to load a module and then delete or
> unmount it. With your patch, the unmount case breaks. This is likely
> to break existing userspace, so, in Linux speak it’s an ABI break.

please read the patch again.
file is only used in case of umh modules.
There is zero difference in default case.

>>
>>>
>>> The “read twice” thing is also bad for another reason: containers. Suppose I have a setup where a container can load a signed module blob. With the read twice code, the container can race and run an entirely different blob outside the container.
>>
>> Not only "read twice", but "read many".
>> If .text sections of elf that are not yet in memory can be modified
>> by malicious user, later they will be brought in with different code.
>> I think the easiest fix to tighten this "umh modules" to CAP_SYS_ADMIN.
>
> Given this issue, I think the patch would need Kees’s explicit ack. I
> had initially thought your patch had minimal security impact, but I
> was wrong Module security is very complicated and needs to satisfy a
> bunch of requirements. There is a lot of code in the kernel that
> assumes that it’s sufficient to verify a module once at load time,
> your patch changes that, and this has all kinds of nasty interactions
> with autoloading.

not true. you misread the patch and making incorrect conclusions.

> Kees is very reasonable, and he’ll change his mind
> and ack a patch that he’s nacked when presented with a valid technical
> argument.
>
> But I think my ABI break observation is also a major problem, and
> Linus is going to be pissed if this thing lands in his tree and breaks
> systems due to an issue that was raised during review. So I think you
> need to either rework the patch or do a serious survey of how all the

I think you need to stop overreacting on non-issue.

> distros deal with modules (dracut, initramfs-tools, all the older
> stuff, and probably more) and make sure they can all handle your
> patch.  I'd also be concerned about anyone who puts /lib/modules on
> less reliable storage than they use for the rest of their system.  (I
> know it's quite common to have /boot be the only non-RAID partition on
> a system, but modules don't generally live in /boot.)
>
> Also, I think you really ought to explain how your approach will work
> with MODULES=n or convince Linus that it’s okay to start adding core
> networking features that don’t work with MODULES=n and can't be built
> into the main kernel image.

that ship sailed long ago.
config BPF_JIT
         bool "enable BPF Just In Time compiler"
         depends on HAVE_CBPF_JIT || HAVE_EBPF_JIT
         depends on MODULES


