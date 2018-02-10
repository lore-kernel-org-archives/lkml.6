Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-308045-1518284497-2-127054020484405672
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518284497; b=EIi/xYdBlS2jg1KHffxjuFu9TS0cYdUGOXxZZv0FHKHtqNw
    8qITGl6plKqlFuSPscJ8+T0BaPOq2rEFFX0GWA5FmO3q+L061m5T7HWA3YhIf2Pe
    NHZ+HSXMEqjZJ6l/4dmmyPaksznrd/bnU9t34inSWMYfu7dC1eQLgyo+7P4JOhqJ
    jzdYioeVNVIqA7Jgn1i4K8R5EmEfq5/l/niL8uFinB8zxGVvybDsHnM7LmEPuYO9
    CK4yl6fLNUwy0P+7LzEXxv+ng0Z6zYkwhtWxF7MvqZPLSje4P6E+i9GHTgOE/aeN
    aB7NNWAnqKZrCaDCOBgnZShnKgEoQhdGpPo+sZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:subject:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518284497; bh=c
    J6pzDhxd0zL9fi5B721tXI7UptVCeTr/dgyLkPpJnc=; b=pWZAy8bXMZmQCKolb
    eI9Zkbc4oomC9mjjDLaH1QXJlC03yYkTtoYU47eR+EkTK90HX3VJ1XzzDNZF9tP4
    BZ/UFnLoAsfeXkhP41ixgnQel7qonil2VxFMJibC7w67be91vp+k2v/1Q4QKldRq
    wvqHoM89Q/JrQSvu94maZzBOtrIvk6kegXJK2GzeQ3JZFtjXmSDC4rcRRh3tdIDf
    T23M9aRSDQ8pYKhlP+EFZ+yrRxW82TA1WjA9I3QTXbeVM8zkF3PmNHPHIr31TIVu
    ghrMEDBEjSgvhbPSGyuHHOxoDlOlNSD14pF80rOSIxLrKkG8Gt3o19RndmPxGdNX
    goBPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=i2se.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 10 Feb 2018 18:35:01 +0100 (CET)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Eric Anholt <eric@anholt.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>
Message-ID: <1423690308.146028.1518284101597@email.1und1.de>
In-Reply-To: <20180202150225.314435-1-arnd@arndb.de>
References: <20180202150225.314435-1-arnd@arndb.de>
Subject: Re: [PATCH] staging: vc04_services: merge vchiq_kern_lib.c into
 vchiq_arm.c
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev21
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K0:EtIT8N8PlodsrO2KclE93aCjWm3P4iMIH8jmf9YTGMBLMBWFDUq
 fV1P4lj9LQk3oj2xDp7xms2YSlWoh4hVEN9VjBY8HdfHMLXpyJ34IiV68iiLk7EQija0/hR
 GAMrKFma5viHZ6xXnn9quylon0VRs4Dl1vu7DjkyLnrRaNlPtYnk/9aVJq4nnd9Kpc39LxZ
 +iMgfR5ZKkx3LU/Ee1RtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:a33prFpjwDQ=:OsKy2ywLQT5tO4bfO13uKn
 k4rSTkOInBy4lz984x/GXK8DmO3/Ar38lijxw2ALKWb9iuIanWVmm/i8JQp66/JX/yQ4MrX1L
 urmhfSTIIzQ02wgRBRX2QS+XZf7vYwZDdLEDZ3eQM+yWCZhwZm6axAHAWIZDXIrXbXWt0FR1f
 MHV4eZ6y15ePyMLoF4vCtneGbjk+3z42YOZ4asZV2d1MmtiWykmPpH/hxtwUt9xPfbz2HvQLy
 Cx5TAB4UkqaSdHlsxPcekF4G1O2+/suC11YPWHmdIA0GTaDMgBz6a5D1VsKXJEA15iXPiLrja
 OQA6vXdo46gvtK8e/YEB76iBbzkP7gDGkMYN17ixG52SNoaSwAG/XKRvWZxvoW+N83DaheMPE
 ku4PMMj/E9A2lAbB4E/JeS3VWrn2Rh0kSniavTaNHw8GpDkQlcfms/FTaC/idRvePHvYNJrNG
 ylfDoVlx/6eICxWwrzFvxpFUH2bNA9xJjMdwjovMgUj57jKCE4LkbbImMIfiQOMWcgqsuK7iT
 lugRVPtPDpfLAbiUZA7VhRf83yRLcmgbRqHvIieLpcF6anzgSOqFZn4X8jwAFd+WoOTdX8PI7
 puegc6zPzLPc4U26RBS9x9lmn6/F/L6ARGsCsjLAoB8vljOdV7T60rYaTlAy29rzNiMz+CplL
 N5vd6oOnZBx7tkQ7oL+Y8yukQMy4oexYlb25lCQkHHeQooiGxPNXLVDIFJusaBFAHF2Dn3ORb
 qA6RHR5XEcISkADRvuW9vjn+3LNYtgnlu70gOM1/aPn4uV8CjTWVUJ/Mngdz7mFPYQPjCw8ml
 1z2pX+j91xg3I4hz6oAXOkLxA9fYzt8lr9DkoJ9mGoU+49yo/deGKRSXbt56+l8N6abvH3TDu
 RnYQlXqT1osJHvFwpfOq3/V/xP4At4wxU/iTPFWzmhdS+wbJkYlyfsWVKHeBBNB5dC1Pyf+FA
 3pgEgjyaaiw==
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
Cc: devel@driverdev.osuosl.org, Andi Kleen <ak@linux.intel.com>,
 Mikhail Shvetsov <lameli67@gmail.com>, Nicolas Pitre <nico@linaro.org>,
 Yamanappagouda Patil <goudapatilk@gmail.com>, phil@raspberrypi.org,
 linux-kernel@vger.kernel.org, Michael Zoran <mzoran@crowfest.net>,
 linux-rpi-kernel@lists.infradead.org,
 simran singhal <singhalsimran0@gmail.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> Arnd Bergmann <arnd@arndb.de> hat am 2. Februar 2018 um 16:01 geschrieben:
> 
> 
> There are two incompatible definitions of 'vchiq_instance_struct', so
> passing them through vchiq_initialise(), vchiq_connect() or another
> such interface is broken, as shown by building the driver with link-time
> optimizations:
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:129:0: error: type of 'vchiq_initialise' does not match original declaration [-Werror=lto-type-mismatch]
>  extern VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *pinstance);
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: 'vchiq_initialise' was previously declared here
>  VCHIQ_STATUS_T vchiq_initialise(VCHIQ_INSTANCE_T *instance_out)
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:68:0: note: code may be misoptimized unless -fno-strict-aliasing is used
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_if.h:131:0: error: type of 'vchiq_connect' does not match original declaration [-Werror=lto-type-mismatch]
>  extern VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance);
> 
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_kern_lib.c:168:0: note: 'vchiq_connect' was previously declared here
>  VCHIQ_STATUS_T vchiq_connect(VCHIQ_INSTANCE_T instance)
> 
> It's possible that only one of the two sides actually access the members,
> but it's clear that they need to agree on the layout. The easiest way
> to achieve this appears to be to merge the two files into one. I tried
> moving the structure definition into a shared header first, but ended
> up running into too many interdependencies that way.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
