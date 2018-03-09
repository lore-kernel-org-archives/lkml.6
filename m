Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3755284-1520572150-2-2244211322214315017
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
    t=1520572150; b=uM9CU+MQt9yAfvQQBhmERNOvchp0xr9GayGqTnhhShOw8Am
    yfglljmtDQ5aUYG8M8GAwOBv8fcQGGV/QmWYlORBnTTJgYJxOMfmXlsCyG8IFrdj
    5//yDDCk6yzx+K2QgzpGqK0lQZmcGnT4uAsqKIAcEpSY0uueapf2Gs/xZVVyxgXw
    h7Fr6emKoTLURLKJFa4YW+wI1f4zPDUNXn7D8Fdh83sZdGSBRjkF4N44e/0rUp7B
    6xTzWnQlYIijRO/myhWknn/gIGovR5lUYcU1vx0D8a48w7RQYYVw91b0sTn3EqBE
    0Wluh0lZ2TSQr93fMOfUNKCPKtGLd/tJ/y70Jtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520572150; bh=59n5oXgLsf6yaTA1nLGlkuq1tgTObOb4y4MySIwnFdc=; b=J
    mUMlYFPVKoiceO2/1zDb9Bkm85hqjStQdEmYQ0zfEm0TFOKQDFP035EhBIU2J9jP
    UuV4QcGYYEyjvT+3i5wauxHZxej4ztu1R6vp8QOGusXF+donpGwpw462mwpqCfA8
    9JPMpo6tMy0vVwxrg/DxsfMGwl9nqtVLrnqmkF8grk05CdcbGR1zs59NTrKpBYSX
    /kGFoLt2lexR1TC5stsu2jObpM74ZJ+YjBy9+Mg5e8dUBQUUxyXH9s9gyO+S+Cgj
    40h3GyamjFoeB0SEFsWHvkcETuSiyLX3wyklGyLbTU+UMrDnT/OCnJ4MA0gF1csL
    Mbkc0/5mBZ7LA/6s7rwOg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=hXNfVDRM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=gRSuKdSk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=hXNfVDRM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=gRSuKdSk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751114AbeCIFJH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 00:09:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46034 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751078AbeCIFJE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 9 Mar 2018 00:09:04 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
 <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
 <CAGXu5j+B4wgT3ovynAxa1zwCeROfN5zK45tL1FUnFh0sg8M5AA@mail.gmail.com>
 <CA+55aFwRGDPvaCUgMtqnQHb2PZ77JSMQMQVf1znSN+PiV7NR-Q@mail.gmail.com>
 <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
