Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C75C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4D1521470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 09:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8KT9FTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D1521470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeJDQJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 12:09:16 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54879 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbeJDQJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 12:09:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so8313334wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 02:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wfqb7I++3Lm+fPfpeoNNFiZBq3A2jlL3UXmrpPyd4gA=;
        b=u8KT9FTDUc+DhwF+joIhMaBwWcOTjUP5lmj1zlP+hZQk9xX9u4JNvCkfjkxkswXxT3
         jU6HpOCD7br7jUDjqAhostCR1Ux+hQtM6ElJIIqL+CodOLgKPaa8ibQMlF72Gw3IlJwJ
         b4ttV5gVuarhbnr1bfROR+wxTywXAkfuq8l/bHlwW0bz/0o/vRFXZp+8buxwQfMLdGJQ
         FdoEcOutOC0uZ26d/pd5+LJEugc0w0buaWh2CaJuPKKwvHfVVhXmFWVkUDvVgmhmqMcw
         5gryBu57l221fC9WjH2HaeP944i77XsmxCiePCtLg1e6r/IHH3z0QXE+DJgHeQJbKHPV
         sm2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wfqb7I++3Lm+fPfpeoNNFiZBq3A2jlL3UXmrpPyd4gA=;
        b=SaLDfftb9ZeVdOLitmX5lGdkdNmaBIhIYY9QKfHa027kFZqVT8BGupHa+7eAZkRFG4
         ykrj5IXRzK2aOoTMtV3IkO/x1pFNas6gHtzRzV3S89hin2vkgzVyiOVAGHpnwioi+ahZ
         xtHUm3SkmDqTwbXMvhk96SufrpZfPvu9A+slu7IAgRkteLC8FMy9Wuaqre5j/o0NTtFd
         yIWDE0omA6SQ0jW5I1A8Gsh3sAR1Eop/7aUOMuftGL79lJN6hamj/2hm0Nv0CbNtPOSe
         /+V/VXFkRsyxwh4PX5j1AhnD3pjiLFaJTLS8Z+/9G+ATzQyxl+iAP6MfnpTQN4wTydZ/
         D6IA==
X-Gm-Message-State: ABuFfoiMYrTZtg3Jb5NZoEbshohDlpgzunYXrQk6nHtDIPT4ExaaMoxF
        fJYrXKu97gFg02l+IGm+cwE=
X-Google-Smtp-Source: ACcGV62iAsGDsEWICQWtsPyHoo5oTw1vILQkflAOx0Owg3vmGFweMZgvkYDaQblEtZTKIaXMN7YPNg==
X-Received: by 2002:a1c:383:: with SMTP id 125-v6mr4145284wmd.92.1538644614436;
        Thu, 04 Oct 2018 02:16:54 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y138-v6sm2856941wmd.2.2018.10.04.02.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 02:16:53 -0700 (PDT)
Date:   Thu, 4 Oct 2018 11:16:51 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     hpa@zytor.com
Cc:     Nadav Amit <namit@vmware.com>, Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jan Beulich <JBeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v9 04/10] x86: refcount: prevent gcc distortions
Message-ID: <20181004091651.GB21151@gmail.com>
References: <20181003213100.189959-1-namit@vmware.com>
 <20181003213100.189959-5-namit@vmware.com>
 <20181004075755.GA3353@gmail.com>
 <20181004083333.GA9802@gmail.com>
 <10D29A50-C352-4407-A824-0C3C06CD8592@zytor.com>
 <A5DED74C-A95A-48D8-AF68-39E23696385F@vmware.com>
 <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36D6F606-6922-4057-B1F8-2B30993962AE@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* hpa@zytor.com <hpa@zytor.com> wrote:

> Ingo: I wasn't talking necessarily about the specifics of each bit, but rather the general 
> concept about being able to use macros in inlines...

Ok, agreed about that part - and some of the patches did improve readability.

Also, the 275 lines macros.s is a lot nicer than the 4,200 lines macros.S.

Also, I'm not against using workarounds when the benefits are larger than the costs, but I am 
against *hiding* the fact that these are workarounds and that for some of them there are costs.

> I can send you something I have been working on in the background, but have been holding off 
> on because of this, in the morning my time.

BTW., I have applied most of the series to tip:x86/kbuild already, and will push them out later 
today after some testing. I didn't apply the final 3 patches as they have dependencies, but 
applied the basics and fixed up the changelogs.

So you can rely on this.

Thanks,

	Ingo
