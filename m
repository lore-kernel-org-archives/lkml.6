Return-Path: <mhocko@kernel.org>
X-Google-Smtp-Source: AH8x226Ve5BoKPaM6F4P4mCLN0nvSKpsk2EuHG9y43sHSycv+X+cf8VQSpbdbn18pj2AwBDKMgjX
ARC-Seal: i=1; a=rsa-sha256; t=1519208188; cv=none;
        d=google.com; s=arc-20160816;
        b=DIt5u3Z1W4a7RlQkzvrw7q1DVpKp6n2PgdwMouM8ZnPDNtDgNZDc4usJvT3Re9ZVaa
         I1h9lx+ywvRXelB8XkFz7cbczeWtM6zx8w5A7iDdMO8EJqlJvKPfEoAeDQT1lB3avuF3
         5cxggrJ5CTac67W4mxvaUooE1G/SUIn24OmWnUODiwDlUqOlhHudw8j2q6bvbEOpX/WP
         uPQ3kCkogD6IPWc0whk56cPjPaxRlBNyILI2JTKBURQGsWcgxOcFC57h06Vb6oVYppdz
         KnVKtRWjT/kcqo4F79SSsQBfsTHHFfFUv3CqfXPvt9Dlu3kmsOWaGwEeDYKHfnou1/Y1
         13+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=CA61Oz7mb4FO6GVP5AjnfObvDMERsDaNEjGggWvF0AM=;
        b=d7pLVNLf9Gr4OxCWLkrCr+4EAUBNXGGTnruSbxyDhmhnT8joJfBH7LUuVJs9bjeF3Y
         nFtdz2f3jU10qrBmVZ0Ad6xOG1u45bOPU1kRNukuAD5K4EgpShIFnp0/HpUm1UNiHaOt
         71troxS13wWSWZmivZNI8jB0EyeibLgTLD+qyfRuxjkkqsNOe1gI1i7wYnAhWbemofQt
         Ol+M0GmdAVjCC4OI0Y65u1ddAz1C6Wt6cYWJSGcXthATdIuBgxWIhnTihBPgYOH9mql4
         ShtgtsPsexkB8lQwgig0U9/ikC7QorufTJL/F7ItseKusEPwvXY7Bx2zu3Cr5ohC6wLe
         4Ftg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of mhocko@kernel.org) smtp.mailfrom=mhocko@kernel.org
Date: Wed, 21 Feb 2018 11:16:26 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_poison: Make early_page_poison_param __init
Message-ID: <20180221101626.GA14384@dhcp22.suse.cz>
References: <20180117034757.27024-1-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117034757.27024-1-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589809968797570691?=
X-GMAIL-MSGID: =?utf-8?q?1593005245904636253?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed 17-01-18 11:47:57, Dou Liyang wrote:
> The early_param() is only called during kernel initialization, So Linux
> marks the function of it with __init macro to save memory.
> 
> But it forgot to mark the early_page_poison_param(). So, Make it __init
> as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/page_poison.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_poison.c b/mm/page_poison.c
> index e83fd44867de..aa2b3d34e8ea 100644
> --- a/mm/page_poison.c
> +++ b/mm/page_poison.c
> @@ -9,7 +9,7 @@
>  
>  static bool want_page_poisoning __read_mostly;
>  
> -static int early_page_poison_param(char *buf)
> +static int __init early_page_poison_param(char *buf)
>  {
>  	if (!buf)
>  		return -EINVAL;
> -- 
> 2.14.3
> 
> 
> 

-- 
Michal Hocko
SUSE Labs
