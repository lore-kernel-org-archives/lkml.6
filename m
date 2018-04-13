Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AIpwx4+ZIkeMGxZ0/1Omlgh3799KDanbFFiYKHedJV+KONvCV2i4SndC4sGPJosTCdwPpm1kVC0v
ARC-Seal: i=1; a=rsa-sha256; t=1523636591; cv=none;
        d=google.com; s=arc-20160816;
        b=IM5/pQuazoxhtMsbi3P/9PTGtIPNupO2QZb6sJuUwSAcYk76XJpxElrLt4sG631ppe
         D4uVOUXv/4UZFYZIiUCzauOohn8Twwv5gTenc2NFDvBt28N/lrYqF8RVjIORsxTo46xp
         GjQ0ySwFDiOPzcO5QiYkW7LAufqF4bIqhsDSep8ag7Pmx5dRdQwNPcMHC16UY4F4axni
         VQ8ddbHcL3ObwlYcNjC29ayFu0RMINdDVwBL9myVIkf+zRe5wmTF62z4ljcKKWTtn2Lu
         R9Yf+/MFSWMnctoyPJk04CcXg/HLNeBe2WKeEKJhPWtn5ftxQjze5piK8z4obre0fAmy
         uM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=AuXDQZsL0zPUzIBvjexLy678q1bM8KkIuDJGMsyeJiQ=;
        b=UROpZVs0N7jg6TrOUEsM8SP0eV9v35ze6xwByxXJK/1TUeI/bkQAQT5cnGyPOKpRCj
         hI3uw8hZj6yUouFQWKXTkU6oVV8FeW4eAvdBtHKtABiAFm+2sUtysM0yDx/DvDGyuZAn
         IroNdZAejiuqHSuN28AclkGfeVixSc/94jQLsBXi1mqU/B7ualJmj3zJZ4Iroet1A8n0
         Z5CxNBuQSZCeppHGPnVKMnfJmbIr05j/t50LWr3g8VWv3vHfpCcGqwETo/KNdjO82X54
         iZmfyJ1SwuWWLHTYkp/po4d1Bj+5c6b3InYV2tiNybsdqUm0T9cgiZurguyVqHsriRI2
         fzxw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=dIU6c99W;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=dIU6c99W;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Fri, 13 Apr 2018 09:23:07 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com, ivecera@redhat.com
Subject: Re: [PATCH v1 1/7] platform_data/mlxreg: Document fixes for hotplug
 device
Message-ID: <20180413162307.GC27560@fury>
References: <1522144927-56512-1-git-send-email-vadimp@mellanox.com>
 <1522144927-56512-2-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522144927-56512-2-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596077325157567666?=
X-GMAIL-MSGID: =?utf-8?q?1597648761993734209?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 10:02:01AM +0000, Vadim Pasternak wrote:
> Remove redunadant description of label in struct mlxreg_hotplug_device.

         ^ redundant

Please configure a spell checker in your text editor. I take care of
these for first time contributors, but as you become a regular
contributor, I shouldn't need to rewrite your commit messages.

I'll handle this one, but please adapt your tooling for future patches.

> 
> Change location of access_mode in struct mlxreg_hotplug_device.
> 
> Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
> ---
>  include/linux/platform_data/mlxreg.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/include/linux/platform_data/mlxreg.h b/include/linux/platform_data/mlxreg.h
> index 2744cff..19f5cb61 100644
> --- a/include/linux/platform_data/mlxreg.h
> +++ b/include/linux/platform_data/mlxreg.h
> @@ -58,11 +58,10 @@ struct mlxreg_hotplug_device {
>   * struct mlxreg_core_data - attributes control data:
>   *
>   * @label: attribute label;
> - * @label: attribute register offset;
>   * @reg: attribute register;
>   * @mask: attribute access mask;
> - * @mode: access mode;
>   * @bit: attribute effective bit;
> + * @mode: access mode;
>   * @np - pointer to node platform associated with attribute;
>   * @hpdev - hotplug device data;
>   * @health_cntr: dynamic device health indication counter;
> -- 
> 2.1.4
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
