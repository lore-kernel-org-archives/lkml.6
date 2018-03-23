Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1821536-1521828042-2-9124584486732187541
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='hr', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521828041; b=qJ4GXOPAp7SBpQ7B/wk/gkIaTYnJHeNAM8t5q3qTp3HbDxz
    brzrPQVAvMw4c9ps1GM4SOErs2x0z/4x5BSdAN3U45cO74BCaO4nFm6iHtFhzy9Z
    vDaSMVY4o6Yrf6XwY31NLOAHNwHlJ8Scl566JXfaCpdQCDWz4HngFqkavku5LQUl
    /txhx+di3aihc0s3g3Hu5t5wE2DqD0pSdhYKfArqMOueVyLoTWm4WKVebh24RG1W
    dc+MTAAVVR1EV6cQFNQct+PV6/0xjv4wGqqRFREkxjAy7HIQkH9sovXR+UAkC3dt
    iLntFn7vZJR4To8rJozIvyqquG5VJC6lKYMJ3xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:references
    :mime-version:in-reply-to:subject:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521828041; bh=0
    x3QAt/5qCRjQ0faRfnZN1khF0EPczmfLPA3WTkCctQ=; b=BMtC4JvkC3pp0GrwM
    qzSL37VdbnY2qnKfKCjfnCRuegJ2sXxhuYAQPQFs3iO6r0kDrmCZGgeIIS1yYt/+
    WWGqUtxWXpPfqiK+RSA67gbSF4OdKha2JFJL9ZK/ZeRLRpCiInKzZFin0Pa1+3kF
    6oCRmS3TefOWjA8qa6hfa1Ho35We84cOFiUpYEKdPCDQhif+NX9IUrE4Q/Fy/vO5
    /kRNcErj6cs6qAGYQM/gpOUfKJL0YJDsdUqniOcP826tk2R1Ba4uivHtI1mIkOhY
    c3kwuCiB3LDIs4GZD2+CWVrUyXIzj3k+Hzy4hsZKLgAKi0eoowGPQYkGkAbPiJTW
    b4tmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=carnet.hr;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=carnet.hr header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 19:00:27 +0100
From: Valentin Vidic <Valentin.Vidic@CARNet.hr>
To: Marcus Wolf <marcus.wolf@smarthome-wolf.de>
Message-ID: <20180323180027.GM31333@gavran.carpriv.carnet.hr>
References: <20180323094725.4904-1-Valentin.Vidic@CARNet.hr>
 <d263c605-f652-fe24-2034-c699f2d27693@smarthome-wolf.de>
 <20180323114254.GL31333@gavran.carpriv.carnet.hr>
 <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9442615c-5606-328a-f8cc-ad389af55ee3@smarthome-wolf.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-SA-Exim-Connect-IP: 161.53.12.131
Subject: Re: [PATCH] staging: pi433: add descriptions for mutex locks
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
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
Cc: devel@driverdev.osuosl.org, Derek Robson <robsonde@gmail.com>,
 Michael Panzlaff <michael.panzlaff@fau.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Luca =?iso-8859-1?Q?S=F6the?= <luca@acul.me>, linux-kernel@vger.kernel.org,
 Marcin Ciupak <marcin.s.ciupak@gmail.com>,
 Marcus Wolf <linux@Wolf-Entwicklungen.de>,
 Simon =?iso-8859-1?Q?Sandstr=F6m?= <simon@nikanor.nu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 04:38:50PM +0100, Marcus Wolf wrote:
> I had no time to work on the code for monthes now and the memorisation
> of my thoughts when I was programming that (approx. one year ago) is
> quite pale.
> 
> As far as I remember, I read something, that the fifo has an integrated
> protection, so no external protection is needed. But absolutely unsure.
> 
> If I will find some time within the next days, I'll have a look at the
> code and try to recall.
> 
> But the most important thing already took place: We started thinking
> about it :-)

You are right, here is what kfifo.h says:

/*
 * Note about locking : There is no locking required until only * one reader
 * and one writer is using the fifo and no kfifo_reset() will be * called
 *  kfifo_reset_out() can be safely used, until it will be only called
 * in the reader thread.
 *  For multiple writer and one reader there is only a need to lock the writer.
 * And vice versa for only one writer and multiple reader there is only a need
 * to lock the reader.
 */

In the case of pi433 there is only one reader (pi433_tx_thread) and
there is no need for a lock there. But the char device (pi433_write)
might have multiple writers so we leave the mutex just in that function?

-- 
Valentin
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
