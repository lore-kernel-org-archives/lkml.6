Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3578680-1523893153-2-17988130280877626350
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
    1523893152; b=f7D1DyUOn+zEzMzuGZvmzNSETFxNmn2NTf6HG0AFC9Ny+Ep7u4
    nxPBHe9gliJvYZ9edJwvHAe7StZcuTKhenseU/XYUzmxQuw6ujRZRXdFRLg52OBX
    7684zu6CFzeCVgtwSu0vXsAkYRU7p2eYr60/BE6ZIr+jRhO6dPB1RnCoYx2DCIZ2
    wm7BsfgIPu+3IS3FpRUZlfmgOQ9UBPboYIU4Bnb+KGT3xJMCMeoSKeNsv7Y7+s3F
    +cNaffiDVqcoqQNE7SrBIsLALzC8r70lFwEZN19GDMpkGVIip6OqeenS97Ve2oWx
    NOQtrLshBNwpHLJTuJp+m8eGucqZnrxeioWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523893152; bh=xrAGUT5CVyOBAuD7WzofRSStpsEShQ8ALA7GqDMfngg=; b=
    oxlnJ9q+JCPjnljyzPob2tVDd9hLuo7sOzH7eJ0RoNx0V55e51sOiuoTF1H6VBM6
    VxqQYfbWCz/Pw1TeLxeflL66IJnBi+S/phnWrKofirtSTtgog9s6mXg2GJSr39g5
    2WESU77mrfAYS8cY5raCge7pnHdQM4u87h/neExLeLkk+nrF9X+u4K2LEbdoruvI
    eYMx+TTzi76cEmyPPjyIrWeIJUNuM0VQWDI8/yNPXXpijRjlv+FKG4PPY0z5m2kA
    EhhfYDGgpYgmk0uFpR8pMM5dISR0saOHe/0zrhoPJO7Ccgg3yPcvYNgnZd05WTQF
    6BWF7KzDfKo1MiOq5q46LQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aCBCT1jv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aCBCT1jv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHjdWNfmsPWhZ3LCQXJ/xlDjjthgs8VZdoa5v/+yTz+i32KEKh9OHz1WJ6K7xxJ81qpIA8QSlRv+B10seCRQRH5hfZ14V5mfn+8fp7Eqi6+LOnQVkcUA
    WGtX5NYE0TEeUbNuLpiEthHw528zG4jJJKi6hxQWtcLXkuYOwKxSpGtmME/MLWKgyu/WDYAytfPtBaFjF/n44IfFBzuRUz5iw4H6VYC+fz9VfMMc20pC6C5k
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=meVymXHHAAAA:8 a=uD9DJJqf5m3OQLBjqZsA:9 a=CjuIK1q_8ugA:10
    a=2JgSa4NbpEOStq-L5dxp:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750972AbeDPPjJ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 11:39:09 -0400
Received: from mail-sn1nam02on0104.outbound.protection.outlook.com ([104.47.36.104]:9033
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750708AbeDPPjI (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 11:39:08 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>, Jan Kara <jack@suse.cz>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Byungchul Park <byungchul.park@lge.com>,
        Tejun Heo <tj@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAF1gA=
Date: Mon, 16 Apr 2018 15:39:04 +0000
Message-ID: <20180416153902.GW2341@sasha-vm>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-15-alexander.levin@microsoft.com>
 <20180409082246.34hgp3ymkfqke3a4@pathway.suse.cz>
 <20180415144248.GP2341@sasha-vm> <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
In-Reply-To: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:q41MAdJ+lWTPHHF1ldINFlHU3whP0NuO2Rqxqt+2IGudYUmHsb6M8DbjOSfiBoB6gcnRz47aU0FmurwdQAIt8AqI0oPsAznW/icQa36Uz0jjhPJPUZuQqLTLWVcZCzE7TUkVacf0Lh6GbNUQn4j4lhw6TYAJxhaigWPjkoVfIOSQJ7rUhObHGDy5JLf+Bfxh5EpOR6OTzT4iDF+2z4o4aEXioFZo/x9Hb8roPXsQmGXXOOn8rBCTucni4mhuSM3w;20:gc3/67AGBYGdOWTG2nXF+G2h0CJfuCrXvDzLplJ6OygivyyfGUT8fSZ+UljkCoD7cO7AaPNEdvLy0fLlFfmaoR6MvxKMdm0ptkwXOxzu4Gaw8tWfKR0ntOQHVTihXW+qTGbP6BdHsJl5WvxRp2n1R5SJztyxEFxQARtkSnLLsT4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062F6BF222AA9A82409F037FBB00@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(271806183753584);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(944501347)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(376002)(39380400002)(366004)(346002)(39860400002)(54094003)(199004)(189003)(9686003)(6512007)(1076002)(10090500001)(3846002)(6116002)(6246003)(66066001)(72206003)(39060400002)(53936002)(33716001)(2900100001)(8676002)(76176011)(11346002)(305945005)(2906002)(105586002)(446003)(25786009)(186003)(26005)(7736002)(81156014)(4326008)(33896004)(102836004)(97736004)(478600001)(10290500003)(14454004)(106356001)(316002)(6916009)(54906003)(22452003)(7416002)(486006)(6506007)(6436002)(229853002)(33656002)(3660700001)(81166006)(6486002)(5250100002)(5660300001)(86612001)(476003)(99286004)(93886005)(86362001)(68736007)(3280700002)(8936002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: UuwoSBSrFVx+XfOmNx/7IVameMbY0ozn2iH/UvN/811RO4GqlxF5xnKQGge/LhwFXiy0kzSVNIkt2IVw6w8791yGq9UmfMcpDKKdpHKE65Bfh0Z/gsMU1H2jmFhTqW9grlv8IIcFOkj7jtRN4dawKU/LrVsEPAEjzU11glkd44M5tzcYW7TREjWjlVAM4fLD
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6232387AC99B4C40BAA80F3AC774256D@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 4787f0c4-f0a1-4386-554e-08d5a3b02f97
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4787f0c4-f0a1-4386-554e-08d5a3b02f97
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 15:39:04.8980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 08:18:09AM -0700, Linus Torvalds wrote:
>On Mon, Apr 16, 2018 at 6:30 AM, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
>>
>> I wonder if the "AUTOSEL" patches should at least have an "ack-by" from
>> someone before they are pulled in. Otherwise there may be some subtle
>> issues that can find their way into stable releases.
>
>I don't know about anybody else, but I  get so many of the patch-bot
>patches for stable etc that I will *not* reply to normal cases. Only
>if there's some issue with a patch will I reply.
>
>I probably do get more than most, but still - requiring active
>participation for the steady flow of normal stable patches is almost
>pointless.
>
>Just look at the subject line of this thread. The numbers are so big
>that you almost need exponential notation for them.
>
>           Linus

I would be more than happy to make this an opt-in process on my end, but
given the responses I've been seeing from folks so far I doubt it'll
work for many people. Humans don't scale :)

There are a few statistics that suggest that the current workflow is
"good enough":

	1. The rejection rate (commits fixed or reverted) for
	AUTOSEL commits is similar (actually smaller) than commits
	tagged for -stable.

	2. Human response rate on review requests is higher than the
	rate Greg is getting with his review mails. This is somewhat
	expected, but it shows that people do what Linus does and reply
	just when they see something wrong.

I also think that using mailing lists for these is bringing up the
limitations of mailing lists. It's hard to go through the amount of
patches AUTOSEL is generating this way, but right now we don't have a
better alternative.=
