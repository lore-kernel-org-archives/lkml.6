Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA47C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:16:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 617D720823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 01:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 617D720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=electrozaur.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeKAKQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 06:16:43 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38991 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAKQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 06:16:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id r10-v6so18475247wrv.6;
        Wed, 31 Oct 2018 18:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=SOummR0OYsn3JwCSP4lWF9xfIF3EqrWJXD2qHXOVhZg=;
        b=N5PoBQCiCngnOuSPZ6XreGs59vMZAOXLv1mDwGl21M83Oth4lGZFjmscYB8Ek6BDwT
         JeAM8As1ix0KFWdjuQimkBVqL+IgHFDHszUV+LQRujhR1RZ0KyFGLKYsCuF9ftLkJeJy
         2TZvIj9WjQjscTWOuX4ghCoPdk2HD0lnVLfYjB69drERd7wOP0QrtwY+ZUMxGByyBbRl
         HSHG7Ego0FjTdus0F2cQP0Zo1P4mnaqU1/W0AL9s7hU/BEwtzi6K8MVvP3OO5FZafTOu
         FnwR1hX7VZYFq5rjfxzRkzWVnhgopDig5mweTciD5hN6pfSJpp1vk43sPGyx6xEMj1RX
         Obfg==
X-Gm-Message-State: AGRZ1gK0F9xZEgLxwbe4Ax9j9LL/noiEwo3DRxNi2vps9ewM2+WUwxa4
        G7lITVZbhDQY+BS4yWVKchoxcxL9
X-Google-Smtp-Source: AJdET5f+J5adCfhV1MgJuYPtq9BTAVzuZptDDpasSV9UU6lOSPKhRxzaD/S30DNOMdu5YEidMkz2+g==
X-Received: by 2002:adf:84c1:: with SMTP id 59-v6mr5156653wrg.144.1541034959305;
        Wed, 31 Oct 2018 18:15:59 -0700 (PDT)
Received: from [10.0.0.5] ([207.232.55.62])
        by smtp.gmail.com with ESMTPSA id y76-v6sm21171857wmd.37.2018.10.31.18.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 18:15:58 -0700 (PDT)
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org>
 <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
 <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
 <1538521591.193396.8.camel@acm.org> <20181025213144.GB24709@flashbox>
 <CAKwvOdn=TvoGdFvgxX6TyXBXnhVLttriRrZEnzS6DjcjL64DPA@mail.gmail.com>
 <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
Cc:     bvanassche@acm.org,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
From:   Boaz Harrosh <ooo@electrozaur.com>
Message-ID: <65187f1a-4e67-3d96-ea97-e37c8bf87e48@electrozaur.com>
Date:   Thu, 1 Nov 2018 03:15:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/10/18 20:54, Nick Desaulniers wrote:
<>
> 
> It's hard to say without knowing the original intent of the code.
>>From the variable's identifier and fact that it's global, I *assume*
> that we want only 1 struct osd_obj_id which is the root, hence the
> identifier `osd_root_object`.  It has 4 references in the entire
> kernel; it doesn't make sense to my why those references would want to
> be referring to two different instances of `osd_root_object`.  Maybe
> the maintainers can clarify if 2 instances is the intent?
> 
> Further complicated is the use of the __weak attribute AND the
> compiler flag -fno-common (which the kernel sets in the top level
> Makefile).  Also, it seems that ODR is a C++ concept; it's not clear
> to me if there's semantic differences with C or not (I don't think so
> in this case, but I've learned not to bet on subtle semantic
> differences between the languages not existing).
> 
> __attribute__((weak)) AND static on a global variable declared in a
> header raises many red flags to me.  Was weak added to work around an
> ODR link error?
> 
> If creating one instance of this variable is a functional change, I
> can't help but suspect the original code was wrong.  But maybe Bart,
> Boaz, or Christoph can clarify or have more thoughts on this?  Looks
> like Boaz added this header in commit de258bf5e638 ("[SCSI] libosd:
> OSDv1 Headers").
> 

Sorry for the late response. Was off line for a bit.

The original patch and all its permutations are all correct
the definition of osd_root_object is just a fancy type cast of
couple of zeros. IE a couple of zeroes with the right type. So they
can be simply compared to retuned and sent line content. So it does
not matter at all what change is accepted.

I'm so sorry for your trouble and test development. It could all
be saved if I was noticing this thread.

I will ACK again the original simple V2 patch.

Thanks
Boaz

<>
