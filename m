Return-Path: <andriy.shevchenko@linux.intel.com>
X-Google-Smtp-Source: AB8JxZqgsyK5D/L+jS1VPSE1q6YdAU4WcnAc2YcgweLz6Bckpij5u3vVTfPx/MsaJl+tHM/sAC0H
ARC-Seal: i=1; a=rsa-sha256; t=1525342894; cv=none;
        d=google.com; s=arc-20160816;
        b=nUAtt+t0+qEqD2LEXcEkQgPcbJV/6YB0yoYdoSgNx0ZkPvFe1nPsV7BJgc4xq9gb2Q
         ++outb+508oSTEjP1WrciC0yCUFjzT44S+GeqvHSzc+3PGTMzjFumrZ0bFID4mdw8Jgx
         aZb4T13TkXjR8S4a973pmdEVsRbtm183CjVK3Ft45tn1yHTA2v2t8E8PYqEi5bGLfuKl
         7OYmLiRnsJ5yjE+DqkTRkBpCRBs4jHBeu54onJqhYkXeGKW5jHhbMit1uk0Vl4uw7m4R
         2S7z73hpbH9kK1WApdkP36PYuQgvs7vj822z/4Ykf9zDYKmNDhFRVyjKciuZtJDWOP0o
         sVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:date:cc:to:from:subject:message-id
         :arc-authentication-results;
        bh=mz5ciXNn4qA6ZNLl2CYMIkPeCU9tJu85b2xS23ANBOk=;
        b=niLRoPOT2LwXTKWIkFGy9f/lWf9tQD+DOwI9hR838OAQ5xt+/R2dekUIZ5jLd3/xge
         tnXXD+wGVhH10ggHaBw2iYb1yXG7K1KoHqGRbucmsFAezoAeaG0hp4kTAgDHEZoy2Zr7
         NAspNWtkH78zgQdSkQjwIXPKXjD4JJcecyMJqJHZ9+Loq6ePdQONiAlPXJZaFaXrDYQ4
         LaN1lT+mfY/Lr8eLnYhA3d2fa9M79Vkd2kl5K5A7inp9v9l/OXwsgqNDlMDmg8zuWw3E
         +o1P04P/3sSwCOYQ2AiQWO7wyJALFErtXmq9mKygrkS0eali7+su6bln86l25H/yh6dO
         2xdg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of andriy.shevchenko@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=andriy.shevchenko@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="38353668"
Message-ID: <1525342889.21176.636.camel@linux.intel.com>
Subject: Re: [PATCH v2 0/3] Few NFC fixes from android-4.14 tree
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>, lkml
 <linux-kernel@vger.kernel.org>,  linux-wireless@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>, Samuel Ortiz
 <sameo@linux.intel.com>,  Christophe Ricard <christophe.ricard@gmail.com>,
 Greg KH <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>,
 Dmitry Shmidt <dimitrysh@google.com>, Todd Kjos <tkjos@google.com>, Android
 Kernel Team <kernel-team@android.com>
Date: Thu, 03 May 2018 13:21:29 +0300
In-Reply-To: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
References: <1525283288-7027-1-git-send-email-amit.pundir@linaro.org>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599375456929773839?=
X-GMAIL-MSGID: =?utf-8?q?1599437950079485805?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-05-02 at 23:18 +0530, Amit Pundir wrote:
> Hi,
> 
> Submitting v2 of NFC fixes I picked up from android-4.14 tree[1]
> for review and comments.
> 
> Again like to point out that I have not feature tested these patches
> at all. Only made small cosmetic changes to the original patches
> (removed Android-only tag and internal bug ID) and build tested for
> arm, before posting them here for review.
> 
> Really appreciate any comments or feedback on how to take it forward.
> 
> Changes since v1:
> * Dropped "NFC: st21nfca: Fix memory OOB and leak issues in
> connectivity
>   events handler" patch for now. I'm yet to verify if the additional
>   aid_len and params_len checks for buffer size are really required,
> and
>   I didn't want to hold up this patch series for one patch alone.
> * Dropped redundant __func__ use dev_dbg() in "NFC: fdp: Fix possible
>   buffer overflow in WCS4000 NFC driver" patch.
> 
> Also drivers/nfc/fdp/ is full of __func__ parameter usage in
> dev_dbg(),
> so submitting a new patch separately to clean that up.
> 

After addressing one comment, FWIW,

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Regards,
> Amit Pundir
> [1] https://android.googlesource.com/kernel/common/+log/android-4.14
> 
> Suren Baghdasaryan (3):
>   NFC: st21nfca: Fix out of bounds kernel access when handling ATR_REQ
>   NFC: Fix possible memory corruption when handling SHDLC I-Frame
>     commands
>   NFC: fdp: Fix possible buffer overflow in WCS4000 NFC driver
> 
>  drivers/nfc/fdp/fdp.c      | 22 +++++++++++-----------
>  drivers/nfc/fdp/i2c.c      | 29 ++++++++++++++++++-----------
>  drivers/nfc/st21nfca/dep.c |  3 ++-
>  net/nfc/hci/core.c         | 10 ++++++++++
>  4 files changed, 41 insertions(+), 23 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
