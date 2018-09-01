Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9FAC43334
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F83A2083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 21:39:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QNPGUg40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F83A2083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeIBBwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 21:52:13 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:32779 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbeIBBwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 21:52:13 -0400
Received: by mail-it0-f68.google.com with SMTP id j198-v6so8022517ita.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GkTMCcglEBhcl1YvI/gHbFFZsQjLvmpgheBH3+VO98w=;
        b=QNPGUg40dTUDloTXgGYbuFXGEImS2PfyUQ+dSwZU2isYyTrU5TIH5RB0K14im5ekrU
         +Nrk26aG/nRQAUXwFfdrvjJSvnHJdg38QKs7C90kjWpThzuMA2oyRZOfS/HNgmg4qoFM
         MXQsnOaH1pcClCEsuSlFlMRYrpmB0iByHAPOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GkTMCcglEBhcl1YvI/gHbFFZsQjLvmpgheBH3+VO98w=;
        b=l1aEObMzAwHlTfQCWpnq0mHM48e6p/rjMelyEmiKIaEts2LtHJYj/VrGYo4kFExMUw
         q1mTsI9X6c6yte2A4jWV4HXxhzvqTiiPBIvk9sQ0uyJGNoOCn0Px+Rgt0hD1tYa3Kx/1
         0JLlIXNaAZ/ZdUJyQzDm/fX878QJYHl0GKYVD9mXGPK6BzGp4trlBNeURImMzSmZC15t
         rdQbJiHH4AXjoFIfMpn03Aua3Djo7o++PQUujZahAsPVlVABr2hmP/i1cmvgHRNyS/fW
         DJWyxllQELk9k+OiOpFE1VjKOHPn8HMOLz8Mc5bd/9iZp3FzhZ8KsE+v+i4TGIu4558+
         wrmA==
X-Gm-Message-State: APzg51DgEAdV7mra7TNODRIb5LxO1rvaGFB1tKHWN9GcoD8nkfxOEoF7
        G14tq53YNMVp+nm2XQfew+4f3RZubmlDZUWuwLk=
X-Google-Smtp-Source: ANB0VdYnB/D6k3xoiCv5X9hW9mgakolSahbYzgnxPB4iHtrbBT6xgxiam/I0JQH2rpOHZqH4Daj53bl82905koBp2JU=
X-Received: by 2002:a02:702:: with SMTP id f2-v6mr16499858jaf.70.1535837934711;
 Sat, 01 Sep 2018 14:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFxyUdhYjnQdnmWAt8tTwn4HQ1xz3SAMZJiawkLpMiJ_+w@mail.gmail.com>
 <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
In-Reply-To: <ciirm8a7p3alos.fsf@u54ee758033e858cfa736.ant.amazon.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Sep 2018 14:38:43 -0700
Message-ID: <CA+55aFzHj_GNZWG4K2oDu4DPP9sZdTZ9PY7sBxGB6WoN9g8d=A@mail.gmail.com>
Subject: Re: Redoing eXclusive Page Frame Ownership (XPFO) with isolated CPUs
 in mind (for KVM to isolate its guests per CPU)
To:     jsteckli@amazon.de
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        juerg.haefliger@hpe.com, deepa.srinivasan@oracle.com,
        Jim Mattson <jmattson@google.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-mm <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        joao.m.martins@oracle.com, pradeep.vincent@oracle.com,
        Andi Kleen <ak@linux.intel.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        kanth.ghatraju@oracle.com, Liran Alon <liran.alon@oracle.com>,
        Kees Cook <keescook@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        chris.hyser@oracle.com, Tyler Hicks <tyhicks@canonical.com>,
        John Haxby <john.haxby@oracle.com>,
        Jon Masters <jcm@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 12:45 AM Julian Stecklina <jsteckli@amazon.de> wrote:
>
> I've been spending some cycles on the XPFO patch set this week. For the
> patch set as it was posted for v4.13, the performance overhead of
> compiling a Linux kernel is ~40% on x86_64[1]. The overhead comes almost
> completely from TLB flushing. If we can live with stale TLB entries
> allowing temporary access (which I think is reasonable), we can remove
> all TLB flushing (on x86). This reduces the overhead to 2-3% for
> kernel compile.

I have to say, even 2-3% for a kernel compile sounds absolutely horrendous.

Kernel bullds are 90% user space at least for me, so a 2-3% slowdown
from a kernel is not some small unnoticeable thing.

           Linus
