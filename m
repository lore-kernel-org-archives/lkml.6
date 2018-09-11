Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91931C43143
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEBB2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 00:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqBwf4fA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CEBB2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbeIKFei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 01:34:38 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55169 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbeIKFeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 01:34:37 -0400
Received: by mail-it0-f67.google.com with SMTP id f14-v6so32053877ita.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 17:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z7FB6bqAOlG4uIEe/nr0yx2nqUjewBB/CMSvvMakjfI=;
        b=pqBwf4fAPDJWIkQkunFO0US7T+cT09SxEgSF8P6IusI4+/OeE2G+UYRR30D2REydNp
         AJLw3fjYoS8PNLeMkJlqdt+MPM91LxoW2UEKTWNqamIYfty7Ih8Xb5Tz1sl0HImwgRix
         1AoIdovTLRIYGQFnViN+mVRgYKx+0AS7PCg5vDEtPiTdii5WN04/LMhJXj5v63e/lix1
         nOsP+osKkBxQr+E6glIynnUX9MhgIDLPg6OHnpf4afKidVzj+dgMI8UoUcXu8oVeFskb
         3CJNIbuxhf+GTmkw+ee0xAm8g3QGfiak2PQneim5JEmlTrLhAc7JnC/8apQTGZoV+M2Y
         pRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z7FB6bqAOlG4uIEe/nr0yx2nqUjewBB/CMSvvMakjfI=;
        b=jtzqt/jk9P600l4wp839a/CLfEaDiuCbBxWB5v/WzOU6i5M0WvuO8HBhOEoPj0iW1l
         kX5CKFUDiZo3JsEZfrprpqONLaf1tsdP1DpZNnA5SNWHW0Zqhpd2DjhUystZFpQ375C4
         Tv5WOAvKhbsX67Iy4JRkfnblP8LrFfnvd2vxC4u3CRcxMgz/ZtMUT0zmYGCo5QiRpuuO
         GXMG4vQ3jQgKn22DCBjnbyIQ0DTRIGpm/2X09VHLp76lwTlNFspqZrWUvJc0KV8tlgdX
         gcor/6yrixlQHJgUE6pcS8aZvrBvtj8y8GH6DqHNn8hEH6ril8W9BVY7U7CexopP+ZCy
         pdCQ==
X-Gm-Message-State: APzg51BYcqkHgkCzMQalFfg+BKAzVpGaUJDK9RgfApOmL29bNfdzCVzh
        fbTO9P8hZvDJ40Ka5iFKVF1A5qGB1aSZXFOWs9g=
X-Google-Smtp-Source: ANB0VdZEFsMhSn3KiONpv3gt++IF1LcwLOAQ6WgM8h3cJfPQHzqn+xtRJNM/z2oex7ejPBxv81mVZahNA81R6lbl5/Y=
X-Received: by 2002:a24:ed84:: with SMTP id r126-v6mr21634946ith.58.1536626282318;
 Mon, 10 Sep 2018 17:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180910232615.4068.29155.stgit@localhost.localdomain> <20180910234400.4068.15541.stgit@localhost.localdomain>
In-Reply-To: <20180910234400.4068.15541.stgit@localhost.localdomain>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 10 Sep 2018 17:37:50 -0700
Message-ID: <CAKgT0UceRHjfoKPxAJEchX4O91j_mtCQxqjTSQ=GJSoSOGbWmg@mail.gmail.com>
Subject: Re: [PATCH 4/4] nvdimm: Trigger the device probe on a cpu local to
 the device
To:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-nvdimm@lists.01.org
Cc:     pavel.tatashin@microsoft.com, Michal Hocko <mhocko@suse.com>,
        dave.jiang@intel.com, Ingo Molnar <mingo@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>, jglisse@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>, logang@deltatee.com,
        dan.j.williams@intel.com,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 4:44 PM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> From: Alexander Duyck <alexander.h.duyck@intel.com>
>
> This patch is based off of the pci_call_probe function used to initialize
> PCI devices. The general idea here is to move the probe call to a location
> that is local to the memory being initialized. By doing this we can shave
> significant time off of the total time needed for initialization.
>
> With this patch applied I see a significant reduction in overall init time
> as without it the init varied between 23 and 37 seconds to initialize a 3GB
> node. With this patch applied the variance is only between 23 and 26
> seconds to initialize each node.

Same mistake here as in patch 1. It is 3TB, not 3GB. I will fix for
the next version.

- Alex
