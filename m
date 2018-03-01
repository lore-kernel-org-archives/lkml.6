Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3347819-1519921922-2-8568476876910153007
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519921921; b=GQS63FsZMChseFVwBiIvTjJ4KhT364LE2LK+e09TFf7qh8N
    om4e4cP1+mHgnwtxnjN8CU/uNiBYAsAtrvShWLgmjWQXpZA5sdlESTmo/j2nJWl9
    h/MjDASy0TiGnCMvIydQOyd3ZREbrQotyPLvC6wWvY6yy1X349IDzEMqXvfQZMKH
    /BpCJUjg1dEcyJAQjqFjUCKK9F/zhZ8vZ80dO/QRUBQ9d3oef5E1LReQqGeo0NTO
    iM8qPu5VRTY8Zu4vU8GrJaiHS5QFpxjFyz0dMsjgk5KT9WmuYHbHayY27DrrGUOX
    Oz66UxsY+EX+jmfATdXhDaiqnYpDq2m37NrgUkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1519921921; bh=s
    VjOs5WgT4CWZyuJNS+5ug1ie4ozu9hdFRqedWpezZk=; b=e3VFUBS5dl68CLTT4
    gYaC/mHL/CRoBWP0MiK0siJAXFNrOndQ90FMpUbR6LkotMMDZbjjcR9GKSgvxRNs
    FEJFMLohp5Oj/5drGEEBGKKmu2y++9WEmf65XrraBtw5kaRh8SZR0dZUFfoyVoKU
    +MP9aARYjjg7xCYFgmgBWz/lY+Lo+KRbfr8gZAEN6Ga0zRQ5dsWU91oh03KJpYCQ
    r89tuLRuoJEX87j2862zjLgvCiBCb/sURJJGujgzU83Me9TLmzkvthTCnsgK4QbO
    9tVCPkTX1v+0n3Y12A4UJkVqTCk6C8hZlYO2iXGt1sPkBSFkNqCkHTd+GXVS7+Xx
    MoRxg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 1 Mar 2018 17:31:52 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Subject: Re: [PATCH 4/4] staging: fsl-dpaa2/eth: allow the driver to compile
 multi-arch
Message-ID: <20180301163152.GA2675@kroah.com>
References: <20180226162807.20649-1-ruxandra.radulescu@nxp.com>
 <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180226162807.20649-5-ruxandra.radulescu@nxp.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
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
Cc: devel@driverdev.osuosl.org, roy.pledge@nxp.com, laurentiu.tudor@nxp.com,
 bogdan.purcareata@nxp.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 10:28:07AM -0600, Ioana Radulescu wrote:
> Drop dependency on ARCH_LAYERSCAPE (which in turn depends on ARM64),
> thus allowing this driver to compile on all architectures supported
> by the fsl-mc bus driver.
> 
> This was compile tested on:
>  - powerpc (corenet_basic_defconfig, ppc64_defconfig)
>  - x86 (i386_defconfig, x86_64_defconfig, needs CONFIG_OF)
>  - arm64 (defconfig)

Seems you need to compile it on more things, based on the kbuild
warnings :(

Please fix up and resend.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
