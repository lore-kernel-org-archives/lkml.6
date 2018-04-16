Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4150847-1523913535-2-15361981049240296542
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
    1523913535; b=J53cauyxLN2KV1InUjcKrcTAC0nxi5JkyzHUsoHv6sXkkpHlOS
    1kXrW/T/L/qiW5rWGEu0QuXhbERzG/OVcNntWGai6qwYLKHxdHkFpFta+zLAoiet
    UkfccPB5CyXyPXz91Mi7lv/iyb4FgySQ5qWOAy/r5VVy6aLlk0jZeDvxEoy3GbUv
    Ju9yIK4kK8/RPrMXF0li26DQWfNJqhRgXX2uNBzXxe3O/e2M5WHKs6JVtKIB9g/A
    QHx042Edzx/vVm7c5i+sdzzN5zItxhkLj1m5xrJ2M6NMN1CGiuB5HFAQvFmYQIPL
    5ke31wf42ox7TjypIcKZonVMI7IHF+vNln6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1523913535; bh=qRN/lbQg71uq99wjpKHlKrx2quiGTQBOfmvZdCLgs4o=; b=
    vddW4Nkln/WNg+UyTQHKNnXz4ikPih7++gvn5uLbxUZNqaHjzgu2Xyjh3wwW/IBf
    c2XJa9YwOgncxn7Sb/JKLPIWk+cXikIAbEKIE4Gj5zFYtPTepCSS88oOpdcYuSAx
    1uD7bnBpA7r6y0XQaQy12fyMQ4HI9XFLWr2ge/5K+5feL7rzEqDINZUS4xM2w13L
    xPOXzrwABEQllJC/eYySsdmNF1SyxtwTcXpliWlrswzc9Qw+uvjt4MTPvWiadKGJ
    gVHTyTP7iGr4JVf/Fa5uCFedgNOErGsy75D9m6qXK6ZzQ3UIvyQbyqMEr+otye9h
    lhjHFDmnsAVbRzZUX8Gk9A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cRfqDLFY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=cRfqDLFY x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNlBSATMUZ/YupLpO5q0kK7L2OjPZHsPFb1LuUkPaZG1k5mT3E6azjT1HunZbN6AeIo2xqDE3QiqKKo72/fZM/5UZt6l1VVUJXRGyWjQSSSj93IEupCr
    0yni/IadOZH+0YE6vijndBOqLni32VzTtrYPiceTJL5YecxWmqbdg48qeM2NmnOycUKARn9yMp+6JjJf5fFtJIym1I0zxvkRmPDV5Uf9AbX0RjyhLfglZT+h
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=Zk_yRc6yo3AIChNGBB4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751150AbeDPVSw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 17:18:52 -0400
Received: from mail-sn1nam02on0134.outbound.protection.outlook.com ([104.47.36.134]:53808
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751146AbeDPVSv (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 16 Apr 2018 17:18:51 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Jiri Kosina <jikos@kernel.org>
CC: Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Topic: [PATCH AUTOSEL for 4.14 015/161] printk: Add console owner and
 waiter logic to load balance console writes
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAADdYCAAAWWgIAABF0AgAACQQCAAA4zgIAAAxqAgAAynoCAAAVdgIAAAfQAgAAJ3IA=
Date: Mon, 16 Apr 2018 21:18:47 +0000
Message-ID: <20180416211845.GP2341@sasha-vm>
References: <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416153031.GA5039@amd> <20180416155031.GX2341@sasha-vm>
 <20180416160608.GA7071@amd> <20180416161412.GZ2341@sasha-vm>
 <20180416170501.GB11034@amd> <20180416171607.GJ2341@sasha-vm>
 <alpine.LRH.2.00.1804162214260.26111@gjva.wvxbf.pm>
 <20180416203629.GO2341@sasha-vm>
 <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1804162238500.28129@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0887;7:EApi9hfTabw9MqXZ10z96zm0MU+4nsuS9wOW/duurwlrgCreWplH84aOcHHq/kvxNdChSP+Jt/RNFldWSiutwplOcqzPLTpi9qVbX+FWUGN0OVKc39cxihrr2fdTYNgnUUPO01VUU41vbL0ug2glUyFMJg1gjX5DPug1w8UdLEc8yz+mUtH0Nx7Zg5eVxlmXaZWqS+QutNd8BUp5QTh59mpLETE14l5jWDJPcSldQYzktOo9ybCl0WkFk8O5HkPy;20:q7OH7l0Dza58qakz5hMiTC1r/5K/bqdz97xT5FwaDjmiyAC5nv/3/VrxJ9a7mr3qoYV8y2QEaF3SSsnek60n5ZtwNlLJ/iYD1nxIizHL291f1NgirWGwffyt8b2f+XcEESbQUT3Fqae2ZCOZ4iAup3LhITnvc9biUorEMvaT0yg=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0887;
x-ms-traffictypediagnostic: DM5PR2101MB0887:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0887087F8CA764E19268C6B0FBB00@DM5PR2101MB0887.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(192374486261705);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231232)(944501347)(52105095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0887;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0887;
x-forefront-prvs: 0644578634
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(51444003)(199004)(189003)(6506007)(8936002)(76176011)(33896004)(59450400001)(305945005)(7736002)(5660300001)(8676002)(81156014)(81166006)(33716001)(7416002)(26005)(93886005)(99286004)(39060400002)(25786009)(316002)(22452003)(186003)(10290500003)(478600001)(66066001)(33656002)(6246003)(9686003)(54906003)(53936002)(6512007)(4326008)(6916009)(6486002)(105586002)(106356001)(3660700001)(6116002)(3280700002)(10090500001)(68736007)(72206003)(1076002)(2900100001)(229853002)(3846002)(14454004)(476003)(486006)(97736004)(6436002)(102836004)(86612001)(446003)(5250100002)(11346002)(2906002)(86362001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0887;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: GGTnTLDvfyILV7ji5gMouVHAl5tcnVr9kJ4Bp3DHOIshMTMCbgz9s1LLWFfEoSOaGdO55XDuCRjgNRmTC+xCWBkcEebZ7ZPmjKrL4c2VRG3MX6s2YNKCz6iDu20zxNCDbyFiAOd29d7+Y12PoPg6nnUyp2RvCFX7X0FBbiT724CK8o+Hzy5uQskq95X5C+6S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <71695765C21E1243B01B601B0493E383@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 546030fe-33cf-4b08-cdcc-08d5a3dfa4d8
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546030fe-33cf-4b08-cdcc-08d5a3dfa4d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2018 21:18:48.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0887
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 10:43:28PM +0200, Jiri Kosina wrote:
>On Mon, 16 Apr 2018, Sasha Levin wrote:
>
>> So I think that Linus's claim that users come first applies here as
>> well. If there's a user that cares about a particular feature being
>> broken, then we go ahead and fix his bug rather then ignoring him.
>
>So one extreme is fixing -stable *iff* users actually do report an issue.
>
>The other extreme is backporting everything that potentially looks like a
>potential fix of "something" (according to some arbitrary metric),
>pro-actively.
>
>The former voilates the "users first" rule, the latter has a very, very
>high risk of regressions.
>
>So this whole debate is about finding a compromise.
>
>My gut feeling always was that the statement in
>
>	Documentation/process/stable-kernel-rules.rst
>
>is very reasonable, but making the process way more "aggresive" when
>backporting patches is breaking much of its original spirit for me.

I agree that as an enterprise distro taking everything from -stable
isn't the best idea. Ideally you'd want to be close to the first
extreme you've mentioned and only take commits if customers are asking
you to do so.

I think that the rule we're trying to agree upon is the "It must fix
a real bug that bothers people".

I think that we can agree that it's impossible to expect every single
Linux user to go on LKML and complain about a bug he encountered, so the
rule quickly becomes "It must fix a real bug that can bother people".

My "aggressiveness" comes from the whole "bother" part: it doesn't have
to be critical, it doesn't have to cause data corruption, it doesn't
have to be a security issue. It's enough that the bug actually affects a
user in a way he didn't expect it to (if a user doesn't have
expectations, it would fall under the "This could be a problem..."
exception.

We can go into a discussion about what exactly "bothering" is, but on
the flip side, the whole -stable tag is just a way for folks to indicate
they want a given patch reviewed for stable, it's not actually a
guarantee of whether the patch will go in to -stable or not.=
