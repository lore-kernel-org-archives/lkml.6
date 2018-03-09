Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3835922-1520576940-5-5128641608697095140
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='cc', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520576940; b=YI/YvWC3iuoN/93OO/UFvvMNr8CRl5CKB7nNtaRKCD0Ll44
    ffPsLPffqJfi/Ovp3UzEg3EMBFe7OGyIWn7Yov7PMptNCJVl1scvacWkMf9F6rwX
    NLG9L4TEntUFB3bS1crkMt7NapaXd4v7003pJVJuXMoZvdYoPEmR7Tti8udSDaB1
    qxQj2EaQeba4sj2ZlCL493+9UScnhU+TprMyNXdHLty8d18kRHteqjKxIuLbfEZz
    PmST5zYCYswsTLHXOpoaNJog/IPQ8xbChAbspyn0W5a2LTtaDVpR9S8rUnW80NOm
    AgXczsYyjOmoYiPf5M6NH2bFmJgFO0bgwiTl3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520576940; bh=A
    mu/vhFVfbl9jsEH2SkPWY3fNeFAhzVC2tB+gcZeDLo=; b=Nf0+FQWIVSHJSH0XL
    s7AB3ZMnvx5kohe7pp+5cbI+W06DiOJ/35o6S0K8kFTzcTKp7rmLQtTcmz3ArxOT
    DPLKIjh1IERq0scE9r3mxvIMcy5VG5zP2EkxFIeDseyfRgxJKQmXMsqYvGTT3Et1
    yhVZ2Zbc2FrVcHguCu69npMRL8oJsJMTgSpw+sEnI7uMbOtAE2OqtUYnX+VMeBsP
    W/qztv/GSthocU5PpWmuDjGMAAUs0uKp4UWmKbBqpINb7eawX91zc4Gh58r715tH
    SSlnohZDICZ3w5OXEB/dzftM2WylK6ATtHnkj5M72LMbOcb4CYZWPUcQGyxTcOdd
    wUyBw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/b7aBkz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=IxxRG6oq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/b7aBkz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=tobin.cc header.i=@tobin.cc header.b=IxxRG6oq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=fm2;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=tobin.cc;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-85 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=tobin.cc header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-ME-Sender: <xms:pSmiWsbhGI2l1-aeHaLNBmhhuOuwjgcadHkdOsfhG65Ll1gQq2z1Jw>
Date: Fri, 9 Mar 2018 17:28:50 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH 4/4] video: Remove stack VLA usage
Message-ID: <20180309062850.GD16734@eros>
References: <1520574625-4225-1-git-send-email-me@tobin.cc>
 <1520575267.11634.25.camel@perches.com>
 <20180309061152.r3yumh6agasyhtvo@cisco>
 <d99bbd46-8fed-b86f-c043-272ebc96e023@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d99bbd46-8fed-b86f-c043-272ebc96e023@embeddedor.com>
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
Cc: Tycho Andersen <tycho@tycho.ws>, driverdev-devel@linuxdriverproject.org,
 Kees Cook <keescook@chromium.org>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 12:16:21AM -0600, Gustavo A. R. Silva wrote:
> 
> I sent a patch for this six hours ago:
> 
> https://patchwork.kernel.org/patch/10268591/
> 
> --
> Gustavo

lol, I knew there would be a race on to fix these :)  And you got it
right, bonus points. Let's drop this one then.


thanks,
Tobin.
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
