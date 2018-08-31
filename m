Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3298FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AC520837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Vj9Zz+nc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5AC520837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaFJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:09:16 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:54395 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbeHaFJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:09:16 -0400
Received: by mail-it0-f68.google.com with SMTP id f14-v6so5111265ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrVKAMkrRBoINoVTjKKNs0slJwNwmhIfvOE2RWqfGt4=;
        b=Vj9Zz+ncgE3e1Cb9TxCzAZUDClXA90bWyD3bW0BiHPMOUzjAwPLEjv7GslCP0SrUU7
         J0TxlRHaWsgd6KG6Y5MrYcPDfaDCsiebwmyvPCcfrPQEJQOyPlU6m4zQbvYt9G4SmLtB
         CbJbVtfoZwAEepFE7Y6Vwf7Ztmi8OJzaxqSb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrVKAMkrRBoINoVTjKKNs0slJwNwmhIfvOE2RWqfGt4=;
        b=hl5afETaNvPjdnoO0dbQ8QvnNXZ9Hv/UkhRVjIRp9VsBbY3IAi8MxYqJ8skIx5FZw7
         2HtCu5oiDSIjbWJbJ9m2K+9JA/uk9e1+fRF+VC4kNvrPIscrABrf+t/W09CpI5Xsbm/Z
         D8m6M4Ew2Mn2YZYcSH1j7Siiw3k2t+QCtHa8SzqWcXsLtiOUnjMKJivNPhUxvumuj8Ku
         rkdGCjdoUBUHAwmm3bXzFl09kOyvaHKir0zpNkjkylgCoUtscnUTVU+VuEcVGrFGsBoj
         aMyixzhVPD3UPUYllk9W70SeKfZ86nICI0oWitKi50JSYG2HcNrxzu0v3tLIO/IM38ap
         7sxw==
X-Gm-Message-State: APzg51B/ZpX7culB98wqTeuzhMd3Y4IiYG5YWGz2uEXOqIB6eR2qnO3q
        +rEsKeMXL0zAC3seI2+2yZqiH+9Hq2HAZyXm18M=
X-Google-Smtp-Source: ANB0VdaicBA6c8dYhcke39TO0UtXPpMPXDUl5DQsoW1G1vPcbLEUsESDEfPhlgvIGiDnfa5UbxdMGk3KVrIH50LLcak=
X-Received: by 2002:a02:9d45:: with SMTP id m5-v6mr10905599jal.72.1535677463743;
 Thu, 30 Aug 2018 18:04:23 -0700 (PDT)
MIME-Version: 1.0
References: <1535645747-9823-1-git-send-email-will.deacon@arm.com>
 <CA+55aFzMMU5RBhn52Lbzf-FXvx3inh5VPVZL613srY+dVU+Lxw@mail.gmail.com> <20180831110054.475a3534@roar.ozlabs.ibm.com>
In-Reply-To: <20180831110054.475a3534@roar.ozlabs.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Aug 2018 18:04:12 -0700
Message-ID: <CA+55aFyweLwdAeeLnPv1ceje2y9Qc2AkM+LdMzK_z29fFb96ug@mail.gmail.com>
Subject: Re: [PATCH 00/12] Avoid synchronous TLB invalidation for intermediate
 page-table entries on arm64
To:     Nick Piggin <npiggin@gmail.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benjamin Herrenschmidt <benh@au1.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 6:01 PM Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Well it would help if powerpc say wanted to start using them without a
> merge cycle lag. Not a huge issue because powerpc already does
> reasonably well here and there's other work that can be done.

Sure. If somebody wants to send the generic changes I can just take
them directly to make it easier for people to work on this.

               Linus
