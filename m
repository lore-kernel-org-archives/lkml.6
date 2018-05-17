Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1627028-1526539081-2-17971459696429822361
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526539080; b=QM8O3JrZJyDl1Z2A4MJe/gMG7nhAZD7UmuuoIMnodbWNRgSK2o
    GBatLe6KFVUlQtZtsA26fQA5JAakCqlj3MB1e2U8Pi/0RiiMIYbAL7Oj/GeUcWEl
    czmbFihIl4efF8ugC2nw7Cjll2B6/WmkSrFifwonHUTj72PXqdCIiWf9V5Yr72IK
    U985Q9HQZdFbfMmEE0YXx613PAhbNAWaP95KV2bEOVBhfuxw4nZrvw32lPC8Fu+Y
    89ufzSAEgQj5RLWDhCVuCkAl+C+3nFu7lJ2msIDkWmZvSTQ2SgO73lTdcU80IFC2
    7kM2EBAqwfUk/q+JW+M6i6LudR4asPvboaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526539080; bh=eIpLB
    r57bEfrd9MQiXSWzXCbTSI8lBQsiW7urMFu7L4=; b=fAthFcFwx9kLAtEWMcEnW
    GUXvARGhOJACpDYGfWyynGbYt5WcUHV2NFLqyg6AVxr8wlkSSp0kKE4w6Pl7UUV3
    RrdRcwjhFLw+HE864eCpcQwNRSYrtqcftnJ0UFumTYziPmZFG0HqE5t9mBmuqrKY
    Jb08WtsfRsWTh6Z9S6BJjJSvbsd8VeiacVUfrn87li/MnuvV9m+iQhtt1zgBpDdc
    Td7zAsdh7Kqj0/5NXfCFXYyzDJb3AtmLGfpV5WrB4TvT3YtviHeGua3fP0f7BIL2
    ViB8EhumwwC2FpADiZyIufkRESDp5mKaOMXHsr34CPgUSRWTkVNxlvHRiy99VeQa
    A==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=lst.de header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=lst.de header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPiZXusC9XASEW7zDTpOX6nBZEIGOZam597OdJ2LvdAOBfoLWpgsWnTp3/z3Qh+riv0wrnogoJHK/DE7qxT+RhL4wz8XRqQywCWyEA+JoJOnUHOErLOn
    bYmWYIDO2Rl8eHjk2b4UHJc6Uh299yCr716E/P0z8movvUcK/dS/OHgNx6E/jWqx/vXYiLeYIm8GJsQFvVcE3A5RXLHjjacl/8RT7R9EMNzK4mslsFtYRAeN
    3/59B/UA2aHZVjCY86F7qQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=d4prKydncGK4iAAgHXAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 17 May 2018 08:42:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 11/40] ipv6/flowlabel: simplify pid namespace lookup
Message-ID: <20180517064220.GA24300@lst.de>
References: <20180425154827.32251-1-hch@lst.de>
 <20180425154827.32251-12-hch@lst.de> <878t8y46sy.fsf@xmission.com>
 <20180515145643.GA661@lst.de> <871seakg0u.fsf@xmission.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <871seakg0u.fsf@xmission.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
 linux-afs@lists.infradead.org, linux-scsi@vger.kernel.org,
 linux-ide@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-acpi@vger.kernel.org,
 netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jiri Slaby <jslaby@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, megaraidlinux.pdl@broadcom.com,
 drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 17, 2018 at 12:28:01AM -0500, Eric W. Biederman wrote:
> > struct pid_namespace *proc_pid_namespace(struct inode *inode)
> > {
> > 	// maybe warn on for s_magic not on procfs??
> > 	return inode->i_sb->s_fs_info;
> > }
> 
> That should work.  Ideally out of line for the proc_fs.h version.
> Basically it should be a cousin of PDE_DATA.

The version in Al's tree is inline and without the warning as
I didn't want to drag in the magic.h include.  Please look at it for
additional comments, I can send incremental fixups if needed.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
