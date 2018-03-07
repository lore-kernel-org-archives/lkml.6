Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816594-1520384918-2-5185849623588500819
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='windows-1252'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520384918; b=asjLnM/80uhtTYASdt2p32WbMrw4qiNRdvA0kLT9FK/eAR0
    OKx6Aiq7zBkzZZ0OpKCpM9b8K73B1oXgFdVxEzhXoAUuehEsj/Go0MCftEqcS7O6
    SHJKxr6dNhUXu52se7iuC0Z4bzvMNWdH1v83QBEqVnw6ZTeYy1I+q1TeDa3vM93G
    mtjLeA9M+12zv+PH9J8hVqdkLF2F37XNEFFrRM2VLBUmSj9knZLlnb0+OQKWvN5x
    haQBW3sOHGEuV/46UCA3KDt0b9teknk7G+Msi1yOcuY1vSxry+69uZz9QlBb70mL
    lPyOi2KG4uEj6bs4325aGW7nSEpFS/3/fKpwTVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520384918; bh=M9ZWZSPFMZfRmKdtbbvbiFbC+WbIsakATwamiiJz+B8=; b=l
    NdCbTv9H450576J2Ij8G6nboW9uuk67rTaEogzeDK8sMEaXhM+IWoOh//XDtT0IB
    kcIJKuc2tU2Bfd8K7mU8V2ZPYAY7W9lGNiXl8oji43V/WDpxrPEu59wOANccXhd5
    SL2kXlJMhK+4ax9Crf3NDFLgisB7AcUzblZqlburEx4NdRnS7c9EB2tzjS/8+47H
    ZotDwL3j//f7FkTJciiyQ6jP37BESK8yUwZsxghHRauSK1Aak3fSaHXQ71B8QNqN
    A1fB/YLPcYSRnkhoszh1DSRHTdnNGVOckgVdVTIuprJoucc5/emqvh18U3Efkcb1
    Aif9ZvKY9XSyguhZW6JzA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Tdp9x96D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=EUSWzBgJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Tdp9x96D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=EUSWzBgJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933297AbeCGBI1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 20:08:27 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44682 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932804AbeCGBIY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 20:08:24 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Greg KH <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>
References: <20180306013457.1955486-1-ast@kernel.org>
 <20180306110549.GB31087@kroah.com>
CC: <davem@davemloft.net>, <daniel@iogearbox.net>,
        <torvalds@linux-foundation.org>, <mcgrof@kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <d4fa4529-8341-8069-b80e-78773b0bb366@fb.com>
