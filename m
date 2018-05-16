Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-67064-1526464707-2-1684230761310165048
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526464706; b=WRj+0Qrzu1yRwiz0FMIwvXEwe7udUE81MNxwpT4UB46dZFefQs
    RVNgWEbvi0nfah9EphXJm83tOaoBbge+JLqOr4gSO4dkQ1nFaag1Z07NIAVOrRdd
    nucuATn2zbhHoj8f6LFsk9kgiHF/KI54maCf7vZUexm2nBdCAej3c6QErmeb29Hm
    Qpsk8TGUtl3tJKwsBLOodNHADRHRo2tAHB3pgFPICY38/nPpL11+BKTht+R14fyQ
    KGXJgmfhMMZUGQaQbEYRHH6mYzYrf4IwhBGmaNP2TMv+e9EPYKmAVlxVXDQlfqsk
    lNTreoralbx528zzvwwUhAVudVG140zKcoAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526464706; bh=AkDBt
    qD5RXgkrjpIRjfA1YTkBIu744VamuDULZomxKE=; b=IKMl1BmVeoiY0NXG26Lh6
    vgdxTG/YyKFjGJn6GMLg2Wb4AWjScz0SDmh41R9zy5Q669kewNM5FZenB+5FU0Gw
    tlmD3m97aiZaB6vW4gMGD0mXUvsR5Pig1QBm9tsV9hfGy4eZ5FOk8DOO9gXuVRve
    Fkx5ZsVL3AcMfVD4LFv5m4LHexWUKZllqKAuqFK+ZncokJdIWX48lenKo+HeiamS
    nvhGTfy0MMt5bfPNxe/I0KSqEZckrjfiRfvub1jzt+Wt71gxTvbBcYPg0vrGopwF
    XBEIbhYtA2xtJdqmpCN9ZQYH5YH29/zceY9yc6Z7F8uBdkafl9xhIY2mOpe6ulAx
    A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=GeEXPUB2 x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=GeEXPUB2 x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNGX5Qs6IceNAf4m3mNPa87dqVLDtqB42QDP0eX9Ot294e1C2yqiM5OcG12T1iw7ijgVqXYk7H/4rLQj7uJj/2cG5qS/DyYrG4x7inxQjQg4zuEcHdfK
    KvmiLPD7Y9BVmRWOS8Ll5RvS424wog0Ppe/Fv+zAR20AjuWKQxx3gvcqm+Lxk0LfrSAigmYhITVijDdaX8DOfV2Gh4Yh51H+MBq0hMn11Px1StorgH0a6Rdj
    s6IK1LJkpXh3rOKemekUqA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ag1SF4gXAAAA:8 a=DDOyTI_5AAAA:8
    a=PYk8P741THD3M-PRQncA:9 a=CjuIK1q_8ugA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 16 May 2018 11:58:02 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 41/42] tty: replace ->proc_fops with ->proc_show
Message-ID: <20180516095802.GA16090@kroah.com>
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-42-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180516094346.20506-42-hch@lst.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
 linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 megaraidlinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 Alexey Dobriyan <adobriyan@gmail.com>, linux-ide@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 16, 2018 at 11:43:45AM +0200, Christoph Hellwig wrote:
> Just set up the show callback in the tty_operations, and use
> proc_create_single_data to create the file without additional
> boilerplace code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
