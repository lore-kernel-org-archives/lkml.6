Return-Path: <ruslan.bilovol@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526331941; cv=none;
        d=google.com; s=arc-20160816;
        b=IHGA9yigiWy/qA+UFr3EHwfZ/Jq4O1yRQpjOrupRYq4kwCeCNQsk6RyuK7DZL8CM1G
         lW6Z8f3s5a+0lZrgztRHyZ/LVXl65qQupvTKSwKMRWr9TJAL3Bpo5H9FA+ZDUVfUmL6E
         iqQJQ9S7YVi48973p8BSc9BeRaKLMuJJQ2PrvoqUfqvZatpe+N1+O+yiFbYi7DJMZHDZ
         qXzxKysU83xTdKXbdf1vh3+G3wq75L2/VjPNKoUuJE4Y6znqu59xQADz3QD0fd36LYl8
         +9j0fzVpe1XuGkjIcuo6RUceUNonePfFlK7uFSrQz6JGXqwa+d+eqFywSuQQ9AJAf7LX
         f+Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=VCEEpn8sv1YMBz27ZuE0ZMbe5o2C7FuWXwzeIqwf/IQ=;
        b=TiKz88lAcQ7TRiSME0GL7+RFSzEdYo0khF4llDWwn7CVOWNeKL92w7m1mGrtUX9FDS
         FN/5qd1IO7168+IYI9mMUXBPhAfky7pvE1UwlpDrxtJcvOI9QU/Jb2uSeUa6N0bgN7wu
         BEmCutDNqpVS0ajUswctsz4tFFhusTsOGzAIlDcbF4OOmmwWbHvjELYfTq9d+35KQEmd
         IYc66V8bjGig7PZBxhuedzTc6D7Kiw0QKVUU+B1ojtow8t5uZchyervQeSo/eKZzPtaM
         994LjhprQaBpScWrr/1d3dczzaSkLZVnoIbpHVd6x4qYwA41UkHMhDouxhZLzikrl+x1
         Nq7Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ChQvefbr;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ChQvefbr;
       spf=pass (google.com: domain of ruslan.bilovol@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ruslan.bilovol@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZoDkLfhrEt4flgELSPLECKc94Ap2D+np46A44qnqCwNN3xCS86lK5URsS/mt31rw4HSYGrNFxWXFkg03tE5dBs=
MIME-Version: 1.0
In-Reply-To: <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
References: <20180511152537.32267-5-jorge.sanjuan@codethink.co.uk> <20180514110342.23683-1-jorge.sanjuan@codethink.co.uk>
From: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Date: Tue, 15 May 2018 00:05:40 +0300
Message-ID: <CAB=otbRxTo1u-WL=WCkhuQe_xTmRcg1AUm4D0D7MTX7Bm1J8Aw@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 4/4] ALSA: usb-audio: UAC3: Parse Input Terminal
 number of channels.
To: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
Cc: Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600181868703215105?=
X-GMAIL-MSGID: =?utf-8?q?1600475042281212921?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 14, 2018 at 2:03 PM, Jorge Sanjuan
<jorge.sanjuan@codethink.co.uk> wrote:
> Obtain the number of channels for the Input Terminal from the
> Logical Cluster Descriptor. This achieves a useful minimal parsing
> of this unit so it can be used in other units in the topology.

Usually 'patch resend' means resend without any changes, and if there
are updates in the patch - it's a new version.

By the way, as I already said in comments to patch 1/4 [1], I verified
this patch successfully.

Reviewed-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
Tested-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2018-May/136044.html

>
> Signed-off-by: Jorge Sanjuan <jorge.sanjuan@codethink.co.uk>
> ---
>  sound/usb/mixer.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> index 431f3c319839..99804cd4aed6 100644
> --- a/sound/usb/mixer.c
> +++ b/sound/usb/mixer.c
> @@ -904,8 +904,12 @@ static int check_input_term(struct mixer_build *state, int id,
>                                 term->id = id;
>                                 term->type = le16_to_cpu(d->wTerminalType);
>
> -                               /* REVISIT: UAC3 IT doesn't have channels/cfg */
> -                               term->channels = 0;
> +                               err = get_cluster_channels_v3(state, le16_to_cpu(d->wClusterDescrID));
> +                               if (err < 0)
> +                                       return err;
> +                               term->channels = err;
> +
> +                               /* REVISIT: UAC3 IT doesn't have channels cfg */
>                                 term->chconfig = 0;
>
>                                 term->name = le16_to_cpu(d->wTerminalDescrStr);
> --
> 2.11.0
>
