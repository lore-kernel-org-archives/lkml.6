Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2139802-1521045134-2-12298939840425924563
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521045133; b=dZNXAPHaUxfxz6HuTYkfVaXT9ORSmOJqfBVBQubAVSj+6Nc
    cO1isSZZqYVRPVHl+9nEoHa/yO4kv2T6xyc6LU2XEdt/uWMdZCtu1fCT0ZMv8HXW
    Hcod5r1KM+qG/y9RziFaxU+Wk8s+27qGQlnRdhsxFsvXleKqbhudJMJEsuYRpV13
    U3RE17qsvqh9V2zNJcSOywi3jdIKCfNS23e8SxsL/5QIlSK4nRJ8zx4r8auHPGz9
    QtikpErjFBj957xOKE0vW6OU84w1PjUOY4lNpNVoTqorRsypOQj2GZhG0SXXqud6
    4sSfDZc4DRN88RnZNF5uroULlvYEpimwkI+7/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521045133; bh=W
    RFTG7IRTYhtHB7XVHPqfARbpK2WUVg1A82S+mfx+NI=; b=c65KH2asdAPtdSr/n
    kyj2tmXXcdriaN7i6AAWBh3ns16GDA53lFK68Erssljdqsud33B4K9RHBNqbR7Bn
    f/Tps6DqLvbYdE8TuOyz2LlY9/mxWw5AVuGbMs77nV1qlsfFCWd60xbJMhLZwcgE
    cXzmMpSjm/fgm+2a8mPq7i7Mf7HgR/8uRYTuLbnuNaSGLiSliTM0FbEmGAU466kI
    3E8JvW9kmsn1KrUjPktd2UYrzH2cFtvLluYs+3yTaCA+KiIrht5lo4WERhOB5pcP
    Qp6lTPrZ2Q1Be1Vp5yuRMNcP1NyWWeEsCE51K4q2sCYnarglNw8fB7gxWWZaKzD7
    fYB3g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 14 Mar 2018 17:32:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 47/47] staging: iio: remove iio-trig-bfin-timer driver
Message-ID: <20180314163207.GA4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-48-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-48-arnd@arndb.de>
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
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 14, 2018 at 04:36:00PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so the timer trigger
> driver is now obsolete. Since this is the last remaining iio trigger
> driver in staging, I'm removing the entire directory.
> 
> I'm not sure about the other staging iio drivers though: almost
> all of them are for Analog Devices devices like this one. They
> are likely used along with blackfin SoCs, but could easily be
> used on any others as well.
> 
> It might be time to consider whether they should be removed, but
> it doesn't feel like a decision that I should be making.

The IIO driver maintainer/developers are talking about that currently, I
think they have a plan for those other drivers.

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