Date: Tue, 6 Mar 2018 17:07:45 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180306110549.GB31087@kroah.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:168e]
X-ClientProxiedBy: DM5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:3:93::11) To SN6PR15MB2510.namprd15.prod.outlook.com
 (2603:10b6:805:25::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4fdfbff4-6a7f-4f8a-1aef-08d583c7d8f7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR15MB2510;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;3:4/KVwdMJdOxgrSQJfeSL4NaC7XPon91zpqc51jA55Tem+eHgvw48SlPpgOZ+5De7syaB1ViB9QX6MfhO58mnCZ0+BtEdEYI7Sv1DArgfP0/+sRuwWE3fgahzWGNJoiZepFm4BKQlo9TVWdSi0R5uYX1ibCNtCnmmMp6wXBNZWJNLZoBw104ofMQuEiqksI/DooxHEXGiry24Kvf4Wvl5CwxWj/DT1VEII7fXB5i7Rx2rJMsaRI3tInxsriy1SXVx;25:Ui1Ycjiuzu8nPwDVmMQI9ryTZLocCSWxvZcXSQhCzjt8fXXKHbb2FK3jjHPI05j3uT5oCpFGSl4xFkVUuKin8zXUgX31CNX2L8aUhFTq7RVa0pmpMKRiPDM+270+8ts6DYJ0ueqCooWg2ot8DkiBJ6wyh9bYKeRDxuNRmWRL2WADWg8mFlAgor9GHveJfiePInaSX5jaqAYv68z/fCycS6iEhE9umxeVJliMSfU2u3uKzyEgicJddNYvrPfT9EobVSpYZcQVjeQJ4+rkXurn45Z6pwFDWxkT6r9kKqnCLhM/3Bz5tGqflBhlSsrCzc/Yzf7+LTp2beDuLT3qo+Bj5A==;31:tNv9MDuX8jtbSA13eBd7YQEZocWe9sJTxh2wiXk7vhsFLPLXcNSEfnPQepGPfOYW1QmLdvx8k0svR12DVL0DaHYZvF1aNC7yxsdWo7bVP1gz9vjdxTVXigTy8ba5YkENVfwdQUFsNsmxpM9L1K0C0EAltddaZOOSfpHwFPqrd2W1EX2eR0I2q3bdDWfLRaYHMhH9m0U3URTTUbrXmce1KDdEJLvyrzAWw0RhjDlDpus=
X-MS-TrafficTypeDiagnostic: SN6PR15MB2510:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;20:DOddLKWinH3F35Vnu6P2vToafc1ZC/85MnVoaWipt8ErpizGagYaO9AxkQ6f4ZxmgPw5V5T6w5dnctN9u5lOeOatvg9qGxyhUZfO2Q6P1mbhe/fxDxdZE6BBMHQVTDdVTJCW4+wnBkt3o0/n7l9PzhxE0rM9qrnwjSk+g/3lwpOTWddhbQhfLDgVb2RBJuL/iuYk3lV2YAKwXSYfzjyKyuLc3PLsdi3sl/MEzJ6b+AIfqJP+zr/uk1lVzHtcT6RpVuvbvU0LYWqfdOuiiG96GFhsDFX1RzbdWgoMcU1zhFClZ80N2kBpMF0iR9y+JACVjh88E6F47BzZXEKC2B+7hLqaHQb49a0dDWI+C8p2gHh/vHUI972Z0+dqA3J+4qiVEIvhgDh2AoQZsM0OkQ8tkwADZ163iSJThTIoA2CkQQZy9IjrYyNHbjLx0gpTFR16RTwBcDVgPGbfJSpmA+VQ8TY8+B8hTRFKZEsKWQ+jAwuC3AEfkbCsrfjENuIGO/i3;4:cC4kh+4062xkRCpVfrcTkeDMTqkvHdsU8Kgn7X6ViiQQQpZK1DQg3llI5YLdIJA6NnUgVN56S+Y4MgOSg8eeYipEailsVVuo7R9E1c49XyMTLyC0OimaNPVaPN5idn8fdjIv6pKIjW5LUj0ObUXifWJDb3i4C57DGAYLkvl78Ld2V9KALpZETkbDOd9jjWRtg+ozJHPQLSYpRNESdWh4lCjHxdltsduFM4WUQkJHn3tGmQDYppiBL2yqA1LJYknknEUFR+gq/g1TAS4iCuFO1FFUL9C0xGTEGsGvciQZW8KjjF0/8YL1vcCUL3M8q4fo
X-Microsoft-Antispam-PRVS: <SN6PR15MB25102B6E08912524E1F41479D7D80@SN6PR15MB2510.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:SN6PR15MB2510;BCL:0;PCL:0;RULEID:;SRVR:SN6PR15MB2510;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(396003)(376002)(346002)(39860400002)(199004)(189003)(8936002)(2906002)(81166006)(81156014)(31696002)(478600001)(8676002)(36756003)(53546011)(386003)(64126003)(229853002)(230700001)(59450400001)(53936002)(50466002)(6246003)(105586002)(16526019)(186003)(31686004)(106356001)(6666003)(97736004)(2950100002)(52396003)(67846002)(65826007)(58126008)(316002)(110136005)(23746002)(46003)(6116002)(4326008)(65956001)(65806001)(47776003)(5660300001)(1706002)(305945005)(76176011)(25786009)(52116002)(68736007)(6486002)(86362001)(575784001)(7736002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR15MB2510;H:[IPv6:2620:10d:c081:1130::1246];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN6PR15MB2510;23:KkDeQJYW3YoPR8FIfDq7UBRJRwZT4Q7hYjCHO?=
 =?Windows-1252?Q?y9/neejP8/rQ6zjWqsiT4TOd99qouc2Piz+Y28pAN4EGwcFaDvyUlW4v?=
 =?Windows-1252?Q?ehUky2Op969HWbzOG8WPZOKhzSG6fuMwMsqUJgM2niaQwZyP8XSWKWYh?=
 =?Windows-1252?Q?mNPfFat5jmP1UK6FRYSs4367UTYqwz6eIITSmTR8K3CU2uNJqtQzV8RL?=
 =?Windows-1252?Q?yTrFyM+YHRylL6uSn/ZSJo7Kach0JOJmvQS4Z9pSl/WOt4EtXdVe/hqd?=
 =?Windows-1252?Q?1ysyBSd0wsUHtUw0n43obZ0uZxjjuR5BwsKYURHlhl/1lZpSOyov0AqH?=
 =?Windows-1252?Q?U7E9Zh7VqDoBTEyFscuI5S35CihUDhQeQzxqfsZNiSC3e+RRZGysCK3i?=
 =?Windows-1252?Q?3PcAWWQO8jXNIHwD8vZJKeUk1CDiCFIz8pQTvaKmmOzqNPswWTa2/xIn?=
 =?Windows-1252?Q?Rj2B8rmF2aMksrxYdFu4TYhdx+Rp00vRFtodteOXUXWKx/tvzrMpI6w6?=
 =?Windows-1252?Q?IcLDgnPJOexpK+p+tWEwGBWkdtHh87l/GD1l5AQzIdb9RiVBjgqcj8Yx?=
 =?Windows-1252?Q?Ax2GO1jyQClK+7Mh0/usYaesGJ88swviL84FajxjIFIoB3uuY2cGzsQb?=
 =?Windows-1252?Q?oelhxG+ITYd06olUiDq9ir55XFW/iehtLQXgzKcknabecRZSnPfyak6a?=
 =?Windows-1252?Q?WpC7fikrL/MasKbTTfRakuBszKJ2mNUxX1+wtf9mEXqblr/e5Dvg8vk0?=
 =?Windows-1252?Q?a6Z9/A8C5nLQFTTGsPQUBdxc5BBo8+ibKMAv+h+RGv8/su3aKx/zEDrZ?=
 =?Windows-1252?Q?Ryap7Ed2GsRPFHa8C+B7Z8cz71wjyHdW5kG/uYsfinoNfjneAZGG1mvy?=
 =?Windows-1252?Q?+wtjU4wVJ0xxNly+K1A5KuIpLpngMbrwpoFKkQb3QWK6Ia2WSpZB47rT?=
 =?Windows-1252?Q?sL9CTUpajHeVFtM/HaZv6Wz3fBLr76Odr+2CjUndnLJrrCPiV5se5N9Y?=
 =?Windows-1252?Q?832JjjZW0Ow8yzmBRNXH+UiKcGzObzm2zPCtn5lxVmW9M84zUQN+1ND6?=
 =?Windows-1252?Q?njNgqDV2ae3Be1SQsFdW0DaTYrPZD+O8LM1uWYVqNq+iQDzM99oMxZod?=
 =?Windows-1252?Q?FJV+NRyA+wRCupjlztkHvugT/ZQLD06MVMQuHeIej9OhqjMVXQX2FUz2?=
 =?Windows-1252?Q?viUq6x0h648V2tFp3kmgZwsq4pxHJGy0NtQND+Q79RV1erJhNA9pgKoP?=
 =?Windows-1252?Q?ceXhNB3vAYvZw3MbWcXbtuFeSVyLvMPJe5gwc6j7Gny4TecsnJw5SGeP?=
 =?Windows-1252?Q?OWX0JbkH3zWf37cMYO3hjzQdm4ayDKyhE2GGpyUmHX4J1YDFxv+nt7mk?=
 =?Windows-1252?Q?ajrn63Qf7ZBlNh90m+cBTpaMCzLAx8q9cvG2LXv1ZCg8MKkGZkWbzrFD?=
 =?Windows-1252?Q?tllGUR07Ka/2ufpv0dI?=
X-Microsoft-Antispam-Message-Info: mWz5JEvTORkF6ZoheIBXpyNGxv5EP3eptQ+ZUwx7qgZNd4JpTRzx8Udq2e3HS+uZCCLIHuoUlt7NdPz2w41NIx7ISEzJ1Qb/W0qqevc4AGASuVxHAn/WFb/nf4cY7nNROhh4jelmOrSRtu5g26jkh3BV5vo8Cu20t53a8W4BXmeG2l8ubWDsGAdeZB+L5TVu
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;6:yrbFlQBv6jwtzJDb8B+gW6gPEddzLdhfrV2MH+fQ9fksxfyz021ucMb8Ob+dqg4l4qUcNKf2qG6/X+0+cQ+iAI9VLX4N1+f6oFlkmTuPhaggML+7h9C8FHRzXCDQww60nQYpLQPERARfb3UuYdwKlkGzA0/6jYqA2pfPcoU2ML0vbQ6gz6zHKiUx7GByqleY4iiTA7og99CA4y7lqCdRPQezBwv+6JsKtCRTEhYDH/r96EiFs6YkKE+wo4KMWANsx0O7F4GIvTJd9+n5xnErTBrsIh8K9M7n3/0eCmwQyMMh0UBocZGNTx+HVPTW+8NBRux61iFpEZdfMZCBrrZZs5kPL4QMbAiTAosQwFjqdLc=;5:3huf0u31qFChr01wZBwA0T/Mw54knwC64fnApov8i6ADh88LTc/7hq/ZwEx/sE1KTP4Gtlku2gVEnu3Ri54oqqIPl52hwUDX0RX2f4Bj4aZcyFQ8lHXKqnSslC5uE/IS+HX3dL44mdrlzIPigKWURYMB0x79TXLw/tIzc0ccFcM=;24:PypN0hsd8li6UpKn14VXpAjCofhTzJNTw7QwCQGQuGudz5vwnWy8f5IEYFiCQa0KXGqa3F20J7cxod73nwZTdq2nPp2ZY8ieYtNqJ3v5DSU=;7:r2imf8fHJ5U70ZNalTp085R+abD08MrSL3kgkl86xgS55nOy+CG1Df3UlOtGwd6hkb+uY4G30qHSoHRzTUhNPLS4R6Z/9W0H/tGzP/Y47OJiNeX2F4cp/aCAE2su0gRHhKCEJ5cr1ttScN3Cyh2Eja3DN2aCrWRbCOx5OEHKscEJ6K6ghB7c2daTnUGVsq+z2aOQCLtw5czvHFG8wzJhmtkxAFmaqIe+GflvbA2Ahml9kh7SzsLb6ZFC/dJTo0do
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR15MB2510;20:ECvyShujWXqvS98JFN3AnW0FDXBW+hrinE9k0IE5FatJqugsXmHL4STmVkjdpEWj9Zk1FiJy2I5j6yPlQ0Rl6GRInjBdP1XJ411pwixiSKj3+leen5vnjGQtKbgyrelV5xPPkh6B4a90EmwWoRU3PrSVpnngKET2JN/0lLGIs5E=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 01:07:49.1315 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fdfbff4-6a7f-4f8a-1aef-08d583c7d8f7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2510
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

combining multiple answers...

On 3/6/18 3:05 AM, Greg KH wrote:
>
> Any chance you can add a field to your "umh module" type such that a
> normal 'modinfo' program will be able to notice it is different easily?

ok. handling of modinfo turned out to be straightforward.
kmod tooling worked fine with simple addition of .modinfo section.

$ modinfo bpfilter
filename: 
/lib/modules/4.16.0-rc4-00799-g1716f0aa3039-dirty/net/bpfilter/bpfilter.ko
umh:            Y
license:        GPL

I will require umh=Y and license to be present.
umh has to be set to Y for this 'umh modules'
and taint of kernel will happen if license is not gpl.
Other modinfo like vermagic are not applicable here, since
umh modules interact with kernel via normal kernel/user abi.

>> Since umh can crash, can be oom-ed by the kernel, killed by admin,
>> the subsystem that uses them (like bpfilter) need to manage life
>> time of umh on its own, so module infra doesn't do any accounting
>> of them. They don't appear in "lsmod" and cannot be "rmmod".
>> Multiple request_module("umh") will load multiple umh.ko processes.
>>
>> Similar to kernel modules the kernel will be tainted if "umh module"
>> has invalid signature.
>
> Shouldn't we fail to load the "module" if the signature is not valid if
> CONFIG_MODULE_SIG_FORCE=y is enabled, like we do for modules?  I run my
> systems like that, and just "warning" isn't probably a good idea for
> systems that want to enforce that everything is signed properly?

CONFIG_MODULE_SIG_FORCE=y is already handled by this patch.
It's checked first for either .ko or umh.ko (before any elf parsing)
and returns -ENOKEY to user space without any dmesg message.
I think it's best to keep it as-is.
The taint and warning is for 'undef SIG_FORCE' and when module
is signed, but incorrectly.

>
> Other than that, one minor question:
>
>> @@ -1745,7 +1745,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>>  	sched_exec();
>>
>>  	bprm->file = file;
>> -	if (fd == AT_FDCWD || filename->name[0] == '/') {
>> +	if (!filename) {
>> +		bprm->filename = "/dev/null";
>
> Why the use of "/dev/null" for the filename here, and elsewhere in the
> code?  While I'm "sure" that everyone really does have /dev/null/
> mounted in the root namespace, what is the use of it here?

filename is assumed to be non-null in several places further
down and instead of hacking it everywhere it's cleaner to assign
some string to it.
I'll change it to filename = "none"
Same in umh part.

> Also, what "namespace" does this usermode helper run in?  I'm guessing
> the "root" one, which is fine with me, but note that people have
> complained in the past about other UMH running in that namespace and not
> in the specific namespace of the "container" that they wanted it to run
> in.

right. this is something we can tweak later if really necessary.
Right now most of the bpf is root-only, so bpfilter.ko would have to run
as cap_sys_admin for now. Later we plan to tighten it to be
cap_net_admin.


On 3/6/18 11:12 AM, Linus Torvalds wrote:
 >
 > particularly for the early implementation when this is a new thing, I
 > really want a message like
 >
 >     executed user process xyz-abc as a pseudo-module
 >
 > or something in dmesg.
 >
 > I do *not* want this to be a magical way to hide things.

right. no intent of hiding anything.
The first thing bpfilter.ko does is print 'Starting bpfilter'
into /dev/console.

Long term the health check of 'umh module' and interaction with
the kernel should be standardized and though they're normal processes
seen with 'ps' would be good to see them in lsmod as well.
For now it's indeed the best to do pr_warn() message like above.
Ratelimiting is probably not necessary.


On 3/6/18 12:01 PM, Andy Lutomirski wrote:
 >
 > I imagine that usermode tooling needs to change regardless
 > because the existing tools may get rather confused if a .ko "module"

the goal is to do zero changes to user tooling.
The kmod tools handle this special .ko just fine.
Tested with modprobe, depmod, modinfo, insmod.
scripts/sign-file also works.

