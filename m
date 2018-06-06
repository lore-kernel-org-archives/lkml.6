Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id SqAqJsZyGFv+MQAAmS7hNA
	; Wed, 06 Jun 2018 23:48:22 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8319B608B8; Wed,  6 Jun 2018 23:48:22 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="X2CybG7Y"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 035CC601D9;
	Wed,  6 Jun 2018 23:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 035CC601D9
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbeFFXsQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 19:48:16 -0400
Received: from a9-114.smtp-out.amazonses.com ([54.240.9.114]:59178 "EHLO
        a9-114.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752093AbeFFXsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 19:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1528328894;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=kBf++yF18/HSyDlaDDNq7JiFV31WDEMUHr34BamH9cI=;
        b=X2CybG7Yftab05DJyXoO1AFeb0jYemWy4ckhL7dnhJA/cH6MOWMnMeHCkrPXcd5a
        5TRm9XWixAgHDSb589B5QfPm8xfKxJVYd8Uciyu9/jv5Q/odWnsRWislzAv4WZRdWiW
        ocMsuAvE1RahqSOWnlwrvtd11Tzk1lFT+teEasaU=
Date: Wed, 6 Jun 2018 23:48:14 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Baoquan He <bhe@redhat.com>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH] slab: Clean up the code comment in slab kmem_cache
 struct
In-Reply-To: <20180606012624.GA19425@MiWiFi-R3L-srv>
Message-ID: <01000163d7803909-286c20d2-9928-4e07-94fc-ee6552e04c67-000000@email.amazonses.com>
References: <20180603032402.27526-1-bhe@redhat.com> <01000163d0e8083c-096b06d6-7202-4ce2-b41c-0f33784afcda-000000@email.amazonses.com> <20180606012624.GA19425@MiWiFi-R3L-srv>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.06.06-54.240.9.114
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2018, Baoquan He wrote:

> I am back porting Thomas's sl[a|u]b freelist randomization feature to
> our distros, need go through slab code for better understanding. From
> git log history, they were 'obj_offset' and 'obj_size'. Later on
> 'obj_size' was renamed to 'object_size' in commit 3b0efdfa1e("mm, sl[aou]b:
> Extract common fields from struct kmem_cache") which is from your patch.
> With my understanding, I guess you changed that on purpose because
> object_size is size of each object, obj_offset is for the whole cache,
> representing the offset the real object starts to be stored. And putting
> them separately is for better desribing them in code comment and
> distinction, e.g 'object_size' is in "4) cache creation/removal",
> while 'obj_offset' is put alone to indicate it's for the whole.

obj_offset only applies when CONFIG_SLAB_DEBUG is set. Ok so that screwy
name also indicates that something special goes on.
