Return-Path: <kernel-hardening-return-12780-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4/jNq35sKPORMYwWpgqjNak2PK7QKJIEgmSpU+0AODgPIoPqgvQ8dwkWfqxVhi5W28aqFwh
ARC-Seal: i=1; a=rsa-sha256; t=1522191861; cv=none;
        d=google.com; s=arc-20160816;
        b=G50gcAaziEGiHmX2XcQY6YKa1R/fPy4+AwtsClrtNFINKWHAdtwKuvbvOIEPJfdU49
         nc+2X3QMdaJo5XOO0hJPY6Gk/saim6LyDV/OECbH/iXEWlq7vmNDJUdoaYTg8bAscVQB
         XVJnhttrG5mDfMhn1EVBX1ED2suMrg2UuX9QMovpsJBv80Ezfb1qPfJldbxv3TlfkGAL
         3myXl2iFu0bQereE2R40pO63na1fgSdntZXqgln+ye35oLqw0ChkAkH/0kWox9DJULfe
         U9TcGCK5hDsG7adhYzNSNb994MrGwk3Mk7o8LWGS14z8sXSHSa+JsRbf1SNJdzH9tFae
         VV6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=VWwcXXOznrDGQX76H6QmCjOTSTwEQrF/BM2ohV+/zJg=;
        b=ChRZcDTRDV587aqNXxtmUJuS997EM2E1ssjk1UHD9SosGk+JNc6gv/k8IN38VXnyii
         tII+bMh0FHlyk6SrqCM+WoQFDQs8qToFfdT8RiS5XQg5zJpDu402c/hdNr8g8AuoKW8Q
         b/jC3FLjQi5fOQX7v/rRT2S6hZ2vuMZfJS/Ly7ym3foeZJXe1TF7/3HhMiCaNaaer/fL
         l5sRAauc1GT3K7dyEm7/Pi1cpOVGy0cIwHZj8ot2LOb5Ka6fmlTupYV1aEqEycW3WVqT
         1RNN49MuTqwZne7FYscoGtXQTyizhAR+y7BrTgMU3QtBGey6/Pjnaa3MWNVWw8WAm0CP
         d65g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12780-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12780-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12780-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12780-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Tue, 27 Mar 2018 16:03:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [PATCH] task_struct: Only use anon struct under randstruct
 plugin
Message-Id: <20180327160342.e2bc9a15afda5823c8daf4fb@linux-foundation.org>
In-Reply-To: <20180327213609.GA2964@beast>
References: <20180327213609.GA2964@beast>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596128328848013628?=
X-GMAIL-MSGID: =?utf-8?q?1596133853939225190?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 27 Mar 2018 14:36:09 -0700 Kees Cook <keescook@chromium.org> wrote:

> The original intent for always adding the anonymous struct in task_struct
> was to make sure we had compiler coverage. However, this caused
> pathological padding of 40 bytes at the start of task_struct.

Why?  What caused this padding?  It happens in all configs?

> Instead,
> move the anonymous struct to being only used when struct layout
> randomization is enabled.

So the mysterious 40 byte bloat is still present in this case?

> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Fixes: 29e48ce87f1e ("task_struct: Allow randomized")
> Cc: stable@vger.kernel.org

Why cc:stable?
