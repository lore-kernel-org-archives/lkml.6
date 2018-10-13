Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC45C71122
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02BCD206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="hDGEHqrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02BCD206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJMXoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:44:01 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35918 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbeJMXoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:44:00 -0400
Received: by mail-ot1-f65.google.com with SMTP id x4so13742407otg.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Oct 2018 09:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cSy8aZNbc+Fp01O7mr7iurX03QUJ9OJYlQTrAqkvWPw=;
        b=hDGEHqrgK4JSJfehJqv2wXlWnet/OGIHzcUE3UOm0uULgIRbkjOJmYaKaXeiRvwa0s
         86kuBoD+TNbeKTHvMIsa7UuuAWHucbuhj7azuQIBTwAX4kSCQeKQiPN53a6X/dt4lmfo
         1uxMrGVYgojBA3jzUxilsidTGChVg4XJm8pnqOP7Z8aAKMF2nAcnjqVN0dzEItcL/Vr+
         PcLpNw3rkruXvBC65QhQbQ8MupdIy8e8nO4XtDTH69LLLbVxrXx4cQU8ZYoxl+YK8U3P
         NgONb0vL+sS+zCrWaDQ9cYtgfiztgX/hmylGsFIVD0rG7lGvDeu9Fg/i4DjSMFtIyjE9
         LV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cSy8aZNbc+Fp01O7mr7iurX03QUJ9OJYlQTrAqkvWPw=;
        b=VNOCYZ5ZoH+vcud9Y8ZMZPlBd1njk7Jk97dot6bkk1WwksHjcRxU8NobRfrwaL0nR8
         5VGOWCwS7z1vplqXKs/O9IyM3X62/kAjWYY4kkLXBE0q3ITJ3qJs4tmtPM2OWK3eUXCl
         mib4omCWLqije3OZ3+ei7k0V4NedVNQtDIYBS1EKppRNeoftwQE76vzaP+mBr/AIfzsl
         RzmOljXrg71Z8rnbeAd03rERmbl2OevD6tMrkxRHngtLF+ZSl+/2KkwfY1Y8rt5oLikU
         R3rsbSmrBpf+mu2yFQ41+taRygiowNtsPS4Mz1vHZQURpoleKjBMtKr3fKKlxZoTIsDg
         aoCg==
X-Gm-Message-State: ABuFfoi1Tma27woWjbjzJqee97qXgXOl6r3RyPEIq8OgajBAYzCmpHRf
        QHOhpQ++XzLn7ORDaRkPDLcHjC6C/6ckQ+ZCRK/JVA==
X-Google-Smtp-Source: ACcGV61+6NRZBHTaiFPGRH1TESsnwhHDwWtzvsoWrQ3EkoGniQ7N5R2WTV3014lMC/rNJ3q4U3pDJ5boaYucGeZWenE=
X-Received: by 2002:a9d:758f:: with SMTP id s15mr6414736otk.353.1539446778225;
 Sat, 13 Oct 2018 09:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181013050021.11962-1-pagupta@redhat.com>
In-Reply-To: <20181013050021.11962-1-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 13 Oct 2018 09:06:07 -0700
Message-ID: <CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] kvm "fake DAX" device
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 10:00 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>  This patch series has implementation for "fake DAX".
>  "fake DAX" is fake persistent memory(nvdimm) in guest
>  which allows to bypass the guest page cache. This also
>  implements a VIRTIO based asynchronous flush mechanism.

Can we stop calling this 'fake DAX', because it isn't 'DAX' and it's
starting to confuse people. This enabling is effectively a
host-page-cache-passthrough mechanism not DAX. Let's call the whole
approach virtio-pmem, and leave DAX out of the name to hopefully
prevent people from wondering why some DAX features are disabled with
this driver. For example MAP_SYNC is not compatible with this
approach.

Additional enabling is need to disable MAP_SYNC in the presence of a
virtio-pmem device. See the rough proposal here:

    https://lkml.org/lkml/2018/4/25/756
