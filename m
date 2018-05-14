Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932512AbeENNPf (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:15:35 -0400
Received: from ec2-52-9-186-167.us-west-1.compute.amazonaws.com ([52.9.186.167]:33302
        "EHLO mail.suchdamage.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932189AbeENNPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:15:33 -0400
From: Sam Hartman <hartmans@debian.org>
To: Thorsten Glaser <tg@mirbsd.de>
Cc: Adrian Bunk <bunk@debian.org>, Ben Hutchings <ben@decadent.org.uk>,
        Debian release team <debian-release@lists.debian.org>,
        Debian kernel maintainers <debian-kernel@lists.debian.org>,
        krb5@packages.debian.org, libbsd@packages.debian.org,
        systemd@packages.debian.org, Michael Kerrisk <mtk.manpages@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: Fixing Linux getrandom() in stable
References: <75577b3d2efd01aaf563f1a1400a2c655556b258.camel@decadent.org.uk>
        <20180513204828.GI10643@localhost>
        <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org>
Date: Mon, 14 May 2018 09:05:58 -0400
In-Reply-To: <Pine.BSM.4.64L.1805132113450.15657@herc.mirbsd.org> (Thorsten
        Glaser's message of "Sun, 13 May 2018 21:23:39 +0000 (UTC)")
Message-ID: <tsld0xygzex.fsf@suchdamage.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thorsten" == Thorsten Glaser <tg@mirbsd.de> writes:

    Thorsten> Adrian Bunk dixit:
    >> As an example, what happens if I debootstrap and deploy the
    >> resulting filesytem to a large number of identical embedded
    >> systems without entropy sources?

    Thorsten> Just get into a habit of not doing so, for example by
    Thorsten> modifying the image during each writing process.

I'm sorry, but modifying the image before each write is simply not
realistic.

My company has found that it's easy to get suppliers to deploy a static
image to the storage of appliances we're constructing during the
manufacturing process.
They do not have tools for modifying the image.  We do detect first boot
and do things like change filesystem UUIDs.
Mixing in any entropy we can obtain during the first boot is relatively
easy.  However, very quickly, we're going to need to do things like
generate ssh keys for management and generate a few other public keys.

Similar situations show up in cloud environments.  There you can use
virtio-rng or similar.

However, the fact is that when we design systems, we are constrained by
constraints placed by other parts of the process out of our control.
Delivering an image that is static and that will be deployed onto
multiple systems is something that does happen and it happens because
it's the best design tradeoff available.
It does have security implications, and in fact may decrease security of
random numbers overall.  On the other hand, it can increase security of
code integrity and tends to be associated with design methodologies that
create reproducible environments.

So, you can try and sweep static images under the rug, but all you're
doing is dsmissing people with real problems they need to solve.
It would be much more constructive to acknowledge that people will use
static images, discuss the security implications, solve the problems we
can solve, and document the residual security implications so our users
and the broader community are aware of our limitations.

--Sam
