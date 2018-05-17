Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1451110-1526534898-2-12054209466569675134
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526534897; b=DLbS4vvnUip9BRB610kKoRZ32huMWceVlHuVKytE2SS1nsVzlK
    OdX/IomwYl3REB+7iZ/OygMn0M0qN6XuZi6C0Zn9jJto3xNVoBGtkHtG3waP4JsG
    OzJ/TGSl4sT0DgcYwse+mhu4Y+fNjyUNdXmf54gKi32s/pgjlQw1lnXYTsdT09z+
    i4wK4Sf2afGb70OLwzTGrOtwIsvw1Sad+K6usflkWn5CiRtVo5lDzqr4Pa5Fhyrg
    JJdF+40J4TAFXbuoFdYeJC9pFwxFFFxPPm1uaGfYqiMXWI1cTDsTCmTG+IDyL3oi
    XKYaaRNcck0sXS5zp5gPGFqvI/vou7tUPPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:references:date:in-reply-to
    :message-id:mime-version:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526534897; bh=ekweS
    VywEYYxYPzvf97JcdcUF6481yPLp0YvQumUNkI=; b=i8n2Mn812i75P1g5CSC8n
    MvUCxNJzIxdgbBb4XIIHGwWqLGhUrV9R4YSnl08n41WYBCGUYrTd9w2vnXrY5z5t
    trgbd/z1TAbMZglkyS3baPZ9NBee53DSwVE802cUleZ777M9nfrG4uUSIalKjuMe
    z/y6AoeY5xY05fKRWllJXw6e5/LMr2jbjUxhRUzaVmmvdvAV/FjKpiibXBrs5Zg8
    PlDTnDQv2HVP0QIK4C8e7IEiTnFQQvoCEwHAaWKioi7z4nO8KG9dwprjhnzS2zTw
    VgQU2NSYFc3ppZrGEDPqYgvQpD3U3gNdmUPVX78QI46fxyt20LOxFpieBvA7wgj2
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xmission.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=xmission.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGV/Vh6gtrRbNT5rX1aCUcfZr5UUepF121qE5TtSRs9LtrJ4jFf6FoXR3o5xUDGXShfaoJ4iJXIdECoVvwAaDGtPYHl6cTSIG99wCdqPFyDxnT1D+fSn
    QkJr/dzBD4/aRJjdUktY+AVQJteG6GNVDRk6LjQFPUpYSzOnXGohndPGVF6YcQpxrHdFR9ozvuwq06GedZgHvS3i/g+C6HTuF68C2db/71+jcWeeYmsyTi/e
    Z+MPLCQ8uzUopyYwQO/45w==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=pGW4Ed5uNc8UqAy1h_kA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: ebiederm@xmission.com (Eric W. Biederman)
To: Christoph Hellwig <hch@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
 <20180515145643.GA661@lst.de>
Date: Thu, 17 May 2018 00:28:01 -0500
In-Reply-To: <20180515145643.GA661@lst.de> (Christoph Hellwig's message of
 "Tue, 15 May 2018 16:56:43 +0200")
Message-ID: <871seakg0u.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1fJBSR-0003ei-0F; ; ; mid=<871seakg0u.fsf@xmission.com>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=97.90.247.198; ; ; frm=ebiederm@xmission.com;
 ; ; spf=neutral
X-XM-AID: U2FsdGVkX1/dtToXGcZsoUEWNIqZwycweV/Sdu9hoiY=
X-SA-Exim-Connect-IP: 97.90.247.198
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Remote-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Remote-Spam-Combo: **;Christoph Hellwig <hch@lst.de>
X-Remote-Spam-Relay-Country: 
X-Remote-Spam-Timing: total 208 ms - load_scoreonly_sql: 0.03 (0.0%),
 signal_user_changed: 3.3 (1.6%), b_tie_ro: 2.4 (1.2%), parse: 1.01 (0.5%),
 extract_message_metadata: 12 (5.6%), get_uri_detail_list: 1.57 (0.8%),
 tests_pri_-1000: 6 (3.1%), tests_pri_-950: 1.14 (0.5%), tests_pri_-900: 0.99
 (0.5%), tests_pri_-400: 23 (11.0%), check_bayes: 22 (10.4%), b_tokenize: 7
 (3.3%), b_tok_get_all: 7 (3.5%), b_comp_prob: 2.00 (1.0%), b_tok_touch_all:
 3.3 (1.6%), b_finish: 0.67 (0.3%), tests_pri_0: 153 (73.8%),
 check_dkim_signature: 0.47 (0.2%), check_dkim_adsp: 2.9 (1.4%),
 tests_pri_500: 4.4 (2.1%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
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

> On Sat, May 05, 2018 at 07:37:33AM -0500, Eric W. Biederman wrote:
>> Christoph Hellwig <hch@lst.de> writes:
>> 
>> > The shole seq_file sequence already operates under a single RCU lock pair,
>> > so move the pid namespace lookup into it, and stop grabbing a reference
>> > and remove all kinds of boilerplate code.
>> 
>> This is wrong.
>> 
>> Move task_active_pid_ns(current) from open to seq_start actually means
>> that the results if you pass this proc file between callers the results
>> will change.  So this breaks file descriptor passing.
>> 
>> Open is a bad place to access current.  In the middle of read/write is
>> broken.
>> 
>> 
>> In this particular instance looking up the pid namespace with
>> task_active_pid_ns was a personal brain fart.  What the code should be
>> doing (with an appropriate helper) is:
>> 
>> struct pid_namespace *pid_ns = inode->i_sb->s_fs_info;
>> 
>> Because each mount of proc is bound to a pid namespace.  Looking up the
>> pid namespace from the super_block is a much better way to go.
>
> What do you have in mind for the helper?  For now I've thrown it in
> opencoded into my working tree, but I'd be glad to add a helper.
>
> struct pid_namespace *proc_pid_namespace(struct inode *inode)
> {
> 	// maybe warn on for s_magic not on procfs??
> 	return inode->i_sb->s_fs_info;
> }

That should work.  Ideally out of line for the proc_fs.h version.
Basically it should be a cousin of PDE_DATA.

Eric

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
