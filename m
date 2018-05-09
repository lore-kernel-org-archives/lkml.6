Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZpSXpTYFMsYEblvWpC9mMqC1Mect+lwJW/8RoGn45cUaO22yU8WN7+ZJsPmHagdH34UWr8W
ARC-Seal: i=1; a=rsa-sha256; t=1525879421; cv=none;
        d=google.com; s=arc-20160816;
        b=eVNwO2dztprJQfAMCgQTKjEeyJprOEcO6HrbUrZHIf7tfOtK3XPxLX/Yt1w1EIws57
         QowRspNa03UwX2pDjzrtgMfk1J33iDOeuvI2aHeJ73Dq5sE8WlB/EV2WpzFn0jxGUrEa
         hon+97mBWWlYRV9hle2Bs3fkVouc/4MSiq+PXPPPcP7TBonbG6ipvusWV7F7DnlOCK71
         07mxqWvwG6v6zOIsW9ttP9SoZ1ZerEIWgidA/CP02MTv7NB6kEqVsvNzsiqgfYwr9Bx/
         CG6hV3XSsRx31xCKcFYxuRAVakKnYqss5MJyLXyKmp9vPD8e/CMaJJ/f/fZ/e84FA7SB
         2btQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=66w/dgjgbRM/0kxh9hwSgm8Zvk+k6TQDK5aFn6BWoU0=;
        b=zbelHp7zxaUd8M5KFd77L1mxjOShy8rJJG7hrBjNA0JkprnMY6y70M4jWtV94cKofJ
         wa1h07TWGHmtXK7BK4D5BQ+ffkJ8tYRRNzx+UzFfLzHbqVTuw05vx2j/V3PjP/uuvEy3
         sdD9eiBIX/i5WrBpr96HPXeKXKpwdYsW4fx0nr0VgxNdqNHL51osQZ45uj4E3ZxmYgG3
         KolIZ4IxbaVsGUeszjqYJZWpeE3FXhQIzwTKm0yl1vsxKPpmcFmpKBF7jzSiBdCPzp6O
         20oR1WXjUP1xnflUCsMLbTrspKhJEJ8TxZVX6n3DLVpxIsd+UWo1Q3fkYluWucimNM98
         mi0w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Date: Wed, 9 May 2018 10:23:39 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: damian <linux_dti@icloud.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	damian <damian.tometzki@icloud.com>, peterz@infradead.org,
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: Kernel build with gcc 8 a lot of warnings
Message-ID: <20180509152339.mszrivslsrrkkoq6@treble>
References: <20180505192112.GA18728@zrhn9910b>
 <20180507045453.leou4zypnlcck4vr@treble>
 <20180508055126.GA18724@kroah.com>
 <20180508133226.uwjbx44fwlxgyzu5@treble>
 <20180508142515.GA16111@kroah.com>
 <20180508143241.5kz4poxcdhajjorl@treble>
 <20180509034646.7qftdvummkz7b2pi@treble>
 <20180509073503.GA2116@zrhn9910b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180509073503.GA2116@zrhn9910b>
User-Agent: NeoMutt/20180323
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1599903094060891144?=
X-GMAIL-MSGID: =?utf-8?q?1600000540256713890?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 09:35:04AM +0200, damian wrote:
> Hi Josh,
> 
> i tested the patch on my maschine it works fine. 
> 
> Best regards
> Damian

Thanks.  0-day found a few more issues.  The latest patches are at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux objtool-gcc8

Waiting for 0-day to run them again, then I'll be submitting them
shortly after.

-- 
Josh
