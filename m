Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AF0C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A93E520665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 16:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfJyBJNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfAIQh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 11:37:57 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34068 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfAIQh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 11:37:57 -0500
Received: by mail-lf1-f66.google.com with SMTP id p6so6142449lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 08:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpOd4KOhVWXZ0ZdlLnkpFIAFTQUwdhkSA+jWkyxu/bA=;
        b=NfJyBJNP+A2pxkF+NsTb0axj1JVmsIGePDLjWasCKbvY5Oeo0W/6duHA2+9VddhYlW
         8bP8ubvLP90Vd2INGZACF6/6xTGGxLbW9gk6uTzoCrnEQv83HfuR2hzwoPYd2VA3BVcH
         yaijCSepdsAun5H/62Z9sg/AIE2NEfT4xpGIKQuAk2TN/CCRgx5zJ8NmaeGe2BxP1OOg
         UTZ8z0MiecvrSiMijqhYWg3qYudIctW+LbS6YGn3qLpwVKWn/wC9kUf8WHj0wBf2BoVI
         ajpecRIoc11UA+gqFAEo+eJLNhmRJuLz3LlnEEXgULyF9Tk/k32e1KELSsNI/8OC6VKp
         Trtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpOd4KOhVWXZ0ZdlLnkpFIAFTQUwdhkSA+jWkyxu/bA=;
        b=AyDxZ/ecSpnSHCRa4bCU0lRlTeoJOXzMhcEa8PC7bl7OqjP3oWz6nWMwpPUnWvKX6L
         CKGP5R16bhXPPznIjWtZNlBOVTa+NfRnDRw7FCoSDYOnDK2ysgbsn0AcEe/OFky1gcFk
         1l2H5Ks5//pz8oqfo7DN3RepHtvZOjCcLVfjRmmIdLfjHjMIg9MDu4SiLOZAToYHwTMo
         +1gHVM6eQjw0q/0VAiz0P2l+GelN/plrOAO92t5pxgKsm9NS7+Rm7rZwdqlkk5nzbbDM
         z6ePGOgJ0MJ2+uqFQD1LgEoWX0S+aeOoYXbBkRm0kWkLFbcGHEbx24g8ZyR+RZysXFMx
         87SA==
X-Gm-Message-State: AJcUukcffXS7ge3utb3WPNqQ9wif5MHtgzliRiGV+VikQAmDp6YYN8r2
        1V//ScE1zH66e83cJUWmzHSvydNbOHKiGovFPH4=
X-Google-Smtp-Source: ALg8bN7HYEAYVDhoJOy2VZl/oQu8bMNl9nvj+Z6fTXvBgWBdK7HamubHUq6qaP5uvlNe/+zZI/XNJBIbvXNw/KI0T8A=
X-Received: by 2002:a19:2906:: with SMTP id p6mr3756886lfp.17.1547051875267;
 Wed, 09 Jan 2019 08:37:55 -0800 (PST)
MIME-Version: 1.0
References: <20190109161916.GA23410@jordon-HP-15-Notebook-PC> <20190109162332.GL6310@bombadil.infradead.org>
In-Reply-To: <20190109162332.GL6310@bombadil.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Wed, 9 Jan 2019 22:11:46 +0530
Message-ID: <CAFqt6zYQU+jN57Lh2Enx-t9EKHSjSKibUHU1Y-KyzAzxWVy3Qw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/hmm.h: Convert to use vm_fault_t
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jglisse@redhat.com,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 9:53 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Jan 09, 2019 at 09:49:17PM +0530, Souptick Joarder wrote:
> > convert to use vm_fault_t type as return type for
> > fault handler.
>
> I think you'll also need to convert hmm_devmem_fault().  And that's
> going to lead to some more spots.

I will add it in v2.
>
> (It's important to note that this is the patch working as designed.  It's
> throwing up warnings where code *hasn't* been converted to vm_fault_t yet
> but should have been).

Ok.
