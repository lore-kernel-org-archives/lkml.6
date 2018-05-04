Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-4122073-1525428505-2-2145673119408322253
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525428504; b=KE8PCydlMCBkAt/2I3EryWL3kXvaZZ93h/ZldDYY7UNKSM+sDz
    3uuW5OFgfMJdkoPkdPF3RKv5fteG6mNuX7uEHRr3AuTKCSM03XNdaeMrjBs1x40G
    2MTjsGtreJkTeDxruDcZA7+JHXZZ6hKhJCC04Rbs54jExO7TDMeI24ls+eidaUXf
    XbSYkB86yvj9ZsjeqDQAt70lR3BvQzK5Zn3zbekIsWJ++4i95LPdyZqQd7le0yC+
    PwN5Rm84c/TXzHLcTa6YLafENVrgnD6hbUklhtOK2WaiuuEn7XbEO/xtAHL+46M6
    cfmMsWl7wlEC+cMieM80SLlguC0PlkX3exAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:content-id:mime-version:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:content-type:content-transfer-encoding
    :sender; s=fm2; t=1525428504; bh=6cAGV+yj2lomJkXSx81z9FhYFdQWHrR
    ANLdLSroQxU0=; b=nTu79nUnq15sUKl34tDXZjaWdIeJtcMqBO8rpJlpS43a7GJ
    WHtpY1po7RK2WQlQCBjUK+oGkR6wu3VNzRY7+kz4K3V5xJuaxDZauBCvQZs1musr
    +QB2RrhTMaPyeocOiKj2Q92vyirXxH2w+g6Ah53IuhG6EaFYT2qtItqI+0mpsOvj
    uDUbOmGAMkNKBtJwJqfF5ZfNra7nIYd2hgirw2j4Gpxdhj7e6b5JQA4zWY5pIZN6
    MHqejZiUfnHpdM5dlCIi9XxD+hXkvVqm/3LGrqjft7lBiIDf6DgWptaoDNf6i7OF
    baP7ecAOzkGWaLkX3UAXwn4cvkZxhmzQ1z0x0MQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=intel.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=intel.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBThRMetaMdr/4fXl7PzV2GCCcvVPShVmI0sR/r4du5J1Tz8WnkJBUTq9p78MvYf2bjD6oBbrnU8FqQtzbtSnYny6I9XvVtbstHASXR0XiCTxNhgFp6E
    +kdZWI2PZTqTbp8OY3UMlaGsLXLIIBafpOR1IQh1cCmjmpPZh/Uy/OPHsKlKBjwo2FyERRx+H1ozYTWsB4SQZeJCqjb9sfyyJZGKC0UUl7g2TtHC1IjBFxia
    XyXuUmMn1v9709UBSvyQGg==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=AycjEXJFu3AA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yPCof4ZbAAAA:8
    a=DDOyTI_5AAAA:8 a=Nc1dX3T1R-t8jicA0-gA:9 a=kPaySrfXZj64AwFt:21
    a=mFS0S7k70lu5bD5Q:21 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400"; d="scan'208";a="225738080"
From: "Dilger, Andreas" <andreas.dilger@intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Subject: Re: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Thread-Topic: [PATCH v2] staging: lustre: llite: fix potential missing-check
 bug when copying lumv
Thread-Index: AQHT4NZ/GvK7CQDrfEibHz/EWOxvVaQbBW2AgARseICAAGFnAA==
Date: Fri, 4 May 2018 10:08:16 +0000
Message-ID: <7185D89D-A0FE-4B55-B089-9AF0891A00BF@intel.com>
References: <1525128971-8946-1-git-send-email-wang6495@umn.edu>
 <20180501084621.jfxrm3qoqfmftnxh@mwanda>
 <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
In-Reply-To: <CAAa=b7dHK9grwfFLOpVv=Wpv32mLS66CxXJDHOzNBNaqsWLXaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.137.157]
Content-ID: <FA118DC446889F4292535D4946A995BC@intel.com>
MIME-Version: 1.0
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Aastha Gupta <aastha.gupta4104@gmail.com>,
 Roman Storozhenko <romeusmeister@gmail.com>, Jeff Layton <jlayton@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 NeilBrown <neilb@suse.com>, open list <linux-kernel@vger.kernel.org>, "Drokin,
 Oleg" <oleg.drokin@intel.com>, Dan Carpenter <dan.carpenter@oracle.com>,
 "moderated list:STAGING - LUSTRE PARALLEL FILESYSTEM"
 <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On May 3, 2018, at 22:19, Wenwen Wang <wang6495@umn.edu> wrote:
> 
> On Tue, May 1, 2018 at 3:46 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>> On Mon, Apr 30, 2018 at 05:56:10PM -0500, Wenwen Wang wrote:
>>> However, given that the user data resides in the user space, a malicious
>>> user-space process can race to change the data between the two copies. By
>>> doing so, the attacker can provide a data with an inconsistent version,
>>> e.g., v1 version + v3 data. This can lead to logical errors in the
>>> following execution in ll_dir_setstripe(), which performs different actions
>>> according to the version specified by the field lmm_magic.
>> 
>> This part is misleading.  The fix is to improve readability and make
>> static checkers happy.  You're over dramatizing it to make people think
>> it has a security impact when it doesn't.
>> 
>> If the user wants to specify v1 data they can just say that on the first
>> read.  They don't need to do funny tricks and race between the two
>> reads.  It's allowed.
>> 
>> In other words this allows the user to do something in a very
>> complicated way which they are already allowed to do in a very simple
>> straight forward way.
>> 
>> regards,
>> dan carpenter
> 
> Thanks for your comment, Dan! How about this:
> 
> However, given that the user data resides in the user space, a
> malicious user-space process can race to change the data between the
> two copies. By doing so, the attacker can provide a data with an
> inconsistent version, e.g., v1 version + v3 data. The current kernel
> can handle such inconsistent data. But, it may pose a potential
> security risk for future implementations. Also, to improve code
> readability and make static analysis tools happy, which will warn
> about read-verify-re-read type bugs, this issue should be fixed.

There is nothing preventing the user from using struct lov_mds_md_v3 but
filling in lmm_magic = LOV_MAGIC_V1 from the beginning, no need for a race.

Cheers, Andreas
--
Andreas Dilger
Lustre Principal Architect
Intel Corporation







_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