CC: Kees Cook <keescook@chromium.org>,
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
Message-ID: <87478c51-59a7-f6ac-1fb2-f3ca2dcf658b@fb.com>
Date: Thu, 8 Mar 2018 21:08:17 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <C94A45E9-54A0-446D-86D6-82D06E2A35CD@amacapital.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:180::1:1584]
X-ClientProxiedBy: BN6PR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:404:10b::11) To BN7PR15MB2498.namprd15.prod.outlook.com
 (2603:10b6:406:86::32)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9df67a15-f110-487e-60bf-08d5857bc92e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2498;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;3:R83CccJAGkODGF8w2u3byWOFvJw8spEds6UZRsDc1DoR46pKkaRW71i1AQCU9tEJovKpec+Sb/C1S8UcJagUIWf9/SdzgeGj0XjiAUskws5EWZgBY0BRo3g2EH5KsESs3Wzje/SXtmny1dL0jToJ11rJOWbKME+Vp100r5uiy47hyEzUUeXemZlvDEK3okvoDZGCcYH4BwMj8hqz0LK2m+h2m45U/aC5WymYlhzZU4dRFt+jkhKnK9g7gBGZPwZM;25:+2TelDvF6cBOl8IwF+pIbAla4EjiKiUIbhrWY58aVDK2lrfwoVbDsvlWYrDBgjm8mnD+DZVUhCDnXL5KRgFt1WiHrzSVQpy+xCvNWg2opkrk8FKq7v0uyEwiinqjCXjG4AFsH119koEnIRD4RwulEzXb8ZPu8SB44Ppgct8ugXLvFULB0kLpjgiDm5Ax9hWD1SsLzVy4LvUz/bSiP6PEpre6H5v27KAQL9BoAoUf+ukV/w01psVb376YEmdEaG/HGNw22tn2ACONarPU8Ub0/k3MLMkVYul6yJ0+BqnVqrzyTDVZWMplBdIi9ETReTZPdzqqDHgvgcaMAjDKBHLQEg==;31:+1Gs/VLH2izP/POpdFWzEJZbOkImgrBpMCBiH5HkUuYIfKXoLgCa5V+QhAkhtdTySe8GO2W6Yyn1zfhoSyQ5bnahMB1wUr0JxfXoAA/8Lo6efo40faRVaIHRK168PROv+fmGgwFiEDRkUupMhnaOOA/DG6wknAg2BDt5KEucH0BpAKai2xaAT4lDcARt/xe3lylMv8hpyVSyNZhcr0xZaeQc7aALNme3rQpK/Oqogh0=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2498:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;20:Jy2/J4JgMR4gLtU1Qe1COv598rE3TjmZfzLl0hZMvc7pkvn2DeTzCUEeDBEoaHKFmqKoQ4iy1gGJY7/oR0TgNLqMnORmN2A5anVXK8Kgd09taIzZ/lEI4BweF9/SX7rT/RkW6Yo9ufyFT7OCxPVUAPtiJtPPBbH5kwUbnbyZE0z5N8Qe20Qvh2+WbmDWAksXGJXSi8KSCmDJC+90q8driQ/X62poGIW4odtwIWoKdh+IDSe2BPUTV3bAwkzTpytoJfEAVOkOIizJqJoQ+Qz5SorS+BtNMP4BfFkJGP26ymNabKwwm/GOMPoVJjx1yIU3zrjUcXsGaiB+k2jtQfbLvtMZequIFTF7Ckxa1Dx1YbyTMNQtdVTJa0Xu/4OncqcaiY9xQo5ghysnnGc+IfGmEDflJimv4sS2YwtjvzR01IzNWHosyR9UCkliWlHzqqVHIiPd+IBYjASKMPL8OFzzmNMFCxoIOpVBOSQ4gDQOfe/6Pqr2iDkbXXBIS/AMfjxC;4:uYydBr4wwCxyQ5xQlYaYuRx6gRz+7/1hd7rQ85F1pmXHxMs4t9jpDeTkGIYAW5kzxA/uHymXpwCPKiAbZ3zoqJv/vuKGdOCAwBekrKur1F7ZlPMW1Bp8iTvVlmHxJ1yhdHtQF6apIxapqIKtItCai2hewhfuaiFRpK7kHr9PdNovtXs99YYVIZA7Q4VvcVmF34+o8IqaL8No+2MqvStTlNNZR+rvNbhPXIRNL0OazZAmlDsQ0jjiznJMlqhHAqCgaffBb2/BbkF3dQt9OSArzQ==
