Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1542408-1521028215-2-14066357232297741008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521028215; b=aNbsPguAapmWGvTahV3o3VIvQr6glr53oi7umHVoYwl52wo
    2wn46SQUZ0/DgZLoHXH+FkPB3R4iARh6TossbNWiiCDwCrbZHMc2qy94pcN6hJIh
    W0Kmt3azyddutzyqhpDIPQlCS+pRwh3jttag0W571Qqayw/bRM37CSGDCvlpzjPf
    LX1YL6W9CaDjoD78HA2QSue6i4oYNgGU9Em22e9w0h5c9FHGDpvl1i+jLYa7SKy7
    5+W1W/08g/c1xKTD6IpK5/ygQkLVQEVLz9FD/Fu1X9u80NKkeBDKA1DWRAXrqAtr
    xR9qSZhqL/liCLbHNtWvusyhPuVbbW5x16cA9dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521028215; bh=O
    5/Ca1SBf5uy9jBeETJL6WjmOzHcnnM/W+odpybjTQQ=; b=IphR+y9h3az8Doh6h
    QBxvwFS/FQPMo80tpjo6af8svEBW1PX98nDEjJS9GNu8P4SyN+deu5dxGhlkBKp/
    ZUAyLhj1dneKHULVLZllgF9zUOAGHV9UhuKl53QH0dzMMJjsIkNBb24mw1JgmAyZ
    Si78K1uZw+RItXqvFwBCyLXVRxtWsevLdbuKbbc+UTMPiwP4Xcc59nTD1dc5NrLW
    +gqRJxwDyJAHQ+FH+IfYxru8MAfwx5kg8skYMpZI/K2hhPHoU2CezVfXE5fVRctq
    F3HnMWNqXb7foi9CRvfIcc+IPmZSMyx21e3TEOqFBnYAMBLYXd3tlwrk9LFTwXcH
    ZPZ8g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 11:50:00 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Message-ID: <20180314115000.GC27868@e107981-ln.cambridge.arm.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
 <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
 <KL1P15301MB0006B22926A4DC338BFEB78DBFD80@KL1P15301MB0006.APCP153.PROD.OUTLOOK.COM>
 <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <SG2P15301MB00158D30D602950F05F8B14ABFD20@SG2P15301MB0015.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "'olaf@aepfle.de'" <olaf@aepfle.de>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "'linux-pci@vger.kernel.org'" <linux-pci@vger.kernel.org>,
 "'jasowang@redhat.com'" <jasowang@redhat.com>,
 "'driverdev-devel@linuxdriverproject.org'"
 <driverdev-devel@linuxdriverproject.org>,
 "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
 "'stable@vger.kernel.org'" <stable@vger.kernel.org>,
 'Jack Morgenstein' <jackm@mellanox.com>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 "'apw@canonical.com'" <apw@canonical.com>,
 "'marcelo.cerri@canonical.com'" <marcelo.cerri@canonical.com>,
 "'bhelgaas@google.com'" <bhelgaas@google.com>,
 "'vkuznets@redhat.com'" <vkuznets@redhat.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 13, 2018 at 06:23:39PM +0000, Dexuan Cui wrote:

[...]

> Hi Lorenzo, Bjorn, and all,
> Do you need more ACKs? Currently Michael and Haiyang reviewed and ack'd 
> the patchset.
> 
> Should I send a v4 that just removes the "CC: stable@vger.kernel.org" tag
> for patches 1, 2, 4 and 5? I tend to avoid a v4 as I supppose it would be 
> easier if you just remove the tags if you belive it's necessary (IMHO all the
> 6 paches are not big and it would be great if we can have all of them in 
> the old stable kernels, but I respect your decision).

I think you need a v4 since for patches that are actually fixing a bug I
want a Fixes: tag added and I want them to be applicable independently
of other patches in the series. Send them in a separate series if you
prefer - I just want to make sure they apply independently.

As for marking patches for stable kernels, I do not think it is right
to send cosmetic churn to stable kernels anyway, at least that's my
reading of the policy.

You can easily post a v4 with patches reshuffled - I will apply them
accordingly.

Before re-posting please read this to improve formatting (I can do it
for you but while at it you can do it yourself):

https://marc.info/?l=linux-pci&m=150905742808166&w=2

Thanks,
Lorenzo
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
