Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1574763-1521159340-2-4374433704311690262
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='ch', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521159340; b=RWlbfwckeK7YC5hyQ6+ILouPfLSIcvcosQVP9oLybs1tPYj
    Mu5h4FI/pzqrdEMPBA7M7+V9MuLq5xFd8UuAfBnChU/el8fv1WAKyVeZeGZJr/tM
    S0oRROmLLbK779+SDr1zKT3LO9Jw5TBccIJRbctUPP/xfCC4xjOkp29mdviZCsSQ
    NtqFQeJKJQGHq6dppe7SSofFjB/dfmx3BGHo6YNCtMWE+z+rOlaLBMOMmLPEm7Ml
    NVG5adhkvSTCsvYuIeruLWMI21p+lb/EuiXHh0ZAg/hZFIZJedY9k/7UjDqk3SF0
    qT6muUjxfdZ7Vxp5dT5FrgVYCfP2sa7u3th71nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521159340; bh=9
    4ayK4Yav7O1yqm1SUEAegwock07J9oPH/uFP3aZ34k=; b=r/gVbJ1+d298CmgIn
    3s1p8JvSTN0Ftkp29ZmIXROgDD76alNXYUjDsgbuSeYffH8b9p8C1EFnVWqB7adi
    wEil9Nq7YwYuOwKHRRjCsBD3osNFqmh+ckLfhHfS/XweQkn05cNG9rwm6IdqAgzx
    fGWx29pMauBm8+FskYx8AaJ+8FAaw3lGiI4e5B2fI/h3Sn+hpHrgyHVgXN1JJbGu
    sGdgUP6O+uyBPoOO6VsNGZMLjFeRK5li7gPBqk+iShnXjQZnFapTFeECvN0R56Ta
    xWCyuXAAkAlYXmEqWouMp/XYPhudXeP98f9d8B2e0Lc7zZKaVG8b9YB4D8s9vmMu
    frw9Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JvaW2ZQZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=lunn.ch header.i=@lunn.ch header.b=JvaW2ZQZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=20171124;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lunn.ch;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lunn.ch header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 16 Mar 2018 01:15:21 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 0/6] staging: Introduce DPAA2 Ethernet Switch driver
Message-ID: <20180316001521.GA13119@lunn.ch>
References: <20180314155558.6898-1-razvan.stefanescu@nxp.com>
 <20180314234437.GD16379@lunn.ch>
 <20180315105642.szn2zhrsgwsv35yf@mwanda>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180315105642.szn2zhrsgwsv35yf@mwanda>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: devel@driverdev.osuosl.org, stuyoder@gmail.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, alexandru.marginean@nxp.com, agraf@suse.de,
 linux-kernel@vger.kernel.org, Razvan Stefanescu <razvan.stefanescu@nxp.com>,
 ioana.ciornei@nxp.com, netdev@vger.kernel.org, laurentiu.tudor@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 01:56:42PM +0300, Dan Carpenter wrote:
> On Thu, Mar 15, 2018 at 12:44:37AM +0100, Andrew Lunn wrote:
> > On Wed, Mar 14, 2018 at 10:55:52AM -0500, Razvan Stefanescu wrote:
> > > This patchset introduces the Ethernet Switch Driver for Freescale/NXP SoCs
> > > with DPAA2 (DataPath Acceleration Architecture v2). The driver manages
> > > switch objects discovered on the fsl-mc bus. A description of the driver
> > > can be found in the associated README file.
> > 
> > Hi Greg
> > 
> > This code has much better quality than the usual stuff in staging. I
> > see no reason not to merge it. 
> 
> Yeah.  It seems pretty decent.  Stuart, Laurentiu, care to comment?
> 
> Meanwhile, netdev and DaveM aren't even on the CC list and they're the
> ones to ultimately decide.

The patches are for staging, so it is GregKH who decides at this
point, not really DaveM.

       Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
