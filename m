Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D59CC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82C92089D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 12:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KmJ/1ZZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82C92089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbeJATEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 15:04:36 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37611 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728979AbeJATEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 15:04:35 -0400
Received: by mail-ed1-f66.google.com with SMTP id c22-v6so402865edc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 05:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2IKVt2EI1/uVgQmHg2N9MGYYewpWN3kcNyNdgXhAIxA=;
        b=KmJ/1ZZYnNlhd3AXNRc4IS9RW6ZoAg5TAyQc/abs8Z6vYZBmwHDniAgH3+nf0aq44j
         wmAx231Z9rWW0zs4Ih8U8JYBfeZHs/OO8U+lGSw1Iq39MFt3h0/VOcndTaITNaEE4zyJ
         7Vsb5vT4IrTqKMKsuClOQ0NiRYhrMYKuDDOgeaZmEVlfz3NV8uk8I2vf3Rha/7X3Gz8t
         ofWcOtxwfrIIHLoxr8masOcWgrU7sMio9umSw8yZhnFUb9X8E0NftciOpVlPf4m3G7d/
         ABgtF4KqPIs4R0+f6XMDUGSGS0iJI3OSYBYIncfu1aMzOkpDWljNja9F7VjXkyFaIfJP
         mHiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2IKVt2EI1/uVgQmHg2N9MGYYewpWN3kcNyNdgXhAIxA=;
        b=CJGnYRdqRkiiJwYzr6ObdxY1kkMKGILJRfUWnncJec64laW41LpTIs66Wsu0fuqNsw
         jAKBbozdHfWLDngRvJYgpm/Y2l49iziMee03YKVTV+J8IOUCWw5/FL4/L5+hVN3orA40
         Xckte9KKTPQUac932/yAHZ2Gc1U3f/vx0oX/9RNhB1nZFSWz1ESj+PaWyzgOZfZYZNwq
         zcUYui+USdw/H4YenovXHk3pAR0Kis8hp9Y5DZvEbgiNeu5bN28BDyjWr8JpPGgIiW5b
         jQgAh/yIJnvoyXYbJCHA8zwgdAAmkiuRNYamZX39p2tMJ9OkWASv0cj7SZKavV4T6WOR
         xoFQ==
X-Gm-Message-State: ABuFfohZgS83AsgLU97rSyv4oTWlzxgZfveGvM8D6PHu41QNSnQ8xseh
        GWoMC8JxApONYFnhFz0CRTCIYg==
X-Google-Smtp-Source: ACcGV618fMlPKg7UkXLeaJJW+wfT1vQrXJ+Geqg8LEYviBLu735YrdItxPdqN32WQDg6qyD4Q4spQg==
X-Received: by 2002:aa7:df8f:: with SMTP id b15-v6mr17653810edy.196.1538396820685;
        Mon, 01 Oct 2018 05:27:00 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id d11-v6sm5650083edo.39.2018.10.01.05.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Oct 2018 05:26:59 -0700 (PDT)
Message-ID: <1538396819.4348.86.camel@arista.com>
Subject: Re: [RFC 0/2] ns: introduce binfmt_misc namespace
From:   Dmitry Safonov <dima@arista.com>
To:     Laurent Vivier <laurent@vivier.eu>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrey Vagin <avagin@openvz.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Date:   Mon, 01 Oct 2018 13:26:59 +0100
In-Reply-To: <d1b6b52b-dd7f-fa27-eafa-7a6a43a03b92@vivier.eu>
References: <20180930234628.25528-1-laurent@vivier.eu>
         <CALCETrWcQtLTVJU14ytWxu_gqoLuAYZJpyAvRsKwwgYZz7FEFg@mail.gmail.com>
         <d1b6b52b-dd7f-fa27-eafa-7a6a43a03b92@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent, thanks for Cc,

On Mon, 2018-10-01 at 09:13 +0200, Laurent Vivier wrote:
> Le 01/10/2018 à 06:45, Andy Lutomirski a écrit :
> > On Sun, Sep 30, 2018 at 4:47 PM Laurent Vivier <laurent@vivier.eu>
> > wrote:
> > > 
> > > This series introduces a new namespace for binfmt_misc.
> > > 
> > 
> > This seems conceptually quite reasonable, but I'm wondering if the
> > number of namespace types is getting out of hand given the current
> > API.  Should we be considering whether we need a new set of
> > namespace
> > creation APIs that scale better to larger numbers of namespace
> > types?
> > 
> 
> Yes, we need something to increase the maximum number of namespace
> types
> because this is the last bit in the clone() flags and the time
> namespace
> has already preempted it.

Yeah, there is this last CLONE_* flag..
I tried to use that 0x1000 flag for something like CLONE_EXTENDED with
all parameters on the stack, but not sure that's reasonable and maybe
someone will suggest a better solution.
All those different clone() ABI (how many parameters to supply and in
which order do not help much).

-- 
Thanks,
             Dmitry
