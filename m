Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC7AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203AC2192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 18:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391501AbeLUSob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 13:44:31 -0500
Received: from mga06.intel.com ([134.134.136.31]:58656 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389288AbeLUSob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 13:44:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Dec 2018 10:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,382,1539673200"; 
   d="scan'208";a="305793588"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by fmsmga005.fm.intel.com with ESMTP; 21 Dec 2018 10:44:28 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id ABD1C301036; Fri, 21 Dec 2018 10:44:28 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Richard Biener <rguenther@suse.de>,
        Nadav Amit <namit@vmware.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Michal Marek <michal.lkml@markovi.net>,
        linux-sparse@vger.kernel.org, Alok Kataria <akataria@vmware.com>,
        Juergen Gross <jgross@suse.com>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v2] x86, kbuild: revert macrofying inline assembly code
References: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
Date:   Fri, 21 Dec 2018 10:44:28 -0800
In-Reply-To: <1544928632-9717-1-git-send-email-yamada.masahiro@socionext.com>
        (Masahiro Yamada's message of "Sun, 16 Dec 2018 11:50:32 +0900")
Message-ID: <87woo23ek3.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro Yamada <yamada.masahiro@socionext.com> writes:

> Revert the following 9 commits:

FWIW the -Wa additional also broke LTO builds because it doesn't really
support -Wa for individual files.

So I'm glad they got reverted.

-Andi
