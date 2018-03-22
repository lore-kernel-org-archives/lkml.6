Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3841162-1521757353-2-1408117864540362567
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
    t=1521757353; b=QITx1MvsDuu5tYpwGuLqdWingFGZoXqI25TOUad9kmC7wAx
    T4A5bCzEKCCzrdDfW05mbgf8Rz+R9Zr+7BIjbwHXLjAJxQxtz5nNvcUapRnhNr2p
    R+eP4Vv6H1MgvMiCBIfMW+N4Gv8rt5lX4eS3nUqTZjFLQ0YLcX4t3a5aAEo/HPIg
    5adQQxMxw6R7m0h/cuy/wxZhRniTGGiOZCMWLROVnYo2VbyBpeeLvfevS49rGbuH
    DQ8x6Ai2Nubxee0oOPkiIsEagYR8PTOPQZvF4DefywTxFpB+ZP18xMc7acgt7ZmW
    iKbvs7TJBIEFwzVJHbtd7OsezjAuHrF2wMmaqFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521757353; bh=7BBuccmiRE3M+NjMl9cvY14KcCtC+YVb8LMjAUFJJ2w=; b=u
    ec3Z2C0KltbfxRtLEihw7SSj3j8M1s4/1p+yNBNtr6vmYKioiydyec/u7W5MbMbQ
    0O28BNRCty2lkq8qOvm+wVr7UGqm8qqadrQM7Im9ViA0+kCtz1bvAhXpEBDBaGQE
    v0W7QAcRCHsvdsInU0UxFEqr39VzRRAqhbtE+zvtGOPeL2aeWDRgBpo3aEeGBvPn
    Ub68hzm49gn4xWlXumZKRIewrxCr4+0VpWnea5ylkZvV9c5ojd+FgSmJOX7U2RXo
    u7wvMdrdOUQ7xvc4KBm5ainOl2Yt8CrRyi3p2nkfG9RmIqG45GG/WWtxucW4PFpa
    1QG633x8RdTs6qq17a7vg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=OF4d4PHp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Qb7ZoKIo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=OF4d4PHp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Qb7ZoKIo x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751765AbeCVWWR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 18:22:17 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751541AbeCVWWP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 22 Mar 2018 18:22:15 -0400
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
References: <CA+55aFwfcXzD+pzjN=vTcvscpK97pSztUZ2JK7pABs+rMtM7BQ@mail.gmail.com>
 <E459E6CC-F51B-4F2A-9D26-FFB7166E0A47@amacapital.net>
 <CA+55aFx7w1s7=5HzeczPkkksaU4oVsWQf+_c=aHS0O7i_9g+Kg@mail.gmail.com>
 <20180309.135724.452219538059491199.davem@davemloft.net>
 <CA+55aFyN8JDh76bm1VinBvrgMH5jNL6RbuFAkrH8vuYU1s9GDQ@mail.gmail.com>
 <CA+55aFx-kDp87_uv9TW5pYD2+nr8c65=ervvwcxhTBJVg7c_pQ@mail.gmail.com>
 <81b7599d-aab7-6cb6-7843-64510c8f6260@fb.com>
 <20180310140843.GP4449@wotan.suse.de> <20180310151652.GV4449@wotan.suse.de>
 <20180322205413.GA30543@wotan.suse.de>
 <CALCETrWFhTurv0gwxRcdLn4CD-1ySE=v4ZgvbsUYJqruZNMptQ@mail.gmail.com>
