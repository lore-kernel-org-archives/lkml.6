Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69D6C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 652BA21836
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 19:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Deb/anuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbeLPThh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 14:37:37 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44076 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730747AbeLPThg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 14:37:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so7866998lfe.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhaHyVhc63MzSY3yf2QAnmgzLKrW87+qU0wix3hm9f0=;
        b=Deb/anuvet0KUnP1M84Olye3QqbZdP758tOHfAhXxvHnBYl+yOjd00ejqoeO7D0sa/
         m30wXMg5JEJ1O9/ANwXKZNH8uDiD3kpInAhIG1C3IqIwE4VT4bxCHfTJGWk9at9CcW5p
         qc3ToOJ58WyaVvT5JDFJnpbPxDEsP0OJPiorI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhaHyVhc63MzSY3yf2QAnmgzLKrW87+qU0wix3hm9f0=;
        b=S6V/MbvVN/TmvvxdIRQKYL/5TCJwOokPaVFx8RG4LOtaacI08LTUVU33KXukenZ5pq
         bJkXOIr5asIZX7CDwox28J7z4p9bCEuBCw9rI45GhzRSMjn/GqyeUR2FoaYcfSVq0EDQ
         O8nWaLnykO6IZFGf8DPkrqs+Ay8yeVNO3fUP856z84cjWtDRLRong4eucG/+ROq5FoV9
         LuGuvRcgK53AqZujcs/inCMli46OXkR0BSktjvbTQRvId5F9BUZahysi6wfvSh44MwAm
         szw4QnPIlplrpecaaEMLTMP7NZLg49zSvcVQrEVvsVd9Jq0muE/6HYxFQAih90EaJelm
         8fIg==
X-Gm-Message-State: AA+aEWYXx3rriqPMurg6nq4dhjhNLDxONweB/4Zt9pgUktYiz1wP8DXD
        PAN2U/0GcNRQh8sICpRoDGMYrjQdWLM=
X-Google-Smtp-Source: AFSGD/Vo3aTI7uesnCvYFhJItNLA1/Rv2nRo9nP0NTKLjwsaVE0wGD3gmUdlPZIBmwGL5gEmL72hzQ==
X-Received: by 2002:a19:7919:: with SMTP id u25mr5521596lfc.18.1544989053222;
        Sun, 16 Dec 2018 11:37:33 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2088282ljf.96.2018.12.16.11.37.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Dec 2018 11:37:32 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id v15-v6so9078072ljh.13
        for <linux-kernel@vger.kernel.org>; Sun, 16 Dec 2018 11:37:31 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr6413154lji.133.1544989051486;
 Sun, 16 Dec 2018 11:37:31 -0800 (PST)
MIME-Version: 1.0
References: <1544824384-17668-1-git-send-email-longman@redhat.com>
In-Reply-To: <1544824384-17668-1-git-send-email-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Dec 2018 11:37:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi-V7LjAAzFuxg+eLQAdp+Ay4WmVJdTNxgPjqKXaj-3Xw@mail.gmail.com>
Message-ID: <CAHk-=wi-V7LjAAzFuxg+eLQAdp+Ay4WmVJdTNxgPjqKXaj-3Xw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 0/3] fs/dcache: Track # of negative dentries
To:     Waiman Long <longman@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org, mcgrof@kernel.org,
        Kees Cook <keescook@chromium.org>, Jan Kara <jack@suse.cz>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, mszeredi@redhat.com,
        Matthew Wilcox <willy@infradead.org>, lwoodman@redhat.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        wangkai86@huawei.com, Michal Hocko <mhocko@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 1:53 PM Waiman Long <longman@redhat.com> wrote:
>
> This patchset addresses 2 issues found in the dentry code and adds a
> new nr_dentry_negative per-cpu counter to track the total number of
> negative dentries in all the LRU lists.

The series looks sane to me. I'm assuming I'll get it either though
-mm or from Al..

            Linus
