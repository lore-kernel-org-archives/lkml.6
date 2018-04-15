Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-510911-1523802902-2-14267315400771653238
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523802902; b=ishfDoGV9V0XKZzWFIpyJ5Yfu/8Q1Zc1adfK5CJ74+606YRBDc
    zCv0X+J8IGU/jlUxw9jvtWOhBDvdsvPyw+EM+zIzuTwG4mPc+5RXSaNjg+5zDQvL
    Ire969sjNMleMQRwiHJV04v2hYPZDQcWDlxiqHCH4xcuLkW4O+pERtU2SaRMJXBW
    klQNnUQAW51Y6LGM4G+9hV8CQfvN6nkgo0xuCMA6HvLyZsgUkyt8VpWeFuGp6vIQ
    4fUNuIwmtfi22kHyftrIVqVW4+mqiOJmRlB2n3+yk9Yfev+2HpLQ6MpfoXtIcdJy
    NJk3VITaCP5LmkceaE99nmMLbNBWCNvzR1GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523802902; bh=J9sWFwLIEM5FnjJfJzkISTppM88mKl9CQShom75g6aM=; b=
    m1NoVaU+bMTvdAiNN+8S17mhPGr8SDUoQGi81P4l9JBRjyVjvIifMLJBpsbtbtU5
    uG/FBuALe5H1gguU95rJjJa8F/CW0eVjri8tkP1RXv9XQUHXv74ZYHeDM+RRPtG4
    EA863nBPAwfMJvy3LC14L/jAF7pIiWU6j4bfwb+VNSplEB35sVZDqkMB7HypDbKC
    AZ+U6w90apEoN/LjFbAzRfqq86ivjd9Lg5UqUswU/9929CJEWmqbDA1stSGsn8CJ
    io175z38dsG78q6msXKiINS5xCXa5mNBgMK8n42vY9ES9gdDV9Pnl4G9dwEayYJs
    JBb52x6ogjZtaqG8+2qnwA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YNCIHeyd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YNCIHeyd x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKPjYH80r70sAgdq4kxykJTQpOXogQjq62BUURtHZOemeMi+q3/a59XEzcFVDDN67x60AfEUbFyaMPypu+GXzR+MTIW6g9QoVLWxTyMxp5J0W8ddMcCL
    u2r7x5Bg1soXq0BXdiScB3chWMZ8349cvE4AKgPV9uQW2jOYkhJP88by9h58T73ZBr5I7q2YvSFW06pIrS2Ax+WnXBJa4kBbPHx1M51fDYxxFIGwzp++Gepf
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=z1WaDHk8-PFPRF97YAYA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752277AbeDOOe5 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 15 Apr 2018 10:34:57 -0400
Received: from mail-co1nam03on0139.outbound.protection.outlook.com ([104.47.40.139]:2704
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751890AbeDOOe4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 15 Apr 2018 10:34:56 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Petr Mladek <pmladek@suse.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.15 019/189] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.15 019/189] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5gTpP6JXfT76UOTL5UYuogqGqP4Fq6AgAnX8IA=
Date: Sun, 15 Apr 2018 14:34:52 +0000
Message-ID: <20180415143447.GL2341@sasha-vm>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-19-alexander.levin@microsoft.com>
 <20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz>
In-Reply-To: <20180409081535.dq7p5bfnpvd3xk3t@pathway.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:8IWYML0yhMUn991k8MJRqL40w6UkXqltFuyBd0Q1aZxNgzZAdohZLe4oFwo0W1qHmmj9kuM1SwrWhDH5Cm+X3ZlQPQ6NDBNByHLfN4kF0Qa/ka+Na0XQcInXCVloLDr9r+PmjyiDfJh/uvv02J44BPbfrgOb6Ccc8dA49ZrwQ4mHFYO5g2WjxWw6H0s+5ZRDrDBEWyEj+WA6Yr99kYdTrsw8oJBn989nn9XzdJzjXOKqQ6+GLIO5wK/NRqdetvRE;20:NBOKk7wXGZO61WeYsvPN+JmkSLl5Xc9jVqYThkYLexVfpmBvUj2rF+hOUCeBTxdk6JfWz5gbi2ezIJ3y69jQg7gpm8/g6BzCmSj5P6BUibfdeM2BqpF2h8YWzSt8pBaS5MVCyDR1AcC5TtPEBwW20IhaWVUKxoA8Z1ucdIbPtmw=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047B21E232D6224CC6E2FBBFBB10@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501347)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0643BDA83C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(39860400002)(346002)(39380400002)(396003)(366004)(199004)(189003)(377424004)(68736007)(5660300001)(97736004)(25786009)(26005)(2906002)(10090500001)(3846002)(86362001)(575784001)(6116002)(478600001)(2900100001)(10290500003)(229853002)(14454004)(72206003)(6486002)(105586002)(66066001)(7416002)(3660700001)(33656002)(3280700002)(8936002)(81166006)(81156014)(53936002)(1076002)(54906003)(9686003)(6512007)(8676002)(99286004)(76176011)(39060400002)(102836004)(59450400001)(86612001)(476003)(33896004)(11346002)(446003)(6506007)(6246003)(305945005)(33716001)(7736002)(4326008)(22452003)(486006)(6436002)(186003)(5250100002)(106356001)(316002)(6916009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: wR89cWLlK1mdK1hJH6B26l9zFTWVcpUZW7snBYUrZpFlD/fGa/dLxYvcc0TFT4xfZCnO/7sf2U8J1XF5TIUbytJ6oPAAFF7sNKoHKW3nFSMkanU4G7lA+F5IZlSQyboc+u7qea3yvT1KfLUNmNrDGJWaW8irOlwVHpo3G9ESzs8/otL/fTkiRe/vixBsXN/K
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <95004968C9AACD4EB8F524BAB47FDE97@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e1d4dd8f-e37b-40f3-5ab7-08d5a2de0ce4
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1d4dd8f-e37b-40f3-5ab7-08d5a2de0ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2018 14:34:52.3603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:15:35AM +0200, Petr Mladek wrote:
>On Mon 2018-04-09 00:16:59, Sasha Levin wrote:
>> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>>
>> [ Upstream commit dbdda842fe96f8932bae554f0adf463c27c42bc7 ]
>>
>> This patch implements what I discussed in Kernel Summit. I added
>> lockdep annotation (hopefully correctly), and it hasn't had any splats
>> (since I fixed some bugs in the first iterations). It did catch
>> problems when I had the owner covering too much. But now that the owner
>> is only set when actively calling the consoles, lockdep has stayed
>> quiet.
>
>I do not think that this is a material for stable backports. Yes, it
>is a fix but it is not trivial. There are already 3 follow up commits:
>
>c162d5b4338d72deed6 ("printk: Hide console waiter logic into helpers")
>fd5f7cde1b85d4c8e09 ("printk: Never set console_may_schedule in
>		console_trylock()")
>c14376de3a1befa70d9 ("printk: Wake klogd when passing console_lock owner")
>
>One is just a code clean up but the other two are changes/fixes that
>should go together with Steven's patch.
>
>These changes tries to prevent softlockups. It is a problem that is
>being discussed for years. We are still waiting for feedback to see if
>more changes will be necessary. IMHO, there is no reason to hurry and
>backport it everywhere.
>
>Best Regards,
>Petr

I'll remove it, thanks Petr!=
