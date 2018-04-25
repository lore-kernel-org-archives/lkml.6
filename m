Return-Path: <kernel-hardening-return-13139-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZoM9MxpgKQjTbUrMTl8l0pRK4WWrsvQe0goiPCXMOBl5SGajHeI0roGUZc83oWTAAO7PwKl
ARC-Seal: i=1; a=rsa-sha256; t=1524667365; cv=none;
        d=google.com; s=arc-20160816;
        b=aj8JSYz730fId3qzvlmc5V+AWRI+apFVZLJTCGJqJ27eQS/pfJLNVLJ7V3DcNzuqLi
         W1PUaL0erUQEQGoOCOROvP+jfUS1D0HnC7v3++L9yoTIno+13Px1hpxrqm8Lt0hzoM1y
         +g1R9OnX7tsz2feXpAVqVulGAVai2Ww/oXH/EHb33z/VO09z6FnSZFnY3xdSkfkNcVE/
         7tqvwiOXh3hpA5qe+nVyTmOrycMd7Ni/qiaBp2Dv9GhSxrHyuZgq8mhy0gH23vVqxq3U
         fhxw6Riok0rHM8PnNEq4WHBYRIhcnWHu9NrlYWawS4aay/4x0K8LN5fDjUXVpKv1+zQk
         oFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=ZQWoQPNM6GJ8UVjeRZYtuPZD9WLyhxVUa/o/h27VuFA=;
        b=fCeLEDFK+SkwGY2Db4CBbzz9JyovbcirkQwdv6S+AxOGvKV0MgxrtbGRoDVk9TjTY8
         HT9LQNQgHHK9RENhvIDrocsXjqX0xW4pYBX5Qo0M+n7p2ym2FtdLQA0GIaUchT5Pt1/U
         DG5nRI+jbANbs7rR0yU4zvLoRw6Y6Q2YD+9d+nFrc9QQHln0vUhwrcUFrBCGQgfnNiyt
         NLlly6BP8ec4hY3z0GvSJZzev4HKAl/apSTXOo++ecs71ZoP+5N8xk0u2FSc8J2Vkv6A
         /+judDv2U+/Cn0STONCMIXAVnvjB2ve1DZSyhQstsbXuMA++SzubNJpDGLZmze/lrwUa
         BbAQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ncOE2spr;
       dkim=pass header.i=@chromium.org header.s=google header.b=HyU3NwY5;
       spf=pass (google.com: domain of kernel-hardening-return-13139-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13139-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=ncOE2spr;
       dkim=pass header.i=@chromium.org header.s=google header.b=HyU3NwY5;
       spf=pass (google.com: domain of kernel-hardening-return-13139-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13139-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <87po2nagrk.fsf@kamboji.qca.qualcomm.com>
References: <20180424235752.GA37317@beast> <87po2nagrk.fsf@kamboji.qca.qualcomm.com>
From: Kees Cook <keescook@chromium.org>
Date: Wed, 25 Apr 2018 07:42:25 -0700
X-Google-Sender-Auth: wrHTAL7FySnNnrlDVNmn1PGTm_A
Message-ID: <CAGXu5jJrd94=RQJHqfdP9wTfhsp61+aCnOmr06bia3mmi79_Mg@mail.gmail.com>
Subject: Re: [PATCH v3] ath9k: dfs: Remove VLA usage
To: Kalle Valo <kvalo@codeaurora.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>, Rosen Penev <rosenp@gmail.com>,
	Eric Dumazet <eric.dumazet@gmail.com>, Joe Perches <joe@perches.com>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598673960782559388?=
X-GMAIL-MSGID: =?utf-8?q?1598729606906591859?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:26 AM, Kalle Valo <kvalo@codeaurora.org> wrote:
> I have already applied an almost identical patch:
>
> ath9k: dfs: remove accidental use of stack VLA
>
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=9c27489a34548913baaaf3b2776e05d4a9389e3e

Ah! Cool, no worries. I didn't see that in linux-next yet. :)

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
