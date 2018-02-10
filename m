Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-627691-1518296264-2-8711057536000427838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518296263; b=jm8dMR2KRKCB2KHkwdtGja/30XGS/W3ha1Swtsgv/e1Oapc
    +BNx+RuB9402vKobrnH07fXlwZq4xfYFEDxFzcvaMHok/1e4fY3tSNiDOUP33HwI
    HrmaDNb9/TcLfTrycYpHcm59BjItblspkZFkSgbGpvgDjrEfoLkfLs57JQY2zwxa
    Gw4vEIDDbisJu+BW0+BHfKjfbCWugOBKAC04FstMuPZjqxNXOnYgt6TwupmHhht6
    4+l03MMgHcfLaaRHeLjuY8vr6yS4xL9PezQUXzlBs0dVDrKdjIDoiAVu9Q7SalOh
    3OolqE2FmaDGnomKw+bgchhGl3dXV7uex4dJQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:content-type:list-id
    :list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:cc:sender; s=arctest; t=1518296263; bh=IAUpSHO11
    8H3TiNcXFA91Ctz3V6BAcJB5+UocS2iAQ0=; b=Zhnx17i7s4eus/aVHFsiHEGW7
    zoR7J8SvILjKTwKrUkxNHAUq1gHlaEsOncO18+aedgkSmNrc3ttAwN3qoRQsAGHk
    53ZaghIHRSRygoLITjTmohJSH4M42Iv03rz0dQusgxq7DMqwAcSiWr6mlB/oNfDH
    pO6hst95sqtskLFkTg1nEkUpoxqnc4QTScAbpBp5JcCGrMIApfpFX2ItNfd4lpSA
    q9sEb5+xXZqQ5WZ3iezHtb96ssl3XArM7Ok4x8RwI8ijf62wn7kU5QwzPHKxGQsg
    kSE9JUNUOG4y1yKKV/PWr/Eosu0HPKftXhbX3sb06QdKY+KTwl0zvNTvohnWg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Dt6kmtbq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=Dt6kmtbq x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Sat, 10 Feb 2018 20:57:11 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Oleg Drokin <oleg.drokin@intel.com>
Subject: Re: [lustre-devel] [PATCH 41/80] staging: lustre: lmv: separate
 master object with master stripe
In-Reply-To: <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
Message-ID: <alpine.LFD.2.21.1802102027560.5700@casper.infradead.org>
References: <1471378773-24590-1-git-send-email-jsimmons@infradead.org>
 <1471378773-24590-42-git-send-email-jsimmons@infradead.org>
 <87r2pvkkl5.fsf@notabene.neil.brown.name>
 <09CE6CEC-52BC-4B29-B609-40DE68A64A33@intel.com>
 <87o9kylux7.fsf@notabene.neil.brown.name>
 <FC7E817D-BA15-4D0A-9976-F1343F9B022A@intel.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="1985284609-1082420824-1518296232=:5700"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180210_205712_139075_B7FF22DE 
X-CRM114-Status: GOOD (  22.77  )
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 NeilBrown <neilb@suse.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 wang di <di.wang@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1985284609-1082420824-1518296232=:5700
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT


> > On Feb 8, 2018, at 10:10 PM, NeilBrown <neilb@suse.com> wrote:
> > 
> > On Thu, Feb 08 2018, Oleg Drokin wrote:
> > 
> >>> On Feb 8, 2018, at 8:39 PM, NeilBrown <neilb@suse.com> wrote:
> >>> 
> >>> On Tue, Aug 16 2016, James Simmons wrote:
> >> 
> >> my that’s an old patch
> >> 
> >>> 
> > ...
> >>> 
> >>> Whoever converted it to "!strcmp()" inverted the condition.  This is a
> >>> perfect example of why I absolutely *loathe* the "!strcmp()" construct!!
> >>> 
> >>> This causes many tests in the 'sanity' test suite to return
> >>> -ENOMEM (that had me puzzled for a while!!).
> >> 
> >> huh? I am not seeing anything of the sort and I was running sanity
> >> all the time until a recent pause (but going to resume).
> > 
> > That does surprised me - I reproduce it every time.
> > I have two VMs running a SLE12-SP2 kernel with patches from
> > lustre-release applied.  These are servers. They have 2 3G virtual disks
> > each.
> > I have two over VMs running current mainline.  These are clients.
> > 
> > I guess your 'recent pause' included between v4.15-rc1 (8e55b6fd0660)
> > and v4.15-rc6 (a93639090a27) - a full month when lustre wouldn't work at
> > all :-(
> 
> More than that, but I am pretty sure James Simmons is running tests all the time too
> (he has a different config, I only have tcp).

Yes I have been testing and haven't encountered this problem. Let me try 
the fix you pointed out. 
 
> > Do you have a list of requested cleanups?  I would find that to be
> > useful.
> 
> As Greg would tell you, “if you don’t know what needs to be done,
> let’s just remove the whole thing from staging now”.
> 
> I assume you saw drivers/staging/lustre/TODO already, it’s only partially done.

Actually the complete list is at :

https://jira.hpdd.intel.com/browse/LU-9679

I need to move that to our TODO list. Sorry I have been short on cycles.

--1985284609-1082420824-1518296232=:5700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--1985284609-1082420824-1518296232=:5700--