CC: Jessica Yu <jeyu@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        David Miller <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hannes Reinecke <hare@suse.com>, <werner@suse.com>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <fbc7ef7a-83fe-67ab-3637-c064edf63cb8@fb.com>
Date: Thu, 22 Mar 2018 15:21:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWFhTurv0gwxRcdLn4CD-1ySE=v4ZgvbsUYJqruZNMptQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:fae1]
X-ClientProxiedBy: CY4PR13CA0028.namprd13.prod.outlook.com
 (2603:10b6:903:99::14) To BN7PR15MB2500.namprd15.prod.outlook.com
 (2603:10b6:406:87::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee7b476f-b211-4c6b-6f02-08d590434930
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN7PR15MB2500;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;3:Gh2V+dypwdHd8rBu1HDLmbVF2FPEj4qXPQkFaHfYFsf8c/irlP+Ui9ujzNrd93WCa1x5MsZGO6lZnRGBSNgZ6b5lrJP+ZUTiHNVPRA9gw+Djj8lEM533Sujnb7WwO2uMDqXVE3Gtq0tWl+2lBRvnz7DnCNM+RvV8c2fArXz5BvOZQLhdF29CaSIKQHfkT94YZjftmg8Hxm749mNGjEzBWGXcyfkKz61QBpPpDtOA+SpYjIALWHIx6GBOZ+OGKJIC;25:QaXdsMutBzd2tf+NEBsdzwwgNnwjlh/DLaXqDfBxNMAtru5ZqZw/xKotgwaSEX4IVeah86R703H4T6NdaH+ljOna+Y5pHcxwthA04zD5Tm8E3bn1oUrOp9LroHmT2xXru/Z6eljoVeb17DR+eTxcP3kbYNMkaNUs9zJQyHvm1Yur+CfiVWSUjQt1xj7AQvF/GP5a3COCZjq5zLITVM1amcM+Q7ZH4oiE2jfoBJj/k4f7vKQx1YmyoWxiGES2Pb1y9ggvDtwBvopMiPuxzIN62DfO3B1iDRgvjEKmaTAtN7PNKbUI/mGYsuJuKpimxCPEWbhPEWvjuMhLAIuaIpzl2A==;31:lziOgaBh0i3i+HeqoO8Cq4REtT3Hnz6iFWwVVfpdxke4FNlBSegKbAmAJ2ta7iGow0eSGOLyds+2CMLJPOSdsrM10n+ob9X2kDZOqBXwY8d7MgaXcvqdH9svK7GgvbZaJj39j3i/gBr1Eqxq5637cLmRt4O/OXOckQp0hzD9I8xvpiRq+jnMvBtx64rwaYrM00RSMQwAkrvbqlRslZ4AyElm7RXGf6R2ukmck2rLNPU=
X-MS-TrafficTypeDiagnostic: BN7PR15MB2500:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;20:gIz14Pvqkt378w7DoCDceNS60oESduETdRh2FhS2P2RFucGrp9SLlXlfgFHdipqjfSygYHXBANwWHzc3UPE+4pN7KSEoO+IwwERq5XYxw9idcyhGou0pec3AqFk2ykhQaVo8pE0tCiGlinlMDMn8j10YuOd03m+yzk/RpTK+r48MRRG1xQPP6f3swAZXB27sy/zraaHmFL2N8RY46YWnM2KTwp1JgrqhF/U3v2XUnTS1kt9ihn9RWZd7GOtGrLaFc4r+Rmr2Mh0nFPxeFQ4ZWUM8e40BxlGmaqPSGqCewXU4TigdhVpXFZY0rRFFil0H74Nh7+XBu9+PXKmNRY7d5Lz77gOpfg2YoHJy3FaG4g2CrxStE13GihCWlbvBR19q+96q0VLmJFQnYe4JQUKXKkDcS3yp/WvBGeSTC1k2BYk3YIqhT2SQgMsunlVIKEoDiiN2bmYL9KGmWntZSg5vCnXJFIhGk9oSsi5wS7kvz+u7zl0Yu93z/R9luJfhpw4e;4:Jg+/+p+oRLdXEeMnCTV2Fqtje802Fea7/LcV3IHYlWHhStOuFrFLzNcyxFqmamsPHPmtv2wXcAkZPHm8W6tR8jgX8YXhYEpUkPlsie/ruiG/1Cw/LpIaAdhjLXcH1Fybm/sqduf2o0EuTyOAiv5byzMvmKwsL/S7I8LlXZ7edsDMjsUuOwAfZzcA3U0OeBJo70vKzG+HhIeahFYIYWhztPl7oqOi6622NYXHCOfZoUrI9I++QASs01tgrWmtEcW6uzsJEN4c70zYErU0arGbbg==
X-Microsoft-Antispam-PRVS: <BN7PR15MB250059DB6A5E229197D8EEE4D7A90@BN7PR15MB2500.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN7PR15MB2500;BCL:0;PCL:0;RULEID:;SRVR:BN7PR15MB2500;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(199004)(189003)(93886005)(316002)(4326008)(31686004)(2906002)(65956001)(65806001)(230700001)(47776003)(446003)(8676002)(105586002)(6666003)(5660300001)(25786009)(8936002)(106356001)(11346002)(229853002)(39060400002)(46003)(53936002)(86362001)(81166006)(53546011)(478600001)(52396003)(1706002)(305945005)(65826007)(7736002)(52146003)(6116002)(31696002)(23676004)(2486003)(36756003)(16526019)(67846002)(68736007)(7416002)(50466002)(81156014)(97736004)(58126008)(110136005)(6246003)(6486002)(76176011)(386003)(64126003)(52116002)(186003)(54906003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR15MB2500;H:[IPv6:2620:10d:c081:1133::112c];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjdQUjE1TUIyNTAwOzIzOlAzdU5MdmNiSkNDbCtVR09HTk1CYTF5YWdp?=
 =?utf-8?B?bXdHV2dPbW1XV0NmZzZnZ1dsdnYyNXdOdFFXUHVtMVFLeURnNzJNZXU2UWsx?=
 =?utf-8?B?Qll2d1ZBcFl3Z3lTaW9iY1JTYmo4QzhXdXJSZllGMk80YUp2NDQ4c2Zjb0Qv?=
 =?utf-8?B?TEc0QlpRWm8vZ29rd3p2NnAwNytScTlQdjF3YUI4QnJ1SHNTQlNZTzEvM3lM?=
 =?utf-8?B?L0FacmJPQWsrZjV3WUVPazBtWVErbk1GV0ttaGE3cXF0U0RHdWN3YXdIREdk?=
 =?utf-8?B?SlZaaFBZOSt6bnYvZytKWTI0MC9vbGtuTG5qRVBueVFSZHJFZkN0emxBeWE2?=
 =?utf-8?B?Wm1XYUh4a2FMSllOMjdKazkvaEhMTGpyclY5TVZYVWVJRVQyazVscTNRRjRQ?=
 =?utf-8?B?YS9UdWxoNXUrRnJGVG1Zb01YQTVhODNCTG15K25ac3dyV0l6SGRQK012TU5o?=
 =?utf-8?B?Yi95YlF3aGs0UkRBOStSUloxc3FscGQ2VW1DRTd3NnBMOUxUa2VUMFF3ZXR5?=
 =?utf-8?B?NFhlZWNObXdGbDc0MjNINVFCTnBJMTN5bm1mejM0N3FUbWpJVjVqekdNWFRk?=
 =?utf-8?B?Uk4zTnpjT0NvYVVKVGpzcWticTdIWDVlR3NIMzJIM1R5elA0cnJqNlNHVVly?=
 =?utf-8?B?NmdlR2lLSDVUS3g1WnpQWVpBVjFReUlTZ0VkNlFsQUFmdi93TXg3bW1mUUdR?=
 =?utf-8?B?dldURmJkRDZobWRuNHRJUVRpdDYwRE1uOC9odWZ1YjdFWklVaE05QkVjQ1cw?=
 =?utf-8?B?QUZZcmtkV1lTZ3hwbFJYcVdNb0owbE5EckF4S0dwN3BDc3Y4YWxSa1k1cHFx?=
 =?utf-8?B?WWZNdnk3VytsZ2psVllEMlRVdmtFd0diQk94TmRlcENCUDhvTmRmUDFreldY?=
 =?utf-8?B?YVd0MFU5N0EveERkTnhjVXBKZ3BoczdpVTBTU2svbitrZzBkUTZHeEZUd056?=
 =?utf-8?B?RXY3YWdQTkxxOFp0dnQ2TTBBWTNvd05uaEcrWCtHRlVSTnh3SEF4RGhybmsv?=
 =?utf-8?B?QWF4YllZWjU1dC9aQlBMNWVOMVhLTHpPR0MzVUpvWVBnNFlmM3VBckp6ZnBK?=
 =?utf-8?B?T01lZDJGZXVDOEJOMDBUUkQ4M3MvWFpWb1N6WFZhMkpvWjl5YzBad0RxWHRS?=
 =?utf-8?B?VlQ5S0J1Tk45bFpkblYvRzJoTmR1WW9VNUtsaHduQjYrYkp0NTJ6d0VRU094?=
 =?utf-8?B?bENtLy9Cc3BpK2w1YlVwejJPd0pzbnFEL09SZ29KcXYzSmViQkR2Um9nQUNx?=
 =?utf-8?B?NlJlUVlLYlZRU1dkQXNKT0JQV3piWGZyYU80VGxPcEZWTnJZMTJmK3c5bUJQ?=
 =?utf-8?B?VCs2ZHJ6UE82WkN0dEF1aFc1dkZWdm90VzllWEdTc2dMWEpzcExoUHZxWU1O?=
 =?utf-8?B?YUxpVHM0Zng4RHRtaVFkNzNaSEN4aG5mc0lvS2FTNmdlS0NocE1lQ2dXM3Nw?=
 =?utf-8?B?OUNLNkFWVk40UGhWT1JROGJaczNrNTFReEFCZFlGL3l1cFc1by9ra3BhekUy?=
 =?utf-8?B?S01hblhvWmZXa01ZUUZTb29nTXNrQmlhMzJ5alhYZUtnb3UwTXczVU9wY3dz?=
 =?utf-8?B?SktTQ0NCem4vb28vNkg0cTVROStFbjBOQ1ZkaVNXOVF3YjM2Y1o5YkxFbmlB?=
 =?utf-8?B?YzUyUXdYZHhndXZhM1pXTys3VVRlSWpnKy9SQytuWGRkVkVweGZ4ZjZzOU8w?=
 =?utf-8?B?NUhsRTRNbjhBR0dYMVJYYlRBeFJmRk1JZkhWdFlNRmppOW1RQmVZZVJrMFgz?=
 =?utf-8?B?L3QxbFdwc01SN0hleGxJQTZUREJ3OHhCY01nR292SWtvTmdYNVFDUVh5N3Bz?=
 =?utf-8?B?VXl4SjI2K05zQWdyNmlZdUpCSVFjOTRWT1ZjdDFqa20xbkExWWxLTTNKOG05?=
 =?utf-8?B?Q00zdFB0N05mem0xeEQwczZ2Yy9rM1JqcmJnd21jQS80T3M1Q3VtNkZ2RXJr?=
 =?utf-8?B?SVBOdHM0dzBRPT0=?=
X-Microsoft-Antispam-Message-Info: M/RgVlWlTqRmhWQL+e3+N0XvPRidc+wGwjfFPrP8D89ijvvTQT5cbXhEDMbI6Wq2b8mslCrQAANAI86wsFZ0KDa6q1DRC1ZIGjcZbJbXhoSAx0oKvwvDjjlWdhfO7Hp24Jk9BV0SnJpUTcc5IIKNI9rLENrf+ad9I0Rjcab0nwXoL9KF36V0E8MhM+CGR93o
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;6:wZakR66My8XlNA55QaMz4Y1s2vOQEzYE6TCSSbA2BKw4MCjqELDpdnzpuPbtQAPOm62B8JfMkttD/atKIIUZBMsvAB47Faf2rMc1M81DzT6YKI7h4Xl1FkTwhcHJV0nL4Luwc01S7RKLYL4g1O62B2ZqJPvOCnbub6KgMcYbDuY5IlHCqivfzuIFuSAuQ8k9+Y6j0KbQSm2i30yBrsuAMl2PX7A65+PJH0XrD9RXIMXUeP2788r7WApK152AEkpvdRos4fNXOe6V+H20/Xwr+LOThnw4H7O4C08v3dd6KUeBWhLfW23C0RiVK7kPrsRKtwU2pP7DQQKOMM47eYRv4We/fyx7Jli3kxU1EIPoWAkUkdOSF5+3SI3Wg1aaq9Ws+g5O9TnNAquBFIXgj6CuoQfr85iay/tq2uPfOvM11hJ860+4xjPUWgSHhJyfOrwO7UqWax9eLJDul7nr5T6PTA==;5:4+iJXLOYyoU9VLToU44nEm3eM4xYzuIl0BbvPqdd9zG5qUB8Pp52pnLgIxfMvf6RheHS02dFnElOYq5PQgjwF12QXOutoNVFYqGfvIhJ2C7LDEYn9AelEDr5iGYkcZt/ehS4sWXkLK8MaOHRuln8mv47RrSdAd7AScmy8jQFLNs=;24:vt0nHo3RBExyA22e15LzcrskF27WnocTgM/W59NFJ1OLoCNZfvo4gOgH7UOA6A9pMgWcCGMF8uOZBGyY7HIBUP/kzn44ItX76dtJ4X8o+I4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR15MB2500;7:ahA7mn04Z79NbaGJwOWsLZZuFixxhsLMp4nrPtisz2vjMij3vvLZYWR9RJz6Bp5RYcK1nXhKN6tdWEVsshz8tlgJ1WeS2oZ9LTrGcOYjNUklHl+ER7JGNXRzlaFZ5CkzMufer7fJVPH1lxoZ4gxKl3p/DBjDUAHZoO5joiz23gTGUFoLO6GwEBYvoByRJYSWrxMFrB9987Ch0O9TBbaBDVXIs8AtjP/b/5VG43SnbUWyg3n97/QSAaDLv/goQ+JC;20:/r/1D6RHuA5Q4L9LF2JaS9AWnJ8f9Xwq9hZ5WT4W6J7RExjz7Fdmbflcb0VSZZJfPiusRo1DTESdXgJ/QEAHce9vEKkDZsSuXd1B3yLLc+iucIvA5otqvLNe/m2e3lFU7lWXDEsoLsyHuQjNd+qvYzQ3TA3GpDN6v/MTpxxa5+I=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 22:21:37.5256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7b476f-b211-4c6b-6f02-08d590434930
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR15MB2500
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-22_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/22/18 3:15 PM, Andy Lutomirski wrote:
> On Thu, Mar 22, 2018 at 8:54 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
>> If we can ensure that these usermode modules don't take *any time at all* on
>> their init *from the start*, it would be wonderful and we'd end up avoiding
>> some really odd corner case issues later.
>>
>
> I don't see why this issue needs to exist at all for the new stuff.
> After all, the new things aren't usermode modules per se.  They're
> regular kernel code (modular or otherwise) that loads a usermode
> helper.  All we need to do is to make sure that, if this is
> distributed as a module, that it's init routine doesn't wait for a
> long time, right?

I've implemented all of the previous suggestions and
now there are zero changes to kernel/module.c
I still need to finish tracpoint stuff first and polish umh code a bit
before sending new version.
Let's hold on this thread until then.

