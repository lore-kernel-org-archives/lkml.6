Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2510764-1520531902-2-10294442072119687323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520531902; b=Ok0bLubF1nBw8wD2D4USf77qkherIurRfSCK/nJhuEBnSP3
    6x1z88kF1h8Wgp6aX8SwdKUgan4zozxpDjcGjBrRVM40SfU1EGmWaCcK/2MrmX0H
    Rnyc6lEiGM1J+Z+zWloxeB4+6t7W3fMbsINs0InamliEtE7hJ3I/rRAeD9YaWu/R
    US4Zr5WYUiAgdkqSeR/GdFoxzF0w61RC7J9Hle0y6Allf6WzNqJjQFmo4jD5fg0m
    5CuyGRCRjCrcTeN7YBBLCltJeBLhQ0BMu/9DeQbGwlUS6Jz2lZj8wN7p1QgEBq8g
    9tvB4fUe7youUqJ5HUYjEn4bu+2ylnLJReYVqiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520531902; bh=S
    tgRaFKvlsTQxaBvZtk89L6ztMBvbZKafKoVmp/Ueag=; b=ZJIfCOeLq6NflS2QW
    74Z7Aj5j+A5hLfiC02BQbeMv+aJYew/e8S6D/fsXXsESKo+dHQFm8JJ4fHcT6+4Y
    Q2i5PLXOC9K+t0vCF4jvPeXyxamr2cTJ6VyTC+R4MQhaoVcrWXb+95l1pfMSXu6X
    7f5uqpHFfBHYMNDfl3cjQO9lXjiehvXLj55o0WL+OgqbzcvUVSmBaHyDMSYro6SN
    B3vVBCop9fgkkTH996tIWWNudNhoEE329YrL4QNGtIAjCqibZ+0zbHXTKhaF5tlq
    3MhAAZvlq48fVJptv2grOv8sdfKWa7+Now+PTtpoW7+wgQhe2qTEqyE0mx6B3Wyi
    CrZXw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 8 Mar 2018 09:58:16 -0800
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Ruxandra Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
Message-ID: <20180308175816.GA3906@kroah.com>
References: <20180306174348.26095-1-ruxandra.radulescu@nxp.com>
 <20180306174348.26095-6-ruxandra.radulescu@nxp.com>
 <HE1PR0402MB2700B47AD54FBA257C64932394D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <HE1PR0402MB2700B47AD54FBA257C64932394D90@HE1PR0402MB2700.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Roy Pledge <roy.pledge@nxp.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 06:32:00PM +0000, Ruxandra Ioana Ciocoi Radulescu wrote:
> > -----Original Message-----
> > From: Ruxandra Ioana Ciocoi Radulescu
> > Sent: Tuesday, March 6, 2018 7:44 PM
> > To: gregkh@linuxfoundation.org
> > Cc: devel@driverdev.osuosl.org; linux-kernel@vger.kernel.org; Roy Pledge
> > <roy.pledge@nxp.com>; Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > Subject: [PATCH 5/5] staging: fsl-mc/dpio: Remove dead code
> > 
> > Function qbman_pull_desc_set_token() is not used at all, so remove it.
> > 
> > Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
> > ---
> >  drivers/staging/fsl-mc/bus/dpio/qbman-portal.c | 5 -----
> >  1 file changed, 5 deletions(-)
>  
> Hi Greg,
> 
> Please ignore this patch, I've just noticed you already applied another
> patch with the same content a couple of hours ago.

Not a problem, now ignored :)

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
