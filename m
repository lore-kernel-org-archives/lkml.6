Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524512930; cv=none;
        d=google.com; s=arc-20160816;
        b=Yrly0HF8SrOESzYmRJ6jzSQLiAT0otZdJ0WiiiwnRW+rlLoarwIUTfsd4v0EPE9COp
         MZjZKm88BaQtaqQne/Xwri3kCiTn/BzliuRAf+FV8gwZUAlG2vVkjdjrdF02X7OdRy3H
         P/lRXLf+mguqZjXUU0F1l2XptHbs0CKbu9pv1NpGwXLAWILPxOgpnkz5xi6+dR01/snj
         GQSCUr2UcFYKF0xAWY6f9Z4doLXMEQNlofqqd7o8Rnu0y3SOSDutP2+gyJ1D6IDw/m9b
         sQKxqjaJhvAZC75QRX/c9SsDldNlQ7JdgJ98SQdl5edx6BSaYpsWx3QEkxFQyD49zmCY
         d/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=7RREjfdQRJokRfQhoU5Ub/Xz4MLTfTJwL7wW87WzU9U=;
        b=leau3QtDcXd7+XbP+2dNMqwLrIIeFu+JcDnhXdsBihpgCYMD8ClQuJGmz7HJaG9JP3
         u12Lgxc2TK3eJuR1VR1yjyM7ZH00WZ8E5IWOiOTSmVO/sPk355VoUImxf6ACZ/f/0rVE
         NoosRVrlWmQcUVkX13iz+XrN+kFoqia5LzHOImvg1tBKvhu4tfRHhWSptZReUvT9Vjzl
         A9LZ0ciAH1WZsP7M/hx7SPZWHet1zRkdZqIQdD1lQVt8x3+tsYTwQ4opq4+YQyv4uShg
         lTTj3XWzTFBHu8R4qwCNEXBg6xjFsp+BxtM5mRdLRJdf5KwHPlb06CIsw5BTVfFEdibQ
         Yt9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZTM2u+yi;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZTM2u+yi;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx48sI72lBAg4fi09L204LYKxne30jET570d0Rrbl58fdqujO48O5xRCOAtoMviU9tZwFIGCiQp2CFxp5ju6DYjE=
MIME-Version: 1.0
In-Reply-To: <s5hbmefzfja.wl-tiwai@suse.de>
References: <1523658266-2259-1-git-send-email-ruslan.bilovol@gmail.com>
 <1523658266-2259-2-git-send-email-ruslan.bilovol@gmail.com> <s5hbmefzfja.wl-tiwai@suse.de>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Mon, 23 Apr 2018 22:48:49 +0300
Message-ID: <CAB=otbQK3P5W-GCxncu-J2mCVuQYZuEBmOW=QJOKVF7RNUPGNQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/4] ALSA: usb: stream: refactor audio
 interface parsing
To: Takashi Iwai <tiwai@suse.de>
Cc: Jorge <jorge.sanjuan@codethink.co.uk>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597671506346289659?=
X-GMAIL-MSGID: =?utf-8?q?1598567670508505793?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 12:55 PM, Takashi Iwai <tiwai@suse.de> wrote:
> On Sat, 14 Apr 2018 00:24:23 +0200,
> Ruslan Bilovol wrote:
>>
>> Offload snd_usb_parse_audio_interface() function which
>> became quite long after adding UAC3 spec support.
>>
>> Move class-specific parts to separate functions
>> which now produce audioformat structure that is
>> ready to be fed to snd_usb_add_audio_stream().
>>
>> This also broke Blue Microphones workaround (which
>> relies on audioformat decoded from previous altsetting)
>> into two parts: prepare quirk flag analyzing previous
>> altsetting then use it with current altsetting.
>>
>> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
>
> Could you try to split this patch to two parts: one is a simple
> refactoring to move the code to snd_usb_get_audioformat_uac12(), and
> another to add snd_usb_get_audioformat_uac3().
>
> In this way, we can see a problem more clearly if it's in the
> refactoring part.
>

Sure, will do in in next patchset

Thanks,
Ruslan
