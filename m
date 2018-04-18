Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1014489-1524077219-2-534674126283616530
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524077219; b=n3ipK+mzjWsBBObaQ4BF3DheFqo/V/V6WBkxw8jbAxny36en5I
    N891WgwZ6BJr9DVAb4meFNCIUnd41vQtd4ILtvT7w0rfNH3T5BIP4Ou5bIGIIDDk
    UtZwg2tfXHJfYMQx854sW97nZVzbxUyfNAx0jsAZEMM2ueo74vrW64+40og4Y14v
    tLafypnbjSPaAH2vVW+m8du8wnCgzxnMAAOAWBctognwpkPj53xnOrjigCq4MMh8
    5wAiKNIXSDDfx4Wg1ieuFB7j364P3tDMHreZMkTGzEZLLCWlgAiRWffYJ93+cLwu
    ckV0ZzTZ6HhT9GdcXOJH18GlKs9DQ70gLwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524077219; bh=nIsuzXQNhmkKNHGhywDlQv2w1ZFTyN
    mGrqA6gWSbHiM=; b=M94sF/asdyRISPxSTQhE2rPw3oZnTbi56Uq3f8mEWNfZbn
    Bhjp1XSMYl8TIPN1dP3nuSYKHlDBYyAhXXO7MWhmtbPVrAkEBcBxcYKOTsntRxXe
    x1aQjlzf1QZl4drZIh0+FtwwLV9NOOY+mZIAdHNqkip15gzEVzw7IyGzsSSUTypJ
    Ln6Zm6gErC6SoQuRzml7SlX7vPitfSU6re9LzVZJ1/0jEHN4HGAS5AZwOrGVfGxr
    +0zDPHi/IsMmebGnMbyd1qNyTXlISuVXnpVv0uuhpcheeVqZqwZW9R/Jzxt+uPgx
    fde7njK3330UiziMU1u3GOphepD6VaNJBV6986hg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SjXatkJX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cwH5kHLO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=SjXatkJX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=cwH5kHLO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4xaMzBKtkGqrWDw+GgwOQr61+5ORQz3qChD3gqgUKgAoqQ5Z5FpLabEjGUhRPQvtKSKGjP0tBw5ge6j49sNFyx5HF05WeFytYLC2mbj6OW0G/C00y2
    HYoEu773ig8FUAc6kvkXTO4jMB0Yf6FzbEeX1hPqzyz1Gsxr+yYkR85LFeAcOFneB1snFuQMU1SMF8W4TQoR9bUz27GNt8fHgFXMfd8q+NdimsS4nv/tx8Ga
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=b2yvCC_gagFq5M-nJJQA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDRSqp (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 14:46:45 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:43255 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeDRSqo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 18 Apr 2018 14:46:44 -0400
X-Google-Smtp-Source: AIpwx4/3mL4UuD4aYFe9pI/g6Gl2ykEovtKqJPH8jrZkVhWLH/mG0W+xSh1VgN53/jAWUCp+MISglw==
Date: Wed, 18 Apr 2018 20:46:40 +0200
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: musb: dsps: phy fix and DT-topology support
Message-ID: <20180418184640.GJ9198@localhost>
References: <20180413151505.32663-1-johan@kernel.org>
 <20180418162015.GG14921@uda0271908>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418162015.GG14921@uda0271908>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 18, 2018 at 11:20:15AM -0500, Bin Liu wrote:
> Johan,
> 
> On Fri, Apr 13, 2018 at 05:15:02PM +0200, Johan Hovold wrote:
> > I've been carrying a patch out-of-tree since my work on improving the
> > USB device-tree support which is needed to be able to describe USB
> > topologies for musb based controllers.
> > 
> > This patch, which associates the platform controller device with the
> > glue device device-tree node, did not play well with the recent changes
> > which added generic phy support to USB core however.
> > 
> > Like the recent dwc2 regression fixed by Arnd after the device-tree
> > #phy-cell changes, the generic phy code in USB core can now also fail
> > indefinitly with -EPROBE_DEFER when the controller uses a legacy USB
> > phy.
> > 
> > The second patch addresses this for musb, which handles its own (legacy
> > and generic) phys, but something more may possibly now be needed for
> > other platforms with legacy phys.
> > 
> > In the process of debugging this, I stumbled over another issue which
> > caused the dsps legacy phy init two be called twice on every probe and
> > which is fixed by the first patch.
> > 
> > Johan
> > 
> > 
> > Johan Hovold (3):
> >   USB: musb: dsps: drop duplicate phy initialisation
> >   USB: musb: host: prevent core phy initialisation
> 
> Are the two bugs only affecting you with your out-of-tree patch? It
> seems don't have any functional impact for me. I need to make a decision
> if these two patches need to go to the stable trees...

The first bug is independent of the third patch (the "out-of-tree"
patch), but as Uwe also noted it seems to be mostly benign since it took
two years for it to be discovered. For that reason, and to minimise the
risk of any stable regressions, I did not mark it for stable.

The second fix is really only needed with the third of_node patch since
I don't think any of the glue drivers propagates the device-tree node in
this way currently. Hence it could also wait for 3.18, and it is in any
case not stable material as the generic-phy support in USB core is new
in 3.17.

Note that other host controllers may have a device-tree node with
associated legacy-phys however and that this could now lead to similar
problems starting with 3.17.

Thanks,
Johan
