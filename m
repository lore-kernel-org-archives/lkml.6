Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AB8JxZrukAtw9c7z6BZQ8+1d+EcnZ6gsxhAVJy138xnFMIpE7ZeTHwWUrGjIoREfJjlz29gqT/Mo
ARC-Seal: i=1; a=rsa-sha256; t=1525392008; cv=none;
        d=google.com; s=arc-20160816;
        b=Gy6Irxuyn1dVc6YEW1nn2CrRRTscSiTBnu0feN2tES+uXOyqpfFpYQ57s4vzIgbnxM
         WGmpXuCWCoikK9tTDiHtiGcQqFViZ+fbGR0lYtrLAm8zxxPfRozDKlAiJJJJ3pGLlquj
         QgeVI7xXdML5elan2qPiHf743BJsoZ+toKVdi+kj14wGyOn8TQ7pB/p+Y+YkBIjZ77hz
         JQLiJcCjHwHeFZj5ETByoSFVVUa2U1emUUOIWEPqmAYARGET3fxXHBQdWiU4tSozmrGH
         +CQ7QICtuih//NmIuWdd3mQcXY1qYLveBsPZ7Gr5sLRj1uWnNZo622S20EMVnyf8/S7f
         Rq8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ZZsgFgkGY+cxPHNDHzSv5gyPVlgr3MuX/31wW1c30I0=;
        b=QoBZW90rpAKY90HdF4Sxy9QcRfcfJV7gShsTmu+RPCV10CUPTanqw3lOkBOUGViHxx
         8GJYccGvbnfO83oxGQS5RfcMk4DhCN0s8QZJcFu5G07PY29Gl0aZlxxnbOBEeHXfNsLh
         7c1TPvWOB0574jnipv759bOlxL3txe/TY531LBLJtaDNh6t4hNd7VPxULw3d9aLDRrKl
         8dJB97IzDPM46ed1Er4jeqsEQruFUcwspb2WsWpj0xv3tw14AGsNZ4XO0V95Lilx0HC0
         lxoXHQfz485vqznQ2Bj6jIiKqQ7WZQodh7wEAwFeBOpgK/m7cNgu4SiJGx5DPq4Lb6uu
         6eAg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Fri, 4 May 2018 00:00:06 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com, christian.koenig@amd.com,
	kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
	linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
	hdegoede@redhat.com, Kees Cook <keescook@chromium.org>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/9] firmware: add function to load firmware without
 warnings v5
Message-ID: <20180504000006.GO27853@wotan.suse.de>
References: <20180423201205.20533-1-andresx7@gmail.com>
 <20180423201205.20533-6-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423201205.20533-6-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598569150296096540?=
X-GMAIL-MSGID: =?utf-8?q?1599489450342386122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:12:01PM -0400, Andres Rodriguez wrote:
> diff --git a/include/linux/firmware.h b/include/linux/firmware.h
> index db8351a42405..a34e16f77f20 100644
> --- a/include/linux/firmware.h
> +++ b/include/linux/firmware.h
> @@ -42,6 +42,8 @@ struct builtin_fw {
>  #if defined(CONFIG_FW_LOADER) || (defined(CONFIG_FW_LOADER_MODULE) && defined(MODULE))
>  int firmware_request(const struct firmware **fw, const char *name,
>  		     struct device *device);
> +int firmware_request_nowarn(const struct firmware **fw, const char *name,
> +			    struct device *device);
>  int firmware_request_nowait(
>  	struct module *module, bool uevent,
>  	const char *name, struct device *device, gfp_t gfp, void *context,

You also missed the firmware_request_nowarn() call on the #else. I'll add it
and re-submit myself.

In future patches about firmware please also Cc Mimi Zohar <zohar@linux.vnet.ibm.com>,
and Kees Cook <keescook@chromium.org>. You can also use the long list (modulo, not
the EFI list) that Hans used on his EFI patches. I realize its long but its just
to ensure enough folks get to review and eybeball the code.

  Luis
