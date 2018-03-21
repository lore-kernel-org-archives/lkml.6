Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbeCUGlg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 02:41:36 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40048 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUGle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 02:41:34 -0400
X-Google-Smtp-Source: AG47ELvkHZmtIhgY19G+Dhl3nIJiYcobkwk3lOE02457T/DATBP6Disjir5A8OysbisIM7ozWhrX8Q==
Date: Wed, 21 Mar 2018 15:41:28 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Maninder Singh <maninder1.s@samsung.com>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net, minchan@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, akpm@linux-foundation.org,
        colin.king@canonical.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, pankaj.m@samsung.com,
        a.sahrawat@samsung.com, v.narang@samsung.com
Subject: Re: [PATCH 0/1] cover-letter/lz4: Implement lz4 with dynamic offset
 length.
Message-ID: <20180321064128.GA468@jagdpanzerIV>
References: <CGME20180321044137epcas5p221e7ee4a0b7464eaa00dad8320f0251d@epcas5p2.samsung.com>
 <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521607242-3968-1-git-send-email-maninder1.s@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/21/18 10:10), Maninder Singh wrote:
> (Added cover letter to avoid much text in patch description)
> 
> LZ4 specification defines 2 byte offset length for 64 KB data.
> But in case of ZRAM we compress data per page and in most of
> architecture PAGE_SIZE is 4KB. So we can decide offset length based
> on actual offset value. For this we can reserve 1 bit to decide offset
> length (1 byte or 2 byte). 2 byte required only if ofsset is greater than 127,
> else 1 byte is enough.

So what happens if I compress the data on a system with no dyn
offset and then send it over the network to a machine which has
dyn offset? Or, say, I have a USB stick with a compression enabled
FS, store files on a dyn offset enabled PC and then mount that USB
stick on a machine with no dyn offset support. And vice versa.

	-ss
