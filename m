Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C019C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAD5A2080A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfBHUF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:05:59 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:46567 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBHUF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:05:58 -0500
Received: from oxbaltgw36.schlund.de ([172.19.246.44]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MuDLZ-1h61tY0nbJ-00uWTw; Fri, 08 Feb 2019 21:05:41 +0100
Date:   Fri, 8 Feb 2019 21:05:39 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Jeremy Linton <jeremy.linton@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     mlangsdo@redhat.com, suzuki.poulose@arm.com, marc.zyngier@arm.com,
        catalin.marinas@arm.com, julien.thierry@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        steven.price@arm.com, ykaukab@suse.de, dave.martin@arm.com,
        shankerd@codeaurora.org
Message-ID: <602509505.322713.1549656339538@email.ionos.de>
In-Reply-To: <20190125180711.1970973-1-jeremy.linton@arm.com>
References: <20190125180711.1970973-1-jeremy.linton@arm.com>
Subject: Re: [PATCH v4 00/12] arm64: add system vulnerability sysfs entries
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:thf0NL6CXayKqbKERWrDR2zdByODSqCMKk2NfZbZi2NZkf1845Y
 lfWjGuHrCN3oWH6WPwrKLjNTjb9f19RmEXkn8/fTxtvHRiSKwiOkLWgFPQQirFb7gaXhPQ6
 WIE+0a2h/YI8w4DlUQbjtyMeMLmznQUbXMSIqNoB+AgvK6TD1DKPPCr2tTQVhQAOE04IbEH
 W7dzDE26BJ7j9DV2P0ZZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CFmHaRNOlqs=:28Af/jZr3MlOsrOzsWBI6G
 PQrSPjY9+TwwqaVIFJKAp6CeqYvFz6XThqhbuwcYFZ61zUFstSvAZBO7Q9po8PV7vJCmlm8Xd
 pTjcyXptGodgaPkQw0XVqq8tD3KXqT379EamJeUyJk8dPqyIu1kS5X+lelLFHRqARr/MFDFWQ
 FXeeYfZmPZiO4IVNmY7rgn2L9Wiuj6pow7p/dMaQ/Vcbd1Yi0Lln8r9q+Gi4bN8GnbcWx7Txb
 L+gXCVwj3XZl2zJV8cjkT3+RkuKwFz8bLu6m8dMw53PjN9jfA+kyF1KO3HzYXq0jB84UAohRV
 ALKQ9/i/zvo+NdQ0e22obj7eaLjsGpf8BOkoHRDgabtm9NsXp+SywkcF8x+CMNGbMMGu96foc
 4fC7nZHU7aer5i8E1NwBXBss/RFwSUYurB0N5eYB8vOfe0KIY/47ftYOYqT5JVIAsOu4vq80F
 m7EjDvC6Bn2j5+K6upzgN3ffbGsjD+OrySRXt1o0upygttUL8Ob+n3580uvZPdqFZZkcAK5h+
 48BayHcaidEa9NtqEIMGBqNTB9dW1hTofoIkeSqg288oUXcnm7BYcK/voPDpSwnHZUd9Bv5XS
 AbouDG6S82HyE7RgQylQqjzK/TNEypV0Ora/EEXV6DkzvJo68V0jfCsWNe27PrCibHyTx+UN8
 bd0G1pxZyM0NNf3tK52kjTHauOUhFuaCYBPZ2sBI9OGC2DNywJnuOh10q2RD7esCnwQUYt9iQ
 DvCnbSND7o6d0/oP6D9457XPznD7finV/pMhgKHCU0h1Ad4EDKBF/lMOrcA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Jeremy Linton <jeremy.linton@arm.com> hat am 25. Januar 2019 um 19:06 geschrieben:
> 
> 
> Arm64 machines should be displaying a human readable
> vulnerability status to speculative execution attacks in
> /sys/devices/system/cpu/vulnerabilities 
> 
> This series enables that behavior by providing the expected
> functions. Those functions expose the cpu errata and feature
> states, as well as whether firmware is responding appropriately
> to display the overall machine status. This means that in a
> heterogeneous machine we will only claim the machine is mitigated
> or safe if we are confident all booted cores are safe or
> mitigated.
> 

The whole series is:

Tested-by: Stefan Wahren <stefan.wahren@i2se.com>

with a Raspberry Pi 3 B+
