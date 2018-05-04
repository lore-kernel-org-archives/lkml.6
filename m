Return-Path: <James.Bottomley@hansenpartnership.com>
X-Google-Smtp-Source: AB8JxZqRDdpWA3Drwm1V0zeas/0v2s6YVCFCD9RZt7LeZjpY9HcAQjUupUMAWwIQWY/Kkt1o03I8
ARC-Seal: i=1; a=rsa-sha256; t=1525469885; cv=none;
        d=google.com; s=arc-20160816;
        b=OdT5lJvdoL4eUO4mBRONf4pxbuwfNQcXeAE/pO+OXac8bOrViD2FU+7z5yhRYZZtft
         PX2BPUGvl+xOyR3NJMd6F6vn+GRGf7059VuX+mVIf7mZN6Evmh/R39JoiGFz+fiDmvmn
         xaHaWwmKB8I2p3KyEWd9CZ8Hh+RvexqyjPkHvG82jqcGzEtK5/mWLJQe1OKJ2eNsWJF1
         9HLdCSHk9NMJhkwxraLpJgU0Xpnwbe8/L8fxuoHrT9VnxX9vu8KlzgA/kesifkdbjbvP
         G7PmB4K8n7Osi+RSclpfNk3TPRkgCPttf1gKq1CFiRF98k+iwZfqwppTFMtp6EqRKjLZ
         PE1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:dkim-signature
         :arc-authentication-results;
        bh=fYX7SYmSgWTi/DR5YedSr31yNQbbT6rE6odT5ZxPclc=;
        b=dQfLFCYx14DnGYiOewkFiqNhDOqXCjxtCgB5tkTGkveav/yK9qj62PC1BO0qxCczD1
         7L9GafrgBW3TPZFU0A1ZVVhzUQxXnyNvYexgCrjrxjqXUr4XZJSZnkGiA0I01e7qxiyG
         oboAn6n7kENu7sFxGPAp89gQQFseER4Yp1jg1lw8H9n3cIYL71OTPLS4oxr3K/3C/Dhr
         XVdkakFK6JWDqPd1YckjftHme5WVgHbBXCY4cZ73Lp+KRp15K6cCeeT8sA6qixeDjXb/
         ooGOPXXkyBx4a45Kc8De4f5vR4ZrrcZtVN9g+dSQkR7UeSi0E6v7zytZT6GOfsdD3bhB
         97sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=fail header.i=@hansenpartnership.com header.s=20151216 header.b=Rrm1yzJl;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Authentication-Results: mx.google.com;
       dkim=fail header.i=@hansenpartnership.com header.s=20151216 header.b=Rrm1yzJl;
       spf=pass (google.com: domain of james.bottomley@hansenpartnership.com designates 66.63.167.143 as permitted sender) smtp.mailfrom=James.Bottomley@hansenpartnership.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=hansenpartnership.com
Message-ID: <1525469881.4114.5.camel@HansenPartnership.com>
Subject: Re: [Ksummit-discuss] bug-introducing patches
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Greg KH <gregkh@linuxfoundation.org>
Cc: "ksummit-discuss@lists.linuxfoundation.org"
 <ksummit-discuss@lists.linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "w@1wt.eu" <w@1wt.eu>
Date: Fri, 04 May 2018 14:38:01 -0700
In-Reply-To: <20180504211317.GK29205@thunk.org>
References: <CAMuHMdW_i-KQpqMz0zsz77tRcE-Sron5zAyh0SHAOJ5ap7x60w@mail.gmail.com>
	 <20180503000620.GA29205@thunk.org> <20180503144612.GJ18390@sasha-vm>
	 <20180503165446.GB30522@ZenIV.linux.org.uk>
	 <20180503173422.GR18390@sasha-vm>
	 <20180503182039.GC30522@ZenIV.linux.org.uk>
	 <8669.1525427874@warthog.procyon.org.uk> <87fu377gbu.fsf@intel.com>
	 <20180504130932.GI29205@thunk.org> <20180504174055.GF4649@kroah.com>
	 <20180504211317.GK29205@thunk.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599280464106480109?=
X-GMAIL-MSGID: =?utf-8?q?1599571110134473626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-04 at 17:13 -0400, Theodore Y. Ts'o wrote:
> If it's not necessary, fine.  But we should still delete what is
> currently documented in stable_kernel_rules and was introduced in
> 8e9b9362266d, because it doesn't describe current practice.

It definitely doesn't seem to describe current practice.  It looks like
it got applied because the commit description bears a somewhat strange
relation to the actual text that was added:  The commit talks about the
 original script that used to forward to stable (although it got me and
hpa confused) which seems to refer to a tiny deletion and the rest is
adding an Ingo one off proposal for dependencies.

For the record: Greg runs his own script now and I'm not involved.

Current process (at least from the SCSI centric view) is that if we
screw up and forward a commit with missing dependencies to stable via a
cc: tag, it won't apply and Greg tells us to fix it, which we do.  That
seems to be an adequately functional process for the odd times we run
into this.

James
