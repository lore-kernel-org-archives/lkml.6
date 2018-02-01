Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932123AbeBAAde (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 19:33:34 -0500
Received: from www.llwyncelyn.cymru ([82.70.14.225]:44714 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754068AbeBAAdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 19:33:31 -0500
Date: Thu, 1 Feb 2018 00:32:36 +0000
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: "Wong Hoi Sing, Edison" <hswong3i@gmail.com>,
        "Hung Hing Lun, Mike" <hlhung3i@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] tcp_lp: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180201003236.06143fd0@alans-desktop>
In-Reply-To: <20180201002407.GA1608@embeddedgus>
References: <20180201002407.GA1608@embeddedgus>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jan 2018 18:24:07 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Cast to s64 some variables and a macro in order to give the
> compiler complete information about the proper arithmetic to
> use. Notice that these elements are used in contexts that
> expect expressions of type s64 (64 bits, signed).
> 
> Currently such expression are being evaluated using 32-bit
> arithmetic.

The question you need to ask is 'can it overflow 32bit maths', otherwise
you are potentially making the system do extra work for no reason.

Alan