X-Microsoft-Antispam-PRVS: <BN7PR15MB2498D5832695F9E49FF27D9ED7DE0@BN7PR15MB2498.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN7PR15MB2498;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2498;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(366004)(376002)(39380400002)(189003)(199004)(36756003)(105586002)(47776003)(2906002)(58126008)(2870700001)(110136005)(31696002)(65826007)(5660300001)(65956001)(65806001)(53936002)(97736004)(93886005)(316002)(106356001)(31686004)(478600001)(67846002)(8676002)(4326008)(6486002)(64126003)(39060400002)(2950100002)(81156014)(54906003)(50466002)(81166006)(52116002)(52396003)(23676004)(52146003)(2486003)(86362001)(229853002)(76176011)(1706002)(6116002)(6666003)(386003)(6246003)(53546011)(25786009)(68736007)(8936002)(7736002)(186003)(16526019)(7416002)(305945005)(46003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2498;H:[IPv6:2620:10d:c081:1131::116e];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjE1TUIyNDk4OzIzOkY3U3pvM00zRjI2by9Wd2JiZU43cmQ2SHBR?=
 =?utf-8?B?QnhBSEQ2Z29LZWZVcDkwMDYvS1pxcGpFbkJoWENEenBlZ3ZvdFlaNG0vWE5h?=
 =?utf-8?B?UjRGUmdtZ3E4Q1dyTXg5SDlkdDVEcmR3M2RleHFqaWJxaE9ZV01PdnB2eXdt?=
 =?utf-8?B?UktjZGRWMERNSU85YmVQSEI3ejgzQ2t2cDZMRWJMMHdyQWxCNDIybjZvNVQv?=
 =?utf-8?B?MGdBNGZ2MVNOdmlaT2hCUkh1SnhWek14WFdBNzlhWTBTbzI3KzZOdFhNVlR3?=
 =?utf-8?B?NTRiVmF1NzdHM2c1NzFhZ3VmRTBQM2hBSkd4U1NoRDIzbXpDalBEbmZNSmFo?=
 =?utf-8?B?dVkxWHhDcVlVbUtoOXdqNkZkL1pLVTBCaTlvdGhQWERBbW1LanBtQ0FwTVVN?=
 =?utf-8?B?TzFpWTRxd0FQN01qQmFMOWRMUjB2YlIwS0oweGhsek1FT2EzMUMvQWRncVkr?=
 =?utf-8?B?RHBYVU1IWTAvNEU5STBhRUowZm5xMlJpRmhSL0RmV1J6VC9sNXlVU1lDYnF1?=
 =?utf-8?B?MVNmaVEzajdaYStSQ08xYW9LYnJiOGhONkVQSllGeVB4ZDdaaXVDeStDVm9r?=
 =?utf-8?B?TEw4bUxKaXlLZCtuQ0sxRXQ3SlhoTVlnSjhWV3hBWGFXSVBmMkZGWEEwZkMy?=
 =?utf-8?B?Q1B5UlJ5WThwc1NWYnBGSWVSK0YzQXc3VnFGWnU1bTQ3SmxLeFpuT1JxZGQ1?=
 =?utf-8?B?VDcrcWRpRGxRQUVhMDZxRzErUGZzVzBjclcrOEV3Y2U2M3lSdFE0ZHViQWxt?=
 =?utf-8?B?a0RDNnhoL21qK1VYbGJiSjNWcVNONXZuVi9KYWxISDRHMG5CNlRwWlBFZ215?=
 =?utf-8?B?VCtlMkV4MWdTZThqdFpQYnZVVlVrYWYwTFhFdjF5UzJkN0pkaFBZd0hiOHVp?=
 =?utf-8?B?SFEwUmJjbzVmaVFWWGNJb3JUZmtqSFlBNmUvRTJ6MXZ3dVdtZ3ZBS3ZwMmlH?=
 =?utf-8?B?L25SSmM4cEpmNHN3b0dITmVKeVhEVWhuQ1dHZ2pFUnRPd3ZrTVJ2VmVhUlA3?=
 =?utf-8?B?TkF6NzhuWlNRYi9KMTJodHJ0RzhtK3Q4NmJ0QXYzYWF3Z2hKVnJ6V2FWUkRY?=
 =?utf-8?B?U25aY1hqeCtKOFBRaXcyZ0prWkNrQ0E0S01uWk5PMWorVDhrYXVLbXFyT1ov?=
 =?utf-8?B?MEJKSU8vb0FreEpETHFsSENnb2dwcEhwNHZKQVRVbzRFdXoycDBzb3BsVXpC?=
 =?utf-8?B?elJ4Q09WVmZPNDBjdXd4bDFySGc0Nk04ZDlRVXRTbGttWUJWN0NkeVJrbXp5?=
 =?utf-8?B?aDVlaEQ0ankwUWtoUVY2WUtNU3FobmhHUE41dmZ4T1BjZmtYUndnYlloWkFl?=
 =?utf-8?B?NWorSVErdWNVcGpMSjdPTHN1OERwU0pua3Z4WGx1T1lLR2Vta21tSnFHOTVG?=
 =?utf-8?B?NFlmcU9rcjkyWkpsa2k5OExrTzE5K0ZXYUUzQjRJRG5Uc3BpMU10TTh2aGd4?=
 =?utf-8?B?UVZTRDVKUVRLQStjY1hnSENvOEJYR3JOMnBoUTQ0RkRNM244MnJLMWpjbW56?=
 =?utf-8?B?QUphTmNSenlNL3UwM01CN21qVXExS0JHWDV6ZGlISy9QOVZ4eGJGK2k1ZmFQ?=
 =?utf-8?B?REY4MGFBamZILzdYemh0LzNBUk9VVUJaczdWSE1ZSzhsNFNiWGdnSjFRdHFD?=
 =?utf-8?B?RUdlVnU1eGV2TU42ZldZOThpeEdXOVBaNWxRMHIwdFIyR1d2c0ZvSGZtNko5?=
 =?utf-8?B?cDBXajNFU0JkQy9JOVlrcGdvcnNiejZmaW9QdXJmenBMenp4NFNPV0IveTJv?=
 =?utf-8?B?NURHVnhLMksrcE82YU9OWHZuc0Ywc0o5L1Z5NG5EL1RuMnNnc24zakQ5M0Qr?=
 =?utf-8?B?akp1Y3B5RTBBNXphMDdlcHVXcm5iR0w4OUcyb2RzcEY3UGtWbEtmaWM3aXlG?=
 =?utf-8?B?MXV4Zk1VY3c1eEVqWnUrem1hcjhSVTNZSWU4aEZFT2pTblBlQTM5RXVyaTBs?=
 =?utf-8?B?TzBDMUdCUFB3PT0=?=
X-Microsoft-Antispam-Message-Info: n5mEMeJB9Bej4B6bEyH2FAVXSsBf+KED7pujzh5zzUKdZPfPiwoOMKzq0H0q4ChLsgF/rRlzJMCtxS9m+aRl/N9eVlNJwrkmPgIBd2heV+WCjwjE83txGpcbkFSNvprGSEJcCs+5WPp1o/kyudiQuBgm8tyvu3Od3iJCYkgejHB22usy4hbP73SrAPI+LVkw
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;6:5e8uMf8eOLe1wgLr8lr6FuNqCqsrBPiDnTJWzshgE1IwORNwvTdq/c0A+5M484tnTMCfKqxqEE6Mm0AgvUexOZp72tG+pUMSLEHrb3e7XI7adL3cexh3ILfo6IQsebyRqkInKVd23AwHVz4KXjZI0mlnOlIFvIB0FoDjSKxGyNyL6tSn0obGxOlDk4KiAq3h2+KCVik1rJu6/U+Knd3MV1HLJRdW2a63LbLQuSk5QApSfRAcWhJiR0jDW4m77BnGIWKyYkBwVSgESKrrCOx6W8Zv6BRsQ6w96Hszd8cAL9PlaIZAhyMTUsVHT+/yUdCJVZ9H3L1EL3T0hNoZFihXmtZbGV+dQLBkE3xgN3pd6AY=;5:2kbSSGrBnhPwxVO11+oJKdQBoGeHBfamBms8inDYUZwCbZlYDnDl3a/Ld99t0s5n01mUTrxWJ60KMePZnLkGnQxHK0tA8WSY0g6JiHg318wX3jhcraNOzkd9k/q050zPgxYeHxCxEHNkA5Mrvb8h1dDhZZzE9W+ua69ZTXRxksE=;24:6CgSyc1Q2MzsPbr+0Noj0yKfVr3DnuanzULT99lxlHPZ/RcRrT5fv5oqF1uhnH+5iE0l00g6NYQvsLqvpKMRvvNVlT6oEdTNp56EQJA99p4=;7:68pyJYMrZujPHo3kQEKSzZ4EkzJAwmDgllJgRpegqvMV7Jq1tJcpQq05Gvyd/IyvfC9FNrZAFS99YhP+mGLsuXZ+hhgKkTjs+1lN8QVsDJgPwqeuvyZAv9JeX7c7zdOrBTIud4l3GUCCfKdZVfi89HUEzzFXEhLhff/89Qr2klbUq+hTEUW3X5+zv+huTTqCDnLW5FTT37yULbnbC2QE/9+2TqFDimNv5YUjGgYuQyMEZvbp5F1IZsMNo/TNp1hV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2498;20:ZugUAK9Fyf4iuoi5iSaYQNSmszsjWOHgqJIFQVS0EZHqCYHmVXwjsXd64moHJQ6RzBv1BFjQNeIzQuU+O/TyJDA4je5VGiDnxeZ7OvctsWSMSBba6wRrJNkOahNwGhur5qqd0A+Z8qf3S2MTOn4nDncuZ7y35KgL5fSXq7QDKW0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 05:08:22.7868 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9df67a15-f110-487e-60bf-08d5857bc92e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2498
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/8/18 7:54 PM, Andy Lutomirski wrote:
>
>
>
>> On Mar 8, 2018, at 7:06 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>
>>
>> Honestly, that "read twice" thing may be what scuttles this.
>> Initially, I thought it was a non-issue, because anybody who controls
>> the module subdirectory enough to rewrite files would be in a position
>> to just execute the file itself directly instead.
>>
>
> On further consideration, I think there’s another showstopper. This patch is a potentially severe ABI break. Right now, loading a module *copies* it into memory and does not hold a reference to the underlying fs. With the patch applied, all kinds of use cases can break in gnarly ways. Initramfs is maybe okay, but initrd may be screwed. If you load an ET_EXEC module from initrd, then umount it, then clear the ramdisk, something will go horribly wrong. Exactly what goes wrong depends on whether userspace notices that umount() failed. Similarly, if you load one of these modules over a network and then lose your connection, you have a problem.

there is not abi breakage and file cannot disappear from running task.
One cannot umount fs while file is still being used.

>
> The “read twice” thing is also bad for another reason: containers. Suppose I have a setup where a container can load a signed module blob. With the read twice code, the container can race and run an entirely different blob outside the container.

Not only "read twice", but "read many".
If .text sections of elf that are not yet in memory can be modified
by malicious user, later they will be brought in with different code.
I think the easiest fix to tighten this "umh modules" to CAP_SYS_ADMIN.

