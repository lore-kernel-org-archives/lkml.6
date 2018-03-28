Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753851AbeC1W0C (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 18:26:02 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:38102 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeC1W0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 18:26:01 -0400
X-Google-Smtp-Source: AIpwx4/3SecsV19C8aqUtE9wNXPyymTTdPkoMbI46vdlk5dmqmfQZWVsiI7swJM0URXJ3GIABtAs0DvFmOYtAQMrGjo=
MIME-Version: 1.0
From: Derek Robson <robsonde@gmail.com>
Date: Wed, 28 Mar 2018 22:26:00 +0000
Message-ID: <CAMfSVWBgYGJAhyadx_xxi6Z7mjP94YGUnBRj3ZvtkEM6JU+WJg@mail.gmail.com>
Subject: Regression in 4.16-rc7 - ipsec vpn broken
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>, ben@decadent.org.uk
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ipsec VPN is broken in 4.16-rc7 and seems to have been broken in all of 4.15

connecting from an iphone seems to give a timeout.


A bisect brings me to this commit as the one that is the issue.

commit: acf568ee859f098279eadf551612f103afdacb4e  (xfrm: Reinject
transport-mode packets through tasklet)


Reverting commit acf568ee859f098279eadf551612f103afdacb4e against
4.16-rc7 causes the VPN to function again.
