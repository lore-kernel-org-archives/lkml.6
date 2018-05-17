Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2600153-1526584527-2-6840814796387557027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526584527; b=Rw7jYqlX3TDNd7MLiM9Vco96kXWBOlsWsY8HtwVL/vJ68B8Dr9
    DlGRqpzfVkL9xNXnrh6jpZRreWxBMYNHX5Rs8X3wfGpzaxb0F/T2kURTltEptTD/
    WlKosmzJadxCDjn/MsuS5K1CgO5ViPJ5tN/Qg9lRt1u/qkoTl5s8PbYxqdOO5Rkc
    zwVdAA4Xz/zU3UQ4Ps0kh8zLq5qXRjIqYwUMRMJ8e4B6eUdXOYitHf36sGbfdOJP
    yPCxpsbD1XhOapg9pronffpK9pAEJxn+p8vNfPS9775P9NGWWXbR3W+5YFquunIz
    w+ge2TvQziANT1M4CFhCyQ7W8pfHAFHgYpkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526584527; bh=4qUSQ
    vD/oXgYBzybr1l5d8I23nJ2nOwLWwoJB7HUpnw=; b=gAQmYLTLdmm2xthWLebSj
    30m2y0dsYQAJsilz8NDQGY/Tfte+kfF3YZJFoDR6XW/N5jQv3C85Yuo4LSZn6R9O
    119QHghGhdENvGB/WxxsOEvWKjm0DtOW5WeXksaeFZuRfAWw6vHybxJSZkDH2CtZ
    CV7zyrZGS941+zMbNTHZIXJst3ECnfBwLMZ8yMrWNnkGW2qFs3EEt0CHmmmN9mIj
    Y5EL1t+9jW+T7BpvMFO5fSkl/YObXh3BksCGsWL6U5mOju8ii5khKDgwZAT/+Jlg
    aWw7M/TyWDJ9e2Q1Rs8kr+5RsRpUT5gBLvC6nO9z6auasAaPEyx9yAah78tY7Rso
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOvyUd+uC6U83csOchYVwfk1dQJpqU/rSLPbP6MHLMqMf+/pVeYW/FEi2MgASY8+0HyQXksc2lXby0WKw074D58sS/Ou5Y0Rw0yz5cKJYzzJQvXXIf0R
    h9MBDl8M9+tfGU4YlE87icaXanGJSRz8EM3/wNuwGUSaIk4ilM1ntqvyB5FiSojT57A4DlFVIeDjNxJHNmaeZd+t4e6sVpGW89ElwFqSofkT6d7LTcpK+Brq
    LKjCxOMT0Njqc9iIxaEPPA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=85S4E89k5U9McCT6XL4A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
 <20180515145643.GA661@lst.de> <871seakg0u.fsf@xmission.com>
 <20180517064220.GA24300@lst.de>
Date: Thu, 17 May 2018 14:14:57 -0500
In-Reply-To: <20180517064220.GA24300@lst.de> (Christoph Hellwig's message of
 "Thu, 17 May 2018 08:42:20 +0200")
Message-ID: <87efiahz66.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fJOMj-0004AX-Sj; ; ; mid=<87efiahz66.fsf@xmission.com>; ; ;
 hst=in02.mta.xmission.com; ; ; ip=97.90.247.198; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/CxGTRCbzfgEjI52abMIIM5ZVh0LOd1tI=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;Christoph Hellwig <hch@lst.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 684 ms - load_scoreonly_sql: 0.03 (0.0%),
 signal_user_changed: 2.5 (0.4%), b_tie_ro: 1.76 (0.3%), parse: 0.74 (0.1%),
 extract_message_metadata: 9 (1.3%), get_uri_detail_list: 0.58 (0.1%),
 tests_pri_-1000: 5 (0.8%), tests_pri_-950: 1.17 (0.2%), tests_pri_-900: 1.02
 (0.1%), tests_pri_-400: 28 (4.1%), check_bayes: 27 (3.9%), b_tokenize: 6
 (0.9%), b_tok_get_all: 8 (1.1%), b_comp_prob: 1.73 (0.3%), b_tok_touch_all:
 10 (1.5%), b_finish: 0.60 (0.1%), tests_pri_0: 117 (17.1%),
 check_dkim_signature: 0.46 (0.1%), check_dkim_adsp: 2.7 (0.4%),
 tests_pri_500: 517 (75.6%), poll_dns_idle: 512 (74.8%), rewrite_mail: 0.00
 (0.0%)
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
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
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, May 17, 2018 at 12:28:01AM -0500, Eric W. Biederman wrote:
>> > struct pid_namespace *proc_pid_namespace(struct inode *inode)
>> > {
>> > 	// maybe warn on for s_magic not on procfs??
>> > 	return inode->i_sb->s_fs_info;
>> > }
>> 
>> That should work.  Ideally out of line for the proc_fs.h version.
>> Basically it should be a cousin of PDE_DATA.
>
> The version in Al's tree is inline and without the warning as
> I didn't want to drag in the magic.h include.  Please look at it for
> additional comments, I can send incremental fixups if needed.

Sounds good.

Eric

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
