Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B85C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DED94217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 21:44:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfAVVoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 16:44:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:48158 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbfAVVoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 16:44:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2019 13:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,508,1539673200"; 
   d="scan'208";a="128046630"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 22 Jan 2019 13:44:15 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B3876301202; Tue, 22 Jan 2019 13:44:15 -0800 (PST)
From:   Andi Kleen <ak@linux.intel.com>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Page flags, can we free up space ?
References: <20190122201744.GA3939@redhat.com>
Date:   Tue, 22 Jan 2019 13:44:15 -0800
In-Reply-To: <20190122201744.GA3939@redhat.com> (Jerome Glisse's message of
        "Tue, 22 Jan 2019 15:17:44 -0500")
Message-ID: <87tvi074gg.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Glisse <jglisse@redhat.com> writes:
>
> Right now this is more a temptative ie i do not know if i will succeed,
> in any case i can report on failure or success and discuss my finding to
> get people opinions on the matter.

I would just stop putting node/zone number into the flags. These
could be all handled with a small perfect hash table, like the original
x86_64 port did, which should be quite cheap to look up.
Then there should be enough bits for everyone again.

-Andi
