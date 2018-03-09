Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520575474-2-13268808630711191784
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520575474; b=oFlTwZWyN+1LasaLayWLqcw1M/IXz1yObrPiMQbH5O9pz3H
    bPWr5GFWDcj8gR1g1tT2iru+jZUxNe/aJqMl+VGMI80DNZyrcjrfO5ZrfzVPcIKx
    0sL1ULEzJg9/U9rwE7298rfo0B4zun49fZ0oUNsiLPx5l37Dba5jLq52lHeuMEH0
    AlPm18mk5ntdR0lMOlflPluhCgomJxDx6fhCyk6n/L211DelQiKqzkoK154SejMR
    kaILQ+N88Tw1fQQnYCm06L1H5EJaLSw31/SmyreBgbR+6K/vdHRcQjtr7rNDfvLE
    j7IbgDC4rZfnwBsBsjAh5sHtLhxTygz50jGXTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520575474; bh=i
    ImPiE5enLzhVgEqrj1Himrrwl2EggcjaHwWAYcYd4E=; b=mTgbVLCc5O0ckmaDS
    gk2YwlW/xxQGkDvfadHBDRgKb6G2T8oHUzg3WhRuwJSUQgxWBgLsfe3N0NgULbs1
    quPVbobXH2Q58vXyKzgLhYdYIrPtZiEdzRGZVFYFVuIfWtfQPWYB36wDywxPRshw
    M3snWrgnfuVMC76akAN8z5uIhqPEF/r1zL2Bw9RFlZ9OcyNH4VY3S84j1RRubz9F
    t2Rcd+ihGwE2eyryuaq44/ufcR5nyYX5tHwvq+EhunBZTOJJ9uhnmLL1xVarZL5s
    Cs+CrcI8Jma1Kg7JvVa2BmnnA2ro7dBZ8S/SDP/VzMI08AzO3Pa+R5MR/biFjecO
    MCcFA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixotD7jt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=KOFZQ5YB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixotD7jt x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=KOFZQ5YB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:6SOiWtHnY1p5-ePi_6RuS0DWJSEOOECrRa2HO6jbtLORrmYmiXheCg>
Date: Fri, 9 Mar 2018 17:04:22 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/4] video: Remove stack VLA usage
Message-ID: <20180309060422.GB16734@eros>
References: <1520574625-4225-1-git-send-email-me@tobin.cc>
 <1520575267.11634.25.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520575267.11634.25.camel@perches.com>
X-Mailer: Mutt 1.5.24 (2015-08-30)
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
Cc: Tycho Andersen <tycho@tycho.ws>, Kees Cook <keescook@chromium.org>,
 kernel-hardening@lists.openwall.com, driverdev-devel@linuxdriverproject.org,
 linux-kernel@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 10:01:07PM -0800, Joe Perches wrote:
> On Fri, 2018-03-09 at 16:50 +1100, Tobin C. Harding wrote:
> > The kernel would like to have all stack VLA usage removed[1].  The
> > arrays are fixed here (declared with a const variable) but they appear
> > like VLAs to the compiler.  We can use a pre-processor define to fix the
> > warning.  
> []
> > diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
> []
> > @@ -27,6 +27,9 @@
> >  
> >  static const char *name = "SiI 164 PanelLink Transmitter";
> >  
> > +/* check vendor id and device id */
> > +const u8 id[] = {0x01, 0x00, 0x06, 0x00};
> 
> It seems id is now global in multiple places.
> Perhaps these should be static.

woops, thanks Joe.  Will fix and re-spin.

> 
> > diff --git a/drivers/video/fbdev/via/via_aux_vt1631.c b/drivers/video/fbdev/via/via_aux_vt1631.c
> []
> > @@ -27,16 +27,19 @@
> >  
> >  static const char *name = "VT1631 LVDS Transmitter";
> >  
> > +/* check vendor id and device id */
> > +const u8 id[] = {0x06, 0x11, 0x91, 0x31}, len = ARRAY_SIZE(id);
> 
> etc...

thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
