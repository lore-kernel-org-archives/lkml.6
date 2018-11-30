Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7CFC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF71214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 15:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="1wvnulbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF71214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbeLADEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 22:04:47 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41571 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbeLADEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 22:04:47 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so5497304otk.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 07:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=54EQHOa43eawX6Ru/pwSvF0q06YJDxkETxXG70n/VWY=;
        b=1wvnulbjZWywnM1VMDl9EJ6jEZ1eYyULF5URc9xBBnRBM+22nXzjbzGku70zZ1FHpM
         3CrnUr4znvFJxRzr+QEn2ydWeL52iuf3hX71Nq2geqSwpZdd78rh5b0DYnUCDhS+/htU
         EXLap7qvm6BorDbL9qMcDJVv40kNAdD79wDW5LeGbCeeZnnoW/7P0Re4ns6FTyf8rs6z
         jDclXYibfWkSGt7Yhm0r5DFHc7HBFzwaARY5HkAvKNoh+PejMVHi1VZolSojRXfnMRq0
         hqZlCWfNrDrLU5cEgD1UvvY2ul3xM9x0gdAP4Pac6rTqeDbZ9y88jVPxlztmBz8YCBfK
         z3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=54EQHOa43eawX6Ru/pwSvF0q06YJDxkETxXG70n/VWY=;
        b=gjSOS84XPBIK6CdnJiYh4JHXLfi5KR/SEjeZYf+YqUm0LsaZNCHhLlhOPianzy/ohV
         q48iPlmaXwvT5tQwjdi0UuN3uDBWPDFrmWt21rmKvPdXtMBPX65Ed5g11/SP6xxNu7qs
         2NUNQ8jHSE3c7bOgfydCyaYF2FPPW2Hi01tddm/8Hz57uyF2JHiIAJIIE+T/yU6xpSuK
         5eQISss+GhGcBHofmHuE/66Gh5AFghuL66U+U7T4EqSJGiA7Wy4DpOdVMo0GMaS9x9Pa
         UCjNMBa+fxsaJPclIekCSkO2It3vEr+tILqRAqukmeoHZuQHjsbqiqQd0HZVgwzJfcx1
         2YJQ==
X-Gm-Message-State: AA+aEWZuMZ07ROgNbIEcpGHggoVFgnBiWdS1UKwEzqsndjh3CWTTpBRu
        JbhHZqIR3brUj9aZ9O+ZfvOrlBfCDcjzMnVzBOLJAg==
X-Google-Smtp-Source: AFSGD/XIr+mvfGi93ZDlhd6NXzmVNn0lwQzo193ISDbH4Xno6sr6GStMaGzhzeUUq5faEFpEZBDhoBBeZXKOgUqKOCM=
X-Received: by 2002:a9d:a78:: with SMTP id 111mr3746757otg.229.1543593300397;
 Fri, 30 Nov 2018 07:55:00 -0800 (PST)
MIME-Version: 1.0
References: <154353682674.1676897.15440708268545845062.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20181130154902.GL10377@bombadil.infradead.org>
In-Reply-To: <20181130154902.GL10377@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 30 Nov 2018 07:54:49 -0800
Message-ID: <CAPcyv4iE375mP7eJP4nb76shWNaATy6FcZYi800wZ3iAJE8G8g@mail.gmail.com>
Subject: Re: [PATCH] dax: Fix Xarray conversion of dax_unlock_mapping_entry()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 7:49 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Nov 29, 2018 at 04:13:46PM -0800, Dan Williams wrote:
> > Internal to dax_unlock_mapping_entry(), dax_unlock_entry() is used to
> > store a replacement entry in the Xarray at the given xas-index with the
> > DAX_LOCKED bit clear. When called, dax_unlock_entry() expects the unlocked
> > value of the entry relative to the current Xarray state to be specified.
> >
> > In most contexts dax_unlock_entry() is operating in the same scope as
> > the matched dax_lock_entry(). However, in the dax_unlock_mapping_entry()
> > case the implementation needs to recall the original entry. In the case
> > where the original entry is a 'pmd' entry it is possible that the pfn
> > performed to do the lookup is misaligned to the value retrieved in the
> > Xarray.
>
> So far, dax_unlock_mapping_entry only has the one caller.  I'd rather we
> returned the 'entry' to the caller, then had them pass it back to the
> unlock function.  That matches the flow in the rest of DAX and doesn't
> pose an undue burden to the caller.
>
> I plan to reclaim the DAX_LOCK bit (and the DAX_EMPTY bit for that
> matter), instead using a special DAX_LOCK value.  DAX is almost free of
> assumptions about the other bits in a locked entry, and this will remove
> the assuption that there's a PMD bit in the entry.
>
> How does this look?
>

Looks good to me, although can we make that cookie an actual type? I
think it's mostly ok to pass around (void *) for 'entry' inside of
fs/dax.c, but once an entry leaves that file I'd like it to have an
explicit type to catch people that might accidentally pass a (struct
page *) to the unlock routine.
