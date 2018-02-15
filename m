Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033776AbeBOPMx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:12:53 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:49353 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033584AbeBOPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:12:51 -0500
Date: Thu, 15 Feb 2018 16:12:38 +0100
From: Lukas Senger <lukas@fridolin.com>
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pps-gpio: Avoid flooding syslog
Message-ID: <20180215161238.23e0c117@dinghy.localdomain>
In-Reply-To: <6c424674-e8f0-eaf1-c056-889e354b43b7@enneenne.com>
References: <ee4fdd16-0343-1a01-63a7-06046026659a@enneenne.com>
        <20180215125921.29494-1-lukas@fridolin.com>
        <20180215125921.29494-2-lukas@fridolin.com>
        <6c424674-e8f0-eaf1-c056-889e354b43b7@enneenne.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:3IFnCtxuD3BcFN2kxiWMpjolSpDW1CrKL6AL3u3pmYpuW2NThrv
 fQ1xzymUQy4pXj2ARLyrln7XVz/HXynNvvP3KTIFEGeWzwByovKuxmwRZg+HGdWhKdtsVbk
 EGbKoVxCSFabOGP7Xpa8vVsLhEjW7Virj2jSSUOqXw8K59VXv0FStCCHDHGIraE9H3cIgiF
 aZC5xHnRMXGWMTeUC5Pfg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OsJAcW0Mj+M=:h6griMlQYs/gHWxiMwWIcX
 7F9yv4HKp6SwEwS60CO7IwGPct+NFS3WNfFX5fVCtdE1K6Wj9xk4SrE7DcyUuSbld9oS2LFqt
 ASpaxlW9+4fLQMsWAMCRp9DAZ5C/FHELVU24tpBLuC6hvP+aoK2asXv3hnAGSVHcvM8iAM4EB
 2MbIU481XyI8fFsMJBGD1qho21s7dz9nyOYMIJk92RsWdz4mtAnI6OV9VyA9FeSahl++iYeHA
 NJjBdG1V1JBnoPRzBk5kt7tf+AiC8PStNricmQnfY8eErQexoNFDtKyWthMUNaweoXUghNgyK
 3IXIzvCWdYujG+kESQ/gHrmSCzXC0Yx8TxAndbz+pqdcUDWK1Nn1DnRSsnwyKvuxe40WH1gvq
 Spo9embXPhu3ht4ZD1HQLbHX/a5Edw4S00CKlT3E3uR4JXg14l3Cwo8dazW1ryQm17KQtwkPA
 wW9mU44dIYTAYevlxhyPgEJfIUJAMkpev00S518E7CJpumXbphsLXFzN/ey84i43s5WVtdqNB
 SZ9pjTDq4L7kkQwvfzxiBKC+jYrCtY/L/N5itjETk3ct0SvSd+0wl+fiyeqSX0YLDMym9+klB
 RiD15Uwy/IjIggXKysiwjpFk3iv0fzBHl8WaOjQRPYXCGyDw/ssqmBQjKLcFNrLP/gXZ6syvG
 5MK2VGZKgJ3GMEyu9axBPVFJgplGJsXgsQRyBTSkssJlM2CJf5CJz2awRAEPKNAKPH06YTjN4
 drH7tZ1Zmqjy5qVg0IzzBcS74jrmaCCAdZ4X6gc0JV69Q5pw6xMBVmWv99I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Why a void function? You should use it to toggle echoing GPIO... =8-o

RFC 2783 says to generate the echo pulse "as rapidly as possible" which
is why I do the toggling in the irq handler. However this leaves the
default echo function installed which just floods syslog.

Another problem with this patch is that it also is against my old one
and not against current kernel code.

Cheers,
Lukas
