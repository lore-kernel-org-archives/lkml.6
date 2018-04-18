Return-Path: <aspriel@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524078684; cv=none;
        d=google.com; s=arc-20160816;
        b=uzUDZERyZ3ZTb/8lJCVJ8aOFkWe8zWMnMvQNL4W6hFjQGTz8pcUhw6jqVLblV9Mzuw
         IsaMSTMR+NUHe2P8iTJmn6Zg43eFSJcfTs74oj4J8xv/KceEvFMQ0nl2mmTCmX5JZTVm
         WiP9tOIDkoWnMUK64DvD6nWCf+jnNv4GpoHj8RJpx7sNmSKTw+0QOEit7wLJqiZIxbjp
         gODUACj60KkjpwshWPLpXYFJ6HrFLHj/OyPoXDkom18TJCfhK+aOSAzvygAdqcO5wWH1
         ml/zXRymuwks8FXXFOKhEYB6zlURhksuGDcjh55EfGyND1dBkzDC/14xp8eJdULuWGJp
         XuSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=CI3TA2UDlO9R/zc315lCko3uOKxngNACZ9Xdc5cmEKA=;
        b=i2NGnq34tbYE9p6JOKyZ+w704sS7DN8OWBYVrYfSzKTRtO/LPpHeB0H/xAZB17LKqM
         4XSCsk7cUvv0EmUQWtw1jL5aXsmg4TsjIyxYmbm970fOMAyHdQcQcNKaixtu0xSkuAk0
         6BYhSBz5i0wpbbQ+zqYkTeoifVX+ihyTvSrf3eVztj7ZMTDo5y2BSZRX3/8ZM98VTYMu
         NdwU43n8G4lUMqbB5n0Y9326ttyfXBh9Z8mRuDlZNKSWaPPqHmGwfsNJv8fYVrDvn12s
         UEtB970Ktdna64xic+PVvABB4m/QNXlxKBKW5OaIQe+yU3rV34GYUqs4HBUzOOy5Fi2m
         nTgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gs9Y1Ua9;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Gs9Y1Ua9;
       spf=pass (google.com: domain of aspriel@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aspriel@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx49hxGQO8+M3jsxe2F63Lq5DcuUU6gGYtYs7u9PwJIYddxRqoJH4VPib/gyflDbYlfRiW5qfcf89y3eYUBf7FSQ=
MIME-Version: 1.0
In-Reply-To: <1523224627-24136-1-git-send-email-aspriel@gmail.com>
References: <1523224627-24136-1-git-send-email-aspriel@gmail.com>
From: Arend van Spriel <aspriel@gmail.com>
Date: Wed, 18 Apr 2018 21:11:23 +0200
Message-ID: <CAJ65rDwOCGZL+=jJj-4-HjPVpR8EhZSS5x5ACS_3aC3gwpUxmA@mail.gmail.com>
Subject: Re: [RESEND PATCH] drivers: change struct device_driver::coredump()
 return type to void
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Brian Norris <briannorris@chromium.org>,
	Arend van Spriel <aspriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597216821863949278?=
X-GMAIL-MSGID: =?utf-8?q?1598112331171343526?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 8, 2018 at 11:57 PM, Arend van Spriel <aspriel@gmail.com> wrote:
> Upon submitting a patch for mwifiex [1] it was discussed whether this
> callback function could fail. To keep things simple there is no need
> for the error code so the driver can do the task synchronous or not
> without worries. Currently the device driver core already ignores the
> return value so changing it to void.
>
> [1] https://patchwork.kernel.org/patch/10231933/
>
> Signed-off-by: Arend van Spriel <aspriel@gmail.com>
> ---
> Hi Greg,
>
> Here is a resend of my patch that got lost. See if it makes it
> this time ;-)

Hi Greg,

Your patch-bot replied to this one and I may be overly anxious, but
that's because things ran haywire in the initial submission. So is the
patch in your queue for 4.17?

Regards,
Arend

> Regards,
> Arend
> ---
>  include/linux/device.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
