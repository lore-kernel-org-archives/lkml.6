Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3387646-1524150604-2-10760668383958383040
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
    1524150603; b=avM3E6WBLfNnM0+QtRW6H7/blMLY2wKDB6dEJEAQ+2W0pIlRjx
    ylpQxhh35DbN+Zfop87/9iQdKmXTVOBLc7BmOndaWhRxS6cYaV7nX4TM/ZIQIg4M
    rgrhxHEWEvyRfw8nZ3phr450d2Y6se0Ahr4tiwv6J6PF5r7n/Z2aeRvnvoUVBDZv
    qY15s6VGoOvanhCOmov7RCCoIoyT/56o69mMpGTeN3eW+oA4jhnF17sUp0WcC/XU
    qIKwfiP69dYxah6a7whsW87zZaoL1x4pG9+l3aV2wnTSYtWxwU63I0E9mBLlYDKY
    X7+kwb9fV/vF5aHb7gdLfNIMCQONUroj0+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=fm2;
    t=1524150603; bh=P2hxJ9sNdMLX4vMkJFR54VRuVKfdYydb/3nPHoRjGsw=; b=
    mvBAVsfivnJKyQbgMTSAnaEsXCkUfT4NA0GUCMBrYq+7jpW7r/a/W3E4Lj4PorcH
    9W2QLrUjRdc9Yd6/cWz/DFD+x1YmwMFfFGyKz9iIbjpsvOUccpXQDb0YfKpWEGl1
    jFD1x4X377r0IQpyIViGl06rY4WaBwLwBmTQFR3oAiE9z8m55JH6lFQBg0f6TIhm
    FJcflC/hqLlTEcnBuEoqDA2jYoOeDHh0wNRX1YdQSI9+ZSfcKJBhWangPkBNVE9z
    Daj+2eCGaCZ5a02mUqaasdRTzhSC2bym367qGMP+oj0lf7UX7VpQmJ9AtrkjxvjH
    7VjbJNx0mmB29e8dSschOA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wn7AS6ek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Wn7AS6ek x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJ1b8hI6/YkTnaZjVsBq5zkkAyx3PgwRtmx4MRqAhdG6vENh1UI+vVna1KQrkUOvxOfB/BnaZsY4vohKFtL+7qjwm2LutjUyf6f4iMax+bkXpk2HJOqW
    iXWyYzCrjX3sdE1gjEREeO/ZmC3U/TRhOGAxADKsH1kOkV6K8sLqU8YAfVL1dx7r9gARALRerbvUZp918v1iXYsLVtQpxFqzQxyUnSZOV8LoIYAAmfgzBB7L
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=F7qjIGpQ-GgA:10 a=kj9zAlcOel0A:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=eG5LCA3_yZqg6JBFOH0A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbeDSPKB (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:10:01 -0400
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:64544
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751070AbeDSPJ7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 19 Apr 2018 11:09:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: Thomas Backlund <tmb@mageia.org>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Thread-Index: AQHTz5h7IvK2v80d0k6VVqDoPwJEM6P4GK8AgAnYKwCAAX5DAIAAHfKAgAAFIICAAAchAIAAAugAgAAB5YCABGlsgIAAJpuAgAASFQCAAAGHAA==
Date: Thu, 19 Apr 2018 15:09:56 +0000
Message-ID: <20180419150954.GC2341@sasha-vm>
References: <20180415144248.GP2341@sasha-vm>
 <20180416093058.6edca0bb@gandalf.local.home>
 <CA+55aFysLTQN8qRu=nuKttGBZzfQq=BpJBH+TMdgLJR7bgRGYg@mail.gmail.com>
 <20180416113629.2474ae74@gandalf.local.home> <20180416160200.GY2341@sasha-vm>
 <20180416121224.2138b806@gandalf.local.home> <20180416161911.GA2341@sasha-vm>
 <7d5de770-aee7-ef71-3582-5354c38fc176@mageia.org>
 <20180419135943.GC16862@kroah.com>
 <6425991f-7d7f-b1f9-ba37-3212a01ad6cf@mageia.org>
In-Reply-To: <6425991f-7d7f-b1f9-ba37-3212a01ad6cf@mageia.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:zGC9cPNvA55K4BLC9yhDlodJzG8swcQrOFLzS7PRdCNCiy0/1PiI9T4ZyrJVR+uJonG1UUmqJVUOe2WPH6vlmWQ3/WL4AV9KRCrQVS1+a5Mx9dk+bx/7XxK+aIdHL9ceCcNmo+pcd+PKyT62R5r27idAAxmt937XjrX80SpwhKowH77+DbvGX/QnvE3qHTXm807YkQDaN7lVoQJc2PJ6z/fMAZDzzoePeW0521XXOaltFVmsPZlHRCJVVkQa2SAM;20:pkVM3OJDObIw6ba0JZKgpxkhlAZbYSOrborBcyJuuMLrH69BGJTNv2RU2NgstB/WEERbNIE4YJligx0Zq0bD/kcvXVg+F1Fc+ukW3vIIJyfIqz8vVkk2HObmraMSh/hrEKnrj9XRZNYSgup5m+w8laa7KaTsVh/k7U7zLbcDEQQ=
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885EE6D33DA66FB4E8A4745FBB50@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231232)(944501383)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0647963F84
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(396003)(376002)(39860400002)(39380400002)(52314003)(51444003)(86362001)(76176011)(229853002)(316002)(54906003)(1076002)(33716001)(14454004)(3846002)(93886005)(6916009)(86612001)(33656002)(22452003)(66066001)(186003)(2900100001)(6116002)(72206003)(4326008)(3660700001)(9686003)(99286004)(2906002)(446003)(8936002)(476003)(11346002)(25786009)(7416002)(10290500003)(81166006)(478600001)(6512007)(53936002)(5250100002)(10090500001)(59450400001)(6506007)(8676002)(102836004)(7736002)(33896004)(305945005)(39060400002)(26005)(6486002)(6436002)(6246003)(3280700002)(5660300001)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
x-microsoft-antispam-message-info: Gzfhoz3VvCtR4BZGsPEnJoUCdwsyWkTbYm2k0mBYExdvFeE7BczvBqmy5f+9HTPWDAx+gCfA5NWUe84Y0Y+3Eoyr+FLA+oPHpaatvQerRKaryoCNRGFmi5/OZ0PZr3t5S89k+xtd04rgq9Sf+eFrD84GWqTvbx4pYMTCA+cXyxeCN+ja4B9TXtKAwgJqsYo5
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A71313D467590E4DBDC77A56E2945198@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 79233c04-b75f-4aa6-a34b-08d5a6079cdc
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79233c04-b75f-4aa6-a34b-08d5a6079cdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2018 15:09:56.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 06:04:26PM +0300, Thomas Backlund wrote:
>Den 19.04.2018 kl. 16:59, skrev Greg KH:
>>Anyway, we are trying not to do this, but it does, and will,
>>occasionally happen.  Look, we just did that for one platform for
>>4.9.94!  And the key to all of this is good testing, which we are now
>>doing, and hopefully you are also doing as well.
>
>Yeah, but having to test stuff with known breakages is no fun, so we=20
>try to avoid that

Known breakages are easier to deal with than unknown ones :)

I think that that "bug compatability" is basically a policy on *which*
regressions you'll see vs *if* you'll see a regression.

We'll never pull in a commit that introduces a bug but doesn't fix
another one, right? So if you have to deal with a regression anyway,
might as well deal with a regression that is also seen on mainline, so
that when you upgrade your stable kernel you'll keep the same set of
regressions to deal with.=
