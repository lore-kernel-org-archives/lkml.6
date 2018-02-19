Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753882AbeBST5t (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 14:57:49 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47416 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753713AbeBST5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 14:57:45 -0500
Subject: Re: Build regressions/improvements in v4.16-rc2
 (infiniband/hw/bnxt_re)
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
References: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
From: Randy Dunlap <rdunlap@infradead.org>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Message-ID: <8c96847f-423d-1a90-3e67-feb409303675@infradead.org>
Date: Mon, 19 Feb 2018 11:57:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519048647-18732-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/19/18 05:57, Geert Uytterhoeven wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.16-rc2[1] compared to v4.15[2].

Hi,
Just FYI, this driver could use some 32-bit attention.

> *** WARNINGS ***
> 
> 1659 warning regressions:
bytes is larger than 1024 bytes [-Wframe-larger-than=]:  => 78:1
>   + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/ib_verbs.c: warning: left shift count >= width of type [enabled by default]:  => 3550:2, 3552:4, 149:2

Above is due to:
#define BNXT_RE_MAX_MR_SIZE_HIGH	BIT(39)
#define BNXT_RE_MAX_MR_SIZE		BNXT_RE_MAX_MR_SIZE_HIGH
as 32-bit CPU cannot shift 39 bits left.

>   + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 569:19
>   + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 336:12, 333:23
>   + /home/kisskb/slave/src/drivers/infiniband/hw/bnxt_re/qplib_fp.c: warning: passing argument 1 of '__fswab64' makes integer from pointer without a cast [enabled by default]:  => 569:2
thanks
-- 
~Randy
