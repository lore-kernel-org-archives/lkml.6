Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeEPN6L (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:58:11 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43492 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeEPN6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:58:10 -0400
Message-ID: <1526479082.9159.120.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 159/190] ipsec: check return value of skb_to_sgvec
 always
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nathan Chancellor <natechancellor@gmail.com>
Date: Wed, 16 May 2018 14:58:02 +0100
In-Reply-To: <20180411183601.856116959@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183601.856116959@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-04-11 at 20:36 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Jason A. Donenfeld <Jason@zx2c4.com>
> 
> commit 3f29770723fe498a5c5f57c3a31a996ebdde03e1 upstream.
[...]

This leaves the error paths in esp{4,6}.c leaking memory; fixed
upstream by:

commit e6194923237f3952b955c343b65b211f36bce01c
Author: Steffen Klassert <steffen.klassert@secunet.com>
Date:   Thu Jul 13 09:13:30 2017 +0200

    esp: Fix memleaks on error paths.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
