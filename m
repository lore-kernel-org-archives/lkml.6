Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525819503; cv=none;
        d=google.com; s=arc-20160816;
        b=RIvNajJvHmh0YGJ+dl84At616ifrzfjbLmxuPx8uJ/VPoKymUPGmTDxNcEml3rGHCy
         HTisgZELeV3iuvD+e9RZ1CM5Ikq4tckn+lideTlqvofdY37T7iSFvkDnsvLtSY7LNAcw
         D3ijEwJkxOxLPFgX/iRq0Y2LSDQTesLWbGR8gqxonfqatP9VaB3h3xk+njh/kqYdRefI
         nMpN03MfLjjmkVpynuXTxI6Z97l2zkjkOyCh+iuwGTFWhucpduVTrGR+t/Ss7DFTKRE2
         Vt2RxcroJD1Lf/sfmp4cMQbMzj6yPPpYpYpTefRYCAHI7X37AR6gS5bK3uD8cmtmSQth
         llIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=8+PAMaZ2dUHHu2rIqqLS0Hwl+HlnjpfN5UVb6BMCW4E=;
        b=J+Gu9QFvYUOBaTw/jaQzQ/4lqsBifQAxdfHg35LYNXrbZPrPU3Qmfaq4AgUM9VqGnk
         6ziwdrWyA2cZMVjAcb4WpKTys1YzR2Mws5Ltwp4avAXIeRIFkm4B0m+nsWJftXDZyHI6
         IbOLxFpht4C/TtxJLmDhrHXC358iPIW0PO5gNhvPOWzMWfEkHRU8urXg1SH/BGHSYqWa
         9I0arWd/Ma7PMS4GWU4Mj7V8t5ztCiRicjG6EnfvaSqghV9a6DasMn9I8JmVkvgCpDdh
         mIRZfkk9sxKgnuaDpmIBI+kJ4TD5rqpGyw1w8UStSG2DXfx2N/aQKHeHa6kOyt26qH2I
         oRew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qbd47p10;
       dkim=pass header.i=@chromium.org header.s=google header.b=ecg5rmn7;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=qbd47p10;
       dkim=pass header.i=@chromium.org header.s=google header.b=ecg5rmn7;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AB8JxZosZNB9fK8xqUv+aQZl9NRplF+3/5EsLQUtDro5lVAFiSCtUfl+Sa2bRmg4bDR6z/iUMkFUXEImtQHimP4L7bU=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180508181247.19431-1-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 8 May 2018 15:45:02 -0700
X-Google-Sender-Auth: iJNHZvLUFqa-cr_sDF8QYTaN0zM
Message-ID: <CAGXu5jJ=9XKn=z1T16iV-BoN88QLh7q+OicZxc5TvEjioriGMA@mail.gmail.com>
Subject: Re: [PATCH v6 00/13] firmware_loader changes for v4.18
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Josh Triplett <josh@joshtriplett.org>, maco@android.com,
	Andy Gross <andy.gross@linaro.org>, David Brown <david.brown@linaro.org>,
	bjorn.andersson@linaro.org, teg@jklm.no, wagi@monom.org,
	Hans de Goede <hdegoede@redhat.com>, Andres Rodriguez <andresx7@gmail.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>, Jakub Kicinski <kubakici@wp.pl>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, Kalle Valo <kvalo@codeaurora.org>,
	Arend van Spriel <arend.vanspriel@broadcom.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	Nicolas Broeking <nbroeking@me.com>, Vikram Mulukutla <markivx@codeaurora.org>,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, jewalt@lgsinnovations.com, oneukum@suse.com,
	Bitterblue of Monsea <cantabile.desu@gmail.com>, Alexei Starovoitov <ast@fb.com>, hare <hare@suse.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, khc@pm.waw.pl,
	"David S. Miller" <davem@davemloft.net>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	tkjos@android.com, Jonathan Corbet <corbet@lwn.net>, mchehab+samsung@kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, linux-scsi@vger.kernel.org,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920585909697433?=
X-GMAIL-MSGID: =?utf-8?q?1599937711573093485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 8, 2018 at 11:12 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Greg,
>
> Here is what I have queued up for the firmware_loader for v4.18. It
> includes a slew of cleanup work, and the new firmware_request_nowarn()
> which is quiet but enables the sysfs fallback mechanism. I've gone ahead
> and also queued up a few minor fixes for the firmware loader documentation
> which have come up recently. These changes are available on my git tree
> both based on linux-next [0] and Linus' latest tree [1]. Folks working
> on new developments for the firmware loader can use my linux-next
> branch 20180508-firmware_loader_for-v4.18-try2 for now.
>
> 0-day sends its blessings.
>
> The patches from Mimi's series still require a bit more discussion and
> review. The discussion over the EFI firmware fallback mechanism is still
> ongoing.
>
> As for the rename that you wanted, perhaps we can do this late in the
> merge window considering we're at rc4 now. I can prep something up for
> that later.
>
> Question, and specially rants are warmly welcomed.

I sent some typo catches, but with those fixed, please consider the
whole series:

Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
