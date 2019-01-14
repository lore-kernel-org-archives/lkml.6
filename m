Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F926C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A9A20645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:47:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0zvzzg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbfANSro (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:47:44 -0500
Received: from mail-lj1-f174.google.com ([209.85.208.174]:38937 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbfANSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:47:44 -0500
Received: by mail-lj1-f174.google.com with SMTP id t9-v6so48177ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 10:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=dThSdtJskhfxCKpEStbcjO4U+BnLsz/sqiq0gz9PYL0=;
        b=Z0zvzzg1SwHpBlWMM2Tc4LylgEVrl7QocyTlvbI9rjQlSP2QwireydmetU3F//D9OV
         IySzf8fOP3YxG6z9lp/M+Ta1sDYYMDqiJGnIM5pljPoNIAJIXEDlYTo6jYcwpK8baItX
         h1CfSdjAYUjH9nyx6+gFCwPp9SBniNNZZwnVclcK1Miao+HxJThnbo/DDbPVUiv0J97Y
         iRzroJXDcBkYzHBjq2lPga4GVB0GTWMRy4doiYkS6sexoeWQhGDThJv71Oe8tk44N0ms
         IIYSxQUH8hFu7at9fa7BwPX9ewapiEgm+yK/XETcsI/Jl8O6Oud1SRO593XB7uJnFYUh
         gWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=dThSdtJskhfxCKpEStbcjO4U+BnLsz/sqiq0gz9PYL0=;
        b=nEIIW0gllaaONQ43sdbHGHwDYXU3XIsHCC/irDraYGig3HK68V592/F9NThmpQtcA1
         bD5RIbOwLOf5ZdE4CheYkAvOhjw1KrE4AwGK+Ej2Gd3SUWbPX1lR5NlOVnCNuZtyVhQx
         mo6TV9JMKL2rV8YOTGiADNsuXY6LUEjHKkaqzwbSV5GSGg836f4sKNf7qq84oMjB1tGU
         RNwHQTupd7Q89b6czEH4bNuZZre37Hz9SC/U/6vE/EUvzSxEuXLCAxC57TMtFccVoMob
         7KaTOjKVc/8CFIIT1r9ofDcS11RNE0UOJpF/9VaCVVwTmRBbcgmTHcufz1lpAytpwPN/
         5OrQ==
X-Gm-Message-State: AJcUukcWvXOILWuDNLG99sY0Q0ZE0WzsQlGoNnQGr/k4bshPK15RWgge
        6dcZa7nZ+Zc4zLJCAhtVyUi98BF0
X-Google-Smtp-Source: ALg8bN7/H3LFJXogcN/XzDKaIuEufLLTfNMwBjS3FAWWJegipFJx0Cx2NQu7ZEIPWAp1q+A1ZjfRiA==
X-Received: by 2002:a2e:a0d3:: with SMTP id f19-v6mr15174967ljm.48.1547491662381;
        Mon, 14 Jan 2019 10:47:42 -0800 (PST)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id h3sm214702lfb.49.2019.01.14.10.47.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:47:41 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 4EEF44608DD; Mon, 14 Jan 2019 21:47:41 +0300 (MSK)
Date:   Mon, 14 Jan 2019 21:47:41 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH]: xarray: Fix potential out of bounds access
Message-ID: <20190114184741.GF17906@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the mark is used as an array index we should use
preincrement to not access the XA_MARK_MAX index.

Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
Matthew, take a look please, I suspect we may access the
mark index out of allocated one. Compile tested only.
It comes from 58d6ea3085f2e53714810a513c61629f6d2be0a6

 lib/xarray.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-next.git/lib/xarray.c
===================================================================
--- linux-next.git.orig/lib/xarray.c
+++ linux-next.git/lib/xarray.c
@@ -129,7 +129,7 @@ static void xas_squash_marks(const struc
 			continue;
 		__set_bit(xas->xa_offset, marks);
 		bitmap_clear(marks, xas->xa_offset + 1, xas->xa_sibs);
-	} while (mark++ != (__force unsigned)XA_MARK_MAX);
+	} while (++mark != (__force unsigned)XA_MARK_MAX);
 }
 
 /* extracts the offset within this node from the index */
