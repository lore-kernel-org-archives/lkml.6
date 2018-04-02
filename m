Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2757645-1522669278-2-13534150840788886892
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='de', MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522669277; b=tXANeJLlKYd5i386VhEUOb4e67jRifdctCgHKkYJ6hbuoNw59a
    MGRmZYrnJLTaTf1jLPn1zwGEUehHE4TO2BYhDENU9ZmeJDEB1KWwWcxLiZL6OpZ7
    4YPhnqZDSbqvLIn0AMhfhXSTPzx9J4FFMFfCjsBDGWOupLFNEzrX7G+P3dTIWQco
    KD3kv1AL2TjJgihdqRw4/KZVLVNmB0lzwt1lb0v7tGyBks2izlqzZHK5s11bErs3
    5vXaIWWPPpqff4KJ81fVfrFxCyAx9wlrE2MjV2hWHDiZlawX+wJ6Uu/uAMWlPBof
    0Tdpzt2j2S4d/bZnzNZ/oa42E1h2T23oZWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522669277; bh=+6JZZ
    WOBbyBkq/4ZQXhGKBeqUqyrmPTd1Fd//phZ58E=; b=pNevvbnQ6Mkj0M4mm54nL
    TlMJqaV3nPmhn06qH5opiMQR46Dywm4aWUuyTmaiaecI1vtM6tZteTugU25nGLFk
    vr1Tnx6Ha8XdQjf9QkuCzzia+vGQP+loP1xkvofy9KNgEKi+P/VRmW8qZyThq88U
    9to0cSa6RTYLjlX/u/Nu//yu7sYEfx4oz9Ox6PFLRSrfwGBMUIkWnqMqpirqPQ15
    0RpEUGi430tcRpr4Gb1Bw4U9dbw1kTzuravVW7xPANBV/dICr6WfoygnHCDhXlCx
    IMNEkdls0/YxZoOyb5xtJGvX3mTOCPJHXVKZopaLjsE2HquMQKpV945rnVOpRV4Q
    g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lkamp.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lkamp.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lkamp.de;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=lkamp.de header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEC6aMbNY+JaPm+NzGqwfokwkR5ExBsr9whgSd2j4VcngABR+wLuRvWyhdWp4xf9clBJzvdzrEGy9cHzTie6zTnXC8S69ZmJKzO3Dy2Z/aXSnkwtNQYS
    EXcKNs6YEkuAxDBBHdiKqz/k2gqHuwBm8vA5RKisJQ11r2YT+PX7MFBKv9N5enEGd9NDU+zMJjBL3sK+gWP1I4Bt3Lj4LzxmXXk2CFMhKMHDdmXhl5UJQCut
    oG4Lw0jYJAMqqaRuaz2UlA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=Sym3WjCbaoyTC7yyWB0A:9
    a=wQg1u4S1YOw5WERe:21 a=_F-51Xykj2gq4dxx:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 2 Apr 2018 13:41:03 +0200
From: Christian =?iso-8859-1?Q?L=FCtke-Stetzkamp?= <christian@lkamp.de>
To: NeilBrown <neil@brown.name>
Subject: Re: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
Message-ID: <20180402114103.GA29354@demeter.lkamp.de>
Mail-Followup-To: NeilBrown <neil@brown.name>,
 Sean Wang <sean.wang@mediatek.com>, devel@driverdev.osuosl.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Chris Coffey <cmc@babblebit.net>,
 linux-arm-kernel@lists.infradead.org
References: <20180329095637.GA16778@kroah.com>
 <20180329124745.24694-1-cmc@babblebit.net>
 <87vada1owt.fsf@notabene.neil.brown.name>
 <1522638255.18424.44.camel@mtkswgap22>
 <87po3i1dhu.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87po3i1dhu.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.7.2 (2016-11-26)
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
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Chris Coffey <cmc@babblebit.net>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 01:41:33PM +1000, NeilBrown wrote:
> On Mon, Apr 02 2018, Sean Wang wrote:
> > Hi, Neil
> >
> > Forgive me I cannot find the cover letter in the original series in my
> > mailbox to make a reply, so I rudely made here just letting you know
> > something good to the growth of mt7621 support in upstream.
> >
> > If so, it would become a bit easier for me that maybe I could give a
> > hand for migrating these staging driver for mt7621 to mainline. I
> > thought mmc, pci, ethernet, gsw and hsdma all could probably reuse the
> > current mainline code.
> 
> I agree that it is quite likely that several of these drivers could and
> should reuse current mainline code.  I would love to have some help
> sorting this out.  I won't have much time myself to dig into it for
> several weeks, but I'll make time to review and test any code that is
> contributed.
> 
> Thanks,
> NeilBrown

Hi,

I have started a patch series for the mmc driver that is currently in
staging, that makes some of the first cleanups (whitespace, indent,..)
and also starts to clean up the code, to make the similarities and
differences to the current mainline code clearer. The series is far
from being complete, but I think I'm going to send it out today, so
you can look and comment.

I would suggest that we continue cleaning the code that is currently
in staging to remove the dead parts and make the diff to the mainline
code obvious. Do you agree with that proposal or do you suggest a
different plan?

Christian
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
