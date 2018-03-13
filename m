Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2567741-1520926886-3-13820298267176543925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES enes, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520926885; b=wb4uqJWgMAnh9jl5u2CSkJqiz8nGuj6o+gBAmbh0rzBH1St
    EP/ZtVr3z79eH2pI1L8PumjXS3nVHoyIlr9mTM2164RFHO9J06frAEsjyoHcxVYl
    3F6AHft7T5605KQt2jMZw28b4F61YiZZIaNznqd4Ljoe2NtyAfn0BPw/CmcG/4SO
    EoARF/0k7DBB4gROg6rPZ/OLWD5vkZWmeOeG0pJtRqvnd49oMyHz2gNRGPiH3gwK
    Hs+cQIGk4RTs1YM7bNyYZNpj8fnIUoZNBUx+vqxt7s8R+QrDQkNi6tu7K243iL1t
    RAtzSOAYyP4tfwwVO3Ggh08arYclGtZBb3b/Pow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520926885; bh=8
    Kgv0PzkJBAU+adHt67mroKf+9kiLgJSfup2XI8SOE0=; b=MdZimPZQjttKplIn8
    V8m7bRlUru/yNePPCHOQF4j6k1o+nKcwFg21gpM1pXgBRRZQF5YqtjESCqy9iN0p
    XBT2gpC+xWEFRDfDePBz8tKuZ0stMDU7KwtS35tjFFsRugKQObVZKUV9UsYp0j3r
    DVDLUMABFy9M4ZhW008HWurvjigE8EafgsFHLKSYdbL/runGlzUaNIUNPWfInTwU
    0KJTyAEfDcvUwrDZk8zDGuvVRAlxcr/azIUM29qXye6ATciOjQyD7x6aS7mUh4Jf
    ZEHl/1KZMNUmPsPU9gVQ/zB3m+0DSqZicA3POu/5/Wa4qRMPt+FAoTgjVbYJocI1
    BOUhw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-IronPort-AV: E=Sophos;i="5.47,464,1515481200"; d="scan'208";a="12256876"
Date: Tue, 13 Mar 2018 13:11:14 +0530
From: Ajay Singh <ajay.kathat@microchip.com>
To: <hariprasath.elango@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] staging: wilc1000: Destroy mutex object in
 deinitialization
Message-ID: <20180313131114.13ff73ce@ajaysk-VirtualBox>
In-Reply-To: <20180312131950.12854-1-hariprasath.elango@gmail.com>
References: <20180312131950.12854-1-hariprasath.elango@gmail.com>
Organization: Microchip Techonology
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
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
Cc: devel@driverdev.osuosl.org, vbabu3@visteon.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless@vger.kernel.org, Ganesh Krishna <ganesh.krishna@microchip.com>,
 aditya.shankar@microchip.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 12 Mar 2018 18:49:49 +0530
<hariprasath.elango@gmail.com> wrote:

> From: HariPrasath Elango <hariprasath.elango@gmail.com>
> 
> Destroy the mutex object that is initialized in wlan_init_locks()
> 
> Signed-off-by: HariPrasath Elango <hariprasath.elango@gmail.com>

Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>


Regards,
Ajay
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
