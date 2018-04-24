Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3158210-1524579703-2-4017432761644618160
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524579702; b=r4b8hFOETQvqAu7gR02PpyVf2BnolCM8K0tljV+GBWP4fWxtZN
    qzwbWG0t44Wox8bsSNahrpImRC37pudA9bubNJJhnWS6sYX5q+IGmQHgTdFpWjuO
    Jdk5Dfbd2TvoqeaATD5uGv/IfhwiXq/keSy6rprN9pQ2kEs75hnLewL+cahcII2K
    zh8SI6AahsGenVwr5njbw9gs9BVUrgUaxPx6d3iYF+hmGBYtI6xXHCVZEGznTDn5
    B47mOURygSk7ruiYSH0uCLTWnl4LTQVFlCRcFC5nuPWLXfQJTB1PJEOrJJmyJmav
    O8yzdXnUpg72/r6myCmtKpMezCYC2ZQE+Lpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524579702; bh=+eKPZ
    fGUnEgcloqoB/ifAU3xUG1ODFbN3jLUtizJKjM=; b=rUc+ELzB3uaZUXgLrIZPJ
    r0IaviHU4TKdd4aWgRHcyJiklXcIPApvfnASjaNJ8QmRwfN2ClSjh7nA/cYGsNuT
    Jo7S9ay9K6lxd25TS1w3f92Gsl4xGMXQDAEz7n3amQoubLkLx8YgSA5kSpcia+15
    G73pyg97GqBAGora6Ly2MjVUWpmteblPI4aY2EEthrYX5RrAHJr7eI3IXB/8TFX5
    Hm0jceBjYM6b6yfrJE207K9i4RDV9RYcGAPN337QTMueaJclx7ujX4olOcZwdLAx
    Sme5RL4Sn+yJhxJEUixdwriW7iBdeKpURRe7QKX3XSVgognt0Myh6kSLX0oL1/ce
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lst.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHWGPr2l6Ns+7lnp0TrD/jY7T0dVWV1FYcMZVor3HbZDrhPg2yLrIn5mRrkOaLEiaUD3GZX7S46jzRvrIXw8tuLVWOIQ1BEHC2o0TPVVlQr1Wq74HqoH
    +YywQMeGakMHNmYZR+RVZ8d+gbf+TEqEiksgtyMQxy5Hw28+T0PoL5cljm0NuxvZTrUERcGnTTRZPPoBblsIuB/5TzHMAUI1PRLQ93M4WX2FLrQz6EtMxV4N
    SdgK38uSraImG+jFPC0QYQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=yjP-KMLsiVDQ3MBg87kA:9 a=CjuIK1q_8ugA:10 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 24 Apr 2018 16:23:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: simplify procfs code for seq_file instances
Message-ID: <20180424142304.GE26136@lst.de>
References: <20180419124140.9309-1-hch@lst.de> <20180419185750.GD2066@avx2>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180419185750.GD2066@avx2>
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
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 Corey Minyard <minyard@acm.org>, linux-ide@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 jfs-discussion@lists.sourceforge.net, linux-afs@lists.infradead.org,
 linux-acpi@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jiri Slaby <jslaby@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 megaraidlinux.pdl@broadcom.com, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 09:57:50PM +0300, Alexey Dobriyan wrote:
> >     git://git.infradead.org/users/hch/misc.git proc_create
> 
> 
> I want to ask if it is time to start using poorman function overloading
> with _b_c_e(). There are millions of allocation functions for example,
> all slightly difference, and people will add more. Seeing /proc interfaces
> doubled like this is painful.

Function overloading is totally unacceptable.

And I very much disagree with a tradeoff that keeps 5000 lines of 
code vs a few new helpers.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
