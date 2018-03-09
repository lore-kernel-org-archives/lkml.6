Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520576309-2-5336907845720139673
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='ws', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520576308; b=B5vZxjlQsgF8PDyoJOlooT8nY5OXTaLXEbFnd4udYsMlra0
    NckuwVXQSwE5CNNIc7dTnM7sk5DvF056aK5/9phX4ehtMg0SB2EL/22o7+lxoFt4
    GlLGg+D1yqOX8LrFT8b1g4VEwhR1UAMfhxmI7mClb3uzxaeLKMkfQ/6n/xEINrfR
    ShD+TfP2yiEuyzpWjThSa13gUmzkbS4xgghdn9JGxcgpllWXvOTGCu8W2vfar1yG
    nBXpn3rjIwmM5gKp5CXzWQyG2Z7oN5J8/UaxyhZoVeHwPB5sSpgq3W0orMQ6inVO
    3VC/W6pc9+S36a5n/wfMbQi+5yAp0KFQNMI0RAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520576308; bh=b
    /6QdyiouO03jWAgadO9g0WykuV1dHKKGUZlvr0c5Kc=; b=BQG++aGp4xfSDm75F
    nrBNLK4rAvGemCjN+6m5kFayfalD6kwdqlgjzTfvdsAhydmiJ6rGRsEchhU4d3qI
    /UUexlQ1PZRmYFO2ZLtqma2HnpgVELy9XH0YB9zw2NfyIBBA3rPCydUdUfy6lRLU
    Q0/Os+Fcco+C0GHRhQZubnUMnaVku5RIuONsnmSxSNcfiXARZ6Kf4AS26YJ5yUqH
    RXqiuvlNa/sZFhvKcsiCnQNKtDuK0hKtZhpPyDhmZ6S/E3tPGLJCq3yaFKF7dj2U
    AzJXCEQgTBTXqpu5Y6U8KnD3wUiczzi+fQ85ANtDHcHo5BQT48Dm25Q6ctzQ7UKY
    EKwsQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=CMKqNs0e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-80 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rP9M7ZQB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b=CMKqNs0e x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tycho.ws;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-80 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rP9M7ZQB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tycho.ws header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AG47ELvn9FA60kqwmDKfC5yzsTTuXdw3/nE+j4J6sZqkSeRL2zFXwF76CHoTNaDutWjZYapziFdp+w==
Date: Thu, 8 Mar 2018 23:11:52 -0700
From: Tycho Andersen <tycho@tycho.ws>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/4] video: Remove stack VLA usage
Message-ID: <20180309061152.r3yumh6agasyhtvo@cisco>
References: <1520574625-4225-1-git-send-email-me@tobin.cc>
 <1520575267.11634.25.camel@perches.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1520575267.11634.25.camel@perches.com>
User-Agent: NeoMutt/20170609 (1.8.3)
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
Cc: Kees Cook <keescook@chromium.org>, kernel-hardening@lists.openwall.com,
 driverdev-devel@linuxdriverproject.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 linux-kernel@vger.kernel.org,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
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

Does it even need to be global? Why not just get rid of the indirection and use
ARRAY_SIZE where we mean it? This seems to work for me,

diff --git a/drivers/video/fbdev/via/via_aux_sii164.c b/drivers/video/fbdev/via/via_aux_sii164.c
index ca1b35f033b1..87db6c98d680 100644
--- a/drivers/video/fbdev/via/via_aux_sii164.c
+++ b/drivers/video/fbdev/via/via_aux_sii164.c
@@ -35,10 +35,10 @@ static void probe(struct via_aux_bus *bus, u8 addr)
                .addr   =       addr,
                .name   =       name};
        /* check vendor id and device id */
-       const u8 id[] = {0x01, 0x00, 0x06, 0x00}, len = ARRAY_SIZE(id);
-       u8 tmp[len];
+       const u8 id[] = {0x01, 0x00, 0x06, 0x00};
+       u8 tmp[ARRAY_SIZE(id)];
 
-       if (!via_aux_read(&drv, 0x00, tmp, len) || memcmp(id, tmp, len))
+       if (!via_aux_read(&drv, 0x00, tmp, sizeof(tmp)) || memcmp(id, tmp, sizeof(tmp)))
                return;
 
        printk(KERN_INFO "viafb: Found %s at address 0x%x\n", name, addr);

Cheers,

Tycho
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
