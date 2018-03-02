Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1500788-1519994814-2-18406581333129332564
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519994814; b=MqbtshYxUBynGBETDQraFLMfmrJkXheavnRWXnyXEFhAfhf
    wDB9IZMWXbynmOHVaJk1oe30Xkd/nwwgZMvJZ1R4lYTKAjphRubppWKgs+oVIMZv
    syXBYgixUenXnCqZ0219DFLchzBc1/tIE7qJUBcJ/JZirBlHzfZcBHzRIcH/YdEx
    9icbni0Hz/7UEfqEghMIkEYjFe1W0WfmS66Kc0fYB49/equqUQkkUBPlqtU6u0fo
    sG0M3uYUFN4q+070ApjWQB/GB3/6E/izLE6LUH2Ryz4nhmeQ5qiqhWlIfyufBPZZ
    TczODp7jKDMciroGrUzlg7S9MJ6G+aeIPGkJMBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519994814; bh=4rkiOGhqARV03FaW949xxqVMRi
    thE8nzjtq4KdyBBp4=; b=Y4bm60bIRUEShExHAay5WJrhyH/wLQzNvjWNke9tO8
    hUYjDNZPbgZ3HH6Iv4BEp2CsCZsSo+cvoWKrusMGlqY6pOwGXHQ9x/uEyWtPfK3b
    eQlZpgNZ7JA4yBiH1xUWWoyufcKwarqE9OJPeMQNFVelyqVOflCLkshPN1DjG8q2
    UWOXevfUTD48GWaweGByje989fW46hsvA2cwsXt+oW5TNOr064mztmE+p/6HOos7
    t8VU5syma2PczOsudXoqudt14pGUm2oXB0S4FmYBgUamwGIjqZ0NJU6btGJbCTQ7
    VINXnxLIfVyGOE6qrwiuZKF2dFh8hNhfyGP2NtaCmFUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=the-dreams.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=the-dreams.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427595AbeCBMqv (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 07:46:51 -0500
Received: from www.zeus03.de ([194.117.254.33]:33622 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423931AbeCBMqu (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 2 Mar 2018 07:46:50 -0500
Date: Fri, 2 Mar 2018 13:46:47 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Dooks <ben-linux@fluff.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] i2c: s3c2410: Properly handle interrupts of number 0
Message-ID: <20180302124647.sfhnto77wgdh5sv6@katana>
References: <1519936484-23132-1-git-send-email-krzk@kernel.org>
 <20180302111931.GX9418@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mmmpzdutlodmvuhh"
Content-Disposition: inline
In-Reply-To: <20180302111931.GX9418@n2100.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--mmmpzdutlodmvuhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


So, maybe some words why I accepted this patch.

On Fri, Mar 02, 2018 at 11:19:31AM +0000, Russell King - ARM Linux wrote:
> On Thu, Mar 01, 2018 at 09:34:44PM +0100, Krzysztof Kozlowski wrote:
> > Interrupt number 0 (returned by platform_get_irq()) might be a valid IRQ
> > so do not treat it as an error.  If interrupt 0 was configured, the dri=
ver
> > would exit the probe early, before finishing initialization, but with
> > 0-exit status.
>=20
> The official position (as stated by Linus) is that interrupt zero is
> not a valid interrupt for peripheral drivers (it may be valid within
> architecture code for things like the x86 PIT, but nothing else.)

I am aware of that situation and I totally agree with the reasoning.

> You need to number your platform interrupts from one rather than zero.

Ack.

> Note that there have been patches proposed to make platform_get_irq()
> return an error rather than returning a value of zero, so changing
> the driver in this way is not a good idea.

I'd much agree to such an approach, yet I didn't see it coming along so
far for years(?) now.

The reason I applied this patch is consistency with the current
interface. The code is wrong with the way platform_get_irq right now
works. This is independent of platform_get_irq should work, I thought.
This needs to be fixed in a seperate series. This patch will not harm
that transition.


--mmmpzdutlodmvuhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlqZR68ACgkQFA3kzBSg
KbZLNxAAqyzCrbHqB9udzXQlk4IfhZaq7rgPRZi9tHSLJiHNWZ4LEalGpquOjmvp
tnvWgX1Ptopi/iwINS7+NBrFQGCQCVlPycNwmVZbfTaMfTHcO9TY5qtW7mlsbxQs
QfOyx786YRjDDJTvNcWPvyU9rXs09JJRcWfvGEs6/uGb12Z7kXVcMbVuqDCGzpSr
0KB0ya47x7YNkHdWrtfht4J/0Wf2DuhX7W/c1K9NaROo02I0tgjgrk57kYDJq1Hq
d9V1m/56WErvBHS4QmdnYrRAzPBr3b4/9ah0Cd+X9sopYafL0hsm2XcuPk0frPB5
mn6h1FP+XLt1IYDMhXt5yQWnj1QXTn0u4vvuYPWQRA9meWi8xWi8jrzR05+kSguc
phPGcCwiOh/K8/w4Wm0WrxMMi3TLDnR1hsceZz2/N700Kosamtm0FnG2eAiUnpuH
zEwRRGCWl91btaVB9sWfcsI+LrDeCH3AL6GOauNtP6jDyyRlEVilS31iDJRC5qCu
KaKKSXBN+zb9BdJ+I+xL8CcxT0jAFuq2WMjIRiYWkyJqPTmeAERwuppEI88cu+N0
rmKrIBLZDXEhAay6E3sYSXk+ZLp3ZixsJ5ip5cV40NY5lMx7YhH9lv4nSJZVcd5V
UvEiWKdhGW7VgY53ZjrFh+64Q63hdiqI6+QsOFQiqTdSGkYTWLU=
=iX6R
-----END PGP SIGNATURE-----

--mmmpzdutlodmvuhh--
