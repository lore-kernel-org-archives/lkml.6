Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3600986-1520834760-2-3747007630084430613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520834760; b=oMWaItO5WAK4I1Iypq5Wt2JCTfu2tz6WY0ACBSzHAKnuzkz
    jL7EJUr7A+LY8mLRsus5H4jZVMDsmqgjR3S46UPIzLFy2RsbAPmn+WkT6x67il32
    OrjO8uRrWJ5Jr414Qj/iZZwuqb15dZTcZ0DmFGoBCchhMEuCNS9T+CZp08viYlLh
    emrQvORG7HpZW911LX9Dl9TblC07StSStLfbhSkjZly72+h4P+xH83BJQ4cFWMPh
    IYEi+h+9pUCJL5EjsvwLh3Y0OPLHtcsp/PGnQNVM/9ohvhvo/6fYq1JBr0v5tUmd
    SFRxXQOltaj+DC0x4B45j7v7jOi0wAbphnR5rCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520834760; bh=Y
    lprKfF9qpxD84ziaKtuQnV777F7q8wse2EUYI4JBBE=; b=CF4jQFurrVyEasksL
    St6CxnI/BPlcGsTxkEJpk9YttCnnCxrKTo9mCfedEXt7CADu+ghRahVhsbQdZ2Bd
    eyIGxTo7X7igJKQo9BsY/rRKXiF185TesgYhdpGE78xK1GuBOnw+K4eQn0gd0z4d
    wdXnDcVD/yPt+N0Wf9MNFor6i/egVPUWW0MdxCzYvGzYlr0wCpqQTX3sun8RAap5
    AtAyPEaUIZKIwtY6SUZ8/bfa4pEBxDlnysLVB9xoeYZNV0ODOZm7mlHv9J+Oktnt
    IdsC6qZNtVh3XjeXweEcWjLJxJWTHYQvt1i9yka1jJJsAOZgVxYJujbfeH/9fI2t
    dO5pw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pc7VveV8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=R6iD1m1C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pc7VveV8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=R6iD1m1C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:wBimWtAhdz-mcBcBavKggos44Pj178iMp-zQhwbzmgHydJvKjklSMg>
Date: Mon, 12 Mar 2018 17:05:49 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH v2] staging: vchiq_arm: Clear VLA warning
Message-ID: <20180312060549.GH8631@eros>
References: <1520818673-14084-1-git-send-email-me@tobin.cc>
 <20180312054613.GG8631@eros>
 <1166411830.411906.1520834284931@email.1und1.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1166411830.411906.1520834284931@email.1und1.de>
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
 kernel-hardening@lists.openwall.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 12, 2018 at 06:58:04AM +0100, Stefan Wahren wrote:
> Hi Tobin,
> =

> > "Tobin C. Harding" <me@tobin.cc> hat am 12. M=E4rz 2018 um 06:46 geschr=
ieben:
> > =

> > =

> > On Mon, Mar 12, 2018 at 12:37:53PM +1100, Tobin C. Harding wrote:
> > > The kernel would like to have all stack VLA usage removed[1].  The ar=
ray
> > > here is fixed (declared with a const variable) but it appears like a =
VLA
> > > to the compiler.  Also, currently we are putting 768 bytes on the
> > > stack.  This function is only called on the error path so performance=
 is
> > > not critical, let's just allocate the memory instead of using the
> > > stack.  This saves stack space and removes the VLA build warning.
> > > =

> > > kmalloc a buffer for dumping state instead of using the stack.
> > > =

> > > [1]: https://lkml.org/lkml/2018/3/7/621
> > > =

> > > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > > ---
> > =

> > Drop this please, leaks memory.
> =

> except from the leak, did you test this patch on a RPi?

No I didn't, but I can have a go at it.  Will try before doing v3.

thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
