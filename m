Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3641714-1526633621-2-14512709684144177529
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
    1526633620; b=IOO43+4RFVpgG7HoljyLTx7ZT8jSG7FPsCr2HaAC+zDRsa4yNt
    ckjaoP0D9fKkpn1Kvzu6OPLxRAWGiSyP7Whzc0+iEQzJEQx9uYXOq2+md2Ih82m0
    yDnk12upzRd9mKiVngFGQS+z2xtzhqme5hiI/fqldcxptCrYdaJMxbMbV4P37lcP
    GsEDWkzE4VF3cNgNC5LlmRFURnr6+U7J0MV5PrFJm/G7QQAmAV+A+yUWS94axjCL
    HyT1vYMdvNitltPPfr1mlzlhT1VoScn+79aPx2fvJl5EmeX56riOLqIP9i8i90TV
    /kZxV5X7ekAze7s9aFIlNc8aVrmV0J20O5uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526633620; bh=pcamI
    HYn0lkM4+TfoEOO6xco6sBIg9Fo9KgSsh5+B7g=; b=IYGBVCsU37i6e8XHwFeF/
    3GtzDZFrVhWsMZanFg+8bAw9HHTpQqwuYbSrOUb2wedXuTc2wpqRwbjI1AlT/r38
    tThH2xnQjzB0bRDLHFqShPTEihOSQnHgBQcac45NvQobHaHwdlUPdr48XHcfwG+u
    acYHNVvFmluVjHmLetJAy/7vZ5xFly/yncvTzFYp1w0xXLQGVZfTubouNbbkQkvc
    kim9DF9awNFwUkA2er7QA5dSQEgSw0GBRKx0Vb/QOAjBWc2nJwvhYVppWcX2NTBg
    wwTLHD1Pa7ARVZUM1jqmHbacM7G25SnO7Rh/hIaHXYq2YrKPPM0DoSZhlRosXxW2
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfDmvt4uqGinEhxtT1yau7hEmOyccGvR/spYf929QPJA9rAcqOV1KnizOqApneyzm3EWDtYedYErmMrZ9TvnypmddC9681xr8h9TW2bzvjIwEgGCrzbSh
    HNqW7vyM/2XKfjxMjc50f7Ky2b5wxjsDQv3Q+2XX1vzQd0UAcM7dB81bJ1rgxubQn7GPW7fzjVib2M+VCUMIPgK9Uh31fRY2KbiyXrbMehG6lccGh85scnCN
    YExbha7vsKbeROMSP7oriQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=43JM2Wx153st-Z4jn8wA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 18 May 2018 10:58:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 38/42] isdn: replace ->proc_fops with ->proc_show
Message-ID: <20180518085812.GB24387@lst.de>
References: <20180516094346.20506-1-hch@lst.de>
 <20180516094346.20506-39-hch@lst.de>
 <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4e7091873e8a220c454a7ce5a3f52edc5b5c3e3a.camel@tiscali.nl>
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

On Fri, May 18, 2018 at 10:43:46AM +0200, Paul Bolle wrote:
> >  	iif->ctr.release_appl  = gigaset_release_appl;
> >  	iif->ctr.send_message  = gigaset_send_message;
> > -	iif->ctr.procinfo      = gigaset_procinfo;
> 
> Is this intentional? You didn't touch the procinfo method in the other ISDN
> drivers, as far as I can see.
> 
> (If it was intentional, gigaset_procinfo() can of course be removed.)

Already fixed in the branch in Als tree.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
