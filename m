Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3768768-1519806075-2-5514141393329126153
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519806074; b=prT2YYBeQE4ILMRRAbmaKcUXmvZ+1qAhL9FrtM1ccDg4Vd0
    xWT4aEcIBikqFmgA+ONbFHBWGhg95x+nPl5kh1ZK0xHexlkF8toNBYTrdC3wX0Ci
    4pGQ2xtTj1hraOXIuZXM8NXQ5N2cLQ5jiA1VvyFAI1MlQt5F4ccIjEszbQSyRjy9
    GzYn2blHw+V0WS2bxlwRawmbCcn8DNpqswTVklqXIBQij86uRzxJ6PXae0tUOvig
    WbPqvrWbfnI4mP5OcFGWyTdJysFuGMdaOjTDnCezyHHv/Ijg40vsmpGDbbs93Wt+
    ryu/U+WLoFRKFXD9p0l6C9jYxGKcAHZz/uLUEGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519806074; bh=FCI74M3OA+BLUzTz3UJiCIZSMz9pfu66ZO23F7YbDPg=; b=R
    N+GyFLhkxW3JdXIRSJFIcHRAOpoYu0uefyIC7KQZ2YdAjaqUgLwHne8LBVlO2E/R
    xNkssGo2Wn9vydKajBVJ8pzEWx9UYbZC2Aqa7vXLzIr4oqtkfyA+FxBAbdjRzOP7
    Zj9jvFadJZo87ClSdQoEpzkeRApENJSJkSbk5UwMIageoPEsMjVjQNTfe2QOfAxR
    O+kCaDUSrplHrJrvKb9TheDK3QdflC246/7Cr3/ka7VfCo1WEgWNCYR7/cg1m3Je
    PRyJwZk/oZ7aa80hIxOfCmcfZbrl8qOnBy/ZNIOtEgoFI0u0lTHslkkDTA0AgBp0
    QkQigllfx7i9fbeIrmu2A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=D0yRtITL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=D0yRtITL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751764AbeB1IVL (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 03:21:11 -0500
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:56314
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751758AbeB1IVK (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 28 Feb 2018 03:21:10 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH 3/3] userfaultfd: non-cooperative: allow synchronous
 EVENT_REMOVE
To: Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Cc: linux-mm <linux-mm@kvack.org>,
        linux-api <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, crml <criu@openvz.org>
References: <1519719592-22668-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1519719592-22668-4-git-send-email-rppt@linux.vnet.ibm.com>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <1a2ed216-74ac-5fe2-abff-21d670eeb96d@virtuozzo.com>
Date: Wed, 28 Feb 2018 11:21:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1519719592-22668-4-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.220.239.180]
X-ClientProxiedBy: HE1PR0401CA0059.eurprd04.prod.outlook.com
 (2603:10a6:3:19::27) To HE1PR0802MB2139.eurprd08.prod.outlook.com
 (2603:10a6:3:c2::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 519f35ca-b114-43f8-183b-08d57e843731
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0802MB2139;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2139;3:JHi7ppmg9DsCHfjF4yFC7t1bIgu1NMpFB1vdNYKqflUtqsDuEpbfnaiePsdV5hZLrUGc2zeqx95E2vaJtpHRTgys89mqkRpnmtqqcSuJrpdTuAWRQeZoeJgpEN3UVXkBHtqPL8EodY7+/FOvR1/GHzEGYHffnH729NKiF1+88RJQOkxzTgN843LOzaeLBmdgu8bhXoWZJwNdQHiDffgiH0Uvc5gYq0X2rnKKvw7aNm028QGlYPfR911ARvn9sPBs;25:/XStzGrYZOc2fkkirZHxJ5S72q61/l+Bmuj/+rmEPE6Bbnqd0C7EeGEipwNJhj/5vPQGqa6Zcmx98PBGB50i8ilIOsB1Ga4fiIdbwNBcrYxHS2755rKB7kvFnDOOj12JJr2P2iFLnzd162iz1AYFuL/GtYasBjXbcDc1rcl4uSXN/KQ+Agd5lQGeKsitXXM+MMsudJxHQfWGxNyOUb1acby2jo+VP6KSvm0zwCFhV4G1ecQIM4kpGStChile+ASLlLAkl+lu0DnHBlZs5NSXQMvPJB4WIecQEL4isHtqhqquo/tSpysvuhID8RZGEtKp4+A+cmLyG6pcEH6Yw7Cafg==;31:LqF1rU9NGP9DRTo2zd8/7XOA8Qz512JuXWQovyEZBh2xBEu7WR0to8wvnK2WOw8+4uICDhQbDKe620y1j9s022P/z3q2TtQib8NAIX6YiBmvz5OfnPUftKBXuhU4A+D7TI1DGMOWrWd1SY64Cbe6zXnBHUWWjPq1lAJVi9CrdavymaLWy0wMHJL3jEQdVtC7/k0GAyIRUOqWV/S019HmOGzQk6y7FF2sWca1CMCVnWo=
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2139:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2139;20:i+kkbkk78A2jeJIWi+KIwJKsL6QvDwc9bckY42X5GRWmyZJ5QjRev4yEbVoLRDFZgwkLc43h4ekM+vZc+xJ2jMCE++CPt2U59TvIfXbSv9CmZEc7IGPGLfyHNmGII6ygKwDYeAYTd7ySd3sNmb+/hHEmNA+iIqs1CCU53xpRgVtdpZmmsv+9tKLzviGKezCdtp/62b2sZgFWHevYXGhfpnWmLmk7HSXL8zop82Aan/Q0X0OlwpZMiV7pMGGJTsIPbEQ0e5dphhlMweFqLuX3GMnWMimR2cKQ7Qb8cjJaFNEj+eVp8Bp9PFPTiHCGYMTd5tI8dMKInyJfxazi+83HmxTx6x48jPUF0vq2Jkqo5+3dXdLEX59hLezbISKniF9dkZPnSpALqwyPlo6HcHDzUZCz+ZTkOYGmTV+Tt8ztmHLlXgN4WC3l39TT9LoXLoSDQpm7PyBL2y0b1BBd16cs8JaJjNl6c1rCqHaJvAcOJ8t0iaza8S7KZZ9Pb+5R7ncs;4:Yi8+UQTr8Ib5D+KXt/gvuAL4RXzth5j/eONK+ExsOCYFsTQ0sHsxSMsq6HsRxmoD4sULuJwh/ezbWy+8shQKFvO9ZSxGHHF4IzrsLND737foBI6rn0PD1B/qPNmTytqciBuw9htz42jhAQv24KXvQoBu7ryYmcIux8IzQnNgaf7ko3yxyst1zaGGAJglm7HvLECgS2uXcoDlVCAsFFV1RIfa9yGbw+jtGMcaKkvyszvOSOAAwzWkTNkKtj2MjJe8JC29yHmMENLB+nZvxdCX7g==
X-Microsoft-Antispam-PRVS: <HE1PR0802MB21399C9A3461CAC982C060BAB0C70@HE1PR0802MB2139.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(3231220)(944501217)(52105095)(93006095)(93001095)(10201501046)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:HE1PR0802MB2139;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0802MB2139;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39850400004)(366004)(39380400002)(376002)(199004)(189003)(6666003)(316002)(106356001)(2950100002)(65956001)(65806001)(558084003)(31686004)(47776003)(117156002)(65826007)(66066001)(25786009)(7736002)(86362001)(5660300001)(305945005)(4326008)(6116002)(31696002)(105586002)(97736004)(229853002)(107886003)(6246003)(53936002)(3846002)(110136005)(52116002)(23676004)(68736007)(478600001)(54906003)(58126008)(2486003)(52146003)(36756003)(16576012)(8676002)(81166006)(2906002)(230700001)(81156014)(50466002)(8936002)(76176011)(386003)(26005)(16526019)(77096007)(64126003)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0802MB2139;H:[192.168.43.229];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA4MDJNQjIxMzk7MjM6eXA3alNWSVV6enY1Y0hrR2tiSmlUVytx?=
 =?utf-8?B?MEZveVRCeEozZmV1ZHlDMWlZMWpWKzRKclR2clU2NW9lYmxpVll1MjBCakJP?=
 =?utf-8?B?RGp6b3hLNU4vbEpXbHowT0pBeDZPTlJ6dGNBUi9uck5vSUFFWUd4Q2ZYNFdv?=
 =?utf-8?B?TVY1eEZ3TGFkQm5VM044cFpGSkJvTFk4bVY3WkxxNC8xSFhZVEI5R3lqdXIv?=
 =?utf-8?B?blh4eGkzaExmY0tYWi9yTzdNaVBPL3pOT3FUaHFxMllKbkNHd3dUU0NMc2pQ?=
 =?utf-8?B?aE5JaUxrZXJMeXVJeWY2dnI2U0cxSkVDNU42aXIrbWxZT3ZUMmM4eVh2MUVS?=
 =?utf-8?B?Q0QvenJ3bTUzd0hQeG9TdVhra29FS1hqMzNnY2JkTFJDQXVBeE94dDI5RnFN?=
 =?utf-8?B?Nyt0NnRxZ2ZOc1F6Rmlmd3lUdzlMUkxJYzRzQ3FGbWxNRVpCTFBDbzlrUVFv?=
 =?utf-8?B?THB0aUozdCtlTTVncDNlbXhXNjh1UkhUdkwyTGk2S1piRjJ0OG1TZ3I4MTJ5?=
 =?utf-8?B?NU54Skw0aWs1VzBzaTJHcnJGZXdWVmdiRU1lY043TzBkdEZQWjBDUnF1cGR5?=
 =?utf-8?B?QWpwaWM4ZWdZL2I0VTlUYVhCYTM2eTNqOGFIWUdOdGF5b08xdEp2RStuNzdp?=
 =?utf-8?B?cUdRU01NS1ZHWnBuaHRtZ1NkVnd1dUJ6ckdqL0FzVExnU0FPTHNLMTEybUJ1?=
 =?utf-8?B?TjdubS9uR09qd2ZGZkdZZ2ZUM21TdUJBb1c5RnNNRm56RDJsSStZb2NOSFRB?=
 =?utf-8?B?MEhiVzBXOG9wenBDaVlHR0RZWnF2eHFMKys3Nk1BM2pueWJaZW1QODJzcTBj?=
 =?utf-8?B?UnJTWEEwaWdTWVBiRjUxWkNWZzNCOTJsSE9ZcEdZaEk3SnZLeWVhUVBKYlVp?=
 =?utf-8?B?RUJjNXpQZ1FOZEY1Ymw5WURZdXdXTlpEUEhDeUhiVFVRQ1NZV3MzVUw3SDBn?=
 =?utf-8?B?WHo1YWZGbkFhbVpjdjdxNThEU3BqNmpiUzR4QS9PK212bFhqQWl5Q2ZTUkxv?=
 =?utf-8?B?U1ZkV2FIZXpBMVUvdzFjSUhBTGc2Wk1sV3JXZmxGZi9sZFFNdEk1SkkxWVpj?=
 =?utf-8?B?dWEwR2lKTEJ3bGF0TmMzNmRoaFRhbjhZdFg4eFZ0enZzd3pVanN2SXFPOG1I?=
 =?utf-8?B?eVNLNFAyYnRrdUNLNktXRWpSTE8xMFpPaElxYUg0TmZQSGV4OUR4ZkNlSEpF?=
 =?utf-8?B?WHFDUjdoVW1oTDhvYVp0aDh3eGdDSEVCZDRxMlNSNVVzZFBGYUFJOWFZeURV?=
 =?utf-8?B?TmQza0RGMVNYUC9vdU9QZUI4TkxOQTNmU0VwMGFhWE9XeDRkQjE3b05vekhX?=
 =?utf-8?B?Y1VrZVN3UHNwTjhvVHlyQkUwK0ROL0NMNkN3Z0xEbzQwQzVLZkhQL1I4MENK?=
 =?utf-8?B?WlVCaGJRMjBLM0ZFZ3BvLzlOQ3BKdjJCM1hhckFrdzQyaG1ob2Z3YWZvcVcx?=
 =?utf-8?B?ejBKMVd2ZG53N0EyUW5QTzcrb0ZPYWMvSVpyclBqSUNjR3gzUGZFb1VyRFhU?=
 =?utf-8?B?ZERRYmpHbFNlMnRDWUE4VHJhN3cxQlJVV0I0L01Wc1U1YkxSbmV6VkRvR3NK?=
 =?utf-8?B?R3ZmRUFVeXZ2OXovYXU1VFJXZm1wUEthS3FXaXFHZGlPK2IxZWR1c1p4Y1FI?=
 =?utf-8?B?dzVNN1FySTJGQnA2Qk15NXZNaGp2U0t4TVFUYjlncENIb2ZkQ3hFSm9hNHFX?=
 =?utf-8?B?bldYclp2TTZpWVlWQXMzNGVtMlY3UEVhODlGN0VoVzJxaXUxNjRRVDBVOUxP?=
 =?utf-8?B?SGZLNlBDb0RzRGRoc3Q3RW56a3VLZW56TjZNd3B5UnpObXhVMWxCOTlvTTRq?=
 =?utf-8?B?MFd2c2hYMDRjWkdIdkF0S1FGWS83QWtzNDZNaDF3Si8xVWZ5NjlUWHJDQWhF?=
 =?utf-8?Q?nWJO2CLSYqIS/NbdP2VPoXabwRRKvE0K0T?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2139;6:nIhVAB6AYxQwSOfJSjdet0albxBdcaorMpo7G3TAja6aCJy69zZjAp3PpPA1vH4TfrlT0vs7tvXmREQ04i0klgj8c8VI0vZUtyVO3ktfTTv0Kot4w5SAQg2Qx5ELt7jCly1UdWfE7voYZm/XNMkxD0atMuDPnMsjvc9yAJ/6+FD97603TVIeEGrK31pcADWoIoRw5sGg+GUqWEekNx/7jdYU8gFnL3ex62Pd+tGUsGwV0QJus5XIgyRpJZbhvZwDaXLNy/rrTAZn4A4pjK271ZeOnYwGUKjIZSOL/bk0VvcPj5rZjtCAoXfWZf8eCR/1ObMfo+py/Ar8KvShrrd0wsAlG3pYcY1jvxcKsIAieJ4=;5:/tEA1An4gLxjXGbbUc1T1bTkMtuTXhMWYYlj9RYxQVX/t1WYwDrqAVujgtlkM38tVuDq0yMpqRr3xQ0+EPXqoSqnMbZdkVd4xWRyMl879+b7Ft3Cqw7KjiMGEl5rSwbb2DJaJNQ5TVT7zZ5NM74V6BUkKWcCfg7mwoPHiZwYT1o=;24:oTydXlG7ku6ogRq7onm7e51bt6YtzAV7miUcbshF7Avs6aG/IRUiwq3grmU3o4fdHVWew9l7nFL4ASfb3m82AJixMXKI3Dx2zNWTOVvlTWs=;7:8lTQAA6ZucInOtWmJ9oXJQ3QuZcbtuqrS82LiqA0et5HdiC6XizCTEXVZkW//Fd+sKU2mSfTMcuWc1LfoV0IbfF1pKmj65UoYZ1FaRETkGH/Yw0m4tBNGnjV/31FcMumw4ctUG2sCbRfh2dYjJakMq3LAgvwa4K5ayNUhfLm90jrTTgZmK0rKtdPzmoBB63rFjvi3Q2ICVQy6Uim6d2JGkwsAd1AW9FdyYfKpviNtNll/lpynn65138DYFRbcD8P
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0802MB2139;20:woLIxCaLE2xmeTU0ygMxVU/OM3kzLe1YWHfGhhLZGYQaielm/pYxFNTq+KyFEE2jM/Ho3EMiqfAEdrU7t9Dsh07LzKKWlMAiPbpjwpiD1uFW8hB004pH9CUKEji1h3e6m1Ry8FtMB4zpEPl1kW1eJykddnD1gUrL+hYQAAwfI98=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 08:21:06.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 519f35ca-b114-43f8-183b-08d57e843731
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2139
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> @@ -52,6 +53,7 @@
>  #define _UFFDIO_WAKE			(0x02)
>  #define _UFFDIO_COPY			(0x03)
>  #define _UFFDIO_ZEROPAGE		(0x04)
> +#define _UFFDIO_WAKE_SYNC_EVENT		(0x05)

Excuse my ignorance, but what's the difference between UFFDIO_WAKE and UFFDIO_WAKE_SYNC_EVENT?

-- Pavel
