Return-Path: <keescook@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519774195; cv=none;
        d=google.com; s=arc-20160816;
        b=UH6mwCxN1TTHWhFWSKxq+9pgeqzfmi5dHCOixs0uoYSX04205zIoZw9HpL4ZpJNNHe
         HKZ+DuuZwDSt7ApX9jO6FiFb67rPINOjWp0lz8xXJwBF1rmVD7QMoRWVRUvgZwMfqBYZ
         Q7BDEMsIC8Yd+Y2pnnpGv3iYbkoFENrl/pmBa7h+ewHVPw8tReNoz+lmin0BoegsAKhQ
         VGrXI+2rFxZNIPW5QHgUsCi9JLqwg4OAfOAPsgLjfeq3qu5C+swuw0H3LRBtdlHCWVDX
         RwYqa9q8LSngz2uXig4+CNpZnBfWBabHE33/4r1OTB+1P/kdTdpNSprtf09ni5hOjwT+
         EY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=qEP7LP0Usn7ayjxZFC19eFgopDLcRrST7qg1OZRb7yw=;
        b=MLd2ljNCzuCLTmBzIMIG4kGrEIsedohg1UR6IKVDpOcJxzKcjfkmSCRRe//wJuvYV4
         h9Ac8DWeVUORfba3tFA52x+9Z5MESC/mCcq4pcWEgxe403jELhuLGulfnS/y/Zp1o2h3
         f9JgJN7hu7oyJTYIkWUfyZrAnr2npqFtzmY++JUQLgfwYPslIVrf2D86NfoOrb7dUwh6
         bJfkuh4WNAWGhm25xVv9ZL1ERkBCux8vTvjCkftTiHcq3TlW9JgD5TQvtl/vdRrj0abn
         1H+dS3JNKIvQLtlNEqy61fi2M5DBfBI7WjVDz8oJL+a+8nQbCCcbVWJ4+NOPnJhA8LDK
         effw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y890X1zd;
       dkim=pass header.i=@chromium.org header.s=google header.b=mfteAS/f;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=Y890X1zd;
       dkim=pass header.i=@chromium.org header.s=google header.b=mfteAS/f;
       spf=pass (google.com: domain of keescook@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=keescook@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AG47ELsOHJZ0Bn6n8iTk2Z/S5/BE74s1/fluKwaoScHz0tXANw8uYBB2umJ/OpeMrN3lI07xFMODz2eMCEIQQbVNeqk=
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <20180227232101.20786-3-mcgrof@kernel.org>
References: <20180227232101.20786-1-mcgrof@kernel.org> <20180227232101.20786-3-mcgrof@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Tue, 27 Feb 2018 15:29:53 -0800
X-Google-Sender-Auth: h1Hl-_nfRvLFEBBDHmOellIpfnE
Message-ID: <CAGXu5jLxAPyBfzvM3izKYYjVz6P=7LQRkxNxUz1Cxwky1gPoUA@mail.gmail.com>
Subject: Re: [RFT 2/7] firmware: fix checking for return values for fw_add_devm_name()
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: cantabile.desu@gmail.com, Jakub Kicinski <kubakici@wp.pl>,
	Greg KH <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Martin Fuzzey <mfuzzey@parkeon.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com, Takashi Iwai <tiwai@suse.de>,
	arend.vanspriel@broadcom.com, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>, stephen.boyd@linaro.org,
	Mark Brown <broonie@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598195211276133?=
X-GMAIL-MSGID: =?utf-8?q?1593598746806918427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> fw_add_devm_name() adds device's name onto the devres for the
> device so that prior to suspend we cache the firmware onto memory,
> so that on resume the firmware is reliably available. We never
> were checking for success for this call though, meaning in some
> really rare cases we my have never setup the firmware cache for
> a device, which could in turn make resume fail.
>
> This is all theoretical, no known issues have been reported.
> This small issue has been present way since the addition of the
> devres firmware cache names on v3.7.
>
> Fixes: f531f05ae9437 ("firmware loader: store firmware name into devres list")
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/firmware_loader.c b/drivers/base/firmware_loader.c
> index 21dd31ef08ae..48932581c70c 100644
> --- a/drivers/base/firmware_loader.c
> +++ b/drivers/base/firmware_loader.c
> @@ -431,6 +431,7 @@ int assign_fw(struct firmware *fw, struct device *device,
>               unsigned int opt_flags)
>  {
>         struct fw_priv *fw_priv = fw->priv;
> +       int ret;
>
>         mutex_lock(&fw_lock);
>         if (!fw_priv->size || fw_state_is_aborted(fw_priv)) {
> @@ -447,8 +448,13 @@ int assign_fw(struct firmware *fw, struct device *device,
>          */
>         /* don't cache firmware handled without uevent */
>         if (device && (opt_flags & FW_OPT_UEVENT) &&
> -           !(opt_flags & FW_OPT_NOCACHE))
> -               fw_add_devm_name(device, fw_priv->fw_name);
> +           !(opt_flags & FW_OPT_NOCACHE)) {
> +               ret = fw_add_devm_name(device, fw_priv->fw_name);
> +               if (ret && ret != 1) {

Why not if (ret < 0) ?

-Kees

> +                       mutex_unlock(&fw_lock);
> +                       return ret;
> +               }
> +       }
>
>         /*
>          * After caching firmware image is started, let it piggyback
> --
> 2.16.2
>



-- 
Kees Cook
Pixel Security
